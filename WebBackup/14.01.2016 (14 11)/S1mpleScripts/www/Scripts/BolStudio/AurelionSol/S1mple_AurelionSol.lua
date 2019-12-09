if myHero.charName ~= "AurelionSol" then return end


--Localize it
local clock, tostring, random, huge, round, floor, pairs, GetDistance = os.clock, tostring, math.random, math.huge, math.round, math.floor, pairs, GetDistance

-- http://bol-tools.com/ tracker
assert(load(Base64Decode("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"), nil, "bt", _ENV))()
TrackerLoad("qFuKVIY8Jsd1AJUO")


--Auto Updater Settings
local AutoUpdate = true
local Version = 0.04

-- Made by Nebelwolfi. Makes Classes Local, Not Global -- 
function Class(name)
	_ENV[name] = { }
	_ENV[name].__index = _ENV[name]
	local mt = { __call = function(self, ...) local b = { } setmetatable(b, _ENV[name]) b:__init(...) return b end }
	setmetatable(_ENV[name], mt)
end

Class("OrbWalker")
Class("Prediction")
Class("Spell")
Class("TargetSelector")
Class("Sol")

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
				menu:addSubMenu("S1OrbWalker", "OrbWalker")
				S1:AddToMenu(menu.OrbWalker)
			end,0.25)
			printC("Loading S1mpleOrbWalker")
		else
			menu:addSubMenu("keys", "keys")
				menu.keys:addParam("harass", "Harass Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
				menu.keys:addParam("combo", "Combo Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte(" "))
				menu.keys:addParam("laneclear", "Laneclear Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
				menu.keys:addParam("lasthit", "Lasthit Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("X"))
		end
	end
	if self.LoadedOrbWalker and not self.LoadedOrbWalker == "S1Orb" then
		menu:addSubMenu("Keys", "keys")
			menu.keys:addParam("inf", "Keys are connected to your OrbWalker Keys", SCRIPT_PARAM_INFO, "")
	end
	if menu.adv.debug then
		printC("OrbWalker Submodule loaded: "..tostring(self.LoadedOrbWalker))
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

function Prediction:__init()
	require("UPL")
	UPL = UPL()

	
	self:SetupSpells()
	self:SetupMenu()
	if menu.adv.debug then
		printC("Prediction Submodule loaded")
	end
end

function Prediction:SetupSpells()
	self.Q = { name = "AurelionSolQ", speed = 600, delay = 0.25, range = 650, width = 130, collision = false, aoe = true, type = "circular"}
	self.R = { name = "AurelionSolR", speed = huge, delay = 0.5, range = 1300, width = 150, collision = false, aoe = true, type = "linear"}

	SpellQ = Spell(_Q, self.Q.speed, self.Q.delay, self.Q.range, self.Q.width, self.Q.collision, self.Q.aoe, self.Q.type)
	SpellR = Spell(_R, self.R.speed, self.R.delay, self.R.range, self.R.width, self.R.collision, self.R.aoe, self.R.type)
end

function Prediction:SetupMenu()
	UPL:AddToMenu(menu)
end

function Spell:__init(slot, speed, delay, range, width, collision, aoe, type)
	self.slot = slot
	self.speed = speed
	self.delay = delay
	self.range = range
	self.width = width
	self.collision = collision
	self.aoe = aoe
	self.type = type
	if self.type ~= nil then
		UPL:AddSpell(self.slot, {speed = self.speed, delay = self.delay, range = self.range, width = self.width, collision = self.collision, aoe = self.aoe, type = self.type})
	end
end

function Spell:Cast(target, pos, force)
	if not target and not pos then return end
	if target and not ValidTarget(target) then return end
	if self.type == nil and target and ValidTarget(target) then
		DelayAction(function ()
			CastSpell(self.slot, target)
		end,random(0.1,0.25))
	elseif target then
		if target.type ~= myHero.type then
			DelayAction(function ()
				CastSpell(self.slot, target.x,target.z)
			end,random(0.1,0.25))
		else
			local CastPosition, HitChance, HeroPosition = UPL:Predict(self.slot, myHero, target)
			if CastPosition and HitChance >= 0 then --Returns 0 if higher then in Nebel's Menu
				DelayAction(function ()
					if CastPosition then
						CastSpell(self.slot, CastPosition.x, CastPosition.z)
					end
				end,random(0.1,0.25))
			end
		end
	elseif pos then
		DelayAction(function ()
			CastSpell(self.slot, pos.x, pos.z)
		end,random(0.1,0.25))
	end
end

function Spell:IsReady()
	return (myHero:CanUseSpell(self.slot) == 0)
end

function TargetSelector:__init()

	self.enemyHeroes = GetEnemyHeroes()

	self.Minions = {}
	self.JungleMinions = {}

	--On Reload
	for i = 1, objManager.maxObjects do
		local object = objManager:getObject(i)
		if object and object.valid and object.type and object.type == "obj_AI_Minion" and object.team ~= myHero.team then
			if object.charName:find("Minion") then
				--self.Minions[#self.Minions+1] = object
				self.Minions[object.networkID] = object
			else
				--self.JungleMinions[#self.JungleMinions+1] = object
				self.JungleMinions[object.networkID] = object
			end
		end
	end


	AddCreateObjCallback(function (object)
		if object and object.valid and object.type and object.type == "obj_AI_Minion" and object.team ~= myHero.team then
			if object.charName:find("Minion") then
				--self.Minions[#self.Minions+1] = object
				self.Minions[object.networkID] = object
			else
				--self.JungleMinions[#self.JungleMinions+1] = object
				self.JungleMinions[object.networkID] = object
			end
		end
	end)
	

	AddDeleteObjCallback(function (object)
		--[[
		local m = {}
		local j = {}
		for _, v in pairs(self.Minions) do
			if v.networkID ~= object.networkID then
				m[#m+1] = v
			end
		end
		for _, v in pairs(self.JungleMinions) do
			if v.networkID ~= object.networkID then
				j[#j+1] = v
			end
		end
		self.Minions = m
		self.JungleMinions = j
		]]--
		self.Minions[object.networkID] = nil
	end)

	if menu.adv.debug then
		printC("TargetSelector Submodule loaded")
	end
end

function TargetSelector:IsEnemyInRange(range)
	for _,v in pairs(self.enemyHeroes) do
		if v and ValidTarget(v) and GetDistance(v) < range+v.boundingRadius then
			return true
		end
	end	
end

function TargetSelector:GetEnemysInRage(range)
	local e = {}
	for _,v in pairs(self.enemyHeroes) do
		if v and ValidTarget(v) and GetDistance(v) < range+v.boundingRadius then
			e[#e+1] = v
		end
	end
	return e
end

function TargetSelector:GetEnemyHero(range)
	local t = nil
	for _, v in pairs(self.enemyHeroes) do
		if v and ValidTarget(v) and GetDistance(v) < range+v.boundingRadius then
			if t and v.health < t.health then
				t = v
			elseif not t then
				t = v
			end
		end
	end
	return t
end

function TargetSelector:GetEnemyMinion(range)
	local t = nil
	for _, v in pairs(self.Minions) do
		if v and ValidTarget(v) and GetDistance(v) < range+v.boundingRadius then
			if t and v.health < t.health then
				t = v
			elseif not t then
				t = v
			end
		end
	end
	return t
end

function TargetSelector:GetJungleMinion(range)
	local t = nil
	for _, v in pairs(self.JungleMinions) do
		if v and ValidTarget(v) and GetDistance(v) < range+v.boundingRadius then
			if t and v.health < t.health then
				t = v
			elseif not t then
				t = v
			end
		end
	end
	return t
end

function Sol:__init()

	self.PassiveLarge = false
	self.PassiveSmall = false
	self.PassiveToLarge = false
	self.PassiveToSmall = false
	self.missles = {}
	self.Q_obj = {}
	self.enemyHeroes = GetEnemyHeroes()
	self.enemyInBrush = {}

	AddDrawCallback(function ()
		self:draw()
	end)

	AddTickCallback(function ()
		self:tick()
		self:clearbush()
	end)

	AddProcessSpellCallback(function (unit, spell)
		self:OnProcessAttack(unit, spell)
	end)

	AddCreateObjCallback(function (obj)
		self:bushdetection(obj)
	end)
end

function Sol:OnProcessAttack(unit, spell)
	if unit.isMe and spell.name == "AurelionSolE" and menu.spells.q.autoqone then
		local bvec = CalcVector(spell.startPos,spell.endPos)*-500
		if SpellQ:IsReady() then
			CastSpell(_Q,myHero.x+bvec.x,myHero.y+bvec.y,myHero.z+bvec.z)
		end
	end
end

function Sol:draw()

	if myHero.dead then return end

	if menu.adv.debug then
		local n = 0
		for i = 1, objManager.maxObjects do
			local object = objManager:GetObject(i)
			if object and object.name and GetDistance(object) < 800 and GetDistance(object) > 200 then
				
				if object.name and object.name:len() > 2 then
					n = n+1
					DrawText3D(tostring(object.name),object.x,object.y,object.z,18,ARGB(255,255,255,255))
					DrawTextA(object.name.." dst: "..GetDistance(object), 18,20, 20*n)
					--print(object.name)
				end
				--DrawTextA(object.name.." dst: "..GetDistance(object), 18,20, 20*n)
			end
		end
		--DrawCircle3D(mousePos.x,mousePos.y,mousePos.z,150,1,ARGB(255,255,255,255),20)
	end


	if menu.draw.passive and self.missles and #self.missles then
		if self.PassiveSmall then
			DrawCircle3D(myHero.x, myHero.y, myHero.z, 330.025, 2, ARGB(255,255,0,0), 15)
		elseif self.PassiveLarge then
			DrawCircle3D(myHero.x, myHero.y, myHero.z, 590.04, 2, ARGB(255,255,0,0), 15)
		elseif self.PassiveToLarge then
			for _,v in pairs(self.missles) do
				if v.name == "AurelionSol_Base_P_MissileSmall_toLarge.troy" then
					DrawCircle3D(myHero.x, myHero.y, myHero.z, GetDistance(v), 2, ARGB(255,255,0,0), 15)
					break
				end
			end
		elseif self.PassiveToSmall then
			for _,v in pairs(self.missles) do
				if v.name == "AurelionSol_Base_P_MissileLarge_toSmall.troy" then
					DrawCircle3D(myHero.x, myHero.y, myHero.z, GetDistance(v), 2, ARGB(255,255,0,0), 15)
					break
				end
			end
		end
	end

	if menu.draw.missles then
		for _,v in pairs(self.missles) do
			if v.name ~= "AurelionSol_Base_P_MissileLarge.troy" then
				DrawCircle3D(v.x,v.y,v.z,50,1,ARGB(255,0,0,0),15)
			else
				DrawCircle3D(v.x,v.y,v.z,100,1,ARGB(255,0,0,0),15)
			end
		end
	end

	if menu.draw.qaoe and self.Q_obj.obj then
		local v = self.Q_obj.obj
		DrawCircle3D(v.x,v.y,v.z,130+(clock()-self.Q_obj.startT)*50, 1, ARGB(255,255,0,255),15)
	end

	if menu.draw.marker then
		for _,v in pairs(self.enemyInBrush) do
			DrawCircle3D(v.pos.x,v.pos.y,v.pos.z, 150, 4, ARGB(255,255,0,200),15)
		end
	end
	
end

function Sol:tick()

	if myHero.dead then	end

	if menu.adv.tpm and floor(clock())%2 ~= 0 then
		return
	end

	self.missles = {}
	--self.Q_obj = {}
	
	local skip_objMan = false
	for i = 1, objManager.maxObjects do
		local object = objManager:GetObject(i)
		if object then
			local dst = GetDistance(object)
			if object.name == "AurelionSol_Base_P_MissileSmall.troy" and dst > 300 and dst < 400 then
				self.PassiveLarge = false
				self.PassiveSmall = true
				self.PassiveToLarge = 0
				self.PassiveToSmall = 0
				self.missles[#self.missles+1] = object
				skip_objMan = true
			elseif not skip_objMan and object.name == "AurelionSol_Base_P_MissileLarge.troy" and dst > 400 and dst < 620 then
				self.PassiveLarge = true
				self.PassiveSmall = false
				self.PassiveToLarge = 0
				self.PassiveToSmall = 0
				self.missles[#self.missles+1] = object
			elseif not skip_objMan and object.name == "AurelionSol_Base_P_MissileSmall_toLarge.troy" and dst > 300 and dst < 620 then
				self.PassiveLarge = false
				self.PassiveSmall = false
				self.PassiveToLarge = true
				self.PassiveToSmall = false
				self.missles[#self.missles+1] = object
			elseif not skip_objMan and object.name == "AurelionSol_Base_P_MissileLarge_toSmall.troy" and dst > 300 and dst < 620 then
				self.PassiveLarge = false
				self.PassiveSmall = false
				self.PassiveToLarge = false
				self.PassiveToSmall = true
				self.missles[#self.missles+1] = object
			elseif object.name == "AurelionSol_Base_Q_Mis.troy" then
				if not self.Q_obj.obj or not self.Q_obj.obj.valid then
					self.Q_obj = {obj = object, startT = clock(), startPos = object.pos}
				end
			end
		end
	end

	if menu.spells.w.autoscale and myHero:CanUseSpell(_W) == 0 then
		local ininner = 0
		local inouter = 0
		local lowlife_obj = nil
		local lowlife_isinner = false

		for _,v in pairs(self.enemyHeroes) do
			if v.visible and not v.dead then
				local dst = GetDistance(v)
				if dst < 690 then
					if dst < 380 and dst > 370 then
						if not lowlife_obj or v.health < lowlife_obj.health then
							lowlife_obj = v
							lowlife_isinner = true
						end
						ininner = ininner + 1
					elseif dst > 490 then
						inouter = inouter + 1
						if not lowlife_obj or v.health < lowlife_obj.health then
							if not lowlife_obj or v.health < lowlife_obj.health then
								lowlife_obj = v
								lowlife_isinner = false
							end
						end
					end
				end
			end
		end

		if ininner + inouter > 0 then
			if menu.spells.w.ts == 1 then
				if ininner > inouter then
					if self.PassiveLarge then
						CastSpell(_W)
					end
				else
					if self.PassiveSmall then
						CastSpell(_W)
					end
				end
			else
				if lowlife_isinner and self.PassiveLarge then
					CastSpell(_W)
				elseif not lowlife_isinner and self.PassiveSmall then
					CastSpell(_W)
				end
			end
		end
	end

	if menu.spells.w.autosmallon and myHero:CanUseSpell(_W) == 0 and self.PassiveLarge and not TargetSelector:IsEnemyInRange(690) then
		if (menu.spells.w.autosmallLaneclear and OrbWalker:GetMode() == "2") or OrbWalker:GetMode() ~= 2 then
			CastSpell(_W)
		end
	end

	if menu.spells.q.autoExplode and #self.Q_obj ~= 0 then
		for _,v in pairs(self.Q_obj) do
			local obj = v.obj
			local range = 130+(clock()-self.Q_obj.startT)*50
			local inrange = 0
			for _,v in pairs(self.enemyHeroes) do
				if GetDistance(obj, v) < range then
					inrange = inrange + 1
				end
			end
			if inrange >= menu.spells.q.minautoExplode then
				CastSpell(_Q)
			end
		end
	end

	if menu.keys.EKey and CanUseSpell(_E) == 0 then
		local bvec = CalcVector(myHero, mousePos)*-(2000+myHero:GetSpellData(_E).level*1000)
		CastSpell(_E, myHero.x+bvec.x,myHero.y+bvec.y,myHero.z+bvec.z)
	end

	self:laneclear()
	self:harass()
	self:combo()

end

function Sol:laneclear()
	if OrbWalker:GetMode() == 2 then
		local target = TargetSelector:GetEnemyMinion(SpellQ.range+130)
		if not target or target.dead then return end
		if menu.ls.q then SpellQ:Cast(target) end
	end
end

function Sol:harass()
	if OrbWalker:GetMode() == 1 then
		local target = TargetSelector:GetEnemyHero(SpellQ.range)
		if not target then return end
		if menu.hs.q then SpellQ:Cast(target) end
	end
end

function Sol:combo()
	if OrbWalker:GetMode() == 4 then
		local target = TargetSelector:GetEnemyHero(SpellQ.range)
		if not target then return end
		if menu.hs.q then SpellQ:Cast(target) end

	end
end

function Sol:bushdetection(object)
	if menu.draw.marker and object and object.name and (object.name == "AurelionSol_Base_P_Audio_StarsIn_HitLarge.troy" --[[or object.name == "AurelionSol_Base_P_Tar.troy"]]) and IsGrass(object.pos) then
		self.enemyInBrush[#self.enemyInBrush+1] = {obj = object, time = clock(), pos = object.pos}
	end
end

function Sol:clearbush()
	if not menu.draw.marker or #self.enemyInBrush == 0 then return end
	local n = {}
	for _,v in pairs(self.enemyInBrush) do
		if v.time + 20 > clock() then
			n[#n+1] = v
		end
	end
	self.enemyInBrush = n
end


--[[
AurelionSol_Base_P_MissileSmall.troy --330.025
AurelionSol_Base_P_MissileLarge.troy --590.04
AurelionSol_Base_P_MissileSmall_toLarge.troy
AurelionSol_Base_P_MissileLarge_toSmall.troy
]]


-- Auto Updater--

function Update()
	if GetGameTimer() > 120 then printC("Game is already progressing, skipping Auto Update") return end

	local UpdateHost = "www.s1mplescripts.de"
	local ServerPath = "/S1mple/Scripts/BolStudio/AurelionSol/"
	local ServerFileName = "S1mple_AurelionSol.lua"
	local ServerVersionFileName = "S1mple_AurelionSol.version"

	DL = Download()
	local ServerVersionDATA = GetWebResult("s1mplescripts.de" , ServerPath..ServerVersionFileName)
	if ServerVersionDATA then
		local ServerVersion = tonumber(ServerVersionDATA)
		if ServerVersion then
			if ServerVersion > tonumber(Version) then
				printC("Updating, don't press F9")
				DL:newDL(UpdateHost, ServerPath..ServerFileName, ServerFileName, LIB_PATH, function ()
					printC("S1mple_AurelionSol updated, please reload")
				end)
			end
		else
			printC("An error occured, while updating, please reload")
		end
	else
		printC("Could not connect to update Server")
	end
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
		self.headsocket:send('HEAD '..self.filepath..' HTTP/1.0'.. self.CRLF ..'Host: '..self.host.. self.CRLF ..'User-Agent: Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36'.. self.CRLF .. self.CRLF)

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
				DrawTextA(tostring(round(self.progress).." %"), 15,150,52+self.offset)
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
		if round(v.progress) < 100 then
			v.offset = k*40-40
			x[#x+1] = v
		else
			self.callbacks[k]()
		end
	end
	self.aktivedownloads = {}
	self.aktivedownloads = x
end

-- Script starts here

function printC(arg)
	print('<font color=\"#515151\">S1mple_AurelionSol</font><font color=\"#000000\"> - </font><font color=\"#cccccc\">'..arg..'</font>')
end


function OnLoad()
	local t_start = clock()
	if AutoUpdate and GetInGameTimer() < 120 then
		Update()
	elseif GetInGameTimer() >= 120 and AutoUpdate then
		printC("Game already started, ignoring Updates")
	elseif not AutoUpdate then
		printC("Auto Update disabled")
	end
	Menu()
	OrbWalker = OrbWalker()
	Prediction = Prediction()
	TargetSelector = TargetSelector()
	Sol = Sol()
	if menu.adv.debug then
		local t_end = clock()
		printC("Loading took: "..t_end-t_start.." sec")
	end
	printC("Welcome " ..GetUser())
end

function Menu()
	menu = scriptConfig("S1mple_AurelionSol", "S1mple_AurelionSol")
	menu:addSubMenu("Advanced Settings", "adv")
		menu.adv:addParam("debug", "Enable Debug Mode", SCRIPT_PARAM_ONOFF, false)
		menu.adv:addParam("tpm", "Tick Performance Mode", SCRIPT_PARAM_ONOFF, false)

	menu:addSubMenu("Spell Settings", "spells")
		menu.spells:addSubMenu("Q", "q")
			menu.spells.q:addParam("autoqone", "Auto Q on E Cast", SCRIPT_PARAM_ONOFF, true)
			menu.spells.q:addParam("autoExplode", "Auto 2nd Cast against Champions", SCRIPT_PARAM_ONOFF, true)
			menu.spells.q:addParam("minautoExplode", "Min Enemy's for Auto 2nd Cast", SCRIPT_PARAM_SLICE, 1,0,5,0)

		menu.spells:addSubMenu("W", "w")
			menu.spells.w:addParam("autoscale", "Auto Scale", SCRIPT_PARAM_ONOFF, true)
			spell_w_ts_list = {"Most", "Lowlife"}
			menu.spells.w:addParam("ts", "Focus:", SCRIPT_PARAM_LIST,1,spell_w_ts_list)
			menu.spells.w:addParam("autosmallon", "Auto Shrink if no Enemy", SCRIPT_PARAM_ONOFF, true)
			menu.spells.w:addParam("autosmallLaneclear", "Auto Shrink in Laneclear", SCRIPT_PARAM_ONOFF, false)
	
	menu:addSubMenu("Laneclear Settings", "ls")
		menu.ls:addParam("q", "Use Q", SCRIPT_PARAM_ONOFF, true)

	menu:addSubMenu("Harras Settings", "hs")
		menu.hs:addParam("q", "Use Q", SCRIPT_PARAM_ONOFF, true)

	menu:addSubMenu("Combo Mode", "c")
		menu.c:addParam("q", "Use Q", SCRIPT_PARAM_ONOFF, true)
		--menu.c:addParam("r", "Use R", SCRIPT_PARAM_ONOFF, true) --TBD
		--menu.c:addParam("min", "Min Enemy's", SCRIPT_PARAM_SLICE, 2, 1,5,0) --TBD

	menu:addSubMenu("Keys", "keys")
		menu.keys:addParam("EKey", "Cast E in Mouse Direction", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("N"))

	menu:addSubMenu("Drawings", "draw")
		menu.draw:addParam("missles", "Draw Missile HitBox", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("passive", "Draw Passive Circle", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("qaoe", "Draw Q AOE", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("marker", "Mark Target in Grass if hit by Passive", SCRIPT_PARAM_ONOFF, true)

	menu:addParam("space", "===========================", SCRIPT_PARAM_INFO,"")
	if _G.VIP_USER then
		sequences = {"QWE", "QEW", "WQE", "WEQ", "EQW", "EWQ"}
		menu:addParam("autolvl", "Auto Level", SCRIPT_PARAM_ONOFF, false)
		menu:addParam("lvlseq", "Level Sequence: (1-3)", SCRIPT_PARAM_LIST , 1, sequences)

		menu:addParam("skin", "Skin Changer:", SCRIPT_PARAM_ONOFF, false)
		menu:addParam("skinlist", "Skins: ", SCRIPT_PARAM_LIST, 1, {"Classic", "Ashen Lord"})
		menu:setCallback("skin", function (value)
			if value and _G.VIP_USER then
				SetSkin(myHero, menu.skinlist-1)
			else
				SetSkin(myHero, -1)
			end
		end)
		menu:setCallback("skinlist", function (value)
			if menu.skin and _G.VIP_USER then
				SetSkin(myHero, menu.skinlist-1)
			end
		end)

		if menu.skin and _G.VIP_USER then
			SetSkin(myHero, menu.skinlist-1)
		end
		menu:addParam("space", "===========================", SCRIPT_PARAM_INFO,"")
	end

	menu:addParam("version", "Version: ", SCRIPT_PARAM_INFO,Version)
end

function OnUnLoad()
	if _G.VIP_USER and menu.skin then
		SetSkin(myHero, -1)
	end
end

function OnTick()
	if VIP_USER and menu.autolvl and GetHeroLeveled() < 3 then
		local c = sequences[menu.lvlseq]:sub(GetHeroLeveled()+1,GetHeroLeveled()+1)
		if c == "Q" then
			LevelSpell(SPELL_1)
		elseif c == "W" then
			LevelSpell(SPELL_2)
		elseif c == "E" then
			LevelSpell(SPELL_3)
		end
	end
end

function CalcVector(source,target)
	local V = Vector(source.x, source.y, source.z)
	local V2 = Vector(target.x, target.y, target.z)
	local vec = V-V2
	local vec2 = vec:normalized()
	return vec2
end