require "utils"
require "textures"
require "world"
require "tile"
require "player"
require "command"
require "inventory"
require "tiles"
require "entity"

enet = require "enet"

enethost = nil
hostevent = nil
clientpeer = nil

function love.load()

	enethost = enet.host_create()
    server = enethost:connect("localhost:25619")
    
    windowWidth, windowHeight = love.window.getMode()

    fps = 0
    debug = false
    commandMode = false
    chunkMode = false
    collisionMode = false
    creativeMode = false
    noclip = false
    textBox = {}

    OnlineMode = true

    WorldSize = 64

    print("Welcome To Subterranean By Homeless Studios")
    print("Develper: RusticVoid")
    print("Writer: DogWoodDan, Large_man")
    print("Soon to be artist: Orange_Aide")
    print("Right now artist: RusticVoid")
    print("")
    print("LINKS:")
    print("Github: https://github.com/RusticVoid/Subterranean")
    print("Itch: https://homelessstudios.itch.io/subterranean")
    print("")
    print("Pick a number for an option")
    print("1: Start")
    print("2: Quit")
    option = io.read()

    if option == "1" then
        print("")
        print("World Size:")
        print("1: Small (64x64 in chunks, 1024x1024 in tiles)")
        print("2: Medium (128x128 in chunks, 2048x2048 in tiles)")
        print("3: Large (256x256 in chunks, 4096x4096 in tiles)")
        option = io.read()
        if option == "1" then
            WorldSize = 64
        end
        if option == "2" then
            WorldSize = 128
        end
        if option == "3" then
            WorldSize = 256
        end
        
        print("")
        print("Game Mode:")
        print("1: default")
        print("2: creative")
        option = io.read()
        if option == "1" then
            creativeMode = false
        end
        if option == "2" then
            creativeMode = true
        end
    else
        if option == "2" then
            print("Give it a second!")
            love.event.quit()
        end
    end

    print("")
    print("STARTING WORLD GEN!")

    print("SETTING RANDOM SEED!")
    math.randomseed(os.clock())

    print("SETTING TILE SIZE!")
    tileSize = 30

    print("INITIALIZING TEXTURES!")
    InitTextures()

    print("INITIALIZING TILES!")
    InitTiles()

    print("CREATING WORLD!")
    world = World.new(WorldSize)
    world:genWorld()

    print("GENERATING CAVES!")
    world:genCave(500, 2000)
    
    print("SPAWNING PLAYER!")
    
    player = Player.new((windowWidth/2)-(tileSize/1.5), (windowHeight/2)-(tileSize/1.5), 8, playerTexture)
    InventoryOpen = false
    inventory = Inventory.new(30, 30, 800-30, 600-30)

    spawned = false
    while spawned == false do
        ChunkX = math.random(1, world.size)
        ChunkY = math.random(1, world.size)
        ChunkSize = world.chunks[ChunkX][ChunkY].size
        SpawnX = math.random(1, ChunkSize)
        SpawnY = math.random(1, ChunkSize)

        if world.chunks[ChunkY][ChunkX].topChunkData[SpawnY][SpawnX] == airTile then
            world.chunks[ChunkY][ChunkX].bottomChunkData[SpawnY][SpawnX] = spawnTile
            spawned = true
            world.x = -(((ChunkX*ChunkSize)*tileSize)+(SpawnX*tileSize)-(windowWidth/2+(player.width/2)))
            world.y = -(((ChunkY*ChunkSize)*tileSize)+(SpawnY*tileSize)-(windowHeight/2+(player.height/2)))-player.collisionPaddingY+2
        end
    end

    print("WORLD GEN DONE!")

    entities = {}

    now = os.clock()
end

function love.update(dt)
    DeltaTime = dt
    fps = love.timer.getFPS()
    MouseX = love.mouse.getX()
    MouseY = love.mouse.getY()

    windowWidth, windowHeight = love.window.getMode()

    prevPlayerX = world.x
    prevPlayerY = world.y
    moved = false
    if commandMode == false then
        if love.keyboard.isDown("w") then
            world.y = world.y + player.speed * DeltaTime
        end
        if love.keyboard.isDown("a") then
            world.x = world.x + player.speed * DeltaTime
        end
        if love.keyboard.isDown("s") then
            world.y = world.y - player.speed * DeltaTime
        end
        if love.keyboard.isDown("d") then
            world.x = world.x - player.speed * DeltaTime
        end
    end

    world:update()
    inventory:update()

    if OnlineMode == true then
        ServerListen()
    end
end

function ServerListen()
    hostevent = enethost:service(1)
    
    if hostevent then
        print("Server detected message type: " .. hostevent.type)
        if hostevent.type == "connect" then 
            print(hostevent.peer, "connected.")
        end
        if hostevent.type == "receive" then
            if hostevent.data:sub(1, 10) == "playerinfo" then
                prasedInfo = {""}
                j = 1
                for i = 12, string.len(hostevent.data) do
                    if hostevent.data:sub(i, i) == ":" then
                        j = j + 1
                        prasedInfo[j] = ""
                    else
                        prasedInfo[j] = prasedInfo[j]..hostevent.data:sub(i, i)
                    end
                end

                foundEntity = false
                for i = 1, #entities do
                    if tonumber(prasedInfo[3]) == i then
                        entities[i].x = prasedInfo[1]
                        entities[i].y = prasedInfo[2]
                        foundEntity = true
                        break
                    end
                end

                if foundEntity == false then
                    table.insert(entities, Entity.new(prasedInfo[1], prasedInfo[2], playerTexture))
                end
            end
        end
    end

    if (not ((lastX == -world.x+player.x) and (lastY == -world.y+player.y))) or (os.clock() > now+5) then
        server:send("playerinfo"..":"..-world.x+player.x..":"..-world.y+player.y)
        lastX = -world.x+player.x
        lastY = -world.y+player.y
        now = os.clock()
    end
end

function love.keypressed(key)
    if key == "escape" then
        if InventoryOpen == true then
            InventoryOpen = false
        end
    end
    if key == "i" then
        InventoryOpen = not InventoryOpen
    end
    if key == "f1" then
        debug = not debug
    end
    if debug == true then
        if key == "f2" then
            chunkMode = not chunkMode
        end
        if key == "f3" then
            collisionMode = not collisionMode
        end
        if key == "f4" then
            noclip = not noclip
        end
        if key == "f5" then
            InitTextures()
        end
        if key == "f6" then
            table.insert(entities, Entity.new(player.x-world.x, player.y-world.y, entityTexture))
        end
        if key == "/" then
            commandMode = true
        end
    end
    if commandMode == true then
        textBoxInput(key)
    end
end

function love.draw()
    world:draw()
    love.graphics.print("FPS: "..fps)

    if debug == true then
        love.graphics.print("Player X:"..-math.floor(((world.x-player.x)/tileSize)/16)-1, 0, 15)
        love.graphics.print("Player Y:"..-math.floor(((world.y-player.y)/tileSize)/16)-1, 0, 30)
        love.graphics.print("noclip:"..tostring(noclip), 0, 45)

        if commandMode == true then
            love.graphics.setColor(0.5, 0.5, 0.5, 0.5)
            love.graphics.rectangle("fill", 0, windowHeight-26, windowWidth, 17)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.print(textBox, 0, windowHeight-25)
        end
    end

    for i = 1, #entities do
        entities[i]:draw()
    end

    player:draw()

    if InventoryOpen == true then
        inventory:draw()
    end
end
