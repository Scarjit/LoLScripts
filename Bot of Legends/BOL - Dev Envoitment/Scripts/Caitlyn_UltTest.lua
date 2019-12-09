function OnProcessSpell(unit, spell)
	if not unit.isMe then return end
	if spell.name ~= "CaitlynAceintheHole" then return end
	print(spell.name)
	starttime = os.clock()
end


function OnDraw()
	for _,v in pairs(GetEnemyHeroes()) do
		if v.charName == "Fiora" and GetDistance(v) <2500 then
			DrawLineBorder3D(myHero.x,myHero.y,myHero.z,v.x,v.y,v.z,200)
			DrawText3D(tostring(GetDistance(v)), myHero.x, myHero.y, myHero.z, 18)
		end
	end
	DrawTextA(myHero.ms)
end

local starttime = 0
local endtime = 0
local dst = 0
local oldlife = 0
function OnTick()
	for _,v in pairs(GetEnemyHeroes()) do
		if v.charName == "Fiora" then
			if oldlife == 0 then oldlife = v.health end
			if oldlife > v.health then
				oldlife = v.health
				--print(os.clock())
				endtime = os.clock()
				dst = GetDistance(v)
				--print(endtime-starttime)
				print("Speed: "..tostring(dst/(endtime-starttime)))
			end
		end
	end
end