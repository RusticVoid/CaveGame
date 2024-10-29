require "tile"

Chunk = {}
Chunk.__index = Chunk

function Chunk.new(x, y, size)
    local self = setmetatable({}, Chunk)
    self.x = x*size
    self.y = y*size
    self.size = size
    self.chunkData = {}

    for y = 1, self.size do
        self.chunkData[y] = {}
        for x = 1, self.size do
            self.chunkData[y][x] = wallTile
        end
    end

    return self
end

function Chunk:update(WorldX, WorldY)
    for y = 1, self.size do
        for x = 1, self.size do
            if self.chunkData[y][x]:inWindow((WorldX+self.x*tileSize), (WorldY+self.y*tileSize), x-1, y-1) then
                if collid(MouseX, MouseY, 1, 1, (WorldX+self.x*tileSize)+(x-1)*tileSize, (WorldY+self.y*tileSize)+(y-1)*tileSize, tileSize, tileSize) then
                    if love.mouse.isDown(1) then
                        if self.chunkData[y][x].breakable == true then
                            self.chunkData[y][x] = floorTile
                        end
                    end
                end
                if collid(player.x, player.y, player.size, player.size, (WorldX+self.x*tileSize)+(x-1)*tileSize, (WorldY+self.y*tileSize)+(y-1)*tileSize, tileSize, tileSize) then
                    if self.chunkData[y][x].hasCollision == true then
                        print(self.chunkData[y][x].hasCollision)
                        world.x = prevPlayerX
                        world.y = prevPlayerY
                    end
                end
            end
        end
    end
end

function Chunk:draw(WorldX, WorldY)
    for y = 1, self.size do
        for x = 1, self.size do
            if self.chunkData[y][x]:inWindow((WorldX+self.x*tileSize), (WorldY+self.y*tileSize), x-1, y-1) then
                self.chunkData[y][x]:draw((WorldX+self.x*tileSize), (WorldY+self.y*tileSize), x-1, y-1)
                if debug == true then
                    love.graphics.rectangle("line", (WorldX+self.x*tileSize), (WorldY+self.y*tileSize), (self.size)*tileSize, (self.size)*tileSize)
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