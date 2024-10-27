Player = {}
Player.__index = Player

function Player.new(playerX, playerY, size, playerSpeed)
    local self = setmetatable({}, Player)
    self.playerX = playerX
    self.playerY = playerY
    self.size = size
    self.playerSpeed = playerSpeed
    self.playerXVel = 0
    self.playerYVel = 0
    self.playerVelMax = self.playerSpeed * 100
    return self
end

function Player:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", player.playerX, player.playerY, self.size, self.size)
end