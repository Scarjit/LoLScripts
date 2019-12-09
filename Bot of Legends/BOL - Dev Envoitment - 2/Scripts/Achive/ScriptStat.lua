require "S1mpleOrbWalker"
S1 = S1mpleOrbWalker()
function OnLoad()
	Menu = scriptConfig(myHero.charName.." Orb-Test", 'OrbTest')
	S1:AddToMenu(Menu)
end