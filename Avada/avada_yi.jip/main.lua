local alib = loadmodule("avada_lib")
local common = alib.common

local myHero = objmanager.player
local enemies = common.GetEnemyHeroes()

-- local smiteSlot = nil
-- local smiteDmg = { 390, 410, 430, 450, 480, 510, 540, 570, 600, 640, 680, 720, 760, 800, 850, 900, 950, 1000 }
-- if myHero:spellslotcast(4).data.name == "SummonerSmite" or myHero:spellslotcast(4).data.name == "S5_SummonerSmitePlayerGanker" or myHero:spellslotcast(4).data.name == "S5_SummonerSmiteDuel" then
	-- smiteSlot = 4
-- elseif myHero:spellslotcast(5).data.name == "SummonerSmite" or myHero:spellslotcast(5).data.name == "S5_SummonerSmitePlayerGanker" or myHero:spellslotcast(5).data.name == "S5_SummonerSmiteDuel" then
	-- smiteSlot = 5
-- end

local spellsToDodge = {
	{name = "Aatrox", spells = {
		{ slot = 0, delay = 0 }, -- Jump
		{ slot = 2, delay = 0 }  -- Blade
	}},
	{name = "Soraka", spells = {
		{ slot = 0, delay = 0 },
		{ slot = 2, delay = 0 }
	}}
}

-- local function AutoSmite()
	-- if not myHero.isDead and smiteSlot and common.CanUseSpell(smiteSlot) then
		-- for i = 0, objmanager.maxObjects - 1 do
			-- local obj = objmanager.get(i)
			-- if common.IsValidTarget(obj) and obj.type == enum.type.minion and obj.team == enum.team.neutral and draw.GetDistance(obj, myHero) < 560 and obj.health <= smiteDmg[myHero.level] then
				-- if obj.charName == "SRU_Baron" or obj.charName == "SRU_Dragon_Water" or obj.charName == "SRU_Dragon_Fire" or obj.charName == "SRU_Dragon_Earth" or obj.charName == "SRU_Dragon_Air" or obj.charName == "SRU_Dragon_Elder" or obj.charName == "SRU_RiftHerald" then
					-- game.cast("obj", smiteSlot, obj)
				-- end
			-- end
		-- end
	-- end
-- end

local function CastQDodge()
	local target = nil
	local bestchamp = { hero = nil, health = math.huge, maxHealth = math.huge }
	if #enemies > 0 then
		for i = 1, #enemies do
			local hero = enemies[i]
			if common.IsValidTarget(hero) and hero.isVisible and draw.GetDistance(myHero, hero) <= 600 then
				if hero.maxHealth < bestchamp.maxHealth then
					bestchamp.hero = hero
					bestchamp.health = hero.health
					bestchamp.maxHealth = hero.maxHealth
				end
			end
		end
		target = bestchamp.hero
	end
	if target then
		local enemiesInRange = {}
		for i = 1, #enemies do
			local hero = enemies[i]
			if hero ~= target and common.IsValidTarget(hero) and draw.GetDistance(target, hero) < 1000 then
				enemiesInRange[#enemiesInRange + 1] = hero
			end
		end
		if #enemiesInRange > 1 then
			local minions = common.GetMinionsInRange(100)
			if #minions > 0 then
				target = minions[1]
			end
		end
	else
		local minions = common.GetMinionsInRange(600)
		if #minions > 0 then
			target = minions[1]
		end
	end
	if target then
		game.cast("obj", 0, target)
		print("casted on "..target.charName)
	else
		game.cast("self", 1)
		print("casted W")
	end
end

local function Dodge(spell)
	if common.CanUseSpell(0) and spell and spell.owner and spell.owner.team == enum.team.enemy and not spell.isBasicAttack then
		print("Enemy spell casted !")
		if spell.target and spell.target == myHero then
			print("You're the target")
			CastQDodge()
		else
			print("You're not the target")
			if draw.GetDistance(myHero, spell.endPos) <= 300 then
				print("But you're near end pos so let's dodge it !")
				CastQDodge()
			end
		end
	end
end

local function OnTick()
	-- AutoSmite()
end

local function OnProcessSpell(spell)
	Dodge(spell)
end

callback.add(enum.callback.tick, function() OnTick() end)
callback.add(enum.callback.recv.spell, function (spell) OnProcessSpell(spell) end)

print("Avada Master Yi: Loaded")

return {}