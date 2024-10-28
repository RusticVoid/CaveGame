require "utils"
require "world"
require "player"
require "textures"
require "tile"

function GameInit()
    print("Welcome to a Homeless Studio Game")
    print("How big would you like the world (leave blank for MEDIUM default):")
    print("1: SMALL (250x250)")
    print("2: MEDIUM (500x500)")
    print("3: LARGE (1000x1000) NOT RECOMENDED!")
    mapSize = io.read()
    worldSize = 500
    if mapSize == "1" then
        worldSize = 250
    end
    if mapSize == "2" then
        worldSize = 500
    end
    if mapSize == "3" then
        worldSize = 900
    end

    print("How many caves (Leave blank for 100):")
    caveCount = io.read()
    if (caveCount == nil) or (caveCount == "") then
        caveCount = 100
    else
        caveCount = tonumber(caveCount)
    end

    print("How many cave iterations (Leave blank for 1000):")
    caveIterations = io.read()
    if (caveIterations == nil) or (caveIterations == "")then
        caveIterations = 1000
    else
        caveIterations = tonumber(caveIterations)
    end

    print("How munch ore (Leave blank for 150):")
    oreAmount = io.read()
    if (oreAmount == nil) or (oreAmount == "") then
        oreAmount = 150
    else
        oreAmount = tonumber(oreAmount)
    end

    print("How many biome areas (Leave blank for 4):")
    bimomeAmount = io.read()
    if (bimomeAmount == nil) or (bimomeAmount == "") then
        bimomeAmount = 4
    else
        bimomeAmount = tonumber(bimomeAmount)
    end

    print("World seed (Leave blank for random):")
    WorldSeed = io.read()
    if (WorldSeed == nil) or (WorldSeed == "") then
        WorldSeed = os.clock()
    else
        WorldSeed = tonumber(WorldSeed)
    end

    math.randomseed(WorldSeed)
    print("Seed: "..WorldSeed)
    tileSize = 50

    ScreenWidth, ScreenHeight = love.window.getMode()

    debug = false

    world = World.new(worldSize, worldSize, tileSize)

    love.graphics.print("Generating World...", 0, 0)

    world:GenWorld()
    world:GenCave(caveCount, caveIterations, 10)
    world:GenOre(oreAmount)
    world:GenBiome(bimomeAmount)

    player = Player.new(ScreenWidth/2, ScreenHeight/2, tileSize-20, 2)
    up = false
    down = false
    left = false
    right = false

    spawingPlayer = true
    while spawingPlayer do
        spwan = math.random(1, 2)
        spwanX = math.random(1, world.worldWidth)
        spwanY = math.random(1, world.worldHeight)
        if ((spwan == 1) and (world.worldData[spwanY][spwanX] == FloorTile)) then
            world.worldShowData[spwanY][spwanX] = 2
            world.worldX = -(spwanX*tileSize)+((ScreenWidth/2))
            world.worldY = -(spwanY*tileSize)+((ScreenHeight/2))
            spawingPlayer = false
        end
    end

    fps = 0
    gameRunning = true
    fiction = 4
end

function love.load()
    InitTextures()

    FloorTile = Tile.new(tileSize, floorTexture, "floor", false)
    wallTile = Tile.new(tileSize, wallTexture, "wall", true)

    redniteTile = Tile.new(tileSize, redniteTexture, "ore", true)
    blueniteTile = Tile.new(tileSize, blueniteTexture, "ore", true)

    ores = {redniteTile, blueniteTile}

    greenGroundTile = Tile.new(tileSize, greenGroundTexture, "floor", false)

    redGroundTile = Tile.new(tileSize, redGroundTexture, "floor", false)
    redWallTile = Tile.new(tileSize, redWallTexture, "floor", false)

    boarderTile = Tile.new(tileSize, wallTexture, "wall", false)

    gameRunning = false
    initLoopDone = false
end

function love.update(dt)
    DeltaTime = dt

    if gameRunning == true then

        fps = love.timer.getFPS( )

        world.prevworldX = world.worldX
        world.prevworldY = world.worldY

        w = love.keyboard.isDown("w")
        s = love.keyboard.isDown("s")
        a = love.keyboard.isDown("a")
        d = love.keyboard.isDown("d")
        shift = love.keyboard.isDown("lshift")

        if debug == true then
            if shift == true then
                player.playerVelMax = 100 * 100
            else
                player.playerVelMax = player.playerSpeed * 100
            end
        end

        if w == true then
            player.playerYVel = player.playerYVel + player.playerSpeed * fiction
            if player.playerYVel > player.playerVelMax then
                player.playerYVel = player.playerVelMax
            end
        else
            if player.playerYVel > 0 then
                player.playerYVel = player.playerYVel - player.playerSpeed * fiction
            end
        end
        if s == true then
            player.playerYVel = player.playerYVel - player.playerSpeed * fiction
            if player.playerYVel < -player.playerVelMax then
                player.playerYVel = -player.playerVelMax
            end
        else
            if player.playerYVel < 0 then
                player.playerYVel = player.playerYVel + player.playerSpeed * fiction
            end
        end
        if a == true then
            player.playerXVel = player.playerXVel - player.playerSpeed * fiction
            if player.playerXVel < -player.playerVelMax then
                player.playerXVel = -player.playerVelMax
            end
        else
            if player.playerXVel < 0 then
                player.playerXVel = player.playerXVel + player.playerSpeed * fiction
            end
        end
        if d == true then
            player.playerXVel = player.playerXVel + player.playerSpeed * fiction
            if player.playerXVel > player.playerVelMax then
                player.playerXVel = player.playerVelMax
            end
        else
            if player.playerXVel > 0 then
                player.playerXVel = player.playerXVel - player.playerSpeed * fiction
            end
        end

        world.worldX = world.worldX - player.playerXVel * DeltaTime
        world.worldY = world.worldY + player.playerYVel * DeltaTime

        MouseX = love.mouse.getX()
        MouseY = love.mouse.getY()
        for y = 0, world.worldHeight do
            for x = 0, world.worldWidth do
                if (world.worldX+(x*world.tileSize) > 0-tileSize)
                and (world.worldX+(x*world.tileSize) < ScreenWidth)
                and (world.worldY+(y*world.tileSize) > 0-tileSize)
                and (world.worldY+(y*world.tileSize) < ScreenHeight) then
                    if ((MouseX) < (world.worldX+((x*tileSize)+tileSize)))
                    and ((MouseX) > (world.worldX+(x*tileSize)))
                    and ((MouseY) < (world.worldY+((y*tileSize)+tileSize)))
                    and ((MouseY) > (world.worldY+(y*tileSize))) then
                    end
                end
            end
        end

        world:UpdateWorld()
    end
end

function love.keypressed(key)
    if gameRunning == true then
        if (key == "p") then
            debug = not debug
        end
        if debug == true then
            if (key == "l") then
                tileSize = 1
                world.tileSize = tileSize
            end
            if (key == "k") then
                tileSize = 50
                world.tileSize = tileSize
            end
            if (key == "j") then
                world.worldX = 0
                world.worldY = 0
            end
            if (key == "r") then
                InitTextures()
            end
        end
    end
end

function love.draw()
    if gameRunning == true then
        world:DrawWorld()
        player:draw()
        if debug == true then
            love.graphics.print(fps)
            love.graphics.print("DbugeMode:"..tostring(debug), 0, 15)
            love.graphics.print("Player X:"..-math.floor((world.worldX/tileSize)-(player.playerX/tileSize)), 0, 30)
            love.graphics.print("Player Y:"..-math.floor((world.worldY/tileSize)-(player.playerY/tileSize)), 0, 45)
        end
    else
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("Generating World!", 0, 0)
        love.graphics.print("If this takes a while check the console if its enabled", 0, 15)
        if initLoopDone == true then
            GameInit();
        end
        initLoopDone = true
    end
end
