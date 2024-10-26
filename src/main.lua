require "utils"
require "world"
require "player"

function GameInit()
    print("Welcome to a Homeless Studio Game")
    print("How big would you like the world (leave blank for MEDIUM default):")
    print("1: SMALL (250x250)")
    print("2: MEDIUM (500x500)")
    print("3: LARGE (1000x1000) NOT RECOMENDED!")
    mapSize = io.read()
    print("How many caves (Leave blank for 100):")
    caveCount = io.read()
    print("How many cave iterations (Leave blank for 1000):")
    caveIterations = io.read()
    print("How munch ore (Leave blank for 150):")
    oreAmount = io.read()
    print("World seed (Leave blank for random):")
    WorldSeed = io.read()

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
    
    if caveCount == "" then
        caveCount = 100
    end

    if caveIterations == "" then
        caveIterations = 1000
    end

    if oreAmount == "" then
        oreAmount = 150
    end
    
    WorldSeed = os.clock()
    if not (WorldSeed == "") then
        WorldSeed = tonumber(WorldSeed)
    end

    math.randomseed(WorldSeed)
    print("Seed: "..WorldSeed)
    tileSize = 20

    ScreenWidth, ScreenHeight = love.window.getMode()

    debug = false

    world = World.new(worldSize, worldSize, tileSize)

    love.graphics.print("Generating World...", 0, 0)

    world:GenWorld()
    world:GenCave(tonumber(caveCount), caveIterations, 10)
    world:GenOre(oreAmount)

    player = Player.new(ScreenWidth/2, ScreenHeight/2, tileSize-5, 5)
    up = false
    down = false
    left = false
    right = false

    spawingPlayer = true
    while spawingPlayer do
        spwan = math.random(1, 2)
        spwanX = math.random(1, world.worldWidth)
        spwanY = math.random(1, world.worldHeight)
        if ((spwan == 1) and (world.worldData[spwanY][spwanX] == 0)) then
            world.worldData[spwanY][spwanX] = 2
            world.worldX = -(spwanX*tileSize)+((ScreenWidth/2))
            world.worldY = -(spwanY*tileSize)+((ScreenHeight/2))
            spawingPlayer = false
        end
    end

    fps = 0
    gameRunning = true
end

function love.load()
    gameRunning = false
    initLoopDone = false
end

function love.update(dt)
    if gameRunning == true then
        fps = love.timer.getFPS( )

        world.prevworldX = world.worldX
        world.prevworldY = world.worldY

        if love.keyboard.isDown("w") then
            world.worldY = world.worldY + player.playerSpeed
        end
        if love.keyboard.isDown("s") then
            world.worldY = world.worldY - player.playerSpeed
        end
        if love.keyboard.isDown("a") then
            world.worldX = world.worldX + player.playerSpeed
        end
        if love.keyboard.isDown("d") then
            world.worldX = world.worldX - player.playerSpeed
        end

        for y = 0, world.worldHeight do
            for x = 0, world.worldWidth do
                    if (world.worldX+(x*world.tileSize) > 0-tileSize) 
                    and (world.worldX+(x*world.tileSize) < ScreenWidth) 
                    and (world.worldY+(y*world.tileSize) > 0-tileSize) 
                    and (world.worldY+(y*world.tileSize) < ScreenHeight) then
                    if ((world.worldData[y][x] == 3) or (world.worldData[y][x] == 4)) then
                        if ((player.playerX) < (world.worldX+((x*tileSize)+tileSize))) 
                        and ((player.playerX+player.size) > (world.worldX+(x*tileSize))) 
                        and ((player.playerY) < (world.worldY+((y*tileSize)+tileSize))) 
                        and ((player.playerY+player.size) > (world.worldY+(y*tileSize))) then
                            world.worldY = world.prevworldY
                            world.worldX = world.prevworldX
                        end
                    end
                end
            end
        end

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
                        if (world.worldData[y][x] == 3) then
                            if love.mouse.isDown(1) then
                                world.worldData[y][x] = 0
                            end
                        end
                        if (world.worldData[y][x] == 0) then
                            if love.mouse.isDown(2) then
                                world.worldData[y][x] = 3
                            end
                        end
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
                tileSize = tileSize + 1
                world.tileSize = tileSize
            end
            if (key == "k") then
                tileSize = tileSize - 1
                world.tileSize = tileSize
            end
            if (key == "j") then
                world.worldX = 0
                world.worldY = 0
            end
        end
    end
end

function love.draw()
    if gameRunning == true then
        world:DrawWorld()
        player:draw()
        love.graphics.print(fps)
    else
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("CHECK CONSOLE", 0, 0)
        if initLoopDone == true then
            GameInit();
        end
        initLoopDone = true
    end
end
