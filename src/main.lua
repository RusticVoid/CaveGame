require "world"
require "player"

function sleep(a)
    local sec = tonumber(os.clock() + a)
    while(os.clock() < sec) do
    end
end

function love.load()
    math.randomseed(os.time())
    tileSize = 20

    ScreenWidth, ScreenHeight = love.window.getMode()

    world = World.new(1000, 1000, tileSize)

    love.graphics.print("Generating World...", 0, 0)

    world:GenWorld()
    world:GenCave(200, 1000, 10)

    player = Player.new(ScreenWidth/2, ScreenHeight/2, 5)
    
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
end

function love.update(dt)
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
end

function love.keypressed(key)
end

function love.draw()
    world:DrawWorld()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", player.playerX, player.playerY, tileSize, tileSize)
end
