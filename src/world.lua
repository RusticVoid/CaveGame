World = {}
World.__index = World

function World.new(worldHeight, worldWidth, tileSize)
    local self = setmetatable({}, World)
    self.worldX = 0
    self.worldY = 0
    self.prevworldX = self.worldX
    self.prevworldY = self.worldY
    self.worldHeight = worldHeight
    self.worldWidth = worldWidth
    self.worldData = {}
    self.worldShowData = {}
    self.tileSize = tileSize
    return self
end

function World:GenWorld()
    for y = 0, self.worldHeight do
        self.worldData[y] = {}
        self.worldShowData[y] = {}
        for x = 0, self.worldWidth do
            self.worldData[y][x] = 1
            self.worldShowData[y][x] = 0
            if (x == 0) or (x == world.worldWidth) or (y == 0) or (y == world.worldHeight) then
                self.worldData[y][x] = 4
            end
        end
    end
end

function World:GenCave(caveAmount, iterations, revamps)
    for i = 0, caveAmount-1 do
        CaveX = math.random(1, self.worldWidth-1)
        CaveY = math.random(1, self.worldHeight-1)

        for j = 0, iterations-1 do
            decision = math.random(1, 4)
            
            if decision == 1 then
                CaveX = CaveX + 1;
                if (CaveX > world.worldWidth-1) then
                    CaveX = CaveX - 1;
                end
            end
            if decision == 2 then
                CaveX = CaveX - 1;
                if (CaveX < 1) then
                    CaveX = CaveX + 1;
                end
            end
            if decision == 3 then
                CaveY = CaveY + 1;
                if (CaveY > world.worldHeight-1) then
                    CaveY = CaveY - 1;
                end
            end
            if decision == 4 then
                CaveY = CaveY - 1;
                if (CaveY < 1) then
                    CaveY = CaveY + 1;
                end
            end

            self.worldData[CaveY][CaveX] = 0
        end
    end

    for i = 0, revamps do
        for y = 1, self.worldHeight-1 do
            for x = 1, self.worldWidth-1 do
                j = 0
                if self.worldData[y][x] == 1 then  
                    if self.worldData[y+1][x] == 0 then
                        j = j + 1
                    end
                    if self.worldData[y-1][x] == 0 then
                        j = j + 1
                    end
                    if self.worldData[y][x+1] == 0 then
                        j = j + 1
                    end
                    if self.worldData[y][x-1] == 0 then
                        j = j + 1
                    end
                end
                if j >= 3 then
                    self.worldData[y][x] = 0
                else
                    if j >= 1 then 
                        self.worldData[y][x] = 3
                    end
                end
            end
        end
    end
end

function World:GenOre(oreCount, revamps)
    for i = 0, oreCount-1 do
        OreX = math.random(1, self.worldWidth-1)
        OreY = math.random(1, self.worldHeight-1)
        OreStart = 201
        OreStop = 202
        OreType = math.random(OreStart, OreStop)

        iterations = math.random(20, 50)

        BigChance = math.random(1, 10)
        if BigChance == 1 then
            iterations = math.random(200, 500)
        end

        for j = 0, iterations-1 do
            decision = math.random(1, 4)
            
            if decision == 1 then
                OreX = OreX + 1;
                if (OreX > world.worldWidth-1) then
                    OreX = OreX - 1;
                end
            end
            if decision == 2 then
                OreX = OreX - 1;
                if (OreX < 1) then
                    OreX = OreX + 1;
                end
            end
            if decision == 3 then
                OreY = OreY + 1;
                if (OreY > world.worldHeight-1) then
                    OreY = OreY - 1;
                end
            end
            if decision == 4 then
                OreY = OreY - 1;
                if (OreY < 1) then
                    OreY = OreY + 1;
                end
            end
            
            self.worldData[OreY][OreX] = OreType
        end
    end
    
    for i = 0, revamps do
        for y = 1, self.worldHeight-1 do
            for x = 1, self.worldWidth-1 do
                if self.worldData[y][x] == 1 then
                    for j = OreStart, OreStop do
                        k = 0
                        if (self.worldData[y+1][x] == j) then
                            k = k + 1
                        end
                        if (self.worldData[y-1][x] == j) then
                            k = k + 1
                        end
                        if (self.worldData[y][x+1] == j) then
                            k = k + 1
                        end
                        if (self.worldData[y][x-1] == j) then
                            k = k + 1
                        end
                        if k >= 3 then
                            self.worldData[y][x] = j
                        end
                    end
                end
            end
        end
    end
end

function World:GenBiome(biomeCount)
    for i = 0, biomeCount-1 do
        BiomeStart = 301
        BiomeStop = 302
        BiomeType = math.random(BiomeStart, BiomeStop)

        caveNotFound = true
        while caveNotFound do
            BiomeX = math.random(1, self.worldWidth-1)
            BiomeY = math.random(1, self.worldHeight-1)
            if self.worldData[BiomeY][BiomeX] == 0 then
                caveNotFound = false
                self.worldData[BiomeY][BiomeX] = BiomeType
                print(BiomeX)
                print(BiomeY)
            end
        end


        iterations = 50
        for j = 0, iterations-1 do
            for y = 0, self.worldHeight do
                for x = 0, self.worldWidth do
                    if self.worldData[y][x] == 0 then
                        for i = BiomeStart, BiomeStop do
                            if self.worldData[y+1][x] == i then
                                self.worldData[y][x] = i
                            end
                            if self.worldData[y-1][x] == i then
                                self.worldData[y][x] = i
                            end
                            if self.worldData[y][x+1] == i then
                                self.worldData[y][x] = i
                            end
                            if self.worldData[y][x-1] == i then
                                self.worldData[y][x] = i
                            end
                            if self.worldData[y-1][x-1] == i then
                                self.worldData[y][x] = i
                            end
                            if self.worldData[y+1][x+1] == i then
                                self.worldData[y][x] = i
                            end
                        end
                    end
                end
            end
        end
    end
end

function World:UpdateWorld()
    for y = 1, self.worldHeight-1 do
        for x = 1, self.worldWidth-1 do
            if (world.worldX+(x*world.tileSize) > 0-tileSize)
            and (world.worldX+(x*world.tileSize) < ScreenWidth)
            and (world.worldY+(y*world.tileSize) > 0-tileSize)
            and (world.worldY+(y*world.tileSize) < ScreenHeight) then
                j = 0
                if self.worldData[y][x] == 1 then  
                    if (self.worldShowData[y+1][x] == 2) then
                        j = j + 1
                    end
                    if (self.worldShowData[y-1][x] == 2) then
                        j = j + 1
                    end
                    if (self.worldShowData[y][x+1] == 2) then
                        j = j + 1
                    end
                    if (self.worldShowData[y][x-1] == 2) then
                        j = j + 1
                    end
                    if j >= 3 then
                        self.worldShowData[y][x] = 2
                    else
                        if j >= 1 then 
                            self.worldData[y][x] = 3
                        end
                    end
                end
            end
        end
    end

    for y = 0, self.worldHeight do
        for x = 0, self.worldWidth do
            if self.worldShowData[y][x] == 2 then
                if not ((self.worldData[y+1][x] == 1) or (self.worldData[y+1][x] == 3) or (self.worldData[y+1][x] == 4) or ((self.worldData[y+1][x] >= OreStart) and (self.worldData[y+1][x] <= OreStop))) then
                    self.worldShowData[y+1][x] = 2
                end

                if not ((self.worldData[y-1][x] == 1) or (self.worldData[y-1][x] == 3) or (self.worldData[y-1][x] == 4) or ((self.worldData[y-1][x] >= OreStart) and (self.worldData[y-1][x] <= OreStop))) then
                    self.worldShowData[y-1][x] = 2
                end

                if not ((self.worldData[y][x+1] == 1) or (self.worldData[y][x+1] == 3) or (self.worldData[y][x+1] == 4) or ((self.worldData[y][x+1] >= OreStart) and (self.worldData[y][x+1] <= OreStop))) then
                    self.worldShowData[y][x+1] = 2
                end

                if not ((self.worldData[y][x-1] == 1) or (self.worldData[y][x-1] == 3) or (self.worldData[y][x-1] == 4) or ((self.worldData[y][x-1] >= OreStart) and (self.worldData[y][x-1] <= OreStop))) then
                    self.worldShowData[y][x-1] = 2
                end

                if not ((self.worldData[y-1][x-1] == 1) or (self.worldData[y-1][x-1] == 3) or (self.worldData[y-1][x-1] == 4) or ((self.worldData[y-1][x-1] >= OreStart) and (self.worldData[y-1][x-1] <= OreStop))) then
                    self.worldShowData[y-1][x-1] = 2
                end

                if not ((self.worldData[y+1][x+1] == 1) or (self.worldData[y+1][x+1] == 3) or (self.worldData[y+1][x+1] == 4) or ((self.worldData[y+1][x+1] >= OreStart) and (self.worldData[y+1][x+1] <= OreStop))) then
                    self.worldShowData[y+1][x+1] = 2
                end
            end
        end
    end
end

function World:DrawWorld()
    for y = 0, self.worldHeight do
        for x = 0, self.worldWidth do
            if (self.worldX+(x*self.tileSize) > 0-tileSize)
            and (self.worldX+(x*self.tileSize) < ScreenWidth)
            and (self.worldY+(y*self.tileSize) > 0-tileSize)
            and (self.worldY+(y*self.tileSize) < ScreenHeight) then
                drawtile = 0
                love.graphics.setColor(0.0, 0.0, 0.0)
                if not ((y+1 > self.worldHeight) or (y-1 < 0) or (x+1 > self.worldWidth) or (x-1 < 0)) then
                    if debug == true then
                        --FLOOR
                        if self.worldData[y][x] == 0 then
                            drawtile = floorTexture
                        end
                        --NOT SEE BLOCK idk
                        if self.worldData[y][x] == 1 then
                            love.graphics.setColor(0, 0, 0)
                        end


                        --CAVE WALLS
                        if self.worldData[y][x] == 3 then
                            drawtile = wallTexture
                        end
                        --ORES
                        if self.worldData[y][x] == 201 then --bluenite
                            drawtile = blueniteTexture
                        end
                        if self.worldData[y][x] == 202 then --rednite
                            drawtile = redniteTexture
                        end
                        --BIOMES
                        if self.worldData[y][x] == 301 then --Red Biome
                            drawtile = redGroundTexture
                        end
                        if self.worldData[y][x] == 302 then --Green Biome
                            drawtile = greenGroundTexture
                        end
                    end
                    if ((self.worldShowData[y+1][x] == 2) or (self.worldShowData[y-1][x] == 2) or (self.worldShowData[y][x+1] == 2) or (self.worldShowData[y][x-1] == 2)) then
                        --FLOOR
                        if self.worldData[y][x] == 0 then
                            drawtile = floorTexture
                        end
    
                        --Abise
                        if self.worldData[y][x] == 1 then
                            love.graphics.setColor(0, 0, 0)
                        end
    
                        --CAVE WALLS
                        if self.worldData[y][x] == 3 then
                            drawtile = wallTexture
                        end

                        --ORES
                        if self.worldData[y][x] == 201 then --bluenite
                            drawtile = blueniteTexture
                        end
                        if self.worldData[y][x] == 202 then --rednite
                            drawtile = redniteTexture
                        end

                        --BIOMES
                        if self.worldData[y][x] == 301 then --Red Biome
                            drawtile = redGroundTexture
                        end
                        if self.worldData[y][x] == 302 then --Green Biome
                            drawtile = greenGroundTexture
                        end
                    end
                end
                
                --WORLD BOARDER
                if self.worldData[y][x] == 4 then
                    love.graphics.setColor(0.2, 0.2, 0.2)
                end

                if drawtile == 0 then
                    love.graphics.rectangle("fill", self.worldX+(x*self.tileSize), self.worldY+(y*self.tileSize), self.tileSize, self.tileSize)
                else
                    love.graphics.setColor(1, 1, 1, 1)
                    love.graphics.draw(drawtile, self.worldX+(x*self.tileSize), self.worldY+(y*self.tileSize), 0, 3.2, 3.2)
                end
            end
        end
    end
end