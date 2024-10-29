
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

function Tile:inWindow(ChunkX, ChunkY, x, y)
    if (ChunkX+(x*tileSize) > 0-(tileSize))
    and (ChunkX+(x*tileSize) < windowWidth)
    and (ChunkY+(y*tileSize) > 0-(tileSize))
    and (ChunkY+(y*tileSize) < windowHeight) then
        isInWindow = true
    else
        isInWindow = false
    end
    return isInWindow
end