local a = readfile("input.rbxm")
local cur = 33
local totalSize = #a
warn(totalSize)

local newFile = ""

newFile = newFile..a:sub(1,32)

while true do
	if cur >= totalSize then break end
	
	local name = a:sub(cur,cur+3):match("%w+")
	local comLen = string.unpack("<I4",a:sub(cur+4,cur+7))
	local uncomLen = string.unpack("<I4",a:sub(cur+8,cur+11))
	local reserved = string.unpack("<I4",a:sub(cur+12,cur+15))
	print(name,comLen,uncomLen,reserved)
	
	local newHeader = a:sub(cur,cur+3) .. string.rep("\0",4) .. a:sub(cur+8,cur+15)
	
	newFile = newFile..newHeader
	
	if comLen == 0 then
		newFile = newFile..a:sub(cur+16,cur+16 + uncomLen-1)
	else
		local comp = a:sub(cur+16,cur+16 + comLen-1)
		local uncomp = lz4decompress(comp,uncomLen)
		newFile = newFile..uncomp
	end
	
	local addLen = comLen ~= 0 and comLen or uncomLen
	cur = cur+16+addLen
end

writefile("output_unlz4.rbxm",newFile)

print("DONE")
