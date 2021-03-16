local userId, userName, serverIp, serverPort = ...

-- fallback incase loadfile args dont work
if userId == nil then userId = 1 end
if userName == nil then userName = "Player" end
if serverIp == nil then serverIp = "localhost" end
if serverPort == nil then serverPort = 53640 end

-- functions --------------------------
function onPlayerAdded(player)
	-- override
end

-- MultiplayerSharedScript.lua inserted here ------ Prepended to Join.lua --

-- arguments ---------------------------------------
local threadSleepTime = ...

if threadSleepTime==nil then
	threadSleepTime = 15
end

local test = false

print("! Joining game '' place -1 at " .. serverIp)

local waitingForCharacter = false
pcall( function()
	if settings().Network.MtuOverride == 0 then
	  settings().Network.MtuOverride = 1400
	end
end)


-- globals -----------------------------------------

client = game:service("NetworkClient")
visit = game:service("Visit")

-- functions ---------------------------------------
function reportError(err)
	print("***ERROR*** " .. err)
	if not test then visit:setUploadUrl("") end
	client:disconnect()
	--wait(4)
	game:SetMessage("Error: " .. err)
end

-- called when the client connection closes
function onDisconnection(peer, lostConnection)
	if lostConnection then
		game:SetMessage("You have lost the connection to the game")
	else
		game:SetMessage("This game has shut down")
	end
end

function requestCharacter(replicator)
	
	-- prepare code for when the Character appears
	local connection
	connection = player.Changed:connect(function (property)
		if property=="Character" then
			game:ClearMessage()
			waitingForCharacter = false
			
			connection:disconnect()
		end
	end)
	
	game:SetMessage("Requesting character")

	local success, err = pcall(function()	
		replicator:RequestCharacter()
		game:SetMessage("Waiting for character")
		waitingForCharacter = true
	end)
	if not success then
		reportError(err)
		return
	end
end

-- called when the client connection is established
function onConnectionAccepted(url, replicator)

	local waitingForMarker = true
	
	local success, err = pcall(function()	
		if not test then 
		    visit:setPing("", 300) 
		end
		
		game:SetMessageBrickCount()

		replicator.Disconnection:connect(onDisconnection)
		
		-- Wait for a marker to return before creating the Player
		local marker = replicator:SendMarker()
		
		marker.Received:connect(function()
			waitingForMarker = false
			requestCharacter(replicator)
		end)
	end)
	
	if not success then
		reportError(err)
		return
	end
	
	-- TODO: report marker progress
	
	while waitingForMarker do
		workspace:ZoomToExtents()
		wait(0.5)
	end
end

-- called when the client connection fails
function onConnectionFailed(_, error)
	game:SetMessage("Failed to connect to the Game. (ID=" .. error .. ")")
end

-- called when the client connection is rejected
function onConnectionRejected()
	connectionFailed:disconnect()
	game:SetMessage("This game is not available. Please try another")
end


-- main ------------------------------------------------------------

local success, err = pcall(function()	

	game:SetMessage("Connecting to Server")
	client.ConnectionAccepted:connect(onConnectionAccepted)
	client.ConnectionRejected:connect(onConnectionRejected)
	connectionFailed = client.ConnectionFailed:connect(onConnectionFailed)
	
	player = game:service("Players"):createLocalPlayer(userId)
	client:connect(serverIp, serverPort, 0, threadSleepTime)

	player:SetSuperSafeChat(false)
	player:SetUnder13(false)
	player:SetAdminMode(true)
	
	-- Overriden
	onPlayerAdded(player)
	
	pcall(function() player.Name = userName end)
	player.CharacterAppearance = ""	
	if not test then visit:setUploadUrl("") end
end)

if not success then
	reportError(err)
end