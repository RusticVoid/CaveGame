require "world"
require "player"

function love.load()
    math.randomseed(os.time())
    tileSize = 5

    world = World.new(100, 100, tileSize)
    world:GenWorld()
    world:GenCave(20, 1000)

    player = Player.new(world.worldX/2, world.worldY/2, 5)
end

function love.update(dt)
    if love.keyboard.isDown("w") then
        player.playerY = player.playerY - player.playerSpeed
    end
    if love.keyboard.isDown("s") then
        player.playerY = player.playerY + player.playerSpeed
    end
    if love.keyboard.isDown("a") then
        player.playerX = player.playerX - player.playerSpeed
    end
    if love.keyboard.isDown("d") then
        player.playerX = player.playerX + player.playerSpeed
    end
end

function love.draw()
    world:DrawWorld()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", player.playerX, player.playerY, tileSize, tileSize)
end
