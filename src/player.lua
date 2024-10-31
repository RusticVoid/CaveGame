Player = {}
Player.__index = Player

function Player.new(x, y, speed, texture)
    local self = setmetatable({}, Player)
    self.x = x
    self.y = y
    self.speed = speed*tileSize
    self.texture = texture
    self.size = tileSize/1.5
    self.selectedTile = wallTile
    return self
end

function Player:draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.texture, self.x-8, self.y-8, 0, tileSize/16)
end