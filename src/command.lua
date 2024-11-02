
function textBoxInput(key)
    if (key == "escape") then
        commandMode = false
        textBox = {}
    else 
        if (key == "return") then
            doCommand()
            commandMode = false
            textBox = {}
        else
            if (key == "backspace") then
                table.remove(textBox, #textBox)
            else
                if (key == "space") then
                    table.insert(textBox, " ")
                else
                    table.insert(textBox, key)
                end
            end
        end
    end
end

function doCommand()
    parsedCommand = parseListString(textBox)

    if parsedCommand[1] == "/tp" then
        world.x = -((((parsedCommand[2]*ChunkSize)*tileSize)+(1*tileSize)-(windowWidth/2)))
        world.y = -((((parsedCommand[3]*ChunkSize)*tileSize)+(1*tileSize)-(windowHeight/2)))
    end

    if parsedCommand[1] == "/findbiome" then
        foundBiome = false
        for ChunkY = 1, world.size do
            for ChunkX = 1, world.size do
                for TileY = 1, world.chunks[ChunkY][ChunkX].size do
                    for TileX = 1, world.chunks[ChunkY][ChunkX].size do
                        if (world.chunks[ChunkY][ChunkX].topChunkData[TileY][TileX] == Biomes[tonumber(parsedCommand[2])][1]) and (world.chunks[ChunkY][ChunkX].bottomChunkData[TileY][TileX] == Biomes[tonumber(parsedCommand[2])][2]) then
                            print("FOUND BIOME: "..ChunkX..":"..ChunkY)
                            foundBiome = true
                            break
                        end
                    end
                    if foundBiome == true then
                        break
                    end
                end
                if foundBiome == true then
                    break
                end
            end
            if foundBiome == true then
                break
            end
        end
    end
end