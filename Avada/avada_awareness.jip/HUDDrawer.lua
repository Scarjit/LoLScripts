local alib = loadmodule("avada_lib")
local common = alib.common
local draw = alib.draw

local loaded = true
function init(bool)
	loaded = bool
end

local enemies = common.GetEnemyHeroes()
local color = {
	dark_red = glx.argb(255, 100, 0, 0),
	green = glx.argb(255, 0, 200, 0),
	backgroundDead = glx.argb(255, 150, 11, 0),
	backgroundMissing = glx.argb(255, 0, 90, 120),
	backgroundVisible = glx.argb(255, 0, 140, 70)
}
local spellNames = {
	["SummonerBarrier"] = "Barrier",
	["SummonerBoost"] = "Cleanse",
	["SummonerDot"] = "Ignite",
	["SummonerExhaust"] = "Exhaust",
	["SummonerFlash"] = "Flash",
	["SummonerHaste"] = "Ghost",
	["SummonerHeal"] = "Heal",
	["SummonerMana"] = "Clarity",
	["SummonerSmite"] = "Smite",
	["SummonerSnowball"] = "Mark",
	["SummonerTeleport"] = "Teleport",
	["S5_SummonerSmiteDuel"] = "Smite",
	["S5_SummonerSmitePlayerGanker"] = "Smite"
}

function DrawHUD()
	local x = glx.screen.width - 130
	local y = 0
    for i=1,#enemies do
		y = (70 + (i - 1) * 130)
        local hero = enemies[i]
		local lifeRatio = hero.health / hero.maxHealth * 111
		
		-- Draw Background
		if hero.isDead then
			glx.screen.line(x, y + 50, x + 121, y + 50, 120, color.backgroundDead)
		else
			if hero.isVisible then
				glx.screen.line(x, y + 50, x + 121, y + 50, 120, color.backgroundVisible)
			else
				glx.screen.line(x, y + 50, x + 121, y + 50, 120, color.backgroundMissing)
			end
		end
		
		-- Draw Champ name
		draw.text(hero.charName, 14, x + 5, y + 1, draw.color.white)
		
		-- Draw Champ level
		draw.text(tostring(hero.level), 14, x + 116, y + 1, draw.color.white, "right")
		
		-- Draw Health bar
		glx.screen.line(x + 5, y + 23, x + 115, y + 23, 24, draw.color.dark_red)
		glx.screen.line(x + 5, y + 23, x + 5 + lifeRatio, y + 23, 24, draw.color.red)
		draw.text(tostring(math.floor(hero.health) .. " / " .. math.floor(hero.maxHealth)), 18, x + 60, y + 23, draw.color.white, "center")
		
		-- Draw Spells
		if (hero:spellslotcast(0).state == 8) then
			glx.screen.line(x + 5, y + 53, x + 29, y + 53, 24, color.green)
			draw.text("Q", 18, x + 17, y + 53, draw.color.white, "center")
		elseif (hero:spellslotcast(0).state == 12) then
			glx.screen.line(x + 5, y + 53, x + 29, y + 53, 24, draw.color.dark_red)
			draw.text("Q", 18, x + 17, y + 53, draw.color.white, "center")
		else
			glx.screen.line(x + 5, y + 53, x + 29, y + 53, 24, draw.color.dark_red)
			draw.text(tostring(math.floor(hero:spellslotcast(0).cooldown)), 18, x + 17, y + 53, draw.color.white, "center")
		end
		
		if (hero:spellslotcast(1).state == 8) then
			glx.screen.line(x + 34, y + 53, x + 58, y + 53, 24, color.green)
			draw.text("W", 18, x + 46, y + 53, draw.color.white, "center")
		elseif (hero:spellslotcast(1).state == 12) then
			glx.screen.line(x + 34, y + 53, x + 58, y + 53, 24, draw.color.dark_red)
			draw.text("W", 18, x + 46, y + 53, draw.color.white, "center")
		else
			glx.screen.line(x + 34, y + 53, x + 58, y + 53, 24, draw.color.dark_red)
			draw.text(tostring(math.floor(hero:spellslotcast(1).cooldown)), 18, x + 46, y + 53, draw.color.white, "center")
		end
		
		if (hero:spellslotcast(2).state == 8) then
			glx.screen.line(x + 63, y + 53, x + 87, y + 53, 24, color.green)
			draw.text("E", 18, x + 75, y + 53, draw.color.white, "center")
		elseif (hero:spellslotcast(2).state == 12) then
			glx.screen.line(x + 63, y + 53, x + 87, y + 53, 24, draw.color.dark_red)
			draw.text("E", 18, x + 75, y + 53, draw.color.white, "center")
		else
			glx.screen.line(x + 63, y + 53, x + 87, y + 53, 24, draw.color.dark_red)
			draw.text(tostring(math.floor(hero:spellslotcast(2).cooldown)), 18, x + 75, y + 53, draw.color.white, "center")
		end
		
		if (hero:spellslotcast(3).state == 8) then
			glx.screen.line(x + 92, y + 53, x + 116, y + 53, 24, color.green)
			draw.text("R", 18, x + 104, y + 53, draw.color.white, "center")
		elseif (hero:spellslotcast(3).state == 12) then
			glx.screen.line(x + 92, y + 53, x + 116, y + 53, 24, draw.color.dark_red)
			draw.text("R", 18, x + 104, y + 53, draw.color.white, "center")
		else
			glx.screen.line(x + 92, y + 53, x + 116, y + 53, 24, draw.color.dark_red)
			draw.text(tostring(math.floor(hero:spellslotcast(3).cooldown)), 18, x + 104, y + 53, draw.color.white, "center")
		end
		
		if (hero:spellslotcast(4).state == 8) then
			draw.text(spellNames[hero:spellslotcast(4).name]..": Up", 20, x + 5, y + 77, draw.color.white, "left")
		else
			draw.text(spellNames[hero:spellslotcast(4).name]..": "..tostring(math.floor(hero:spellslotcast(4).cooldown)), 20, x + 5, y + 77, draw.color.red, "left")
		end
		
		if (hero:spellslotcast(5).state == 8) then
			draw.text(spellNames[hero:spellslotcast(5).name]..": Up", 20, x + 5, y + 98, draw.color.white, "left")
		else
			draw.text(spellNames[hero:spellslotcast(5).name]..": "..tostring(math.floor(hero:spellslotcast(5).cooldown)), 20, x + 5, y + 98, draw.color.red, "left")
		end
	end
end

callback.add(enum.callback.draw, function() if loaded then DrawHUD() end end)

return init