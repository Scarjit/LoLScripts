local alib = loadmodule("avada_lib")
local common = alib.common
local draw = alib.draw

local loaded = true
function init(bool)
	loaded = bool
end

local objectives = {}

function AddToObjectives(mob)
	local addToTable = true
	for i=1,#objectives do
		local m = objectives[i]
		if m.name == mob then
			m.timer = game.time
			addToTable = false
			break
		end
	end
	if addToTable then
		objectives[#objectives+1] = { name = mob, timer = game.time }
	end
end

function OnAnimationex(obj)
	if obj and obj.type == enum.type.minion and obj.team == enum.team.neutral then
		if obj.charName == "SRU_RiftHerald" then
			AddToObjectives("Herald")
		elseif obj.charName == "SRU_Baron" then
			AddToObjectives("Baron")
		elseif obj.charName == "SRU_Dragon_Water" or
		obj.charName == "SRU_Dragon_Fire" or
		obj.charName == "SRU_Dragon_Earth" or
		obj.charName == "SRU_Dragon_Air" or
		obj.charName == "SRU_Dragon_Elder" then
			AddToObjectives("Dragon")
		end
	end
end

function ObjectivesAlert()
	for i=1,#objectives do
		local mob = objectives[i]
		if mob.timer + 3 < game.time then
			objectives[i] = nil
		else
			local posX, posY = glx.screen.width / 2, glx.screen.height / 2
			if mob.name == "Herald" then
				draw.text("Enemy Team is doing the Rift Herald!", 30, posX, posY - 25, draw.color.red, "center")
			elseif mob.name == "Baron" then
				draw.text("Enemy Team is doing the Baron Nashor!", 30, posX, posY - 25, draw.color.red, "center")
			elseif mob.name == "Dragon" then
				draw.text("Enemy Team is doing the Dragon!", 30, posX, posY + 25, draw.color.red, "center")
			end
		end
	end
end

callback.add(enum.callback.draw, function() if loaded then ObjectivesAlert() end end)
callback.add(enum.callback.recv.animationex, function(obj) if loaded then OnAnimationex(obj) end end)

return init