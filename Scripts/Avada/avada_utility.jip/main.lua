local version = "1.01"

local alib = loadmodule("avada_lib")
local common = alib.common
local draw = alib.draw

local myHero = objmanager.player
local enemies = common.GetEnemyHeroes()

local smiteDmg = { 390, 410, 430, 450, 480, 510, 540, 570, 600, 640, 680, 720, 760, 800, 850, 900, 950, 1000 }
local smiteSlot = nil
if myHero:spellslotcast(4).name == "SummonerSmite" or myHero:spellslotcast(4).name == "S5_SummonerSmitePlayerGanker" or myHero:spellslotcast(4).name == "S5_SummonerSmiteDuel" then
	smiteSlot = 4
elseif myHero:spellslotcast(5).name == "SummonerSmite" or myHero:spellslotcast(5).name == "S5_SummonerSmitePlayerGanker" or myHero:spellslotcast(5).name == "S5_SummonerSmiteDuel" then
	smiteSlot = 5
end

local cleanseSlot = nil
if myHero:spellslotcast(4).name == "SummonerBoost" then
	cleanseSlot = 4
elseif myHero:spellslotcast(5).name == "SummonerBoost" then
	cleanseSlot = 5
end

function AutoSmite()
	if not myHero.isDead and smiteSlot and common.CanUseSpell(smiteSlot) then
		for i = 0, objmanager.maxObjects - 1 do
			local obj = objmanager.get(i)
			if common.IsValidTarget(obj) and obj.type == enum.type.minion and obj.team == enum.team.neutral and draw.GetDistance(obj, myHero) < 560 and obj.health <= smiteDmg[myHero.level] then
				if obj.charName == "SRU_Baron" or obj.charName == "SRU_Dragon_Water" or obj.charName == "SRU_Dragon_Fire" or obj.charName == "SRU_Dragon_Earth" or obj.charName == "SRU_Dragon_Air" or obj.charName == "SRU_Dragon_Elder" or obj.charName == "SRU_RiftHerald" then
					game.cast("obj", smiteSlot, obj)
				end
			end
		end
	end
end

function OnUpdateBuff(buff, source)
	if buff and buff.owner and buff.owner == myHero and source.type == enum.type.hero and source.team == enum.team.enemy then
		if buff.name == "SummonerExhaust" then
			AutoQSS("Exhaust")
		end
		if buff.type == 5 then
			AutoQSS("Stun")
		elseif buff.type == 7 then
			AutoQSS("Silence")
		elseif buff.type == 8 then
			AutoQSS("Taunt")
		elseif buff.type == 11 then
			AutoQSS("Root")
		elseif buff.type == 22 then
			AutoQSS("Charm")
		elseif buff.type == 24 then
			AutoQSS("Suppression")
		elseif buff.type == 25 then
			AutoQSS("Blind")
		elseif buff.type == 28 then
			AutoQSS("Fear")
		elseif buff.type == 29 then
			AutoQSS("KnockUp")
		end
	end
end

function AutoQSS(typeName)
	if myHero.charName == "Alistar" and common.CanUseSpell(3) then
		game.cast("self", 3)
	elseif myHero.charName == "Gangplank" and common.CanUseSpell(1) then
		game.cast("self", 1)
	elseif myHero.charName == "Olaf" and common.CanUseSpell(3) then
		game.cast("self", 3)
	elseif myHero.charName == "Rengar" and myHero.mana == myHero.maxMana and common.CanUseSpell(1) then
		game.cast("self", 1)
	else
		local useCleanse = true
		for i = 6, 11 do
			local item = myHero:spellslotcast(i).name
			if item == "QuicksilverSash" or item == "ItemMercurial" then
				game.cast("self", i)
				useCleanse = false
				break
			end
		end
		if useCleanse and cleanseSlot and typeName ~= "Suppression" then
			game.cast("self", cleanseSlot)
		end
	end
end

function OnTick()
	AutoSmite()
end

callback.add(enum.callback.tick, function() OnTick() end)
callback.add(enum.callback.recv.updatebuff, function(buff, source) OnUpdateBuff(buff, source) end)

print("Avada Utility "..version..": Loaded")

return {}