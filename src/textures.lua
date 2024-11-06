
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
    uraniumTexture = love.graphics.newImage("assets/tiles/uranium.png")
    ironTexture = love.graphics.newImage("assets/tiles/iron.png")

    greenGroundTexture = love.graphics.newImage("assets/tiles/greenGround.png")
    
    redGroundTexture = love.graphics.newImage("assets/tiles/redGround.png")
    redWallTexture = love.graphics.newImage("assets/tiles/redWall.png")

    
    pupGroundTexture = love.graphics.newImage("assets/tiles/pupGround.png")
    pupWallTexture = love.graphics.newImage("assets/tiles/pupWall.png")

    spawnTexture = love.graphics.newImage("assets/tiles/spawn.png")

    craftingStationTexture = love.graphics.newImage("assets/tiles/craftingStation.png")
    nukeTexture = love.graphics.newImage("assets/tiles/nuke.png")

    redniteItemTexture = love.graphics.newImage("assets/items/rednite.png")
    blueniteItemTexture = love.graphics.newImage("assets/items/bluenite.png")
    uraniumItemTexture = love.graphics.newImage("assets/items/uranium.png")
    ironItemTexture = love.graphics.newImage("assets/items/iron.png")
    ironSheetItemTexture = love.graphics.newImage("assets/items/ironSheet.png")
end