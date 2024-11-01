Player = {}
Player.__index = Player

function Player.new(IP)
    local self = setmetatable({}, Player)
    self.IP = IP
    self.x = 0
    self.y = 0
    self.texture = 0
    return self
end