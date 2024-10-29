--MAKE COLLISION STUFF OR SOMTHING

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

-- ADD SLEEP FUNCTION PROBABLY NEED