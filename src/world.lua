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
            self.worldData[y][x] = wallTile
            self.worldShowData[y][x] = wallTile
            if (x == 0) or (x == world.worldWidth) or (y == 0) or (y == world.worldHeight) then
                self.worldData[y][x] = boarderTile
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

            self.worldData[CaveY][CaveX] = FloorTile
        end
    end

    for i = 0, revamps do
        for y = 1, self.worldHeight-1 do
            for x = 1, self.worldWidth-1 do
                if self.worldData[y][x] == wallTile then
                    j = 0
                    if self.worldData[y+1][x] == FloorTile then
                        j = j + 1
                    end
                    if self.worldData[y-1][x] == FloorTile then
                        j = j + 1
                    end
                    if self.worldData[y][x+1] == FloorTile then
                        j = j + 1
                    end
                    if self.worldData[y][x-1] == FloorTile then
                        j = j + 1
                    end

                    if j >= 3 then
                        self.worldData[y][x] = FloorTile
                    end
                end
            end
        end
    end
end

function World:GenOre(oreCount)
    for i = 0, oreCount-1 do
        OreX = math.random(1, self.worldWidth-1)
        OreY = math.random(1, self.worldHeight-1)
        OreStart = 1
        OreStop = #ores
        OreType = math.random(OreStart, OreStop)

        iterations = math.random(20, 50)
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
            
            self.worldData[OreY][OreX] = ores[OreType]
        end
    end
end

function World:GenBiome(biomeCount)
end

function World:UpdateWorld()
end

function World:DrawWorld()
    for y = 0, self.worldHeight do
        for x = 0, self.worldWidth do
            if (self.worldX+(x*self.tileSize) > 0-tileSize)
            and (self.worldX+(x*self.tileSize) < ScreenWidth)
            and (self.worldY+(y*self.tileSize) > 0-tileSize)
            and (self.worldY+(y*self.tileSize) < ScreenHeight) then
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.draw(self.worldData[y][x].texture, self.worldX+(x*self.tileSize), self.worldY+(y*self.tileSize), 0, 3.2, 3.2)
            end
        end
    end
end