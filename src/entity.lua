Entity = {}
Entity.__index = Entity

function Entity.new(x, y, texture)
    local self = setmetatable({}, Entity)
    self.x = x
    self.y = y
    self.texture = texture
    return self
end

function Entity:draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.texture, self.x, self.y, 0, tileSize/16)
end