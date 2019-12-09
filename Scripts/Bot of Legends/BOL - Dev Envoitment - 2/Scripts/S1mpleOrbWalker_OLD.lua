assert(load(Base64Decode("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"), nil, "bt", _ENV))() ScriptStatus("XKNOMRRNKMJ") 

class 'S1mpleOrbWalker' 
function S1mpleOrbWalker:__init()
	require("VPrediction")
	VPred = VPrediction()
	--AutoUpdater
	self.version = 0.3
	host = "www.scarjit.de"
	file = "/S1mpleScripts/Scripts/BolStudio/OrbWalker/S1mpleOrbWalker.lua"
	name = "S1mpleOrbWalker.lua"
	DL = Download()

	local ServerVersionDATA = GetWebResult("scarjit.de" , "/S1mpleScripts/Scripts/BolStudio/OrbWalker/S1mpleOrbWalker.version")
	if ServerVersionDATA then
		local ServerVersion = tonumber(ServerVersionDATA)
		if ServerVersion then
			if ServerVersion > tonumber(self.version) then
				print("Updating, don't press F9"..ServerVersion..self.version)
				DL:newDL(host,file, name, LIB_PATH)
			end
		else
			print("An error occured, while updating, please reload")
		end
	else
		print("Could not connect to update Server")
	end

	--External
	_G.S1OrbLoaded = true

	--Internal
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
	self.loaded = true
	self:addTowers()
end

function S1mpleOrbWalker:OnDraw()
	if not self.menu then return end
	targets = self:GetMinions(self.aarange)
	if self.menu.orb.adv.debug then
		DrawTextA("os.clock: "..os.clock(),18,20,0)
		DrawTextA("aamode: "..self.aamode,18,20,20)
		DrawTextA("armor: "..myHero.armor,18,20,140)
		DrawTextA("armorPenPercent: "..myHero.armorPenPercent,18,20,160)
		DrawTextA("armorPen: "..myHero.armorPen,18,20,180)
		DrawTextA("lastmove: "..self.lastmove,18,20,220)
		DrawTextA("canMove: "..tostring(self:CanMove()),18,20,240)

		for _, v in pairs(targets) do
			DrawText3D(v.health.." : "..self:RealADDamage(v, myHero, {name = "Basic"}, 0),v.x,v.y,v.z)
		end
	end

	if self.aamode == "none" or self.aamode == "sbtw" then return end
	for _, v in pairs(targets) do
		local hpp = v.health/v.maxHealth*100
		local dmg = self:RealADDamage(v, myHero, {name = "Basic"}, 0)
		if dmg > v.health and self.menu.orb.draw.killable then
			DrawCircle3D(v.x,v.y,v.z,30, 3, ARGB(255,255-25.5*hpp,255,25.5*hpp))
		elseif dmg*3 > v.health and self.menu.orb.draw.soon then
			DrawCircle3D(v.x,v.y,v.z,30, 1, ARGB(150,255-25.5*hpp,255,25.5*hpp))
		end

	end	
end

function S1mpleOrbWalker:OnAnimation(unit, animation)
	if not self.menu then return end
	if unit.isMe and animation:find("Attack") then

		local spellProc = unit.spell
		self.windUpTime = spellProc.windUpTime

		self.lastAttack = GetTickCount() - GetLatency() * 0.5
		self.lastWindUpTime = unit.spell.windUpTime * 1000
		self.lastAttackCD = unit.spell.animationTime * 1000
		
	end
end

function S1mpleOrbWalker:setAttackMode(mode)
	if not self.loaded then return end
	if not mode or type(mode) ~= "string" then
		self.aamode = "none"
	else
		self.aamode = mode
	end
end

function S1mpleOrbWalker:GetLatency() --In millisec
	return GetLatency() / 2000
end

function S1mpleOrbWalker:setOrbMode(mode)
	if not mode then 
		self.aamode = "none"
		return
	end
	self.aamode = mode
end

function S1mpleOrbWalker:CanMove() --Thanks to Bilbao for this Function
	return (GetTickCount() + GetLatency() * 0.5 > self.lastAttack + self.lastWindUpTime + 20) and (self.lastmove+self.menu.orb.human.moveorderdelay < os.clock())
end

function S1mpleOrbWalker:timeToShoot()
	return (GetTickCount() + GetLatency() * 0.5 > self.lastAttack + self.lastAttackCD)
end

function S1mpleOrbWalker:Move()
	if not self:CanMove() then return end
	if self.aamode == "none" then return end
	if GetDistance(myHero, mousePos) < 200 then return end
	self.lastmove = os.clock()
	myHero:MoveTo(mousePos.x, mousePos.z)
end

function S1mpleOrbWalker:EnemysInRange(range)
	local enemys = self:GetMinions(range)
	local champs = self:GetChampions(range)
	for _,v in pairs(champs) do
		enemys[#enemys+1] = v
	end
	return #enemys
end

function S1mpleOrbWalker:PredictHealth(object, time)
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

function S1mpleOrbWalker:RealADDamage(target, source, spell, additionalDamage)
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



function S1mpleOrbWalker:GetMinions(range)
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
		
function S1mpleOrbWalker:GetChampions(range)
	local Champions = GetEnemyHeroes()
	local ChampInRange = {}
	for _,v in pairs(Champions) do
		if GetDistance(v) < range and ValidTarget(v) then
			ChampInRange[#ChampInRange] = v
		end
	end	
	return ChampInRange
end
	
function S1mpleOrbWalker:GetMinionTarget()
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
	
function S1mpleOrbWalker:GetChampionTarget()
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

function S1mpleOrbWalker:GetAATargets()
	if self.aamode == "none" then return nil end

	local target = nil
	if self.aamode == "laneclear" then
		target = self:GetMinionTarget()
		if not target and self.menu.orb.adv.orbTower then
			local t = nil
			for _, v in pairs(self.Towers) do
				if v and not v.dead then
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
		if self.isEmpoweredShoot then
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
	if self.aamode == "sbtw" then
		target = self:GetChampionTarget()
	end
	return target
end

function S1mpleOrbWalker:ProgressAA(target)
	if target then
		DelayAction(function ()
			myHero:Attack(target)
		end,self.menu.orb.human.aadelay/1000)
	end
end

function S1mpleOrbWalker:MoF()
	if not self.menu then return end
	local target = self:GetAATargets()
	if target then
		if self:timeToShoot() then
			self:ProgressAA(target)
		elseif self:CanMove() then
			self:Move()
		end
	else
		self:Move()
	end
end

function S1mpleOrbWalker:addTowers()
	--self.Towers
	for i = 1, objManager.maxObjects, 1 do
        local object = objManager:getObject(i)
        if object and (object.type == "obj_AI_Turret" or object.type == "obj_HQ" or object.type == "obj_BarracksDampener") and object.team ~= player.team then
        	self.Towers[#self.Towers+1] = object
        end
    end
end

function S1mpleOrbWalker:SetOrbMode()
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


function S1mpleOrbWalker:AddToMenu(Menu)
	self.menu = Menu

	self.menu:addSubMenu('OrbWalker', 'orb')
	self.menu.orb:addParam('HarrasKey', 'Harras Key', SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
	self.menu.orb:addParam('LaneClearKey', 'Laneclear Key', SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
	self.menu.orb:addParam('LastHitKey', 'LastHit Key', SCRIPT_PARAM_ONKEYDOWN, false, string.byte("X"))
	self.menu.orb:addParam('SBTWKey', 'SBTW Key', SCRIPT_PARAM_ONKEYDOWN, false, string.byte(" "))

	self.menu.orb:addSubMenu('Advanced', 'adv')
	self.menu.orb.adv:addParam("orbTower", "OrbWalk Towers (Laneclear)", SCRIPT_PARAM_ONOFF, true)
	self.menu.orb.adv:addParam("dmgbuff","Health Buffer %",SCRIPT_PARAM_SLICE, 0,0,10,1)
	self.menu.orb.adv:addParam("healtpred", "Use Health Prediction", SCRIPT_PARAM_ONOFF, false)
	self.menu.orb.adv:addParam("debug", "Show the Magic", SCRIPT_PARAM_ONOFF, false)

	self.menu.orb:addSubMenu('Humanizer', 'human')
	self.menu.orb.human:addParam("moveorderdelay", "Next Move Order Delay", SCRIPT_PARAM_SLICE, 0.25, 0, 2, 1)
	self.menu.orb.human:addParam("inf", "Values > 1 or < 0.1 are not recommended", SCRIPT_PARAM_INFO, "")
	self.menu.orb.human:addParam("spacer", " ", SCRIPT_PARAM_INFO, "")
	self.menu.orb.human:addParam("aadelay", "Auto-Attack Delay", SCRIPT_PARAM_SLICE, 20,0,400,1)
	self.menu.orb.human:addParam("inf", "Values > 300 or < 20 are not recommended", SCRIPT_PARAM_INFO, "")
	self.menu.orb.human:addParam("spacer", " ", SCRIPT_PARAM_INFO, "")
	
	self.menu.orb:addSubMenu('Draws', 'draw')
	self.menu.orb.draw:addParam("killable", "Draw Killable Minions", SCRIPT_PARAM_ONOFF, true)
	self.menu.orb.draw:addParam("soon", "Draw Nearly Killable Minions", SCRIPT_PARAM_ONOFF, true)
end

class "Download"
function Download:__init()
	self.aktivedownloads = {}
	self.callbacks = {}

	AddTickCallback(function ()
		self:RemoveDone()
	end)

	class "AsyncDL"
	function AsyncDL:__init(host, file, name,offset, path)
		self.Data = ''
		self.host = host
		self.file = file
		self.name = name
		self.size = 0
		self.path = path
		self.offset = offset
		self.percentage = 0
		self.socket = require("socket")
		self.tcp = self.socket.tcp()
		self.tcp:settimeout(99999,'b')
		self.tcp:settimeout(9999999,'t')
		self.tcp:connect(self.host, 80)
		self.writentofile = false
		self:download()
		AddDrawCallback(function ()
			self:Draw()
		end)
		AddTickCallback(function ()
			self:Tick()
		end)
	end

	function AsyncDL:download()
		local CRLF = '\r\n';
		self.tcp:send('GET '..self.file..' HTTP/1.1'.. CRLF ..'Host: '..self.host.. CRLF ..'User-Agent: Bot of Legends 1.0'.. CRLF .. CRLF)
	end

	function AsyncDL:Draw()
		if self.Data and self.size then
			if self.percentage ~= 100 then
				DrawTextA("Updating: "..self.name,15,50,35+self.offset,ARGB(255,255-2.5*self.percentage,2.5*self.percentage,0))
				DrawRectangleOutline(49,50+self.offset,152,20, ARGB(255,255,255,255),1)
				DrawLine(50,60+self.offset,50+(1.5*self.percentage),60+self.offset,18,ARGB(150,255,255,255))
			else
				DrawTextA("Updated: "..self.name,18,50,35+self.offset,ARGB(255,255,255,255))
			end

			--DrawTextA(self.Data)
		end
	end

	function AsyncDL:Tick()
		if self.cStatus ~= 'timeout' then
			self.fString, self.cStatus, self.pString = self.tcp:receive(1024);
		end
		if ((self.fString) or (#self.pString > 0)) then
			self.Data = self.Data .. (self.fString or self.pString)
		end

		if self.cStatus == 'closed' and self.writentofile == false then
			self.writentofile = true
			local file = io.open(self.path.."\\"..self.name, "w+b")
			if self.l then
				file:write(string.sub(self.Data,self.l+1))
			else
				local begins = string.find(self.Data, "Length: .+")
				local ends = string.find(self.Data, "Connection")
				local sizeraw = tonumber(string.sub(self.Data, begins+string.len("Length: "), ends-1))
				local beginx = string.find(self.Data, "Type: .+\n")
				local endx = string.find(string.sub(self.Data,beginx,beginx+20),"\n")
				self.l = string.sub(self.Data,0,beginx+endx):len()+1
				self.size = sizeraw+self.l
				self.percentage = (#self.Data/self.size)*100
				file:write(string.sub(self.Data,self.l+1))
			end
			file:close()
			self.tcp:close()
		end

		if self.Data then
			local begins = string.find(self.Data, "Length: .+")
			local ends = string.find(self.Data, "Connection")
			local sizeraw = tonumber(string.sub(self.Data, begins+string.len("Length: "), ends-1))
			local beginx = string.find(self.Data, "Type: .+\n")
			local endx = string.find(string.sub(self.Data,beginx,beginx+20),"\n")
			self.l = string.sub(self.Data,0,beginx+endx):len()+1
			self.size = sizeraw+self.l
			self.percentage = (#self.Data/self.size)*100
		end
	end
end

function Download:newDL(host, file, name, path, callback)
	local offset = (#self.aktivedownloads)*40
	self.aktivedownloads[#self.aktivedownloads+1] = AsyncDL(host, file, name, offset, path)
	if not callcack then
		callback = (function ()
		end)
	end

	self.callbacks[#self.callbacks+1] = callback

end

function Download:RemoveDone()
	if #self.aktivedownloads == 0 then return end
	local x = {}
	for k, v in pairs(self.aktivedownloads) do
		if v.percentage ~= 100 then
			x[#x+1] = v
		else
			print(type(self.callbacks[k]))
		end
	end
	self.aktivedownloads = {}
	self.aktivedownloads = x
end

