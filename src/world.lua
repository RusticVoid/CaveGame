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
    for Height = 0, self.worldHeight do
        self.worldData[Height] = {}
        for Width = 0, self.worldWidth do
            self.worldData[Height][Width] = 1
        end
    end
end

function World:GenCave(caveAmount, iterations)
    for i = 0, caveAmount-1 do
        CaveX = math.random(1, self.worldWidth)
        CaveY = math.random(1, self.worldHeight)

        for j = 0, iterations-1 do
            decision = math.random(1, 4)
            
            if decision == 1 then
                CaveX = CaveX + 1;
                if (CaveX > world.worldWidth) then
                    CaveX = CaveX - 1;
                end
            end
            if decision == 2 then
                CaveX = CaveX - 1;
                if (CaveX < 0) then
                    CaveX = CaveX + 1;
                end
            end
            if decision == 3 then
                CaveY = CaveY + 1;
                if (CaveY > world.worldHeight) then
                    CaveY = CaveY - 1;
                end
            end
            if decision == 4 then
                CaveY = CaveY - 1;
                if (CaveY < 0) then
                    CaveY = CaveY + 1;
                end
            end

            self.worldData[CaveY][CaveX] = 0
        end
    end
end

function World:DrawWorld()
    for Height = 0, self.worldHeight do
        for Width = 0, self.worldWidth do
            if self.worldData[Height][Width] == 1 then
                love.graphics.setColor(0.2, 0.7, 0.2)
            end
            if self.worldData[Height][Width] == 0 then
                love.graphics.setColor(0.1, 0.1, 0.1)
            end
            love.graphics.rectangle("fill", Height*self.tileSize, Width*self.tileSize, self.tileSize, self.tileSize)
        end
    end
end