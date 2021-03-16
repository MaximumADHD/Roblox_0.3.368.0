local Visit = game:service("Visit")
local Players = game:service("Players")
local NetworkClient = game:service("NetworkClient")

local function onConnectionRejected()
	game:SetMessage("This game is not available. Please try another")
end

local function onConnectionFailed(_, id, reason)
	game:SetMessage("Failed to connect to the Game. (ID=" .. id .. ", " .. reason .. ")")
end

local function onConnectionAccepted(peer, replicator)
	local worldReceiver = replicator:SendMarker()
	local received = false
	
	local function onWorldReceived()
		received = true
	end
	
	worldReceiver.Received:connect(onWorldReceived)
	game:SetMessageBrickCount()
	
	while not received do
		workspace:ZoomToExtents()
		wait(0.5)
	end
	
	local player = Players.LocalPlayer
	game:SetMessage("Requesting character")
	
	replicator:RequestCharacter()
	game:SetMessage("Waiting for character")
	
	while not player.Character do
		player.Changed:wait()
	end
	
	game:ClearMessage()
end

NetworkClient.ConnectionAccepted:connect(onConnectionAccepted)
NetworkClient.ConnectionRejected:connect(onConnectionRejected)
NetworkClient.ConnectionFailed:connect(onConnectionFailed)

game:SetMessage("Connecting to Server")

local success, errorMsg = pcall(function ()
	local player = Players.LocalPlayer
	
	if not player then
		player = Players:createLocalPlayer(0)
	end
	
	NetworkClient:connect("localhost", 53640, 0)
end)

if not success then
	game:SetMessage(errorMsg)
end
