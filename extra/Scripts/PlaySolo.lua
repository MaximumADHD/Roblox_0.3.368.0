-- Services
local Visit = game:service("Visit")
local Players = game:service("Players")
local RunService = game:service("RunService")

-- Create Player
local player = game.Players.LocalPlayer

if not player then
	player = game.Players:createLocalPlayer(0)
end

local function waitForChild(parent,childName)
	local child
	
	while true do
		child = parent:findFirstChild(childName)
		
		if child then
			break
		else
			parent.ChildAdded:wait()
		end
	end
	
	return child
end

local function onChanged(property)
	if property == "Character" then
		local humanoid = waitForChild(player.Character, "Humanoid")
		
		humanoid.Died:connect(function ()
			wait(5)
			player:LoadCharacter()
		end)
	end
end

player.Changed:connect(onChanged)
player:LoadCharacter()

-- Start the game.
RunService:run()
