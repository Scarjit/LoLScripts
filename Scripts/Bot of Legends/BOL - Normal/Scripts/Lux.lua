--[[
 __  __                    ____      _     _____ _             ____                                         _               
|  \/  | ___  _ __ ___    / ___| ___| |_  |_   _| |__   ___   / ___|__ _ _ __ ___   ___ _ __ __ _          | |   _   ___  __
| |\/| |/ _ \| '_ ` _ \  | |  _ / _ \ __|   | | | '_ \ / _ \ | |   / _` | '_ ` _ \ / _ \ '__/ _` |  _____  | |  | | | \ \/ /
| |  | | (_) | | | | | | | |_| |  __/ |_    | | | | | |  __/ | |__| (_| | | | | | |  __/ | | (_| | |_____| | |__| |_| |>  < 
|_|  |_|\___/|_| |_| |_|  \____|\___|\__|   |_| |_| |_|\___|  \____\__,_|_| |_| |_|\___|_|  \__,_|         |_____\__,_/_/\_\
]]
class "Lux"
class "Download"

function Lux:__init()	
	self:Variables()
	self:Callbacks()
	self:Menu()
	self:LoadTableOrbs()
	self:LoadOrb()
	self:AutoUpdater()
end

function Lux:Callbacks()
	AddTickCallback(function()
	if myHero.dead then return end
	Target = self:CustomTarget()
	QReady = myHero:CanUseSpell(_Q) == READY
	WReady = myHero:CanUseSpell(_W) == READY
	EReady = myHero:CanUseSpell(_E) == READY
	RReady = myHero:CanUseSpell(_R) == READY
	EBuff = function() return myHero:GetSpellData(_E).name ~= "LuxLightStrikeKugel" end
	if EBuff() then
    	for i, enemy in ipairs(GetEnemyHeroes()) do
    		if ValidTarget(enemy) and GetDistance(enemy, LastCastEPos) <= 320 then
    			CastSpell(_E, enemy.x, enemy.z)
    		end
    	end
    end
	self:Killsteal()
	self:Combo(Target)
	self:Harass(Target)
	self:Farming()
	self:Stealing()
	self:ManualR()
	end)
	AddCastSpellCallback(function(iSpell, startPos, endPos, targetUnit)
		if iSpell == 2 then
			LastCastEPos = endPos
		end
	end)
	AddMsgCallback(function(msg, key)
		if msg == WM_LBUTTONDOWN and not myHero.dead then
			for i, enemy in ipairs(GetEnemyHeroes()) do
        		if GetDistance(enemy, mousePos) <= 115 and ValidTarget(enemy) and enemy.type == "AIHeroClient" then
        			if self.SelectedTarget ~= enemy then
        				self.SelectedTarget = enemy
        				SendMsg("Selected Target: "..enemy.charName)
        			else
        				self.SelectedTarget = nil 
        				SendMsg("Unselected Target: "..enemy.charName)
        			end
				end
			end
		end
	end)
	AddDrawCallback(function()
		if myHero.dead then return end
		if Menu.Draws.Q and QReady then
			DrawCircle3D(myHero.x, myHero.y, myHero.z, 1200, 1, RGB(Menu.Draws.Color.Q[2], Menu.Draws.Color.Q[3], Menu.Draws.Color.Q[4]))
		end
		if Menu.Draws.E and EReady then
			DrawCircle3D(myHero.x, myHero.y, myHero.z, 1100, 1, RGB(Menu.Draws.Color.E[2], Menu.Draws.Color.E[3], Menu.Draws.Color.E[4]))
		end
		if Menu.Draws.R and RReady then
			DrawCircle3D(myHero.x, myHero.y, myHero.z, 3340, 1, RGB(Menu.Draws.Color.R[2], Menu.Draws.Color.R[3], Menu.Draws.Color.R[4]))
		end
		if Menu.Draws.Kill then
			for _, unit in pairs(GetEnemyHeroes()) do
				if ValidTarget(unit) then
					local barPos = self:GetHPBarPos(unit)
					local qDmg = GetDmg(_Q, unit)
					local eDmg = GetDmg(_E, unit)
					local rDmg = GetDmg(_R, unit)
					local dmg = 0
					if QReady then dmg = dmg + qDmg end
					if EReady then dmg = dmg + eDmg end
					if RReady then dmg = dmg + rDmg end
					local enemyperc = unit.health/unit.maxHealth
					local dmgperc = (dmg/unit.health)*100
					if QReady and EReady and RReady and qDmg+eDmg+rDmg > unit.health then
						DrawTextA("Q+E+R = Kill", 17, barPos.x+5, barPos.y-38, ARGB(255,255,255,255))
					elseif QReady and EReady and qDmg+eDmg > unit.health then
						DrawTextA("Q+E = Kill", 17, barPos.x+5, barPos.y-38, ARGB(255,255,255,255))
					elseif QReady and qDmg > unit.health then
						DrawTextA("Q = Kill", 17, barPos.x+5, barPos.y-38, ARGB(255,255,255,255))
					elseif EReady and RReady and eDmg+rDmg > unit.health then
						DrawTextA("E+R = Kill", 17, barPos.x+5, barPos.y-38, ARGB(255,255,255,255))
					elseif EReady and eDmg > unit.health then
						DrawTextA("E = Kill", 17, barPos.x+5, barPos.y-38, ARGB(255,255,255,255))
					elseif RReady and rDmg > unit.health then
						DrawTextA("R = Kill", 17, barPos.x+5, barPos.y-38, ARGB(255,255,255,255))
					end
					if dmgperc < 100 then
						DrawLine(barPos.x-5, barPos.y-12, barPos.x+(1.05*dmgperc)*enemyperc, barPos.y-12, 15, ARGB(180,2.55*dmgperc,0,-255+2.55*dmgperc))
						DrawTextA(math.round(dmgperc).."%",12,barPos.x+(1.05*dmgperc)*enemyperc/2, barPos.y-27)
					else
						DrawLine(barPos.x-5, barPos.y-12, barPos.x+105*enemyperc, barPos.y-12, 15, ARGB(180,255,0,0))
						DrawTextA("100%",12,barPos.x+(1.05*dmgperc)*enemyperc/2, barPos.y-27)
					end
				end
			end
		end
	end)
end

function Lux:Variables()
	self.Version = 0.03
	self.OrbWalkers = {}
	self.LoadedOrb = nil
	LastCastEPos = nil
    UPL:AddSpell(_Q, {speed = 1200, delay = 0.25, range = 1200, width = 125, collision = true, aoe = false, type = "linear"})
    UPL:AddSpell(_W, {speed = 1630, delay = 0.25, range = 1230, width = 205, collision = false, aoe = false, type = "linear"})
    UPL:AddSpell(_E, {speed = 1300, delay = 0.25, range = 1075, width = 320, collision = false, aoe = true, type = "circular"})
    UPL:AddSpell(_R, {speed = math.huge, delay = 1, range = 3340, width = 245, collision = false, aoe = false, type = "linear"})
    ts = TargetSelector(TARGET_LESS_CAST, 3330, DAMAGE_MAGIC)
	ts2 = TargetSelector(TARGET_LOW_HP, 3330, DAMAGE_MAGICAL)
	ts3 = TargetSelector(TARGET_NEAR_MOUSE, 3330, DAMAGE_MAGICAL)
	enemyMinions = minionManager(MINION_ENEMY, 1075, myHero, MINION_SORT_HEALTH_ASC)
	jungleMinions = minionManager(MINION_JUNGLE, 3330, myHero, MINION_SORT_MAXHEALTH_DEC)
	if myHero:GetSpellData(SUMMONER_1).name:find("SummonerDot") then 
		Ignite = SUMMONER_1 
	elseif myHero:GetSpellData(SUMMONER_2).name:find("SummonerDot") then 
		Ignite = SUMMONER_2 
	end
end

function Lux:Menu()
	Menu = scriptConfig("Mom Get The Camera - Lux", "MomGetTheCamera-Lux")

	Menu:addSubMenu("-> Combo", "Combo")
	Menu.Combo:addParam("Q", "--> Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.Combo:addParam("E", "--> Use E", SCRIPT_PARAM_ONOFF, true)
	Menu.Combo:addParam("R", "--> Use R", SCRIPT_PARAM_ONOFF, true)

	Menu:addSubMenu("-> Harass", "Harass")
	Menu.Harass:addParam("Q", "--> Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.Harass:addParam("E", "--> Use E", SCRIPT_PARAM_ONOFF, true)

	Menu:addSubMenu("-> Farming", "Farming")
	Menu.Farming:addParam("1", "-->                       LaneClear", SCRIPT_PARAM_INFO, "<--")
	Menu.Farming:addParam("LaneClearE", "--> Use E", SCRIPT_PARAM_ONOFF, true)
	Menu.Farming:addParam("LaneClearM", "--> Min minions to use E", SCRIPT_PARAM_SLICE, 4, 3, 6, 0)

	Menu:addSubMenu("-> Mana Manager", "Mana")
	Menu.Mana:addParam("1", "-->                       Harass", SCRIPT_PARAM_INFO, "<--")
	Menu.Mana:addParam("HarassQ", "--> Mana to use Q", SCRIPT_PARAM_SLICE, 35, 0, 100, 0)
	Menu.Mana:addParam("HarassE", "--> Mana to use E", SCRIPT_PARAM_SLICE, 35, 0, 100, 0)

	Menu.Mana:addParam("2", "-->                       LaneClear", SCRIPT_PARAM_INFO, "<--")
	Menu.Mana:addParam("LaneClearE", "--> Mana to use E", SCRIPT_PARAM_SLICE, 35, 0, 100, 0)

	Menu:addSubMenu("-> Manual R", "ManualR")
  	Menu.ManualR:addParam("Key", "Key to use Manual R", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("T"))
 	Menu.ManualR:addParam("Mode", "Mode", SCRIPT_PARAM_LIST, 4, {"Target", "Near Mouse", "Low HP", "Killable"})

	Menu:addSubMenu("-> Jungle Steal", "Steal")
  	Menu.Steal:addParam("Key", "Key to enable the Jungle Steal", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("H"))

	--[[Menu:addSubMenu("-> Auto Protect", "WProtect")
	for i, ally in ipairs(GetAllyHeroes()) do
		Menu.WProtect:addParam(ally.charName, "--> Protect "..ally.charName, SCRIPT_PARAM_ONOFF, true)
	end]]

	Menu:addSubMenu("-> Killsteal", "Killsteal")
	Menu.Killsteal:addParam("EnableA", "--> Killsteal with: All Spells", SCRIPT_PARAM_ONOFF, true)
	if Ignite then 
		Menu.Killsteal:addParam("Ignite", "--> Killsteal with: Ignite", SCRIPT_PARAM_ONOFF, true)
	end

	Menu:addSubMenu("-> Draws Settings", "Draws")
	Menu.Draws:addSubMenu("-> Colors Settings", "Color")
	Menu.Draws.Color:addParam("Q", "--> Q Range Color", SCRIPT_PARAM_COLOR, {255,255,255,255})
	Menu.Draws.Color:addParam("E", "--> E Range Color", SCRIPT_PARAM_COLOR, {255,255,255,255})
	Menu.Draws.Color:addParam("R", "--> R Range Color", SCRIPT_PARAM_COLOR, {255,255,255,255})
	Menu.Draws:addParam("Q", "--> Draw Q range", SCRIPT_PARAM_ONOFF, true)
	Menu.Draws:addParam("E", "--> Draw E range", SCRIPT_PARAM_ONOFF, true)
	Menu.Draws:addParam("R", "--> Draw R range", SCRIPT_PARAM_ONOFF, true)
 	Menu.Draws:addParam("Kill", "--> Draw Damage in Enemy Bar", SCRIPT_PARAM_ONOFF, true)

	Menu:addSubMenu("-> Auto Leveler", "Leveler")

	if VIP_USER then
		Menu.Leveler:addParam("Enable", "--> Enable Auto Leveler", SCRIPT_PARAM_ONOFF, false)
 		Menu.Leveler:addParam("Mode", "Mode", SCRIPT_PARAM_LIST, 3, {"Q>W>E", "Q>E>W", "E>Q>W", "E>W>Q"})
 		Menu.Leveler.Enable = false
 		DelayToLevel = 0
 		SequenceLevel = {
 		[1] = {1,2,3,1,1,4,2,1,2,3,4,1,2,3,2,4,3,3},
 		[2] = {1,3,2,1,1,4,3,1,3,2,4,1,3,2,3,4,2,2},
 		[3] = {3,1,2,3,3,4,1,3,1,2,4,3,1,2,1,4,2,2},
 		[4] = {3,2,1,3,3,4,2,3,2,1,4,3,2,1,2,4,1,1},
 		}
 		AddTickCallback(function()
 			if Menu.Leveler.Enable and os.clock()-DelayToLevel >= 2 then
 				DelayToLevel = os.clock()
 				autoLevelSetSequence(SequenceLevel[Menu.Leveler.Mode])
 			else
 				autoLevelSetSequence(nil)
 			end
 		end)
 	else
 		Menu.Leveler:addParam("info", "This is only for VIP Users", SCRIPT_PARAM_INFO, "")
 	end

	Menu:addSubMenu("-> Skin Changer", "Skin")

	if VIP_USER then
		Menu.Skin:addParam("ChangeSkin", "--> Enable Skin Changer", SCRIPT_PARAM_ONOFF, false)
		Menu.Skin:setCallback('ChangeSkin', function(Change)
			if Change then
				if Menu.Skin.SkinID == 1 then SkinToA = -1 end
				if Menu.Skin.SkinID == 2 then SkinToA = 1 end
				if Menu.Skin.SkinID == 3 then SkinToA = 2 end
				if Menu.Skin.SkinID == 4 then SkinToA = 3 end
				if Menu.Skin.SkinID == 5 then SkinToA = 4 end
				if Menu.Skin.SkinID == 6 then SkinToA = 5 end
				if Menu.Skin.SkinID == 7 then SkinToA = 6 end
				SetSkin(myHero, SkinToA)
			else
				SetSkin(myHero, -1)
			end
		end)
		Menu.Skin:addParam('SkinID', 'Skins', SCRIPT_PARAM_LIST, 1, {"Classic", "Sorcerres", "Spellthief", "Commando", "Imperial", "Steel Legion", "Star Guardian"})
		Menu.Skin:setCallback('SkinID', function(Change)
		if Menu.Skin.ChangeSkin then
			if Change == 1 then SkinToA = -1 end
			if Change == 2 then SkinToA = 1 end
			if Change == 3 then SkinToA = 2 end
			if Change == 4 then SkinToA = 3 end
			if Change == 5 then SkinToA = 4 end
			if Change == 6 then SkinToA = 5 end
			if Change == 7 then SkinToA = 6 end
			SetSkin(myHero, SkinToA)
		end
		end)
    
		if Menu.Skin.ChangeSkin then
			if Menu.Skin.SkinID == 1 then SkinToA = -1 end
			if Menu.Skin.SkinID == 2 then SkinToA = 1 end
			if Menu.Skin.SkinID == 3 then SkinToA = 2 end
			if Menu.Skin.SkinID == 4 then SkinToA = 3 end
			if Menu.Skin.SkinID == 5 then SkinToA = 4 end
			if Menu.Skin.SkinID == 6 then SkinToA = 5 end
			if Menu.Skin.SkinID == 7 then SkinToA = 6 end
			SetSkin(myHero, SkinToA)
		end
	else
		Menu.Skin:addParam("info", "This is only for VIP Users", SCRIPT_PARAM_INFO, "")
	end

	Menu:addSubMenu("", "info")

	UPL:AddToMenu(Menu, "-> Predictions")
	Menu:addParam("info1", "", SCRIPT_PARAM_INFO, "")
	Menu:addParam("author", "Author:", SCRIPT_PARAM_INFO, "HiranN")
end

function Lux:LoadTableOrbs()
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
	if FileExist(LIB_PATH .. "/SxOrbWalk.lua") then
		table.insert(self.OrbWalkers, "S1mpleOrbWalker")
	end
	if #self.OrbWalkers > 0 then
		Menu:addSubMenu("-> Orbwalkers", "Orbwalkers")
		Menu:addSubMenu("-> Keys", "Keys")
		Menu.Orbwalkers:addParam("Orbwalker", "OrbWalker", SCRIPT_PARAM_LIST, 1, self.OrbWalkers)
		Menu.Keys:addParam("info", "Detecting keys from :", SCRIPT_PARAM_INFO, self.OrbWalkers[Menu.Orbwalkers.Orbwalker])
	  	Menu.Keys:addParam("Harass", "--> Key to toggle Harass", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("L"))
	  	Menu.Keys:addParam("LaneClear", "--> Key to toggle LaneClear", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("K"))
	  	Menu.Keys:addParam("Steal", "--> Key to toggle Jungle Steal", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("G"))
	  	Menu.Keys.Harass = false
	  	Menu.Keys.LaneClear = false
	  	Menu.Keys.Steal = false
		local OrbAlr = false
  			Menu.Orbwalkers:setCallback("Orbwalker", function(value) 
  			if OrbAlr then return end
  			OrbAlr = true
 			Menu.Orbwalkers:addParam("info", "Press F9 2x to load your selected Orbwalker.", SCRIPT_PARAM_INFO, "")
  			SendMsg("Press F9 2x to load your selected Orbwalker")
  		end)
	end
end

function Lux:LoadOrb()
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
    --Menu.Orbwalkers:addSubMenu("NOW", "NOW")
    --_G.NebelwolfisOrbWalkerClass(Menu.Orbwalkers.NOW)	
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
	elseif self.OrbWalkers[Menu.Orbwalkers.Orbwalker] == "S1mpleOrbWalker" then 
	require "S1mpleOrbWalker"
	DelayAction(function()
    _G.S1mpleOrbWalker:AddToMenu(Menu.Orbwalkers)
    end, 1)
	end
end

function Lux:Keys()
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
	elseif self.LoadedOrb == "S1mpleOrbWalker" then
	if _G.S1mpleOrbWalker.aamode == "sbtw" then return "Combo" end
	if _G.S1mpleOrbWalker.aamode == "harass" then return "Harass" end
	if _G.S1mpleOrbWalker.aamode == "laneclear" then return "Laneclear" end
	if _G.S1mpleOrbWalker.aamode == "lasthit"then return "Lasthit" end
	end
end

function Lux:CustomTarget()
	ts:update()
	if self.SelectedTarget == nil then
		return ts.target
	elseif self.SelectedTarget ~= nil and ValidTarget(self.SelectedTarget, 750) then
		return self.SelectedTarget
	else
		return ts.target
	end
end

function Lux:Combo(unit)
	if unit and ValidTarget(unit) and self:Keys() == "Combo" then
		if Menu.Combo.Q and QReady and GetDistance(unit) <= 1200 then
			self:Cast(_Q, unit)
		end
		if Menu.Combo.E and EReady and GetDistance(unit) <= 1075 then 
			self:Cast(_E, unit)
		end
		if Menu.Combo.R and RReady and GetDistance(unit) <= 3340 and unit.health < GetDmg(_R, unit) then 
			self:Cast(_R, unit)
		end
	end
end

function Lux:Harass(unit)
	if unit and ValidTarget(unit) and (self:Keys() == "Harass" or Menu.Keys.Harass) then
		if Menu.Harass.Q and QReady and GetDistance(unit) <= 1200 then
			self:Cast(_Q, unit)
		end
		if Menu.Harass.E and EReady and GetDistance(unit) <= 1075 then
			self:Cast(_E, unit)
		end
	end
end

function Lux:Farming()
	enemyMinions:update()
	for _, minions in ipairs(enemyMinions.objects) do
		if ValidTarget(minions) and (self:Keys() == "Laneclear" or Menu.Keys.LaneClear) then
			if Menu.Farming.LaneClearE and EReady and self:ManaCheck(Menu.Mana.LaneClearE) then
				local BestPos, BestHit = self:GetFarmPosition(1075, 330)
				if BestPos and BestHit and BestHit >= Menu.Farming.LaneClearM then
					if GetDistance(BestPos) < 1075 then
    					if not EBuff() then
      						CastSpell(_E, BestPos.x, BestPos.z)
    					elseif EBuff() then
    						CastSpell(_E)
    					end
					end
				end
			end
		end
	end
end

function Lux:Stealing()
	jungleMinions:update()
	for _, minions in ipairs(jungleMinions.objects) do
		if ValidTarget(minions) and (Menu.Steal.Key or Menu.Keys.Steal) and (minions.name:lower():find("dragon") or minions.name:lower():find("baron")) then
			ExtraDmg = 0
			for i, enemy in ipairs(GetEnemyHeroes()) do
				if ValidTarget(enemy) and GetDistance(enemy, minions) <= 800 then
					ExtraDmg = ExtraDmg+enemy.totalDamage
				end
			end
			if EReady and RReady and GetDistance(minions) <= 1075 then
				if GetDmg(_E, minions)+GetDmg(_R, minions)+ExtraDmg > minions.health then
					EPos, EHit, HeroPosition = UPL:Predict(_E, myHero, minions)
					RPos, RHit, HeroPosition = UPL:Predict(_R, myHero, minions)
    				if RHit and EHit and RPos and EPos then
    					CastSpell(_E, EPos.x, EPos.z)
      					CastSpell(_R, RPos.x, RPos.z)
    					DelayAction(function()
    						CastSpell(_E)
    					end,0.90)
    				end
				end
			elseif RReady and GetDistance(minions) <= 3340 then
				if GetDmg(_R, minions)+ExtraDmg > minions.health then
					RPos, RHit, HeroPosition = UPL:Predict(_R, myHero, minions)
    				if RHit and RPos then
      					CastSpell(_R, RPos.x, RPos.z)
      				end
      			end
			end
		end
	end
end

function Lux:GetFarmPosition(range, width)
    local BestPos 
    local BestHit = 0
    local objects = enemyMinions.objects
    for i, object in pairs(objects) do
      local hit = self:CountObjectsNearPos(object.pos or object, range, width, objects)
      if hit > BestHit and GetDistanceSqr(object) < range * range then
        BestHit = hit
        BestPos = Vector(object)
        if BestHit == #objects then
          break
        end
      end
    end
    return BestPos, BestHit
end

function Lux:CountObjectsNearPos(pos, range, radius, objects)
    local n = 0
    for i, object in pairs(objects) do
      if GetDistance(pos, object) <= radius then
        n = n + 1
      end
    end
    return n
end

function Lux:Killsteal()
	for i, enemy in ipairs(GetEnemyHeroes()) do
		if not ValidTarget(enemy) then return end
		if Menu.Killsteal.EnableA then
			local qDmg = GetDmg(_Q, enemy)
			local eDmg = GetDmg(_E, enemy)
			local rDmg = GetDmg(_R, enemy)
			if QReady and EReady and RReady and GetDistance(enemy) <= 1180 and qDmg+eDmg+rDmg > enemy.health then
				self:Cast(_Q, enemy)
				self:Cast(_E, enemy)
				self:Cast(_R, enemy)
			elseif QReady and EReady and qDmg+eDmg > enemy.health then
				self:Cast(_Q, enemy)
				self:Cast(_E, enemy)
			elseif QReady and qDmg > enemy.health and GetDistance(enemy) <= 1200 then
				self:Cast(_Q, enemy)
			elseif EReady and RReady and GetDistance(enemy) <= 1180 and eDmg+rDmg > enemy.health then
				self:Cast(_E, enemy)
				self:Cast(_R, enemy)
			elseif EReady and eDmg > enemy.health then
				self:Cast(_E, enemy)
			elseif RReady and rDmg > enemy.health then
				self:Cast(_R, enemy)
			end
		end
		if Ignite and Menu.Killsteal.Ignite and enemy.health <= 50 + (20 * myHero.level) and myHero:CanUseSpell(Ignite) == READY and GetDistance(enemy) < 650 then
			CastSpell(Ignite, enemy)
		end	
	end
end

function Lux:ManaCheck(menu)
	if menu <= 100 * myHero.mana / myHero.maxMana then 
		return true
	else
		return false
	end
end

function Lux:ManualR()
	if not Menu.ManualR.Key then return end
	ts2:update()
	ts3:update()
	if Menu.ManualR.Mode == 1 and ValidTarget(Target) then
		self:Cast(_R, Target)
	elseif Menu.ManualR.Mode == 2 and ValidTarget(ts3.target) then
		if ts3.target then
			self:Cast(_R, ts3.target)
		end
	elseif Menu.ManualR.Mode == 3 and ValidTarget(ts2.target) then
		if ts2.target then
			self:Cast(_R, ts2.target)
		end
	end
end

function Lux:Cast(spell, target)
	Ranges = {
	[_Q] = 1200,
	[_W] = 1230,
	[_E] = 1075,
	[_R] = 3340,
	}
    Pos, Hit, HeroPosition = UPL:Predict(spell, myHero, target)
	if spell ~= _E then
    	if GetDistance(target) <= Ranges[spell] and myHero:CanUseSpell(spell) == READY and Pos and Hit >= 0 then
      		CastSpell(spell, Pos.x, Pos.z)
    	end
    else
    	if not EBuff() then
    		if GetDistance(target) <= Ranges[spell] and myHero:CanUseSpell(spell) == READY and Pos and Hit >= 0 then
      			CastSpell(_E, Pos.x, Pos.z)
    		end
    	end
    end
end

function Lux:GetHPBarPos(enemy)
 	enemy.barData = {PercentageOffset = {x = -0.05, y = 0}}
  	local barPos = GetUnitHPBarPos(enemy)
  	local barPosOffset = GetUnitHPBarOffset(enemy)
  	local barOffset = { x = enemy.barData.PercentageOffset.x, y = enemy.barData.PercentageOffset.y }
  	local barPosPercentageOffset = { x = enemy.barData.PercentageOffset.x, y = enemy.barData.PercentageOffset.y }
  	local BarPosOffsetX = 171
  	local BarPosOffsetY = 46
  	local CorrectionY = 39
  	local StartHpPos = 31
	do
		local t = {
			["Darius"] = -0.05,
			["Renekton"] = -0.05,
			["Sion"] = -0.05,
			["Thresh"] = 0.03,
			["Jhin"] = -0.06,
		}
		barOffset.x = t[enemy.charName] or 0
	end
  	barPos.x = math.floor(barPos.x + (barPosOffset.x - 0.5 + barPosPercentageOffset.x) * BarPosOffsetX + StartHpPos)
  	barPos.y = math.floor(barPos.y + (barPosOffset.y - 0.5 + barPosPercentageOffset.y) * BarPosOffsetY + CorrectionY)

 	local StartPos = Vector(barPos.x , barPos.y, 0)
  	local EndPos = Vector(barPos.x + 108 , barPos.y , 0)
  	return Vector(StartPos.x, StartPos.y, 0), Vector(EndPos.x, EndPos.y, 0)
end

local Dashes = {
	["ahritumble"] = {targetted = false},
	["akalishadowdance"] = {targetted = true},
	["headbutt"] = {targetted = true},
	["caitlynentrapment"] = {targetted = false},
	["carpetbomb"] = {targetted = true},
	["dianateleport"] = {targetted = true},
	["fizzpiercingstrike"] = {targetted = true},
	["fizzjump"] = {targetted = false},
	["gragasbodyslam"] = {targetted = false},
	["gravesmove"] = {targetted = false},
	["ireliagatotsu"] = {targetted = true},
	["jarvanivdragonstrike"] = {targetted = false},
	["jaxleapstrike"] = {targetted = true},
	["khazixe"] = {targetted = false},
	["leblancslide"] = {targetted = false},
	["leblancslidem"] = {targetted = false},
	["blindmonkqtwo"] = {targetted = true},
	["luciane"] = {targetted = false},
	["pantheon_leapbash"] = {targetted = true},
	["renektonsliceanddice"] = {targetted = false},
	["sejuaniarcticassault"] = {targetted = false},
	["shenshadowdash"] = {targetted = false},
	["shyvanatransformcast"] = {targetted = false},
	["rocketjump"] = {targetted = false},
	["slashcast"] = {targetted = false},
	["vaynetumble"] = {targetted = false},
	["viq"] = {targetted = false},
	["monkeykingnimbus"] = {targetted = true},
	["xenzhaosweep"] = {targetted = true},
	["yasuodashwrapper"] = {targetted = true},
}

Damage = {
	[_Q] = function() return 10+50*myHero:GetSpellData(_Q).level+0.7*myHero.ap end,
	[_E] = function() return 15+45*myHero:GetSpellData(_E).level+0.6*myHero.ap end,
	[_R] = function() return 200+100*myHero:GetSpellData(_R).level+0.75*myHero.ap end,
}

function Lux:AutoUpdater()
	local host = "www.scarjit.de"
	local file = "/HiranN/BoL/Scripts/Lux.lua"
	local file2 = "/HiranN/BoL/Versions/"
	local name = GetCurrentEnv().FILE_NAME
	local path = SCRIPT_PATH
	DelayAction(function()
		local ServerVersionDATA = GetWebResult(host, file2.."Lux.version")
		local ServerVersion = tonumber(ServerVersionDATA)
		if ServerVersion then
			if ServerVersion > tonumber(self.Version) then
				DL = Download()
				SendMsg("Updating to version: "..ServerVersion)
				DL:newDL(host, file, name, path, function()
					SendMsg("Updated to version: "..ServerVersion..", press 2x F9")
				end)
			else
				SendMsg("You have the latest version: "..self.Version)
			end
		else
			SendMsg("Can't connect to Updater Site")
		end
	end, 0.85)
end

function GetDmg(spell, target)
	if target and spell then
		return myHero:CalcMagicDamage(target, Damage[spell]())
	end
end

function SendMsg(msg)
	if msg then
		PrintChat("<font color=\"#FF80AC\"><u><b>Mom Get The Camera - Lux:</b></u></font> "..msg..".")
	end
end

if myHero.charName ~= "Lux" then return end

if not _G.UPLloaded then
  if FileExist(LIB_PATH .. "/UPL.lua") then
    require("UPL")
    UPL = UPL()
  else 
    SendMsg("Downloading UPL, please don't press F9")
    DelayAction(function() DownloadFile("https://raw.github.com/nebelwolfi/BoL/master/Common/UPL.lua".."?rand="..math.random(1,10000), LIB_PATH.."UPL.lua", function () SendMsg("Successfully downloaded UPL. Press F9 twice") end) end, 3) 
    return
  end
end

-- Bol Tools Tracker --
assert(load(Base64Decode("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"), nil, "bt", _ENV))()
TrackerLoad("umUeOrXJQqBi1uRl")
-- Bol Tools Tracker --

function OnLoad()
	Lux()
	DelayAction(function()
	SendMsg("Welcome "..GetUser())
	end, 0.50)
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
		self.headsocket:connect(host, 80)
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