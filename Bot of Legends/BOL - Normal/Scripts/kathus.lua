Karthus = {
		[_Q] = { name = "KarthusLayWaste", speed = math.huge, delay = 0.65, range = 875, width = 190*2, collision = false, aoe = false, type = "circular", dmgAP = function(source, target) local m=minionManager(MINION_JUNGLE, 190, target, MINION_SORT_HEALTH_ASC); return (#m.objects == 0 and 2 or 1) * (20+20*source:GetSpellData(_Q).level+0.3*source.ap) end},
		[_W] = { name = "KarthusWallOfPain", speed = math.huge, delay = 0.25, range = 1000, width = 160, collision = false, aoe = true, type = "circular"},
		[_E] = { name = "KarthusDefile", speed = math.huge, delay = 0.25, range = 550, width = 550, collision = false, aoe = true, type = "circular", dmgAP = function(source, target) return 10+20*source:GetSpellData(_Q).level+0.2*source.ap end},
		[_R] = { name = "KarthusFallenOne", range = math.huge, dmgAP = function(source, target) return 100+150*source:GetSpellData(_Q).level+0.60*source.ap end}
	}
function OnLoad()
	require("UPL")
	UPL = UPL()
	UPL:AddSpell(_Q,{speed = Karthus[_Q].speed, delay = Karthus[_Q].delay, range = Karthus[_Q].range, width = Karthus[_Q].width, collision = Karthus[_Q].collision, aoe = Karthus[_Q].aoe, type = Karthus[_Q].type})
    UPL:AddSpell(_W,{speed = Karthus[_W].speed, delay = Karthus[_W].delay, range = Karthus[_W].range, width = Karthus[_W].width, collision = Karthus[_W].collision, aoe = Karthus[_W].aoe, type = Karthus[_W].type})
    OrbWalker=OrbWalker()
    Menu()
    ts = TargetSelector(TARGET_LESS_CAST,1000, DAMAGE_MAGIC)
    enemyMinions = minionManager(MINION_ENEMY,875, player, MINION_SORT_HEALTH_ASC)
end

function OnTick()
	ts:update()
	enemyMinions:update()
	IsKarthusE()
	Laneclear()
	Harras()
	Combo()
end

function IsKarthusE()
	local ke = false
	for i = 1, objManager.maxObjects do
    local object = objManager:GetObject(i)
		if object and object.valid and GetDistance(object) < 50 and object.name == "Karthus_Base_E_Defile.troy" then
			ke = true
		end
	end
	KarthusE = ke
end

function Laneclear()
	if OrbWalker:GetMode() ~= 2 then return end
	if menu.ls.q then
		for _,minion in pairs(enemyMinions.objects) do
			if ValidTarget(minion, 875) then
				CastPosition, HitChance = UPL:Predict(_Q, myHero, minion)
				if CastPosition and HitChance > 0 then
					CastSpell(_Q,CastPosition.x,CastPosition.z)
				end
			end
		end
	end

	if menu.ls.e then
		local n = 0
		for _,minion in pairs(enemyMinions.objects) do
			if ValidTarget(minion, 550) then
				n = n+1
			end
		end
		if n > 3 and not KarthusE then
			CastSpell(_E)
		elseif KarthusE and n < 1 then
			CastSpell(_E)
		end
	end
end

function Harras()
	if OrbWalker:GetMode() ~= 1 then return end
	if menu.hs.q then
		if ValidTarget(ts.target, 875) then
			CastPosition, HitChance = UPL:Predict(_Q, myHero, ts.target)
			if CastPosition and HitChance > 0 then
				CastSpell(_Q,CastPosition.x,CastPosition.z)
			end
		end
	end
end

function Combo()
	if OrbWalker:GetMode() ~= 4 then return end
	if menu.c.q then
		if ValidTarget(ts.target, 875) then
			CastPosition, HitChance = UPL:Predict(_Q, myHero, ts.target)
			if CastPosition and HitChance > 0 then
				CastSpell(_Q,CastPosition.x,CastPosition.z)
			end
		end
	end
	
	if menu.c.w then
		if ValidTarget(ts.target, 1000) then
			CastPosition, HitChance = UPL:Predict(_W, myHero, ts.target)
			if CastPosition and HitChance > 0 then
				CastSpell(_W,CastPosition.x,CastPosition.z)
			end
		end
	end
	
	if menu.c.e then
		if ValidTarget(ts.target, 550) and not KarthusE then
			CastSpell(_E)
		elseif KarthusE and not ValidTarget(ts.target, 550) then
			CastSpell(_E)
		end
	end
end

function Menu()
	menu = scriptConfig("Felix_karthus", "Felix_karthus")
	menu:addSubMenu("Laneclear Settings", "ls")
		menu.ls:addParam("q", "Use Q", SCRIPT_PARAM_ONOFF, true)
		menu.ls:addParam("e", "Use E", SCRIPT_PARAM_ONOFF, false)

	menu:addSubMenu("Harras Settings", "hs")
		menu.hs:addParam("q", "Use Q", SCRIPT_PARAM_ONOFF, true)

	menu:addSubMenu("Combo Mode", "c")
		menu.c:addParam("q", "Use Q", SCRIPT_PARAM_ONOFF, true)
		menu.c:addParam("w", "Use W", SCRIPT_PARAM_ONOFF, true)
		menu.c:addParam("e", "Use E", SCRIPT_PARAM_ONOFF, true)

	UPL:AddToMenu(menu)
end

class("OrbWalker")
function OrbWalker:__init()
	self.LoadedOrbWalker = nil

	DelayAction(function ()
		self:GetLoadedOrbWalker() --Give the OrbWalker some time to load
	end,1.25)
end

function OrbWalker:GetLoadedOrbWalker()
	if _G.S1OrbLoading or _G.S1mpleOrbLoaded then self.LoadedOrbWalker = "S1Orb" end
	if _G.Reborn_Loaded or _G.AutoCarry then self.LoadedOrbWalker = "SAC:R" end
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
				S1:AddToMenu(menu)
			end,0.25)
			print("Loading S1mpleOrbWalker")
		else
			menu:addSubMenu("Keys", "keys")
				menu.keys:addParam("harass", "Harass Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
				menu.keys:addParam("combo", "Combo Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte(" "))
				menu.keys:addParam("laneclear", "Laneclear Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
				menu.keys:addParam("lasthit", "Lasthit Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("X"))
		end
	end
	if self.LoadedOrbWalker then
		menu:addSubMenu("Keys", "keys")
			menu.keys:addParam("inf", "Keys are connected to your OrbWalker Keys", SCRIPT_PARAM_INFO, "")
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
		if not menu.keys then return 0 end
		if menu.keys.harass then return 1 end
		if menu.keys.laneclear then return 2 end
		if menu.keys.lasthit then return 3 end
		if menu.keys.combo then return 4 end
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
