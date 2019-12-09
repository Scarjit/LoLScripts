local common = {}
local string, game, setmetatable, math, objmanager, myHero, print, tostring, type, enum= string, game, setmetatable, math, objmanager, objmanager.player, print, tostring, type, enum

function common.GetDistanceSqr(p1,p2)
    if(not p1 or not p2)then 
        return math.huge 
    end 
    local xSqr = (p1.x - p2.x) * (p1.x - p2.x)
    local ySqr = (p1.y - p2.y) * (p1.y - p2.y)
    local zSqr = (p1.z - p2.z) * (p1.z - p2.z)
    return xSqr + ySqr + zSqr
end

function common.GetDistance(p1,p2)
    return math.sqrt(common.GetDistanceSqr(p1,p2))
end

function common.DamageReduction(target)
    return 100 / (100 + ((target.bonusArmor + target.armor) * myHero.armorPenMod) - myHero.lethality)
end

function common.CanUseSpell(slot)
	-- Add mana checks
	-- and (myHero.mana >= myHero:spellslotcast(slot).mana)
	local ccFree = true
	local buffmanager = myHero.buffmanager
	for i = 0, buffmanager.count - 1 do
		local buff = buffmanager:get(i)
		if buff and buff.valid and buff.endTime < game.time and buff.startTime > game.time then
			local bt = buff.type
			ccFree = (bt ~= 5) and (bt ~= 7) and (bt ~= 8) and (bt ~= 21) and (bt ~= 22) and (bt ~= 24) and (bt ~= 29)
		end
	end 
	return ccFree and (myHero:spellslotcast(slot).state == 0)
end

function common.GetEnemyHeroesInRange (range, pos)
    local pos = pos or myHero
    local h = {}
	for i=1, #common.GetEnemyHeroes() do
		local hero = common.GetEnemyHeroes()[i]
        if(common.IsValidTarget(hero) and common.GetDistance(pos, hero) < range)then
            h[#h+1] = hero
        end
    end
    return h
end

function common.GetMinionsInRange (range, team)
    range = range or math.huge
    team = team or enum.team.enemy
    
    local minions = {}
    for i=0,objmanager.maxObjects - 1 do
        local obj = objmanager.get(i)
        if(obj and obj.type == enum.type.minion and obj.team == team and common.GetDistance(obj, myHero) < range)then
            minions[#minions+1] = obj
        end
    end
    return minions
end

common._enemyHeroes = nil
function common.GetEnemyHeroes ()
    if common._enemyHeroes then return common._enemyHeroes end
	common._enemyHeroes = {}
	for i=0, objmanager.maxObjects - 1 do
		local obj = objmanager.get(i)
		if(obj and obj.type == myHero.type and obj.team ~= myHero.team)then
			common._enemyHeroes[#common._enemyHeroes+1] = obj
		end
	end
    return common._enemyHeroes
end

common._allyHeroes = nil
function common.GetAllyHeroes ()
    if common._allyHeroes then return common._allyHeroes end
	common._allyHeroes = {}
	for i=0, objmanager.maxObjects - 1 do
		local obj = objmanager.get(i)
		if(obj and obj.type == myHero.type and obj.team == myHero.team and obj.networkID ~= myHero.networkID)then
			common._allyHeroes[#common._allyHeroes+1] = obj
		end
	end
    return common._allyHeroes
end

function common.IsValidTarget(object)
	return object and not object.isDead and not object.isInvulnerable and object.isTargetable --and object.visible
end

function common.IsRecalling(object) --Maybe change this to a callback based function
    local buffmanager = object.buffmanager
    for i=0,buffmanager.count-1 do
        local buff = buffmanager:get(i)
        if(buff and buff.valid and buff.endTime < game.time and buff.startTime > game.time)then
            if(string.match(buff.name, "recall"))then
                return true
            end
        end
    end
    return false
end

common._enemyTowers = nil
function common.GetEnemyTowers ()
    if common._enemyTowers then return common._enemyTowers end
	common._enemyTowers = {}
	for i=0, objmanager.maxObjects - 1 do
		local obj = objmanager.get(i)
		if(obj and obj.class:lower():find("turret")) then
			local tower = objmanager.tominion(obj)
			if (tower.team == enum.team.enemy and tower.health > 0)then
				common._enemyTowers[#common._enemyTowers+1] = tower
			end
		end
	end
    return common._enemyTowers
end

common._fountain = nil
common._fountainRadius = 750
function common.GetFountain()
    if(common._fountain) then
        return common._fountain
    end
	
    local map = common.GetMap() 
    if(map ~= nil and map.index ~= nil and map.index == 1)then 
        common._fountainRadius = 1050
    end
    
    if(common.GetShop())then
        for i=0, objmanager.maxObjects - 1 do
            local object = objmanager.get(i)
            if(object and object.team == myHero.team and object.name:lower():find("spawn") and not object.name:lower():find("troy") and not object.name:lower():find("barracks")) then 
                common._fountain = object
                return common._fountain
            end
        end
    end
end

function common.NearFountain(distance)
    distance = distance or common._fountainRadius or 0
    local fountain = common.GetFountain()
	if fountain then
		return (common.GetDistanceSqr(myHero, fountain) <= distance * distance), fountain.x, fountain.y, fountain.z, distance 
	else
		return false, 0, 0, 0, 0
	end
end

function common.InFountain()
    return common.NearFountain()
end

common._map = { index = 0, name = "unknown"}
function common.GetMap()
    if(common._map.index ~= 0)then
        return common._map
    end
	
    local obj = common.GetShop() 
    if math.floor(obj.x) == 232 and math.floor(obj.y) == 163 and math.floor(obj.z) == 1277 then 
        common._map = { index = 1, name = "Summoner's Rift"} 
        --[[ 
    elseif math.floor(obj.x) == -217 and math.floor(obj.y) == 276 and math.floor(obj.z) == 7039 then --TODO UPDATE 
        common._map = { index = 4, name = "The Twisted Treeline"} 
    elseif math.floor(obj.x) == 556 and math.floor(obj.y) == 191 and math.floor(obj.z) == 1887 then --TODO UPDATE 
        common._map = { index = 7, name = "The Proving Grounds"} 
    elseif math.floor(obj.x) == 16 and math.floor(obj.y) == 168 and math.floor(obj.z) == 4452 then --TODO UPDATE 
        common._map = { index = 8, name = "The Crystal Scar"} 
    elseif math.floor(obj.x) == 1313 and math.floor(obj.y) == 123 and math.floor(obj.z) == 8005 then --TODO UPDATE 
        common._map = { index = 10, name = "The Twisted Treeline Beta"} 
    elseif math.floor(obj.x) == 497 and math.floor(obj.y) == -40 and math.floor(obj.z) == 1932 then --TODO UPDATE 
        common._map = { index = 12, name = "Howling Abyss"} 
        ]]-- 
    else 
        print("Unknown Map! Shop: x:" .. tostring(math.floor(obj.x)).. " y:" .. tostring(math.floor(obj.y)).. " z:" .. tostring(math.floor(obj.z)))         
    end 
    
    return common._map
end

common._shop = nil
common._shopRadius = 1250
function common.GetShop()
	if common._shop then 
        return common._shop 
    end 
    for i = 0, objmanager.maxObjects - 1 do
        local object = objmanager.get(i) 
        if object and object.name and string.find(object.name:lower(), "shop") ~= nil and object.team == myHero.team then 
            common._shop = object
            return common._shop
        end
    end
	return nil
end

--Simple metatable based class
function common.Class(base, init)
   local c = {}
   if not init and type(base) == 'function' then
      init = base
      base = nil
   elseif type(base) == 'table' then
      for i,v in pairs(base) do
         c[i] = v
      end
      c._base = base
   end
   c.__index = c
   local mt = {}
   mt.__call = function(class_tbl, ...)
   local obj = {}
   setmetatable(obj,c)
   if init then
      init(obj,...)
   else 
      if base and base.init then
      base.init(obj, ...)
      end
   end
   return obj
   end
   c.init = init
   c.is_a = function(self, klass)
      local m = getmetatable(self)
      while m do 
         if m == klass then return true end
         m = m._base
      end
      return false
   end
   setmetatable(c, mt)
   return c
end

return common