--[[
   _____ __                 _        _      _ _                        _              _____ __                 _       _____           _       _       
  / ____/_ |               | |      | |    (_) |                      | |            / ____/_ |               | |     / ____|         (_)     | |      
 | (___  | |_ __ ___  _ __ | | ___  | |     _| |__   __ _ _ __ _   _  | |__  _   _  | (___  | |_ __ ___  _ __ | | ___| (___   ___ _ __ _ _ __ | |_ ___ 
  \___ \ | | '_ ` _ \| '_ \| |/ _ \ | |    | | '_ \ / _` | '__| | | | | '_ \| | | |  \___ \ | | '_ ` _ \| '_ \| |/ _ \\___ \ / __| '__| | '_ \| __/ __|
  ____) || | | | | | | |_) | |  __/ | |____| | |_) | (_| | |  | |_| | | |_) | |_| |  ____) || | | | | | | |_) | |  __/____) | (__| |  | | |_) | |_\__ \
 |_____/ |_|_| |_| |_| .__/|_|\___| |______|_|_.__/ \__,_|_|   \__, | |_.__/ \__, | |_____/ |_|_| |_| |_| .__/|_|\___|_____/ \___|_|  |_| .__/ \__|___/
                     | |                                        __/ |         __/ |                     | |                             | |            
                     |_|                                       |___/         |___/                      |_|                             |_|            





]]

class("S1mpleLibary")
function S1mpleLibary:__init()
	if _G.S1mple_Libaryloaded then return end
	SUpdate()
	self.vip = VIP_USER
	self.supportedlolversion = "6.2.0.249"
	self.lvllist = {"Override Me"}
	self.level = 1
	self.levellst = 1
	self.minhuman = 0
	self.maxhuman = 0.01
	cfg = nil
	AddTickCallback(function()
		self:tick()
	end)
	_G.S1mple_Libaryloaded = true
end

function S1mpleLibary:AddMenu(Config)
	if not self.vip then return end
	if GetGameVersion():sub(1,10) == self.supportedlolversion then
		if not Config then error("Config required") end
		Config:addSubMenu("VIP Settings", "vip")
			Config.vip:addSubMenu("Auto Level", "lvl")
				Config.vip.lvl:addParam("enabled", "Activate Auto Level", SCRIPT_PARAM_ONOFF, false)
				Config.vip.lvl:addParam("order", "Level Order", SCRIPT_PARAM_LIST, 1, self.lvllist)
			--Config.vip:addParam("masteryemote","Mastery Emoter after Kill", SCRIPT_PARAM_ONOFF, false) //Wont implement until BoL Fixes it API
	else
		Config:addParam("po", "Packets outdated", SCRIPT_PARAM_INFO, "")
	end
	cfg = Config
end

function S1mpleLibary:tick()
	if cfg and cfg.vip and cfg.vip.lvl.enabled then
		self:chklvl()
	end

	if cfg and cfg.vip and cfg.vip.masteryemote then
		self:masterytaunt()
	end
end

function S1mpleLibary:setHuman(min, max)
	if not min then min = 0 end
	if not max then
		if min then
				max = min+1
			else
				max = 0.01
		end
	end
	self.minhuman = min
	self.maxhuman = max
end


--[[============================================= AUTO LEVEL =============================================]]--

function S1mpleLibary:SetLvLOrder(neworder)
	self.lvllist = neworder
end


function S1mpleLibary:chklvl()
	if self.level <= myHero.level then
		if self.lvllist[cfg.vip.lvl.order]:sub(self.levellst,self.levellst) == "Q" then
			DelayAction(function ()
				self:lvlspell(_Q)
			end, math.random(self.minhuman,self.maxhuman))			
		elseif self.lvllist[cfg.vip.lvl.order]:sub(self.levellst,self.levellst) == "W" then
			DelayAction(function ()
				self:lvlspell(_W)
			end, math.random(self.minhuman,self.maxhuman))	
		elseif self.lvllist[cfg.vip.lvl.order]:sub(self.levellst,self.levellst) == "E" then
			DelayAction(function ()
				self:lvlspell(_E)
			end, math.random(self.minhuman,self.maxhuman))	
		elseif self.lvllist[cfg.vip.lvl.order]:sub(self.levellst,self.levellst) == "R" then
			DelayAction(function ()
				self:lvlspell(_R)
			end, math.random(self.minhuman,self.maxhuman))	
		else
			print(self.lvllist[cfg.vip.lvl.order]:sub(self.levellst,self.levellst))
		end
		self.level = self.level + 1
		self.levellst = self.levellst + 2
	end
end

function S1mpleLibary:lvlspell(id)
if not self.vip then return end
if GetGameVersion():sub(1,10) ~= self.supportedlolversion then return end
local offsets = {
[_Q] = 0x41,
[_W] = 0xFC,
[_E] = 0x64,
[_R] = 0xAA,
}
local p = CLoLPacket(0x0153)
p.vTable = 0xF700D0
p:EncodeF(myHero.networkID)
p:Encode1(offsets[id])
for i = 1, 4 do p:Encode1(0xF7) end
for i = 1, 4 do p:Encode1(0xAF) end
p:Encode1(0x8F)
for i = 1, 4 do p:Encode1(0xA5) end
SendPacket(p)
end

--============================================= AUTO MASTERY EMOTE =============================================


function S1mpleLibary:masterytauntPackage()
	if not self.vip then return end
	if GetGameVersion():sub(1,10) ~= self.supportedlolversion then return end
	print("Mastery Taunt is not Yet Updated")
	--[[ 5.24
	local p = CLoLPacket(0x0153)
	p.vTable = 0xE98380
	p:EncodeF(myHero.networkID)
	for i = 1, 4 do p:Encode1(0x1E) end
	p:Encode1(0x7A)
	p:Encode1(0x07)
	p:Encode1(0xA4)
	p:Encode1(0xEB)
	SendPacket(p)
	]]--
end




--[[==================Auto Update====================]]
class('SUpdate')
function SUpdate:__init()
	self.updating = false
	self.updated = false
	AddDrawCallback(function ()
		self:draw()
	end)
	self:download()
end

function SUpdate:download( ... )
	self.updating = true
	version = "0.7"
	local serveradress = "scarjit.de"
	local scriptadress = "/S1mpleScripts/Scripts/BolStudio/Libary/S1mpleLibary/"
	local ServerVersionDATA = GetWebResult(serveradress , scriptadress.."/S1mple_Libary.version")
	if ServerVersionDATA then
		local ServerVersion = tonumber(ServerVersionDATA)
		if ServerVersion then
			if ServerVersion > tonumber(version) then
				print("Updating, don't press F9")
				DownloadFile("http://"..serveradress..scriptadress.."/S1mple_Libary.lua",LIB_PATH.."S1mple_Libary.lua", function ()
					updated = true
				end)
			end
		else
			print("An error occured, while updating, please reload")
		end
	else
		print("Could not connect to update Server")
	end
	self.updating = false
end

function SUpdate:draw()
	local w, h = WINDOW_W, WINDOW_H
	if self.updating then
		DrawTextA("[S1mple_Libary] Updating", 25, 10,h*0.05,ARGB(255,255,255,255), "left", "center")
	end
	if updated then
		DrawTextA("[S1mple_Libary] Updated, press 2xF9", 25, 10,h*0.05,ARGB(255,255,255,255), "left", "center")
	end
end