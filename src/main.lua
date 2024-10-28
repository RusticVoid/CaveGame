require "textures"
require "world"
require "tile"

function love.load()
    windowWidth, windowHeight = love.window.getMode()
    math.randomseed(os.clock())
    fps = 0

    tileSize = 16

    InitTextures()

    wallTile = Tile.new(wallTexture)
    floorTile = Tile.new(floorTexture)

    world = World.new(0, 0, 16)
    

    world:genCave(10, 1000)
end

function love.update(dt)
    fps = love.timer.getFPS()

    windowWidth, windowHeight = love.window.getMode()

    if love.keyboard.isDown("w") then
        world.y = world.y + 10
    end
    if love.keyboard.isDown("a") then
        world.x = world.x + 10
    end
    if love.keyboard.isDown("s") then
        world.y = world.y - 10
    end
    if love.keyboard.isDown("d") then
        world.x = world.x - 10
    end

    world:update()
end

function love.keypressed(key)
end

function love.draw()
    world:draw()
    love.graphics.print(fps)
    love.graphics.print("Player X:"..-math.floor((world.x/tileSize)/16), 0, 15)
    love.graphics.print("Player Y:"..-math.floor((world.y/tileSize)/16), 0, 30)
end
