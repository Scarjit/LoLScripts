if myHero.charName ~= "MissFortune" then return end

-- Script Status --
assert(load(Base64Decode("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"), nil, "bt", _ENV))() ScriptStatus("VILMHOLHLHL") 
-- Script Status --

local ts
local LocalVersion = "1.8"
local autoupdate = true -- Change to false if you don't want autoupdates.

	function OnLoad()
	if myHero:GetSpellData(SUMMONER_1).name:find("summonerdot") then Ignite = SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerdot") then Ignite = SUMMONER_2 end
	
	Menu = scriptConfig("HR Miss Fortune", "HRMissFortune")
	
	Menu:addSubMenu("Combo", "combo")
	Menu.combo:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.combo:addParam("UseW", "Use W", SCRIPT_PARAM_ONOFF, true)
	Menu.combo:addParam("UseE", "Use E", SCRIPT_PARAM_ONOFF, true)
	Menu.combo:addParam("UseR", "Use R", SCRIPT_PARAM_ONOFF, true)
	Menu.combo:addParam("BlockRMove", "Block Move (Orbwalk) when using R", SCRIPT_PARAM_ONOFF, true)
	Menu.combo:addParam("UseRK", "Use R if enemy killable", SCRIPT_PARAM_ONOFF, true)
	Menu.combo:addParam("AutoR", "Auto R", SCRIPT_PARAM_ONOFF, true)
	Menu.combo:addParam("AutoRH", "Auto R in x enemies",  SCRIPT_PARAM_SLICE, 3, 1, 5, 0) 
	
	Menu:addSubMenu("Harass", "harass")
	Menu.harass:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.harass:addParam("mManager", "Harass Mana",  SCRIPT_PARAM_SLICE, 30, 0, 100, 0) 
	
	Menu:addSubMenu("LaneClear", "laneclear")
	Menu.laneclear:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.laneclear:addParam("mManager", "LaneClear Mana",  SCRIPT_PARAM_SLICE, 25, 0, 100, 0) 
	
	Menu:addSubMenu("JungleClear", "jungleclear")
	Menu.jungleclear:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.jungleclear:addParam("mManager", "JungleClear Mana",  SCRIPT_PARAM_SLICE, 25, 0, 100, 0) 
	
	Menu:addSubMenu("HitChance", "hitchance")
	Menu.hitchance:addParam("EHitCH", "E Hit Chance",  SCRIPT_PARAM_SLICE, 2, 1, 5, 1) 
	Menu.hitchance:addParam("RHitCH", "R Hit Chance",  SCRIPT_PARAM_SLICE, 2, 1, 5, 1) 
	
	Menu:addSubMenu("KillSteal", "killsteal")
	Menu.killsteal:addParam("KSOn", "KillSteal", SCRIPT_PARAM_ONOFF, true)
	Menu.killsteal:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
	if Ignite then Menu.killsteal:addParam("I", "Use Ignite", SCRIPT_PARAM_ONOFF, true) end
	
	Menu:addSubMenu("Draw Settings", "drawing")	
	Menu.drawing:addParam("mDraw", "Disable All Range Draws", SCRIPT_PARAM_ONOFF, false)
	Menu.drawing:addParam("myHero", "Draw My Range", SCRIPT_PARAM_ONOFF, true)
	Menu.drawing:addParam("qDraw", "(Q) Range", SCRIPT_PARAM_ONOFF, true)
	Menu.drawing:addParam("qColor", "(Q) Color", SCRIPT_PARAM_COLOR, {255, 255, 40, 164})
	Menu.drawing:addParam("eDraw", "(E) Range", SCRIPT_PARAM_ONOFF, true)
	Menu.drawing:addParam("eColor", "(E) Color", SCRIPT_PARAM_COLOR, {255, 255, 40, 164})
	Menu.drawing:addParam("rDraw", "(R) Range", SCRIPT_PARAM_ONOFF, true)
	Menu.drawing:addParam("rColor", "(R) Color", SCRIPT_PARAM_COLOR, {255, 255, 40, 164})
	Menu.drawing:addParam("tText", "Draw Current Target Text", SCRIPT_PARAM_ONOFF, true)
	
	Menu:addSubMenu("Keys", "keys")
	Menu.keys:addParam("ComboKey", "Combo Key", SCRIPT_PARAM_ONKEYDOWN, false, 32)
	Menu.keys:addParam("Harass", "Harass", SCRIPT_PARAM_ONKEYDOWN, false, 67)
	Menu.keys:addParam("LaneJungClear", "LaneClear / JungleClear", SCRIPT_PARAM_ONKEYDOWN, false, 86)
	
	Menu:addParam("pred", "Prediction Type", SCRIPT_PARAM_LIST, 1, { "VPrediction", "HPrediction"})
	Menu:addParam("AutoQ", "Auto Q in minion to hit enemies", SCRIPT_PARAM_ONOFF, true)
	CustomLoad()
	
	if FileExist(LIB_PATH .. "/HPrediction.lua") then
	require 'HPrediction'

	HPred = HPrediction()
	HP_E = HPSkillshot({type = "DelayCircle", delay = 0.20, range = 1000, width = 200, speed = math.huge})
	HP_R = HPSkillshot({type = "Triangle", delay = 0.25, range = 1400, width = 700, speed = math.huge})
	UseHP = true
else
	UseHP = false
	PrintChat("<font color=\"#FF7B24\"><b>[HR Miss Fortune] </b></font>".."<font color=\"#0FCBB4\"><b>If you want other Prediction download : HPrediction.</b></font>")
end

    if _G.Reborn_Loaded or _G.AutoCarry then
	PrintChat("<font color=\"#FF7B24\"><b>[HR Miss Fortune] </b></font>".."<font color=\"#0FCBB4\"><b>Loading SAC.</b></font>")
	DelayAction(function()  
	SAC = true
	SX = false
	PrintChat("<font color=\"#FF7B24\"><b>[HR Miss Fortune] </b></font>".."<font color=\"#0FCBB4\"><b>SAC Loaded.</b></font>")	
	end, 10)
	else
  	LoadOrb()
	end
	
	end
	
	function CustomLoad()
	CheckVPred()
	Skills()		
	FindUpdates()
	
	enemyMinions = minionManager(MINION_ENEMY, 700, myHero, MINION_SORT_HEALTH_ASC)
	jungleMinions = minionManager(MINION_JUNGLE, 700, myHero, MINION_SORT_MAXHEALTH_DEC)
	ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, 1000, DAMAGE_MAGIC)
	ts.name = "Miss Fortune"
	Menu:addTS(ts)
	PriorityOnLoad()
  end
  
	function LoadOrb()
	if FileExist(LIB_PATH .. "/SxOrbWalk.lua") then
	PrintChat("<font color=\"#FF7B24\"><b>[HR Miss Fortune] </b></font>".."<font color=\"#0FCBB4\"><b>Loading SxOrbWalk.</b></font>")
	require("SxOrbWalk")
	PrintChat("<font color=\"#FF7B24\"><b>[HR Miss Fortune] </b></font>".."<font color=\"#0FCBB4\"><b>SxOrbWalk Loaded.</b></font>")	
	Menu:addSubMenu("SxOrbWalk", "SXMenu")
	SxOrb:LoadToMenu(Menu.SXMenu)
	SAC = false
	SX = true
	else
	local ToUpdate = {}
    ToUpdate.Version = 1
    ToUpdate.UseHttps = true
    ToUpdate.Host = "raw.githubusercontent.com"
    ToUpdate.VersionPath = "/Superx321/BoL/master/common/SxOrbWalk.Version"
    ToUpdate.ScriptPath =  "/Superx321/BoL/master/common/SxOrbWalk.lua"
    ToUpdate.SavePath = LIB_PATH.."/SxOrbWalk.lua"
    ToUpdate.CallbackUpdate = function(NewVersion,OldVersion) print("<font color=\"#FF794C\"><b>SxOrbWalk: </b></font> <font color=\"#FFDFBF\">Updated to "..NewVersion..". </b></font>") end
    ToUpdate.CallbackNoUpdate = function(OldVersion) print("<font color=\"#FF794C\"><b>SxOrbWalk: </b></font> <font color=\"#FFDFBF\">No Updates Found</b></font>") end
    ToUpdate.CallbackNewVersion = function(NewVersion) print("<font color=\"#FF794C\"><b>SxOrbWalk: </b></font> <font color=\"#FFDFBF\">New Version found ("..NewVersion.."). Please wait until its downloaded</b></font>") end
    ToUpdate.CallbackError = function(NewVersion) print("<font color=\"#FF794C\"><b>SxOrbWalk: </b></font> <font color=\"#FFDFBF\">Error while Downloading. Please try again.</b></font>") end
    ScriptUpdate(ToUpdate.Version,ToUpdate.UseHttps, ToUpdate.Host, ToUpdate.VersionPath, ToUpdate.ScriptPath, ToUpdate.SavePath, ToUpdate.CallbackUpdate,ToUpdate.CallbackNoUpdate, ToUpdate.CallbackNewVersion,ToUpdate.CallbackError)
	end
end
	
	function CheckVPred()
		if FileExist(LIB_PATH .. "/VPrediction.lua") then
		require("VPrediction")
		VP = VPrediction()
	else
		local ToUpdate = {}
		ToUpdate.Version = 0.0
		ToUpdate.UseHttps = true
		ToUpdate.Name = "VPrediction"
		ToUpdate.Host = "raw.githubusercontent.com"
		ToUpdate.VersionPath = "/SidaBoL/Scripts/master/Common/VPrediction.version"
		ToUpdate.ScriptPath =  "/SidaBoL/Scripts/master/Common/VPrediction.lua"
		ToUpdate.SavePath = LIB_PATH.."/VPrediction.lua"
		ToUpdate.CallbackUpdate = function(NewVersion,OldVersion) print("<font color=\"#FF794C\"><b>" .. ToUpdate.Name .. ": </b></font> <font color=\"#FFDFBF\">Updated to "..NewVersion..". Please Reload with 2x F9</b></font>") end
		ToUpdate.CallbackNoUpdate = function(OldVersion) print("<font color=\"#FF794C\"><b>" .. ToUpdate.Name .. ": </b></font> <font color=\"#FFDFBF\">No Updates Found</b></font>") end
		ToUpdate.CallbackNewVersion = function(NewVersion) print("<font color=\"#FF794C\"><b>" .. ToUpdate.Name .. ": </b></font> <font color=\"#FFDFBF\">New Version found ("..NewVersion.."). Please wait until its downloaded</b></font>") end
		ToUpdate.CallbackError = function(NewVersion) print("<font color=\"#FF794C\"><b>" .. ToUpdate.Name .. ": </b></font> <font color=\"#FFDFBF\">Error while Downloading. Please try again.</b></font>") end
		ScriptUpdate(ToUpdate.Version,ToUpdate.UseHttps, ToUpdate.Host, ToUpdate.VersionPath, ToUpdate.ScriptPath, ToUpdate.SavePath, ToUpdate.CallbackUpdate,ToUpdate.CallbackNoUpdate, ToUpdate.CallbackNewVersion,ToUpdate.CallbackError)
	end
	end
	
function OnWndMsg(msg,wParam) 
	if myHero:CanUseSpell(_R) == READY then
	if msg == KEY_DOWN and wParam == 0x52 then 
	Ulting = true
	end
end
end
	
function DmgR()
	local RDmg

	RLevel = myHero:GetSpellData(_R).level
	if RLevel == 1 then
	RDmg = myHero.damage*12 + myHero.ap*10
	elseif RLevel == 2 then
	RDmg = myHero.damage*14 + myHero.ap*12
	elseif RLevel == 3 then
	RDmg = myHero.damage*16 + myHero.ap*14
	end
	return RDmg
end

	function UseSpells()
	for _, unit in pairs(GetEnemyHeroes()) do
		local health = unit.health
		local dmgQ = getDmg("Q", unit, myHero)
		local dmgE = getDmg("E", unit, myHero)

		if GetDistance(unit) <= 800 then
		if not Menu.killsteal.KSOn then return end
			if health <= dmgQ and Menu.killsteal.UseQ and myHero:CanUseSpell(_Q) == READY and ValidTarget(unit) then
				CastSpell(_Q, unit)
				end
				if Ignite then
			if health <= 40 + (20 * myHero.level) and Menu.killsteal.I and myHero:CanUseSpell(Ignite) == READY and ValidTarget(unit) then
				CastSpell(Ignite, unit)
			end
			end
	end
	end
	end
	

function OnApplyBuff(source, unit, buff)
	if unit and source and buff and unit.isMe and buff.name:lower():find("missfortunebulletsound") then
	Ulting = true
end
end

function OnRemoveBuff(unit, buff)
	if unit and buff and unit.isMe and buff.name:lower():find("missfortunebulletsound") then
	Ulting = false
end
end
	
	function OnTick()
	if myHero.dead then return end
	
	ts:update()
	
	Target = GetCustomTarget()
	
	ComboKey = Menu.keys.ComboKey
	HarassKey = Menu.keys.Harass
	LaneClearKey = Menu.keys.LaneJungClear
	JungleClearKey = Menu.keys.LaneJungClear
	
	if Menu.combo.BlockRMove then
	if Ulting then
	if SAC then
	_G.AutoCarry.MyHero:MovementEnabled(false)
	_G.AutoCarry.MyHero:AttacksEnabled(false)
	end
	if SX then
	SxOrb:DisableMove()
	SxOrb:DisableAttacks()	
	end
	
	else
	
	if SAC then
	_G.AutoCarry.MyHero:MovementEnabled(true)
	_G.AutoCarry.MyHero:AttacksEnabled(true)
	end
	if SX then
	SxOrb:EnableMove()
	SxOrb:EnableAttacks()
	end
	end
	end
	
	if Ulting then return end
	
	if ComboKey then 
	Combo(Target)
	end
	
	if HarassKey and not ComboKey then
	Harass(Target)
	end	
	
	if LaneClearKey and not ComboKey then
	LaneClear()
	end
	
	if JungleClearKey and not ComboKey then
	JungleClear()
	end
	
	if Menu.combo.AutoR then
	AutoR()
	end
	
	if Menu.combo.UseRK then
	KillWithR()
	end
	
	if Menu.AutoQ then
	AutoQ()
	end
	
	UseSpells()
	
	end
	
function GetCustomTarget()
	ts:update()	
	if ValidTarget(ts.target) and ts.target.type == myHero.type then
		return ts.target
	else
		return nil
	end
end

function Combo(unit)
	if ValidTarget(unit) and unit ~= nil and unit.type == myHero.type then

		if Menu.combo.UseQ and GetDistance(unit) <= 650 and myHero:CanUseSpell(_Q) == READY then 
		CastSpell(_Q, unit)
		end	
		
		if Menu.combo.UseW and myHero:CanUseSpell(_W) == READY then 
		CastSpell(_W)
		end	
		
		if Menu.combo.UseE and GetDistance(unit, myHero) >= 700 then 
		CastE(unit)
		end	
	end
end

function Harass(unit)
	if myHero:CanUseSpell(_Q) == READY and not IsMyManaLowHarass() and ts.target ~= nil and Menu.harass.UseQ then 
	CastSpell(_Q, unit)
	end
end

function IsMyManaLowLaneClear()
    if myHero.mana < (myHero.maxMana * ( Menu.laneclear.mManager / 100)) then
        return true
    else
        return false
    end
end

function IsMyManaLowJungleClear()
    if myHero.mana < (myHero.maxMana * ( Menu.jungleclear.mManager / 100)) then
        return true
    else
        return false
    end
end

function IsMyManaLowHarass()
    if myHero.mana < (myHero.maxMana * ( Menu.harass.mManager / 100)) then
        return true
    else
        return false
    end
end

function LaneClear()
	enemyMinions:update()
	if not IsMyManaLowLaneClear() then
		for i, minion in pairs(enemyMinions.objects) do
			if ValidTarget(minion) and minion ~= nil then
				if Menu.laneclear.UseQ and GetDistance(minion) <= 650 and myHero:CanUseSpell(_Q) == READY then
					if SAC then 
					if not _G.AutoCarry.Orbwalker:CanShoot() then
					CastSpell(_Q, minion)
					end
					end

					if SX then 
					if not _G.SxOrb:CanAttack() then
					CastSpell(_Q, minion)
					end
					end	
end
end
end
end
end

function JungleClear()
	jungleMinions:update()
	if not IsMyManaLowJungleClear() then
	for i, jungleMinion in pairs(jungleMinions.objects) do
		if jungleMinion ~= nil then
		if Menu.jungleclear.UseQ then CastSpell(_Q, jungleMinion) end
		end
end
end
end

function CastE(unit)
	if Menu.pred == 1 then
	if unit ~= nil and GetDistance(unit) <= SkillE.range and myHero:CanUseSpell(_E) == READY then
		CastPosition,  HitChance,  Position = VP:GetCircularAOECastPosition(unit, SkillE.delay, SkillE.width, SkillE.range, SkillE.speed, myHero, false)
 
		if HitChance >= Menu.hitchance.EHitCH then
			CastSpell(_E, CastPosition.x, CastPosition.z)
		end
	end
	elseif Menu.pred == 2 then
  local EPos, EHitChance = HPred:GetPredict(HP_E, unit, myHero)
  
  if EHitChance > Menu.hitchance.EHitCH then
    CastSpell(_E, EPos.x, EPos.z)
  end
  end
 end
 
function AutoR()
  	for _, enemy in pairs(GetEnemyHeroes()) do
		if GetDistance(enemy) <= 1150 then
           local AOECastPosition, MainTargetHitChance, nTargets = VP:GetConeAOECastPosition(enemy, SkillR.delay, SkillR.width, SkillR.range, SkillR.speed, myHero, false)
           if MainTargetHitChance >= 2 and GetDistance(AOECastPosition) <= SkillR.range and nTargets >= Menu.combo.AutoRH and not enemy.dead and myHero:CanUseSpell(_R) == READY then
		  Ulting = true
		  DelayAction(function()CastSpell(_R, AOECastPosition.x, AOECastPosition.z)end, 0.125)
		   end
		   end
end
end

function KillWithR()
  	for _, unit in pairs(GetEnemyHeroes()) do 
	if GetDistance(unit, myHero) <= 900 then
	if unit ~= nil and GetDistance(unit) <= SkillR.range and myHero:CanUseSpell(_R) == READY then
	if ValidTarget(unit) and unit ~= nil and unit.type == myHero.type then
	if unit.health <= DmgR() and GetDistance(unit) <= 1000 then
		CastPosition,  HitChance,  Position = VP:GetConeAOECastPosition(unit, SkillR.delay, SkillR.width, SkillR.range, SkillR.speed, myHero, false)
		if HitChance >= Menu.hitchance.RHitCH then
			Ulting = true
			DelayAction(function()CastSpell(_R, CastPosition.x, CastPosition.z)end, 0.125)
		end
	end
end
end
end
end
end

function AutoQ()
		enemyMinions:update()
		for i, minion in pairs(enemyMinions.objects) do
		for i = 1, heroManager.iCount do
		local enemy = heroManager:getHero(i)
		if ValidTarget(minion) and minion ~= nil then
		if ValidTarget(enemy) and enemy ~= nil then
		if GetQ(minion, enemy) and myHero:CanUseSpell(_Q) == READY then
		if enemy.dead then return end
		CastSpell(_Q, minion)
		end
		end
		end
		end
		end
end

function OnDraw()
	if not myHero.dead and not Menu.drawing.mDraw then

		if myHero:CanUseSpell(_Q) == READY and Menu.drawing.qDraw then 
			DrawCircle(myHero.x, myHero.y, myHero.z, 700, RGB(Menu.drawing.qColor[2], Menu.drawing.qColor[3], Menu.drawing.qColor[4]))
		end
		
		if myHero:CanUseSpell(_E) == READY and Menu.drawing.eDraw then 
			DrawCircle(myHero.x, myHero.y, myHero.z, SkillE.range, RGB(Menu.drawing.eColor[2], Menu.drawing.eColor[3], Menu.drawing.eColor[4]))
		end
		
		if myHero:CanUseSpell(_R) == READY and Menu.drawing.rDraw then 
			DrawCircle(myHero.x, myHero.y, myHero.z, SkillR.range, RGB(Menu.drawing.rColor[2], Menu.drawing.rColor[3], Menu.drawing.rColor[4]))
		end
		
		if Menu.drawing.myHero then
			DrawCircle(myHero.x, myHero.y, myHero.z, 590, RGB(250, 6, 6))
		end

		if Target ~= nil and ValidTarget(Target) then
			if Menu.drawing.tText then
			DrawText3D("Current Target",Target.x-100, Target.y-50, Target.z, 20, 0xFFFFFF00)
		end
		end
end
end

function GetQ(minion, unit)
	if minion == nil or unit == nil or GetDistanceSqr(unit, triangle_target) > 700 * 700 or GetDistanceSqr(myHero, triangle_target) > 700 * 700 then return end

	for i, secure_minion in pairs(enemyMinions.objects) do
		if secure_minion == nil then return end

		if GetTriangle(minion, 40, unit) and TargetHaveBuff("missfortunepassivestack", unit) then
			return true
		end
		if GetTriangle(minion, 20, unit) and ((GetTriangle(minion, 20, secure_minion) and GetDistance(minion, secure_minion) > GetDistance(minion, unit)) or not GetTriangle(minion, 20, secure_minion)) and minion ~= secure_minion then
			return true
		end
		if GetTriangle(minion, 40, unit) and ((GetTriangle(minion, 40, secure_minion) and GetDistance(minion, secure_minion) > GetDistance(minion, unit)) or not GetTriangle(minion, 40, secure_minion)) and minion ~= secure_minion then
			return true
		end
		if GetTriangle(minion, 90, unit) and ((GetTriangle(minion, 90, secure_minion) and GetDistance(minion, secure_minion) > GetDistance(minion, unit)) or not GetTriangle(minion, 90, secure_minion)) and minion ~= secure_minion then
			return true
		end
	end

	return false
end

function GetTriangle(triangle_target, angle, unit)
	if triangle_target == nil or unit == nil or GetDistanceSqr(unit, triangle_target) > 700 * 700 or GetDistanceSqr(myHero, triangle_target) > 700 * 700 then return end

	v1 = (Vector(triangle_target) - Vector(myHero)):rotated(0, angle / (180 * math.pi), 0):normalized()
	v2 = (Vector(triangle_target) - Vector(myHero)):rotated(0, -(angle / (180 * math.pi)), 0):normalized()
	triangle = Polygon(Point(triangle_target.x, triangle_target.z), Point(triangle_target.x + 300 * v1.x, triangle_target.z + 300 * v1.z), Point(triangle_target.x + 300 * v2.x, triangle_target.z + 300 * v2.z))

	if triangle:contains(Point(unit.x, unit.z)) then
		return true
	else
		return false
	end
end

function Skills()
	SkillE = { name = "", range = 1000, delay = 0.25, speed = math.huge, width = 200, ready = false }
	SkillR = { name = "", range = 1400, delay = 0.25, speed = math.huge, width = 700, ready = false }
end
	
local priorityTable = {
 
    AP = {
        "Annie", "Ahri", "Akali", "Anivia", "Annie", "Brand", "Cassiopeia", "Diana", "Evelynn", "FiddleSticks", "Fizz", "Gragas", "Heimerdinger", "Karthus",
        "Kassadin", "Katarina", "Kayle", "Kennen", "Leblanc", "Lissandra", "Lux", "Malzahar", "Mordekaiser", "Morgana", "Nidalee", "Orianna",
        "Rumble", "Ryze", "Sion", "Swain", "Syndra", "Teemo", "TwistedFate", "Veigar", "Viktor", "Vladimir", "Xerath", "Ziggs", "Zyra", "MasterYi", "VelKoz", "Azir", "Ekko",
    },
    Support = {
        "Alistar", "Blitzcrank", "Janna", "Karma", "Leona", "Lulu", "Nami", "Nunu", "Sona", "Soraka", "Taric", "Thresh", "Zilean", "Braum", "Bard", "TahmKench",
    },
 
    Tank = {
        "Amumu", "Chogath", "DrMundo", "Galio", "Hecarim", "Malphite", "Maokai", "Nasus", "Rammus", "Sejuani", "Shen", "Singed", "Skarner", "Volibear",
        "Warwick", "Yorick", "Zac", "Illaoi", "RekSai",
    },
 
    AD_Carry = {
        "Ashe", "Caitlyn", "Corki", "Draven", "Ezreal", "Graves", "Jayce", "KogMaw", "MissFortune", "Pantheon", "Quinn", "Shaco", "Sivir",
        "Talon", "Tristana", "Twitch", "Urgot", "Varus", "Vayne", "Zed", "Lucian", "Jinx",
 
    },
 
    Bruiser = {
        "Aatrox", "Darius", "Elise", "Fiora", "Gangplank", "Garen", "Irelia", "JarvanIV", "Jax", "Khazix", "LeeSin", "Nautilus", "Nocturne", "Olaf", "Poppy",
        "Renekton", "Rengar", "Riven", "Shyvana", "Trundle", "Tryndamere", "Udyr", "Vi", "MonkeyKing", "XinZhao", "Gnar", "Kindred"
    },
 
}
 
function SetPriority(table, hero, priority)
        for i=1, #table, 1 do
                if hero.charName:find(table[i]) ~= nil then
                        TS_SetHeroPriority(priority, hero.charName)
                end
        end
end
 
function arrangePrioritys()
        for i, enemy in ipairs(GetEnemyHeroes()) do
                SetPriority(priorityTable.AD_Carry, enemy, 1)
                SetPriority(priorityTable.AP,       enemy, 2)
                SetPriority(priorityTable.Support,  enemy, 3)
                SetPriority(priorityTable.Bruiser,  enemy, 4)
                SetPriority(priorityTable.Tank,     enemy, 5)
        end
end
 
function PriorityOnLoad()
        if heroManager.iCount < 10 then
				PrintChat("<font color=\"#FF7B24\"><b>[HR Miss Fortune] </b></font>".."<font color=\"#0FCBB4\"><b>Too few champions to arrange priority.</b></font>")	
        else
                arrangePrioritys()
        end
end
	
local serveradress = "raw.githubusercontent.com"
local scriptadress = "/HiranN/BoL/master"
	function FindUpdates()
	if not autoupdate then return end
	local ServerVersionDATA = GetWebResult(serveradress , scriptadress.."/HR Miss Fortune.version")
	if ServerVersionDATA then
		local ServerVersion = tonumber(ServerVersionDATA)
		if ServerVersion then
			if ServerVersion > tonumber(LocalVersion) then
			PrintChat("<font color=\"#FF7B24\"><b>[HR Miss Fortune] </b></font>".."<font color=\"#0FCBB4\"><b>Updating, don't press F9.</b></font>")
			Update()
			else
			PrintChat("<font color=\"#FF7B24\"><b>[HR Miss Fortune] </b></font>".."<font color=\"#0FCBB4\"><b>You have the latest version.</b></font>")
			end
		else
		PrintChat("<font color=\"#FF7B24\"><b>[HR Miss Fortune] </b></font>".."<font color=\"#0FCBB4\"><b>An error occured, while updating, please reload.</b></font>")
		end
	else
	PrintChat("<font color=\"#FF7B24\"><b>[HR Miss Fortune] </b></font>".."<font color=\"#0FCBB4\"><b>Could not connect to update Server.</b></font>")
	end
end

function Update()
	DownloadFile("http://"..serveradress..scriptadress.."/HR Miss Fortune.lua",SCRIPT_PATH.."HR Miss Fortune.lua", function ()
	PrintChat("<font color=\"#FF7B24\"><b>[HR Miss Fortune] </b></font>".."<font color=\"#0FCBB4\"><b>Updated, press 2x F9.</b></font>")
	end)
end

class "ScriptUpdate"
function ScriptUpdate:__init(LocalVersion,UseHttps, Host, VersionPath, ScriptPath, SavePath, CallbackUpdate, CallbackNoUpdate, CallbackNewVersion,CallbackError)
    self.LocalVersion = LocalVersion
    self.Host = Host
    self.VersionPath = '/BoL/TCPUpdater/GetScript'..(UseHttps and '5' or '6')..'.php?script='..self:Base64Encode(self.Host..VersionPath)..'&rand='..math.random(99999999)
    self.ScriptPath = '/BoL/TCPUpdater/GetScript'..(UseHttps and '5' or '6')..'.php?script='..self:Base64Encode(self.Host..ScriptPath)..'&rand='..math.random(99999999)
    self.SavePath = SavePath
    self.CallbackUpdate = CallbackUpdate
    self.CallbackNoUpdate = CallbackNoUpdate
    self.CallbackNewVersion = CallbackNewVersion
    self.CallbackError = CallbackError
    AddDrawCallback(function() self:OnDraw() end)
    self:CreateSocket(self.VersionPath)
    self.DownloadStatus = 'Connect to Server for VersionInfo'
    AddTickCallback(function() self:GetOnlineVersion() end)
end

function ScriptUpdate:print(str)
    print('<font color="#FFFFFF">'..os.clock()..': '..str)
end

function ScriptUpdate:OnDraw()
    if self.DownloadStatus ~= 'Downloading Script (100%)' and self.DownloadStatus ~= 'Downloading VersionInfo (100%)'then
        DrawText('Download Status: '..(self.DownloadStatus or 'Unknown'),50,10,50,ARGB(0xFF,0xFF,0xFF,0xFF))
    end
end

function ScriptUpdate:CreateSocket(url)
    if not self.LuaSocket then
        self.LuaSocket = require("socket")
    else
        self.Socket:close()
        self.Socket = nil
        self.Size = nil
        self.RecvStarted = false
    end
    self.LuaSocket = require("socket")
    self.Socket = self.LuaSocket.tcp()
    self.Socket:settimeout(0, 'b')
    self.Socket:settimeout(99999999, 't')
    self.Socket:connect('sx-bol.eu', 80)
    self.Url = url
    self.Started = false
    self.LastPrint = ""
    self.File = ""
end

function ScriptUpdate:Base64Encode(data)
    local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    return ((data:gsub('.', function(x)
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end

function ScriptUpdate:GetOnlineVersion()
    if self.GotScriptVersion then return end

    self.Receive, self.Status, self.Snipped = self.Socket:receive(1024)
    if self.Status == 'timeout' and not self.Started then
        self.Started = true
        self.Socket:send("GET "..self.Url.." HTTP/1.1\r\nHost: sx-bol.eu\r\n\r\n")
    end
    if (self.Receive or (#self.Snipped > 0)) and not self.RecvStarted then
        self.RecvStarted = true
        self.DownloadStatus = 'Downloading VersionInfo (0%)'
    end

    self.File = self.File .. (self.Receive or self.Snipped)
    if self.File:find('</s'..'ize>') then
        if not self.Size then
            self.Size = tonumber(self.File:sub(self.File:find('<si'..'ze>')+6,self.File:find('</si'..'ze>')-1))
        end
        if self.File:find('<scr'..'ipt>') then
            local _,ScriptFind = self.File:find('<scr'..'ipt>')
            local ScriptEnd = self.File:find('</scr'..'ipt>')
            if ScriptEnd then ScriptEnd = ScriptEnd - 1 end
            local DownloadedSize = self.File:sub(ScriptFind+1,ScriptEnd or -1):len()
            self.DownloadStatus = 'Downloading VersionInfo ('..math.round(100/self.Size*DownloadedSize,2)..'%)'
        end
    end
    if self.File:find('</scr'..'ipt>') then
        self.DownloadStatus = 'Downloading VersionInfo (100%)'
        local a,b = self.File:find('\r\n\r\n')
        self.File = self.File:sub(a,-1)
        self.NewFile = ''
        for line,content in ipairs(self.File:split('\n')) do
            if content:len() > 5 then
                self.NewFile = self.NewFile .. content
            end
        end
        local HeaderEnd, ContentStart = self.File:find('<scr'..'ipt>')
        local ContentEnd, _ = self.File:find('</sc'..'ript>')
        if not ContentStart or not ContentEnd then
            if self.CallbackError and type(self.CallbackError) == 'function' then
                self.CallbackError()
            end
        else
            self.OnlineVersion = (Base64Decode(self.File:sub(ContentStart + 1,ContentEnd-1)))
            self.OnlineVersion = tonumber(self.OnlineVersion)
            if self.OnlineVersion > self.LocalVersion then
                if self.CallbackNewVersion and type(self.CallbackNewVersion) == 'function' then
                    self.CallbackNewVersion(self.OnlineVersion,self.LocalVersion)
                end
                self:CreateSocket(self.ScriptPath)
                self.DownloadStatus = 'Connect to Server for ScriptDownload'
                AddTickCallback(function() self:DownloadUpdate() end)
            else
                if self.CallbackNoUpdate and type(self.CallbackNoUpdate) == 'function' then
                    self.CallbackNoUpdate(self.LocalVersion)
                end
            end
        end
        self.GotScriptVersion = true
    end
end

function ScriptUpdate:DownloadUpdate()
    if self.GotScriptUpdate then return end
    self.Receive, self.Status, self.Snipped = self.Socket:receive(1024)
    if self.Status == 'timeout' and not self.Started then
        self.Started = true
        self.Socket:send("GET "..self.Url.." HTTP/1.1\r\nHost: sx-bol.eu\r\n\r\n")
    end
    if (self.Receive or (#self.Snipped > 0)) and not self.RecvStarted then
        self.RecvStarted = true
        self.DownloadStatus = 'Downloading Script (0%)'
    end

    self.File = self.File .. (self.Receive or self.Snipped)
    if self.File:find('</si'..'ze>') then
        if not self.Size then
            self.Size = tonumber(self.File:sub(self.File:find('<si'..'ze>')+6,self.File:find('</si'..'ze>')-1))
        end
        if self.File:find('<scr'..'ipt>') then
            local _,ScriptFind = self.File:find('<scr'..'ipt>')
            local ScriptEnd = self.File:find('</scr'..'ipt>')
            if ScriptEnd then ScriptEnd = ScriptEnd - 1 end
            local DownloadedSize = self.File:sub(ScriptFind+1,ScriptEnd or -1):len()
            self.DownloadStatus = 'Downloading Script ('..math.round(100/self.Size*DownloadedSize,2)..'%)'
        end
    end
    if self.File:find('</scr'..'ipt>') then
        self.DownloadStatus = 'Downloading Script (100%)'
        local a,b = self.File:find('\r\n\r\n')
        self.File = self.File:sub(a,-1)
        self.NewFile = ''
        for line,content in ipairs(self.File:split('\n')) do
            if content:len() > 5 then
                self.NewFile = self.NewFile .. content
            end
        end
        local HeaderEnd, ContentStart = self.NewFile:find('<sc'..'ript>')
        local ContentEnd, _ = self.NewFile:find('</scr'..'ipt>')
        if not ContentStart or not ContentEnd then
            if self.CallbackError and type(self.CallbackError) == 'function' then
                self.CallbackError()
            end
        else
            local newf = self.NewFile:sub(ContentStart+1,ContentEnd-1)
            local newf = newf:gsub('\r','')
            if newf:len() ~= self.Size then
                if self.CallbackError and type(self.CallbackError) == 'function' then
                    self.CallbackError()
                end
                return
            end
            local newf = Base64Decode(newf)
            if type(load(newf)) ~= 'function' then
                if self.CallbackError and type(self.CallbackError) == 'function' then
                    self.CallbackError()
                end
            else
                local f = io.open(self.SavePath,"w+b")
                f:write(newf)
                f:close()
                if self.CallbackUpdate and type(self.CallbackUpdate) == 'function' then
                    self.CallbackUpdate(self.OnlineVersion,self.LocalVersion)
                end
            end
        end
        self.GotScriptUpdate = true
    end
end
