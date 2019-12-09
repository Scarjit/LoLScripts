local alib = loadmodule("avada_lib")
local common = alib.common
local draw = alib.draw

local loaded = true
function init(bool)
	loaded = bool
end

local enemies = common.GetEnemyHeroes()

local jungler = { obj = nil, isVisible = false, lastSeen = 0 }

for i = 1, #enemies do
	local hero = enemies[i]
	if hero:spellslotcast(4).name == "SummonerSmite" or hero:spellslotcast(5).name == "SummonerSmite" or
	hero:spellslotcast(4).name == "S5_SummonerSmitePlayerGanker" or hero:spellslotcast(5).name == "S5_SummonerSmitePlayerGanker" or
	hero:spellslotcast(4).name == "S5_SummonerSmiteDuel" or hero:spellslotcast(5).name == "S5_SummonerSmiteDuel" then
		jungler.obj = hero
		if hero.isVisible then
			jungler.isVisible = true
		end
		break
	end
end

local function junglerTracker()
	if jungler.obj and jungler.lastSeen >= game.time and not jungler.obj.isDead and jungler.isVisible and draw.GetDistance(myHero, jungler.obj) <= 3000 then
		local textX = glx.screen.width * 0.5
		local textY = glx.screen.height * 0.75
		draw.text("!  Enemy Jungler is ganking you  !", 40, textX, textY, draw.color.red, "center")
	end
end

callback.add(enum.callback.draw, function() if loaded then junglerTracker() end end)
callback.add(enum.callback.recv.gainvision, function(obj) if loaded and jungler.obj and jungler.obj == obj then jungler.isVisible = true jungler.lastSeen = game.time + 5 end end)
callback.add(enum.callback.recv.losevision, function(obj) if loaded and jungler.obj and jungler.obj == obj then jungler.isVisible = false end end)

return init
