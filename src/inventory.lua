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
    for i = 0, self.slotAmount do
        self.inventorySlots[i] = ""
    end

    self.inventorySlots[0] = wallTile
    self.inventorySlots[1] = spawnTile
    self.inventorySlots[2] = rednite
    self.inventorySlots[3] = bluenite
    self.inventorySlots[4] = redWall
    self.inventorySlots[5] = greenGround
    self.inventorySlots[6] = redGround
    self.inventorySlots[7] = floorTile
    
    return self
end

function Inventory:update()
    if InventoryOpen == true then
        row = 0
        column = 0
        for i = 0, #self.inventorySlots do
            if ((self.x+(row*(self.slotSize+self.slotSpacing))+self.slotPadding)+self.slotSize+self.slotSpacing > self.x+(self.width-self.x)) then
                column = column + 1
                row = 0
            end

            if mouseCollid(self.x+(row*(self.slotSize+self.slotSpacing))+self.slotPadding, self.y+(column*(self.slotSize+self.slotSpacing))+self.slotPadding, self.slotSize, self.slotSize) then
                if love.mouse.isDown(1) then
                    if not (self.inventorySlots[i] == "") then
                        player.selectedTile = self.inventorySlots[i]
                        InventoryOpen = false
                    end
                end
            end
            row = row + 1
        end
    end
end

function Inventory:draw()
    love.graphics.setColor(1, 1, 1, 0.5)
    love.graphics.rectangle("fill", self.x, self.y, self.width-self.x, self.height-self.y)

    row = 0
    column = 0
    love.graphics.setColor(1, 1, 1, 0.5)
    for i = 0, #self.inventorySlots do
        if ((self.x+(row*(self.slotSize+self.slotSpacing))+self.slotPadding)+self.slotSize+self.slotSpacing > self.x+(self.width-self.x)) then
            column = column + 1
            row = 0
        end
        
        love.graphics.setColor(1, 1, 1, 0.5)
        love.graphics.rectangle("fill", self.x+(row*(self.slotSize+self.slotSpacing))+self.slotPadding, self.y+(column*(self.slotSize+self.slotSpacing))+self.slotPadding, self.slotSize, self.slotSize)
    
        if not (self.inventorySlots[i] == "") then
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.draw(self.inventorySlots[i].texture, (self.x+(row*(self.slotSize+self.slotSpacing))+self.slotPadding)+10, (self.y+(column*(self.slotSize+self.slotSpacing))+self.slotPadding)+10, 0, tileSize/16)
        end
        row = row + 1
    end

    love.graphics.setColor(1, 1, 1, 1)
end