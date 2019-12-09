if myHero.charName ~= "Syndra" then return end

-- http://bol-tools.com/ tracker
assert(load(Base64Decode("G0x1YVIAAQQEBAgAGZMNChoKAAAAAAAAAAAAAQQfAAAAAwAAAEQAAACGAEAA5QAAAJ1AAAGGQEAA5UAAAJ1AAAGlgAAACIAAgaXAAAAIgICBhgBBAOUAAQCdQAABhkBBAMGAAQCdQAABhoBBAOVAAQCKwICDhoBBAOWAAQCKwACEhoBBAOXAAQCKwICEhoBBAOUAAgCKwACFHwCAAAsAAAAEEgAAAEFkZFVubG9hZENhbGxiYWNrAAQUAAAAQWRkQnVnc3BsYXRDYWxsYmFjawAEDAAAAFRyYWNrZXJMb2FkAAQNAAAAQm9sVG9vbHNUaW1lAAQQAAAAQWRkVGlja0NhbGxiYWNrAAQGAAAAY2xhc3MABA4AAABTY3JpcHRUcmFja2VyAAQHAAAAX19pbml0AAQSAAAAU2VuZFZhbHVlVG9TZXJ2ZXIABAoAAABzZW5kRGF0YXMABAsAAABHZXRXZWJQYWdlAAkAAAACAAAAAwAAAAAAAwkAAAAFAAAAGABAABcAAIAfAIAABQAAAAxAQACBgAAAHUCAAR8AgAADAAAAAAQSAAAAU2VuZFZhbHVlVG9TZXJ2ZXIABAcAAAB1bmxvYWQAAAAAAAEAAAABAQAAAAAAAAAAAAAAAAAAAAAEAAAABQAAAAAAAwkAAAAFAAAAGABAABcAAIAfAIAABQAAAAxAQACBgAAAHUCAAR8AgAADAAAAAAQSAAAAU2VuZFZhbHVlVG9TZXJ2ZXIABAkAAABidWdzcGxhdAAAAAAAAQAAAAEBAAAAAAAAAAAAAAAAAAAAAAUAAAAHAAAAAQAEDQAAAEYAwACAAAAAXYAAAUkAAABFAAAATEDAAMGAAABdQIABRsDAAKUAAADBAAEAXUCAAR8AgAAFAAAABA4AAABTY3JpcHRUcmFja2VyAAQSAAAAU2VuZFZhbHVlVG9TZXJ2ZXIABAUAAABsb2FkAAQMAAAARGVsYXlBY3Rpb24AAwAAAAAAQHpAAQAAAAYAAAAHAAAAAAADBQAAAAUAAAAMAEAAgUAAAB1AgAEfAIAAAgAAAAQSAAAAU2VuZFZhbHVlVG9TZXJ2ZXIABAgAAAB3b3JraW5nAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAEBAAAAAAAAAAAAAAAAAAAAAAAACAAAAA0AAAAAAAYyAAAABgBAAB2AgAAaQEAAF4AAgEGAAABfAAABF0AKgEYAQQBHQMEAgYABAMbAQQDHAMIBEEFCAN0AAAFdgAAACECAgUYAQQBHQMEAgYABAMbAQQDHAMIBEMFCAEbBQABPwcICDkEBAt0AAAFdgAAACEAAhUYAQQBHQMEAgYABAMbAQQDHAMIBBsFAAA9BQgIOAQEARoFCAE/BwgIOQQEC3QAAAV2AAAAIQACGRsBAAIFAAwDGgEIAAUEDAEYBQwBWQIEAXwAAAR8AgAAOAAAABA8AAABHZXRJbkdhbWVUaW1lcgADAAAAAAAAAAAECQAAADAwOjAwOjAwAAQGAAAAaG91cnMABAcAAABzdHJpbmcABAcAAABmb3JtYXQABAYAAAAlMDIuZgAEBQAAAG1hdGgABAYAAABmbG9vcgADAAAAAAAgrEAEBQAAAG1pbnMAAwAAAAAAAE5ABAUAAABzZWNzAAQCAAAAOgAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAA4AAAATAAAAAAAIKAAAAAEAAABGQEAAR4DAAIEAAAAhAAiABkFAAAzBQAKAAYABHYGAAVgAQQIXgAaAR0FBAhiAwQIXwAWAR8FBAhkAwAIXAAWARQGAAFtBAAAXQASARwFCAoZBQgCHAUIDGICBAheAAYBFAQABTIHCAsHBAgBdQYABQwGAAEkBgAAXQAGARQEAAUyBwgLBAQMAXUGAAUMBgABJAYAAIED3fx8AgAANAAAAAwAAAAAAAPA/BAsAAABvYmpNYW5hZ2VyAAQLAAAAbWF4T2JqZWN0cwAECgAAAGdldE9iamVjdAAABAUAAAB0eXBlAAQHAAAAb2JqX0hRAAQHAAAAaGVhbHRoAAQFAAAAdGVhbQAEBwAAAG15SGVybwAEEgAAAFNlbmRWYWx1ZVRvU2VydmVyAAQGAAAAbG9vc2UABAQAAAB3aW4AAAAAAAMAAAAAAAEAAQEAAAAAAAAAAAAAAAAAAAAAFAAAABQAAAACAAICAAAACkAAgB8AgAABAAAABAoAAABzY3JpcHRLZXkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFAAAABUAAAACAAUKAAAAhgBAAMAAgACdgAABGEBAARfAAICFAIAAjIBAAQABgACdQIABHwCAAAMAAAAEBQAAAHR5cGUABAcAAABzdHJpbmcABAoAAABzZW5kRGF0YXMAAAAAAAIAAAAAAAEBAAAAAAAAAAAAAAAAAAAAABYAAAAlAAAAAgATPwAAAApAAICGgEAAnYCAAAqAgICGAEEAxkBBAAaBQQAHwUECQQECAB2BAAFGgUEAR8HBAoFBAgBdgQABhoFBAIfBQQPBgQIAnYEAAcaBQQDHwcEDAcICAN2BAAEGgkEAB8JBBEECAwAdggABFgECAt0AAAGdgAAACoCAgYaAQwCdgIAACoCAhgoAxIeGQEQAmwAAABdAAIAKgMSHFwAAgArAxIeGQEUAh4BFAQqAAIqFAIAAjMBFAQEBBgBBQQYAh4FGAMHBBgAAAoAAQQIHAIcCRQDBQgcAB0NAAEGDBwCHw0AAwcMHAAdEQwBBBAgAh8RDAFaBhAKdQAACHwCAACEAAAAEBwAAAGFjdGlvbgAECQAAAHVzZXJuYW1lAAQIAAAAR2V0VXNlcgAEBQAAAGh3aWQABA0AAABCYXNlNjRFbmNvZGUABAkAAAB0b3N0cmluZwAEAwAAAG9zAAQHAAAAZ2V0ZW52AAQVAAAAUFJPQ0VTU09SX0lERU5USUZJRVIABAkAAABVU0VSTkFNRQAEDQAAAENPTVBVVEVSTkFNRQAEEAAAAFBST0NFU1NPUl9MRVZFTAAEEwAAAFBST0NFU1NPUl9SRVZJU0lPTgAECwAAAGluZ2FtZVRpbWUABA0AAABCb2xUb29sc1RpbWUABAYAAABpc1ZpcAAEAQAAAAAECQAAAFZJUF9VU0VSAAMAAAAAAADwPwMAAAAAAAAAAAQJAAAAY2hhbXBpb24ABAcAAABteUhlcm8ABAkAAABjaGFyTmFtZQAECwAAAEdldFdlYlBhZ2UABA4AAABib2wtdG9vbHMuY29tAAQXAAAAL2FwaS9ldmVudHM/c2NyaXB0S2V5PQAECgAAAHNjcmlwdEtleQAECQAAACZhY3Rpb249AAQLAAAAJmNoYW1waW9uPQAEDgAAACZib2xVc2VybmFtZT0ABAcAAAAmaHdpZD0ABA0AAAAmaW5nYW1lVGltZT0ABAgAAAAmaXNWaXA9AAAAAAACAAAAAAABAQAAAAAAAAAAAAAAAAAAAAAmAAAAKgAAAAMACiEAAADGQEAAAYEAAN2AAAHHwMAB3YCAAArAAIDHAEAAzADBAUABgACBQQEA3UAAAscAQADMgMEBQcEBAIABAAHBAQIAAAKAAEFCAgBWQYIC3UCAAccAQADMgMIBQcECAIEBAwDdQAACxwBAAMyAwgFBQQMAgYEDAN1AAAIKAMSHCgDEiB8AgAASAAAABAcAAABTb2NrZXQABAgAAAByZXF1aXJlAAQHAAAAc29ja2V0AAQEAAAAdGNwAAQIAAAAY29ubmVjdAADAAAAAAAAVEAEBQAAAHNlbmQABAUAAABHRVQgAAQSAAAAIEhUVFAvMS4wDQpIb3N0OiAABAUAAAANCg0KAAQLAAAAc2V0dGltZW91dAADAAAAAAAAAAAEAgAAAGIAAwAAAPyD15dBBAIAAAB0AAQKAAAATGFzdFByaW50AAQBAAAAAAQFAAAARmlsZQAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAABAAAAAAAAAAAAAAAAAAAAAAA="), nil, "bt", _ENV))()
TrackerLoad("ywT7rpLgiO8DxceI")

--Auto Updater Settings--
local AutoUpdate = true --Turn to false if you dislike AutoUpdating
local Version = 0.15

--Technicall Stuff
	
-- Made by Nebelwolfi. Makes Classes Local, Not Global -- 
function Class(name)
	_ENV[name] = { }
	_ENV[name].__index = _ENV[name]
	local mt = { __call = function(self, ...) local b = { } setmetatable(b, _ENV[name]) b:__init(...) return b end }
	setmetatable(_ENV[name], mt)
end

--Main Script
Class("OrbWalker")
Class("Prediction")
Class("Spell")
Class("Item")
Class("TargetSelector")
Class("SphereManager")
Class("AntiGapCloser")
Class("Syndra")

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
			printC("Loading S1mpleOrbWalker")
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
	--[[
	Thanks Nebelwolfi
	https://github.com/nebelwolfi/BoL/blob/master/Common/SpellData.lua
	]]
	self.Q = { name = "SyndraQ", speed = math.huge, delay = 0.67, range = 790, width = 125, collision = false, aoe = true, type = "circular", dmgAP = function(source, target) return (5+45*source:GetSpellData(_Q).level+0.75*source.ap) end}
	self.W = { name = "syndrawcast", speed = math.huge, delay = 0.8, range = 925, width = 190, collision = false, aoe = true, type = "circular", dmgAP = function(source, target) return 40+40*source:GetSpellData(_W).level+0.7*source.ap end}
	self.E = { name = "", speed = 2500, delay = 0.25, range = 730, width = 45, collision = false, aoe = true, type = "cone", dmgAP = function(source, target) return 25+45*source:GetSpellData(_E).level+0.4*source.ap end}
	self.R = { name = "", range = 725, dmgAP = function(source, target, stacks) return math.max((stacks or 1) + 3, 7)*(45+45*source:GetSpellData(_R).level+0.2*source.ap) end}

	SpellQ = Spell(_Q, self.Q.speed, self.Q.delay, self.Q.range, self.Q.width, self.Q.collision, self.Q.aoe, self.Q.type)
	SpellW = Spell(_W, self.W.speed, self.W.delay, self.W.range, self.W.width, self.W.collision, self.W.aoe, self.W.type)
	SpellE = Spell(_E, self.E.speed, self.E.delay, self.E.range, self.E.width, self.E.collision, self.E.aoe, self.E.type)
	SpellR = Spell(_R, nil, nil, self.R.range, nil, nil, nil, nil)

end

function Prediction:SetupMenu()
	UPL:AddToMenu2(menu)
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

function Spell:Cast(target, pos)
	if not target and not pos then return end
	if target and not ValidTarget(target) then return end
	if self.type == nil and target and ValidTarget(target) then
		DelayAction(function ()
			CastSpell(self.slot, target)
		end,math.random(0.1,0.25))
	elseif target then
		if target.type ~= myHero.type then
			DelayAction(function ()
				CastSpell(self.slot, target.x,target.z)
			end,math.random(0.1,0.25))
		else
			local CastPosition, HitChance, HeroPosition = UPL:Predict(self.slot, myHero, target)
			if CastPosition and HitChance >= 0 then --Returns 0 if higher then in Nebel's Menu
				DelayAction(function ()
					if CastPosition then
						CastSpell(self.slot, CastPosition.x, CastPosition.z)
					end
				end,math.random(0.1,0.25))
			end
		end
	elseif pos then
		DelayAction(function ()
			CastSpell(self.slot, pos.x, pos.z)
		end,math.random(0.1,0.25))
	end
end

function Spell:IsReady()
	return (myHero:CanUseSpell(self.slot) == 0)
end

function Item:__init()
	if menu.adv.debug then
		printC("Item Submodule loaded")
	end
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
				self.Minions[#self.Minions+1] = object
			else
				self.JungleMinions[#self.JungleMinions+1] = object
			end
		end
	end

	AddCreateObjCallback(function (object)
		if object and object.valid and object.type and object.type == "obj_AI_Minion" and object.team ~= myHero.team then
			if object.charName:find("Minion") then
				self.Minions[#self.Minions+1] = object
			else
				self.JungleMinions[#self.JungleMinions+1] = object
			end
		end
	end)

	AddDeleteObjCallback(function (object)
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
	end)
	if menu.adv.debug then
		printC("TargetSelector Submodule loaded")
	end
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

function SphereManager:__init()
	self.sphere = {}
	self.stimeadd = 0
	self.sspheres = 0
	self.isbound = false

	AddCreateObjCallback(function (object)
		if object and object.valid and object.name and object.name == "Seed" then
			if self.sspheres > 0 then
				self.sphere[#self.sphere+1] = {obj = object, endT = os.clock()+6.0+(myHero:GetSpellData(_Q).level == 5 and 2 or 0)-GetLatency()/2000-(SphereManager.stimeadd/SphereManager.sspheres), grabbed = false, netID = object.networkID}
			else
				self.sphere[#self.sphere+1] = {obj = object, endT = os.clock()+6.0+(myHero:GetSpellData(_Q).level == 5 and 2 or 0)-GetLatency()/2000, grabbed = false, netID = object.networkID}
			end
		end
	end)

	AddDeleteObjCallback(function (object)
		local s = {}
		if object and object.name and (object.name:find("_Q_idle") or object.name:find("_Q_Lv5_idle")) and object.name:find("Syndra") then
			local x
			for i,v in pairs(self.sphere) do
				if GetDistance(v.obj, object) > 1 and v.netID ~= object.networkID then
					s[#s+1] = v
				else
					x = i
				end
			end
			if self.sphere[x] and self.sphere[x].endT-os.clock() < 0.5 and self.sphere[x].endT-os.clock() > -0.5 then
				self.sspheres = self.sspheres + 1
				self.stimeadd = self.stimeadd + self.sphere[x].endT-os.clock()
			end
			self.sphere = s
		end
	end)

	AddDrawCallback(function ()
		for _, v in pairs(self.sphere) do
			local t = v.endT-os.clock()
			if t > 0 then
				DrawCircle3D(v.obj.x,v.obj.y,v.obj.z,40,2,ARGB(255,255-t*36,t*36,0))
			end
			if not v.grabbed then
				DrawText3D(tostring(math.round(t)), v.obj.x,v.obj.y,v.obj.z,18)
			else
				DrawCircle3D(v.obj.x,v.obj.y,v.obj.z,40,2,ARGB(255,255,0,255))
			end
		end
	end)

	AddApplyBuffCallback(function (a,b,c)
		if a and a.isMe and b and c and c.name:lower() == "syndrawtooltip" then
			self.isbound = true
		end
	end)

	AddRemoveBuffCallback(function (a,b)
		if a and a.isMe and b and b.name:lower() == "syndrawtooltip" then
			self.isbound = false
		end
	end)

	AddTickCallback(function ()
		if TargetHaveBuff("recall", myHero) then return end
		if menu.spells.w.auto2ndW and self.isbound then
			local t = TargetSelector:GetEnemyHero(SpellW.range+SpellW.width/2)
			if not t then t = TargetSelector:GetEnemyMinion(SpellW.range+SpellW.width/2) end
			if not t then t = TargetSelector:GetJungleMinion(SpellW.range+SpellW.width/2) end
			if t then
				SpellW:Cast(t)
			end
		end
		if menu.spells.w.usebeforeexpire and not self.isbound then
			local t = TargetSelector:GetEnemyHero(SpellW.range+SpellW.width/2)
			if not t then t = TargetSelector:GetEnemyMinion(SpellW.range+SpellW.width/2) end
			if not t then t = TargetSelector:GetJungleMinion(SpellW.range+SpellW.width/2) end
			if not t then return end
			for _,v in pairs(self.sphere) do
				local t = v.endT-os.clock()
				if t < 1 and v.obj and GetDistance(v.obj) < SpellW.range then
					CastSpell(_W, v.obj.x, v.obj.z)
				end
			end
		end
	end)
	if menu.adv.debug then
		printC("Sphere Manager Submodule loaded")
	end
end

function SphereManager:GetSphere(range)
	local s = nil
	for _,v in pairs(self.sphere) do
		if v and GetDistance(v.obj) < range then
			if not s then
				s = v
			elseif s.endT > v.endT then
				s = v
			end
		end
	end
	if s then return s.obj else return nil end
end

GapcloserUnitTarget = {
	['AkaliShadowDance']	= {true, Champ = 'Akali', 	spellKey = 'R'},
	['Headbutt']     	= {true, Champ = 'Alistar', 	spellKey = 'W'},
	['DianaTeleport']       	= {true, Champ = 'Diana', 	spellKey = 'R'},
	['IreliaGatotsu']     	= {true, Champ = 'Irelia',	spellKey = 'Q'},
	['JaxLeapStrike']         	= {true, Champ = 'Jax', 	spellKey = 'Q'},
	['JayceToTheSkies']       	= {true, Champ = 'Jayce',	spellKey = 'Q'},
	['MaokaiUnstableGrowth']    = {true, Champ = 'Maokai',	spellKey = 'W'},
	['MonkeyKingNimbus']  	= {true, Champ = 'MonkeyKing',	spellKey = 'E'},
	['Pantheon_LeapBash']   	= {true, Champ = 'Pantheon',	spellKey = 'W'},
	['PoppyHeroicCharge']       = {true, Champ = 'Poppy',	spellKey = 'E'},
	['QuinnE']       	= {true, Champ = 'Quinn',	spellKey = 'E'},
	['XenZhaoSweep']     	= {true, Champ = 'XinZhao',	spellKey = 'E'},
	['blindmonkqtwo']	    	= {true, Champ = 'LeeSin',	spellKey = 'Q'},
	['FizzPiercingStrike']	    = {true, Champ = 'Fizz',	spellKey = 'Q'},
	['RengarLeap']	    	= {true, Champ = 'Rengar',	spellKey = 'Q/R'},
	['YasuoDashWrapper']	    = {true, Champ = 'Yasuo',	spellKey = 'E'},
}

GapcloserUnitNoTarget = {
	['AatroxQ']	= {true, Champ = 'Aatrox', 	range = 1000,  	projSpeed = 1200, spellKey = 'Q'},
	['GragasE']	= {true, Champ = 'Gragas', 	range = 600,   	projSpeed = 2000, spellKey = 'E'},
	['GravesMove']	= {true, Champ = 'Graves', 	range = 425,   	projSpeed = 2000, spellKey = 'E'},
	['HecarimUlt']	= {true, Champ = 'Hecarim', 	range = 1000,   projSpeed = 1200, spellKey = 'R'},
	['JarvanIVDragonStrike']	= {true, Champ = 'JarvanIV',	range = 770,   	projSpeed = 2000, spellKey = 'Q'},
	['JarvanIVCataclysm']	= {true, Champ = 'JarvanIV', 	range = 650,   	projSpeed = 2000, spellKey = 'R'},
	['KhazixE']	= {true, Champ = 'Khazix', 	range = 900,   	projSpeed = 2000, spellKey = 'E'},
	['khazixelong']	= {true, Champ = 'Khazix', 	range = 900,   	projSpeed = 2000, spellKey = 'E'},
	['LeblancSlide']	= {true, Champ = 'Leblanc', 	range = 600,   	projSpeed = 2000, spellKey = 'W'},
	['LeblancSlideM']	= {true, Champ = 'Leblanc', 	range = 600,   	projSpeed = 2000, spellKey = 'WMimic'},
	['LeonaZenithBlade']	= {true, Champ = 'Leona', 	range = 900,  	projSpeed = 2000, spellKey = 'E'},
	['UFSlash']	= {true, Champ = 'Malphite', 	range = 1000,  	projSpeed = 1800, spellKey = 'R'},
	['RenektonSliceAndDice']	= {true, Champ = 'Renekton', 	range = 450,  	projSpeed = 2000, spellKey = 'E'},
	['SejuaniArcticAssault']	= {true, Champ = 'Sejuani', 	range = 650,  	projSpeed = 2000, spellKey = 'Q'},
	['ShenShadowDash']	= {true, Champ = 'Shen', 	range = 575,  	projSpeed = 2000, spellKey = 'E'},
	['RocketJump']	= {true, Champ = 'Tristana', 	range = 900,  	projSpeed = 2000, spellKey = 'W'},
	['slashCast']	= {true, Champ = 'Tryndamere', 	range = 650,  	projSpeed = 1450, spellKey = 'E'},
}

function AntiGapCloser:__init()
	AddProcessSpellCallback(function (source, spelldata)
		if menu.adv.antigap and spelldata.target == myHero and GapcloserUnitTarget[spelldata.name] then
			if SpellE:IsReady() and GetDistance(spelldata.endPos) < Prediction.E.range then
				if SpellQ:IsReady() then
					CastSpell(_Q, source.x, source.z)
					CastSpell(_E, source.x, source.z)
				else
					CastSpell(_E, source.x, source.z)
				end
			end
		elseif GapcloserUnitNoTarget[spelldata.name] and SpellE:IsReady() then
			if SpellQ:IsReady() and GetDistance(spelldata.endPos) < Prediction.Q.range then
			--	SpellQ:Cast(source)
			--	SpellE:Cast(source)
			elseif GetDistance(spelldata.endPos) < Prediction.E.range then
			--	SpellE:Cast(source)
			end
		end
	end)
	if menu.adv.debug then
		printC("AntiGapCloser Submodule loaded")
	end
end

function Syndra:__init()
	AddTickCallback(function ()
		self:KS()
		self:QE()
		self:JungleSteal()
		self:laneclear()
		self:harras()
		self:combo()
	end)

	AddCastSpellCallback(function (ID, startPos, endPos, target)
		if ID == 3 then
			if menu.spells.r.block and Prediction.R.dmgAP(myHero, target, #SphereManager.sphere) < target.health then
				BlockSpell()
			end

			local h = target.health
			local dst = GetDistance(target)
			if VIP_USER and Prediction.R.dmgAP(myHero, target, #SphereManager.sphere) > h then
				if dst < 790 and SpellQ:IsReady() and Prediction.Q.dmgAP(myHero, target) > h*1.2 then --1.1 for secure kill
					BlockSpell()
					DelayAction(function ()
						CastSpell(_Q, target.x,target.z)
					end,0.25)
				elseif dst < 925 and SpellW:IsReady() and SphereManager.isbound and Prediction.W.dmgAP(myHero, target) > h*1.2 then
					BlockSpell()
					DelayAction(function ()
						CastSpell(_W, target.x,target.z)
					end,0.25)
				elseif dst < 730 and SpellE:IsReady() and Prediction.W.dmgAP(myHero, target) > h*1.2 then
					BlockSpell()
					DelayAction(function ()
						CastSpell(_E, target.x,target.z)
					end,0.25)
				end
			end
		end
	end)

	AddDrawCallback(function ()
		self:Draw()
	end)
	if menu.adv.debug then
		printC("Syndra Submodule loaded")
	end
end

function Syndra:Draw()
	if menu.draw.qrange then
		DrawCircle3D(myHero.x,myHero.y,myHero.z,Prediction.Q.range, 1, ARGB(255,0,255,255),15)
	end
	if menu.draw.wrange then
		DrawCircle3D(myHero.x,myHero.y,myHero.z,Prediction.W.range, 1, ARGB(255,255,255,0),15)
	end
	if menu.draw.erange then
		DrawCircle3D(myHero.x,myHero.y,myHero.z,Prediction.E.range, 1, ARGB(255,255,0,255),15)
	end
	if menu.draw.rrange then
		DrawCircle3D(myHero.x,myHero.y,myHero.z,Prediction.R.range, 1, ARGB(255,255,255,255),15)
	end

	if menu.draw.nspheres then
		local n = 0
		for _, v in pairs(SphereManager.sphere) do
			if GetDistance(v.obj) < Prediction.W.range then
				n = n+1
			end
		end
		DrawText3D(tostring(n),myHero.x,myHero.y,myHero.z,28,ARGB(255,255,255,0))
	end

	if menu.draw.dmgdraw then
		for i = 1, objManager.maxObjects do
			local object = objManager:GetObject(i)
			if object and object.valid and not object.dead and object.visible and GetDistance(object) < 2000 and object.type == myHero.type and object.team ~= myHero.team then
				local dmg = 0
				if SpellQ:IsReady() then
					dmg = dmg+Prediction.Q.dmgAP(myHero,object)
				end
				if SpellE:IsReady() then
					Prediction.E.dmgAP(myHero,object)
				end
				if SphereManager.isbound then
					dmg = dmg+Prediction.W.dmgAP(myHero,object)
				end
				if object.type == myHero.type and SpellR:IsReady() then
					dmg = dmg+Prediction.R.dmgAP(myHero,object,#SphereManager.sphere)
				end
				dmg = myHero:CalcMagicDamage(object, dmg)
				
				if object.type == myHero.type then
					local barPos = GetUnitHPBarPos(object) --THANKS Jori
					local barOffset = GetUnitHPBarOffset(object)
					do -- For some reason the x offset never exists
						local t = {
							["Darius"] = -0.05,
							["Renekton"] = -0.05,
							["Sion"] = -0.05,
							["Thresh"] = 0.03,
							["Jhin"] = -0.06,
						}
						
						barOffset.x = t[object.charName] or 0
					end
					baseX = barPos.x - 69 + barOffset.x * 150
					baseY = barPos.y + barOffset.y * 50 + 12.5
					if object.charName == "Jhin" then
						baseY = baseY-12
					end
				end

				local hpp = (object.health/object.maxHealth)*100
				local dmgp = (dmg/object.health)*100

				DrawLine(baseX, baseY-20, baseX+1.05*hpp, baseY-20, 7, ARGB(255,255,255,255))

				if dmgp < hpp then
					DrawLine(baseX, baseY-20, baseX+1.05*dmgp, baseY-20, 7, ARGB(255,255,255,0))
				else
					DrawLine(baseX, baseY-20, baseX+105, baseY-20, 7, ARGB(255,255,0,0))
				end
			end
		end
	end

	if menu.draw.sphereline then
		for _, v in pairs(SphereManager.sphere) do
			if GetDistance(v.obj) < 2000 then
				DrawLine3D(myHero.x,myHero.y,myHero.z,v.obj.x,v.obj.y,v.obj.z,18,ARGB(128,0,255,128))
			end
		end
	end

	if menu.draw.qestunline and SpellE:IsReady() then
		for _, v in pairs(SphereManager.sphere) do
			local dst = GetDistance(v.obj)
			if dst < 730 then
				local range = 1000+dst*0.273972602739726
				local Vec = CalcVector(v.obj, myHero)*range
				DrawLine3D(myHero.x,myHero.y,myHero.z,myHero.x+Vec.x,myHero.y+Vec.y,myHero.z+Vec.z,Prediction.Q.width,ARGB(128,255,255,255))
			end
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

function Syndra:QE()
	
end

function Syndra:JungleSteal()
	if #TargetSelector.JungleMinions < 1 then return end
	local dmg = 0
	if SpellQ:IsReady() then dmg = dmg+Prediction.Q.dmgAP(myHero, TargetSelector.JungleMinions[1]) end
	if SpellW:IsReady() then dmg = dmg+Prediction.W.dmgAP(myHero, TargetSelector.JungleMinions[1]) end
	if menu.jng.blue then
		for _,v in pairs(TargetSelector.JungleMinions) do
			if (v.name:find("SRU_Blue") and not v.name:find("SRU_BlueMini")) or (v.name:find("SRU_Red") and not v.name:find("SRU_RedMini")) or v.name:find("SRU_Gromp") then
				if dmg > v.health and not v.dead then
					CastSpell(_W, v.x,v.z)
					CastSpell(_W, myHero.x,myHero.z)
					CastSpell(_Q, v.x,v.z)
				end
			elseif v.name:find("SRU_RiftHerald") or v.name:find("SRU_Dragon") or v.name:find("SRU_Baron") then
				if SpellW:IsReady() then dmg = dmg-Prediction.W.dmgAP(myHero, TargetSelector.JungleMinions[1]) end
				if dmg > v.health and not v.dead then
					CastSpell(_Q, v.x,v.z)
				end
			end
		end
	end
end

function Syndra:laneclear()
	if OrbWalker:GetMode() ~= 2 then return end
	local t = TargetSelector:GetEnemyMinion(SpellW.range+SpellW.width/2)
	if not t then t = TargetSelector:GetJungleMinion(SpellW.range+SpellW.width/2) end
	if not t then return end

	if menu.ls.q then
		SpellQ:Cast(t)
	end
	if menu.ls.w then
		SpellW:Cast(t)
	end
	if menu.ls.e then
		SpellE:Cast(t)
	end

end

function Syndra:harras()
	if (OrbWalker:GetMode() ~= 1 and not menu.keys.harasstoggle) then return end

	local t = TargetSelector:GetEnemyHero(SpellW.range+SpellW.width/2)
	if not t then return end

	if menu.hs.q then
		SpellQ:Cast(t)
	end
	if menu.hs.w then
		local x = SphereManager:GetSphere(SpellW.range)
		if x then
			SpellW:Cast(x)
		else
			SpellW:Cast(t)
		end
	end
	if menu.hs.e then
		SpellE:Cast(t)
	end

end

function Syndra:combo()
	if OrbWalker:GetMode() ~= 4 then return end
	local t = TargetSelector:GetEnemyHero(SpellW.range+SpellW.width/2)
	if not t then return end

	if menu.c.q then
		SpellQ:Cast(t)
	end
	if menu.c.w then
		local x = SphereManager:GetSphere(SpellW.range)
		if x then
			SpellW:Cast(x)
		else
			SpellW:Cast(t)
		end
	end
	if menu.c.e then
		SpellE:Cast(t)
	end

	if menu.c.r and Prediction.R.dmgAP(myHero, target) > t.health*1.1 then
		SpellR:Cast(t)
	end
end

function Syndra:KS()
	local t = TargetSelector:GetEnemyHero(SpellR.range)
	if menu.spells.r.ks and t and Prediction.R.dmgAP(myHero, target) > t.health*1.1 then
		SpellR:Cast(t)
	end
end


function OnDraw()
	if not menu.adv.debug then return end

	DrawTextA("Ping: "..GetLatency()/2000,12,12,0)
	DrawTextA("stimeadd/sspheres: "..SphereManager.stimeadd/SphereManager.sspheres,12,12,12)
	DrawTextA("stimeadd: "..SphereManager.stimeadd,12,12,24)
	DrawTextA("sspheres: "..SphereManager.sspheres,12,12,36)
	DrawTextA("OrbMode: "..OrbWalker:GetMode(),12,12,48)
	DrawTextA("#minons"..#TargetSelector.Minions,12,12,60)
	DrawTextA("#jungle"..#TargetSelector.JungleMinions,12,12,72)

	for i = 1, myHero.buffCount do
		local tBuff = myHero:getBuff(i)
		if BuffIsValid(tBuff) then
			DrawTextA(tBuff.name,12,512,12*i)
		end
	end

	for i = 1, objManager.maxObjects do
		local object = objManager:GetObject(i)
		if object and object.valid and GetDistance(object) < 2000 and object.team == 300 then
			DrawText3D(object.name.." : "..object.type, object.x,object.y,object.z)
		end
	end
end

--[[
SRU_RiftHerald
SRU_Dragon
SRU_Baron
]]


-- Auto Updater--

function Update()
	if GetGameTimer() > 120 then printC("Game is already progressing, skipping Auto Update") return end

	local UpdateHost = "www.scarjit.de"
	local ServerPath = "/S1mpleScripts/Scripts/BolStudio/Syndra/"
	local ServerFileName = "S1mple_Syndra.lua"
	local ServerVersionFileName = "S1mple_Syndra.version"

	DL = Download()
	local ServerVersionDATA = GetWebResult("scarjit.de" , ServerPath..ServerVersionFileName)
	if ServerVersionDATA then
		local ServerVersion = tonumber(ServerVersionDATA)
		if ServerVersion then
			if ServerVersion > tonumber(Version) then
				printC("Updating, don't press F9")
				DL:newDL(UpdateHost, ServerPath..ServerFileName, ServerFileName, LIB_PATH, function ()
					printC("S1mple_Syndra updated, please reload")
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

-- Script starts here

function printC(arg)
	print('<font color=\"#515151\">S1mple_Syndra</font><font color=\"#000000\"> - </font><font color=\"#cccccc\">'..arg..'</font>')
end

function OnLoad()
	local t_start = os.clock()
	if AutoUpdate and GetInGameTimer() < 120 then
		Update()
	elseif GetInGameTimer() >= 120 and AutoUpdate then
		printC("Game already started, ignoring Updates")
	elseif not AutoUpdate and GetInGameTimer() < 120 then
		printC("Auto Update disabled")
	end
	Menu()
	OrbWalker = OrbWalker()
	Prediction = Prediction()
	TargetSelector = TargetSelector()
	SphereManager = SphereManager()
	Item = Item()
	AntiGapCloser = AntiGapCloser()
	Syndra = Syndra()
	if menu.adv.debug then
		local t_end = os.clock()
		printC("Loading took: "..t_end-t_start.." sec")
	end
	printC("Welcome " ..GetUser())
end

function Menu()
	menu = scriptConfig("S1mple_Syndra", "S1mple_Syndra")
	menu:addSubMenu("Advanced Settings", "adv")
		menu.adv:addParam("antigap", "Use Anti-Gapcloser", SCRIPT_PARAM_ONOFF, true)
		menu.adv:addParam("debug", "--Do not Press this Button--", SCRIPT_PARAM_ONOFF, false)
	menu:addSubMenu("Spell Settings", "spells")
		menu.spells:addSubMenu("Q", "q")
			menu.spells.q:addParam("autoQforQE", "Auto Q for QE Stun", SCRIPT_PARAM_ONOFF, true)

		menu.spells:addSubMenu("W", "w")
			menu.spells.w:addParam("usebeforeexpire","Auto Use before Sphere Expire", SCRIPT_PARAM_ONOFF, true)
			menu.spells.w:addParam("auto2ndW", "Auto 2nd W Cast", SCRIPT_PARAM_ONOFF, false)

		menu.spells:addSubMenu("E", "e")
			menu.spells.e:addParam("autostun", "Auto Stun", SCRIPT_PARAM_ONOFF, true)

		menu.spells:addSubMenu("R", "r")
			menu.spells.r:addParam("ks", "Use for Killsteal", SCRIPT_PARAM_ONOFF, true)
			menu.spells.r:addParam("block", "Block if not Killing (VIP)", SCRIPT_PARAM_ONOFF, true)

	menu:addSubMenu("Jungle Steal", "jng")
		menu.jng:addParam("blue", "Steal Blue", SCRIPT_PARAM_ONOFF, true)
		menu.jng:addParam("red", "Steal Red", SCRIPT_PARAM_ONOFF, false)
		menu.jng:addParam("gromp", "Steal Gromp", SCRIPT_PARAM_ONOFF, false)
		menu.jng:addParam("riftherald", "Steal Rift Herald", SCRIPT_PARAM_ONOFF, false)
		menu.jng:addParam("dragon", "Steal Dragon", SCRIPT_PARAM_ONOFF, true)
		menu.jng:addParam("baron", "Steal Baron", SCRIPT_PARAM_ONOFF, true)

	menu:addSubMenu("Laneclear Settings", "ls")
		menu.ls:addParam("q", "Use Q", SCRIPT_PARAM_ONOFF, true)
		menu.ls:addParam("w", "Use W", SCRIPT_PARAM_ONOFF, true)
		menu.ls:addParam("e", "Use E", SCRIPT_PARAM_ONOFF, false)
		menu.ls:addParam("jungle", "Attack Jungle", SCRIPT_PARAM_ONOFF, false)

	menu:addSubMenu("Harras Settings", "hs")
		menu.hs:addParam("q", "Use Q", SCRIPT_PARAM_ONOFF, true)
		menu.hs:addParam("w", "Use W", SCRIPT_PARAM_ONOFF, true)
		menu.hs:addParam("e", "Use E", SCRIPT_PARAM_ONOFF, true)

	menu:addSubMenu("Combo Mode", "c")
		menu.c:addParam("q", "Use Q", SCRIPT_PARAM_ONOFF, true)
		menu.c:addParam("w", "Use W", SCRIPT_PARAM_ONOFF, true)
		menu.c:addParam("e", "Use E", SCRIPT_PARAM_ONOFF, true)
		menu.c:addParam("r", "Use R", SCRIPT_PARAM_ONOFF, true)

	if not menu.keys then
		menu:addSubMenu("Keys", "keys")
	end
		menu.keys:addParam("harasstoggle", "Harass Toggle", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("N"))

	menu:addSubMenu("Draws", "draw")
		menu.draw:addParam("qrange", "Show Q Range", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("wrange", "Show W Range", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("erange", "Show E Range", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("rrange", "Show R Range", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("nspheres", "Show #Spheres in Range", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("sphereline", "Draw Line to Sphere", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("dmgdraw", "Draw Possible Damage", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("qestunline", "Draw QE Stun Line", SCRIPT_PARAM_ONOFF, true)

	sequences = {"QWE", "QEW", "WQE", "WEQ", "EQW", "EWQ"}
	menu:addParam("autolvl", "Auto Level (VIP)", SCRIPT_PARAM_ONOFF, false)
	menu:addParam("lvlseq", "Level Sequence: (1-3)", SCRIPT_PARAM_LIST , 1, sequences)

	menu:addParam("skin", "Skin Changer: (VIP)", SCRIPT_PARAM_ONOFF, false)
	menu:addParam("skinlist", "Skins: ", SCRIPT_PARAM_LIST, 1, {"Classic", "Justicar", "Atlantean", "Queen of Diamonds", "Snow Day"})
	menu:setCallback("skin", function (value)
		if value and VIP_USER then
			SetSkin(myHero, menu.skinlist-1)
		else
			SetSkin(myHero, -1)
		end
	end)
	menu:setCallback("skinlist", function (value)
		if menu.skin and VIP_USER then
			SetSkin(myHero, menu.skinlist-1)
		end
	end)

	if menu.skin and VIP_USER then
		SetSkin(myHero, menu.skinlist-1)
	end

	menu:addParam("version", "Version: ", SCRIPT_PARAM_INFO,Version)

end

function OnUnLoad()
	if menu.skin and VIP_USER then
		SetSkin(myHero, -1)
	end
end

function OnTick()
	if menu.autolvl and VIP_USER and GetHeroLeveled() < 3 then
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

--[[
Done:
Y	- Harass Toggle
Y	- Block R if not killing (menu)
Y	- R Overkill Check
Y	- Auto Level
Y	- Draw Options
Y	- Draw Number of Spheres in Range
Y	- Draw DamageBar
Y	- QE Stun Draw

Soon:
Y(targeted)	- Anti-Gapcloser (Q/E if possible)
	- Jungle Steal
	- Interrupter
	- Item Manager (Auto Zhonyas)
	- Grab big Minons if AA miss
50%	- Combo Mode
50%	- Harras Mode


https://github.com/spyk1/BoL/blob/master/BaguetteAnivia/BaguetteAnivia.lua#L1433

Credits to:
	HiranN
	Spyk
	Sonickid9
	timo62


]]