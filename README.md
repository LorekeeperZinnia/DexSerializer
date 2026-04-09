<p align="center">
<img src="/logo.png" width="500"/>
</p>

# Dex Serializer
An accurate Roblox Binary Format Serializer made in Lua
<p align="center">
<img src="/server_save.png" width="800"/>
</p>


## Disclaimer
Executors are not recommended to use this serializer as is, since is not maintained. I only released this for learning purposes.
It is recommended to wait for someone interested to fork this so they can take over the project and maintain it.
Or if you are interesting in maintaining this GitHub repo itself, then please contact me in the community server.

I do not use executors anymore so I had did small fixes to support the newer API dumps in studio, etc.
Go to [Suggested Improvements](#suggested-improvements) to see a list of improvements that can be made to this script.
Please see the [Known Issues](#known-issues) section for some issues that people I know have found when I had them test this script on executors.


## Overview
This serializer was completed in late 2020 in preperation for The Augur's reign that started in July 2021

Many ServerScriptService and ServerStorage models of top games were saved during that era with top accuracy

This serializer can save in both xml and binary format. It is more accurate in binary format since I stopped maintaining xml format after I finished making binary.


This is old and discontinued, but the agency released it to show people the grand serializer that
powered the saveinstance function in the top executors at the time before they were discontinued:
- ScriptWare
- Synapse X
- Elysian

The options in this serializer is also what UNC's saveinstance is based of, due to ScriptWare using this as its primary saveinstance implementation.

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

## Suggested Improvements
Here are some sugggestions for those interested in maintaining this script:
- Support the newer roblox types such as Content, SecurityCapabilities, etc
	- Would also be nice if you can work with executor devs to make sure their `gethiddenprop` function supports all value types that can be serialized.
	- If you are interested in reversing the new types, I have attached a script called `unlz4.lua` that you can modify to decompress the lz4 chunks in a binary format file so you can take a look at how studio saves certain types.
- Use buffer
- Use ReflectionService for API dumps

## Known Issues
- Axes property doesn't save properly in XML due to a typo in the tag
- XML may not work with the full API dump since I had scripted it before switching over to full API dump. I had used to make special handlers for BinaryString and other hidden properties.
- Color3uint8 in binary was just an assumption (A color type that has R G B as integers from 0-255) since gethiddenprop did not support that value type. If you run into issues, simply add BasePart.Color3uint8 to the `propFilter` table.

## Community Server
If you would like to find more information, or talk to others interested in this script, you may join the server:<br>https://discord.gg/jnXFq2VBgU<br>
Note that very limited to no support will be provided.

<br>

Made by Moon

<img src="/logo2.jpg" width="400"/>
