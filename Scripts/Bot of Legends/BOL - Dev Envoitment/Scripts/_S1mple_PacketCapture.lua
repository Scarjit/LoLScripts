function toHex(int)
	return "0x"..string.format("%04X ",int)
end

function OnLoad()
	print("Loaded PCap")
	local file = io.open(SCRIPT_PATH.."\\".."pcap2.txt", "a")
	file:write("\n")
	file:close()
	DelayAction(function ( )
		lvlspell(_Q)
	end,2)
end

function OnRecvPacket(p)
	--if p.header ~= 0x001A and p.header ~= 0x00C2 and p.header ~= 0x0043 and p.header ~= 0x002C and p.header ~= 0x0012 and p.header ~= 0x005F and p.header ~= 0x00F0 and p.header ~= 0x00B5 and p.header ~= 0x000C and p.header ~= 0x014B and p.header ~= 0x012D then
		--register(p, "Recv")
	--end
end
 
function OnSendPacket(p)
	--if p.header ~= 0x00A9 then return end
	register(p, "Send")
end

function register(p, str)
	p.pos = 2
	local obj = objManager:GetObjectByNetworkId(p:DecodeF())
	local name = ""
	if obj and obj.valid then
		name = obj.charName
	else return end
	--if obj == myHero then return end
	--if obj.type ~= myHero.type then return end
	print("Got Package: "..toHex(p.header))
	local seconds = GetInGameTimer()
	if type(seconds) ~= "number" or seconds > 100000 or seconds < 0 then return " ? " end
	local formatedTime = string.format("%i:%02i", seconds / 60, seconds % 60)

	local file = io.open(SCRIPT_PATH.."\\".."pcap2.txt", "a")
	file:write("Time: "..os.clock().." || "..toHex(p.header).." || "..DumpPacketData(p).." || "..toHex(p.vTable).."|| "..name.."|| dwArg1: "..p.dwArg1.." || dwArg2: "..p.dwArg2.."\n")
	--file:write(toHex(p.header).."\n")
	file:close()
end

function lvlspell(id)
  local offsets = { 
    [_Q] = 0xF8,
    [_W] = 0x4F,
    [_E] = 0x14,
    [_R] = 0x9E,
  }
  local p = CLoLPacket(0x00A9)
  p.vTable = 0xF3981C
  p:EncodeF(myHero.networkID)
  for i = 1,4 do p:Encode1(0x19) end
  for i = 1,4 do p:Encode1(0x44) end
  p:Encode1(0xEC)
  p:Encode1(offsets[id])
  for i = 1,4 do p:Encode1(0xF7) end
  register(p, "tset")
  --SendPacket(p)
end