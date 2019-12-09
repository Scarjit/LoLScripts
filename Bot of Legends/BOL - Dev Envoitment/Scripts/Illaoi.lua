

--[[
	=============================
	Illaoi - The Kraken Priestess
			Team Metro
	=============================
	Recommended with:
	 - Evadeee                          by Weee
	 - Sida's Auto Carry: Reborn        by Sida
	
	Requirements: 
	 - VPrediction
	 - UPL
	 - UOL
	 If you miss any of this Requirements, they will be automaticly Downloaded
	 
	=============================
			 Changelog
	=============================
	v0.07 - 2016-01-09
	 - Hotfix
	v0.06 - 2016-01-07
	 - Improved Compatiblity with OrbWalkers
	 	- Added Attack Reset's for non SAC:R OrbWalkers
	 - Added HitChance Settings
	 - Added Improved Libary Downloaded
	 - Added Warning for Incompatibly OrbWalkers (SxOrbWalk)
	 - Added Warning if there is no OrbWalker choosen

	v0.05 - 2016-01-06
	 - Small Improvements
	v0.04 - 2015-01-05
	 - Optimized Vessel Tracking
	 - Better Log
	 - Added UPL
	 - Added UOL

	v0.03 - 2015-12-28
     - Vessel Tracking Bug fix
     - Code Optimization
	
	v0.02 - 2015-12-01
	 - Smart Q Usage for harass improved
	
	v0.01 - 2015-11-30
	 - Initial release
	 - Situational combo
	 - Last-hit management
	 - Lane-clear
	 - Spirit tracker
	 - Fully customizable
	 
]]-- 

--DO NOT ENCRYPT THIS (Script Status)
if myHero.charName == "Illaoi" then
	assert(load(Base64Decode("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"), nil, "bt", _ENV))() ScriptStatus("OBEFAJAEDAH") 
end
--End ScriptStatus

--AutoUpdate--
local AutoUpdate = true

--Base Shell--
local scriptVersion = 0.07
local StridePage = 'paradoxscripts.com'
local ScriptLink = '/Scripts/Illaoi/Illaoi.lua'
local VersionLink = '/Scripts/Illaoi/IllaoiVersion.txt'

--In-game Variables--
local vessel = {}
local enemyhero = {}
local sprite = {}
local tentacle = {nil, nil}
local tcount = 0
local spirittimer = 0
local nextattacktime = 0
local enemyheroes = GetEnemyHeroes()
local currentOrbwalker = ""

--Supported Lol Version (Packets)
supportedversion = "5.24.0.249"

--Prediction--
local ToDownload = 0
local Downloaded = 0
if FileExist(LIB_PATH.."/VPrediction.lua") then
	require ('VPrediction')
	VP = VPrediction()
else
	print("Downloading VPrediction, please don't press F9")
    DelayAction(function() DownloadFile("https://raw.githubusercontent.com/SidaBoL/Scripts/master/Common/VPrediction.lua".."?rand="..math.random(1,10000), LIB_PATH.."VPrediction.lua", function () 
    	Downloaded = Downloaded + 1 
    	DLAnnouncer("VPrediction") 
    	end) 
    end, 3) 
    ToDownload = ToDownload + 1
end


if not _G.UPLloaded then
  if FileExist(LIB_PATH .. "/UPL.lua") then
    require("UPL")
    _G.UPL = UPL()
  else 
    print("Downloading UPL, please don't press F9")
    DelayAction(function() DownloadFile("https://raw.github.com/nebelwolfi/BoL/master/Common/UPL.lua".."?rand="..math.random(1,10000), LIB_PATH.."UPL.lua", function () 
    	Downloaded = Downloaded + 1 
    	DLAnnouncer("UPL") 
    	end) 
    end, 3) 
    ToDownload = ToDownload + 1
  end
end

--Orbwalker--
if not _G.UOLloaded then
  if FileExist(LIB_PATH .. "/UOL.lua") then
  	DelayAction(function ()
  		require("UOL")
  	end, 10)
  else 
    print("Downloading UOL, please don't press F9")
    DelayAction(function() DownloadFile("https://raw.github.com/nebelwolfi/BoL/master/Common/UOL.lua".."?rand="..math.random(1,10000), LIB_PATH.."UOL.lua", function () 
    	Downloaded = Downloaded + 1 
    	DLAnnouncer("UOL") 
    	end) 
    end, 3) 
    ToDownload = ToDownload + 1
  end
end

function DLAnnouncer(name)
	if Downloaded ~= ToDownload then
	print("Successfully downloaded "..name..". Wait for "..tostring(ToDownload-Downloaded).." Download(s) to finish")
	else
		print("Successfully downloaded "..name..". Press F9 twice.")
	end
end

if ToDownload ~= 0 then return end


function OnLoad()


	log = LogHandler()
	printChat('Initializing auto-updater module...')
	vesselsprite = GetSprite("MetroSeries/vesselbox.png")
	-- nasprite = GetSprite("MetroSeries/na.png")
	--Teaser
	teasersprite1 = GetSprite("MetroSeries/vesselface.png")
	teasersprite2 = GetSprite("MetroSeries/vesselface2.png")
	LoadChampSprites()
	if AutoUpdate then
		Update = Update()
	else
		printChat('Auto-update is disabled. Manually check the forum if you would like the updated version.')
		Compatibility()
	end
	Enemies()
	Minions = Minions()
	OldTentacles()
end

function LoadChampSprites()
	for k, v in pairs(enemyheroes) do
		sprite[#sprite+1] = GetSprite("MetroSeries/ChampIcons/"..v.charName..".png", "MetroSeries/ChampIcons/_na.png")
	end
end

function OnDraw()
	if Champion and not myHero.dead then
		if target and Menu.draw.target then
			DrawCircle(target.x, target.y, target.z, 150, ARGB(100, 250, 0, 250))   
		end
		if Menu.draw.tentacle then
			for i = 1, 30 do
				if tentacle[i] ~= nil and tentacle[i].maxHealth == 2 then
					if GetDistance(tentacle[i]) < 800 then
						DrawCircle(tentacle[i].x, tentacle[i].y, tentacle[i].z, 800, ARGB(100, 204, 204, 252))
					else
						DrawCircle(tentacle[i].x, tentacle[i].y, tentacle[i].z, 800, ARGB(1, 120, 120, 120))
					end
				elseif tentacle[i] ~= nil and tentacle[i].maxHealth == 1 then
					DrawCircle(tentacle[i].x, tentacle[i].y, tentacle[i].z, 100, ARGB(100, 120, 120, 120))
				end
			end
		end
		if spirit and spirittimer - os.clock() > 0 and Menu.draw.spirittimer then 
			spiritpos = WorldToScreen(D3DXVECTOR3(spirit.x, spirit.y, spirit.z))
			DrawText(tostring(math.round((spirittimer - os.clock())*10)*0.1), 30, spiritpos.x - (0.015 * WINDOW_W), spiritpos.y + (0.05 * WINDOW_H), ARGB(200, 252, 252, 252))
			DrawText('HOLD CLEAR KEY', 18, spiritpos.x - (0.05 * WINDOW_W), spiritpos.y - (0.185 * WINDOW_H), ARGB(200, 187, 5, 200))
		end
		if Champion.spells.R:isReady() and Menu.draw.ult then
			if Champion:EnemyCount(800) >= 2 then
				if Champion:EnemyCount(450) >= Menu.combo.r.targ2 then
					DrawCircle(myHero.x, myHero.y, myHero.z, 450, ARGB(100, 0, 175, 0)) 
				elseif Champion:EnemyCount(450) < Menu.combo.r.targ2 then
					DrawCircle(myHero.x, myHero.y, myHero.z, 450, ARGB(100, 175, 0, 0))
				end
			elseif Champion:EnemyCount(800) <= 1 then
				if Champion:EnemyCount(450) >= Menu.combo.r.targ1 then
					DrawCircle(myHero.x, myHero.y, myHero.z, 450, ARGB(100, 0, 175, 0)) 
				elseif Champion:EnemyCount(450) < Menu.combo.r.targ1 then
					DrawCircle(myHero.x, myHero.y, myHero.z, 450, ARGB(100, 175, 0, 0))
				end
			end
		end
	end
	if Champion and not GetGame().isOver and Menu.draw.vessel then
		vesselsprite:Draw(0, WINDOW_H - 192, 0xFF)

			if VesselCount() == 0 then
				
				teasersprite1:Draw(80, WINDOW_H - 55, 0xFF)

			elseif VesselCount() == 1 then
				for k, v in pairs(enemyheroes) do
					if v == vessel[1] then
						sprite[k]:Draw(80, WINDOW_H - 55, 0xFF)
					end
				end

			elseif VesselCount() == 2 then
				for k, v in pairs(enemyheroes) do
					if v == vessel[1] then
						sprite[k]:Draw(50, WINDOW_H - 55, 0xFF)
					elseif v == vessel[2] then
						sprite[k]:Draw(110, WINDOW_H - 55, 0xFF)
					end
				end
			
			elseif VesselCount() == 3 then
				for k, v in pairs(enemyheroes) do
					if v == vessel[1] then
						sprite[k]:Draw(20, WINDOW_H - 55, 0xFF)
					elseif v == vessel[2] then
						sprite[k]:Draw(80, WINDOW_H - 55, 0xFF)
					elseif v == vessel[3] then
						sprite[k]:Draw(140, WINDOW_H - 55, 0xFF)
					end
				end

			end
	end

	--Print Orbwalker warning
	if currentOrbwalker == "No Orbwalker found, please activate one in the 'Orbwalker' Menu" then
		DrawTextA(currentOrbwalker, 25, WINDOW_W/2-250, WINDOW_H/2-250, ARGB(255,255,0,0))
	end
	--Print SxOrb Warning
	if currentOrbwalker == "SxOrbWalk" then
		local warning = "WARNING SxOrbWalk is not Supported !!!!"
		DrawTextA(warning, 30, WINDOW_W/2-250, WINDOW_H/2, ARGB(255,255,0,0))
	end

	--Debug

	if target then
		DrawTextA(target.charName.. " || "..GetDistance(target), 18, 20 ,40)
		local CastPosition, HitChance, HeroPosition = UPL:Predict(_Q, myHero, target)
		DrawText3D(tostring(HitChance), target.x,target.y,target.z,18,ARGB(255,255,255,255))
	end
end

function OnTick()
	for i = 1, 30 do
		if tentacle[i] ~= nil and tentacle[i].dead then
			TentacleManager(tentacle[i], 2)
		end
	end
end

function OnCreateObj(obj)
	if obj.name == 'God' and obj.team == myHero.team then
		TentacleManager(obj, 1)
	end
	if obj and string.match(obj.name, ".troy") == nil and isSpirit(obj.name:lower()) and obj.team ~= myHero.team then
		spirit = obj
		spirittimer = os.clock() + 10
	elseif obj and (obj.name:lower() == 'illaoi_base_e_spiritreturn.troy' or obj.name:lower() == 'illaoi_base_e_spirittimershatter.troy' or obj.name:lower() == 'illaoi_base_e_deathbeam.troy') then
		spirit = nil
		spirittimer = 0
		--isVessel() --Not needed anymore
	end
end

function OnDeleteObj(obj)
	if obj and obj.name ~= nil and obj.name:lower() == 'illaoibase_e_spirittimeroutline.troy' then
		spirit = nil
		spirittimer = 0
		--isVessel() --Not needed anymore
	end
end

function OnProcessAttack(unit, spell)
	if unit == myHero and spell.name:lower():find('attack') then
		nextattacktime = os.clock() + (1 / myHero.attackSpeed)
	end
end

function OnRemoveBuff(unit, buff)
	if buff.name == 'illaoievesselvo' then
		for i = 1, 5 do
			if vessel[i] ~= nil and unit.networkID == vessel[i].networkID then
				vessel[i] = nil
				log:print("Deleted Vessel: "..unit.charName)
				return
			end
		end
	end
end

function OnRecvPacket(p)
	if GetGameVersion():sub(1,10) == supportedversion and VIP_USER then
		GetVessel(p)
	end
end

--[[
function GetVesselOLD(p) --Inserts the Vessel into the vessel Table.
	p.pos = 0 --Cause BoL sometimes does some random things..
	if p.header == 0x00C8 then
		p.pos = 2
		netid = p:DecodeF()
		p.pos = 0 --Cause BoL sometimes does some random things..
		for _,k in pairs(enemyheroes) do
			if k.networkID == netid then
				local flag = false
				for _, v in pairs(vessel) do
					if v == k then flag = true end
				end
				if flag == false then
					table.insert(vessel, k)
				end
			end
		end
	end
end
]]--

function GetVessel(p) --Inserts the Vessel into the vessel Table.
	p.pos = 0 --Cause BoL sometimes does some random things..
	if p.header == 0x00C8 then
		p.pos = 2
		netid = p:DecodeF()
		p.pos = 0 --Cause BoL sometimes does some random things..
		local obj = objManager:GetObjectByNetworkId(netid)
		if obj.team ~= myHero.team then
			for _, v in pairs(vessel) do
				if v == obj then return end
			end
			--table.insert(vessel, obj)
			log:print("Got Vessel Packet: "..obj.charName)
			if TargetHaveBuff("illaoievessel", obj) then
				vessel[#vessel+1] = obj
				log:print(obj.charName.." has the vessel Buff")
			end
		end
	end
end

--[[ --Not neaded anymore
function isVessel()
	for i, enemy in ipairs(enemyheroes) do
		if enemy ~= nil then
			for a = 1, enemy.buffCount do
				local tBuff = enemy:getBuff(a)
				if tBuff.name == 'illaoievessel' and tBuff.endT - GetGameTimer() == 60 then
					AddVessel(enemy)
					return
				end
			end
		end
	end
end


function AddVessel(unit)
	if unit ~= nil and not AlreadyVessel(unit) then
		for i = 1, 5 do
			if vessel[i] == nil then
				vessel[i] = unit
				return
			end
		end
	end
end

function AlreadyVessel(unit)
	for i = 1, 5 do
		if vessel[i] ~= nil and vessel[i].networkID == unit.networkID then
			return true
		end
	end
	return false
end
]]--

function VesselCount()
	--[[numvessel = 0
	for i = 1, 5 do
		if vessel[i] ~= nil then
			numvessel = numvessel + 1
		end
	end
	return numvessel]]--
	return #vessel --Should increase Performance
end

function OldTentacles()
	for i = 1, objManager.maxObjects do
		tobj = objManager:getObject(i)
		if tobj ~= nil and tobj.name == 'God' and tobj.team == myHero.team then
			TentacleManager(tobj, 1)
		end
	end
end

function TentacleManager(obj, status)
	if status == 1 then
		for i = 1, 30 do
			if tentacle[i] == nil then
				tentacle[i] = obj
				return
			end
		end
	elseif status == 2 then
		for i = 1, 30 do
			if tentacle[i] ~= nil and obj.networkID == tentacle[i].networkID then
				tentacle[i] = nil
				return
			end
		end
	end
end

function isSpirit(spiritname)
	if spiritname ~= nil then
		for i = 1, 6 do
			if i == 6 and enemyhero[i] == nil then
				return false
			elseif spiritname == enemyhero[i] then
				return true
			end
		end
	else
		return false
	end
end

function Enemies()
	herocounter = 1
	for i = 1, heroManager.iCount, 1 do
		local hero = heroManager:getHero(i)
		if hero ~= nil and hero.team ~= myHero.team then
			enemyhero[herocounter] = hero.name:lower()
			herocounter = herocounter + 1
		end
   end
end

function Orbwalker()
  if not _G.Reborn_Loaded then
	printChat('Sorry, SxOrbWalk does not currently support Illaoi.')
	--[[printChat('SAC:R not found. Using SxOrbWalk instead.')
	require ('SxOrbWalk')
	SxMenu = scriptConfig('Illaoi - SxOrbWalk', 'SxOrb')
	SxOrb:LoadToMenu(SxMenu, true)
	SxOrb:RegisterHotKey('fight', Menu.orbwalk, 'comboKey')
	SxOrb:RegisterHotKey('harass', Menu.orbwalk, 'harassKey')
	SxOrb:RegisterHotKey('laneclear', Menu.orbwalk, 'clearKey')
	SxOrb:RegisterHotKey('lasthit', Menu.orbwalk, 'lasthitKey') ]]
	elseif _G.Reborn_Loaded and not _G.Reborn_Initialised then
	DelayAction(Orbwalker, 1)
  elseif _G.Reborn_Initialised then
	_G.AutoCarry.Crosshair:SetSkillCrosshairRange(1000)
	printChat('SAC:R detected. Disabling SxOrbWalk.')
  end
end

function Compatibility()
	DelayAction(function()
		printChat('Please wait while we verify your prerequisites..')
	end, 1)
	if myHero.charName == 'Illaoi' then --Temp SAC:R Check until SxOrb is updated and supports Illaoi
		DelayAction(function()
			Champion = Illaoi()
		end, 2)
	elseif myHero.charName ~= 'Illaoi' then
		DelayAction(function()
			printChat('Sorry, it seems like you are not currently playing Illaoi.')
		end, 3)
	end
end

function printChat(m)
	print('<font color=\"#52527a\">Metro Series</font><font color=\"#888888\"> - </font><font color=\"#cccccc\">'..m..'</font>')
end

class 'Update'
function Update:__init()
  self.Version = scriptVersion
  self.DownloadPath = 'http://'..StridePage..ScriptLink
  self.SavePath = SCRIPT_PATH .. _ENV.FILE_NAME
  if os.clock() < 180 then
	self:Check()
  else
		DelayAction(function()
			printChat('The game is already in progress. Disabling auto update.')
			Compatibility()
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
		DelayAction(function()
			Compatibility()
		end, 1)
	end
end

class 'Spells'
function Spells:__init(slot, range, width, speed, delay, spellType, collision, key, trait, hitchance)
	self.slot = slot
	self.range = range
	self.width = width
	self.speed = speed
	self.delay = delay
	self.type = spellType
	self.collision = collision
	self.key = key
	self.trait = trait
	self.hitchance = hitchance or 0
	if self.type ~= 'self' and self.type ~= 'target' then
		local _aoe = false
		local _type = ""

		if self.type == 'ss_line' then 
			_type = "linear"
			if self.trait == 1 then
				_aoe = true
			end
		end

		if self.type == 'ss_cir' then 
			_type = "circular"
			if self.trait == 1 then
				_aoe = true
			end
		end

		if self.type == 'ss_cone' then 
			_type = "cone"
			if self.trait == 1 then
				_aoe = true
			end
		end
		DelayAction(function ()
			UPL:AddSpell(self.slot, {speed = self.speed, delay = self.delay, range = self.range, width = self.width, collision = self.collision, aoe = _aoe, type = _type})
		end, 11)
	end
end

function Spells:MeetReq(tar)
	if self:isReady() then
		if self.type == 'self' then
			return true
		elseif self.type == 'target' then
			return true
		elseif self.type == 'ss_line' then
			return self:Predict(tar)
		elseif self.type == 'ss_cir' then
			return self:Predict(tar)
		elseif self.type == 'ss_cone' then
			return self:Predict(tar)
		end
	end
end

function Spells:isReady()
	if myHero:CanUseSpell(self.slot) == READY then
		return true
	else
		return false
	end
end

function Spells:isHitChance(hs)
	if hs >= self.hitchance then
		return true
	end
end

function Spells:Predict(targ)
	self.CastPosition, self.HitChance, self.HeroPosition = UPL:Predict(self.slot, myHero, targ)
	if self.CastPosition and self:isHitChance(self.HitChance) then
		return true
	else
		return false
	end
end

function Spells:Cast(tar)
	self.target = tar
	if self.type == 'self' then
		CastSpell(self.slot)
	elseif self.type == 'target' then
		CastSpell(self.slot, self.target)
	elseif self.type == 'ss_line' then
		CastSpell(self.slot, self.CastPosition.x, self.CastPosition.z)
	elseif self.type == 'ss_cir' then
		CastSpell(self.slot, self.CastPosition.x, self.CastPosition.z)
	elseif self.type == 'ss_cone' then
		CastSpell(self.slot, self.CastPosition.x, self.CastPosition.z)
	end
end

class 'SelectTarget'
function SelectTarget()
	if not UOL then return nil end
	if UOL:GetTarget() ~= nil then
    	return UOL:GetTarget()
    elseif ts then
    	ts:update()
    	return ts.target
    end
end

class 'Minions'
function Minions:__init()
	minions = minionManager(MINION_ENEMY, 1200, myHero, MINION_SORT_HEALTH_ASC)
end

function Minions:Count()
	minions:update()
	return minions.iCount
end

function Minions:Lowest()
	minions:update()
	if minions.iCount >= 1 then
		return minions.objects[1]
	else
		return nil
	end
end

-- Illaoi --

class 'Illaoi'
function Illaoi:__init()
	printChat(myHero.charName..' - The Kraken Priestess <font color=\"#808080\">v'..scriptVersion..'</font> loaded. Good luck!')
	
	self.spells = {
	--  Spells(slot, range, width, speed, delay, type, collision, key, trait, hit Chance)
		Q = Spells(_Q, 800, 80, 2000, 1, "ss_line", false, "Q", 1, 2),
		W = Spells(_W, 600, 220, 0, 0, "self", false, "W", 0),
		E = Spells(_E, 900, 70, 1600, 0.25, "ss_line", true, "E", 0, 2),
		R = Spells(_R, 450, 70, 1600, .5, "self", true, "R", 1)
	}

	self:Menu()
	GetOrbWalker()
	--Orbwalker()
	
	self.focusspirit = false
	
	AddTickCallback(function () 
	self:OnTick() 
  end)
end

function Illaoi:OnTick()
	target = SelectTarget()
	--[[if spirit ~= nil and self.focusspirit == false then
		self.focusspirit = true
		if _G.AutoCarry then
			_G.AutoCarry.Crosshair:ForceTarget(spirit)
		elseif SxMenu then
			
		end
	elseif spirit == nil and self.focusspirit == true then
		self.focusspirit = false
		if _G.AutoCarry then
			_G.AutoCarry.Crosshair:UnlockTarget()
		elseif SxMenu then
			
		end
	end]]
	if Menu.orbwalk.harassKey then
		self:Harass()
	end
	if Menu.orbwalk.clearKey then
		self:Clear()
	end
	if Menu.orbwalk.lasthitKey then
		self:Lasthit()
	end
	if Menu.orbwalk.comboKey then
		self:Combo()
	end
end

function Illaoi:Combo()
	if target then
		if self:EnemyCount(800) > 1 then
			if Menu.combo.r.auto2 and self.spells.R:isReady() and self:EnemyCount(450) >= Menu.combo.r.targ2 then
				if Menu.combo.r.aftere and (self.spells.E:isReady() == false or Menu.combo.e.usee2 ~= 0) then
					self.spells.R:Cast()
				else
					self.spells.R:Cast()
				end
			end
			if self:CheckE() and self:Mana(Menu.combo.e.manae) then
				if Menu.combo.e.usee2 == 2 or (Menu.combo.e.usee2 == 3 and self.spells.R:isReady() == false) then
					self.spells.E:Cast()
				elseif (Menu.combo.e.usee2 == 1 or Menu.combo.usee2 == 3) --[[GetDistance(target) < 300]] then
					self.spells.E:Cast()
				end
			end
			if self.spells.W:isReady() and self:Mana(Menu.combo.w.manaw) then
				if Menu.combo.w.usew1 == 1 and GetDistance(target) <= 400 then
					self.spells.W:Cast()
					if _G.AutoCarry then
						_G.AutoCarry.Orbwalker:OnAttackReset()
					elseif SxMenu then
						SxOrb:Attack(target)
					end
					if currentOrbwalker ~= "SxOrbWalk" and currentOrbwalker ~= "SAC:R" and currentOrbwalker ~= "" and currentOrbwalker ~= "No Orbwalker found, please activate one in the 'Orbwalker' Menu" then
						UPL:ResetAA()
					end
				elseif Menu.combo.w.usew1 == 2 and os.clock() < nextattacktime then
					self.spells.W:Cast()
					if _G.AutoCarry then
						_G.AutoCarry.Orbwalker:OnAttackReset()
					elseif SxMenu then
						SxOrb:Attack(target)
					end
					if currentOrbwalker ~= "SxOrbWalk" and currentOrbwalker ~= "SAC:R" and currentOrbwalker ~= "" and currentOrbwalker ~= "No Orbwalker found, please activate one in the 'Orbwalker' Menu" then
						UPL:ResetAA()
					end
				end
			end
			if self.spells.Q:MeetReq(target) and self:Mana(Menu.combo.q.manaq) then
				if (Menu.combo.q.useq1 == 2 or Menu.combo.q.useq1 == 3) and self:Health(20) then
					self.spells.Q:Cast()
				elseif (Menu.combo.q.useq1 == 1 or Menu.combo.q.useq1 == 3) --[[and self.spells.Q.MaxHit >= 2 ]] then  
					self.spells.Q:Cast()
				end
			end
		elseif self:EnemyCount(1000) == 1 then
			if Menu.combo.r.auto1 and self.spells.R:isReady() and self:EnemyCount(450) >= Menu.combo.r.targ1 then
				self.spells.R:Cast()
			end
			if self.spells.E:MeetReq(target) and spirit == nil then
				if Menu.combo.e.usee1 == 1 and GetDistance(target) < 300 then
					self.spells.E:Cast()
				elseif Menu.combo.e.usee1 == 2 then
					self.spells.E:Cast()
				end
			end
			if self.spells.W:isReady() and self:Mana(Menu.combo.w.manaw) then
				if (Menu.combo.w.usew2 == 1 or Menu.combo.w.usew2 == 3) and GetDistance(target) > 250 and GetDistance(target) <= 400 then
					self.spells.W:Cast()
					if _G.AutoCarry then
						_G.AutoCarry.Orbwalker:OnAttackReset()
					elseif SxMenu then
						SxOrb:Attack(target)
					end
					if currentOrbwalker ~= "SxOrbWalk" and currentOrbwalker ~= "SAC:R" and currentOrbwalker ~= "" and currentOrbwalker ~= "No Orbwalker found, please activate one in the 'Orbwalker' Menu" then
						UPL:ResetAA()
					end
				elseif (Menu.combo.w.usew2 == 2 or (Menu.combo.w.usew2 == 3 and GetDistance(target) < 150)) and os.clock() < nextattacktime then
					self.spells.W:Cast()
					if _G.AutoCarry then
						_G.AutoCarry.Orbwalker:OnAttackReset()
					elseif SxMenu then
						SxOrb:Attack(target)
					end
					if currentOrbwalker ~= "SxOrbWalk" and currentOrbwalker ~= "SAC:R" and currentOrbwalker ~= "" and currentOrbwalker ~= "No Orbwalker found, please activate one in the 'Orbwalker' Menu" then
						UPL:ResetAA()
					end
				end
			end
			if self.spells.Q:MeetReq(target) and self:Mana(Menu.combo.q.manaq) then
				if Menu.combo.q.useq2 == 2 then
					self.spells.Q:Cast()
				elseif Menu.combo.q.useq2 == 1 and (GetDistance(target) <= 300 or self:Damage('Q', target) >= target.health) then   
					self.spells.Q:Cast()
				end
			end
		end
	end
end

function Illaoi:Lasthit()
	if os.clock() < nextattacktime and Minions:Count() ~= 0 and self:Mana(Menu.farm.w.manaw) and Menu.farm.w.usew == 1 and self:Damage('W',Minions:Lowest()) >= Minions:Lowest().health and self.spells.W:isReady() then
		self.spells.W:Cast()
		if _G.AutoCarry then
			_G.AutoCarry.Orbwalker:OnAttackReset()
		elseif SxMenu then
			SxOrb:Attack(minions.objects[1])
		end
	end
end

function Illaoi:Clear()
	if spirit ~= nil then
		if self.spells.Q:isReady() and self:Mana(Menu.clear.q.manaq) and self.spells.Q:MeetReq(spirit) then
			self.spells.Q:Cast()
		elseif self.spells.W:isReady() and self:Mana(Menu.clear.w.manaw) then
			self.spells.W:Cast()
			if _G.AutoCarry then
				_G.AutoCarry.Orbwalker:OnAttackReset()
			elseif SxMenu then
				SxOrb:Attack(spirit)
			end
		end
	else
		minix, miniy, miniz, minicount, lowestmini = Champion:Minions()
		if minix ~= 0 and minix ~= nil and self.spells.Q:isReady() and self:Mana(Menu.clear.q.manaq) and minicount >= Menu.clear.q.useq and Menu.clear.q.useq ~= 0 then
			--Manual casting due to artificial coordinates
			CastSpell(_Q, minix, miniz)
		elseif lowestmini ~= nil and GetDistance(lowestmini, myHero) < 350 then
			if (Menu.clear.w.usew == 1 or Menu.clear.w.usew == 3) and self.spells.W:isReady() and lowestmini ~= nil and self:Mana(Menu.clear.w.manaw) and self:Tentacles(lowestmini) >= 1 and Menu.clear.w.usew ~= 0 then
				self.spells.W:Cast()
				if _G.AutoCarry then
					_G.AutoCarry.Orbwalker:OnAttackReset()
				elseif SxMenu then
					SxOrb:Attack(lowestmini)
				end
				if currentOrbwalker ~= "SxOrbWalk" and currentOrbwalker ~= "SAC:R" and currentOrbwalker ~= "" and currentOrbwalker ~= "No Orbwalker found, please activate one in the 'Orbwalker' Menu" then
					UPL:ResetAA()
				end
			elseif Menu.clear.w.usew == 3 and os.clock() < nextattacktime and lowestmini ~= nil and self:Damage('W', lowestmini) >= lowestmini.health and self.spells.W:isReady() then 
				self.spells.W:Cast()
				if _G.AutoCarry then
					_G.AutoCarry.Orbwalker:OnAttackReset()
				elseif SxMenu then
					SxOrb:Attack(lowestmini)
				end
				if currentOrbwalker ~= "SxOrbWalk" and currentOrbwalker ~= "SAC:R" and currentOrbwalker ~= "" and currentOrbwalker ~= "No Orbwalker found, please activate one in the 'Orbwalker' Menu" then
					UPL:ResetAA()
				end
			elseif Menu.clear.w.usew == 2 and self.spells.W:isReady() and minicount >= 1 then
				self.spells.W:Cast()
				if _G.AutoCarry then
					_G.AutoCarry.Orbwalker:OnAttackReset()
				elseif SxMenu then
					SxOrb:Attack(lowestmini)
				end
				if currentOrbwalker ~= "SxOrbWalk" and currentOrbwalker ~= "SAC:R" and currentOrbwalker ~= "" and currentOrbwalker ~= "No Orbwalker found, please activate one in the 'Orbwalker' Menu" then
					UPL:ResetAA()
				end
			end
		end
	end 
end

function Illaoi:Harass()
	if spirit ~= nil then
		target = spirit
	end
	if target then
		if spirit == nil and self.spells.E:MeetReq(target) and self:Mana(Menu.harass.e.manae) and Menu.harass.e.pullspirit ~= 4 and Menu.harass.e.pullspirit ~= 0 and self:Tentacles(myHero) >= Menu.harass.e.pullspirit then
			self.spells.E:Cast()
		elseif spirit == nil and self.spells.E:MeetReq(target) and self:Mana(Menu.harass.e.manae) and Menu.harass.e.pullspirit == 4 then
			self.spells.E:Cast()
		end
		if self.spells.Q:MeetReq(target) and self:Mana(Menu.harass.q.manaq) then
			if (Menu.harass.q.useq == 3 or Menu.harass.q.useq == 4) and self:Health(20) then
				self.spells.Q:Cast()
			elseif (Menu.harass.q.useq == 1 or Menu.harass.q.useq == 4) and spirit ~= nil --[[and self.spells.Q.MaxHit >= 2]] then    
				self.spells.Q:Cast()
			elseif Menu.harass.q.useq == 2 or Menu.harass.q.useq == 4 then
				self.spells.Q:Cast()
			end
		end
		if Menu.harass.w.usew == 2 and os.clock() < nextattacktime and self.spells.W:isReady() and GetDistance(target) < 350 then 
			self.spells.W:Cast()
			if _G.AutoCarry then
				_G.AutoCarry.Orbwalker:OnAttackReset()
			elseif SxMenu then
				SxOrb:Attack(target)
			end
			if currentOrbwalker ~= "SxOrbWalk" and currentOrbwalker ~= "SAC:R" and currentOrbwalker ~= "" and currentOrbwalker ~= "No Orbwalker found, please activate one in the 'Orbwalker' Menu" then
				UPL:ResetAA()
			end
		elseif Menu.harass.w.usew == 1 then
			if self:Tentacles(target) >= 1 and GetDistance(target) < 350 then
				self.spells.W:Cast()
			end
		end
	end 
end

function Illaoi:EnemyCount(dist)
	self.nearby = 0
	if spirit ~= nil and dist == 450 then
		self.nearby = self.nearby + 1
	end
	for _, enemy in ipairs(enemyheroes) do
		if GetDistance(enemy, myHero) < dist and ValidTarget(enemy, dist) then
			self.nearby = self.nearby + 1
		end
	end
	return self.nearby
end

function Illaoi:Damage(skill, tar)
	self.armor = 100/(100 + tar.armor)
	if skill == 'Q' then
		self.baseq = {1.2, 1.3, 1.4, 1.5, 1.6}
		if myHero:GetSpellData(_Q).level == 0 or myHero:GetSpellData(_W).level == nil then
			return 0
		else
			return ((myHero.level * 10) + (self.baseq[myHero:GetSpellData(_Q).level] * myHero.totalDamage)) * self.armor
		end
	elseif skill == 'W' then
		self.basew = {15, 35, 55, 75, 95}
		if myHero:GetSpellData(_W).level == 0 or myHero:GetSpellData(_W).level == nil then
			return 0
		else
			self.wdmg = (self.basew[myHero:GetSpellData(_W).level] + (0.1 * myHero.totalDamage) + myHero.totalDamage) * self.armor
			return self.wdmg
		end
	else
		--return getDmg(skill, tar, myHero) Doesn't work on Illaoi
	end
end

function Illaoi:CheckE()
	for i, valtar in ipairs(enemyheroes) do
		if ValidTarget(valtar, 850) then
			if self.spells.E:MeetReq(valtar) then
				return true
			end
		end
	end
	return false
end

--[[function Illaoi:Minions()
	minions:update()
	self.avgminx = 0
	self.avgminy = 0
	self.avgminz = 0
	for i = 1, minions.iCount do
		self.avgminx = self.avgminx + minions.objects[i].x 
		self.avgminy = self.avgminy + minions.objects[i].y
		self.avgminz = self.avgminz + minions.objects[i].z
		if i == minions.iCount then
			return self.avgminx / i, self.avgminy / i, self.avgminz / i, i, minions.objects[1]
		end
	end
end]]--

--New Illaoi:Minons()

function Illaoi:Minions()

	local function GetLineAOECastPositionM(unit, delay, radius, range, speed, from)
		local CastPosition, HitChance, Position = VP:GetBestCastPosition(unit, delay, radius, range, speed, from, false, "line")
		local points = {}
		local Positions = {}
		local mainCastPosition, mainHitChance = CastPosition, HitChance
	
		table.insert(Positions, {unit = unit, HitChance = HitChance, Position = Position, CastPosition = CastPosition})
		table.insert(points, Position)
	
		range = range and range - 4 or 20000
		radius = radius == 0 and 1 or (radius + VP:GetHitBox(unit)) - 4
		from = from and Vector(from) or Vector(myHero)
	
		local function CircleCircleIntersection(C1, C2, R1, R2)
			local D = GetDistance(C1, C2)
			local A = (R1 * R1 - R2 * R2 + D * D ) / (2 * D)
			local H = math.sqrt(R1 * R1 - A * A);
			local Direction = (Vector(C2) - Vector(C1)):normalized()
			local PA = Vector(C1) + A * Direction
	
			local S1 = PA + H * Direction:perpendicular()
			local S2 = PA - H * Direction:perpendicular()
	
			return S1, S2
		end
	
		local function GetPosiblePoints(from, pos, width, range)
			local middlepoint = (from + pos)/2
			local P1, P2 = CircleCircleIntersection(from, middlepoint, width, GetDistance(middlepoint, from))
	
			local V1 = (P1 - from)
			local V2 = (P2 - from)
	
			return from + range * (pos - V1 - from):normalized(), from + range * (pos - V2 - from):normalized()
		end
	
		local function CountHits(P1, P2, width, points)
			local hits = 0
			local hitt = {}
			width = width + 2
			for i, point in ipairs(points) do
				local pointSegment, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(P1, P2, point)
				if isOnSegment and GetDistanceSqr(pointSegment, point) <= width * width then
					hits = hits + 1
					table.insert(hitt, point)
				elseif i == 1 then
					return -1
				end
			end
			return hits, hitt
		end
	
		for i, target in ipairs(minions.objects) do
			if target.networkID ~= unit.networkID and ValidTarget(target, range * 1.5) then
				CastPosition, HitChance, Position = VP:GetBestCastPosition(target, delay, radius, range, speed, from, false, "line")
				if GetDistance(from, Position) < (range + radius) then
					table.insert(points, Position)
					table.insert(Positions, {unit = target, HitChance = HitChance, Position = Position, CastPosition = CastPosition})
				end
			end
		end
	
		local MaxHit = 1
		local MaxHitPos
	
		if #points > 1 then
			for i, candidate in ipairs(points) do
				local C1, C2 = GetPosiblePoints(from, points[i], radius - 20, range)
				local hits, MPoints1 = CountHits(from, C1, radius, points)
				local hits2, MPoints2 = CountHits(from, C2, radius, points)
				if hits >= MaxHit then
					MaxHitPos = C1
					MaxHit = hits
					MaxHitPoints = MPoints1
				end
				if hits2 >= MaxHit then
					MaxHitPos = C2
					MaxHit = hits2
					MaxHitPoints = MPoints2
				end
			end
		end
	
		if MaxHit > 1 then
			--center the line
			local maxdist = -1
			local p1
			local p2
			for i, hitp in ipairs(MaxHitPoints) do
				for o, hitp2 in ipairs(MaxHitPoints) do
					local StartP, EndP = Vector(from), (Vector(hitp) + Vector(hitp2)) / 2
					local pointSegment, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(StartP, EndP, hitp)
					local pointSegment2, pointLine2, isOnSegment2 = VectorPointProjectionOnLineSegment(StartP, EndP, hitp2)
	
					local dist = GetDistanceSqr(hitp, pointLine) + GetDistanceSqr(hitp2, pointLine2)
					if dist >= maxdist then
						maxdist = dist
						p1 = hitp
						p2 = hitp2
					end
				end
			end
	
			if VP.ReturnHitTable then
				for i = #Positions, 1, -1 do
					local pointSegment, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(Vector(from), (p1 + p2) / 2, Positions[i].Position)
					if (not isOnSegment) or (GetDistanceSqr(pointLine, Positions[i].Position) > (radius + 5)^2) then
						table.remove(Positions, i)
					end
				end
			end
	
			return (p1 + p2) / 2, mainHitChance, MaxHit, Positions
		else
			return mainCastPosition, mainHitChance, 1, Positions
		end
	end

	minions:update()

	--GetLineAOECastPositionM
	local hits = 0
	local minion = nil
	local mainCastPosition = nil
	for _, v in pairs(minions.objects) do
		if GetDistance(v, myHero) <= 800 then
			mainCastPosition, mainHitChance, MaxHit, Positions = GetLineAOECastPositionM(v, 1, 80, 800, 2000, myHero)
			if MaxHit >= 1 and MaxHit > hits and mainHitChance >= 2 then
				hits = MaxHit
				minion = v
			end
		end
	end
	--return self.avgminx / i, self.avgminy / i, self.avgminz / i, i, minions.objects[1]

	if mainCastPosition then
		return mainCastPosition.x, mainCastPosition.y, mainCastPosition.z, hits, minions.objects[1]
	else
		return nil, nil, nil, 0, minions.objects[1]
	end
end

function Illaoi:Tentacles(loc)
	self.tcount = 0
	for i = 1, 30 do
		if tentacle[i] ~= nil then
			if GetDistance(tentacle[i], loc) < 750 and tentacle[i].maxHealth == 2 then
				self.tcount = self.tcount + 1
			end
		end
	end
	return self.tcount
end

function Illaoi:Health(amount)
	if amount >= (myHero.health/myHero.maxHealth) * 100 then
		return true
	else
		return false
	end
end

function Illaoi:Mana(amt)
	if amt <= (myHero.mana/myHero.maxMana) * 100 then
		return true
	else
		return false
	end
end

function Illaoi:Menu()
	if Menu then return end
	Menu = scriptConfig(myHero.charName.." - The Kraken Priestess", 'Illaoi')   
	---
	Menu:addSubMenu('Orbwalking', 'orbwalk')
		Menu.orbwalk:addParam("inf", "Please set this Key's to your", SCRIPT_PARAM_INFO, "")
		Menu.orbwalk:addParam("inf", "Orbwalker Keys", SCRIPT_PARAM_INFO, "")
		Menu.orbwalk:addParam('comboKey', 'SBTW Combo Mode', SCRIPT_PARAM_ONKEYDOWN, false, 32)
		Menu.orbwalk:addParam('harassKey', 'Mixed Mode', SCRIPT_PARAM_ONKEYDOWN, false, GetKey('C'))
		Menu.orbwalk:addParam('clearKey', 'Laneclear Mode', SCRIPT_PARAM_ONKEYDOWN, false, GetKey('V'))
		Menu.orbwalk:addParam('lasthitKey', 'Lasthit Mode', SCRIPT_PARAM_ONKEYDOWN, false, GetKey('X'))
	---
	Menu:addSubMenu('Drawings', 'draw')
		Menu.draw:addParam('target', 'Highlight Focused Target', SCRIPT_PARAM_ONOFF, true)
		Menu.draw:addParam('tentacle', 'Dynamic Tentacle Range', SCRIPT_PARAM_ONOFF, true)
		Menu.draw:addParam('spirittimer', 'Dynamic Spirit Timer', SCRIPT_PARAM_ONOFF, true)
		Menu.draw:addParam('vessel', 'Vessel Tracker', SCRIPT_PARAM_ONOFF, true)
		Menu.draw:addParam('ult', 'Dynamic Ultimate Range', SCRIPT_PARAM_ONOFF, true)
	---
	Menu:addSubMenu('Combo', 'combo')
		Menu.combo:addSubMenu('Q Settings', 'q')
			Menu.combo.q:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			Menu.combo.q:addParam('manaq', 'Use Q when mana >', SCRIPT_PARAM_SLICE, 10, 0, 100, 0)
			Menu.combo.q:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			Menu.combo.q:addParam('useq2', 'Q usage mode (1v1)', SCRIPT_PARAM_SLICE, 1, 0, 2, 0)
			Menu.combo.q:addParam("Buffer", "0 - Off", SCRIPT_PARAM_INFO, "")
			Menu.combo.q:addParam("Buffer", "1 - Only close range", SCRIPT_PARAM_INFO, "")
			Menu.combo.q:addParam("Buffer", "2 - Whenever ready", SCRIPT_PARAM_INFO, "")
			Menu.combo.q:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			Menu.combo.q:addParam('useq1', 'Q usage mode (Teamfight)', SCRIPT_PARAM_SLICE, 3, 0, 3, 0)
			Menu.combo.q:addParam("Buffer", "0 - Off", SCRIPT_PARAM_INFO, "")
			Menu.combo.q:addParam("Buffer", "1 - When hit > 2 targets", SCRIPT_PARAM_INFO, "")
			Menu.combo.q:addParam("Buffer", "2 - Use only when hp < 20%", SCRIPT_PARAM_INFO, "")
			Menu.combo.q:addParam("Buffer", "3 - Smart usage", SCRIPT_PARAM_INFO, "")
			Menu.combo.q:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
		Menu.combo:addSubMenu('W Settings', 'w')
			Menu.combo.w:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			Menu.combo.w:addParam('manaw', 'Use W when mana >', SCRIPT_PARAM_SLICE, 10, 0, 100, 0)
			Menu.combo.w:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			Menu.combo.w:addParam('usew2', 'W usage mode (1v1)', SCRIPT_PARAM_SLICE, 3, 0, 3, 0)
			Menu.combo.w:addParam("Buffer", "0 - Off", SCRIPT_PARAM_INFO, "")
			Menu.combo.w:addParam("Buffer", "1 - Whenever ready", SCRIPT_PARAM_INFO, "")
			Menu.combo.w:addParam("Buffer", "2 - Use as AA reset", SCRIPT_PARAM_INFO, "")
			Menu.combo.w:addParam("Buffer", "3 - Smart", SCRIPT_PARAM_INFO, "")
			Menu.combo.w:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			Menu.combo.w:addParam('usew1', 'W usage mode (Teamfight)', SCRIPT_PARAM_SLICE, 1, 0, 2, 0)
			Menu.combo.w:addParam("Buffer", "0 - Off", SCRIPT_PARAM_INFO, "")
			Menu.combo.w:addParam("Buffer", "1 - Whenever ready", SCRIPT_PARAM_INFO, "")
			Menu.combo.w:addParam("Buffer", "2 - Use as AA reset", SCRIPT_PARAM_INFO, "")
			Menu.combo.w:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
		Menu.combo:addSubMenu('E Settings', 'e')
			Menu.combo.e:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			Menu.combo.e:addParam('manae', 'Use E when mana >', SCRIPT_PARAM_SLICE, 10, 0, 100, 0)
			Menu.combo.e:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			Menu.combo.e:addParam('usee1', 'E usage mode (1v1)', SCRIPT_PARAM_SLICE, 1, 0, 2, 0)
			Menu.combo.e:addParam("Buffer", "0 - Off", SCRIPT_PARAM_INFO, "")
			Menu.combo.e:addParam("Buffer", "1 - Use at short range", SCRIPT_PARAM_INFO, "")
			Menu.combo.e:addParam("Buffer", "2 - Whenever ready", SCRIPT_PARAM_INFO, "")
			Menu.combo.e:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			Menu.combo.e:addParam('usee2', 'E usage mode (Teamfight)', SCRIPT_PARAM_SLICE, 3, 0, 3, 0)
			Menu.combo.e:addParam("Buffer", "0 - Off", SCRIPT_PARAM_INFO, "")
			Menu.combo.e:addParam("Buffer", "1 - Use only in short range", SCRIPT_PARAM_INFO, "")
			Menu.combo.e:addParam("Buffer", "2 - Whenever ready", SCRIPT_PARAM_INFO, "")
			Menu.combo.e:addParam("Buffer", "3 - Smart usage", SCRIPT_PARAM_INFO, "")
			Menu.combo.e:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
		Menu.combo:addSubMenu('R Settings', 'r')
			Menu.combo.r:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			Menu.combo.r:addParam('targ1', 'Minimum target to ult (1v1)', SCRIPT_PARAM_SLICE, 2, 1, 2, 0)
			Menu.combo.r:addParam('auto1', 'Automatic Ultimate (1v1)', SCRIPT_PARAM_ONOFF, false)
			Menu.combo.r:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			Menu.combo.r:addParam('targ2', 'Minimum target to ult (Teamfight)', SCRIPT_PARAM_SLICE, 1, 1, 6, 0)
			Menu.combo.r:addParam('auto2', 'Automatic Ultimate (Teamfight)', SCRIPT_PARAM_ONOFF, true)
			Menu.combo.r:addParam('aftere', 'Ult only after E attempt', SCRIPT_PARAM_ONOFF, true)
			Menu.combo.r:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
	---
	Menu:addSubMenu('Harass', 'harass')
		Menu.harass:addSubMenu('Q Settings', 'q')
			Menu.harass.q:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			Menu.harass.q:addParam('manaq', 'Use Q when mana >', SCRIPT_PARAM_SLICE, 30, 0, 100, 0)
			Menu.harass.q:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			Menu.harass.q:addParam('useq', 'Q usage mode', SCRIPT_PARAM_SLICE, 4, 0, 4, 0)
			Menu.harass.q:addParam("Buffer", "0 - Off", SCRIPT_PARAM_INFO, "")
			Menu.harass.q:addParam("Buffer", "1 - Spirit and target", SCRIPT_PARAM_INFO, "")
			Menu.harass.q:addParam("Buffer", "2 - Whenever ready", SCRIPT_PARAM_INFO, "")
			Menu.harass.q:addParam("Buffer", "3 - Use when hp < 20%", SCRIPT_PARAM_INFO, "")
			Menu.harass.q:addParam("Buffer", "4 - Smart usage", SCRIPT_PARAM_INFO, "")
			Menu.harass.q:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
		Menu.harass:addSubMenu('W Settings', 'w')
			Menu.harass.w:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			Menu.harass.w:addParam('manaw', 'Use W when mana >', SCRIPT_PARAM_SLICE, 30, 0, 100, 0)
			Menu.harass.w:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			Menu.harass.w:addParam('usew', 'W usage mode',  SCRIPT_PARAM_SLICE, 1, 0, 2, 0)
			Menu.harass.w:addParam("Buffer", "0 - Off", SCRIPT_PARAM_INFO, "")
			Menu.harass.w:addParam("Buffer", "1 - Enemy in tentacle range", SCRIPT_PARAM_INFO, "")
			Menu.harass.w:addParam("Buffer", "2 - Only as AA reset", SCRIPT_PARAM_INFO, "")
			Menu.harass.w:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
		Menu.harass:addSubMenu('E Settings', 'e')
			Menu.harass.e:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			Menu.harass.e:addParam('manae', 'Use E when mana >', SCRIPT_PARAM_SLICE, 50, 0, 100, 0)
			Menu.harass.e:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			Menu.harass.e:addParam('pullspirit', 'E usage mode',  SCRIPT_PARAM_SLICE, 1, 0, 4, 0)
			Menu.harass.e:addParam("Buffer", "0 - Off", SCRIPT_PARAM_INFO, "")
			Menu.harass.e:addParam("Buffer", "1-3 - x tentacles in range", SCRIPT_PARAM_INFO, "")
			Menu.harass.e:addParam("Buffer", "4 - Always use when can hit", SCRIPT_PARAM_INFO, "")
			Menu.harass.e:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
	---
	Menu:addSubMenu('Laneclear', 'clear')
		Menu.clear:addSubMenu('Q Settings', 'q')
			Menu.clear.q:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			Menu.clear.q:addParam('manaq', 'Use Q when mana >', SCRIPT_PARAM_SLICE, 40, 0, 100, 0)
			Menu.clear.q:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			Menu.clear.q:addParam('useq', 'Q usage mode', SCRIPT_PARAM_SLICE, 4, 0, 6, 0)
			Menu.clear.q:addParam("Buffer", "0 - Off", SCRIPT_PARAM_INFO, "")
			Menu.clear.q:addParam("Buffer", "1-6 - Use when > x minions", SCRIPT_PARAM_INFO, "")
			Menu.clear.q:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
		Menu.clear:addSubMenu('W Settings', 'w')
			Menu.clear.w:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			Menu.clear.w:addParam('manaw', 'Use W when mana >', SCRIPT_PARAM_SLICE, 40, 0, 100, 0)
			Menu.clear.w:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			Menu.clear.w:addParam('usew', 'W usage mode', SCRIPT_PARAM_SLICE, 1, 0, 3, 0)
			Menu.clear.w:addParam("Buffer", "0 - Off", SCRIPT_PARAM_INFO, "")
			Menu.clear.w:addParam("Buffer", "1 - Use when tentacle in range", SCRIPT_PARAM_INFO, "")
			Menu.clear.w:addParam("Buffer", "2 - Whenever ready", SCRIPT_PARAM_INFO, "")
			Menu.clear.w:addParam("Buffer", "3 - Smart usage", SCRIPT_PARAM_INFO, "")
			Menu.clear.w:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
	---
	Menu:addSubMenu('Lasthit', 'farm')
		Menu.farm:addSubMenu('W Settings', 'w')
		Menu.farm.w:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
		Menu.farm.w:addParam('manaw', 'Use W when mana >', SCRIPT_PARAM_SLICE, 30, 0, 100, 0)
		Menu.farm.w:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
		Menu.farm.w:addParam('usew', 'W usage mode', SCRIPT_PARAM_SLICE, 1, 0, 1, 0)
		Menu.farm.w:addParam("Buffer", "0 - Off", SCRIPT_PARAM_INFO, "")
		Menu.farm.w:addParam("Buffer", "1 - Smart usage", SCRIPT_PARAM_INFO, "")
		Menu.farm.w:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
	---
	Menu:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
	Menu:addParam("ScriptAuthor", "Metro Series - "..myHero.charName, SCRIPT_PARAM_INFO, "")
	Menu:addParam("Version", "Version "..scriptVersion, SCRIPT_PARAM_INFO, "")


	--Add UPL to Menu

	if not Menu.UPL then
		UPL:AddToMenu2(Menu)
		Menu.UPL:addParam("qhs", "Q Min Hitchance", SCRIPT_PARAM_SLICE, 2, 1, 3)
		Menu.UPL:removeCallback("qhs")
		Menu.UPL:setCallback("qhs", function ()
			Champion.spells.Q.hitchance = Menu.UPL.qhs
			end)
		Menu.UPL:removeCallback("ehs")
		Menu.UPL:addParam("ehs", "E Min Hitchance", SCRIPT_PARAM_SLICE, 2, 1, 3)
		Menu.UPL:setCallback("ehs", function ()
			Champion.spells.E.hitchance = Menu.UPL.ehs
		end)
	end

	--Add UOL to Menu--
	Menu:addSubMenu("Orbwalker", "orb")
	DelayAction(function ()
		UOL:AddToMenu(Menu.orb)
		DelayAction(function ()
			local walker = {"Nebelwolfi's Orb Walker", "SxOrbWalk", "Simple OrbWalker", "Big Fat OrbWalker"}
			Menu.orb:setCallback("o", function()
				if currentOrbwalker ~= "SAC:R" and currentOrbwalker ~= "MMA" and currentOrbwalker ~= "NOW" then
					currentOrbwalker = walker[Menu.orb.o]
					log:print("Changed Orbwalker: "..currentOrbwalker)
				end
			end)
			if Menu.orb.e then
				if currentOrbwalker ~= "SAC:R" and currentOrbwalker ~= "MMA" and currentOrbwalker ~= "NOW" then
					currentOrbwalker = walker[Menu.orb.o]
					log:print("Changed Orbwalker: "..currentOrbwalker)
				end
			end
			ConfigOrbWalker()
		end,1)
	end, 10)
end
-------------

function GetOrbWalker()
	DelayAction(function ()
		if _G.Reborn_Loaded or _G.AutoCarry then
		currentOrbwalker = "SAC:R"
	elseif _G.MMA_Loaded or _G.MMA_Version then
		currentOrbwalker = "MMA"
	elseif _G.NebelwolfisOrbWalkerInit or _G.NebelwolfisOrbWalkerLoaded then
		currentOrbwalker = "NOW"
	else
		DelayAction(function ()
			if currentOrbwalker == "" then
				currentOrbwalker = "No Orbwalker found, please activate one in the 'Orbwalker' Menu"
			end
		end,10)
	end
	ConfigOrbWalker()
	log:print("Current Orbwalker: "..currentOrbwalker)
	end,1)	
end

function ConfigOrbWalker()
	local function editSAC()
		if _G.AutoCarry and _G.AutoCarry.Crosshair then
			_G.AutoCarry.Crosshair:SetSkillCrosshairRange(1000)
		else
			DelayAction(function ()
				editSAC()
			end,1)
		end
	end 
	if currentOrbwalker == "SAC:R" then
		editSAC()
	elseif not ts then
		ts = TargetSelector(TARGET_LESS_CAST, 1200, DAMAGE_MAGIC, true)
		Menu:addTS(ts)
	end
end





class('LogHandler')
function LogHandler:__init()
	if not FileExist(SCRIPT_PATH .."\\MetroSeries_"..myHero.charName..".log") then
		local logfile = io.open(SCRIPT_PATH .."\\MetroSeries_"..myHero.charName..".log", "a")
		logfile:close()
		self:print("Generating new Log File on: "..os.date("%c"))
	end

	local logfile = io.open(SCRIPT_PATH .."\\MetroSeries_"..myHero.charName..".log", "a")
	logfile:write("\n\n")
	logfile:close()
	self:print("Loaded Script || Version: "..scriptVersion.." || LoLVersion: "..GetGameVersion():sub(1,10).." || InGameTime: "..string.format("%i:%02i", GetInGameTimer() / 60, GetInGameTimer() % 60))
	

	AddUnloadCallback( function() self:unload() end)
	AddBugsplatCallback( function() self:bugsplat() end)

end

function LogHandler:print(arg)
	local logfile = io.open(SCRIPT_PATH .."\\MetroSeries_"..myHero.charName..".log", "a")
	logfile:write(os.date("%c").." || ")
	if arg == nil then
		logfile:write("Got nil Value to write\n")
	else
		local _type = type(arg)
		local str = ""

		if _type == "string" then str = arg
		elseif _type == "number" then str = tostring(arg)
		elseif _type == "boolean" then str = arg and "true" or "false"
		elseif _type == "table" then str = table.serialize(arg)
		elseif _type == "userdata" then str = ctostring(v)
		else str = "Unknown type: ".._type
		end

		logfile:write(str.."\n")

	end
	logfile:close()
end

function LogHandler:unload()
	self:print("Unloading Script")
	self:print("==================================================")
end

function LogHandler:bugsplat()
	self:print("BUGSPLAT")
	self:print("==================================================")
end