local inputPath = (arg and arg[1]) or "input.rbxm"
local outputPath = (arg and arg[2]) or "output_unlz4.rbxm"

local function readAll(path)
	if type(readfile) == "function" then
		return readfile(path)
	end

	local handle, err = io.open(path, "rb")
	if not handle then
		error(err, 0)
	end

	local data = handle:read("*a")
	handle:close()
	return data
end

local function writeAll(path, data)
	if type(writefile) == "function" then
		writefile(path, data)
		return
	end

	local handle, err = io.open(path, "wb")
	if not handle then
		error(err, 0)
	end

	handle:write(data)
	handle:close()
end

local function fail(message)
	error("unlz4: " .. message, 0)
end

local a = readAll(inputPath)
local totalSize = #a
print(totalSize)

if a:sub(1, 8) ~= "<roblox!" then
	writeAll(outputPath, a)
	print("Input is not a binary Roblox file; copied it unchanged to " .. outputPath)
	print("DONE")
	return
end

local cur = 33
local newFile = a:sub(1, 32)

while true do
	if cur > totalSize then
		break
	end

	if cur + 15 > totalSize then
		fail("truncated chunk header at byte " .. cur)
	end

	local name = a:sub(cur, cur + 3):match("%w+") or "????"
	local comLen = string.unpack("<I4", a:sub(cur + 4, cur + 7))
	local uncomLen = string.unpack("<I4", a:sub(cur + 8, cur + 11))
	local reserved = string.unpack("<I4", a:sub(cur + 12, cur + 15))
	print(name, comLen, uncomLen, reserved)

	local newHeader = a:sub(cur, cur + 3) .. string.rep("\0", 4) .. a:sub(cur + 8, cur + 15)
	newFile = newFile .. newHeader

	local addLen = comLen ~= 0 and comLen or uncomLen
	if addLen < 0 or cur + 16 + addLen - 1 > totalSize then
		fail("chunk " .. name .. " claims an invalid size")
	end

	if comLen == 0 then
		newFile = newFile .. a:sub(cur + 16, cur + 16 + uncomLen - 1)
	else
		if type(lz4decompress) ~= "function" then
			fail("lz4decompress is not available in this Lua environment")
		end

		local comp = a:sub(cur + 16, cur + 16 + comLen - 1)
		local uncomp = lz4decompress(comp, uncomLen)
		newFile = newFile .. uncomp
	end

	cur = cur + 16 + addLen
end

writeAll(outputPath, newFile)
print("DONE")
