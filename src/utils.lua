function collid(x1, y1, sizeX1, sizeY1, x2, y2, sizeX2, sizeY2)
    collided = false

    if (x1 < x2+sizeX2)
    and (x1+sizeX1 > x2)
    and (y1 < y2+sizeY2)
    and (y1+sizeY1 > y2) then
        collided = true
    end

    return collided
end

function mouseCollid(x, y, sizeX, sizeY)
    collided = false

    collid(MouseX, MouseY, 1, 1, x, y, sizeX, sizeY)

    return collided
end

function parseListString(stringList)
    local parsedCommand = {""}
    j = 1
    for i = 1, #stringList do
        if stringList[i] == " " then
            j = j + 1
            parsedCommand[j] = ""
        else
            parsedCommand[j] = parsedCommand[j]..stringList[i]
        end
    end
    return parsedCommand
end

-- ADD SLEEP FUNCTION PROBABLY NEED