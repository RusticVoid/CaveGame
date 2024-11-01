require "tile"

Chunk = {}
Chunk.__index = Chunk

function Chunk.new(x, y, size)
    local self = setmetatable({}, Chunk)
    self.x = x*size
    self.y = y*size
    self.size = size
    self.topChunkData = {}
    self.bottomChunkData = {}

    for y = 1, self.size do
        self.topChunkData[y] = {}
        for x = 1, self.size do
            self.topChunkData[y][x] = wallTile
        end
    end

    for y = 1, self.size do
        self.bottomChunkData[y] = {}
        for x = 1, self.size do
            self.bottomChunkData[y][x] = floorTile
        end
    end

    return self
end

function Chunk:update(WorldX, WorldY)
    for y = 1, self.size do
        for x = 1, self.size do
            if self.topChunkData[y][x]:inWindow((WorldX+self.x*tileSize), (WorldY+self.y*tileSize), x-1, y-1) then
                if mouseCollid((WorldX+self.x*tileSize)+(x-1)*tileSize, (WorldY+self.y*tileSize)+(y-1)*tileSize, tileSize, tileSize) then
                    if not (InventoryOpen == true) then
                        if love.mouse.isDown(1) then
                            if self.topChunkData[y][x].breakable == true then
                                foundSlot = false
                                for column = 0, 5 do
                                    for row = 0, 10 do
                                        for i = 0, inventory.stackSize do
                                            if inventory.inventorySlots[column][row][i] == 0 then
                                                if creativeMode == false then
                                                    inventory.inventorySlots[column][row][i] = self.topChunkData[y][x]
                                                end
                                                self.topChunkData[y][x] = airTile
                                                foundSlot = true
                                                break
                                            end
                                        end
                                        if foundSlot == true then
                                            break
                                        end
                                    end
                                    if foundSlot == true then
                                        break
                                    end
                                end
                            end
                        end
                        if love.mouse.isDown(2) then
                            if self.topChunkData[y][x] == airTile then
                                foundSlot = false
                                for column = 0, 5 do
                                    for row = 0, 10 do
                                        for i = 0, inventory.stackSize do
                                            if inventory.inventorySlots[column][row][i] == player.selectedTile then
                                                if creativeMode == false then
                                                    inventory.inventorySlots[column][row][i] = 0
                                                end
                                                if player.selectedTile.topTile == true then
                                                    self.topChunkData[y][x] = player.selectedTile
                                                else 
                                                    self.bottomChunkData[y][x] = player.selectedTile
                                                end
                                                foundSlot = true
                                                break
                                            end
                                        end
                                        if foundSlot == true then
                                            break
                                        end
                                    end
                                    if foundSlot == true then
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
                if (noclip == false) then
                    if self.topChunkData[y][x].hasCollision == true then
                        if collid(player.x+player.collisionPaddingX, player.y+player.collisionPaddingY, player.width, player.height, ((WorldX+self.x*tileSize)+(x-1)*tileSize), (WorldY+self.y*tileSize)+(y-1)*tileSize, tileSize, tileSize) then
                            world.x = prevPlayerX
                            world.y = prevPlayerY
                        end
                    end
                end
            end
        end
    end
end

function Chunk:draw(WorldX, WorldY)
    for y = 1, self.size do
        for x = 1, self.size do
            love.graphics.setColor(1, 1, 1)
            if self.topChunkData[y][x]:inWindow((WorldX+self.x*tileSize), (WorldY+self.y*tileSize), x-1, y-1) then
                if self.topChunkData[y][x] == airTile then
                    love.graphics.draw(self.bottomChunkData[y][x].texture, (WorldX+self.x*tileSize)+(x-1)*tileSize, (WorldY+self.y*tileSize)+(y-1)*tileSize, 0, tileSize/16)
                else
                    love.graphics.draw(self.topChunkData[y][x].texture, (WorldX+self.x*tileSize)+(x-1)*tileSize, (WorldY+self.y*tileSize)+(y-1)*tileSize, 0, tileSize/16)
                end
                if debug == true then
                    if collisionMode == true then
                        if self.topChunkData[y][x].hasCollision == true then
                            love.graphics.setColor(1, 0, 0)
                            love.graphics.rectangle("line", ((WorldX+self.x*tileSize)+(x-1)*tileSize)+1, ((WorldY+self.y*tileSize)+(y-1)*tileSize)+1, tileSize-1, tileSize-1)
                        else
                            love.graphics.setColor(1, 1, 0)
                            love.graphics.rectangle("line", ((WorldX+self.x*tileSize)+(x-1)*tileSize)+1, ((WorldY+self.y*tileSize)+(y-1)*tileSize)+1, tileSize-1, tileSize-1)
                        end
                    end
                end
                
            end
        end
    end
    love.graphics.setColor(1, 1, 1)
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