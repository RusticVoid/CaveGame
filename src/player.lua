Player = {}
Player.__index = Player

function Player.new(playerX, playerY, playerSpeed)
    local self = setmetatable({}, Player)
    self.playerX = playerX
    self.playerY = playerY
    self.playerSpeed = playerSpeed
    return self
end