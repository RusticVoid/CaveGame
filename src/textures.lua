
function InitTextures()
    love.graphics.setDefaultFilter("nearest", "nearest")
    wallTexture = love.graphics.newImage("assets/tiles/wall.png")
    redniteTexture = love.graphics.newImage("assets/tiles/rednite.png")
    blueniteTexture = love.graphics.newImage("assets/tiles/bluenite.png")
    floorTexture = love.graphics.newImage("assets/tiles/floor.png")
    greenGroundTexture = love.graphics.newImage("assets/tiles/greenGround.png")
    redGroundTexture = love.graphics.newImage("assets/tiles/redGround.png")
end