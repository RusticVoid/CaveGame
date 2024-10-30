
Tile = {}
Tile.__index = Tile

function Tile.new(texture, hasCollision, breakable)
    local self = setmetatable({}, Tile)
    self.texture = texture
    self.hasCollision = hasCollision
    self.breakable = breakable
    return self
end

function Tile:draw(ChunkX, ChunkY, x, y)
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.texture, ChunkX+x*tileSize, ChunkY+y*tileSize, 0, tileSize/16)
    if debug == true then
        if collisionMode == true then
            if self.hasCollision == true then
                love.graphics.setColor(1, 0, 0)
                love.graphics.rectangle("line", (ChunkX+x*tileSize)+1, (ChunkY+y*tileSize)+1, tileSize-1, tileSize-1)
            else
                love.graphics.setColor(1, 1, 0)
                love.graphics.rectangle("line", (ChunkX+x*tileSize)+1, (ChunkY+y*tileSize)+1, tileSize-1, tileSize-1)
            end
        end
    end
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