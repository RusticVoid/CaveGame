require "textures"
require "world"
require "tile"
require "player"

function love.load()
    windowWidth, windowHeight = love.window.getMode()
    math.randomseed(os.clock())
    fps = 0
    debug = false

    tileSize = 30

    InitTextures()

    wallTile = Tile.new(wallTexture)
    floorTile = Tile.new(floorTexture)

    world = World.new(63)
    
    player = Player.new((windowWidth/2)-(tileSize/1.5), (windowHeight/2)-(tileSize/1.5), 8)

    world:genCave(100, 2000)
end

function love.update(dt)
    DeltaTime = dt
    fps = love.timer.getFPS()

    windowWidth, windowHeight = love.window.getMode()

    if love.keyboard.isDown("w") then
        world.y = world.y + player.speed * DeltaTime
    end
    if love.keyboard.isDown("a") then
        world.x = world.x + player.speed * DeltaTime
    end
    if love.keyboard.isDown("s") then
        world.y = world.y - player.speed * DeltaTime
    end
    if love.keyboard.isDown("d") then
        world.x = world.x - player.speed * DeltaTime
    end

    world:update()
end

function love.keypressed(key)
    if key == "f1" then
        debug = not debug
    end
    if debug == true then
        if key == "f2" then
        end
    end
end

function love.draw()
    world:draw()
    love.graphics.print("FPS: "..fps)
    if debug == true then
        love.graphics.print("Player X:"..-math.floor(((world.x-player.x)/tileSize)/16), 0, 15)
        love.graphics.print("Player Y:"..-math.floor(((world.y-player.y)/tileSize)/16), 0, 30)
    end
    player:draw()
end
