# Roblox 0.3.368.0

This is a newly discovered build of Roblox, compiled in March of 2007.<br>
To run the client, download this repository as a zip and extract it.

# Requirements #

For this to execute correctly, you need to make sure your system has the `Microsoft Visual C++ 2005 Service Pack` installed. This pack was standard in most older systems, but newer systems are no longer bundled with it. You can find it here:<br>
https://www.microsoft.com/en-us/download/details.aspx?id=26347

# WARNING: DO NOT USE THIS AS A MULTIPLAYER CLIENT #

This build in its vanilla state is ***EXTREMELY VULNERABLE*** to exploits.<br/>
We cannot guarentee your safety connecting to servers running this build, nor will we take any responsibility if anything happens. You have been warned, be smart and have fun :)!

# Download Link #
https://github.com/CloneTrooper1019/Roblox_0.3.368.0/archive/main.zip

# Basic Commands #

* Create a player:<br/>
`game.Players:createLocalPlayer(0)`

* Load your player's character:<br/>
`game.Players.LocalPlayer:LoadCharacter()`

* Run the game:<br/>
`game:service("RunService"):run()`

# ThumbnailGenerator Support #

This build features the `ThumbnailGenerator` service, which is still used to this day to render avatars and game thumbnails. It has the following API definition:

```
Class ThumbnailGenerator : Instance
	Function string ThumbnailGenerator:click(string fileType, int cx, int cy, bool hideSky)
```

Note that this service **does not work** immediately, it will crash Roblox if it isn't setup correctly.<br/>
You must copy the following files into the root directory of this repository:

- `Mesa-7.0/GLU32.DLL` -> `GLU32.DLL`
- `Mesa-7.0/OPENGL32.DLL` -> `OPENGL32.DLL`
- `Mesa-7.0/OSMESA32.DLL` -> `OSMESA32.DLL`

**IMPORTANT NOTES:**

- When these DLL files are active, the rendering speed will slow to a crawl.
	- This is a known defect which cannot be avoided.
	- Remove the DLLs from the root directory when you aren't using them.
- Arguments for `ThumbnailGenerator:click` have the following constraints:
  - `fileType` must be 
- Upon using the `click` function, Roblox will close shortly after.
- The string returned by the function is the image encoded in base64.
