Player = {}
Player.__index = Player

function Player.new(x, y, speed)
    local self = setmetatable({}, Player)
    self.x = x
    self.y = y
    self.speed = speed*tileSize
    self.size = tileSize/1.5
    return self
end

function Player:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)
end