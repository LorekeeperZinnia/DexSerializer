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
Or if you are interested in maintaining this GitHub repo itself, then please contact me in the community server.

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

Back then, the saveinstance scripts were horrible. The best one that Synapse had was the rerumu one which was so slow and inaccurate.

The options in this serializer is also what UNC's saveinstance is based of, due to ScriptWare using this as its primary saveinstance implementation.

Note that there are little to no comments since I didn't intend to release to public.

It would be nice if executors supported this fully so in the event The Augur rises to power once again, that more accurate saves of ServerScriptService and ServerStorage can be done on today's top games


## How to Use
Assuming you are using it as a module
```lua
local serializer = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/FirTheDeveloper/DexSerializer/refs/heads/main/serializer.lua"))()
serializer.Init()

-- Then we can save
serializer.Save(instance, name, options)
```

For `instance` you can put any of the following
- A single instance to save it and all descendants
- `game` to save the whole game to a .rbxl file
- A table with multiple instances inside it, to save something with multiple roots

The name is optional, if you leave it out it will generate one.

## Options

```lua
Serializer = {
	-- Decompilation Settings
	Decompile = false,                    -- Decompiles scripts or not
	DecompileTimeout = 10,                -- Timeout before giving up decompiling a script (seconds)
	MaxThreads = 3,                       -- Number of parallel decompilation threads
	DecompileIgnore = {"Chat","CoreGui","CorePackages"},  -- Services to ignore
	SaveBytecode = false,                 -- Include bytecode in output (if available)
	SaveScriptCache = false,              -- Cache decompiled scripts
	
	-- Instance Selection
	NilInstances = false,                 -- Include nil instances
	Decompile = false,                    -- Decompiles or not
	RemovePlayerCharacters = true,        -- Remove player characters
	SavePlayers = false,                  -- Save player instances if saving game
	IsolateStarterPlayer = true,          -- Isolate StarterPlayer for playtesting
	IsolateLocalPlayer = false,           -- Isolate local player
	SavePlayerCharacters = false,         -- Include player character models
	
	-- Property Filtering
	IgnoreDefaultProps = true,            -- Ignore default properties (reduces file size)
	IgnoreNotArchivable = true,           -- Skip non-archivable instances
	
	-- Output Settings
	Binary = true,                        -- Use binary format (.rbxl/.rbxm) instead of XML
	ShowStatus = true,                    -- Display status in top-left corner
	ReadMe = true,                        -- Include helpful README in save
	Mode = "full",                        -- "full", "scripts", or "models"
	FilePath = false,                     -- Custom file path
	Callback = false,                     -- Callback function after saving (receives binary data)
	Clipboard = false,                    -- Copy to clipboard instead of file
	AvoidFileOverwrite = true,            -- Ask before overwriting existing files
	
	-- Safety Features
	SafeMode = false,                     -- Kick before saving for safety (recommended for production)
	BoostFPS = false,                     -- Disable rendering to boost FPS during save
	KillAllScripts = false,               -- Kill all scripts before saving
	AntiIdle = false,                     -- Prevent idle timeout during long saves
	
	-- Data Cleanup
	Anonymous = false                     -- Remove personal data like player names/IDs
}
```

### Mode Options
- **"full"**: Save everything (default)
- **"scripts"**: Only save scripts (forces Decompile=true)
- **"models"**: Save models without scripts (forces Decompile=false)

If Callback or Clipboard is set, it does that instead of writing to a file.

## Usage Examples

### Basic Save
```lua
serializer.Save(game)
```

### Save Only Scripts (Auto-Decompile)
```lua
serializer.Save(game, "GameScripts", {
	Mode = "scripts",
	ShowStatus = true,
	MaxThreads = 4
})
```

### Safe Mode (Recommended for Production)
```lua
serializer.Save(game, "SafeBackup", {
	SafeMode = true,        -- Kicks you before saving
	BoostFPS = true,        -- Improves performance
	AntiIdle = true,        -- Prevents timeout
	DecompileTimeout = 15
})
```

### Export Specific Model
```lua
serializer.Save(workspace.MyModel, "model_export", {
	Mode = "models",
	Binary = true,
	IgnoreDefaultProps = true
})
```

### Anonymize Save (Remove Personal Data)
```lua
serializer.Save(game, "Anonymous", {
	Anonymous = true,
	RemovePlayerCharacters = true,
	SavePlayers = false
})
```


- For gethiddenproperty, support
	- BinaryString
 	- SharedString (return the raw binary value that is shared)
	- Color3uint8 (this property is on BasePart and it is what gets serialized for part colors)
	- Vector3int16 (used in TerrainRegion)
- have lz4 compress function
- have a clipboard function that sets to `application/x-roblox-studio` (for reference, copy something in studio and use clipboard viewer to see how its saved)

## Suggested Improvements
Here are some sugggestions for those interested in maintaining this script:
	- Would also be nice if you can work with executor devs to make sure their `gethiddenprop` function supports all value types that can be serialized.
- Possibly clean it up

## Known Issues
 - None :3

## Community Server
If you would like to find more information, or talk to others interested in this script, you may join the server:<br>https://discord.gg/jnXFq2VBgU<br>
Note that very limited to no support will be provided.

<br>

Made by Moon

<img src="/logo2.jpg" width="400"/>
