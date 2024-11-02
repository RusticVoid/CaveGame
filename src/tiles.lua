function InitTiles()
    airTile = Tile.new(airTexture, false, false, true)
    wallTile = Tile.new(wallTexture, true, true, true)
    floorTile = Tile.new(floorTexture, false, false, false)
    spawnTile = Tile.new(spawnTexture, false, false, false)


    redWall = Tile.new(redWallTexture, true, true, true)
    redGround = Tile.new(redGroundTexture, false, false, false)
    RedBiome = {redWall, redGround}

    greenGround = Tile.new(greenGroundTexture, false, false, false)
    GreenBiome = {wallTile, greenGround}

    pupWall = Tile.new(pupWallTexture, true, true, true)
    pupGround = Tile.new(pupGroundTexture, false, false, false)
    pupBiome = {pupWall, pupGround}

    Biomes = {RedBiome, GreenBiome, pupBiome}
    
    rednite = Tile.new(redniteTexture, true, true, true)
    bluenite = Tile.new(blueniteTexture, true, true, true)

    Ores = {rednite, bluenite}
end