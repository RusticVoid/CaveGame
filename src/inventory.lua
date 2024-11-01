Inventory = {}
Inventory.__index = Inventory

function Inventory.new(x, y, width, height)
    local self = setmetatable({}, Inventory)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.inventorySlots = {}
    self.slotSpacing = 15
    self.slotPadding = 20
    self.slotAmount = 65
    self.slotSize = 50
    self.stackSize = 99
    for column = 0, 5 do
        self.inventorySlots[column] = {}
        for row = 0, 10 do
            self.inventorySlots[column][row] = {}
            for i = 0, self.stackSize do
                self.inventorySlots[column][row][i] = 0
            end
        end
    end

    if creativeMode == true then
        self.inventorySlots[0][0][0] = wallTile
        self.inventorySlots[0][1][0] = spawnTile
        self.inventorySlots[0][2][0] = rednite
        self.inventorySlots[0][3][0] = bluenite
        self.inventorySlots[0][4][0] = redWall
        self.inventorySlots[0][5][0] = greenGround
        self.inventorySlots[0][6][0] = redGround
        self.inventorySlots[0][7][0] = floorTile
    end
    
    return self
end

function Inventory:update()
    if InventoryOpen == true then
        for column = 0, 5 do
            for row = 0, 10 do
                if mouseCollid(self.x+(row*(self.slotSize+self.slotSpacing))+self.slotPadding, self.y+(column*(self.slotSize+self.slotSpacing))+self.slotPadding, self.slotSize, self.slotSize) then
                    if love.mouse.isDown(1) then
                        for i = 0, self.stackSize do
                            if not (self.inventorySlots[column][row][i] == 0) then
                                player.selectedTile = self.inventorySlots[column][row][i]
                            else
                                print("empty")
                                InventoryOpen = false
                                break
                            end
                        end
                    end
                end
            end
        end
    end
end

function Inventory:draw()
    love.graphics.setColor(1, 1, 1, 0.5)
    love.graphics.rectangle("fill", self.x, self.y, self.width-self.x, self.height-self.y)

    for column = 0, 5 do
        for row = 0, 10 do
            love.graphics.setColor(1, 1, 1, 0.5)
            love.graphics.rectangle("fill", self.x+(row*(self.slotSize+self.slotSpacing))+self.slotPadding, self.y+(column*(self.slotSize+self.slotSpacing))+self.slotPadding, self.slotSize, self.slotSize)
            stackAmount = 0
            for i = 0, self.stackSize do
                if not (self.inventorySlots[column][row][i] == 0) then
                    stackAmount = stackAmount + 1
                    love.graphics.setColor(1, 1, 1, 1)
                    love.graphics.draw(inventory.inventorySlots[column][row][i].texture, self.x+(row*(self.slotSize+self.slotSpacing))+self.slotPadding, self.y+(column*(self.slotSize+self.slotSpacing))+self.slotPadding, 0, tileSize/16)    
                    love.graphics.print(stackAmount, self.x+(row*(self.slotSize+self.slotSpacing))+self.slotPadding, self.y+(column*(self.slotSize+self.slotSpacing))+self.slotPadding)
                end
            end
        end
    end

    love.graphics.setColor(1, 1, 1, 1)
end