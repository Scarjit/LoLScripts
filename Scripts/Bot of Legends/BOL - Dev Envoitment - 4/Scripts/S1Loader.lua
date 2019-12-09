require "S1mpleOrbWalker"
function OnLoad()
	DelayAction(function ()
		_G.S1 = S1mpleOrbWalker()
		Menu = scriptConfig("S1mpleOrbWalker", 'S1mpleOrbWalker')
		S1:AddToMenu(Menu)
	end,1)
end