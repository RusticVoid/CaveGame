require "chunk"

World = {}
World.__index = World

function World.new(size)
    local self = setmetatable({}, World)
    self.x = -(size*16*tileSize)/2
    self.y = -(size*16*tileSize)/2
    self.chunks = {}
    self.size = size
    return self
end

function World:genWorld()
    for y = 1, self.size do
        self.chunks[y] = {}
        for x = 1, self.size do
            self.chunks[y][x] = Chunk.new(x, y, 16)
        end
    end
end

function World:genCave(caveAmount, interations)
    for i = 0, caveAmount do
        CaveChunkX = math.random(1, self.size)
        CaveChunkY = math.random(1, self.size)

        CaveX = math.random(1, self.chunks[CaveChunkY][CaveChunkX].size)
        CaveY = math.random(1, self.chunks[CaveChunkY][CaveChunkX].size)

        self.chunks[CaveChunkY][CaveChunkX].chunkData[CaveY][CaveX] = floorTile

        for i = 0, interations do
            decision = math.random(1, 4)
            
            if decision == 1 then
                CaveX = CaveX + 1;
            end
            if decision == 2 then
                CaveX = CaveX - 1;
            end
            if decision == 3 then
                CaveY = CaveY + 1;
            end
            if decision == 4 then
                CaveY = CaveY - 1;
            end

            if CaveX < 1 then
                CaveChunkX = CaveChunkX - 1
                if CaveChunkX < 1 then
                    CaveChunkX = CaveChunkX + 1
                else
                    CaveX = self.chunks[CaveChunkY][CaveChunkX].size
                end
            end
            if CaveY < 1 then
                CaveChunkY = CaveChunkY - 1
                if CaveChunkY < 1 then
                    CaveChunkY = CaveChunkY + 1
                    CaveY = 1
                else
                    CaveY = self.chunks[CaveChunkY][CaveChunkX].size
                end
            end
            if CaveX > self.chunks[CaveChunkY][CaveChunkX].size then
                CaveChunkX = CaveChunkX + 1
                if CaveChunkX > world.size then
                    CaveChunkX = CaveChunkX - 1
                else
                    CaveX = 1
                end
            end
            if CaveY > self.chunks[CaveChunkY][CaveChunkX].size then
                CaveChunkY = CaveChunkY + 1
                if CaveChunkY > world.size then
                    CaveChunkY = CaveChunkY - 1
                    CaveY = self.chunks[CaveChunkY][CaveChunkX].size
                else
                    CaveY = 1
                end
            end
            self.chunks[CaveChunkY][CaveChunkX].chunkData[CaveY][CaveX] = floorTile

            if self.chunks[CaveChunkY][CaveChunkX].chunkData[CaveY][CaveX] == floorTile then
                self.chunks[CaveChunkY][CaveChunkX].chunkData[CaveY][CaveX] = floorTile
            end
        end
    end
end

function World:update()
    for y = 1, self.size do
        for x = 1, self.size do
            if self.chunks[y][x]:inWindow(self.x, self.y) then
                self.chunks[y][x]:update(self.x, self.y)
            end
        end
    end
end

function World:draw()
    for y = 1, self.size do
        for x = 1, self.size do
            if self.chunks[y][x]:inWindow(self.x, self.y) then
                self.chunks[y][x]:draw(self.x, self.y)
            end
        end
    end
end