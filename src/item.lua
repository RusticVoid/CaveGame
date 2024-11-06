
Item = {}
Item.__index = Item

function Item.new(texture)
    local self = setmetatable({}, Item)
    self.texture = texture
    self.IsItem = true
    return self
end

function Item:inWindow(ChunkX, ChunkY, x, y)
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