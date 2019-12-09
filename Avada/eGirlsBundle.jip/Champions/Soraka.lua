local alib = loadmodule("avada_lib")
local common = alib.common
local draw = alib.draw
local soraka = common.Class()
local orb = loadorbwalker()

soraka.spells = {
    _Q = {slot = 0, range = 950},
    _W = {slot = 1},
    _E = {slot = 2},
    _R = {slot = 3}
}

local myHero = objmanager.player
local allies, enemies = common.GetAllyHeroes(), common.GetEnemyHeroes()

local spellsToSilence = {
	{ name = "Anivia", spells = { 3 } },
	{ name = "Caitlyn", spells = { 3 } },
	{ name = "Darius", spells = { 3 } },
	{ name = "FiddleSticks", spells = { 1, 3 } },
	{ name = "Gragas", spells = { 1 } },
	{ name = "Janna", spells = { 3 } },
	{ name = "Karthus", spells = { 3 } },
	{ name = "Katarina", spells = { 3 } },
	{ name = "Malzahar", spells = { 3 } },
	{ name = "MasterYi", spells = { 1 } },
	{ name = "MissFortune", spells = { 3 } },
	{ name = "Nunu", spells = { 3 } },
	{ name = "Pantheon", spells = { 2, 3 } },
	{ name = "Sion", spells = { 0 } },
	{ name = "TwistedFate", spells = { 3 } },
	{ name = "Varus", spells = { 0 } },
	{ name = "Vi", spells = { 0, 3 } },
	{ name = "Warwick", spells = { 3 } },
	{ name = "Xerath", spells = { 0, 3 } }
}


function soraka:load()
    self:create_menu()
  callback.add(enum.callback.tick, function() self:OnTick() end)
	callback.add(enum.callback.recv.spell, function (spell) self:AutoSilence(spell) end)
end

function soraka:create_menu()
    local menu = menuconfig("egirlsbundleSona", "eGirlsBundle [Soraka]")	
		menu:menu("keys", "Key Settings")
				menu.keys:keybind("combo_key","Combo Key", "Space", false)
				menu.keys:keybind("harass_key","Harass Key", "C", false)
				menu.keys:keybind("laneclear_key","Laneclear Key", "V", false)
				
		menu:menu("combo", "Combo Mode")
        menu.combo:header("_Q", "[Q] Starcall")
            menu.combo:boolean("qEnabled", "Enable Q usage", true)
            menu.combo:slider("qMinManx", "Min Mana (%) to cast Q", 0 , 0, 100,1)
        menu.combo:header("_W", "[W] Astral Infusion")
            menu.combo:boolean("wInfo", "-> Heal Settings", false)
        menu.combo:header("_E", "[E] Equinox")
            menu.combo:boolean("eEnabled", "Enable E usage", true)
            menu.combo:slider("eMinManx", "Min Mana (%) to cast E", 0 , 0, 100,1)
        menu.combo:header("_R", "[R] Wish")
            menu.combo:boolean("rInfo", "-> Heal Settings", false)
						
			menu:menu("harass", "Combo Mode")
	        menu.harass:header("_Q", "[Q] Starcall")
	            menu.harass:boolean("qEnabled", "Enable Q usage", true)
	            menu.harass:slider("qMinManx", "Min Mana (%) to cast Q", 0 , 0, 100,1)
	        menu.harass:header("_W", "[W] Astral Infusion")
	            menu.harass:boolean("wInfo", "-> Heal Settings", false)
	        menu.harass:header("_E", "[E] Equinox")
	            menu.harass:boolean("eEnabled", "Enable E usage", true)
	            menu.harass:slider("eMinManx", "Min Mana (%) to cast E", 0 , 0, 100,1)
	        menu.harass:header("_R", "[R] Wish")
	            menu.harass:boolean("rInfo", "-> Heal Settings", false)
							
				menu:menu("laneclear", "Laneclear Mode")
						menu.laneclear:header("_Q", "[Q] Starcall")
						menu.laneclear:boolean("qEnabled", "Enable Q usage", true)
						menu.laneclear:slider("qMinManx", "Min Mana (%) to cast Q", 30 , 0, 100,1)
		self.menu = menu
end

function soraka:OnTick()
		selector.update()
    self:AutoUlt()
    self:AutoHeal()
		self:Combo()
		self:Harass()
		self:Laneclear()
end

function soraka:Combo ()
	if(not self.menu.keys.combo_key:get())then return end
	
	if(self.menu.combo.qEnabled:get() and myHero.mana/myHero.maxMana*100 >= self.menu.combo.qMinManx:get() and common.CanUseSpell(self.spells._Q.slot))then
		self:CastQ()
	end
	
	if(self.menu.combo.eEnabled:get() and myHero.mana/myHero.maxMana*100 >= self.menu.combo.eMinManx:get() and common.CanUseSpell(self.spells._E.slot))then
		self:CastE()
	end
end

function soraka:Harass ()
	if(not self.menu.keys.harass_key:get())then return end
	
	if(self.menu.harass.qEnabled:get() and myHero.mana/myHero.maxMana*100 >= self.menu.harass.qMinManx:get() and common.CanUseSpell(self.spells._Q.slot))then
		self:CastQ()
	end
	
	if(self.menu.harass.eEnabled:get() and myHero.mana/myHero.maxMana*100 >= self.menu.harass.eMinManx:get() and common.CanUseSpell(self.spells._E.slot))then
		self:CastE()
	end
end

function soraka:Laneclear ()
	if(not self.menu.keys.laneclear_key:get())then return end
	
	if(self.menu.laneclear.qEnabled:get() and myHero.mana/myHero.maxMana*100 >= self.menu.laneclear.qMinManx:get() and common.CanUseSpell(self.spells._Q.slot))then
		self:CastQ(#common.GetMinionsInRange(self.spells._Q.range) > 0 and common.GetMinionsInRange(self.spells._Q.range)[1])
	end
end

function soraka:CastQ (t)
		local target = t and t or selector.get_target()
		if(target and common.IsValidTarget(target))then
			if(common.CanUseSpell(0))then
				game.cast("obj", 0, target)
			end
		end
end

function soraka:CastE (t)
		local target = t and t or selector.get_target()
		if(target and common.IsValidTarget(target))then
			if(common.CanUseSpell(2))then
				game.cast("obj", 2, target)
			end
	end
end

function soraka:AutoHeal()
	if common.CanUseSpell(1) then
		for i = 1, #allies do
			local hero = allies[i]
			if hero and not hero.dead and draw.GetDistance(myHero, hero) < 550 --[[and (myHero.health / myHero.maxHealth * 100) > 25--]] and (hero.health / hero.maxHealth * 100) < 75 then
				game.cast("obj", 1, hero)
			end
		end
	end
end

function soraka:AutoSilence(spell)
	if common.CanUseSpell(2) and spell.owner.team == enum.team.enemy then
		local slot = spell.slot
		local champ = spell.owner
		if (draw.GetDistance(myHero, champ) <= 910) then
			if spell.name == "SummonerTeleport" then
				game.cast("pos", 2, champ.pos)
			else
				local name = champ.charName
				for i = 1, #spellsToSilence do
					if name == spellsToSilence[i].name then
						for j = 1, #spellsToSilence[i].spells do
							if slot == spellsToSilence[i].spells[j] then
								game.cast("pos", 2, champ.pos)
								break
							end
						end
						break
					end
				end
			end
		end
	end
end

function soraka:AutoUlt()
	if common.CanUseSpell(3) then
		if (myHero.health / myHero.maxHealth * 100) < 10 then
			game.cast("self", 3)
			return
		end
		for i = 1, #allies do
			local hero = allies[i]
			if hero and not hero.dead and (hero.health / hero.maxHealth * 100) < 10 then
				game.cast("self", 3)
			end
		end
	end
end



return soraka