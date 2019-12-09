--[[
   ________                __        _____   _                     ___ 
  / ___<  /___ ___  ____  / /__     /__  /  (_)___ _____ ______   |__ \
  \__ \/ / __ `__ \/ __ \/ / _ \      / /  / / __ `/ __ `/ ___/   __/ /
 ___/ / / / / / / / /_/ / /  __/     / /__/ / /_/ / /_/ (__  )   / __/ 
/____/_/_/ /_/ /_/ .___/_/\___/     /____/_/\__, /\__, /____/   /____/ 
                /_/                        /____//____/                
]]--

if myHero.charName ~= "Ziggs" then return end

class("OrbWalker")
function OrbWalker:__init(menu)
	self.LoadedOrbWalker = nil
	self.menu = menu
	DelayAction(function ()
		self:GetLoadedOrbWalker() --Give the OrbWalker some time to load
	end,1.25)
end

function OrbWalker:GetLoadedOrbWalker()
	if _G.S1OrbLoading or _G.S1mpleOrbLoaded then self.LoadedOrbWalker = "S1Orb" end
	if _G.Reborn_Loaded or _G.AutoCarry then self.LoadedOrbWalker = "SAC:R" end
	if _G.SAC then self.LoadedOrbWalker = "SAC:P" end
	if _G.MMA_Loaded or _G.MMA_Version then self.LoadedOrbWalker = "MMA" end
	if _G.NebelwolfisOrbWalkerInit or _G.NebelwolfisOrbWalkerLoaded then self.LoadedOrbWalker = "NOW" end
	if _Pewalk then self.LoadedOrbWalker = "PEW" end
	if _G.SxOrb or SxOrb then self.LoadedOrbWalker = "SxOrb" end
	if not self.LoadedOrbWalker then
		if FileExist(LIB_PATH.."S1mpleOrbWalker.lua") then
			self.LoadedOrbWalker = "S1Orb"
			DelayAction(function ()
				require "S1mpleOrbWalker"
				S1 = S1mpleOrbWalker()
				self.menu:addSubMenu("OrbWalker", "orb")
				S1:AddToMenu(self.menu.orb)
			end,0.25)
			printC("Loading S1mpleOrbWalker")
			return
		else
			self.menu:addSubMenu("Keys", "keys")
				self.menu.keys:addParam("harass", "Harass Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
				self.menu.keys:addParam("combo", "Combo Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte(" "))
				self.menu.keys:addParam("laneclear", "Laneclear Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
				self.menu.keys:addParam("lasthit", "Lasthit Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("X"))
			self.ts = TargetSelector(TARGET_LESS_CAST, 560, DAMAGE_MAGIC, true)
		end
	end
	if self.LoadedOrbWalker then
		self.menu:addSubMenu("Keys", "keys")
			self.menu.keys:addParam("inf", "Keys are connected to your OrbWalker Keys", SCRIPT_PARAM_INFO, "")
	end
end

function OrbWalker:GetMode()
	--[[
	Mode Table:
		-2: Critical Error, should never happen
		-1: OrbWalker Loaded, but no return value (this is an error)
		0: None
		1: Harass
		2: Laneclear
		3: Lasthit
		4: SBTW
	]]
	if not self.LoadedOrbWalker then
		if not self.menu.keys then return 0 end
		if self.menu.keys.harass then return 1 end
		if self.menu.keys.laneclear then return 2 end
		if self.menu.keys.lasthit then return 3 end
		if self.menu.keys.combo then return 4 end
		return 0
	end
	if self.LoadedOrbWalker == "S1Orb" then
		if S1 and S1.aamode == "none" then return 0 end
		if S1 and S1.aamode == "harass" then return 1 end
		if S1 and S1.aamode == "laneclear" then return 2 end
		if S1 and S1.aamode == "lasthit" then return 3 end
		if S1 and S1.aamode == "sbtw" then return 4 end
		if not S1 and _G.S1mpleOrbWalker then
			S1 = _G.S1
		end		
		return -1
	elseif self.LoadedOrbWalker == "SAC:R" then
		if not _G.AutoCarry then return 0 end
		if _G.AutoCarry.Keys.MixedMode then return 1 end
		if _G.AutoCarry.Keys.LaneClear then return 2 end
		if _G.AutoCarry.Keys.LastHit then return 3 end
		if _G.AutoCarry.Keys.AutoCarry then return 4 end
		return 0
	elseif self.LoadedOrbWalker == "MMA" then
		if _G.MMA_IsDualCarrying() then return 1 end
		if _G.MMA_IsLaneClearing() then return 2 end
		if _G.MMA_IsLastHitting() then return 3 end
		if _G.MMA_IsOrbwalking() then return 4 end
		return 0
	elseif self.LoadedOrbWalker == "NOW" then
		if not _G.NebelwolfisOrbWalker then return 0 end
		if _G.NebelwolfisOrbWalker.Config.k.Harass then return 1 end
		if _G.NebelwolfisOrbWalker.Config.k.LaneClear then return 2 end
		if _G.NebelwolfisOrbWalker.Config.k.LastHit then return 3 end
		if _G.NebelwolfisOrbWalker.Config.k.Combo then return 4 end
		return 0
	elseif self.LoadedOrbWalker == "PEW" then
		if not _Pewalk then return 0 end
		if _Pewalk.GetActiveMode().Mixed then return 1 end
		if _Pewalk.GetActiveMode().LaneClear then return 2 end
		if _Pewalk.GetActiveMode().Farm then return 3 end
		if _Pewalk.GetActiveMode().Carry then return 4 end
		return 0
	elseif self.LoadedOrbWalker == "SxOrb" then
		if not _G.SxOrb then return end
		if _G.SxOrb.isHarass or SxOrb.isHarass then return 1 end
		if _G.SxOrb.isLaneClear or SxOrb.isLaneClear then return 2 end
		if _G.SxOrb.isLastHit or SxOrb.isLastHit then return 3 end
		if _G.SxOrb.isFight or SxOrb.isFight then return 4 end
		return 0
	elseif self.LoadedOrbWalker == "BFW" then
		if _G["BigFatOrb_Mode"] == "Harass" then return 1 end
		if _G["BigFatOrb_Mode"] == "LaneClear" then return 2 end
		if _G["BigFatOrb_Mode"] == "LastHit" then return 3 end
		if _G["BigFatOrb_Mode"] == "Combo" then return 4 end
		return 0
	end
	error("OrbWalker: -2")
end

function OrbWalker:GetTarget()
	not self.LoadedOrbWalker then
		ts:update()
		return ts.target
	elseif self.LoadedOrbWalker == "S1Orb" then
		return S1:GetTarget()
	elseif self.LoadedOrbWalker == "SAC:R" then
		return _G.AutoCarry

end

class("Ziggs")
function Ziggs:__init()
	printC("Loading Ziggs")
	if self:LoadPred() then
		self:Menu()
		self.orb = OrbWalker(self.menu)
		AddTickCallback(function ()
			self:OnTick()
		end)
	end
end

function Ziggs:LoadPred()
	if FileExist(LIB_PATH.."FHPrediction.lua") then
		require("FHPrediction")
		return true
	else
		printC("This Script requires FHPrediction. Please download it, and reload the script")
		return false
	end
end

function Ziggs:Menu()
	self.menu = scriptConfig("S1mple_Ziggs2", "S1mple_Ziggs2")
	self.menu:addSubMenu("Advanced Settings", "adv")
		self.menu.adv:addParam("debug", "Activate Debug Mode", SCRIPT_PARAM_ONOFF, false)
	self.menu:addSubMenu("Spells", "spells")
		self.menu.spells:addSubMenu("Q","q")

		self.menu.spells:addSubMenu("W","w")
			self.menu.spells.w:addParam("autotower", "Auto Kill enemy Towers", SCRIPT_PARAM_ONOFF, true)
			self.menu.spells.w:addParam("sep1", "", SCRIPT_PARAM_INFO, "")
			self.menu.spells.w:addParam("autothrowenabled", "Use W to prevent low life enemy from escaping", SCRIPT_PARAM_ONOFF, true)
			self.menu.spells.w:addParam("autothrowmaxhpperc", "Max HP %", SCRIPT_PARAM_SLICE, 10, 0, 50, 0)
			self.menu.spells.w:addParam("autothrowblacklistinfo", "Blacklist:", SCRIPT_PARAM_INFO, "")
			for _,v in pairs(GetEnemyHeroes()) do
				self.menu.spells.w:addParam("autothrowblacklist"..v.charName, v.charName, SCRIPT_PARAM_ONOFF, false)
			end

		self.menu.spells:addSubMenu("E","e")

		self.menu.spells:addSubMenu("R","r")


	self.menu:addSubMenu("Laneclear", "lc")
		self.menu.lc:addParam("useq", "Use Q", SCRIPT_PARAM_ONOFF, true)
		self.menu.lc:addParam("minqmana", "Min Q Mana %", SCRIPT_PARAM_SLICE, 15,0,100,0)
		self.menu.lc:addParam("minqhit", "Min Minions hit", SCRIPT_PARAM_SLICE, 3,1,5,0)
		self.menu.lc:addParam("sep1", "", SCRIPT_PARAM_INFO, "")
		self.menu.lc:addParam("usew", "Use W", SCRIPT_PARAM_ONOFF, true)
		self.menu.lc:addParam("minwmana", "Min W Mana %", SCRIPT_PARAM_SLICE, 15,0,100,0)
		self.menu.lc:addParam("minwhit", "Min Minions hit", SCRIPT_PARAM_SLICE, 3,1,5,0)
		self.menu.lc:addParam("sep2", "", SCRIPT_PARAM_INFO, "")
		self.menu.lc:addParam("usee", "Use E", SCRIPT_PARAM_ONOFF, false)
		self.menu.lc:addParam("minemana", "Min E Mana %", SCRIPT_PARAM_SLICE, 15,0,100,0)
		self.menu.lc:addParam("minehit", "Min Minions hit", SCRIPT_PARAM_SLICE, 3,1,5,0)
		self.menu.lc:addParam("sep3", "", SCRIPT_PARAM_INFO, "")
	self.menu:addSubMenu("Harrass", "hr")
		self.menu.hr:addParam("useq", "Use Q", SCRIPT_PARAM_ONOFF, true)
		self.menu.hr:addParam("minqmana", "Min Q Mana %", SCRIPT_PARAM_SLICE, 15,0,100,0)
		self.menu.hr:addParam("sep1", "", SCRIPT_PARAM_INFO, "")
		self.menu.hr:addParam("usew", "Use W", SCRIPT_PARAM_ONOFF, true)
		self.menu.hr:addParam("minwmana", "Min W Mana %", SCRIPT_PARAM_SLICE, 15,0,100,0)
		self.menu.hr:addParam("wdirection", "W Direction", SCRIPT_PARAM_LIST, 1, {"Towards", "Away"})
		self.menu.hr:addParam("sep2", "", SCRIPT_PARAM_INFO, "")
		self.menu.hr:addParam("usee", "Use E", SCRIPT_PARAM_ONOFF, false)
		self.menu.hr:addParam("minemana", "Min E Mana %", SCRIPT_PARAM_SLICE, 15,0,100,0)
		self.menu.hr:addParam("sep3", "", SCRIPT_PARAM_INFO, "")
	self.menu:addSubMenu("Combo", "cb")
		self.menu.hr:addParam("useq", "Use Q", SCRIPT_PARAM_ONOFF, true)
		self.menu.hr:addParam("minqmana", "Min Q Mana %", SCRIPT_PARAM_SLICE, 15,0,100,0)
		self.menu.hr:addParam("sep1", "", SCRIPT_PARAM_INFO, "")
		self.menu.hr:addParam("usew", "Use W", SCRIPT_PARAM_ONOFF, true)
		self.menu.hr:addParam("minwmana", "Min W Mana %", SCRIPT_PARAM_SLICE, 15,0,100,0)
		self.menu.hr:addParam("wdirection", "W Direction", SCRIPT_PARAM_LIST, 1, {"Towards", "Away"})
		self.menu.hr:addParam("sep2", "", SCRIPT_PARAM_INFO, "")
		self.menu.hr:addParam("usee", "Use E", SCRIPT_PARAM_ONOFF, false)
		self.menu.hr:addParam("minemana", "Min E Mana %", SCRIPT_PARAM_SLICE, 15,0,100,0)
		self.menu.hr:addParam("sep3", "", SCRIPT_PARAM_INFO, "")
end

function Ziggs:OnTick()
	if self.orb:GetMode() != 0 then
		self.target = self.orb:
	end
end

function printC(arg)
	print('<font color=\"#515151\">S1mple_Ziggs_2</font><font color=\"#000000\"> - </font><font color=\"#cccccc\">'..arg..'</font>')
end

function OnLoad()
	Ziggs()	
end




class "Download"
function Download:__init()
	socket = require("socket")
	self.aktivedownloads = {}
	self.callbacks = {}

	AddTickCallback(function ()
		self:RemoveDone()
	end)

	class("Async")
	function Async:__init(host, filepath, localname, drawoffset, localpath)
		self.progress = 0
		self.host = host
		self.filepath = filepath
		self.localname = localname
		self.offset = drawoffset
		self.localpath = localpath
		self.CRLF = '\r\n'

		self.headsocket = socket.tcp()
		self.headsocket:settimeout(1)
		self.headsocket:connect(self.host, 80)
		self.headsocket:send('HEAD '..self.filepath..' HTTP/1.1'.. self.CRLF ..'Host: '..self.host.. self.CRLF ..'User-Agent: Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36'.. self.CRLF .. self.CRLF)

		self.HEADdata = ""
		self.DLdata = ""
		self.StartedDownload = false
		self.canDL = true

		AddTickCallback(function ()
			self:tick()
		end)
		AddDrawCallback(function ()
			self:draw()
		end)
	end

	function Async:tick()
		if self.progress == 100 then return end
		if self.HEADcStatus ~= "timeout" and self.HEADcStatus ~= "closed" then
			self.HEADfString, self.HEADcStatus, self.HEADpString = self.headsocket:receive(16);
			if self.HEADfString then
				self.HEADdata = self.HEADdata..self.HEADfString
			elseif self.HEADpString and #self.HEADpString > 0 then
				self.HEADdata = self.HEADdata..self.HEADpString
			end
		elseif self.HEADcStatus == "timeout" then
			self.headsocket:close()
			--Find Lenght
			local begin = string.find(self.HEADdata, "Length: ")
			if begin then
				self.HEADdata = string.sub(self.HEADdata,begin+8)
				local n = 0
				local _break = false
				for i=1, #self.HEADdata do
					local c = tonumber(string.sub(self.HEADdata,i,i))
					if c and _break == false then
						n = n+1
					else
						_break = true
					end
				end
				self.HEADdata = string.sub(self.HEADdata,1,n)
				self.StartedDownload = true
				self.HEADcStatus = "closed"
			end
		end
		if self.HEADcStatus == "closed" and self.StartedDownload == true and self.canDL == true then --Double Check
			self.canDL = false
			self.DLsocket = socket.tcp()
			self.DLsocket:settimeout(1)
			self.DLsocket:connect(self.host, 80)
			--Start Main Download
			self.DLsocket:send('GET '..self.filepath..' HTTP/1.1'.. self.CRLF ..'Host: '..self.host.. self.CRLF ..'User-Agent: Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36'.. self.CRLF .. self.CRLF)
		end
		
		if self.DLsocket and self.DLcStatus ~= "timeout" and self.DLcStatus ~= "closed" then
			self.DLfString, self.DLcStatus, self.DLpString = self.DLsocket:receive(1024);
			
			if ((self.DLfString) or (self.DLpString and #self.DLpString > 0)) then
				self.DLdata = self.DLdata .. (self.DLfString or self.DLpString)
			end

		elseif self.DLcStatus and self.DLcStatus == "timeout" then
			self.DLsocket:close()
			self.DLcStatus = "closed"
			self.DLdata = string.sub(self.DLdata,#self.DLdata-tonumber(self.HEADdata)+1)

			local file = io.open(self.localpath.."\\"..self.localname, "w+b")
			file:write(self.DLdata)
			file:close()
			self.progress = 100
		end

		if self.progress ~= 100 and self.DLdata and #self.DLdata > 0 then
			self.progress = (#self.DLdata/tonumber(self.HEADdata))*100
		end
	end

	function Async:draw()
		if self.progress < 100 then
			DrawTextA("Downloading: "..self.localname,15,50,35+self.offset)
			DrawRectangleOutline(49,50+self.offset,250,20, ARGB(255,255,255,255),1)
			if self.progress ~= 100 then
				DrawLine(50,60+self.offset,50+(2.5*self.progress),60+self.offset,18,ARGB(150,255-self.progress*2.5,self.progress*2.5,255-self.progress*2.5))
				DrawTextA(tostring(math.round(self.progress).." %"), 15,150,52+self.offset)
			end
		end
	end

end

function Download:newDL(host, file, name, path, callback)
	local offset = (#self.aktivedownloads+1)*40
	self.aktivedownloads[#self.aktivedownloads+1] = Async(host, file, name, offset-40, path)
	if not callback then
		callback = (function ()
		end)
	end

	self.callbacks[#self.callbacks+1] = callback

end

function Download:RemoveDone()
	if #self.aktivedownloads == 0 then return end
	local x = {}
	for k, v in pairs(self.aktivedownloads) do
		if math.round(v.progress) < 100 then
			v.offset = k*40-40
			x[#x+1] = v
		else
			self.callbacks[k]()
		end
	end
	self.aktivedownloads = {}
	self.aktivedownloads = x
end