Player = {}
Player.__index = Player

function Player.new(x, y, speed)
    local self = setmetatable({}, Player)
    self.x = x
    self.y = y
    self.speed = speed*tileSize
    return self
end

function Player:draw()
    love.graphics.rectangle("fill", self.x, self.y, tileSize/1.5, tileSize/1.5)
end