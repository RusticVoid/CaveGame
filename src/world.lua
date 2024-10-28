require "chunk"

World = {}
World.__index = World

function World.new(size)
    local self = setmetatable({}, World)
    self.x = -(size*16*tileSize)/2
    self.y = -(size*16*tileSize)/2
    self.chunks = {}
    self.size = size

    for y = 0, self.size do
        self.chunks[y] = {}
        for x = 0, self.size do
            self.chunks[y][x] = Chunk.new(x, y, 16)
        end
    end

    return self
end

function World:genCave(caveAmount, interations)
    for i = 0, caveAmount do
        CaveChunkX = math.random(0, self.size)
        CaveChunkY = math.random(0, self.size)

        CaveX = math.random(0, self.chunks[CaveChunkY][CaveChunkX].size)
        CaveY = math.random(0, self.chunks[CaveChunkY][CaveChunkX].size)

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

            if CaveX < 0 then
                CaveChunkX = CaveChunkX - 1
                if CaveChunkX < 0 then
                    CaveChunkX = CaveChunkX + 1
                else
                    CaveX = self.chunks[CaveChunkY][CaveChunkX].size
                end
            end
            if CaveY < 0 then
                CaveChunkY = CaveChunkY - 1
                if CaveChunkY < 0 then
                    CaveChunkY = CaveChunkY + 1
                    CaveY = 0
                else
                    CaveY = self.chunks[CaveChunkY][CaveChunkX].size
                end
            end
            if CaveX > self.chunks[CaveChunkY][CaveChunkX].size then
                CaveChunkX = CaveChunkX + 1
                if CaveChunkX > world.size then
                    CaveChunkX = CaveChunkX - 1
                else
                    CaveX = 0
                end
            end
            if CaveY > self.chunks[CaveChunkY][CaveChunkX].size then
                CaveChunkY = CaveChunkY + 1
                if CaveChunkY > world.size then
                    CaveChunkY = CaveChunkY - 1
                    CaveY = self.chunks[CaveChunkY][CaveChunkX].size
                else
                    CaveY = 0
                end
            end
            self.chunks[CaveChunkY][CaveChunkX].chunkData[CaveY][CaveX] = floorTile
        end
    end
end

function World:update()
    for y = 0, self.size do
        for x = 0, self.size do
            if self.chunks[y][x]:inWindow(self.x, self.y) then
                self.chunks[y][x]:update()
            end
        end
    end
end

function World:draw()
    for y = 0, self.size do
        for x = 0, self.size do
            if self.chunks[y][x]:inWindow(self.x, self.y) then
                self.chunks[y][x]:draw(self.x, self.y)
            end
        end
    end
end