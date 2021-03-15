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
	- This is cannot be avoided as this forces rendering to software rendering.
	- Remove the DLLs from the root directory when you aren't using them.
- Shadows must be disabled or Roblox will crash when opening a new place
- Upon using the `click()` function, the crash dialog may show (though usually you can still interact with the client).
- MesaLib is very prone to rendering bugs (text appearing as black boxes, etc), though these don't affect the outcome of the thumbnail.

- Arguments for `ThumbnailGenerator:click()` have the following constraints:
  - `fileType` can be `PNG`, `JPG`, `TGA`, `BMP`, `PCX` or `ICO` 
  - `cx` is the width of the thumbnail (max is 4096)
  - `cy` is the height of the thumbnail (max is 4096)
  - `hideSky` will make the sky transparent and adjust the camera angle if set to true, and will keep the sky and original camera angle if set to false
 - The string returned by the function is the image encoded in base64. Use a base64 to image converter like this one [here](https://codebeautify.org/base64-to-image-converter).

Example usage (renders an avatar thumbnail):
```
if not game.Players.LocalPlayer then game.Players:createLocalPlayer(0):LoadCharacter() end
print(game:service("ThumbnailGenerator"):click("PNG", 420, 420, true))
```
