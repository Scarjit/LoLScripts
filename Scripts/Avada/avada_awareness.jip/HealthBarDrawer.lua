local alib = loadmodule("avada_lib")
local common = alib.common
local draw = alib.draw

local loaded = true
function init(bool)
	loaded = bool
end

local enemies = common.GetEnemyHeroes()
local color = {
	background = glx.argb(255, 0, 140, 70)
}

local function DrawHealthBar()
	local hero, lptr
	for i = 0, tonumber(glx.hbar_n) - 1 do
		if lptr ~= glx.hbar[i].ptr then
			lptr = glx.hbar[i].ptr
			hero = objmanager.toluaclass(glx.hbar[i].ptr)
			if hero.type == enum.type.hero and hero.team == enum.team.enemy then
				local x = glx.hbar[i].x - 3
				local y = glx.hbar[i].y - 15
				glx.screen.drawLine(x, y, x + 134, y, 22, color.background)
				draw.text("Q:"..math.floor(hero:spellslotcast(0).cooldown)..
				"  |  W:"..math.floor(hero:spellslotcast(1).cooldown)..
				"  |  E:"..math.floor(hero:spellslotcast(2).cooldown)..
				"  |  R:"..math.floor(hero:spellslotcast(3).cooldown), 12, x + 3, y)
			end
		end
	end
end

callback.add(999, function() end)
callback.add(enum.callback.draw, function() if loaded then DrawHealthBar() end end)

return init