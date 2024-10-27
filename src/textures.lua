
function InitTextures()
    love.graphics.setDefaultFilter("nearest", "nearest")
    wallTexture = love.graphics.newImage("assets/tiles/wall.png")
    redniteTexture = love.graphics.newImage("assets/tiles/rednite.png")
    blueniteTexture = love.graphics.newImage("assets/tiles/bluenite.png")
    floorTexture = love.graphics.newImage("assets/tiles/floor.png")
end