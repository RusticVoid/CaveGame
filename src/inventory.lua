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
        self.inventorySlots[0][8][0] = pupGround
        self.inventorySlots[0][9][0] = pupWall
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
                                InventoryOpen = false
                                break
                            end
                        end
                    end
                    if love.mouse.isDown(2) then
                        if os.clock() > now+0.1 then
                            now = os.clock()
                            if player.holdingTile == false then
                                stackAmount = 0
                                for i = 0, self.stackSize do
                                    if not (self.inventorySlots[column][row][i] == 0) then
                                        stackAmount = stackAmount + 1
                                        player.selectedTile = self.inventorySlots[column][row][i]
                                        self.inventorySlots[column][row][i] = 0
                                    end
                                end
                                if stackAmount > 0 then
                                    player.holdingTile = true
                                    player.selectedTileAmount = stackAmount
                                end
                            else
                                while player.holdingTile do
                                    if inventory.inventorySlots[column][row][0] == 0 then
                                        player.selectedTileAmount = player.selectedTileAmount - 1
                                        inventory.inventorySlots[column][row][0] = player.selectedTile
                                        if (player.selectedTileAmount == 0) then
                                            player.holdingTile = false
                                            break
                                        end
                                        if love.keyboard.isDown("lshift") then
                                            break
                                        end
                                    else
                                        if inventory.inventorySlots[column][row][0] == player.selectedTile then
                                            j = 0
                                            for i = 0, inventory.stackSize do
                                                if inventory.inventorySlots[column][row][i] == 0 then
                                                    j = j + 1
                                                    player.selectedTileAmount = player.selectedTileAmount - 1
                                                    inventory.inventorySlots[column][row][i] = player.selectedTile
                                                    if (player.selectedTileAmount == 0) then
                                                        player.holdingTile = false
                                                        break
                                                    end
                                                    if love.keyboard.isDown("lshift") then
                                                        break
                                                    end
                                                end
                                            end
                                            break
                                        end
                                    end
                                end
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
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.print("Mouse-1 to select block", self.x, self.height-100)
    love.graphics.print("Mouse-2 to grab block", self.x, self.height-85)
    love.graphics.print("left-shift + Mouse-2 to put down 1 block", self.x, self.height-70)

    for column = 0, 5 do
        for row = 0, 10 do
            love.graphics.setColor(1, 1, 1, 0.5)
            love.graphics.rectangle("fill", self.x+(row*(self.slotSize+self.slotSpacing))+self.slotPadding, self.y+(column*(self.slotSize+self.slotSpacing))+self.slotPadding, self.slotSize, self.slotSize)
            stackAmount = 0
            for i = 0, self.stackSize do
                if not (self.inventorySlots[column][row][i] == 0) then
                    stackAmount = stackAmount + 1
                    love.graphics.setColor(1, 1, 1, 1)
                    love.graphics.draw(inventory.inventorySlots[column][row][i].texture, self.x+(row*(self.slotSize+self.slotSpacing))+self.slotPadding+10, self.y+(column*(self.slotSize+self.slotSpacing))+self.slotPadding+10, 0, tileSize/16)    
                    love.graphics.print(stackAmount, self.x+(row*(self.slotSize+self.slotSpacing))+self.slotPadding+10, self.y+(column*(self.slotSize+self.slotSpacing))+self.slotPadding+10)
                end
            end
        end
    end

    love.graphics.setColor(1, 1, 1, 1)
    if not (player.selectedTileAmount == 0) then
        love.graphics.draw(player.selectedTile.texture, MouseX-10, MouseY-10, 0, tileSize/16)
        love.graphics.print(player.selectedTileAmount, MouseX-10, MouseY-10)
    end

    love.graphics.setColor(1, 1, 1, 1)
end