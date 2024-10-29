require "tile"

Chunk = {}
Chunk.__index = Chunk

function Chunk.new(x, y, size)
    local self = setmetatable({}, Chunk)
    self.x = x*size
    self.y = y*size
    self.size = size
    self.chunkData = {}

    for y = 0, self.size do
        self.chunkData[y] = {}
        for x = 0, self.size do
            self.chunkData[y][x] = wallTile
        end
    end

    return self
end

function Chunk:update()
    for y = 0, self.size do
        for x = 0, self.size do
            self.chunkData[y][x]:update()
        end
    end
end

function Chunk:draw(WorldX, WorldY)
    for y = 0, self.size do
        for x = 0, self.size do
            if self.chunkData[y][x]:inWindow((WorldX+self.x*tileSize), (WorldY+self.y*tileSize), x, y) then
                self.chunkData[y][x]:draw((WorldX+self.x*tileSize), (WorldY+self.y*tileSize), x, y)
                if debug == true then
                    love.graphics.rectangle("line", (WorldX+self.x*tileSize), (WorldY+self.y*tileSize), self.size*tileSize, self.size*tileSize)
                end
            end
        end
    end
end

function Chunk:inWindow(WorldX, WorldY)
    if (WorldX+(self.x*tileSize) > 0-(self.size*tileSize))
    and (WorldX+(self.x*tileSize) < windowWidth)
    and (WorldY+(self.y*tileSize) > 0-(self.size*tileSize))
    and (WorldY+(self.y*tileSize) < windowHeight) then
        isInWindow = true
    else
        isInWindow = false
    end
    return isInWindow
end