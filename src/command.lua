
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
    parseCommand = {""}
    j = 1
    for i = 1, #textBox do
        if textBox[i] == " " then
            j = j + 1
            parseCommand[j] = ""
        else
            parseCommand[j] = parseCommand[j]..textBox[i]
        end
    end
    if parseCommand[1] == "/tp" then
        world.x = -((((parseCommand[2]*ChunkSize)*tileSize)+(1*tileSize)-(windowWidth/2)))
        world.y = -((((parseCommand[3]*ChunkSize)*tileSize)+(1*tileSize)-(windowHeight/2)))
    end
end