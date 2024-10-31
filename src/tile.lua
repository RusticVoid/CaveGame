
Tile = {}
Tile.__index = Tile

function Tile.new(texture, hasCollision, breakable, topTile)
    local self = setmetatable({}, Tile)
    self.texture = texture
    self.hasCollision = hasCollision
    self.breakable = breakable
    self.topTile = topTile
    return self
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