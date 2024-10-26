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
        for x = 0, self.worldWidth do
            self.worldData[y][x] = 1
            if (x == 0) or (x == world.worldWidth) or (y == 0) or (y == world.worldHeight) then
                self.worldData[y][x] = 4
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
                for i = OreStart, OreStop do
                    if self.worldData[y][x] == 1 then  
                        if (self.worldData[y+1][x] == i) then
                            j = j + 1
                        end
                        if (self.worldData[y-1][x] == i) then
                            j = j + 1
                        end
                        if (self.worldData[y][x+1] == i) then
                            j = j + 1
                        end
                        if (self.worldData[y][x-1] == i) then
                            j = j + 1
                        end
                    end
                    if j == 4 then
                        self.worldData[y][x] = i
                    end
                end
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

function World:UpdateWorld()
    for y = 1, self.worldHeight-1 do
        for x = 1, self.worldWidth-1 do
            if (world.worldX+(x*world.tileSize) > 0-tileSize)
            and (world.worldX+(x*world.tileSize) < ScreenWidth)
            and (world.worldY+(y*world.tileSize) > 0-tileSize)
            and (world.worldY+(y*world.tileSize) < ScreenHeight) then
                j = 0
                if self.worldData[y][x] == 1 then  
                    if (self.worldData[y+1][x] == 2) then
                        j = j + 1
                    end
                    if (self.worldData[y-1][x] == 2) then
                        j = j + 1
                    end
                    if (self.worldData[y][x+1] == 2) then
                        j = j + 1
                    end
                    if (self.worldData[y][x-1] == 2) then
                        j = j + 1
                    end
                    if j >= 3 then
                        self.worldData[y][x] = 2
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
            if self.worldData[y][x] == 0 then
                if self.worldData[y+1][x] == 2 then
                    self.worldData[y][x] = 2
                end
                if self.worldData[y-1][x] == 2 then
                    self.worldData[y][x] = 2
                end
                if self.worldData[y][x+1] == 2 then
                    self.worldData[y][x] = 2
                end
                if self.worldData[y][x-1] == 2 then
                    self.worldData[y][x] = 2
                end
                if self.worldData[y-1][x-1] == 2 then
                    self.worldData[y][x] = 2
                end
                if self.worldData[y+1][x+1] == 2 then
                    self.worldData[y][x] = 2
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
                love.graphics.setColor(0, 0, 0)
                if not ((y+1 > self.worldHeight) or (y-1 < 0) or (x+1 > self.worldWidth) or (x-1 < 0)) then
                    if debug == true then
                        if self.worldData[y][x] == 1 then
                            love.graphics.setColor(0, 0, 0)
                        else
                            love.graphics.setColor(0.3, 0.3, 0.3)
                        end
                    end
                    if ((self.worldData[y+1][x] == 2) or (self.worldData[y-1][x] == 2) or (self.worldData[y][x+1] == 2) or (self.worldData[y][x-1] == 2)) then
                        --FLOOR
                        if self.worldData[y][x] == 0 then
                            love.graphics.setColor(0.3, 0.3, 0.3)
                        end
    
                        --NOT SEE BLOCK idk
                        if self.worldData[y][x] == 1 then
                            love.graphics.setColor(0, 0, 0)
                        end
    
                        --SPAWN POINT / SHOW FILL / SHOW FLOOR
                        if self.worldData[y][x] == 2 then
                            love.graphics.setColor(0.3, 0.3, 0.3)
                        end
    
                        --CAVE WALLS
                        if self.worldData[y][x] == 3 then
                            love.graphics.setColor(0.5, 0.5, 0.5)
                        end

                        --ORES
                        if self.worldData[y][x] == 201 then --bluenite
                            love.graphics.setColor(0.6, 0.6, 0.8)
                        end
                        if self.worldData[y][x] == 202 then --rednite
                            love.graphics.setColor(0.8, 0.6, 0.6)
                        end
                    end
                end
                
                --WORLD BOARDER
                if self.worldData[y][x] == 4 then
                    love.graphics.setColor(0.2, 0.2, 0.2)
                end
                love.graphics.rectangle("fill", self.worldX+(x*self.tileSize), self.worldY+(y*self.tileSize), self.tileSize, self.tileSize)
            end
        end
    end
end