require "S1mpleOrbWalker"
function OnLoad()
	DelayAction(function ()
		S1 = S1mpleOrbWalker()
		Menu = scriptConfig(myHero.charName.." Orb-Test", 'OrbTest')
		S1:AddToMenu(Menu)
	end,1)
end