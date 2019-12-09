local alib = loadmodule("avada_lib")
local common = alib.common
local draw = alib.draw

local loaded = true
function init(bool)
	loaded = bool
end

local myHero = objmanager.player
local enemies = common.GetEnemyHeroes()

local recallTable = {}
for i=1,#enemies do
	recallTable[#recallTable+1] = { hero = enemies[i], recall = false, name = "", timer = 0, delay = 0 }
end

function OnTick()
	for i=1,#recallTable do
		local e = recallTable[i]
		local hero = e.hero
		local name = hero.recallName
		if hero.recallName ~= "" then
			if not e.recall then
				e.recall = true
				if name == "recall" then
					e.timer = game.time + 8
					e.delay = 8
					e.name = "Recall"
				elseif name == "SuperRecall" then
					e.timer = game.time + 4
					e.delay = 4
					e.name = "SuperRecall"
				elseif name == "SummonerTeleport" then
					e.timer = game.time + 4.7
					e.delay = 4.7
					e.name = "Teleport"
				end
			end
		else
			e.recall = false
		end
	end
end

function OnDraw()
	for i=1,#recallTable do
		local e = recallTable[i]
		if e.recall then
			local w, h = 120, (glx.height / 2) + ((i - 2) * 30)
			local timer = e.timer - game.time
			if e.name == "Teleport" then
				glx.screen.line(w - 100, h, w + 100, h, 25, draw.color.white)
				glx.screen.line(w - 100, h, (w + 100) - (200 * timer / e.delay), h, 25, draw.color.medium_violet_red)
				draw.text(e.hero.charName, 12, w, h - 5, draw.color.black, "center", "middle")
				draw.text("Teleporting: "..tostring(tonumber(string.format("%.1f", timer))).."s", 12, w, h + 5, draw.color.black, "center", "middle")
			else
				glx.screen.line(w - 100, h, w + 100, h, 25, draw.color.white)
				glx.screen.line(w - 100, h, (w - 100) + (200 * timer / e.delay), h, 25, draw.color.violet)
				draw.text(e.hero.charName, 12, w, h - 5, draw.color.black, "center", "middle")
				draw.text("Recalling: "..tostring(tonumber(string.format("%.1f", timer))).."s", 12, w, h + 5, draw.color.black, "center", "middle")
			end
		end
	end
end

callback.add(enum.callback.tick, function() if loaded then OnTick() end end)
callback.add(enum.callback.draw, function() if loaded then OnDraw() end end)

print("Avada BaseUlt: Loaded")

return init