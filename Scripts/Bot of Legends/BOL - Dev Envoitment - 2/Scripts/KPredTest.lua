require("KPrediction")
KPred = KPrediction()
function OnLoad()
	QSkill = KPSkillshot({type = "DelayLine", range = 1175, speed = 1200, width = 80, delay = 0.25, collisionM = 1, collisionH = 1})
	print("Test")
	
	for _,v in pairs(GetEnemyHeroes()) do
		a,b,c,d = KPred:GetPrediction(QSkill, v, myHero, nil, true)
	end

	print(a) --Cast Position
	print(b) --HitChance
	print(c) --I guess colliding Enemys
	print(d) --I guess colliding Minions

	if a and b > 1.5 then
		CastSpell(_Q, a.x,a.y,a.z)
	end
end

function OnTick()
	for _,v in pairs(GetEnemyHeroes()) do
		a,b,c,d = KPred:GetPrediction(QSkill, v, myHero, nil, true)
	end
	if b >= 4 then
		print("Target is dashing")
	end
end