World = {}
World.__index = World

function World.new(worldHeight, worldWidth, tileSize)
    local self = setmetatable({}, World)
    self.worldX = 0
    self.worldY = 0
    self.worldHeight = worldHeight
    self.worldWidth = worldWidth
    self.worldData = {}
    self.tileSize = tileSize
    return self
end

function World:GenWorld()
    for y = 0, self.worldHeight do
        self.worldData[y] = {}
        for x = 0, self.worldWidth do
            self.worldData[y][x] = 1
            if (x == 0) or (x == world.worldWidth) or (y == 0) or (y == world.worldHeight) then
                self.worldData[y][x] = 3
            end
        end
    end
end

function World:GenCave(caveAmount, iterations, revamps)
    for i = 0, caveAmount-1 do
        CaveX = math.random(1, self.worldWidth)
        CaveY = math.random(1, self.worldHeight)

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

function World:DrawWorld()
    for y = 0, self.worldHeight do
        for x = 0, self.worldWidth do
            if (self.worldX+(x*self.tileSize) > 0-tileSize) 
            and (self.worldX+(x*self.tileSize) < ScreenWidth) 
            and (self.worldY+(y*self.tileSize) > 0-tileSize) 
            and (self.worldY+(y*self.tileSize) < ScreenHeight) then
                if self.worldData[y][x] == 0 then
                    love.graphics.setColor(0.3, 0.3, 0.3)
                end
                if self.worldData[y][x] == 1 then
                    love.graphics.setColor(0, 0, 0)
                end
                if self.worldData[y][x] == 2 then
                    love.graphics.setColor(1.0, 0.0, 0.0)
                end
                if self.worldData[y][x] == 3 then
                    love.graphics.setColor(0.5, 0.5, 0.5)
                end
                love.graphics.rectangle("fill", self.worldX+(x*self.tileSize), self.worldY+(y*self.tileSize), self.tileSize, self.tileSize)
            end
        end
    end
end