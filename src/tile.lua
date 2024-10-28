Tile = {}
Tile.__index = Tile

function Tile.new(tilesize, texture, tileType, breakable)
    local self = setmetatable({}, Tile)
    self.tileX = 0
    self.tileY = 0
    self.tilesize = tilesize
    self.texture = texture
    self.tilesize = tileType
    self.breakable = breakable
    return self
end

function Tile:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.texture, self.tileX, self.tileY, self.tilesize, self.tilesize)
end
