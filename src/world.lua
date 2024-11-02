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

        self.chunks[CaveChunkY][CaveChunkX].topChunkData[CaveY][CaveX] = airTile

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
            self.chunks[CaveChunkY][CaveChunkX].topChunkData[CaveY][CaveX] = airTile

            if self.chunks[CaveChunkY][CaveChunkX].topChunkData[CaveY][CaveX] == airTile then
                self.chunks[CaveChunkY][CaveChunkX].topChunkData[CaveY][CaveX] = airTile
            end
        end
    end
end

function World:genBiome(BiomeAmount, interations)
    for i = 0, BiomeAmount do
        ValidPos = false
        while ValidPos == false do
            BiomeChunkX = math.random(1, self.size)
            BiomeChunkY = math.random(1, self.size)
    
            BiomeX = math.random(1, self.chunks[BiomeChunkY][BiomeChunkX].size)
            BiomeY = math.random(1, self.chunks[BiomeChunkY][BiomeChunkX].size)
            
            if (self.chunks[BiomeChunkY][BiomeChunkX].topChunkData[BiomeX][BiomeY] == airTile) and (self.chunks[BiomeChunkY][BiomeChunkX].bottomChunkData[BiomeX][BiomeY] == floorTile) then
                ValidPos = true
            end
        end

        BiomeType = math.random(1, #Biomes)

        self.chunks[BiomeChunkY][BiomeChunkX].bottomChunkData[BiomeX][BiomeY] = Biomes[BiomeType][2]

        for i = 0, interations do
            decision = math.random(1, 4)
            
            if decision == 1 then
                BiomeX = BiomeX + 1;
            end
            if decision == 2 then
                BiomeX = BiomeX - 1;
            end
            if decision == 3 then
                BiomeY = BiomeY + 1;
            end
            if decision == 4 then
                BiomeY = BiomeY - 1;
            end

            if BiomeX < 1 then
                BiomeChunkX = BiomeChunkX - 1
                if BiomeChunkX < 1 then
                    BiomeChunkX = BiomeChunkX + 1
                else
                    BiomeX = self.chunks[BiomeChunkY][BiomeChunkX].size
                end
            end
            if BiomeY < 1 then
                BiomeChunkY = BiomeChunkY - 1
                if BiomeChunkY < 1 then
                    BiomeChunkY = BiomeChunkY + 1
                    BiomeY = 1
                else
                    BiomeY = self.chunks[BiomeChunkY][BiomeChunkX].size
                end
            end
            if BiomeX > self.chunks[BiomeChunkY][BiomeChunkX].size then
                BiomeChunkX = BiomeChunkX + 1
                if BiomeChunkX > world.size then
                    BiomeChunkX = BiomeChunkX - 1
                else
                    BiomeX = 1
                end
            end
            if BiomeY > self.chunks[BiomeChunkY][BiomeChunkX].size then
                BiomeChunkY = BiomeChunkY + 1
                if BiomeChunkY > world.size then
                    BiomeChunkY = BiomeChunkY - 1
                    BiomeY = self.chunks[BiomeChunkY][BiomeChunkX].size
                else
                    BiomeY = 1
                end
            end

            if self.chunks[BiomeChunkY][BiomeChunkX].topChunkData[BiomeY][BiomeX] == wallTile then
                self.chunks[BiomeChunkY][BiomeChunkX].topChunkData[BiomeY][BiomeX] = Biomes[BiomeType][1]
            end
            if self.chunks[BiomeChunkY][BiomeChunkX].bottomChunkData[BiomeY][BiomeX] == floorTile then
                self.chunks[BiomeChunkY][BiomeChunkX].bottomChunkData[BiomeY][BiomeX] = Biomes[BiomeType][2]
            end
        end
    end
end

function World:genOre(OreAmount, interations)
    for i = 0, OreAmount do
        OreChunkX = math.random(1, self.size)
        OreChunkY = math.random(1, self.size)

        OreX = math.random(1, self.chunks[OreChunkY][OreChunkX].size)
        OreY = math.random(1, self.chunks[OreChunkY][OreChunkX].size)

        OreType = math.random(1, #Ores)

        self.chunks[OreChunkY][OreChunkX].topChunkData[OreY][OreX] = Ores[OreType]

        for i = 0, interations do
            decision = math.random(1, 4)
            
            if decision == 1 then
                OreX = OreX + 1;
            end
            if decision == 2 then
                OreX = OreX - 1;
            end
            if decision == 3 then
                OreY = OreY + 1;
            end
            if decision == 4 then
                OreY = OreY - 1;
            end

            if OreX < 1 then
                OreChunkX = OreChunkX - 1
                if OreChunkX < 1 then
                    OreChunkX = OreChunkX + 1
                else
                    OreX = self.chunks[OreChunkY][OreChunkX].size
                end
            end
            if OreY < 1 then
                OreChunkY = OreChunkY - 1
                if OreChunkY < 1 then
                    OreChunkY = OreChunkY + 1
                    OreY = 1
                else
                    OreY = self.chunks[OreChunkY][OreChunkX].size
                end
            end
            if OreX > self.chunks[OreChunkY][OreChunkX].size then
                OreChunkX = OreChunkX + 1
                if OreChunkX > world.size then
                    OreChunkX = OreChunkX - 1
                else
                    OreX = 1
                end
            end
            if OreY > self.chunks[OreChunkY][OreChunkX].size then
                OreChunkY = OreChunkY + 1
                if OreChunkY > world.size then
                    OreChunkY = OreChunkY - 1
                    OreY = self.chunks[OreChunkY][OreChunkX].size
                else
                    OreY = 1
                end
            end
            self.chunks[OreChunkY][OreChunkX].topChunkData[OreY][OreX] = Ores[OreType]
        end
    end
end

function World:genClean(interations)
    for i = 0, interations do
        for ChunkY = 1, world.size do
            for ChunkX = 1, world.size do
                for TileY = 1, world.chunks[ChunkY][ChunkX].size do
                    for TileX = 1, world.chunks[ChunkY][ChunkX].size do
                        j = 0
                        if (not (TileY+1 > world.chunks[ChunkY][ChunkX].size)) and (world.chunks[ChunkY][ChunkX].topChunkData[TileY+1][TileX] == airTile) then
                            j = j + 1
                        end
                        if (not (TileY-1 <= 0)) and (world.chunks[ChunkY][ChunkX].topChunkData[TileY-1][TileX] == airTile) then
                            j = j + 1
                        end
                        if (not (TileX+1 > world.chunks[ChunkY][ChunkX].size)) and (world.chunks[ChunkY][ChunkX].topChunkData[TileY][TileX+1] == airTile) then
                            j = j + 1
                        end
                        if (not (TileX-1 <= 0)) and (world.chunks[ChunkY][ChunkX].topChunkData[TileY][TileX-1] == airTile) then
                            j = j + 1
                        end

                        if j >= 3 then
                            world.chunks[ChunkY][ChunkX].topChunkData[TileY][TileX] = airTile
                        end
                    end
                end
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
                if debug == true then
                    if chunkMode == true then
                        love.graphics.setColor(1, 1, 1)
                        love.graphics.rectangle("line", (self.x+self.chunks[y][x].x*tileSize), (self.y+self.chunks[y][x].y*tileSize), (self.size)*tileSize, (self.size)*tileSize)
                    end
                end
            end
        end
    end
end