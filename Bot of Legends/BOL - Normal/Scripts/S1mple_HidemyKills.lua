lastdeads = {}
function OnLoad()
	print("loaded")
	for _,v in pairs(GetEnemyHeroes()) do
		lastdeads[#lastdeads+1] = {obj = v, lastdead = 0, isdead = false}
	end
	for _,v in pairs(GetAllyHeroes()) do
		lastdeads[#lastdeads+1] = {obj = v, lastdead = 0, isdead = false}
	end
	for i = 1, objManager.maxObjects do
		local object = objManager:getObject(i)
		if object and object.valid and object.health and object.health > 1 and (object.type == "obj_AI_Turret" or object.type == "obj_HQ" or object.type == "obj_BarracksDampener") and object.team ~= myHero.team then
			lastdeads[#lastdeads+1] = {obj = object, lastdead = 0, isdead = false}
		end
	end
	lastdeads[#lastdeads+1] = {obj = myHero, lastdead = 0, isdead = false}
end

function OnDraw()
	for i,v in pairs(lastdeads) do
		if (v.obj.type == myHero.obj and v.obj.dead) or (v.obj.type ~= myHero.obj and v.obj.health < 1 or (v.obj and v.obj.dead)) then
			if v.isdead then
				if v.lastdead + 10 > os.clock() then
					DrawTextA(v.obj.charName)
					DrawRectangle(WINDOW_W*0.25, WINDOW_H*0.1, WINDOW_W/2, 100, ARGB(255,0,0,0))
				end
			else
				lastdeads[i].isdead = true
				lastdeads[i].lastdead = os.clock()
			end
		else
			lastdeads[i].isdead = false
			lastdeads[i].lastdead = 0
		end
	end
end