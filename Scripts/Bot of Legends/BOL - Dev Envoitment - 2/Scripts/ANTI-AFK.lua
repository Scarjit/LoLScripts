local nextMove = 0
function OnTick()
	if os.clock() >= nextMove then
		myHero:MoveTo(myHero.x+math.random(-2000,2000),myHero.z+math.random(-2000,2000))
		nextMove = os.clock() + 15 + math.random(-1,1)
	end
end

function OnLoad()print(GetGameVersion():sub(1,10))end