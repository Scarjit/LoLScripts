--SCRIPT STATUS--
assert(load(Base64Decode("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"), nil, "bt", _ENV))() ScriptStatus("XKNONRJNORO") 
--SCRIPT STATUS--

class 'Nasus'
class 'Download'

function Nasus:__init()
	self.QStacks = ReadFile(LIB_PATH.."GalacticNasus.txt")
	if self.QStacks == "" then self.QStacks = 0 end
	if GetInGameTimer() <= 75 then self.QStacks = 0 end
	self:Remove(LIB_PATH.."GalacticNasus.txt", 0, 25)
	self.Version = 0.7
	self.QActive = false
	self.OrbWalkers = {}
	self.LoadedOrb = nil
	ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, 1600, DAMAGE_MAGICAL)
	enemyMinions = minionManager(MINION_ENEMY, 700, myHero, MINION_SORT_HEALTH_ASC)
	jungleMinions = minionManager(MINION_JUNGLE, 700, myHero, MINION_SORT_MAXHEALTH_DEC)
	self:Menu()
	self:LoadTableOrbs()
	self:LoadOrb()
	self:Callbacks()
	self:SendMsg("Loaded")
	self:CheckUpdates()
end

function Nasus:Menu()
if myHero:GetSpellData(SUMMONER_1).name:find("summonerdot") then Ignite = SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerdot") then Ignite = SUMMONER_2 end
  	Menu = scriptConfig("Galactic Nasus", "GalacticNasus")
	Menu:addSubMenu("Combo", "Combo")
	Menu:addSubMenu("LastHit", "LastHit")
	Menu:addSubMenu("LaneClear", "LaneClear")

	Menu.Combo:addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.Combo:addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true) 
	Menu.Combo:addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true) 
    Menu.Combo:addParam("ManaW", "% Mana to not use W", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
    Menu.Combo:addParam("ManaE", "% Mana to not use E", SCRIPT_PARAM_SLICE, 30, 0, 100, 0)

	Menu.LastHit:addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)

	Menu.LaneClear:addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.LaneClear:addParam("QL", "Only use Q to LastHit unit", SCRIPT_PARAM_ONOFF, true)

	if Ignite then 
	Menu:addSubMenu("KillSteal", "KillSteal")	
	Menu.KillSteal:addParam("Enable", "Enable KillSteal", SCRIPT_PARAM_ONOFF, true) 
	Menu.KillSteal:addParam("Ignite", "KillSteal with ignite", SCRIPT_PARAM_ONOFF, true) end
 
	Menu:addSubMenu("Draws", "Draws")	
	Menu.Draws:addParam("MinionsDmg", "Draw on minions", SCRIPT_PARAM_ONOFF, true) 

	ts.name = "Nasus"
	Menu:addTS(ts)

	Menu:addParam("info", "Author:", SCRIPT_PARAM_INFO, "HiranN")
	Menu:addParam("info2", "Your Region:", SCRIPT_PARAM_INFO, GetGameRegion())
	Menu:addParam("info3", "Stacks detected :", SCRIPT_PARAM_INFO, "0")
	Menu.info3 = self.QStacks
	if self.QStacks ~= 0 then self:SendMsg("Detected Stacks: "..self.QStacks) end
end

function Nasus:SendMsg(msg)
	PrintChat("<font color=\"#E94F42\"><b>[Galactic Nasus]</b></font> ".."<font color=\"#64e3ee\"><b>"..msg..".</b></font>")
end

function Nasus:LoadTableOrbs()
	if _G.Reborn_Loaded or _G.Reborn_Initialised or _G.AutoCarry ~= nil then
	table.insert(self.OrbWalkers, "SAC")
	end
	if _G.MMA_IsLoaded then
	table.insert(self.OrbWalkers, "MMA")
	end
	if _G._Pewalk then
	table.insert(self.OrbWalkers, "Pewalk")
	end
	if FileExist(LIB_PATH .. "/Nebelwolfi's Orb Walker.lua") then
	table.insert(self.OrbWalkers, "NOW")
	end
	if FileExist(LIB_PATH .. "/Big Fat Orbwalker.lua") then
	table.insert(self.OrbWalkers, "Big Fat Walk")
	end
	if FileExist(LIB_PATH .. "/SOW.lua") then
	table.insert(self.OrbWalkers, "SOW")
	end
	if FileExist(LIB_PATH .. "/SxOrbWalk.lua") then
	table.insert(self.OrbWalkers, "SxOrbWalk")
	end
	if #self.OrbWalkers > 0 then
	Menu:addSubMenu("Orbwalkers", "Orbwalkers")
	Menu:addSubMenu("Keys", "Keys")
	Menu.Orbwalkers:addParam("Orbwalker", "OrbWalker", SCRIPT_PARAM_LIST, 1, self.OrbWalkers)
	Menu.Keys:addParam("info", "Detecting keys from: "..self.OrbWalkers[Menu.Orbwalkers.Orbwalker], SCRIPT_PARAM_INFO, "")
	local OrbAlr = false
  	Menu.Orbwalkers:setCallback("Orbwalker", function(value) 
  	if OrbAlr then return end
  	OrbAlr = true
 	Menu.Orbwalkers:addParam("info", "Press F9 2x to load your selected Orbwalker.", SCRIPT_PARAM_INFO, "")
  	self:SendMsg("Press F9 2x to load your selected Orbwalker")
  	end)
	end
end

function Nasus:LoadOrb()
	if self.OrbWalkers[Menu.Orbwalkers.Orbwalker] == "SAC" then
	self.LoadedOrb = "Sac"
	TIMETOSACLOAD = false
	DelayAction(function() TIMETOSACLOAD = true end,15)
	elseif self.OrbWalkers[Menu.Orbwalkers.Orbwalker] == "MMA" then
	self.LoadedOrb = "Mma"
	elseif self.OrbWalkers[Menu.Orbwalkers.Orbwalker] == "Pewalk" then
	self.LoadedOrb = "Pewalk"
	elseif self.OrbWalkers[Menu.Orbwalkers.Orbwalker] == "NOW" then
	self.LoadedOrb = "Now"
	require "Nebelwolfi's Orb Walker"
	_G.NOWi = NebelwolfisOrbWalkerClass()
    Menu.Orbwalkers:addSubMenu("NOW", "NOW")
    _G.NebelwolfisOrbWalkerClass(Menu.Orbwalkers.NOW)	
	elseif self.OrbWalkers[Menu.Orbwalkers.Orbwalker] == "Big Fat Walk" then
	self.LoadedOrb = "Big"
	require "Big Fat Orbwalker"
	elseif self.OrbWalkers[Menu.Orbwalkers.Orbwalker] == "SOW" then
	self.LoadedOrb = "Sow"
	require "SOW"
    Menu.Orbwalkers:addSubMenu("SOW", "SOW")
    _G.SOWi = SOW(_G.VP)
	SOW:LoadToMenu(Menu.Orbwalkers.SOW)
	elseif self.OrbWalkers[Menu.Orbwalkers.Orbwalker] == "SxOrbWalk" then
	self.LoadedOrb = "SxOrbWalk"
	require "SxOrbWalk"
    Menu.Orbwalkers:addSubMenu("SxOrbWalk", "SxOrbWalk")
	SxOrb:LoadToMenu(Menu.Orbwalkers.SxOrbWalk)
	end
end

function Nasus:Keys()
	if self.LoadedOrb == "Sac" and TIMETOSACLOAD then
	if _G.AutoCarry.Keys.AutoCarry then return "Combo" end
	if _G.AutoCarry.Keys.MixedMode then return "Harass" end
	if _G.AutoCarry.Keys.LaneClear then return "Laneclear" end
	if _G.AutoCarry.Keys.LastHit then return "Lasthit" end
	elseif self.LoadedOrb == "Mma" then
	if _G.MMA_IsOrbwalking() then return "Combo" end
	if _G.MMA_IsDualCarrying() then return "Harass" end
	if _G.MMA_IsLaneClearing() then return "Laneclear" end
	if _G.MMA_IsLastHitting() then return "Lasthit" end
	elseif self.LoadedOrb == "Pewalk" then
	if _G._Pewalk.GetActiveMode().Carry then return "Combo" end
	if _G._Pewalk.GetActiveMode().Mixed then return "Harass" end
	if _G._Pewalk.GetActiveMode().LaneClear then return "Laneclear" end
	if _G._Pewalk.GetActiveMode().Farm then return "Lasthit" end
	elseif self.LoadedOrb == "Now" then
	if _G.NOWi.Config.k.Combo then return "Combo" end
	if _G.NOWi.Config.k.Harass then return "Harass" end
	if _G.NOWi.Config.k.LaneClear then return "Laneclear" end
	if _G.NOWi.Config.k.LastHit then return "Lasthit" end
	elseif self.LoadedOrb == "Big" then
	if _G["BigFatOrb_Mode"] == "Combo" then return "Combo" end
	if _G["BigFatOrb_Mode"] == "Harass" then return "Harass" end
	if _G["BigFatOrb_Mode"] == "LaneClear" then return "Laneclear" end
	if _G["BigFatOrb_Mode"] == "LastHit" then return "Lasthit" end
	elseif self.LoadedOrb == "Sow" then
	if _G.SOWi.Menu.Mode0 then return "Combo" end
	if _G.SOWi.Menu.Mode1 then return "Harass" end
	if _G.SOWi.Menu.Mode2 then return "Laneclear" end
	if _G.SOWi.Menu.Mode3 then return "Lasthit" end
	elseif self.LoadedOrb == "SxOrbWalk" then
	if _G.SxOrb.isFight then return "Combo" end
	if _G.SxOrb.isHarass then return "Harass" end
	if _G.SxOrb.isLaneClear then return "Laneclear" end
	if _G.SxOrb.isLastHit then return "Lasthit" end
	end
end

function Nasus:GetQDamage(unit)
	return ((myHero.totalDamage + getDmg("Q", unit, myHero) + self.QStacks) - unit.armor)
end

function Nasus:Callbacks()
	AddCreateObjCallback(function(obj) 
	if obj.name == "DeathsCaress_nova.troy" then 
	self.QStacks = self.QStacks + 3 
	Menu.info3 = self.QStacks
	end
	end)
	AddApplyBuffCallback(function(source, unit, buff) 
	if unit and buff and unit.isMe and buff.name == "NasusQ" then
	self.QActive = true
	end
	end)
	AddRemoveBuffCallback(function(unit, buff) 
	if unit and buff and unit.isMe and buff.name == "NasusQ" then
	self.QActive = false
	end
	end)
	AddUnloadCallback(function() 
	if self.QStacks ~= nil and self.QStacks ~= 0 then
	local file = io.open(LIB_PATH.."GalacticNasus.txt", "a")
	file:write(self.QStacks)
	file:close()
	end
	end)
	AddTickCallback(function()
	if myHero.dead then return end
	ts:update()
	Target = ts.target
	self:UseAttack()
	self:Combo(Target)
	self:LastHit()
	self:LaneClear()
	self:KillSteal()
	end)
	AddDrawCallback(function()
	if Menu.Draws.MinionsDmg then
  	enemyMinions:update()
  	jungleMinions:update()
 	for i, minion in pairs(enemyMinions.objects) do
	self:DrawBarPos(minion)
	end
	end
	end)
	ListUnitsTo6 = 
	{
	["SRU_ChaosMinionSiege"] = true,
	["SRU_Blue"] = true,
	["SRU_Red"] = true,
	["SRU_Gromp"] = true,
	["SRU_Murkwolf"] = true,
	["SRU_Razorbeak"] = true,
	["SRU_Krug"] = true,
	["SRU_Dragon"] = true,
	["SRU_Baron"] = true,
	}
	AddProcessAttackCallback(function(unit, spell)
	if unit and spell and unit.isMe and spell.name:lower():find("attack") and self.QActive then
	if ListUnitsTo6[spell.target.charName] or spell.target == myHero.type then
	if spell.target.dead then self.QStacks = self.QStacks+3 end
	end
	end
	end)
end

function Nasus:DrawBarPos(unit)
	local barPos = GetUnitHPBarPos(unit)
	local Color = (self:GetQDamage(unit) >= unit.health) and 0xFF009900 or 0xFFFF0000
	if unit.charName:lower():find("minion") then 
	self:DrawRectangle(barPos.x - 30, barPos.y-2, 60, 4, Color)
 	if self:GetQDamage(unit) >= unit.health then 
 	DrawCircle(unit.x, unit.y, unit.z, 50, 0xFF009900)
 	end
	end
end

function Nasus:DrawRectangle(x, y, width, height, color)  
  	local A = x - 1
  	local B = x + width
  	local C = y - 1
  	local D = y + height
  	DrawLine(A, C, B, C,     1, color) --> ---
  	DrawLine(A, C, A, D,     1, color) --> |
  	DrawLine(B, C, B, D,	 1, color) -->   |
  	DrawLine(A, D, B, D,     1, color) --> ___
end

function Nasus:Combo(target)
	if not ValidTarget(target) then return end
	if self:Keys() == "Combo" then
	if Menu.Combo.Q and GetDistance(target) <= 280 then self:Cast(_Q, target) end
	if Menu.Combo.W and GetDistance(target) <= 600 and Menu.Combo.ManaW <= 100*myHero.mana/myHero.maxMana then self:Cast(_W, target) end
	if Menu.Combo.E and GetDistance(target) <= 350 and Menu.Combo.ManaE <= 100*myHero.mana/myHero.maxMana then self:Cast(_E, target) end
end
end

function Nasus:Cast(spell, target)
	if spell and ValidTarget(target) then
		if spell == _Q and myHero:CanUseSpell(_Q) == READY and not self:Blind(myHero) and not self:Immortal(target) then
			CastSpell(_Q)
		elseif spell == _W and myHero:CanUseSpell(_W) == READY then
			CastSpell(_W, target)
		elseif spell == _E and myHero:CanUseSpell(_E) == READY then
			CastSpell(_E, target.x, target.z)
		elseif spell == _R and myHero:CanUseSpell(_R) == READY then
		end
	end
end

function Nasus:Blind(unit)
	for i = 1, unit.buffCount do
		local buff = unit:getBuff(i)
		if buff and buff.valid and buff.endT > GetInGameTimer() and buff.type == 25 then
			return true
		end
	end
	return false
end

function Nasus:Immortal(unit)
	if TargetHaveBuff("judicatorintervention", unit) then 
		return true
	elseif TargetHaveBuff("undyingrage", unit) then 
		return true
	elseif TargetHaveBuff("sionpassivezombie", unit) then 
		return true
	elseif TargetHaveBuff("aatroxpassivedeath", unit) then 
		return true
	elseif TargetHaveBuff("chronoshift", unit) then 
		return true 
	end
    return false
end

AttackTime = 0 
function Nasus:UseAttack()
  	enemyMinions:update()
  	jungleMinions:update()
	if self:Keys() == "Laneclear" or self:Keys() == "Lasthit" and self.QActive then
 	for i, minion in pairs(enemyMinions.objects) do
	if self:GetQDamage(minion) >= minion.health and GetDistance(minion) <= 275 and os.clock()-AttackTime > 0.40 then
	myHero:Attack(minion)
	AttackTime = os.clock()
	end
	end
	end
end

function Nasus:LastHit()
	if self:Keys() == "Lasthit" then
  	enemyMinions:update()
  	jungleMinions:update()
 	for i, minion in pairs(enemyMinions.objects) do
	if Menu.LastHit.Q and myHero:CanUseSpell(_Q) == READY and self:GetQDamage(minion) >= minion.health and GetDistance(minion) <= 275 then 
	self:Cast(_Q, minion) end
	end
 	for i, minion in pairs(jungleMinions.objects) do
	if Menu.LastHit.Q and myHero:CanUseSpell(_Q) == READY and self:GetQDamage(minion) >= minion.health and GetDistance(minion) <= 275 then 
	self:Cast(_Q, minion) end
	end
	end
end

function Nasus:LaneClear()
	if self:Keys() == "Laneclear" then
  	enemyMinions:update()
  	jungleMinions:update()
 	for i, minion in pairs(enemyMinions.objects) do
 	if Menu.LaneClear.QL then 
	if Menu.LaneClear.Q and myHero:CanUseSpell(_Q) == READY and self:GetQDamage(minion) >= minion.health and GetDistance(minion) <= 275 then 
	self:Cast(_Q, minion) end
	elseif not Menu.LaneClear.QL then
	if Menu.LaneClear.Q and myHero:CanUseSpell(_Q) == READY and GetDistance(minion) <= 275 then 
	self:Cast(_Q, minion) end
	end
	end
 	for i, minion in pairs(jungleMinions.objects) do
 	if Menu.LaneClear.QL then 
	if Menu.LaneClear.Q and myHero:CanUseSpell(_Q) == READY and self:GetQDamage(minion) >= minion.health and GetDistance(minion) <= 275 then 
	self:Cast(_Q, minion) end
	elseif not Menu.LaneClear.QL then
	if Menu.LaneClear.Q and myHero:CanUseSpell(_Q) == READY and GetDistance(minion) <= 275 then 
	self:Cast(_Q, minion) end
	end
	end
end
end

function Nasus:KillSteal()
	if not Ignite then return end
	if not Menu.KillSteal.Enable then return end 
  	for _, unit in pairs(GetEnemyHeroes()) do
 	local EnemyH = unit.health + unit.hpRegen * 2
 	if Menu.KillSteal.Ignite then
 	if EnemyH <= 40 + (20 * myHero.level) and myHero:CanUseSpell(Ignite) == READY and ValidTarget(unit) and GetDistance(unit) <= 875 then
 	CastSpell(Ignite, unit)
 	end
 	end
 	end
end

function Nasus:Remove(filename, starting_line, num_lines)
    local fp = io.open( filename, "r" )
    if fp == nil then return nil end
    content = {}
    i = 1;
    for line in fp:lines() do
    if i < starting_line or i >= starting_line + num_lines then
	content[#content+1] = line
	end
	i = i + 1
    end
    fp:close()
    fp = io.open( filename, "w+" )
    for i = 1, #content do
	fp:write( string.format( "%s\n", content[i] ) )
    end
    fp:close()
end

local serveradress = "raw.githubusercontent.com"
local scriptadress = "/HiranN/BoL/master"
local scriptname = "Galactic Nasus"
local adressfull = "http://"..serveradress..scriptadress.."/"..scriptname..".lua"
function Nasus:CheckUpdates()
  	local ServerVersionDATA = GetWebResult("www.scarjit.de", "/HiranN/BoL/Versions/Nasus.version")  
  	local ServerVersion = tonumber(ServerVersionDATA)
  	if ServerVersionDATA then
  	if ServerVersion then
  	if ServerVersion > tonumber(self.Version) then
  	self:SendMsg("Updating, don't press F9")
  	DL = Download()
  	file = "/HiranN/BoL/Scripts/Nasus.lua"
  	name = GetCurrentEnv().FILE_NAME
  	DL:newDL("www.scarjit.de", file, name, SCRIPT_PATH, function()
  	self:SendMsg("Downloaded update, press F9 2x to reload")
  	end)
  	else
  	self:SendMsg("No updates found")
  	end
  	end
	end
end

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

BloCklist =
{
["bcipa3"] = true,
}

if myHero.charName ~= "Nasus" then return end

if BloCklist[GetUser()] then 
PrintChat("<font color=\"#E94F42\"><b>[Galactic Nasus]</b></font> ".."<font color=\"#64e3ee\"><b>Script blocked for you </b></font><font color=\"#ffff33\"><b>"..GetUser().."</b></font><font color=\"#64e3ee\"><b>.</b></font>")
return end

function OnLoad() Nasus() end