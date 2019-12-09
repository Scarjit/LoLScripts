local alib = loadmodule("avada_lib")
local common = alib.common
local draw = alib.draw

local loaded = true
function init(bool)
	loaded = bool
end

local enemies = common.GetEnemyHeroes()

local function DrawPath()
    for i=1,#enemies do
        local hero = enemies[i]
		if hero.path.active then
			local distance = draw.GetDistance(hero.pos, hero.path.point[hero.path.index])
			if draw.vec3IsOnScreen(hero.path.point[hero.path.index]) then
				glx.world.drawLine(hero.pos, hero.path.point[hero.path.index], 4, draw.color.white)
			end
			for i = hero.path.index, hero.path.count - 1 do
				distance = distance + draw.GetDistance(hero.path.point[i], hero.path.point[i + 1])
				if draw.vec3IsOnScreen(hero.path.point[i + 1]) then
					glx.world.drawLine(hero.path.point[i], hero.path.point[i + 1], 4, draw.color.white)
				end
			end
			local pos = glx.world.toScreen(hero.path.point[hero.path.count])
			if draw.vec2IsOnScreen(pos) then
				draw.text(tostring(tonumber(string.format("%.1f", distance / hero.ms))).."s", 18, pos.x, pos.y - 20)
			end
		end
	end
end

callback.add(enum.callback.draw, function() if loaded then DrawPath() end end)

return init