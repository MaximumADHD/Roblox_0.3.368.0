# Roblox 0.3.368.0

This is a newly discovered build of Roblox, compiled in March of 2007.<br/>
To run the client, download this repository as a zip and extract it.<br/>
The executable can be found in the `client` folder!

# Requirements #

For this to execute correctly, you need to make sure your system has the `Microsoft Visual C++ 2005 Service Pack` installed. This pack was standard in most older systems, but newer systems are no longer bundled with it.<br/>

You can find it here:<br/>
https://www.microsoft.com/en-us/download/details.aspx?id=26347

**(Note**: You will need the x86 pack. It may also help to have the x64 pack as well.)

# WARNING: DO NOT CONNECT TO UNTRUSTED SERVERS #

This build does support hosting and connecting to servers, but there's a non-zero chance this build has exploitable bugs that can be used for **remote code execution** on your machine.<br/>
If you do try and take advantage of the multiplayer functionality in this build, make sure you only connect to servers that are trustworthy. Otherwise it isn't worth doing.<br/>
You have been warned, be smart and have fun :)!

# Download Link #
https://github.com/CloneTrooper1019/Roblox_0.3.368.0/archive/master.zip

# Basic Commands #

You can enable the command bar by navigating to the bar at the top of the screen and clicking `View -> Toolbars -> Command`
Here are some basic commands that can be used to do various things in this build:

## Opening Places ##

* Open Crossroads:<br/>
`game:load("rbxasset://../../extra/places/Crossroads.rbxl")`

* Open Happy Home in Robloxia:<br/>
`game:load("rbxasset://../../extra/places/HappyHomeInRobloxia.rbxl")`

* Open Roblox HQ:<br/>
`game:load("rbxasset://../../extra/places/RobloxHQ.rbxl")`

* Open Tabula Rasa:<br/>
`game:load("rbxasset://../../extra/places/TabulaRasa.rbxl")`

## Starting Game Sessions ##

* Start a Play Solo session:<br/>
`loadfile("rbxasset://../../extra/scripts/PlaySolo.lua")()`

* Start a localhost server.<br/>
`loadfile("rbxasset://../../extra/scripts/StartServer.lua")()`

* Connect to a localhost server:<br/>
`loadfile("rbxasset://../../extra/scripts/StartPlayer.lua")()`

## Manual Actions ##

* Create a player manually:<br/>
`game.Players:createLocalPlayer(0)`

* Load your player's character manually:<br/>
`game.Players.LocalPlayer:LoadCharacter()`

* Run the game manually:<br/>
`game:service("RunService"):run()`

* Reset the DataModel to an empty state:<br/>
`game:clearContent()`

# ThumbnailGenerator Support #

This build features the `ThumbnailGenerator` service, which is still used by Roblox to this day for render avatars and game thumbnails!<br/>
While it only exists on Roblox's backend server today, it happened to exist in this build for some reason.<br/>
It has the following API definition:

```
Class ThumbnailGenerator : Instance
    Function string ThumbnailGenerator:click(string fileType, int cx, int cy, bool hideSky)
```

Note that this service **does not work** immediately, it will crash Roblox if it isn't setup correctly.<br/>
You must copy the following files into the `client` directory of this repository:

- `extra/Mesa-7.2/GLU32.DLL` -> `client/GLU32.DLL`
- `extra/Mesa-7.2/OPENGL32.DLL` -> `client/OPENGL32.DLL`
- `extra/Mesa-7.2/OSMESA32.DLL` -> `client/OSMESA32.DLL`

## IMPORTANT NOTES ##

- When these DLL files are active, the rendering speed will slow to a crawl depending on the resolution of the game window.
	- This is cannot be avoided as this forces rendering to software rendering.
	- Remove the DLLs from the `client` directory when you aren't using them!
- Shadows **must be disabled** or Roblox will crash when opening a new place.
- Upon using `ThumbnailGenerator:click`, the crash dialog may show (though usually you can still interact with the client).
- MesaLib is very prone to rendering bugs (text appearing as black boxes, etc), though these don't affect the outcome of the thumbnail.

- Arguments for `ThumbnailGenerator:click` have the following constraints:
  - `fileType` can be `"PNG"`, `"JPG"`, `"TGA"`, `"BMP"`, `"PCX"` or `"ICO"` 
  - `cx` is the width of the thumbnail (max is 4096)
  - `cy` is the height of the thumbnail (max is 4096)
  - `hideSky` will make the sky transparent and adjust the camera angle if set to true, and will keep the sky and original camera angle if set to false
 - The string returned by the function is the image encoded in base64. Use a base64 to image converter like this one [here](https://codebeautify.org/base64-to-image-converter).

Example usage (renders an avatar thumbnail):

```lua
if not game.Players.LocalPlayer then
	game.Players:createLocalPlayer(0)
end

game.Players.LocalPlayer:LoadCharacter()
print(game:service("ThumbnailGenerator"):click("PNG", 420, 420, true))
```
