local alib = loadmodule("avada_lib")
local common = alib.common
local draw = alib.draw

local loaded = true
function init(bool)
	loaded = bool
end

local towers = common.GetEnemyTowers()

function OnDraw()
	for i=1, #towers do
		local tower = towers[i]
		if tower and tower.health > 0 and tower.isOnScreen then
			glx.world.circle(tower.pos, 775 + tower.bRadius, 1, draw.color.red, 50)
		end
	end
end

callback.add(enum.callback.draw, function() if loaded then OnDraw() end end)

return init