function CraftingStationInit()
    craftingStationOpen = false

    Slots = {{{0},{0},{0}},
             {{0},{0},{0}}}

    for y = 1, #Slots do
        for x = 1, #Slots[y] do
            for i = 0, inventory.stackSize do
                Slots[y][x][i] = 0
            end
        end
    end

    for i = 0, inventory.stackSize do
        Slots[1][1][i] = 1
        Slots[2][2][i] = 1
        Slots[1][3][i] = 1
    end

end

function OpenCraftingStation()
    InventoryOpen = true
    craftingStationOpen = true
    otherUI = true
end
function CloseCraftingStation()
    InventoryOpen = false
    craftingStationOpen = false
    otherUI = false
end

function UpdateCraftingStation()
    for y = 1, #Slots do
        for x = 1, #Slots[y] do
            if not (Slots[y][x] == 0) then
                if mouseCollid(inventory.width-220+((x-1)*(inventory.slotSize+inventory.slotSpacing))+inventory.slotPadding, inventory.height-150+((y-1)*(inventory.slotSize+inventory.slotSpacing))+inventory.slotPadding, inventory.slotSize, inventory.slotSize) then
                    if love.mouse.isDown(2) then
                        if os.clock() > now+0.1 then
                            now = os.clock()
                            if player.holdingTile == false then
                                stackAmount = 0
                                for i = 0, inventory.stackSize do
                                    if not (Slots[y][x][i] == 1) then
                                        stackAmount = stackAmount + 1
                                        player.selectedTile = Slots[y][x][i]
                                        Slots[y][x][i] = 1
                                    end
                                end
                                if stackAmount > 0 then
                                    player.holdingTile = true
                                    player.selectedTileAmount = stackAmount
                                end
                            else
                                while player.holdingTile do
                                    if Slots[y][x][0] == 0 then
                                        break
                                    end
                                    if Slots[y][x][0] == 1 then
                                        player.selectedTileAmount = player.selectedTileAmount - 1
                                        Slots[y][x][0] = player.selectedTile
                                        if (player.selectedTileAmount == 0) then
                                            player.holdingTile = false
                                            break
                                        end
                                        if love.keyboard.isDown("lshift") then
                                            break
                                        end
                                    else
                                        if Slots[y][x][0] == player.selectedTile then
                                            j = 0
                                            for i = 0, inventory.stackSize do
                                                if Slots[y][x][i] == 1 then
                                                    j = j + 1
                                                    player.selectedTileAmount = player.selectedTileAmount - 1
                                                    Slots[y][x][i] = player.selectedTile
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
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            end

            for i = 0, inventory.stackSize do
                if Slots[1][1][i] == rednite then
                    Slots[1][1][i] = 1
                    Slots[2][2][i] = redniteItem
                end

                if Slots[1][1][i] == bluenite then
                    Slots[1][1][i] = 1
                    Slots[2][2][i] = blueniteItem
                end

                if Slots[1][1][i] == uranium then
                    Slots[1][1][i] = 1
                    Slots[2][2][i] = uraniumItem
                end

                if Slots[1][1][i] == iron then
                    Slots[1][1][i] = 1
                    Slots[2][2][i] = ironItem
                end

                if Slots[1][1][i] == ironItem then
                    Slots[1][1][i] = 1
                    Slots[2][2][i] = ironSheetItem
                end

                if Slots[1][1][i] == ironSheetItem then
                    if Slots[1][3][i] == uraniumItem then
                        Slots[1][1][i] = 1
                        Slots[1][3][i] = 1
                        Slots[2][2][i] = nukeTile
                    end
                end
            end
        end
    end
end

function DrawCraftingStationUI()
    if craftingStationOpen == true then
        love.graphics.setColor(1, 1, 1, 0.5)
        love.graphics.rectangle("fill", inventory.width-150, inventory.height-114, 30+inventory.slotSize, 16)
        love.graphics.rectangle("fill", inventory.width-117, inventory.height-98, 16, 33)

        for y = 1, #Slots do
            for x = 1, #Slots[y] do
                if not (Slots[y][x][0] == 0) then
                    love.graphics.setColor(1, 1, 1, 0.5)
                    love.graphics.rectangle("fill", inventory.width-220+((x-1)*(inventory.slotSize+inventory.slotSpacing))+inventory.slotPadding, inventory.height-150+((y-1)*(inventory.slotSize+inventory.slotSpacing))+inventory.slotPadding, inventory.slotSize, inventory.slotSize)
                    stackAmount = 0
                    for i = 0, inventory.stackSize do
                        if not (Slots[y][x][i] == 1) then
                            stackAmount = stackAmount + 1
                            love.graphics.setColor(1, 1, 1, 1)
                            love.graphics.draw(Slots[y][x][i].texture, inventory.width-220+((x-1)*(inventory.slotSize+inventory.slotSpacing))+inventory.slotPadding+10, inventory.height-150+((y-1)*(inventory.slotSize+inventory.slotSpacing))+inventory.slotPadding+10, 0, tileSize/16)
                        end
                    end
                    love.graphics.setColor(1, 1, 1, 1)
                    love.graphics.print(stackAmount, inventory.width-220+((x-1)*(inventory.slotSize+inventory.slotSpacing))+inventory.slotPadding+10, inventory.height-150+((y-1)*(inventory.slotSize+inventory.slotSpacing))+inventory.slotPadding+10)
                end
            end
        end
    end
end