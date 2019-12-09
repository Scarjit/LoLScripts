class 'Fiora'
class 'Download'

function Fiora:__init()
	self.Version = 0.25
	self.OrbWalkers = {}
	self.Recalling = {}
	self.recallTimes = {
	['recall'] = 7.9,
	['odinrecall'] = 4.4,
	['odinrecallimproved'] = 3.9,
	['recallimproved'] = 6.9,
	['superrecall'] = 3.9,
	}
	self.LoadedOrb = nil
	self.Vitals = {}
	self.HasLantern = nil
	self.LastP = 0
	ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, 1000, DAMAGE_MAGICAL)
	self:Menu()
	self:Callbacks()
	self:LoadTableOrbs()
	self:LoadOrb()
	self:SendMsg("<font color=\"#B8860B\"><b>"..GetUser()..", </b></font>".."Thanks for using Fiora Vital Spot")
	self:CheckUpdates()
end

function Fiora:Menu()
	Menu = scriptConfig("Fiora Vital Spot", "FioraVitalSpot")

	Menu:addSubMenu("Q Settings", "Q")
	Menu:addSubMenu("Auto Riposte", "Riposte")
	Menu:addSubMenu("E Settings", "E")
	Menu:addSubMenu("R Settings", "R")	
	Menu:addSubMenu("Lock Target", "Target")
	Menu:addSubMenu("Draw Settings", "Draw")
	Menu:addSubMenu("Emote on Kill", "Emote")
	Menu:addSubMenu("Skin Changer", "Skin")
	Menu:addSubMenu("Recall Tracker", "Recall")

	Menu.Q:addParam("Q", "Use Q in Combo", SCRIPT_PARAM_ONOFF, true)
	Menu.E:addParam("E", "Use E in Combo", SCRIPT_PARAM_ONOFF, true) 
	Menu.E:addParam("El", "Use E in Laneclear", SCRIPT_PARAM_ONOFF, true) 
	Menu.R:addParam("R", "Use R in Combo", SCRIPT_PARAM_ONOFF, true)
	Menu.R:addParam("RE", "Enemies around to use R", SCRIPT_PARAM_SLICE, 3, 1, 5, 0)

	Menu.Riposte:addParam("W", "Use Auto W", SCRIPT_PARAM_ONOFF, true) 
	Menu.Riposte:addParam("info", "Only working for Targetted spells.", SCRIPT_PARAM_INFO, "[BETA]")

	Menu.Target:addParam("On", "Enable Lock Target with Left-Click", SCRIPT_PARAM_ONOFF, true)

	Menu.Draw:addParam("DrawV", "Draw Vital Spots on Target", SCRIPT_PARAM_ONOFF, true)
	Menu.Draw:addParam("DrawL", "Draw Line on Target", SCRIPT_PARAM_ONOFF, true)
	Menu.Draw:addParam("DrawC", "Draw Circle around Fiora", SCRIPT_PARAM_ONOFF, true)

	Menu.Emote:addParam("On", "Use Emote on Kill", SCRIPT_PARAM_ONOFF, false)
	if VIP_USER then
	Menu.Emote:addParam("E", "Emote", SCRIPT_PARAM_LIST, 4, {"Dance", "Taunt", "Laugh", "Joke", "Mastery"})
	else
	Menu.Emote:addParam("E", "Emote", SCRIPT_PARAM_LIST, 4, {"Dance", "Taunt", "Laugh", "Joke"})
	end

	if Menu.Emote.E == 5 and not VIP_USER then Menu.Emote.E = 4 end

	if VIP_USER then
    Menu.Skin:addParam('On', 'Change Skin', SCRIPT_PARAM_ONOFF, false);
    Menu.Skin:addParam('SkinList', 'Skin', SCRIPT_PARAM_LIST, 5, {"Royal Guard", "Nightraven", "Headmistress", "PROJECT", "Classic"})
    Menu.Skin:setCallback('On', function(c)
    if (c) then
    SetSkin(myHero, Menu.Skin.SkinList)
    else
    SetSkin(myHero, -1)
    end
    end)
    Menu.Skin:setCallback('SkinList', function(c)
    if (Menu.Skin.On) then
    SetSkin(myHero, c)
   	end
    end)
    if (Menu.Skin.On) then
    SetSkin(myHero, Menu.Skin.SkinList)
    end
	else
	Menu.Skin:addParam("info", "You need be VIP to use this.", SCRIPT_PARAM_INFO, "")
	end

	if VIP_USER then
	AddRecvPacketCallback2(function(p) self:RecvPacket(p) end)
    Menu.Recall:addParam('On', 'Use Recall Tracker', SCRIPT_PARAM_ONOFF, true);
  	Menu.Recall:addParam("DrawB", "Draw Recall Bar", SCRIPT_PARAM_ONOFF, true)
    Menu.Recall:addParam('PrintR', 'Print Recalling', SCRIPT_PARAM_ONOFF, false);
    Menu.Recall:addParam('PrintF', 'Print Finish Recall', SCRIPT_PARAM_ONOFF, true);
	else
	Menu.Recall:addParam("info", "You need be VIP to use this.", SCRIPT_PARAM_INFO, "")
	end
  	for i, ally in ipairs(GetAllyHeroes()) do
  	if ally.charName == "Thresh" then
	Menu:addSubMenu("Grab Thresh Lantern", "Lantern")
	if VIP_USER then
	Menu.Lantern:addParam("Grab", "Grab Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("T"))
    Menu.Lantern:addParam("Auto", "Auto Grab if life below %", SCRIPT_PARAM_SLICE, 15, 0, 100, 0)
	Menu.Lantern:addParam("Autoinfo", "0 % will disable this option.", SCRIPT_PARAM_INFO, "")
    Menu.Lantern:addParam("AutoR", "Range to Auto Grab", SCRIPT_PARAM_SLICE, 1000, 250, 2000, 0)
	AddTickCallback(function() self:TickLantern() end)
	else
	Menu.Lantern:addParam("info", "You need be VIP to use this.", SCRIPT_PARAM_INFO, "")
	end
	end
	end

	ts.name = "Fiora"
	Menu:addTS(ts)

	Menu:addParam("info", "Author:", SCRIPT_PARAM_INFO, "HiranN")
	Menu:addParam("info2", "Your Region:", SCRIPT_PARAM_INFO, GetGameRegion())
end

function Fiora:SendMsg(msg)
	PrintChat("<font color=\"#3FF4CB\"><b>[Fiora Vital Spot]</b></font> ".."<font color=\"#DFBC5E\"><b>"..msg..".</b></font>")
end

function Fiora:LoadTableOrbs()
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
	Menu:addSubMenu("Orbwalkers", "Orbwalkers")
	Menu:addSubMenu("Keys", "Keys")
	Menu.Orbwalkers:addParam("Orbwalker", "OrbWalker", SCRIPT_PARAM_LIST, 1, self.OrbWalkers)
	Menu.Keys:addParam("info", "Detecting keys from :", SCRIPT_PARAM_INFO, self.OrbWalkers[Menu.Orbwalkers.Orbwalker])
	local OrbAlr = false
  	Menu.Orbwalkers:setCallback("Orbwalker", function(value) 
  	if OrbAlr then return end
  	OrbAlr = true
 	Menu.Orbwalkers:addParam("info", "Press F9 2x to load your selected Orbwalker.", SCRIPT_PARAM_INFO, "")
  	self:SendMsg("Press F9 2x to load your selected Orbwalker")
  	end)
	end
end

function Fiora:LoadOrb()
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
function Fiora:Keys()
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

function Fiora:Callbacks()
	AddTickCallback(function() self:Tick() end)
	AddDrawCallback(function() self:Draw() end)
	AddCreateObjCallback(function(obj) self:CreateObj(obj) end)
	AddDeleteObjCallback(function(obj) self:DeleteObj(obj) end)
	AddAnimationCallback(function(unit, animation) self:Animation(unit, animation) end)
	AddProcessSpellCallback(function(unit, spell) self:ProcessSpell(unit, spell) end)
	AddMsgCallback(function(msg, key) self:WndMsg(msg, key) end)
end

function Fiora:CreateObj(obj)
	if obj and obj.valid then
 	if obj.name:find("Fiora_Base_Passive_SE.troy") or
 	obj.name:find("Fiora_Base_Passive_NE.troy") or
 	obj.name:find("Fiora_Base_Passive_SW.troy") or
 	obj.name:find("Fiora_Base_Passive_NW.troy") 
 	then
	table.insert(self.Vitals, obj)
 	elseif obj.name:find("Fiora_Base_R_Mark_SE_FioraOnly.troy") or 
 	obj.name:find("Fiora_Base_R_Mark_NE_FioraOnly.troy") or
 	obj.name:find("Fiora_Base_R_Mark_SW_FioraOnly.troy") or
 	obj.name:find("Fiora_Base_R_Mark_NW_FioraOnly.troy") 
 	then
  	table.insert(self.Vitals, obj)	
	end
	end
	if obj and obj.valid and obj.team == myHero.team and obj.name == "ThreshLantern" then
	self.HasLantern = obj
	end
end

function Fiora:DeleteObj(obj)
	if obj and obj.valid then
 	if obj.name:find("Fiora_Base_Passive_SE.troy") or
 	obj.name:find("Fiora_Base_Passive_NE.troy") or 
 	obj.name:find("Fiora_Base_Passive_SW.troy") or 
 	obj.name:find("Fiora_Base_Passive_NW.troy") 
 	then
	for i, vital in ipairs(self.Vitals) do
	if obj == vital then
	table.remove(self.Vitals, i)
	end
	end
 	elseif obj.name:find("Fiora_Base_R_Mark_SE_FioraOnly.troy") or 
 	obj.name:find("Fiora_Base_R_Mark_NE_FioraOnly.troy") or 
 	obj.name:find("Fiora_Base_R_Mark_SW_FioraOnly.troy") or 
 	obj.name:find("Fiora_Base_R_Mark_NW_FioraOnly.troy") 
 	then
	for i, vital in ipairs(self.Vitals) do
	if obj == vital then
	table.remove(self.Vitals, i)
	end
	end
	end
	end
	if obj and obj.valid and obj.team == myHero.team and obj.name == "ThreshLantern" then
	self.HasLantern = nil
	end
end

function Fiora:Animation(unit, animation)
	if unit and animation and unit.isMe  then
	if animation:lower():find("attack") and animation ~= "Spell1_attack" and myHero:CanUseSpell(_E) == READY then
	if self:Keys() == "Combo" and Menu.E.E or self:Keys() == "Laneclear" and Menu.E.El then 
	DelayAction(function() self:ResetAA() CastSpell(_E) end, unit.spell.windUpTime + GetLatency() / 2000) 
	end
	end
	end
	if unit and animation and unit.team ~= myHero.team and unit.type == myHero.type and animation == "Death" and GetDistance(unit) <= 1000 then
	if Menu.Emote.On then
	DelayAction(function() 
	if VIP_USER and Menu.Emote.E == 5 then self:DoMastery() return end
	DoEmote(Menu.Emote.E-1)
	end, 0.1)
	end
	end
end

function Fiora:ProcessSpell(unit, spell)	   
	if unit and spell and unit.team ~= myHero.team then
	if spell.target and spell.target.isMe then
	self:CastW(Target) 
	end
	end
end

function Fiora:DoMastery()
 	if (string.find(GetGameVersion(), 'Releases/6.6') ~= nil) then
  	local p = CLoLPacket(0x0027)
  	p.vTable = 0xEA7E78
  	p:EncodeF(myHero.networkID)
  	p:Encode4(0xF8)
  	SendPacket(p)
  	end
end

function Fiora:ResetAA()
  	if LoadedOrb == "Sac" and TIMETOSACLOAD then
  	_G.AutoCarry.Orbwalker:ResetAttackTimer()
  	elseif LoadedOrb == "Mma" then
  	_G.MMA_ResetAutoAttack()
  	elseif LoadedOrb == "Pewalk" then
  
  	elseif LoadedOrb == "Now" then
  	_G.NebelwolfisOrbWalker:ResetAA()
  	elseif LoadedOrb == "Big" then
  
  	elseif LoadedOrb == "Sow" then
  	_G.SOWi:resetAA()
  	elseif LoadedOrb == "SxOrbWalk" then
  	_G.SxOrb:ResetAA()
  	elseif LoadedOrb == "S1mpleOrbWalker" then
  	_G.S1mpleOrbWalker:ResetAA()
  	end
end

function Fiora:CustomTarget()
	if not Menu.Target.On then
	return ts.target
	end
	if self.SelectedTarget == nil then
	return ts.target
	elseif self.SelectedTarget ~= nil and ValidTarget(self.SelectedTarget, 750) then
	return self.SelectedTarget
	else
	return ts.target
	end
end

function Fiora:WndMsg(msg, key)
	if msg == WM_LBUTTONDOWN and Menu.Target.On and not myHero.dead then
		for i, enemy in ipairs(GetEnemyHeroes()) do
        	if GetDistance(enemy, mousePos) <= 115 and ValidTarget(enemy) and enemy.type == "AIHeroClient" then
        		if self.SelectedTarget ~= enemy then
        			self.SelectedTarget = enemy
        			self:SendMsg("Selected Target: "..enemy.charName)
        			else
        			self.SelectedTarget = nil 
        			self:SendMsg("Unselected Target: "..enemy.charName)
        		end
			end
		end
	end
end

function Fiora:Tick()
	if myHero.dead then return end
	ts:update()
	Target = self:CustomTarget()
	self:Combo(Target)
end

function Fiora:TickLantern()
	if myHero.dead then return end
	if os.clock() - self.LastP >= 0.50 then
	if self.HasLantern and self.HasLantern.valid and Menu.Lantern.Auto ~= 0 and ((myHero.health * 100 ) / myHero.maxHealth) <= Menu.Lantern.Auto and 
	GetDistance(self.HasLantern) <= Menu.Lantern.AutoR or Menu.Lantern.Grab and self.HasLantern and self.HasLantern.valid then
	self:UseLantern()
	end
	end
end

TableRef = {[0x4F] = 0x01,[0x14] = 0x02,[0x9E] = 0x03,[0x24] = 0x04,[0x50] = 0x05,[0xF6] = 0x06,[0x78] = 0x07,[0x83] = 0x08,[0x75] = 0x09,[0xC2] = 0x0A,[0xB9] = 0x0B,[0x6E] = 0x0C,[0x5B] = 0x0D,[0xC8] = 0x0E,[0xBB] = 0x0F,[0x45] = 0x10,[0xC9] = 0x11,[0xA1] = 0x12,[0x69] = 0x13,[0x5E] = 0x14,[0xA6] = 0x15,[0x82] = 0x16,[0x9D] = 0x17,[0x17] = 0x18,[0x09] = 0x19,[0x65] = 0x1A,[0x55] = 0x1B,[0xFD] = 0x1C,[0xDC] = 0x1D,[0x27] = 0x1E,[0xB2] = 0x1F,[0x36] = 0x20,[0x28] = 0x21,[0x71] = 0x22,[0x19] = 0x23,[0xB0] = 0x24,[0x8E] = 0x25,[0x67] = 0x26,[0x53] = 0x27,[0x47] = 0x28,[0x1C] = 0x29,[0xF5] = 0x2A,[0xE4] = 0x2B,[0x90] = 0x2C,[0xB7] = 0x2D,[0xFB] = 0x2E,[0x3A] = 0x2F,[0x85] = 0x30,[0x66] = 0x31,[0x8F] = 0x32,[0xF4] = 0x33,[0x6C] = 0x34,[0x20] = 0x35,[0xCD] = 0x37,[0xD3] = 0x38,[0xB6] = 0x39,[0xC3] = 0x3A,[0xF3] = 0x3B,[0x2B] = 0x3C,[0x8A] = 0x3D,[0xB3] = 0x3E,[0xE0] = 0x3F,[0x60] = 0x40,[0xA8] = 0x41,[0x37] = 0x42,[0x1E] = 0x43,[0xBE] = 0x44,[0x5F] = 0x45,[0x29] = 0x46,[0x74] = 0x47,[0x1B] = 0x48,[0xE9] = 0x49,[0xB8] = 0x4A,[0xC0] = 0x4B,[0xF2] = 0x4C,[0x3D] = 0x4D,[0x61] = 0x4E,[0xFA] = 0x4F,[0x35] = 0x50,[0x4C] = 0x51,[0xEF] = 0x52,[0x2A] = 0x53,[0x3B] = 0x54,[0xFC] = 0x55,[0x04] = 0x56,[0x16] = 0x57,[0xA7] = 0x58,[0x32] = 0x59,[0x80] = 0x5A,[0x70] = 0x5B,[0xAA] = 0x5C,[0xD4] = 0x5D,[0x98] = 0x5E,[0xB4] = 0x5F,[0xD2] = 0x60,[0xAC] = 0x61,[0xEC] = 0x62,[0x64] = 0x63,[0xE2] = 0x64,[0xD6] = 0x65,[0x15] = 0x66,[0xA2] = 0x67,[0xFF] = 0x68,[0x1D] = 0x69,[0x48] = 0x6A,[0x97] = 0x6B,[0x33] = 0x6C,[0x41] = 0x6D,[0x9C] = 0x6E,[0x58] = 0x6F,[0x62] = 0x70,[0x2C] = 0x71,[0x0E] = 0x72,[0xD7] = 0x73,[0x46] = 0x74,[0xA4] = 0x75,[0xCA] = 0x76,[0xE7] = 0x77,[0x7C] = 0x78,[0x30] = 0x79,[0x1A] = 0x7A,[0x12] = 0x7B,[0xD5] = 0x7C,[0x91] = 0x7D,[0x68] = 0x7E,[0x3C] = 0x7F,[0x9B] = 0x80,[0xF1] = 0x81,[0x08] = 0x82,[0x10] = 0x83,[0x6A] = 0x84,[0x52] = 0x85,[0xD0] = 0x86,[0x39] = 0x87,[0x4D] = 0x88,[0xBF] = 0x89,[0x73] = 0x8A,[0xC6] = 0x8B,[0xE3] = 0x8C,[0x06] = 0x8D,[0x49] = 0x8E,[0x18] = 0x8F,[0xEB] = 0x90,[0x1F] = 0x91,[0x38] = 0x92,[0xDA] = 0x93,[0x3F] = 0x94,[0xDD] = 0x95,[0x84] = 0x96,[0x44] = 0x97,[0xBD] = 0x98,[0x94] = 0x99,[0x0A] = 0x9A,[0x9A] = 0x9B,[0x31] = 0x9C,[0x81] = 0x9D,[0x34] = 0x9E,[0xF9] = 0x9F,[0x4E] = 0xA0,[0xBA] = 0xA1,[0x13] = 0xA2,[0xAF] = 0xA3,[0x7D] = 0xA4,[0x76] = 0xA5,[0x89] = 0xA6,[0x5A] = 0xA7,[0x3E] = 0xA8,[0x26] = 0xA9,[0xBC] = 0xAA,[0x77] = 0xAB,[0x0D] = 0xAC,[0x79] = 0xAD,[0x86] = 0xAE,[0x8B] = 0xAF,[0xC7] = 0xB0,[0x92] = 0xB1,[0x72] = 0xB2,[0x22] = 0xB3,[0x2F] = 0xB4,[0x59] = 0xB5,[0xE1] = 0xB6,[0xFE] = 0xB7,[0x88] = 0xB8,[0x8C] = 0xB9,[0xD8] = 0xBA,[0xB1] = 0xBB,[0x21] = 0xBC,[0xC5] = 0xBD,[0x51] = 0xBE,[0xC1] = 0xBF,[0xD1] = 0xC0,[0xEA] = 0xC1,[0xA5] = 0xC2,[0xA3] = 0xC3,[0x87] = 0xC4,[0x93] = 0xC5,[0x9F] = 0xC6,[0x54] = 0xC7,[0xEE] = 0xC8,[0x99] = 0xC9,[0x01] = 0xCA,[0x40] = 0xCB,[0x6D] = 0xCC,[0x96] = 0xCD,[0x23] = 0xCE,[0xC4] = 0xCF,[0xDF] = 0xD0,[0xA0] = 0xD1,[0xCB] = 0xD2,[0xCF] = 0xD3,[0xCC] = 0xD4,[0xE6] = 0xD5,[0xF7] = 0xD6,[0x00] = 0xD7,[0xDB] = 0xD8,[0x7B] = 0xD9,[0x5D] = 0xDA,[0x7A] = 0xDB,[0x0C] = 0xDC,[0xE5] = 0xDD,[0xCE] = 0xDE,[0xE8] = 0xDF,[0x0B] = 0xE0,[0xAD] = 0xE1,[0x6F] = 0xE2,[0x43] = 0xE3,[0x2E] = 0xE4,[0x8D] = 0xE5,[0x5C] = 0xE6,[0xB5] = 0xE7,[0x7E] = 0xE8,[0x4B] = 0xE9,[0xAE] = 0xEA,[0x25] = 0xEB,[0x57] = 0xEC,[0x03] = 0xED,[0xAB] = 0xEE,[0x6B] = 0xEF,[0xF0] = 0xF0,[0x56] = 0xF1,[0xDE] = 0xF2,[0x11] = 0xF3,[0xED] = 0xF4,[0x7F] = 0xF5,[0x42] = 0xF6,[0xD9] = 0xF7,[0x2D] = 0xF8,[0x0F] = 0xF9,[0x95] = 0xFA,[0x02] = 0xFB,[0x05] = 0xFC,[0xA9] = 0xFD,[0x07] = 0xFE,[0x63] = 0xFF,[0xF8] = 0x00,}

TableRef2 = {[0x01] = 0xCA,[0x02] = 0xFB,[0x03] = 0xED,[0x04] = 0x56,[0x05] = 0xFC,[0x06] = 0x8D,[0x07] = 0xFE,[0x08] = 0x82,[0x09] = 0x19,[0x0A] = 0x9A,[0x0B] = 0xE0,[0x0C] = 0xDC,[0x0D] = 0xAC,[0x0E] = 0x72,[0x0F] = 0xF9,[0x10] = 0x83,[0x11] = 0xF3,[0x12] = 0x7B,[0x13] = 0xA2,[0x14] = 0x02,[0x15] = 0x66,[0x16] = 0x57,[0x17] = 0x18,[0x18] = 0x8F,[0x19] = 0x23,[0x1A] = 0x7A,[0x1B] = 0x48,[0x1C] = 0x29,[0x1D] = 0x69,[0x1E] = 0x43,[0x1F] = 0x91,[0x20] = 0x35,[0x21] = 0xBC,[0x22] = 0xB3,[0x23] = 0xCE,[0x24] = 0x04,[0x25] = 0xEB,[0x26] = 0xA9,[0x27] = 0x1E,[0x28] = 0x21,[0x29] = 0x46,[0x2A] = 0x53,[0x2B] = 0x3C,[0x2C] = 0x71,[0x2D] = 0xF8,[0x2E] = 0xE4,[0x2F] = 0xB4,[0x30] = 0x79,[0x31] = 0x9C,[0x32] = 0x59,[0x33] = 0x6C,[0x34] = 0x9E,[0x35] = 0x50,[0x36] = 0x20,[0x37] = 0x42,[0x38] = 0x92,[0x39] = 0x87,[0x3A] = 0x2F,[0x3B] = 0x54,[0x3C] = 0x7F,[0x3D] = 0x4D,[0x3E] = 0xA8,[0x3F] = 0x94,[0x40] = 0xCB,[0x41] = 0x6D,[0x42] = 0xF6,[0x43] = 0xE3,[0x44] = 0x97,[0x45] = 0x10,[0x46] = 0x74,[0x47] = 0x28,[0x48] = 0x6A,[0x49] = 0x8E,[0x4A] = 0x36,[0x4B] = 0xE9,[0x4C] = 0x51,[0x4D] = 0x88,[0x4E] = 0xA0,[0x4F] = 0x01,[0x50] = 0x05,[0x51] = 0xBE,[0x52] = 0x85,[0x53] = 0x27,[0x54] = 0xC7,[0x55] = 0x1B,[0x56] = 0xF1,[0x57] = 0xEC,[0x58] = 0x6F,[0x59] = 0xB5,[0x5A] = 0xA7,[0x5B] = 0x0D,[0x5C] = 0xE6,[0x5D] = 0xDA,[0x5E] = 0x14,[0x5F] = 0x45,[0x60] = 0x40,[0x61] = 0x4E,[0x62] = 0x70,[0x63] = 0xFF,[0x64] = 0x63,[0x65] = 0x1A,[0x66] = 0x31,[0x67] = 0x26,[0x68] = 0x7E,[0x69] = 0x13,[0x6A] = 0x84,[0x6B] = 0xEF,[0x6C] = 0x34,[0x6D] = 0xCC,[0x6E] = 0x0C,[0x6F] = 0xE2,[0x70] = 0x5B,[0x71] = 0x22,[0x72] = 0xB2,[0x73] = 0x8A,[0x74] = 0x47,[0x75] = 0x09,[0x76] = 0xA5,[0x77] = 0xAB,[0x78] = 0x07,[0x79] = 0xAD,[0x7A] = 0xDB,[0x7B] = 0xD9,[0x7C] = 0x78,[0x7D] = 0xA4,[0x7E] = 0xE8,[0x7F] = 0xF5,[0x80] = 0x5A,[0x81] = 0x9D,[0x82] = 0x16,[0x83] = 0x08,[0x84] = 0x96,[0x85] = 0x30,[0x86] = 0xAE,[0x87] = 0xC4,[0x88] = 0xB8,[0x89] = 0xA6,[0x8A] = 0x3D,[0x8B] = 0xAF,[0x8C] = 0xB9,[0x8D] = 0xE5,[0x8E] = 0x25,[0x8F] = 0x32,[0x90] = 0x2C,[0x91] = 0x7D,[0x92] = 0xB1,[0x93] = 0xC5,[0x94] = 0x99,[0x95] = 0xFA,[0x96] = 0xCD,[0x97] = 0x6B,[0x98] = 0x5E,[0x99] = 0xC9,[0x9A] = 0x9B,[0x9B] = 0x80,[0x9C] = 0x6E,[0x9D] = 0x17,[0x9E] = 0x03,[0x9F] = 0xC6,[0xA0] = 0xD1,[0xA1] = 0x12,[0xA2] = 0x67,[0xA3] = 0xC3,[0xA4] = 0x75,[0xA5] = 0xC2,[0xA6] = 0x15,[0xA7] = 0x58,[0xA8] = 0x41,[0xA9] = 0xFD,[0xAA] = 0x5C,[0xAB] = 0xEE,[0xAC] = 0x61,[0xAD] = 0xE1,[0xAE] = 0xEA,[0xAF] = 0xA3,[0xB0] = 0x24,[0xB1] = 0xBB,[0xB2] = 0x1F,[0xB3] = 0x3E,[0xB4] = 0x5F,[0xB5] = 0xE7,[0xB6] = 0x39,[0xB7] = 0x2D,[0xB8] = 0x4A,[0xB9] = 0x0B,[0xBA] = 0xA1,[0xBB] = 0x0F,[0xBC] = 0xAA,[0xBD] = 0x98,[0xBE] = 0x44,[0xBF] = 0x89,[0xC0] = 0x4B,[0xC1] = 0xBF,[0xC2] = 0x0A,[0xC3] = 0x3A,[0xC4] = 0xCF,[0xC5] = 0xBD,[0xC6] = 0x8B,[0xC7] = 0xB0,[0xC8] = 0x0E,[0xC9] = 0x11,[0xCA] = 0x76,[0xCB] = 0xD2,[0xCC] = 0xD4,[0xCD] = 0x37,[0xCE] = 0xDE,[0xCF] = 0xD3,[0xD0] = 0x86,[0xD1] = 0xC0,[0xD2] = 0x60,[0xD3] = 0x38,[0xD4] = 0x5D,[0xD5] = 0x7C,[0xD6] = 0x65,[0xD7] = 0x73,[0xD8] = 0xBA,[0xD9] = 0xF7,[0xDA] = 0x93,[0xDB] = 0xD8,[0xDC] = 0x1D,[0xDD] = 0x95,[0xDE] = 0xF2,[0xDF] = 0xD0,[0xE0] = 0x3F,[0xE1] = 0xB6,[0xE2] = 0x64,[0xE3] = 0x8C,[0xE4] = 0x2B,[0xE5] = 0xDD,[0xE6] = 0xD5,[0xE7] = 0x77,[0xE8] = 0xDF,[0xE9] = 0x49,[0xEA] = 0xC1,[0xEB] = 0x90,[0xEC] = 0x62,[0xED] = 0xF4,[0xEE] = 0xC8,[0xEF] = 0x52,[0xF0] = 0xF0,[0xF1] = 0x81,[0xF2] = 0x4C,[0xF3] = 0x3B,[0xF4] = 0x33,[0xF5] = 0x2A,[0xF6] = 0x06,[0xF7] = 0xD6,[0xF8] = 0x00,[0xF9] = 0x9F,[0xFA] = 0x4F,[0xFB] = 0x2E,[0xFC] = 0x55,[0xFD] = 0x1C,[0xFE] = 0xB7,[0xFF] = 0x68,[0x00] = 0xD7,}

function Fiora:UseLantern()
 	if (string.find(GetGameVersion(),'Releases/6.6') ~= nil) then
	self.LastP = os.clock()
	p = CLoLPacket(0x001E)
	p.vTable = 0xEA7E78
	p:EncodeF(myHero.networkID)
	local aFake = CLoLPacket(0x0001)
	aFake:EncodeF(self.HasLantern.networkID)
	aFake.pos = 2
	local bytes = {}
	for i = 1, 4 do
	bytes[i]=TableRef[aFake:Decode1()]
	end
	for i = 1, 4 do p:Encode1(bytes[i]) end
	SendPacket(p)
	end
end

-- Credits to RalphLol
function Fiora:RecvPacket(p)
	if p.header == 0x0263 and Menu.Recall.On then
	local lshift, rshift, band, bxor = bit32.lshift, bit32.rshift, bit32.band, bit32.bxor
	p.pos = 55
	local bytes = {}
	for i=4, 1, -1 do
	bytes[i] = TableRef2[p:Decode1()]
	end
	local netID = bxor(lshift(band(bytes[1],0xFF),24),lshift(band(bytes[2],0xFF),16),lshift(band(bytes[3],0xFF),8),band(bytes[4],0xFF))
	local o = objManager:GetObjectByNetworkId(DwordToFloat(netID))
	if o and o.valid and o.type == 'AIHeroClient' and o.team == TEAM_ENEMY then
	p.pos = 31
	local str = ''
	for i=1, p.size do
	local char = p:Decode1()
	if char == 0 then break end
	str=str..string.char(char)
	end
	if self.recallTimes[str:lower()] then
	local r = {}
	r.unit = o
	r.name = o.charName
	r.startT = os.clock()
	r.duration = self.recallTimes[str:lower()]
	r.endT = r.startT + r.duration
	if Menu.Recall.PrintR then
	self:SendMsg(r.name..": Recalling")
	end
	self.Recalling[o.networkID] = r
	return
	elseif self.Recalling[o.networkID] then
	if self.Recalling[o.networkID] and self.Recalling[o.networkID].endT > os.clock() then
	self:SendMsg(self.Recalling[o.networkID].name..": Cancel Recall")
	self.Recalling[o.networkID] = nil
	return
	else
	if Menu.Recall.PrintF then
	self:SendMsg(self.Recalling[o.networkID].name..": Finish Recall")
	end
	self.Recalling[o.networkID] = nil
	return
	end
	end
	end
	end
end

function Fiora:Draw()
	if Menu.Draw.DrawC and not myHero.dead then
		self:DrawCircleAround()
	end 
	if VIP_USER and Menu.Recall.DrawB then
		for i, enemy in ipairs(GetEnemyHeroes()) do
			if self.Recalling[enemy.networkID] ~= nil and enemy.valid then
				recall = (self.Recalling[enemy.networkID])
				local w = WINDOW_W
				local h = WINDOW_H+60
				local m = w/3-w/2
				local percentage = ((recall.endT-os.clock())/recall.duration)*1
				DrawLineBorder(w/3, h/1.25-20*i+20, w/2, h/1.25-20*i+20, 18, ARGB(255,255,175,255), 1.5)
				DrawLine(w/3, h/1.25-20*i+20, w/2+m*percentage, h/1.25-20*i+20, 18, ARGB(128,150,120,255))
				DrawTextA(enemy.charName.." ("..math.round(enemy.health/(enemy.maxHealth/100), 0).."%)".." is Recalling.",16,w/2.8-25,h/1.262-20*i+20)
				DrawTextA(math.round(recall.endT-os.clock(), 1),16,w/2.1+15,h/1.262-20*i+20)
			end
		end
	end
	if Menu.Draw.DrawV and ValidTarget(Target) and not myHero.dead then
		for i, vital in ipairs(self.Vitals) do
			if GetDistance(vital, Target) <= 20 and vital.valid then
			if vital.name:find("NE") then self:DrawCircleVital(vital.x, vital.y, vital.z+150, 0xff00ffff)
			elseif vital.name:find("SW") then self:DrawCircleVital(vital.x, vital.y, vital.z-150, 0xff00ffff)
			elseif vital.name:find("SE") then self:DrawCircleVital(vital.x-150, vital.y, vital.z, 0xff00ffff)
			elseif vital.name:find("NW") then self:DrawCircleVital(vital.x+150, vital.y, vital.z, 0xff00ffff)
			end
			end
		end
	end
	if Menu.Draw.DrawL then
		if ValidTarget(Target) and not myHero.dead and Target.type == "AIHeroClient" then
			DrawLine3D(Target.x, Target.y, Target.z, myHero.x, myHero.y, myHero.z, 4, ARGB(255, GetDistance(Target), 50, 50))
		end
	end
end

DrawCRTick = 130
DrawCR2Tick = 50
DrawCTick = 0
DrawC2Tick = 0

function Fiora:DrawCircleAround() 
	if myHero.dead then return end
	if os.clock()-DrawCTick >= 0.05 then DrawCRTick = DrawCRTick-5 DrawCTick = os.clock() end
	if DrawCRTick == 5 then DrawCRTick = 130 end
	DrawCircle(myHero.x, myHero.y, myHero.z, DrawCRTick, 0xff00ffff)
end 

function Fiora:DrawCircleVital(pos1, pos2, pos3, color) 
	if myHero.dead then return end
	if os.clock()-DrawC2Tick >= 0.05 then DrawCR2Tick = DrawCR2Tick-5 DrawC2Tick = os.clock() end
	if DrawCR2Tick == 5 then DrawCR2Tick = 50 end
	DrawCircle(pos1, pos2, pos3, DrawCR2Tick, color)
end 

function Fiora:Combo(target)
	if self:Keys() == "Combo" and ValidTarget(target) then
	if Menu.Q.Q then
	for i, vital in ipairs(self.Vitals) do
	self:Cast(_Q, vital)
	end
	end
	if Menu.R.R and myHero:CanUseSpell(_R) == READY then
	if Menu.R.RE ~= 0 and CountEnemyHeroInRange(600) >= Menu.R.RE then
	CastSpell(_R, target)
	end
	end
	end
end

function Fiora:Cast(spell, obj)
	if spell == _Q and obj then
	if myHero:CanUseSpell(_Q) == READY and GetDistance(obj) <= 400 and GetDistance(obj, Target) <= 20 then
	if obj.name:find("NE") then CastSpell(_Q, obj.x, obj.z+200)
	elseif obj.name:find("SW") then CastSpell(_Q, obj.x, obj.z-200)
	elseif obj.name:find("SE") then CastSpell(_Q, obj.x-200, obj.z) 
	elseif obj.name:find("NW") then CastSpell(_Q, obj.x+200, obj.z) end
	end
	end
end

function Fiora:CastW(target)
	if ValidTarget(target) and myHero:CanUseSpell(_W) == READY and GetDistance(target) <= 765 and Menu.Riposte.W then
	CastSpell(_W, target.x, target.z)
	end
end

function Fiora:CheckUpdates()
	host = "www.scarjit.de"
	file = "/HiranN/BoL/Scripts/Fiora.lua"
	name = GetCurrentEnv().FILE_NAME
	versionfilepath = "/HiranN/BoL/Versions/Fiora.version"
	path = SCRIPT_PATH
	DL = Download()
	DL:downloadUpdate(host, file, name, path, function ()
	self:SendMsg("Downloaded update, press F9 2x to reload")
	end, self.Version, versionfilepath)
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
	local c = {}
	for k, v in pairs(self.aktivedownloads) do
		if math.round(v.progress) < 100 then
			v.offset = k*40-40
			x[#x+1] = v
			c[#c+1] = self.callbacks[k]
		else
			self.callbacks[k]()
			self.callbacks[k] = function ()
				
			end
		end
	end
	self.callbacks = {}
	self.callbacks = c
	self.aktivedownloads = {}
	self.aktivedownloads = x
end

function Download:downloadUpdate(host, file, name, path, _callback,version, versionfilepath)
	function HasUpdate(name,cb)
		function _cb()
			cb()
			DeleteFile(name..".version")
		end
		DelayAction(function ()
			local v = ReadFile(name..".version")
			if v and tonumber(v) > tonumber(version) then
					self:newDL(host, file, name, path, cb)
			end
		end,0.25)
	end
	self:newDL(host,versionfilepath,name..".version",path,function ()
		HasUpdate(name,_callback)
	end)

end

if myHero.charName ~= "Fiora" then return end
function OnLoad() Fiora() end

assert(load(Base64Decode("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"), nil, "bt", _ENV))()
TrackerLoad("IvxWfs8vho0JJjfk")

-- Extra line.