<p align="center">
<img src="/logo.png" width="500"/>
</p>

# Dex Serializer
An accurate Roblox Binary Format Serializer made in Lua
<p align="center">
<img src="/server_save.png" width="800"/>
</p>


## Overview
This serializer was completed in late 2020 in preperation for The Augur's reign that started in July 2021

Many ServerScriptService and ServerStorage models of top games were saved during that era with top accuracy

This serializer can save in both xml and binary format. It is more accurate in binary format since I stopped maintaining xml format after I finished making binary.


This is old and discontinued, but the agency released it to show people the grand serializer that
powered the saveinstance function in the top executors at the time before they were discontinued:
- ScriptWare
- Synapse X

The options in this serializer is also what UNC's saveinstance is based of, due to ScriptWare using this as its primary saveinstance implementation.

It would be nice if someone forked and improved it by doing the following:
- Support the newer roblox types such as Content, etc
- Use buffer
- Use ReflectionService

Note that there are little to no comments since I didn't intend to release to public.

It would be nice if executors supported this fully so in the event The Augur rises to power once again, that more accurate saves of ServerScriptService and ServerStorage can be done on today's top games


## How to Use
Assuming you are using it as a module
```lua
local serializer = require("serializer.lua")
serializer.Init()

-- Then we can save
serializer.Save(instance, name, options)
```

For `instance` you can put any of the following
- A single instance to save it and all descendants
- `game` to save the whole game to a .rbxl file
- A table with multiple instances inside it, to save something with multiple roots

The name is optional, if you leave it out it will generate one.

Options
```lua
Serializer = {
	Decompile = false, -- Decompiles or not
	NilInstances = false, -- Saves nil or not
	RemovePlayerCharacters = true, -- Remove player chars
	SavePlayers = false, -- Save instances in players if saving game
	DecompileTimeout = 10, -- Timeout before giving up decompiling a script
	MaxThreads = 3, -- Threads to use to decompile
	DecompileIgnore = {"Chat","CoreGui","CorePackages"}, -- Services to ignore saving if saving game
	ShowStatus = true, -- Show a status at top
	IgnoreDefaultProps = true, -- Ignore saving default props to lower file size (xml only)
	IsolateStarterPlayer = true, -- Isolate StarterPlayer instances if saving game, to ensure you can playtest it after opening the rbxl
	Binary = true, -- Use binary format
	Callback = false, -- A callback function after the saving is complete where the raw binary is passed
	Clipboard = false -- Copies the raw binary to clipboard instead of writing to file (need a clipboard function that sets the type to application/x-roblox-studio)
}
```
If Callback or Clipboard is set, it does that instead of writing to a file.

## What executor devs should do to support this fully and ensure accurate saves
- For gethiddenproperty, support
	- BinaryString
 	- SharedString (return the raw binary value that is shared)
	- Color3uint8 (this property is on BasePart and it is what gets serialized for part colors)
	- Vector3int16 (used in TerrainRegion)
- have lz4 compress function
- have a clipboard function that sets to `application/x-roblox-studio` (for reference, copy something in studio and use clipboard viewer to see how its saved)

## Community Server
If you would like to find more information, or talk to others interested in this script, you may join the server:<br>https://discord.gg/jnXFq2VBgU<br>
Note that very limited to no support will be provided.

<br>

Made by Moon

<img src="/logo2.jpg" width="400"/>
