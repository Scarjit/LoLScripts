require("S1mple_DrawLibary")

function OnLoad()
	SDL = SDL()
	--SDL:DrawTimerBar(WINDOW_H/2,WINDOW_W/2-200,500,100,10,ARGB(255,255,255,0), ARGB(255,0,0,0),2, true, "S1mple",14, ARGB(255,0,255,0))
	--SDL:DrawTimerBarVertical(WINDOW_H/2,WINDOW_W/2-400,10,100,11,ARGB(255,255,255,0), ARGB(255,0,0,0),2, true, "S1mple",14, ARGB(255,0,255,0))

	SDL:DrawTriangle(WINDOW_H/2,WINDOW_W/2-200,200,200,10,ARGB(255,255,255,0),ARGB(255,0,0,0),5,false)
end

local nextMove = 0
function OnTick()
	if os.clock() >= nextMove then
		myHero:MoveTo(myHero.x+math.random(-2000,2000),myHero.z+math.random(-2000,2000))
		nextMove = os.clock() + 15 + math.random(-1,1)
	end
end