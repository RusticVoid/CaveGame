
Tile = {}
Tile.__index = Tile

function Tile.new(texture)
    local self = setmetatable({}, Tile)
    self.texture = texture
    return self
end

function Tile:update()
end

function Tile:draw(ChunkX, ChunkY, x, y)
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.texture, ChunkX+x*tileSize, ChunkY+y*tileSize, 0, tileSize/16)
    love.graphics.setColor(1, 1, 1)
end