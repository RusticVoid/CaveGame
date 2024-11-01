
function InitTextures()
    love.graphics.setDefaultFilter("nearest", "nearest")

    playerTexture = love.graphics.newImage("assets/entities/player.png")
    
    entityTexture = love.graphics.newImage("assets/entities/entity.png")
    runnerTexture = love.graphics.newImage("assets/entities/runner.png")

    airTexture = love.graphics.newImage("assets/tiles/air.png")
    floorTexture = love.graphics.newImage("assets/tiles/floor.png")
    wallTexture = love.graphics.newImage("assets/tiles/wall.png")

    redniteTexture = love.graphics.newImage("assets/tiles/rednite.png")
    blueniteTexture = love.graphics.newImage("assets/tiles/bluenite.png")

    greenGroundTexture = love.graphics.newImage("assets/tiles/greenGround.png")
    
    redGroundTexture = love.graphics.newImage("assets/tiles/redGround.png")
    redWallTexture = love.graphics.newImage("assets/tiles/redWall.png")

    spawnTexture = love.graphics.newImage("assets/tiles/spawn.png")
end