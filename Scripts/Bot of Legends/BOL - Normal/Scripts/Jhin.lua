-- Jhin - The Virtuoso --
--Changelog at the Bottom
if myHero.charName ~= "Jhin" then return end

--AutoUpdate--
local AutoUpdate = false --Don't want to autoupdate while writing the Script.

--Base Shell--
local scriptVersion = 0.19
local StridePage = 'paradoxscripts.com'
local ScriptLink = '/Scripts/Jhin/Jhin.lua'
local VersionLink = '/Scripts/Jhin/JhinVersion.version'

--Prediction--

if FileExist(LIB_PATH .. "/VPrediction.lua") then
	require("VPrediction")
	VPred = VPrediction()
else 
	print("Downloading VPrediction, please don't press F9")
	DelayAction(function() DownloadFile("https://raw.githubusercontent.com/SidaBoL/Scripts/master/Common/VPrediction.lua".."?rand="..math.random(1,10000), LIB_PATH.."VPrediction.lua", function () print("Successfully downloaded VPrediction. Press F9 twice.") end) end, 3) 
	return
end


if not _G.UPLloaded then
	if FileExist(LIB_PATH .. "/UPL.lua") then
		require("UPL")
		_G.UPL = UPL()
	else 
		print("Downloading UPL, please don't press F9")
		DelayAction(function() DownloadFile("https://raw.github.com/nebelwolfi/BoL/master/Common/UPL.lua".."?rand="..math.random(1,10000), LIB_PATH.."UPL.lua", function () print("Successfully downloaded UPL. Press F9 twice.") end) end, 3) 
		return
	end
end

--Global Vars--
currentOrbWalker = nil
loadtimeOrb = 0
-------------

function OnLoad()
	Update()
	DownloadSprites()
	Jhin = Jhin()
	IsOtherOrbWalkerLoaded()
	MIAPredict()
end

function MIAPredict()
	MIA = {}
	for _,v in pairs(GetEnemyHeroes()) do
		MIA[#MIA+1] = MIA_Prediction(v)
	end
end

-- Orbwalker -- 
function IsOtherOrbWalkerLoaded()
	DelayAction(function ()
		if _G.Reborn_Loaded or _G.AutoCarry then
			currentOrbWalker = "SAC:R"
		elseif _G.MMA_Loaded or _G.MMA_Version then
			currentOrbWalker = "MMA"
		elseif _G.NebelwolfisOrbWalkerInit or _G.NebelwolfisOrbWalkerLoaded then
			currentOrbWalker = "NOW"
		elseif _Pewalk then
			currentOrbWalker = "PEW"
		elseif _G.SxOrb or SxOrb then
			currentOrbWalker = "SxOrb"
		elseif _G.S1OrbLoaded then
			currentOrbWalker = "S1mpleOrbWalk"
		else
			currentOrbWalker = "Jhin"
			JOrb = OrbWalker()
			JOrb:AddToMenu(Jhin.menu)
		end
		loadtimeOrb = os.clock()
	end,0.5)
end

function SetOrbMode()
	if Menu.orb.SBTWKey then
		Orb:setAttackMode("sbtw")
	elseif Menu.orb.HarrasKey then
		Orb:setAttackMode("harras")
	elseif Menu.orb.LaneClearKey then
		Orb:setAttackMode("laneclear")
	elseif Menu.orb.LastHitKey then
		Orb:setAttackMode("lasthit")
	else
		Orb:setAttackMode()
	end
end

function OnDraw()
	if currentOrbWalker and currentOrbWalker ~= "Jhin" and loadtimeOrb+10 > os.clock() then
		if currentOrbWalker == "SAC:R" then
			DrawTextA("SAC:R is working with our Script, but some advanced functions might not work", 18, WINDOW_W/2-250, WINDOW_H/2, ARGB(255,0,255,0))
		elseif currentOrbWalker == "SxOrb" then
			DrawTextA("Turn SxOrbWalker off to use this Script", 60, WINDOW_W/2-500, WINDOW_H/2, ARGB(255,255,0,0))
			return
		else
			DrawTextA("Warning: This OrbWalker have not jet been tested with our Script", 18, WINDOW_W/2-250, WINDOW_H/2, ARGB(255,255,0,255))
			DrawTextA("Some advanced functions have been disabled.", 18, WINDOW_W/2-250, WINDOW_H/2+18, ARGB(255,255,0,255))
		end
	end
end

--


class 'OrbWalker' 
function OrbWalker:__init()

	--External
	self.target = nil
	self.ammo = -1
	--Internal
	self.isReloading = false
	self.isCritShot = false
	self.isAA = false
	self.menu = nil
	self.Towers = {}
	self.lastAttack = 0
	self.lastWindUpTime = 0
	self.lastAttackCD = 0
	self.windUpTime = 0
	self.aamode = "none"
	self.myTeam = myHero.team
	self.aarange = myHero.range + myHero.boundingRadius
	self.aaprojectilespeed = myHero.range > 300 and VPred:GetProjectileSpeed(myHero) or math.huge


	self.lastmove = 0
	self.minionMan = minionManager(MINION_ENEMY, self.aarange, player, MINION_SORT_HEALTH_ASC)
	self.jungleMan = minionManager(MINION_JUNGLE, self.aarange, player, MINION_SORT_HEALTH_ASC)

	AddAnimationCallback(function(unit, animation)
		self:OnAnimation(unit, animation)
	end)
	AddTickCallback(function()
		self:SetOrbMode()
		self:MoF()
	end)
	AddDrawCallback(function()
		self:OnDraw()
	end)
	AddApplyBuffCallback(function (source, target, buff)
		self:ApplyBuff(source, target, buff)
	end)
	AddRemoveBuffCallback(function (source, target, buff)
		self:RemoveBuff(source, target, buff)
	end)
	self.loaded = true
	self:addTowers()
end

function OrbWalker:ApplyBuff(source, target, buff)
	if not target then return end
	if not source.valid or not target.valid then return end
	if source.isMe and target.isMe then
		if buff.name == "jhinpassiveattackbuff" then
			self.isCritShot = true
		elseif buff.name == "JhinPassiveReload" then
			self.isReloading = true
		end
	end
end

function OrbWalker:RemoveBuff(source, buff)
	if not source.valid then return end
	if source.isMe then
		if buff.name == "jhinpassiveattackbuff" then
			self.isCritShot = false
		elseif buff.name == "JhinPassiveReload" then
			self.isReloading = false
			self.ammo = 4
		end
	end
end

function OrbWalker:OnDraw()
	if not self.menu then return end
	targets = self:GetMinions(self.aarange)
	if self.menu.orb.adv.debug then
		DrawTextA("os.clock: "..os.clock(),18,20,0)
		DrawTextA("aamode: "..self.aamode,18,20,20)
		DrawTextA(tostring(self:timeToShoot()),18,20,40)
		DrawTextA("armor: "..myHero.armor,18,20,140)
		DrawTextA("armorPenPercent: "..myHero.armorPenPercent,18,20,160)
		DrawTextA("armorPen: "..myHero.armorPen,18,20,180)
		DrawTextA("lastmove: "..self.lastmove,18,20,220)
		DrawTextA("canMove: "..tostring(self:CanMove()),18,20,240)

		for _, v in pairs(targets) do
			DrawText3D(v.health.." : "..self:RealADDamage(v, myHero, {name = "Basic"}, 0),v.x,v.y,v.z)
		end
	end

	if self.menu.orb.adv.showaarange then
		DrawCircle3D(myHero.x,myHero.y,myHero.z,self.aarange,1, ARGB(255,0,255,0))
	end



	if self.aamode == "none" or self.aamode == "sbtw" then return end
	for _, v in pairs(targets) do
		local hpp = v.health/v.maxHealth*100
		local dmg = 0
		if self.isCritShot then
			dmg = self:RealADDamage(v, myHero, {name = "CritAttack"}, 0)
		else
			dmg = self:RealADDamage(v, myHero, {name = "Basic"}, 0)
		end
		if dmg > v.health and self.menu.orb.draw.killable then
			DrawCircle3D(v.x,v.y,v.z,30, 3, ARGB(255,255-25.5*hpp,255,25.5*hpp))
		elseif dmg*3 > v.health and self.menu.orb.draw.soon then
			DrawCircle3D(v.x,v.y,v.z,30, 1, ARGB(150,255-25.5*hpp,255,25.5*hpp))
		end

	end	


end

function OrbWalker:OnAnimation(unit, animation)
	if not self.menu then return end
	if unit.isMe and animation:find("Attack") then

		local spellProc = unit.spell
		self.windUpTime = spellProc.windUpTime

		self.lastAttack = GetTickCount() - GetLatency() * 0.5
		self.lastWindUpTime = unit.spell.windUpTime * 1000
		self.lastAttackCD = unit.spell.animationTime * 1000
		self.ammo = self.ammo - 1
	end
end

function OrbWalker:setAttackMode(mode)
	if not self.loaded then return end
	if not mode or type(mode) ~= "string" then
		self.aamode = "none"
	else
		self.aamode = mode
	end
end

function OrbWalker:GetLatency() --In millisec
	return GetLatency() / 2000
end

function OrbWalker:setOrbMode(mode)
	if not mode then 
		self.aamode = "none"
		return
	end
	self.aamode = mode
end

function OrbWalker:CanMove() --Thanks to Bilbao for this Function
	if not self.menu then return true end
	if self.isReloading then return true end
	return (GetTickCount() + GetLatency() * (0.5+self.menu.orb.adv.tTSdelay) > self.lastAttack + self.lastWindUpTime) and (self.lastmove+self.menu.orb.human.moveorderdelay < os.clock())
end

function OrbWalker:timeToShoot()
	if self.isReloading then return false end
	return (GetTickCount() + GetLatency() * (0.5+self.menu.orb.adv.tTSdelay)  > self.lastAttack + self.lastAttackCD)
end

function OrbWalker:Move()
	if not self:CanMove() then return end
	if self.aamode == "none" then return end
	if GetDistance(myHero, mousePos) < 20 then return end
	self.lastmove = os.clock()
	myHero:MoveTo(mousePos.x, mousePos.z)
end

function OrbWalker:EnemysInRange(range)
	local enemys = self:GetMinions(range)
	local champs = self:GetChampions(range)
	for _,v in pairs(champs) do
		enemys[#enemys+1] = v
	end
	return #enemys
end

function OrbWalker:PredictHealth(object, time)
	if not object then return math.huge end
	if not time then
		time = self.windUpTime + GetDistance(object.visionPos, myHero.visionPos)/self.aaprojectilespeed - 0.07
	end
	if self.menu.orb.adv.healtpred then
		return VPred:GetPredictedHealth(object, time+self:GetLatency(), 0)
	else
		return object.health
	end
end

function OrbWalker:RealADDamage(target, source, spell, additionalDamage)
	--Big Thanks to VPrediction
	-- read initial armor and damage values
	local armorPenPercent = source.armorPenPercent
	local armorPen = source.armorPen
	local totalDamage = source.totalDamage + (additionalDamage or 0)
	local damageMultiplier = spell.name:find("CritAttack") and 2 or 1

	-- minions give wrong values for armorPen and armorPenPercent
	if source.type == "obj_AI_Minion" then
		armorPenPercent = 1
	elseif source.type == "obj_AI_Turret" then
		armorPenPercent = 0.7
	end

	-- turrets ignore armor penetration and critical attacks
	if target.type == "obj_AI_Turret" then
		armorPenPercent = 1
		armorPen = 0
		damageMultiplier = 1
	end

	-- calculate initial damage multiplier for negative and positive armor

	local targetArmor = (target.armor * armorPenPercent) - armorPen
	if targetArmor < 0 then -- minions can't go below 0 armor.
		--damageMultiplier = (2 - 100 / (100 - targetArmor)) * damageMultiplier
		damageMultiplier = 1 * damageMultiplier
	else
		damageMultiplier = 100 / (100 + targetArmor) * damageMultiplier
	end

	-- use ability power or ad based damage on turrets
	if source.type == myHero.type and target.type == "obj_AI_Turret" then
		totalDamage = math.max(source.totalDamage, source.damage + 0.4 * source.ap)
	end

	-- minions deal less damage to enemy heros
	if source.type == "obj_AI_Minion" and target.type == myHero.type and source.team ~= TEAM_NEUTRAL then
		damageMultiplier = 0.60 * damageMultiplier
	end

	-- heros deal less damage to turrets
	if source.type == myHero.type and target.type == "obj_AI_Turret" then
		damageMultiplier = 0.95 * damageMultiplier
	end

	-- minions deal less damage to turrets
	if source.type == "obj_AI_Minion" and target.type == "obj_AI_Turret" then
		damageMultiplier = 0.475 * damageMultiplier
	end

	-- siege minions and superminions take less damage from turrets
	if source.type == "obj_AI_Turret" and (target.charName == "Red_Minion_MechCannon" or target.charName == "Blue_Minion_MechCannon") then
		damageMultiplier = 0.8 * damageMultiplier
	end

	-- caster minions and basic minions take more damage from turrets
	if source.type == "obj_AI_Turret" and (target.charName == "Red_Minion_Wizard" or target.charName == "Blue_Minion_Wizard" or target.charName == "Red_Minion_Basic" or target.charName == "Blue_Minion_Basic") then
		damageMultiplier = (1 / 0.875) * damageMultiplier
	end

	-- turrets deal more damage to all units by default
	if source.type == "obj_AI_Turret" then
		damageMultiplier = 1.05 * damageMultiplier
	end

	-- calculate damage dealt
	local dmg = damageMultiplier * totalDamage * (1-self.menu.orb.adv.dmgbuff*0.01)
	return dmg
end



function OrbWalker:GetMinions(range)
	self.minionMan.range = range
	self.jungleMan.range = range
	self.minionMan:update()
	self.jungleMan:update()
	local t = {}
	for _, v in pairs(self.minionMan.objects) do
		t[#t+1] = v
	end
	for _, v in pairs(self.jungleMan.objects) do
		t[#t+1] = v
	end
	return t
end
		
function OrbWalker:GetChampions(range)
	local Champions = GetEnemyHeroes()
	local ChampInRange = {}
	for _,v in pairs(Champions) do
		if GetDistance(v) < range and ValidTarget(v) then
			ChampInRange[#ChampInRange] = v
		end
	end	
	return ChampInRange
end
	
function OrbWalker:GetMinionTarget()
	local target = nil
	local minions = self:GetMinions(self.aarange)
	for _,v in pairs(minions) do
		local predictedHealt = self:PredictHealth(v)
		if target == nil and predictedHealt > 0 and ValidTarget(v) then
			target = v
		elseif target ~= nil and predictedHealt > 0 and predictedHealt < target.health and ValidTarget(v) then
			target = v
		end
	end
	return target
end
	
function OrbWalker:GetChampionTarget()
	local target = nil
	for _,v in pairs(self:GetChampions(self.aarange)) do
		local predictedHealt = self:PredictHealth(v) 
		if target == nil and predictedHealt > 0 and ValidTarget(v) then
			target = v
		elseif target ~= nil and predictedHealt > 0 and predictedHealt < target.health and ValidTarget(v) then
			target = v
		end
	end
	return target
end

function OrbWalker:GetAATargets()
	if self.aamode == "none" then return nil end

	local target = nil
	if self.aamode == "laneclear" then
		if self.isCritShot and self.menu.orb.adv.firecritatchamp then 
			target = self:GetChampionTarget()
		end
		if not target then
			target = self:GetMinionTarget()
		end
		if not target and self.menu.orb.adv.orbTower then
			local t = nil
			for _, v in pairs(self.Towers) do
				if v and v.valid and not v.dead and v.health > 0 then
					if not t and GetDistance(v) < self.aarange then
						t = v
					elseif t and v.health < t.health and GetDistance(v) < self.aarange then
						t = v
					end
				end
			end
			if t then target = t end
		end
	end
	if self.aamode == "sbtw" then
		target = self:GetChampionTarget()
	end
	if self.aamode == "harras" then
		target = self:GetChampionTarget()
		if not target then
			target = self:GetMinionTarget()
			if target then
				local delay = GetDistance(target)/self.aaprojectilespeed
				local predictedHealt = self:PredictHealth(target)
				if predictedHealt > self:RealADDamage(target, myHero, {name = "Basic"}, 0) then
					target = nil	
				end
			end
		end
	end
	if self.aamode == "lasthit" then
		if self.isCritShot and self.menu.orb.adv.firecritatchamp then 
			target = self:GetChampionTarget()
		end
		if not target then
			target = self:GetMinionTarget()
			if target then
				local delay = GetDistance(target)/self.aaprojectilespeed
				local predictedHealt = self:PredictHealth(target) 
				if predictedHealt > self:RealADDamage(target, myHero, {name = "Basic"}, 0) then
					target = nil	
				end
			end
		end
	end
	return target
end

function OrbWalker:ProgressAA(target)
	if target then
		DelayAction(function ()
			myHero:Attack(target)
		end,self.menu.orb.human.aadelay/1000)
	end
end

function OrbWalker:MoF()
	if not self.menu then return end
	local target = self:GetAATargets()
	if target then
		self.target = target
		if self:timeToShoot() then
			self:ProgressAA(target)
		elseif self:CanMove() then
			self:Move()
		end
	else
		self:Move()
	end
end

function OrbWalker:addTowers()
	--self.Towers
	for i = 1, objManager.maxObjects, 1 do
		local object = objManager:getObject(i)
		if object and object.valid and not object.dead and (object.type == "obj_AI_Turret" or object.type == "obj_HQ" or object.type == "obj_BarracksDampener") and object.team ~= player.team then
			self.Towers[#self.Towers+1] = object
		end
	end
end

function OrbWalker:SetOrbMode()
	if not self.menu then return end
	if self.menu.orb.SBTWKey then
		self:setAttackMode("sbtw")
	elseif self.menu.orb.HarrasKey then
		self:setAttackMode("harras")
	elseif self.menu.orb.LaneClearKey then
		self:setAttackMode("laneclear")
	elseif self.menu.orb.LastHitKey then
		self:setAttackMode("lasthit")
	else
		self:setAttackMode()
	end
end


function OrbWalker:AddToMenu(Menu)
	function SetToggleMode()
		if self.menu.orb.toggle == true then
			self.menu.orb:removeParam("HarrasKey")
			self.menu.orb:removeParam("LaneClearKey")
			self.menu.orb:removeParam("LastHitKey")
			self.menu.orb:removeParam("SBTWKey")
			self.menu.orb:addParam('HarrasKey', 'Harras Key', SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("C"))
			self.menu.orb:addParam('LaneClearKey', 'Laneclear Key', SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("V"))
			self.menu.orb:addParam('LastHitKey', 'LastHit Key', SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("X"))
			self.menu.orb:addParam('SBTWKey', 'SBTW Key', SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte(" "))
		else
			self.menu.orb:removeParam("HarrasKey")
			self.menu.orb:removeParam("LaneClearKey")
			self.menu.orb:removeParam("LastHitKey")
			self.menu.orb:removeParam("SBTWKey")
			self.menu.orb:addParam('HarrasKey', 'Harras Key', SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
			self.menu.orb:addParam('LaneClearKey', 'Laneclear Key', SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
			self.menu.orb:addParam('LastHitKey', 'LastHit Key', SCRIPT_PARAM_ONKEYDOWN, false, string.byte("X"))
			self.menu.orb:addParam('SBTWKey', 'SBTW Key', SCRIPT_PARAM_ONKEYDOWN, false, string.byte(" "))
		end
	end
	self.menu = Menu

	self.menu:addSubMenu('OrbWalker', 'orb')
	self.menu.orb:addParam("toggle", "Toggle Mode", SCRIPT_PARAM_ONOFF, false)
	self.menu.orb:setCallback("toggle", function ()
		SetToggleMode()
	end)
	self.menu.orb:addParam('HarrasKey', 'Harras Key', SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
	self.menu.orb:addParam('LaneClearKey', 'Laneclear Key', SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
	self.menu.orb:addParam('LastHitKey', 'LastHit Key', SCRIPT_PARAM_ONKEYDOWN, false, string.byte("X"))
	self.menu.orb:addParam('SBTWKey', 'SBTW Key', SCRIPT_PARAM_ONKEYDOWN, false, string.byte(" "))
	

	self.menu.orb:addSubMenu('Advanced', 'adv')
	self.menu.orb.adv:addParam("orbTower", "OrbWalk Towers (Laneclear)", SCRIPT_PARAM_ONOFF, true)
	self.menu.orb.adv:addParam("firecritatchamp", "Fire 4th Shoot always at Champs", SCRIPT_PARAM_ONOFF, true)
	self.menu.orb.adv:addParam("dmgbuff","Health Buffer %",SCRIPT_PARAM_SLICE, 0,0,10,1)
	self.menu.orb.adv:addParam("tTSdelay", "Prevent AA Canceling", SCRIPT_PARAM_SLICE, -1, -2, 2, 1)
	self.menu.orb.adv:addParam("healtpred", "Use Health Prediction", SCRIPT_PARAM_ONOFF, false)
	self.menu.orb.adv:addParam("debug", "Show the Magic", SCRIPT_PARAM_ONOFF, false)
	self.menu.orb.adv:addParam("showaarange", "Show AA Range", SCRIPT_PARAM_ONOFF, false)

	self.menu.orb:addSubMenu('Humanizer', 'human')
	self.menu.orb.human:addParam("moveorderdelay", "Next Move Order Delay", SCRIPT_PARAM_SLICE, 0.25, 0, 0.5, 1)
	self.menu.orb.human:addParam("inf", "Values > 0.3 or < 0.1 are not recommended", SCRIPT_PARAM_INFO, "")
	self.menu.orb.human:addParam("spacer", " ", SCRIPT_PARAM_INFO, "")
	self.menu.orb.human:addParam("aadelay", "Auto-Attack Delay", SCRIPT_PARAM_SLICE, 20,0,400,1)
	self.menu.orb.human:addParam("inf", "Values > 100 or < 10 are not recommended", SCRIPT_PARAM_INFO, "")
	self.menu.orb.human:addParam("spacer", " ", SCRIPT_PARAM_INFO, "")
	
	self.menu.orb:addSubMenu('Draws', 'draw')
	self.menu.orb.draw:addParam("killable", "Draw Killable Minions", SCRIPT_PARAM_ONOFF, true)
	self.menu.orb.draw:addParam("soon", "Draw Nearly Killable Minions", SCRIPT_PARAM_ONOFF, true)
end




--Update--

function printChat(m)
	print('<font color=\"#52527a\">Metro Series</font><font color=\"#888888\"> - </font><font color=\"#cccccc\">'..m..'</font>')
end

class 'Update'
function Update:__init()
  if not AutoUpdate then return end
  self.Version = scriptVersion
  self.DownloadPath = 'http://'..StridePage..ScriptLink
  self.SavePath = SCRIPT_PATH .. _ENV.FILE_NAME
  if os.clock() < 180 then
	self:Check()
  else
		DelayAction(function()
			printChat('The game is already in progress. Disabling auto update.')
		end, 2)
  end 
end
  
function Update:RequireUpdate()
  self.NewVersion = GetWebResult(StridePage, VersionLink)     
  if self.NewVersion then
	self.NewVersion = string.match(self.NewVersion, '%d.%d%d')
		self.NewVersion = tonumber(self.NewVersion)
	if self.NewVersion and self.NewVersion > scriptVersion then
	  DelayAction(function()
		printChat('New version v'..self.NewVersion..' found! Downloading... Do not press F9!')
	  end, 2)
	  return true
	else
	  DelayAction(function()
		printChat('No new updates found.')
	  end, 2)
	  return false
	end
  end
end
  
function Update:Check()
  if self:RequireUpdate() then
	DownloadFile(self.DownloadPath, self.SavePath, 
	function()
	  if FileExist(self.SavePath) then
		DelayAction(function()
		  printChat('Script updated! Please reload BOL for changes to take effect!')
		end, 3)
	  end
	end)
  else
	end
end

--Actions--

class("Jhin")
function Jhin:__init()
	self.QDMG = (15+25*myHero:GetSpellData(_Q).level)+((0.25+0.05*myHero:GetSpellData(_Q).level)*myHero.totalDamage+myHero.addDamage)+((myHero.ap + (myHero.ap * myHero.apPercent)*0.6))
	self.WDMG = (35+15*myHero:GetSpellData(_W).level)+(0.7*(myHero.totalDamage+myHero.addDamage))
	self.EDMG = (-40+60*myHero:GetSpellData(_E).level)+(1.2*(myHero.totalDamage+myHero.addDamage))+(myHero.ap + (myHero.ap * myHero.apPercent))
	self.RDMG = (-25+75*myHero:GetSpellData(_R).level)+0.25*(myHero.totalDamage+myHero.addDamage)

	self.enemyMinions = minionManager(MINION_ENEMY, 600, player, MINION_SORT_HEALTH_ASC)
	self.ts = TargetSelector(TARGET_LESS_CAST, 3300, DAMAGE_PHYSICAL, true)
	self:RegisterSpells()
	self.menu = nil
	self:Menu()
	
	AddDrawCallback(function ()
		self:OnDraw()
	end)
	AddTickCallback(function ()
		self:OnTick()
	end)

	AddProcessSpellCallback(function (object,spellProc)
		self:PS(object,spellProc)
	end)
end

function Jhin:PS(object,spellProc)
	if object.networkID == myHero.networkID then
		if spellProc.name == "JhinR" or spellProc.name == "JhinRShot" then
			self:UltAssist(spellProc)
		end
	end
end

function Jhin:OnDraw()
	if self.menu.draw.debugdraw then
		for i = 1, myHero.buffCount do
			local tBuff = myHero:getBuff(i)
			if BuffIsValid(tBuff) then
				DrawTextA(tBuff.name, 12, 20, 20+20*i)
			end
		end

		for i2,v in pairs(GetEnemyHeroes()) do
			DrawTextA(v.charName,20,20+i2*80,20)
			for i = 1, v.buffCount do
				local tBuff = v:getBuff(i)
				if BuffIsValid(tBuff) then
					if tBuff.name == "jhinespotteddebuff" then
						DrawTextA(tBuff.name, 20, 20+i2*80, 40+i*20, ARGB(255,255,0,0))
					else
						DrawTextA(tBuff.name, 20, 20+i2*80, 40+i*20)
					end
				end
			end
		end
	end

	--Draw Damage
	for _, v in pairs(GetEnemyHeroes()) do
		if v and v.visible and not v.dead then
			local dmg = 0

			if self.spellsQ:IsReady() then
				dmg = dmg + self.QDMG
			end

			if self.spellsW:IsReady() then
				dmg = dmg + self.WDMG
			end

			if self.spellsE:IsReady() then
				dmg = dmg + self.EDMG
			end
			local basicdmg = 0
			if JOrb and JOrb.ammo and JOrb.ammo == 1 then
				basicdmg = JOrb:RealADDamage(v, myHero, {name = "CritAttack"}, 0)
				basicdmg = basicdmg * 0.75
			elseif JOrb and JOrb.ammo and JOrb.ammo > 0 then
				basicdmg = JOrb:RealADDamage(v, myHero, {name = "Basic"}, 0)
			end

			dmg = dmg+basicdmg
			local dmgperc = (dmg/v.health)*100
			local basicAttack = self:RealADDamage(myHero, v, {name = "Basic"}, 0)
			
			local barPos = GetUnitHPBarPos(v) --THANKS Jori
			local barOffset = GetUnitHPBarOffset(v)
			do -- For some reason the x offset never exists
				local t = {
					["Darius"] = -0.05,
					["Renekton"] = -0.05,
					["Sion"] = -0.05,
					["Thresh"] = 0.03,
					["Jhin"] = -0.06,
				}
				barOffset.x = t[v.charName] or 0
			end
			local baseX = barPos.x - 69 + barOffset.x * 150
			local baseY = barPos.y + barOffset.y * 50 + 12.5

			if v.charName == "Jhin" then 
				baseY = baseY - 12
			end
			local enemyhpperc = v.health/v.maxHealth

			


			if dmgperc < 100 then
				if self.menu.draw.drawdmgbar then
					DrawLine(baseX, baseY-10, baseX+(1.05*dmgperc)*enemyhpperc, baseY-10, 15, ARGB(180,2.55*dmgperc,0,-255+2.55*dmgperc))
				end
				if self.menu.draw.drawdmgtext then
					DrawTextA(math.round(dmgperc).."%",12,baseX+(1.05*dmgperc)*enemyhpperc/2, baseY-17)
				end
			else
				if self.menu.draw.drawdmgbar then
					DrawLine(baseX, baseY-10, baseX+105*enemyhpperc, baseY-10, 15, ARGB(180,255,0,0))
				end
				if self.menu.draw.drawdmgtext then
					DrawTextA("KILL HIM",12,baseX+40*enemyhpperc, baseY-17)
				end
			end

		end
	end

	if self.menu.draw.qrange then
		DrawCircle3D(myHero.x, myHero.y, myHero.z, self.spellsQ.range, self.menu.draw.qthick, ARGB(self.menu.draw.qcolor[1],self.menu.draw.qcolor[2],self.menu.draw.qcolor[3],self.menu.draw.qcolor[4]), 16)
	end
	if self.menu.draw.wrange then
		DrawCircle3D(myHero.x, myHero.y, myHero.z, self.spellsW.range, self.menu.draw.wthick, ARGB(self.menu.draw.wcolor[1],self.menu.draw.wcolor[2],self.menu.draw.wcolor[3],self.menu.draw.wcolor[4]), 16)
	end
	if self.menu.draw.erange then
		DrawCircle3D(myHero.x, myHero.y, myHero.z, self.spellsE.range, self.menu.draw.ethick, ARGB(self.menu.draw.ecolor[1],self.menu.draw.ecolor[2],self.menu.draw.ecolor[3],self.menu.draw.ecolor[4]), 16)
	end
	if self.menu.draw.rrange then
		DrawCircleMinimap(myHero.x, myHero.y, myHero.z, self.spellsR.range, self.menu.draw.rthick, ARGB(self.menu.draw.rcolor[1],self.menu.draw.rcolor[2],self.menu.draw.rcolor[3],self.menu.draw.rcolor[4]), 16)
	end

	if self.menu.ult.tracer and self.UltimateisActive then
		for i,v in pairs(GetEnemyHeroes()) do
			if v and not v.dead and not self.menu.ult.blacklist["bl"..v.charName] then
				if v.visible then
					CastPosition, HitChance, HeroPosition = UPL:Predict(_R, myHero, v)
					if CastPosition then
						DrawLine3D(myHero.x,myHero.y,myHero.z,CastPosition.x,CastPosition.y,CastPosition.z,1,ARGB(255,0,255,255))
						DrawLine3D(v.x,v.y,v.z,CastPosition.x,CastPosition.y,CastPosition.z,1,ARGB(255,255,255,255))
						DrawCircle3D(CastPosition.x,CastPosition.y,CastPosition.z,50,1,ARGB(255,255,255,255),8)
						if not self.UltimateShootsFired then
							DrawText3D("Predicted Health "..tostring(math.round((v.health-self.RDMG)/v.maxHealth*100)),v.x,v.y,v.z,14,ARGB(255,255,0,0))
						else
							DrawText3D("Predicted Health "..tostring(math.round((v.health-(self.RDMG*2))/v.maxHealth*100)),v.x,v.y,v.z,14,ARGB(255,255,0,0))
						end
					end
				elseif  MIA and #MIA > 0 then
					local m = MIA[i]:Predict()
					if m then
						DrawLine3D(myHero.x,myHero.y,myHero.z,m.x,m.y,m.z,1,ARGB(255,0,255,255))
					end
				end
			end
		end
	end
end

function Jhin:GetTarget(range)
	if not range then range = 550 end
	if currentOrbWalker == "Jhin" then
		if JOrb.target then return JOrb.target else
			self.ts:update()
			return self.ts.target
		end
	elseif currentOrbWalker == "PEW" then
		return _Pewalk.GetTarget(range)
	elseif currentOrbWalker == "NOW" then
		_G.NebelwolfisOrbWalker:GetTarget()
	elseif currentOrbWalker == "MMA" then
		return _G.MMA_Target
	elseif currentOrbWalker == "SAC:R" and _G.AutoCarry and _G.AutoCarry.Crosshair then
		_G.AutoCarry.Crosshair:SetSkillCrosshairRange(range)
		return _G.AutoCarry.Crosshair:GetTarget()
	end
end

function Jhin:GetOrbWalkMode()
	if currentOrbWalker == "Jhin" then
		return JOrb.aamode
	elseif self.menu.keys then
		if self.menu.keys.harras then return "harras" end
		if self.menu.keys.combo then return "sbtw" end
		if self.menu.keys.laneclear then return "laneclear" end
		if self.menu.keys.lasthit then return "lasthit" end
	end
	return nil
end


function Jhin:UltAssist(spellProc)
	if spellProc.name == "JhinR" then
		self.UltimateShootsFired = 0
		self.UltPos = { x = mousePos.x , y = mousePos.y, z = mousePos.z} --Cause spellProc is strange
		self.UltimateisActive = true
		self.UltStarttime = os.clock()
		DelayAction(function ()
			self.UltimateisActive = false
			self.UltPos = nil
		end,11)
	elseif spellProc.name == "JhinRShot" then
		self.UltimateShootsFired = self.UltimateShootsFired + 1
		self.LastShoot = os.clock()
	end
	if self.UltimateShootsFired == 4 then
		self.UltimateisActive = false
	end
end

function Jhin:FireAtTargets()
	if not self.menu.ult.ultassist then return end
	local target = self:GetTarget(self.spellsR.range)
	
	function IsValidConeTarget(target)
		local function CalcAngle(vector1, vector2)
			local angle = math.atan2(vector1.z-vector2.z, vector1.x-vector2.x)
			return angle
		end

		local function CalcVector(source,target)
			local V = Vector(source.x, source.y, source.z)
			local V2 = Vector(target.x, target.y, target.z)
			local vec = V-V2
			local vec2 = vec:normalized()
			return vec2
		end

		local ultpos = mousePos
		local VectorSelfUlt = CalcVector(myHero, self.UltPos)*-100
		local VectorSelfTarget = CalcVector(myHero, target)*-100
		local V = Vector(0,0,0)
		local AngleVSUVST = V:angleBetween(VectorSelfUlt,VectorSelfTarget)
		if AngleVSUVST <= 20 then
			return true
		else
			return false
		end

	end

	if target then
		if not self.menu.ult.blacklist["bl"..target.charName] and IsValidConeTarget(target) and target.visible then
			self.spellsR:Cast(target)
		elseif self.menu.ult.blacklist["bl"..target.charName] then
			for _, v in pairs(GetEnemyHeroes()) do
				if not self.menu.ult.blacklist["bl"..v.charName] and v.visible then
					if IsValidConeTarget(v) then
						self.spellsR:Cast(target)
						break
					end
				end
			end
		end
	elseif not target then
		local t = false
		for _, v in pairs(GetEnemyHeroes()) do
			if not self.menu.ult.blacklist["bl"..v.charName] and v.visible then
				if IsValidConeTarget(v) then
					self.spellsR:Cast(target)
					t = true
					break
				end
			end
		end
		if t == false and MIA and #MIA > 0 then
			for _, v in pairs(MIA) do
				local pos = v:Predict()
				if not v.hero.dead and pos and IsValidConeTarget(pos) then
					self.spellsR:Cast(pos, true)
				end
			end
		end
	end
end

function Jhin:Combo()
	if not self.menu then return end
	local target = self:GetTarget(3300)
	if not target then return end
	if self.spellsQ:IsReady() and self:Mana(self.menu.combo.q.manaq) and self.menu.combo.q.comboq and target.type == myHero.type then
		--Cast if between 0-3 Minions
		local mir = self:MinionsInRange(self.spellsQ.range*1.5)
		if #mir <= 3 and #mir ~= 0 and target then
			self.spellsQ:Cast(mir[1])
		else
			--Cast to kill
			local eir = self:EnemiesInRange(self.spellsQ.range)
			local lowliveenemy = nil
			for _, v in pairs(eir) do
				if self.QDMG * 0.95 > v.health then
					self.spellsQ:Cast(v)
				else
					--Cast to do most DMG
					if lowliveenemy == nil then
						lowliveenemy = v
					elseif lowliveenemy.health > v.health then
						lowliveenemy = v
					end
				end
			end
			if lowliveenemy then
				self.spellsQ:Cast(lowliveenemy)
			end
		end		
	end

	if self.spellsW:IsReady() then
		for _, v in pairs(self:EnemiesInRange(self.spellsW.range)) do
			if TargetHaveBuff("jhinespotteddebuff", v) then
				self.spellsW:Cast(v)
			end
		end
		if self.spellsW:IsReady() and self:Mana(self.menu.combo.w.manaw) and not self.menu.combo.w.stunonly then
			self.spellsW:Cast(target)
		end
	end
	if self.spellsE:IsReady() then
		for _, v in pairs(self:EnemiesInRange(self.spellsE.range)) do
			if TargetHaveBuff("JhinW", v) then
				self.spellsE:Cast(v)
			end
		end
		if not self.menu.combo.e.ewhilew then
			self.spellsE:Cast(target)
		end
	end
end

function Jhin:Lasthit()
	--soon
end

function Jhin:Clear()
	local target = self:GetTarget(3300)
	if not target or target.type ~= 'obj_AI_Minion' then return end
	if self.spellsQ:IsReady() and self:Mana(self.menu.clear.q.manaq) then
		self.spellsQ:Cast(target)
	end
	if self.spellsW:IsReady() and self:Mana(self.menu.clear.w.manaw) then
		self.spellsW:Cast(target)
	end
	if self.spellsE:IsReady() and self:Mana(self.menu.clear.e.manae) then
		self.spellsE:Cast(target)
	end
end

function Jhin:Harass()
	if not self.menu then return end
	local target = self:GetTarget(3300)
	if not target then return end
	if JOrb and self.menu.adv.coaacd and JOrb:timeToShoot() and GetDistance(target) < JOrb.aarange then return end


	if self.spellsQ:IsReady() and self:Mana(self.menu.harass.q.manaq) and self.menu.harass.q.harassq and target.type == myHero.type then
		--Cast if between 0-3 Minions
		local mir = self:MinionsInRange(self.spellsQ.range*1.5)
		if #mir <= 3 and #mir ~= 0 and target then
			self.spellsQ:Cast(mir[1])
		else
			--Cast to kill
			local eir = self:EnemiesInRange(self.spellsQ.range)
			local lowliveenemy = nil
			for _, v in pairs(eir) do
				if self.QDMG * 0.95 > v.health then
					self.spellsQ:Cast(v)
				else
					--Cast to do most DMG
					if lowliveenemy == nil then
						lowliveenemy = v
					elseif lowliveenemy.health > v.health then
						lowliveenemy = v
					end
				end
			end
			if lowliveenemy then
				self.spellsQ:Cast(lowliveenemy)
			end
		end		
	end

	if self.spellsW:IsReady() and self.menu.harass.w.harassw then
		for _, v in pairs(self:EnemiesInRange(self.spellsW.range)) do
			if TargetHaveBuff("jhinespotteddebuff", v) then
				self.spellsW:Cast(v)
			end
		end
		if self.spellsW:IsReady() and self:Mana(self.menu.harass.w.manaw) and not self.menu.harass.w.stunonly then
			self.spellsW:Cast(target)
		end
	end

	if self.spellsE:IsReady() and self.menu.harass.e.harasse then
		for _, v in pairs(self:EnemiesInRange(self.spellsE.range)) do
			if TargetHaveBuff("JhinW", v) then
				self.spellsE:Cast(v)
			end
		end
		if not self.menu.harass.e.ewhilew then
			self.spellsE:Cast(target)
		end
	end
end

function Jhin:OnTick()
	local orbmode = self:GetOrbWalkMode()
	if orbmode == "sbtw" then
		self:Combo()
	elseif orbmode == "harras" then
		self:Harass()
	elseif orbmode == "laneclear" then
		self:Clear()
	elseif orbmode == "lasthit" then
		self:Lasthit()
	end
	if self.UltimateisActive then
		self:FireAtTargets()
	end
end

--Health/Mana--
function Jhin:Health(amount)
	if amount >= (myHero.health/myHero.maxHealth) * 100 then
		return true
	else
		return false
	end
end

function Jhin:Mana(amt)
	if amt <= (myHero.mana/myHero.maxMana) * 100 then
		return true
	else
		return false
	end
end

--Menu--

function Jhin:Menu()
	self.menu = scriptConfig(myHero.charName.." - The Virtuoso", 'Jhin')	
	---
	self.menu:addSubMenu('Drawings', 'draw')
		self.menu.draw:addParam('qrange', 'Q Range', SCRIPT_PARAM_ONOFF, true)
		self.menu.draw:addParam('wrange', 'W Range', SCRIPT_PARAM_ONOFF, true)
		self.menu.draw:addParam('erange', 'E Range', SCRIPT_PARAM_ONOFF, true)
		self.menu.draw:addParam('rrange', 'R Range', SCRIPT_PARAM_ONOFF, true)
		self.menu.draw:addParam("space1", "--Color Settings--", SCRIPT_PARAM_INFO, "")
		self.menu.draw:addParam("qcolor", "Q Color", SCRIPT_PARAM_COLOR, {255,255,255,255})
		self.menu.draw:addParam("wcolor", "W Color", SCRIPT_PARAM_COLOR, {255,255,0,255})
		self.menu.draw:addParam("ecolor", "E Color", SCRIPT_PARAM_COLOR, {255,255,255,0})
		self.menu.draw:addParam("rcolor", "R Color", SCRIPT_PARAM_COLOR, {255,0,255,255})
		self.menu.draw:addParam("space2", "--Thickness Settings--", SCRIPT_PARAM_INFO, "")
		self.menu.draw:addParam("qthick", "Q Thickness", SCRIPT_PARAM_SLICE, 2,1,5)
		self.menu.draw:addParam("wthick", "W Thickness", SCRIPT_PARAM_SLICE, 2,1,5)
		self.menu.draw:addParam("ethick", "E Thickness", SCRIPT_PARAM_SLICE, 2,1,5)
		self.menu.draw:addParam("rthick", "R Thickness", SCRIPT_PARAM_SLICE, 2,1,5)
		self.menu.draw:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
		self.menu.draw:addParam("drawdmgbar", "Draw Potential Damage Bar", SCRIPT_PARAM_ONOFF, true)
		self.menu.draw:addParam("drawdmgtext", "Draw Potential Damage Text", SCRIPT_PARAM_ONOFF, true)
		self.menu.draw:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")		
		self.menu.draw:addParam("debugdraw", "Show Debug Draws", SCRIPT_PARAM_ONOFF, false)


	---
	self.menu:addSubMenu('Combo', 'combo')
		self.menu.combo:addSubMenu('Q Settings', 'q')
			self.menu.combo.q:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			self.menu.combo.q:addParam('comboq', 'Use Q', SCRIPT_PARAM_ONOFF, true)
			self.menu.combo.q:addParam('manaq', 'Use Q when mana >', SCRIPT_PARAM_SLICE, 10, 0, 100, 0)
			self.menu.combo.q:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
		self.menu.combo:addSubMenu('W Settings', 'w')
			self.menu.combo.w:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			self.menu.combo.w:addParam('combow', 'Use W', SCRIPT_PARAM_ONOFF, true)
			self.menu.combo.w:addParam('manaw', 'Use W when mana >', SCRIPT_PARAM_SLICE, 10, 0, 100, 0)
			self.menu.combo.w:addParam("stunonly", "Only use on Stunable", SCRIPT_PARAM_ONOFF, false)
			self.menu.combo.w:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
		self.menu.combo:addSubMenu('E Settings', 'e')
			self.menu.combo.e:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			self.menu.combo.e:addParam('comboe', 'Use E', SCRIPT_PARAM_ONOFF, true)
			self.menu.combo.e:addParam('manae', 'Use E when mana >', SCRIPT_PARAM_SLICE, 10, 0, 100, 0)
			self.menu.combo.e:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			self.menu.combo.e:addParam("ewhilew", "Only use E if W hit", SCRIPT_PARAM_ONOFF, true)
	---
	self.menu:addSubMenu('Harass', 'harass')
		self.menu.harass:addSubMenu('Q Settings', 'q')
			self.menu.harass.q:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			self.menu.harass.q:addParam('harassq', 'Use Q', SCRIPT_PARAM_ONOFF, true)
			self.menu.harass.q:addParam('manaq', 'Use Q when mana >', SCRIPT_PARAM_SLICE, 40, 0, 100, 0)
		self.menu.harass:addSubMenu('W Settings', 'w')
			self.menu.harass.w:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			self.menu.harass.w:addParam('harassw', 'Use W', SCRIPT_PARAM_ONOFF, true)
			self.menu.harass.w:addParam('manaw', 'Use W when mana >', SCRIPT_PARAM_SLICE, 40, 0, 100, 0)
			self.menu.harass.w:addParam("stunonly", "Only use on Stunable", SCRIPT_PARAM_ONOFF, false)
		self.menu.harass:addSubMenu('E Settings', 'e')
			self.menu.harass.e:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			self.menu.harass.e:addParam('harasse', 'Use E', SCRIPT_PARAM_ONOFF, true)
			self.menu.harass.e:addParam('manae', 'Use E when mana >', SCRIPT_PARAM_SLICE, 40, 0, 100, 0)
			self.menu.harass.e:addParam("ewhilew", "Only use E if W hit", SCRIPT_PARAM_ONOFF, true)
	---
	self.menu:addSubMenu('Laneclear', 'clear')
		self.menu.clear:addSubMenu('Q Settings', 'q')
			self.menu.clear.q:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			self.menu.clear.q:addParam('manaq', 'Use Q when mana >', SCRIPT_PARAM_SLICE, 40, 0, 100, 0)
			self.menu.clear.q:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
		self.menu.clear:addSubMenu('W Settings', 'w')
			self.menu.clear.w:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			self.menu.clear.w:addParam('manaw', 'Use W when mana >', SCRIPT_PARAM_SLICE, 40, 0, 100, 0)
			self.menu.clear.w:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
		self.menu.clear:addSubMenu('E Settings', 'e')
			self.menu.clear.e:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			self.menu.clear.e:addParam('manae', 'Use E when mana >', SCRIPT_PARAM_SLICE, 40, 0, 100, 0)
			self.menu.clear.e:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
	---
	self.menu:addSubMenu("Prediction", "pred")
		self.menu.pred:addParam("qhs", "Q Hitchance", SCRIPT_PARAM_SLICE, 3, 1, 3, 0)
		self.menu.pred:addParam("whs", "W Hitchance", SCRIPT_PARAM_SLICE, 3, 1, 3, 0)
		self.menu.pred:addParam("ehs", "E Hitchance", SCRIPT_PARAM_SLICE, 3, 1, 3, 0)
		self.menu.pred:addParam("rhs", "R Hitchance", SCRIPT_PARAM_SLICE, 3, 1, 3, 0)
		self.menu.pred:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")

	self.menu:addSubMenu("Advanced", "adv")
		self.menu.adv:addParam("whilecdinfo", "This Feature only works with our OrbWalker", SCRIPT_PARAM_INFO, "")

	self.menu:addSubMenu("R - Config", "ult")
		self.menu.ult:addParam("ultassist", "Enable Ult Assist", SCRIPT_PARAM_ONOFF, true)
		self.menu.ult:addSubMenu("Blacklist", "blacklist")
		for _,v in pairs(GetEnemyHeroes()) do
			self.menu.ult.blacklist:addParam("bl"..v.charName, v.charName, SCRIPT_PARAM_ONOFF, false)
		end
		self.menu.ult:addParam("tracer", "Draw Tracer Lines", SCRIPT_PARAM_ONOFF, false)

	if VIP_USER and tostring(GetGameVersion():sub(1,10)):find("6.3.0.240") then
		self.menu:addSubMenu("VIP - Settings", "vip")
			self.menu.vip:addSubMenu("Auto Level", "lvlspll")
				self.menu.vip.lvlspll:addParam("enable", "Enable Auto Level", SCRIPT_PARAM_ONOFF, true)
				self.menu.vip.lvlspll:addParam("menu", "Open Config Menu", SCRIPT_PARAM_ONOFF, false)
	end
			

	DelayAction(function ()
		if not JOrb then
			self.menu:addSubMenu("Keys", "keys")
			self.menu.keys:addParam("harras", "Harras Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
			self.menu.keys:addParam("combo", "Combo Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte(" "))
			self.menu.keys:addParam("laneclear", "Laneclear Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
			self.menu.keys:addParam("lasthit", "Lasthit Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("X"))
		elseif JOrb then
			self.menu.adv:removeParam("whilecdinfo")
			self.menu.adv:addParam("coaacd", "Prefer Cast on AA CD", SCRIPT_PARAM_ONOFF, true)
		end
	end,2)
	
	self.menu:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
	self.menu:addParam("ScriptAuthor", "Metro Series - "..myHero.charName, SCRIPT_PARAM_INFO, "")
	self.menu:addParam("Version", "Version "..scriptVersion, SCRIPT_PARAM_INFO, "")

	--UPL
	UPL.addToMenu2 = true
	UPL.Config = self.menu.pred
end

function Jhin:RegisterSpells()
	self.spellsQ = Spell(_Q, math.huge, 0.25, 550, 0, false, false, "none")
	self.spellsW = Spell(_W, math.huge, 0.55, 2950, 75, false, true, "linear")
	self.spellsE = Spell(_E, math.huge, 0.75, 750, 260, false, true, "none")
	self.spellsR = Spell(_R, 3300, 0.5, 3300, 75, false, true, "linear")
end

function Jhin:MinionsInRange(range)
	self.enemyMinions:update()
	local n = {}
	for i, minion in pairs(self.enemyMinions.objects) do
		if minion and minion.valid and not minion.dead and GetDistance(minion) <= range then n[#n+1] = minion end
	end
	return n
end

function Jhin:EnemiesInRange(range)
	local n = {}
	for _,v in pairs(GetEnemyHeroes()) do
		if v and v.valid and not v.dead and GetDistance(v) <= range then n[#n+1] = v end
	end
	return n
end

function Jhin:RealADDamage(target, source, spell, additionalDamage)
	--Big Thanks to VPrediction
	-- read initial armor and damage values
	local armorPenPercent = source.armorPenPercent
	local armorPen = source.armorPen
	local totalDamage = source.totalDamage + (additionalDamage or 0)
	local damageMultiplier = spell.name:find("CritAttack") and 2 or 1

	-- minions give wrong values for armorPen and armorPenPercent
	if source.type == "obj_AI_Minion" then
		armorPenPercent = 1
	elseif source.type == "obj_AI_Turret" then
		armorPenPercent = 0.7
	end

	-- turrets ignore armor penetration and critical attacks
	if target.type == "obj_AI_Turret" then
		armorPenPercent = 1
		armorPen = 0
		damageMultiplier = 1
	end

	-- calculate initial damage multiplier for negative and positive armor

	local targetArmor = (target.armor * armorPenPercent) - armorPen
	if targetArmor < 0 then -- minions can't go below 0 armor.
		--damageMultiplier = (2 - 100 / (100 - targetArmor)) * damageMultiplier
		damageMultiplier = 1 * damageMultiplier
	else
		damageMultiplier = 100 / (100 + targetArmor) * damageMultiplier
	end

	-- use ability power or ad based damage on turrets
	if source.type == myHero.type and target.type == "obj_AI_Turret" then
		totalDamage = math.max(source.totalDamage, source.damage + 0.4 * source.ap)
	end

	-- minions deal less damage to enemy heros
	if source.type == "obj_AI_Minion" and target.type == myHero.type and source.team ~= TEAM_NEUTRAL then
		damageMultiplier = 0.60 * damageMultiplier
	end

	-- heros deal less damage to turrets
	if source.type == myHero.type and target.type == "obj_AI_Turret" then
		damageMultiplier = 0.95 * damageMultiplier
	end

	-- minions deal less damage to turrets
	if source.type == "obj_AI_Minion" and target.type == "obj_AI_Turret" then
		damageMultiplier = 0.475 * damageMultiplier
	end

	-- siege minions and superminions take less damage from turrets
	if source.type == "obj_AI_Turret" and (target.charName == "Red_Minion_MechCannon" or target.charName == "Blue_Minion_MechCannon") then
		damageMultiplier = 0.8 * damageMultiplier
	end

	-- caster minions and basic minions take more damage from turrets
	if source.type == "obj_AI_Turret" and (target.charName == "Red_Minion_Wizard" or target.charName == "Blue_Minion_Wizard" or target.charName == "Red_Minion_Basic" or target.charName == "Blue_Minion_Basic") then
		damageMultiplier = (1 / 0.875) * damageMultiplier
	end

	-- turrets deal more damage to all units by default
	if source.type == "obj_AI_Turret" then
		damageMultiplier = 1.05 * damageMultiplier
	end

	-- calculate damage dealt
	local dmg = damageMultiplier * totalDamage * 0.98
	return dmg
end


class("Spell")
function Spell:__init(slot, speed, delay, range, width, collision, aoe, type)
	self.slot = slot
	self.speed = speed
	self.delay = delay
	self.range = range
	self.width = width
	self.collision = collision
	self.aoe = aoe
	self.type = type
	if self.type ~= "none" then
		UPL:AddSpell(self.slot, { speed = self.speed, delay = self.delay, range = self.range, width = self.width, collision = self.collision, aoe = self.aoe, type = self.type })
	end
end

function Spell:Cast(target, flag)
	if flag then
		DelayAction(function ()
			if target and target.x and target.z then
				CastSpell(self.slot, target.x,target.z)
			end
		end,math.random(0,0.025))
		return
	end

	if not target or target.dead or (not target.visible and self.slot ~= _R) or not target.valid then return end
	if not ValidTarget(target) then return end
	if not self:IsReady() then return end

	if self.type ~= "none" then
		CastPosition, HitChance, HeroPosition = UPL:Predict(self.slot, myHero, target)
		local hs = Jhin.menu.pred[({[_Q]="q",[_W]="w",[_E]="e",[_R]="r"})[self.slot].."hs"]

		if HitChance >= hs then
			CastSpell(self.slot, CastPosition.x, CastPosition.z)
		elseif self.slot == _R then
			local endtime = Jhin.UltStarttime+11
			local timeleft = endtime - os.clock()
			if timeleft < 11/2 then
				if hs > 3 then hs = 3 end
				hs = hs - 1
			end
			if timeleft < 11/3 then
				hs = hs - 1
			end
			if timeleft < 11/4 then
				hs = hs - 1
			end
			if HitChance >= hs then
				DelayAction(function ()
					CastSpell(self.slot, CastPosition.x, CastPosition.z)
				end,math.random(0,0.025))
			end
		end
	else
		DelayAction(function ()
			if target and target.valid then
				CastSpell(self.slot, target)
			end
		end,math.random(0,0.025))
	end
end

function Spell:IsReady()
	return (myHero:CanUseSpell(self.slot) == 0)  
end


class("LevelSpellC")
function LevelSpellC:__init(savename)
	if not VIP_USER or not tostring(GetGameVersion():sub(1,10)):find("6.3.0.240") then return end
	self.inipos = 7
	self.offset = 22
	self.lastlevelup = 1
	self.savename = savename
	self.loaded = false
	--

	self.grid = {}
	self:Load()

	Button = GetSprite("\\MetroSeries\\Jhin\\Button.png")
	ButtonPressed = GetSprite("\\MetroSeries\\Jhin\\ButtonPressed.png")
	Background = GetSprite("\\MetroSeries\\Jhin\\Background.png")
	ButtonClose = GetSprite("\\MetroSeries\\Jhin\\Close.png")
	ButtonReset = GetSprite("\\MetroSeries\\Jhin\\Reset.png")
	ButtonLeveled = GetSprite("\\MetroSeries\\Jhin\\ButtonLeveled.png")

	AddDrawCallback(function ()
		self:Draw()
	end)
	AddMsgCallback(function(msg, wParam)
		self:MouseClick(msg, wParam)
	end)
	AddTickCallback(function ()
		self:Level()
	end)
	AddUnloadCallback(function ()
		self:Save()
	end)
	Jhin.menu.vip.lvlspll:setCallback("menu", function() self:Save() end)
end

function LevelSpellC:reset()
	self.grid = {}
	for i = 1, 18 do
		self.grid[i] = {}
		for j = 1, 4 do
			self.grid[i][j] = { isClicked = false, posx = WINDOW_W/3+5+22*i+10.5, posy = WINDOW_H/1.43+self.inipos+self.offset*(j-1)+10.5}
		end
	end
end

function LevelSpellC:Draw()
	if not Jhin.menu.vip.lvlspll.menu then return end
	if not self.grid or not self.grid[1] then self:reset() end
	Background:Draw(WINDOW_W/3, WINDOW_H/1.43, 255)
	ButtonClose:Draw(WINDOW_W/1.69, WINDOW_H/1.32, 255)
	ButtonReset:Draw(WINDOW_W/1.69, WINDOW_H/1.4, 255)
	for i=1,18 do
		for j = 1, 4 do
			if self.grid[i][j].isClicked == true then
				if myHero.level < i then
					ButtonPressed:Draw(WINDOW_W/3+5+22*i, WINDOW_H/1.43+self.inipos+self.offset*(j-1), 255)
				else
					ButtonLeveled:Draw(WINDOW_W/3+5+22*i, WINDOW_H/1.43+self.inipos+self.offset*(j-1), 255)
				end
			else
				Button:Draw(WINDOW_W/3+5+22*i, WINDOW_H/1.43+self.inipos+self.offset*(j-1), 255)
			end
		end
	end
end

function LevelSpellC:MouseClick(msg, wParam)
	if not Jhin.menu.vip.lvlspll.menu then return end
	if msg ~= 513 or wParam ~= 1 then return end
	local mp = WorldToScreen(D3DXVECTOR3(mousePos.x, mousePos.y, mousePos.z))

	for i, v in pairs(self.grid) do
		for i2, v2 in pairs(v) do
			if math.sqrt((mp.x-v2.posx)^2+(mp.y-v2.posy)^2) <= 10.5 then
				if self:ValidSetting(i,i2) then
					if i2 ~= 1 then
						self.grid[i][1].isClicked = false
					end
					if i2 ~= 2 then
						self.grid[i][2].isClicked = false
					end
					if i2 ~= 3 then
						self.grid[i][3].isClicked = false
					end
					if i2 ~= 4 then
						self.grid[i][4].isClicked = false
					end
					self.grid[i][i2].isClicked = not self.grid[i][i2].isClicked
				end
			end
		end
	end
	if mp.x >= WINDOW_W/1.69 and mp.x <= (WINDOW_W/1.69)+95 then
		if mp.y >= WINDOW_H/1.32 and mp.y <= (WINDOW_H/1.32)+40 then
			Jhin.menu.vip.lvlspll.menu = false
		elseif mp.y >= WINDOW_H/1.4 and mp.y <= (WINDOW_H/1.4)+40 then
			self:reset()
		end
	end
end

function LevelSpellC:ValidSetting(i,i2)
	--Check if Ult Lvl before LvL 6
		if i2 == 4 and i < 6 then return false end
	
	--Check if OverLevel
		local skilllevel = 0
		for n=1,i-1 do
			if self.grid[n][i2].isClicked == true then
				skilllevel = skilllevel + 1
			end
		end
		if skilllevel == 5 then return end
		if math.ceil(i/2) < skilllevel then return false end

	if i2 == 4 and skilllevel >= 3 then return false end



	return true
end

function LevelSpellC:Level()
	if not Jhin.menu.vip.lvlspll.enable then return end
	if not self.loaded then return end
	--self.lastlevelup = 1
	if myHero.level >= self.lastlevelup then
		for i = 1,4 do
			if self.grid[self.lastlevelup][i].isClicked then
				spellsSlots = {SPELL_1, SPELL_2, SPELL_3, SPELL_4}
				DelayAction(function ()
					LevelSpell(spellsSlots[i])
				end, math.random(0.25,1))
			end
		end
		self.lastlevelup = self.lastlevelup + 1
	end
end

function LevelSpellC:Save()
	local str = table.concat({"return ",table.serialize(self.grid, nil, true)})
	local file = io.open(LIB_PATH.."\\Saves\\"..tostring(self.savename)..".save", "w")
	file:write(str)
	file:close()
end

function LevelSpellC:Load()
	if FileExist(LIB_PATH.."\\Saves\\"..tostring(self.savename)..".save") then
		local str = ReadFile(LIB_PATH.."\\Saves\\"..tostring(self.savename)..".save")
		self.grid = load(str)()
	else	
		self:reset()
	end
	self.loaded = true
end


function DownloadSprites()
	CreateDirectory(SPRITE_PATH.."\\MetroSeries\\")
	CreateDirectory(SPRITE_PATH.."\\MetroSeries\\Jhin\\")
	local Downloads = 0
	host = "http://paradoxscripts.com"

	Background = "/Scripts/Jhin/Sprites/Background.png"
	ButtonPressed = "/Scripts/Jhin/Sprites/ButtonPressed.png"
	Button = "/Scripts/Jhin/Sprites/Button.png"
	ButtonReset = "/Scripts/Jhin/Sprites/ButtonPressed.png"
	ButtonLeveled = "/Scripts/Jhin/Sprites/ButtonLeveled.png"
	ButtonClose = "/Scripts/Jhin/Sprites/ButtonClose.png"
	ButtonReset = "/Scripts/Jhin/Sprites/ButtonReset.png"

	if not FileExist(SPRITE_PATH.."\\MetroSeries\\Jhin\\Background.png") then
		Downloads = Downloads + 1
		DelayAction(function ()
			DownloadFile(host..Background, SPRITE_PATH.."\\MetroSeries\\Jhin\\Background.png", function()
				Downloads = Downloads - 1
			end)
		end,0.25)				
	end
	if not FileExist(SPRITE_PATH.."\\MetroSeries\\Jhin\\ButtonLeveled.png") then
		Downloads = Downloads + 1
		DelayAction(function ()
			DownloadFile(host..Background, SPRITE_PATH.."\\MetroSeries\\Jhin\\ButtonLeveled", function()
				Downloads = Downloads - 1
			end)
		end,0.25)				
	end
	if not FileExist(SPRITE_PATH.."\\MetroSeries\\Jhin\\ButtonPressed.png") then
		Downloads = Downloads + 1
		DelayAction(function ()
			DownloadFile(host..ButtonPressed, SPRITE_PATH.."\\MetroSeries\\Jhin\\ButtonPressed.png", function()
				Downloads = Downloads - 1
			end)
		end,0.25)	
	end
	if not FileExist(SPRITE_PATH.."\\MetroSeries\\Jhin\\Button.png") then
		Downloads = Downloads + 1
		DelayAction(function ()
			DownloadFile(host..Button, SPRITE_PATH.."\\MetroSeries\\Jhin\\Button.png", function()
				Downloads = Downloads - 1
			end)
		end,0.25)	
	end
	if not FileExist(SPRITE_PATH.."\\MetroSeries\\Jhin\\Close.png") then
		Downloads = Downloads + 1
		DelayAction(function ()
			DownloadFile(host..ButtonClose, SPRITE_PATH.."\\MetroSeries\\Jhin\\Close.png", function()
				Downloads = Downloads - 1
			end)
		end,0.25)	
	end
	if not FileExist(SPRITE_PATH.."\\MetroSeries\\Jhin\\Reset.png") then
		Downloads = Downloads + 1
		DelayAction(function ()
			DownloadFile(host..ButtonReset, SPRITE_PATH.."\\MetroSeries\\Jhin\\Reset.png", function()
				Downloads = Downloads - 1
			end)
		end,0.25)
	end

	if Downloads ~= 0 then
		printChat("Sprites Missing, downloading..")
		printChat("Using Alternative Downloader")
		printChat("The Game might lag for some secounds")
	end

	local function DelayLvLSpellIni()
		if Downloads == 0 then
			DelayAction(function ()
				LV = LevelSpellC("JhinAutoLevel")
			end,0.25)
		else
			DelayAction(function ()
				DelayLvLSpellIni()
			end,0.25)
		end
	end
	DelayLvLSpellIni()
end

class("MIA_Prediction")
function MIA_Prediction:__init(hero)
	self.hero = hero
	self.lastpos = nil
	self.lastwp = nil
	self.lastseen = 0
	self.wall = false
	self.wasmoving = false
	self.reallastseen = 0
	AddTickCallback(function ()
		self:tick()
	end)
	AddDrawCallback(function ()
		self:draw()
	end)
end

function MIA_Prediction:tick()
	if self.hero.visible and self.hero.hasMovePath then
		self.lastseen = os.clock()
		self.lastwp = self.hero.path
		self.wasmoving = true
	end
	if self.hero.visible then
		self.wall = false
		self.reallastseen = os.clock()
		self.lastpos = self.hero.pos
	end
	if not self.hero.hasMovePath or (self.hero.hasMovePath and GetDistance(self.hero,self.lastwp.endPath)) then
		self.wasmoving = false
		self.lastpos = self.hero.pos
	end
end

function MIA_Prediction:Predict()
	local function CalcVector(source,target)
		local V = Vector(source.x, source.y, source.z)
		local V2 = Vector(target.x, target.y, target.z)
		local vec = V-V2
		local vec2 = vec:normalized()
		return vec2
	end

	if self.hero.visible then
		return self.hero.pos
	end

	if os.clock()-self.lastseen > 10 then
		return nil
	end

	if not self.wall then
		self.tdst = (os.clock()-self.lastseen)*self.hero.ms
	end
	local path = CalculatePath(self.hero,self.lastwp.endPath)


	if path and self.tdst then
		local PrePreWP = nil -- :D
		local PreWP = nil
		local traveld = 0
		for i2=0,path.count do
			local p = path:Path(i2)
			if PreWP then
				traveld = traveld + GetDistance(PreWP,p)
				if self.tdst <= traveld then
					local n = CalcVector(PreWP,p)*(traveld-self.tdst)
					local d3 = D3DXVECTOR3(p.x+n.x,p.y+n.y,p.z+n.z)
					if IsWall(d3) then
						--self.wall = true
					end
					return {x = p.x+n.x,y = p.y+n.y,z = p.z+n.z}
				end
			end
			if PreWP then
				PrePreWP = PreWP
			end
			PreWP = p
		end
		if PrePreWP and PreWP then
			local v = CalcVector(PrePreWP, PreWP)*(traveld-self.tdst)
			local d3 = D3DXVECTOR3(PreWP.x+v.x,PreWP.y+v.y,PreWP.z+v.z)
			if IsWall(d3) then
				self.wall = true
			end
			return {x = PreWP.x+v.x,y = PreWP.y+v.y,z = PreWP.z+v.z}
		end
	end

	if not self.wasmoving and self.lastpos then
		return self.lastpos
	end
	print(self.wasmoving)
	return nil
	
end

function MIA_Prediction:draw()
	local pos = self:Predict()
	if pos and not self.hero.visible then
		DrawCircle3D(pos.x,pos.y,pos.z,50,1,ARGB(255,255,0,0))
		DrawText3D(self.hero.charName.." MIA since: "..tostring(math.floor(os.clock()-self.reallastseen)),pos.x,pos.y,pos.z)
	end
end

--[[
Changelog:

Update 0.18
	Added Humanizer
	Better FOW Prediction (using enemy Waypoints)
	Added Tracer while in Ult Mode (you don't need Ult Assist enabled for that)

Update 0.17
	Enabled AutoLevel for 6.3

Update 0.16
	Added FOW Prediction

Update 0.15
	Made SxOrbWalker show as incompatible again
	Better Ultimate
		Now decreases the needed HitChance over Time, to fire more shoots

Update 0.13 & 0.14
	Fixed Sprite Downloader

Update 0.12
	Improved AutoLevel Draws
	Added an Option to only Cast W if it will Stun the Target (Credits to HeRoBaNd for requesting it)
	Cleared up the Sprite Download function
	Added VPrediction AutoDownloader
	Added UPL settings for each Spell
	SAC:R now added as compatible OrbWalker

Update 0.11
	Just a quick hotfix

Update 0.10 Released (Credits to HeRoBaNd)
	Fixed HPBars
		The Damage is now displayed, based on the current, rather then on the max Life
		Added an Option to draw current Possible damage as Percentage Number
		Added basic attack's to damage calculation
	Fixed an issue, where the Sprite downloader won't create the Jhin Folder

Update 0.09 Released
	Fixed an issue with the Ult Assist
	It should no longer Cast the Ultimate itself
	Optimized Target Finding

Update 0.08 Released
	Fixed multiple Errors
	Added AutoLevel (VIP Only)
	Sprites for AutoLevel are downloaded automatically
		If they fail to download open the Script and set UseAlternativeDownloader = false to UseAlternativeDownloader = true

Update 0.07 Released
	Fixed Laneclear Chatspam
	Fixed AA targeting Minions in SBTW-Mode
	If you have trouble injecting, try 6.2HF instead of latest

Pre Update 0.06
	Internal Test Versions


Goodbye Dominion you will be missed
]]