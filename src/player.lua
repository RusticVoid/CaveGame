Player = {}
Player.__index = Player

function Player.new(x, y, speed, texture)
    local self = setmetatable({}, Player)
    self.x = x
    self.y = y
    self.speed = speed*tileSize
    self.texture = texture
    self.width, self.height = self.texture:getDimensions()
    self.width = (self.width*tileSize/16)-10
    self.height = (self.height*tileSize/16)-4
    self.collisionPaddingX = 5
    self.collisionPaddingY = 3
    self.size = tileSize/1.5
    self.selectedTile = airTile
    self.selectedTileAmount = 0
    self.holdingTile = false
    return self
end

function Player:draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.texture, self.x, self.y, 0, tileSize/16)
    if debug == true then
        if collisionMode == true then
            love.graphics.setColor(1, 0, 0, 1)
            love.graphics.rectangle("line", self.x+self.collisionPaddingX, self.y+self.collisionPaddingY, self.width, self.height)    
        end
    end
    love.graphics.setColor(1, 1, 1, 1)
end