enet = require "enet"

enethost = nil
hostevent = nil
clientpeer = nil

require "player"

function love.load(args)

	-- establish host for receiving msg
	enethost = enet.host_create("localhost:25619")

	players = {}

end

function love.update(dt)
	hostevent = enethost:service(1000)
	
	if hostevent then
		print("Server detected message type: " .. hostevent.type)
		if hostevent.type == "connect" then
			print(hostevent.peer, "connected.")
			table.insert(players, Player.new(hostevent.peer))
		end
		if hostevent.type == "receive" then
			print("Received message: ", hostevent.data, hostevent.peer)
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

				for i = 1, #players do
					if not (players[i].IP == hostevent.peer) then
						for j = 1, #players do
							if players[j].IP == hostevent.peer then
								players[i].IP:send("playerinfo"..":"..players[j].x..":"..players[j].y..":"..j)
							end
						end
					else
						if players[i].IP == hostevent.peer then
							players[i].x = prasedInfo[1]
							players[i].y = prasedInfo[2]
						end
					end
				end
			end
		end
	end
end

function love.draw()
end