

--[[
	=============================
	Caitlyn
			Team Paradox
	=============================
	Recommended with:
	 - Evadeee 							by Weee
	 - Sida's Auto Carry: Reborn 		by Sida
	
	Requirements: 
	 - VPrediction
	 - SxOrbWalk (unless SAC:R is available)
	 
	=============================
			 Changelog
	=============================
	
	v0.01
	 
]]-- 

--DO NOT ENCRYPT THIS (Script Status)

--End ScriptStatus

--AutoUpdate--
local AutoUpdate = false --Don't want to autoupdate while writing the Script.

--Base Shell--
local scriptVersion = 0.01 
local StridePage = 'paradoxscripts.com'
local ScriptLink = '/Scripts/Caitlyn/Caitlyn.lua'
local VersionLink = '/Scripts/Caitlyn/CaitlynVersion.txt'

--In-game Variables--
local enemyhero = {}
local nextattacktime = 0
local enemyheroes = GetEnemyHeroes()
local ISCC = {
    ["UndyingRage"] = true,
	["aatroxqknockup"] = true,
	["ahriseducedoom"] = true,
	["powerfistslow"] = true,
	["braumstundebuff"] = true,
	["rupturetarget"] = true,
	["EliseHumanE"] = true,
	["Flee"] = true,
	["HowlingGaleSpell"] = true,
	["jarvanivdragonstrikeph2"] = true,
	["karmaspiritbindroot"] = true,	
	["LuxLightBindingMis"] = true,
	["lissandrawfrozen"] = true,
	["maokaiunstablegrowthroot"] = true,
	["DarkBindingMissile"] = true,
	["namiqdebuff"] = true,
	["nautilusanchordragroot"] = true,
	["RunePrison"] = true,
	["Taunt"] = true,
	["Stun"] = true,
	["swainshadowgrasproot"] = true,
	["threshqfakeknockup"] = true,
	["velkozestun"] = true,
	["virdrunkstun"] = true,
	["viktorgravitationfieldstun"] = true,
	["supression"] = true,
	["yasuoq3mis"] = true,
	["zyragraspingrootshold"] = true,
	["AatroxPassiveDeath"] = true,
	["FerociousHowl"] = true,
}

--Supported Lol Version (Packets)
supportedversion = "5.24.0.249"

--Prediction--
require("VPrediction") -- Still needs VPred, cause of the Minions function
VP = VPrediction()

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

--Orbwalker--
if not _G.UOLloaded then
  if FileExist(LIB_PATH .. "/UOL.lua") then
  	DelayAction(function ()
  		require("UOL")
  	end, 10)
  else 
    print("Downloading UOL, please don't press F9")
    DelayAction(function() DownloadFile("https://raw.github.com/nebelwolfi/BoL/master/Common/UOL.lua".."?rand="..math.random(1,10000), LIB_PATH.."UOL.lua", function () print("Successfully downloaded UOL. Press F9 twice.") end) end, 3) 
    return
  end
end


function OnLoad()
	printChat('Initializing auto-updater module...')
	if AutoUpdate then
		Update = Update()
	else
		printChat('Auto-update is disabled. Manually check the forum if you would like the updated version.')
		Compatibility()
	end
	Enemies()
	Minions = Minions()
	loadsprites()
end



function OnDraw()


end

function loadsprites()
	trapsprite = GetSprite("MetroSeries/Caitlyn/TrapMiniIcon.png")
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

function Compatibility()
	DelayAction(function()
		printChat('Please wait while we verify your prerequisites..')
	end, 1)
	if myHero.charName == 'Caitlyn' then --Temp SAC:R Check until SxOrb is updated and supports Caitlyn
		DelayAction(function()
			Champion = Caitlyn()
		end, 2)
	elseif myHero.charName ~= 'Caitlyn' then
		DelayAction(function()
			printChat('Sorry, it seems like you are not currently playing Caitlyn.')
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
    if self.NewVersion and self.NewVersion ~= scriptVersion then
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
function Spells:__init(slot, range, width, speed, delay, spellType, collision, key, trait, mincastdelay)
	self.slot = slot
	self.range = range
	self.width = width
	self.speed = speed
	self.delay = delay
	self.type = spellType
	self.collision = collision
	self.key = key
	self.trait = trait
	self.mincastdelay = mincastdelay or 0 --In Secounds
	self.lastcast = 0

	if not self.type == 'self' and not self.type == 'target' then
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
	if myHero:CanUseSpell(self.slot) == READY and self.lastcast+self.mincastdelay >= os.clock() then
		return true
	else
		return false
	end
end

function Spells:isHitChance(hs)
	if hs >= 1 then
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

	self.lastcast = os.clock()
end


class 'SelectTarget'
function SelectTarget()
	if not UOL then return nil end
    return UOL:GetTarget()
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

-- Caitlyn --
class 'Caitlyn'
function Caitlyn:__init()
	printChat(myHero.charName..' - the Sheriff of Piltover <font color=\"#808080\">v'..scriptVersion..'</font> loaded. Good luck!')
	
	self:Menu()
	self.spells = {
	--	Spells(slot, range, width, speed, delay, type, collision, key, trait)
		Q = Spells(_Q, 1250, 80, 2000, 1, "ss_line", false, "Q",0),
		W = Spells(_W, 800, 67.5, 0, 0, "target", false, "W",0, Menu.misc.human.trapdelay),
		E = Spells(_E, 950, 70, 1600, 0.25, "ss_line", true, "E",0),
		R = Spells(_R, 2000, 70, 1600, .5, "target", true, "R",0)
	}
	
	

	AddTickCallback(function () 
   		self:OnTick()  
 	end)
 	AddDrawCallback(function ()
 		self:OnDraw()
 	end)
 	AddCreateObjCallback(function (obj)
 		self:OnCreate(obj)
 	end)
 	AddDeleteObjCallback(function (obj)
 		self:OnDelete(obj)
 	end)
end

function Caitlyn:OnDraw()
	local function DrawCircleTarget(target, width, thickness, color)
		DrawCircle3D(target.x,target.y,target.z,width, thickness, color)
	end
	if Menu.draw.qrange then
		DrawCircleTarget(myHero, self.spells.Q.range, Menu.draw.qthick, ARGB(Menu.draw.qcolor[1],Menu.draw.qcolor[2],Menu.draw.qcolor[3],Menu.draw.qcolor[4]))
	end
	if Menu.draw.wrange then
		DrawCircleTarget(myHero, self.spells.W.range, Menu.draw.wthick, ARGB(Menu.draw.wcolor[1],Menu.draw.wcolor[2],Menu.draw.wcolor[3],Menu.draw.wcolor[4]))
	end
	if Menu.draw.erange then
		DrawCircleTarget(myHero, self.spells.E.range, Menu.draw.ethick, ARGB(Menu.draw.ecolor[1],Menu.draw.ecolor[2],Menu.draw.ecolor[3],Menu.draw.ecolor[4]))
	end
	if Menu.draw.rrange then
		DrawCircleTarget(myHero, self.spells.R.range, Menu.draw.rthick, ARGB(Menu.draw.rcolor[1],Menu.draw.rcolor[2],Menu.draw.rcolor[3],Menu.draw.rcolor[4]))
	end

	if target and Menu.draw.target then
		DrawCircleTarget(target, 50,5, ARGB(255,255,255,255))
	end

	if Menu.draw.tom then
		for k, v in pairs(traps) do
			if v and v.valid then
			local x,y = GetMinimapX(v.pos.x), GetMinimapY(v.pos.z)
				if x and y then
					trapsprite:SetScale(0.47,0.47)
					trapsprite:Draw(x-13, y-11, 0xFF)
				end
			end
		end
	end
end

function Caitlyn:OnCreate(obj)
	if obj and obj.valid then
		if obj.name == "caitlyn_Base_yordleTrap_idle_green.troy" or obj.name == "caitlyn_Base_yordleTrap_idle_green_inBrush.troy" then
			self:traptracker(obj, "add")
		end
	end
end

function Caitlyn:OnDelete(obj)
	if obj and obj.valid then
		if obj.name == "caitlyn_Base_yordleTrap_idle_green.troy" or obj.name == "caitlyn_Base_yordleTrap_idle_green_inBrush.troy" then
			self:traptracker(obj, "del")
		end
	end
end

function Caitlyn:OnTick()
	target = SelectTarget()
	if target and IsOnCC(target) and self.spells.W:isReady() and Menu.misc.autotrap then 
		self.spells.W:Cast(target)     
	end

	local orbmode
	if not UOL then 
		orbmode = ""
	else
		orbmode = UOL:GetOrbWalkMode()
	end

	if orbmode == "Harras" then
		self:Harass()
	end
	if orbmode == "LaneClear" then
		self:Clear()
	end
	if orbmode == "LastHit" then
		self:Lasthit()
	end
	if orbmode == "Combo" then
		self:Combo()
	end
end

traps = {}
function Caitlyn:traptracker(obj, _type)
	if _type == "add" then
		traps[#traps+1] = obj
	elseif _type == "del" then
		for k, v in pairs(traps) do
			if v.networkID == obj.networkID then
				table.remove(traps, k)
			end
		end
	end
end

function IsOnCC(target)
	assert(type(target) == 'userdata', "IsOnCC: Wrong type. Expected userdata got: "..tostring(type(target)))
	for i = 1, target.buffCount do
		tBuff = target:getBuff(i)
		if BuffIsValid(tBuff) and ISCC[tBuff.name] then
			return true
		end	
	end
	return false
end

function Caitlyn:Combo()

end

function Caitlyn:Lasthit()

end

function Caitlyn:Clear()

end

function Caitlyn:Harass()
	
end

function Caitlyn:EnemyCount(dist)
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



--[[function Caitlyn:Minions()
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

--New Caitlyn:Minons()

function Caitlyn:Minions()

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


function Caitlyn:Health(amount)
	if amount >= (myHero.health/myHero.maxHealth) * 100 then
		return true
	else
		return false
	end
end

function Caitlyn:Mana(amt)
	if amt <= (myHero.mana/myHero.maxMana) * 100 then
		return true
	else
		return false
	end
end

function Caitlyn:Menu()
	Menu = scriptConfig(myHero.charName.."Whitty Name", 'Caitlyn')	
	---
	Menu:addSubMenu('Drawings', 'draw')
		Menu.draw:addParam('target', 'Highlight Focused Target', SCRIPT_PARAM_ONOFF, true)
		Menu.draw:addParam('qrange', 'Q Range', SCRIPT_PARAM_ONOFF, true)
		Menu.draw:addParam('wrange', 'W Range', SCRIPT_PARAM_ONOFF, true)
		Menu.draw:addParam('erange', 'E Range', SCRIPT_PARAM_ONOFF, true)
		Menu.draw:addParam('rrange', 'R Range', SCRIPT_PARAM_ONOFF, true)
		Menu.draw:addParam("space1", "--Color Settings--", SCRIPT_PARAM_INFO, "")
		Menu.draw:addParam("qcolor", "Q Color", SCRIPT_PARAM_COLOR, {255,255,255,255})
		Menu.draw:addParam("wcolor", "W Color", SCRIPT_PARAM_COLOR, {255,255,255,255})
		Menu.draw:addParam("ecolor", "E Color", SCRIPT_PARAM_COLOR, {255,255,255,255})
		Menu.draw:addParam("rcolor", "R Color", SCRIPT_PARAM_COLOR, {255,255,255,255})
		Menu.draw:addParam("space2", "--Thickness Settings--", SCRIPT_PARAM_INFO, "")
		Menu.draw:addParam("qthick", "Q Thickness", SCRIPT_PARAM_SLICE, 2,1,5)
		Menu.draw:addParam("wthick", "W Thickness", SCRIPT_PARAM_SLICE, 2,1,5)
		Menu.draw:addParam("ethick", "E Thickness", SCRIPT_PARAM_SLICE, 2,1,5)
		Menu.draw:addParam("rthick", "R Thickness", SCRIPT_PARAM_SLICE, 2,1,5)
		Menu.draw:addParam("space3", "--Trap Settings--", SCRIPT_PARAM_INFO, "")
		Menu.draw:addParam("tom", "Show Traps on the Minimap", SCRIPT_PARAM_ONOFF, true)


	---
	Menu:addSubMenu('Combo', 'combo')
		Menu.combo:addSubMenu('Q Settings', 'q')
			Menu.combo.q:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			Menu.combo.q:addParam('manaq', 'Use Q when mana >', SCRIPT_PARAM_SLICE, 10, 0, 100, 0)
			Menu.combo.q:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			Menu.combo.q:addParam('useq2', 'Q usage mode (1v1)', SCRIPT_PARAM_SLICE, 1, 0, 1, 0)
			Menu.combo.q:addParam("Buffer", "0 - Off", SCRIPT_PARAM_INFO, "")
			Menu.combo.q:addParam("Buffer", "1 - Whenever ready", SCRIPT_PARAM_INFO, "")
			Menu.combo.q:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			Menu.combo.q:addParam('useq1', 'Q usage mode (Teamfight)', SCRIPT_PARAM_SLICE, 2, 0, 2, 0)
			Menu.combo.q:addParam("Buffer", "0 - Off", SCRIPT_PARAM_INFO, "")
			Menu.combo.q:addParam("Buffer", "1 - When hit > 2 targets", SCRIPT_PARAM_INFO, "")
			Menu.combo.q:addParam("Buffer", "2 - Smart usage", SCRIPT_PARAM_INFO, "")
			Menu.combo.q:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
		Menu.combo:addSubMenu('W Settings', 'w')
			Menu.combo.w:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			Menu.combo.w:addParam('manaw', 'Use W when mana >', SCRIPT_PARAM_SLICE, 10, 0, 100, 0)
			Menu.combo.w:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			Menu.combo.w:addParam('usew2', 'W usage mode (1v1)', SCRIPT_PARAM_SLICE, 3, 0, 3, 0)
			Menu.combo.w:addParam("Buffer", "0 - Off", SCRIPT_PARAM_INFO, "")
			Menu.combo.w:addParam("Buffer", "1 - Whenever ready", SCRIPT_PARAM_INFO, "")
			Menu.combo.w:addParam("Buffer", "2 - When Enemy CCed", SCRIPT_PARAM_INFO, "")
			Menu.combo.w:addParam("Buffer", "3 - Smart", SCRIPT_PARAM_INFO, "")
			Menu.combo.w:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
		Menu.combo:addSubMenu('E Settings', 'e')
			Menu.combo.e:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			Menu.combo.e:addParam('manae', 'Use E when mana >', SCRIPT_PARAM_SLICE, 10, 0, 100, 0)
			Menu.combo.e:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			Menu.combo.e:addParam('usee1', 'E usage mode', SCRIPT_PARAM_SLICE, 1, 0, 2, 0)
			Menu.combo.e:addParam("Buffer", "0 - Off", SCRIPT_PARAM_INFO, "")
			Menu.combo.e:addParam("Buffer", "1 - Use at short range", SCRIPT_PARAM_INFO, "")
			Menu.combo.e:addParam("Buffer", "2 - Whenever ready", SCRIPT_PARAM_INFO, "")
			Menu.combo.e:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
		Menu.combo:addSubMenu('R Settings', 'r')
			Menu.combo.r:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			Menu.combo.r:addParam('rassist', 'Ult Assist', SCRIPT_PARAM_ONOFF, true)
	---
	Menu:addSubMenu('Harass', 'harass')
		Menu.harass:addSubMenu('Q Settings', 'q')
			Menu.harass.q:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			Menu.harass.q:addParam('harassq', 'Use Q', SCRIPT_PARAM_ONOFF, true)
		Menu.harass:addSubMenu('W Settings', 'w')
			Menu.harass.w:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
			Menu.harass.w:addParam('harassw', 'Use W', SCRIPT_PARAM_ONOFF, true)
		Menu.harass:addSubMenu('E Settings', 'e')
			Menu.harass.e:addParam('harasse', 'Use E', SCRIPT_PARAM_ONOFF, true)
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
		Menu.farm:addSubMenu('e Settings', 'e')
		Menu.farm.e:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
		Menu.farm.e:addParam('manaw', 'Use W when mana >', SCRIPT_PARAM_SLICE, 30, 0, 100, 0)
		Menu.farm.e:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")

	---
	Menu:addSubMenu('MISC', 'misc')
		Menu.misc:addSubMenu('AutoTrap', 'autotrap')
		Menu.misc.autotrap:addParam('enabletrap', 'Use Auto Trap', SCRIPT_PARAM_ONOFF, true)
		Menu.misc:addSubMenu('Humanizer', 'human')
		Menu.misc.human:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
		Menu.misc.human:addParam('trapdelay', 'Trap Delay', SCRIPT_PARAM_SLICE, 500, 0, 2000, 0)
		--Adding Change Callback to trapdelay, to prevent use from having to 2xF9
		Menu.misc.human:setCallback('trapdelay', function ()
			self.spells.W = Spells(_W, 600, 220, 0, 0, "target", false, "W",0, Menu.misc.human.trapdelay)
		end)
		Menu.misc.human:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
		
	Menu:addParam("Buffer", "", SCRIPT_PARAM_INFO, "")
	Menu:addParam("ScriptAuthor", "Metro Series - "..myHero.charName, SCRIPT_PARAM_INFO, "")
	Menu:addParam("Version", "Version "..scriptVersion, SCRIPT_PARAM_INFO, "")
	

	--Add UPL to Menu--
	UPL:AddToMenu2(Menu)

	--Add UOL to Menu--
	Menu:addSubMenu("Orbwalker", "orb")
	DelayAction(function ()
		UOL:AddToMenu(Menu.orb)
	end, 10)
end
-------------