-- Furry Packets Lib
-- by Furry
-- Version 6.0

_AUTO_UPDATE_FURRY = true -- Set this to false to prevent automatic updates

--			[ ChangeLog ]
--  There is no ChangeLog, this is just a script to keep AutoLeveler and SkinChanger Packets all in one place, so when I need to update them, all I need to do is update this script.
--			[ ChangeLog ]

_GAME_VERSION = string.find(GetGameVersion(), 'Releases/5.24') -- Change this after a patch if you want errors and bugsplats :)
_GAME_VERSION_LEVELER = string.find(GetGameVersion(), 'Releases/5.24') -- Change this after a patch if you want errors and bugsplats :)

local serveradress = "raw.githubusercontent.com"
local scriptadress = "/FurryBoL/master/master"
local LocalVersion = "6.0"
 
 
if _AUTO_UPDATE_FURRY or true then
	local ServerVersionDATA = GetWebResult(serveradress , scriptadress.."/Furry_Packets_Lib.version")
	if ServerVersionDATA then
		local ServerVersion = tonumber(ServerVersionDATA)
		if ServerVersion then
			if ServerVersion > tonumber(LocalVersion) then
				print("<font color='#9900FF'>[Furry Packets Lib] </font><font color='#FF0000'>-</font><font color='#00FFFF'> Updating Furry_Packets_Lib, don't press F9</font>")
				DelayAction(DownloadFile, 0, {
					"http://"..serveradress..scriptadress.."/Furry_Packets_Lib.lua",
					LIB_PATH.."\\Furry_Packets_Lib.lua",
					function ()
						print("<font color='#9900FF'>[Furry Packets Lib] </font><font color='#FF0000'>-</font><font color='#00FFFF'> Updated, press 2xF9</font>")
					end
				})
			end
		else
			print("<font color='#9900FF'>[Furry Packets Lib] </font><font color='#FF0000'>-</font><font color='#00FFFF'> An error occured, while updating, please reload</font>")
		end
	else
		print("<font color='#9900FF'>[Furry Packets Lib] </font><font color='#FF0000'>-</font><font color='#00FFFF'> Could not connect to update Server</font>")
	end
end
	
print("<font color='#9900FF'>[Furry Packets Lib] </font><font color='#FF0000'>-</font><font color='#00FFFF'> Loaded!</font>")

if (_GAME_VERSION_LEVELER ~= nil) then
	_G.LevelSpell = function(id)
		local offsets = { 
			[_Q] = 0x1E,
			[_W] = 0xD3,
			[_E] = 0x3A,
			[_R] = 0xA8,
		}
		local p = CLoLPacket(0x00B6)
		p.vTable = 0xFE3124
		p:EncodeF(myHero.networkID)
		p:Encode1(0xC1)
		p:Encode1(offsets[id])
		for i = 1, 4 do p:Encode1(0x63) end
		for i = 1, 4 do p:Encode1(0xC5) end
		for i = 1, 4 do p:Encode1(0x6A) end
		for i = 1, 4 do p:Encode1(0x00) end
		SendPacket(p)
	end
end

function SkinChanger()
local skinsPB = {}
local skinObjectPos = nil
local skinHeader = nil
local dispellHeader = nil
local skinH = nil
local skinHPos = nil
end

if (_GAME_VERSION ~= nil) then
	skinsPB = {
		[1] = nil,
		[2] = 0xCA,
		[3] = 0x0C,
		[4] = 0x4C,
		[5] = 0xF8,
		[6] = 0xB8,
		[7] = 0x78,
		[8] = 0x38,
		[9] = 0xE8,
		[10] = 0xA8,
		[11] = 0x68,
		[12] = 0x28,
		[13] = 0xD8,
	}
	skinObjectPos = 6
	skinHeader = 0x3A
	dispellHeader = 0xB7
	skinH = 0x8C
	skinHPos = 32
end

function SendSkinPacket(mObject, skinPB, networkID)
	if (_GAME_VERSION ~= nil) then
		local mP = CLoLPacket(0x3A)
		mP.vTable = 0xF351B0
		mP:EncodeF(myHero.networkID)
		for I = 1, string.len(mObject) do
			mP:Encode1(string.byte(string.sub(mObject, I, I)));
		end
		for I = 1, (16 - string.len(mObject)) do
			mP:Encode1(0x00)
		end
		mP:Encode4(0x0000000E)
		mP:Encode4(0x0000000F)
		mP:Encode2(0x0000)
		if (skinPB == nil) then
			mP:Encode4(0x82828282)
		else
			mP:Encode1(skinPB)
			for I = 1, 3 do
				mP:Encode1(skinH)
			end
		end
		mP:Encode4(0x00000000)
		mP:Encode4(0x00000000)
		mP:Encode1(0x00)
		mP:Hide()
		RecvPacket(mP)
	end
end
