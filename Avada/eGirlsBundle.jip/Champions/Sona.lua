local alib = loadmodule("avada_lib")
local common = alib.common
local game, callback, print, menuconfig, myHero, enum = game, callback, print, menuconfig, objmanager.player, enum --nobody likes global vars
local sona = common.Class()

sona.spells = {
    _Q = {range = 700, slot = 0, damage = function ()
        return myHero.level*40+0.5*myHero.ap*myHero.apMod
    end},
    _W = {range = 1000, slot = 1},
    _E = {range = 1000, slot = 2},
    _R = {range = 1000, slot = 3}
}


function sona:load()
    self:create_menu()
    callback.add(enum.callback.tick, function() self:on_tick() end)
end

function sona:create_menu()
    local menu = menuconfig("egirlsbundleSona", "eGirlsBundle [Sona]")
    
        --Use this till orbwalker release
        menu:menu("keys", "Key Settings")
            menu.keys:keybind("combo_key","Combo Key", "Space", false)
            menu.keys:keybind("harass_key","Harass Key", "C", false)
            menu.keys:keybind("laneclear_key","Laneclear Key", "V", false)
    
        menu:menu("combo", "Combo Mode")
            menu.combo:header("_Q", "[Q] Hymn of Valor")
                menu.combo:boolean("qEnabled", "Enable Q usage", true)
                menu.combo:slider("qMinManx", "Min Mana (%) to cast Q", 0 , 0, 100,1)
                menu.combo:slider("qMinEnemies", "Min enemies arount to cast Q", 1 , 0, 5,1)
            menu.combo:header("_W", "[W] Aria of Perseverance")
                menu.combo:boolean("wInfo", "-> Heal Settings", false)
            menu.combo:header("_E", "[E] Song of Celerity")
                menu.combo:boolean("eEnabled", "Enable E usage", true)
                menu.combo:slider("eMinManx", "Min Mana (%) to cast E", 0 , 0, 100,1)
                menu.combo:slider("eMinEnemies", "Min enemies arount to cast E", 1 , 0, 5,1)
            menu.combo:header("_R", "[R] Crescendo")
                menu.combo:boolean("rEnabled", "Enable R usage", true)
                menu.combo:slider("rMinManx", "Min Mana (%) to cast R", 0 , 0, 100,1)
                menu.combo:slider("rMinEnemies", "Min enemies hit", 1 , 1, 5,1)
                
        menu:menu("harass", "Harass Mode")
            menu.harass:header("_Q", "[Q] Hymn of Valor")
                menu.harass:boolean("qEnabled", "Enable Q usage", true)
                menu.harass:slider("qMinManx", "Min Mana (%) to cast Q", 30 , 0, 100,1)
                menu.harass:slider("qMinEnemies", "Min enemies arount to cast Q", 1 , 0, 5,1)
            menu.harass:header("_W", "[W] Aria of Perseverance")
                menu.harass:boolean("wInfo", "-> Heal Settings", false)
            menu.harass:header("_E", "[E] Song of Celerity")
                menu.harass:boolean("eEnabled", "Enable E usage", true)
                menu.harass:slider("eMinManx", "Min Mana (%) to cast E", 30 , 0, 100,1)
                menu.harass:slider("eMinEnemies", "Min enemies arount to cast E", 1 , 0, 5,1)
            menu.harass:header("_R", "[R] Crescendo")
                menu.harass:boolean("rEnabled", "Enable R usage", true)
                menu.harass:slider("rMinManx", "Min Mana (%) to cast R", 30 , 0, 100,1)
                menu.harass:slider("rMinEnemies", "Min enemies hit", 2 , 1, 5,1)
        
        menu:menu("laneclear", "Laneclear Mode")
            menu.laneclear:header("_Q", "[Q] Hymn of Valor")
            menu.laneclear:boolean("qEnabled", "Enable Q usage", true)
            menu.laneclear:slider("qMinManx", "Min Mana (%) to cast Q", 30 , 0, 100,1)
        
        menu:menu("ks", "Killsteal Settings")
            menu.ks:boolean("enabled", "Enable Killsteal", true)
            menu.ks:boolean("useQ", "Use Q", true)
            menu.ks:boolean("useR", "Use R", true)
        
        menu:menu("heal", "Heal Settings")
            menu.heal:boolean("enable", "Enable auto heal", true)
            menu.heal:boolean("enableself", "Enable self", true)
            menu.heal:boolean("enableally", "Enable ally", true)
            menu.heal:boolean("recalldisable", "Disable while recalling", true)
                menu.heal.recalldisable:set('tooltip', "Set to false, to abort your own recall to heal allies or yourself.")
            menu.heal:boolean("recalldisableally", "Disable for recalling allies", true)
                menu.heal.recalldisableally:set('tooltip', "Do not heal allies if they are recalling.")
            menu.heal:boolean("fountaindisalbe", "Disable while in fountain", true)
                menu.heal.fountaindisalbe:set('tooltip', "Do not heal while in fountain.")
            menu.heal:slider("minmana", "Min auto heal Mana (%)", 25, 0, 100, 1)
                menu.heal.minmana:set('tooltip', "The Script will only cast W, if your mana is above the given percentage.")
            menu.heal:slider("maxhealth", "Heal until XXX% HP", 60, 0, 100, 1)
                menu.heal.maxhealth:set('callback', function  (oldValue, newValue)
                    menu.heal.maxhealth:set('text', "Heal until "..newValue.."% HP")
                end)
                menu.heal.maxhealth:set('text', "Heal until "..menu.heal.maxhealth:get().."% HP")
                menu.heal.maxhealth:set('tooltip', "The Script will heal you or your ally to the given percentage.")
            menu.heal:slider("minenemies", "Min Enemies around", 1, 0, 5, 1)
                menu.heal.minenemies:set('tooltip', "Only heal you or your ally, if an enemy is near.")
            menu.heal:slider("enemyscanrange", "Enemies detection radius", 3000, 0, 25000, 100)
                menu.heal.enemyscanrange:set('tooltip', "Maximum range from your hero, to count as a thread.")
            
            local _allyHeroes = common.GetAllyHeroes()
            if(#_allyHeroes > 0)then
                menu.heal:header("_whitelist", "Whitelist")
                for i=1,#_allyHeroes do
                    local ally = _allyHeroes[i]
                    menu.heal:boolean(ally.charName, "Heal " .. ally.charName, true)
                    menu.heal[ally.charName]:set('tooltip', "Enable or disable healing for this Champion.")
                end
            end
            
    sona.menu = menu
end

function sona:combo()
    if(not self.menu.keys.combo_key:get())then
        return
    end
    
    if(self.menu.combo.qEnabled:get() and myHero.mana/myHero.maxMana*100 >= self.menu.combo.qMinManx:get() and #common.GetEnemyHeroesInRange(self.spells._Q.range) > self.menu.combo.qMinEnemies:get() and common.CanUseSpell(self.spells._Q.slot))then
        game.cast("self", self.spells._Q.slot)
    end
    
    if(self.menu.combo.eEnabled:get() and myHero.mana/myHero.maxMana*100 >= self.menu.combo.eMinManx:get() and #common.GetEnemyHeroesInRange(self.spells._E.range) > self.menu.combo.eMinEnemies:get() and common.CanUseSpell(self.spells._E.slot))then
        game.cast("self", self.spells._E.slot)
    end
end

function sona:harass()
    if(not self.menu.keys.harass_key:get())then
        return
    end
    
    if(self.menu.harass.qEnabled:get() and myHero.mana/myHero.maxMana*100 >= self.menu.harass.qMinManx:get() and #common.GetEnemyHeroesInRange(self.spells._Q.range) > self.menu.harass.qMinEnemies:get() and common.CanUseSpell(self.spells._Q.slot))then
        game.cast("self", self.spells._Q.slot)
    end
    
    if(self.menu.harass.eEnabled:get() and myHero.mana/myHero.maxMana*100 >= self.menu.harass.eMinManx:get() and #common.GetEnemyHeroesInRange(self.spells._E.range) > self.menu.harass.eMinEnemies:get() and common.CanUseSpell(self.spells._E.slot))then
        game.cast("self", self.spells._E.slot)
    end
end

function sona:laneclear()
    if(not self.menu.keys.laneclear_key:get())then
        return
    end
    
    if(self.menu.laneclear.qEnabled:get() and myHero.mana/myHero.maxMana*100 >= self.menu.laneclear.qMinManx:get() and common.CanUseSpell(self.spells._Q.slot) and #common.GetMinionsInRange(self.spells._Q.range) > 0)then
        game.cast("self", self.spells._Q.slot)
    end
end

function sona:killsteal()
    if(not self.menu.ks.enabled:get())then
        return
    end
    
    if(self.menu.ks.useQ:get() and common.CanUseSpell(self.spells._Q.slot))then
        local inrange = common.GetEnemyHeroesInRange(self.spells._Q.slot)
        for i=1,#inrange do
            local t = inrange[i]
            if(common.IsValidTarget(t))then
                if(t.health < self.spells._Q.damage())then
                    game.cast("self", self.spells._Q.slot)
                end
            end
        end
    end
end

function sona:heal()
    --Is enabled ?
    if(not self.menu.heal.enable:get())then
        return
    end
    
    --Is recalling ?
    if(common.IsRecalling(myHero) and self.menu.heal.recalldisable:get())then
        return
    end
    
    
    --Is in fountain ?
    if(common.InFountain() and self.menu.heal.fountaindisalbe:get())then
        return
    end
    
    
    --Have enough Mana ?
    if(myHero.mana/myHero.maxMana*100 < self.menu.heal.minmana:get())then
        return
    end
    
    
    --Enough enemies around ?
    local enemies_around = 0
    local enemies_needed = self.menu.heal.minenemies:get()
    local e_range = self.menu.heal.enemyscanrange:get()
    for i=1,#common.GetEnemyHeroes() do
        local hero = common.GetEnemyHeroes()[i]
        if(hero and not hero.isDead and hero.isVisible)then
            if(draw.GetDistance(myHero, hero) <= e_range)then
                enemies_around = enemies_around + 1
                if(enemies_around >= enemies_needed)then
                    break
                end
            end
        end
    end
    
    if(enemies_around < enemies_needed)then
        return
    end
    
    local max_health_perc = self.menu.heal.maxhealth:get()
    local do_heal = false
    --Do i need healing ?
    if(myHero.health/myHero.maxHealth*100 < max_health_perc and self.menu.heal.enableself:get())then
        do_heal = true
    end
    
    --Skip ally search, if you need healing yourself (more fps)
    
    if(not do_heal)then
        --Do any of my allies need healing ?
        if(self.menu.heal.enableally:get())then
            for i=1,#common.GetAllyHeroes() do
                local ally = common.GetAllyHeroes()[i]
                if(self.menu.heal[ally.charName]:get())then
                    if(ally.health/ally.maxHealth*100 < max_health_perc)then
                        if(self.menu.heal.recalldisableally:get() and common.IsRecalling(ally))then
                            do_heal = true
                        end
                    end
                end
            end
        end
    end
    
    if(do_heal)then
        game.cast("self", self.spells._W.slot) -- 1 == W
    end
end



function sona:on_tick()
    self:heal()
    
    self:combo()
    self:harass()
    self:laneclear()
    
    self:killsteal()
    
    
end



return sona