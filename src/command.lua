
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
end