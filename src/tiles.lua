function InitTiles()
    airTile = Tile.new(airTexture, false, false, true)
    wallTile = Tile.new(wallTexture, true, true, true)
    rednite = Tile.new(redniteTexture, true, true, true)
    bluenite = Tile.new(blueniteTexture, true, true, true)
    redWall = Tile.new(redWallTexture, true, true, true)

    greenGround= Tile.new(greenGroundTexture, false, false, false)
    redGround = Tile.new(redGroundTexture, false, false, false)
    floorTile = Tile.new(floorTexture, false, false, false)
    spawnTile = Tile.new(spawnTexture, false, false, false)

    BorderTile = Tile.new(wallTexture, true, false, true)
end