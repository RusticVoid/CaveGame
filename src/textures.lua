
function InitTextures()
    love.graphics.setDefaultFilter("nearest", "nearest")
    floorTexture = love.graphics.newImage("assets/tiles/floor.png")
    wallTexture = love.graphics.newImage("assets/tiles/wall.png")

    redniteTexture = love.graphics.newImage("assets/tiles/rednite.png")
    blueniteTexture = love.graphics.newImage("assets/tiles/bluenite.png")

    greenGroundTexture = love.graphics.newImage("assets/tiles/greenGround.png")
    
    redGroundTexture = love.graphics.newImage("assets/tiles/redGround.png")
    redWallTexture = love.graphics.newImage("assets/tiles/redWall.png")
end