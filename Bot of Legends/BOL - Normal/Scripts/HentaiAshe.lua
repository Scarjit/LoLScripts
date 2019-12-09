--[[                                                                           
 ____   ____      ______  _____   ______   _________________      _____    ____ 
|    | |    | ___|\     \|\    \ |\     \ /                 \ ___|\    \  |    |
|    | |    ||     \     \\\    \| \     \\______     ______//    /\    \ |    |
|    |_|    ||     ,_____/|\|    \  \     |  \( /    /  )/  |    |  |    ||    |
|    .-.    ||     \--'\_|/ |     \  |    |   ' |   |   '   |    |__|    ||    |
|    | |    ||     /___/|   |      \ |    |     |   |       |    .--.    ||    |
|    | |    ||     \____|\  |    |\ \|    |    /   //       |    |  |    ||    |
|____| |____||____ '     /| |____||\_____/|   /___//        |____|  |____||____|
|    | |    ||    /_____/ | |    |/ \|   ||  |`   |         |    |  |    ||    |
|____| |____||____|     | / |____|   |___|/  |____|         |____|  |____||____|
  \(     )/    \( |_____|/    \(       )/      \(             \(      )/    \(  
   '     '      '    )/        '       '        '              '      '      '                                                                  
      _____            ______   ____   ____      ______                         
  ___|\    \       ___|\     \ |    | |    | ___|\     \                        
 /    /\    \     |    |\     \|    | |    ||     \     \                       
|    |  |    |    |    |/____/||    |_|    ||     ,_____/|                      
|    |__|    | ___|    \|   | ||    .-.    ||     \--'\_|/                      
|    .--.    ||    \    \___|/ |    | |    ||     /___/|                        
|    |  |    ||    |\     \    |    | |    ||     \____|\                       
|____|  |____||\ ___\|_____|   |____| |____||____ '     /|                      
|    |  |    || |    |     |   |    | |    ||    /_____/ |                      
|____|  |____| \|____|_____|   |____| |____||____|     | /                      
  \(      )/      \(    )/       \(     )/    \( |_____|/                       
   '      '        '    '         '     '      '    )/                          
                                                    '                           
--]]
--ver. 0.51

if myHero.charName ~= "Ashe" then return end

assert(load(Base64Decode("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"), nil, "bt", _ENV))()
TrackerLoad("lJjOQ2GyvDHARjzp")

local version = "0.51"
local scriptname = "Hentai Ashe"
local developer = "remembermyhentai"
local contact = "skype xd_kikass"
local DP, VP, KP = nil
local FHPred = false
local kek = 1
local topkek = {}
local YOLO = {}
local REGEN = false
local FONTAN = false
local lowBase = {["x"] = 406, ["z"] = 424}
local upBase = {["x"] = 14322, ["z"] = 14394}
local POTS = {"ItemCrystalFlask", "RegenerationPotion", "ItemMiniRegenPotion", "ItemCrystalFlaskJungle", "ItemDarkCrystalFlask"}
local TURRETS = {"Turret_T2_C_01_A", "Turret_T2_C_02_A", "Turret_T2_L_01_A", "Turret_T2_C_03_A", "Turret_T2_R_01_A", "Turret_T1_C_01_A", "Turret_T1_C_02_A", 
"Turret_T1_C_06_A", "Turret_T1_C_03_A", "Turret_T1_C_07_A"}
local CUTLASSSLOT, YOUMUSLOT, GUNBLADESLOT, BOTRKSLOT, QSSSLOT, DERVISHSLOT
local ATTACKITEMS = {"BilgewaterCutlass", "YoumusBlade", "HextechGunblade", "ItemSwordOfFeastAndFamine"}
local ANTICCITEMS = {"QuicksilverSash", "ItemDervishBlade"}
local CCSPELLS = {"MordekaiserChildrenOfTheGrave", "SkarnerImpale", "LuxLightBindingMis", "Wither", "SonaCrescendo", "DarkBindingMissile", "CurseoftheSadMummy",
"EnchantedCrystalArrow", "BlindingDart", "LuluWTwo", "AhriSeduce", "CassiopeiaPetrifyingGaze", "Terrify", "HowlingGale", "JaxCounterStrike", "KennenShurikenStorm",
"LeblancSoulShackle", "LeonaSolarFlare", "LissandraR", "AlZaharNetherGrasp", "MonkeyKingDecoy", "NamiQ", "OrianaDetonateCommand", "Pantheon_LeapBash", "PuncturingTaunt",
"SejuaniGlacialPrisonStart", "SwainShadowGrasp", "Imbue", "ThreshQ", "UrgotSwap2", "VarusR", "VeigarEventHorizon", "ViR", "InfiniteDuress", "ZyraGraspingRoots",
"paranoiamisschance", "puncturingtauntarmordebuff", "surpression", "zedulttargetmark", "enchantedcrystalarrow", "nasusw"}
local AttackResets = {"dariusnoxiantacticsonh", "fioraflurry", "garenq", "hecarimrapidslash", "jaxempowertwo", "jaycehypercharge", "leonashieldofdaybreak", 
"luciane", "lucianq", "lucianw", "monkeykingdoubleattack", "mordekaisermaceofspades", "nasusq", "nautiluspiercinggaze", "netherblade", "parley", 
"poppydevastatingblow", "powerfist", "renektonpreexecute", "rengarq", "shyvanadoubleattack", "sivirw", "takedown", "talonnoxiandiplomacy", "trundletrollsmash", 
"vaynetumble", "vie", "volibearq", "xenzhaocombotarget", "yorickspectral", "reksaiq"}
local NoAttacks = {"jarvanivcataclysmattack", "monkeykingdoubleattack", "shyvanadoubleattack", "shyvanadoubleattackdragon", "zyragraspingplantattack", 
"zyragraspingplantattack2", "zyragraspingplantattackfire", "zyragraspingplantattack2fire", "viktorpowertransfer", "sivirwattackbounce"}
local Attacks = {"caitlynheadshotmissile", "frostarrow", "garenslash2", "kennenmegaproc", "lucianpassiveattack", "masteryidoublestrike", "quinnwenhanced", 
"renektonexecute", "renektonsuperexecute", "rengarnewpassivebuffdash", "trundleq", "xenzhaothrust", "xenzhaothrust2", "xenzhaothrust3", "viktorqbuff"}

local PussyOut = 
{
["KatarinaR"] = true,
["AlZaharNetherGrasp"] = true,
["TwistedFateR"] = true,
["VelkozR"] = true,
["InfiniteDuress"] = true,
["JhinR"] = true,
["CaitlynAceintheHole"] = true,
["UrgotSwap2"] = true,
["LucianR"] = true,
["GalioIdolOfDurand"] = true,
["MissFortuneBulletTime"] = true,
["XerathLocusPulse"] = true
}
local VARS = {
  AA = {RANGE = 600},
  W = {RANGE = 1200, DELAY = 0.5, SPEED = 2000, ANGLE = 57.5},
  R = {RANGE = 25000, DELAY = 0.5, SPEED = 1600, WIDTH = 100}
}

asheW = {range = VARS.W.RANGE, speed = VARS.W.SPEED, delay = VARS.W.DELAY, radius = 60, type = "DelayLine", width = 60}
asheR = {range = VARS.R.RANGE, speed = VARS.R.SPEED, delay = VARS.R.DELAY, radius = VARS.R.WIDTH, type = "DelayLine", width = VARS.R.WIDTH, collisionH = true, collisionM = false}


function OnLoad()
  
  AddApplyBuffCallback(Buff_Add)
  AddRemoveBuffCallback(Buff_Rem)
  AddProcessAttackCallback(Ashe_ProcessAttack)

  
  Menu = scriptConfig("[Hentai Ashe]", "HentaiAshe")
  Menu:addSubMenu("[Key Binds]", "Key")
  Menu.Key:addParam("combo", "Combo", SCRIPT_PARAM_ONKEYDOWN, false, string.byte(" "))
  Menu.Key:addParam("harras", "Harras", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
  Menu.Key:addParam("lasthit", "Lasthit", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("X"))
  Menu.Key:addParam("laneclear", "Laneclear/Jungleclear", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
  Menu.Key:addParam("tryR", "Manual ult", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("T"))

  Menu:addSubMenu("[Combo]", "Combo")
  Menu.Combo:addParam("useQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
  Menu.Combo:addParam("useW", "Use W", SCRIPT_PARAM_ONOFF, true)
  Menu.Combo:addParam("useR", "Enable R usage", SCRIPT_PARAM_ONKEYTOGGLE, true, string.byte("Z"))
  Menu.Combo:addSubMenu("Ult [R] whitelist", "whitelist")
  for i,enemy in pairs(GetEnemyHeroes()) do
    table.insert(YOLO, enemy.charName)
  end
  for i = 1, #YOLO do
    local a1 = "a"..i
    local a2 = ""..YOLO[i]
    Menu.Combo.whitelist:addParam(a1, a2, SCRIPT_PARAM_ONOFF, true)
  end
  Menu:addSubMenu("[Harras]", "Harras")
  Menu.Harras:addParam("useQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
  Menu.Harras:addParam("useW", "Use W", SCRIPT_PARAM_ONOFF, true)

  Menu:addSubMenu("[Farm]", "Farm")
  Menu.Farm:addSubMenu("[Lasthit]", "Lasthit")
  Menu.Farm.Lasthit:addParam("lasthitW", "Use W for lasthit", SCRIPT_PARAM_ONOFF, true)
  Menu.Farm.Lasthit:addParam("lasthitWmana", "% Mana for lasthit", SCRIPT_PARAM_SLICE, 60, 0, 100, 0)
  Menu.Farm:addSubMenu("[Clear]", "Laneclear")
  Menu.Farm.Laneclear:addParam("laneclearQ", "Use Q for clear", SCRIPT_PARAM_ONOFF, true)
  Menu.Farm.Laneclear:addParam("laneclearW", "Use W for clear", SCRIPT_PARAM_ONOFF, true)
  Menu.Farm.Laneclear:addParam("laneclearMana", "% Mana for clear", SCRIPT_PARAM_SLICE, 60, 0, 100, 0)

  Menu:addSubMenu("[Prediction]", "Prediction")
  Menu.Prediction:addParam("activePred", "Prediction (require reload [2x F9])", SCRIPT_PARAM_LIST, 1, {"VPred", "DPred", "FHPred", "KPred (disabled)"})
  if Menu.Prediction.activePred == 1 then
    if FileExist(LIB_PATH .. "VPrediction.lua") then
      require "VPrediction"
      VP = VPrediction()
      Menu.Prediction:addParam("WVPHC", "W HitChance", SCRIPT_PARAM_SLICE, 2, 1, 5, 0)
      Menu.Prediction:addParam("RVPHC", "R HitChance", SCRIPT_PARAM_SLICE, 2, 1, 5, 0)
    end
  elseif Menu.Prediction.activePred == 2 then
    if VIP_USER and FileExist(LIB_PATH.."DivinePred.lua") and FileExist(LIB_PATH.."DivinePred.luac") then
      require "DivinePred"
      DP = DivinePred()
      Menu.Prediction:addParam("WHC", "W HitChance %", SCRIPT_PARAM_SLICE, 75, 50, 100, 0)
      Menu.Prediction:addParam("RHC", "R HitChance %", SCRIPT_PARAM_SLICE, 75, 50, 100, 0)
    end
  elseif Menu.Prediction.activePred == 3 then
    if FileExist(LIB_PATH.."FHPrediction.lua") then
      require("FHPrediction")
      FHPred = true
      PrintChat("FHPrediction found")
      Menu.Prediction:addParam("infoFH", "FHPrediction found", SCRIPT_PARAM_INFO, "")
    else
      PrintChat("Something wrong with FHPred, contact developer")
    end
  end

  Menu:addSubMenu("[Item Usage]", "Item")
  Menu.Item:addParam("UseItem", "Enable Item Usage", SCRIPT_PARAM_ONOFF, true)
  Menu.Item:addSubMenu("[Offensive Items]", "AttackItem")
  Menu.Item.AttackItem:addParam("UseCutlass", "Use Bilgewater Cutlass", SCRIPT_PARAM_ONOFF, true)
  Menu.Item.AttackItem:addParam("UseBOTRK", "Use BOTRK", SCRIPT_PARAM_ONOFF, true)
  Menu.Item.AttackItem:addParam("UseYoumu", "Use Youmus Blade", SCRIPT_PARAM_ONOFF, true)
  Menu.Item.AttackItem:addParam("UseGunblade", "Use Hextech Gunblade", SCRIPT_PARAM_ONOFF, true)
  Menu.Item:addSubMenu("[Anti CC]", "DefItem")
  Menu.Item.DefItem:addParam("EnableACC", "Enable AntiCC", SCRIPT_PARAM_ONOFF, true)
  Menu.Item.DefItem:addParam("UseQSS", "Use Quicksilver Sash", SCRIPT_PARAM_ONOFF, true)
  Menu.Item.DefItem:addParam("UseDervish", "Use Dervish Blade", SCRIPT_PARAM_ONOFF, true)

  Menu:addSubMenu("[Draws]", "Draws")
  Menu.Draws:addParam("drawW", "Draw W range", SCRIPT_PARAM_ONOFF, true)
  Menu.Draws:addParam("drawRstatus", "Draw R status", SCRIPT_PARAM_ONOFF, true)
  Menu.Draws:addParam("drawHP", "Draw damage on HP bars", SCRIPT_PARAM_ONOFF, true)

  Menu:addSubMenu("[Auto]", "Auto")
  Menu.Auto:addParam("autoInterrupt", "Auto Interrupt important enemy spells", SCRIPT_PARAM_ONOFF, true)
  Menu.Auto:addParam("autoPots", "Auto Potions usage", SCRIPT_PARAM_ONOFF, true)
  Menu.Auto:addParam("autoPotsHealth", "% Health for autopots", SCRIPT_PARAM_SLICE, 75, 0, 100, 0)
  Menu.Auto:addParam("autoHeal", "Auto Heal usage", SCRIPT_PARAM_ONOFF, true)
  Menu.Auto:addParam("autoHealHealth", "% Health for Heal usage", SCRIPT_PARAM_SLICE, 10, 0, 100, 0)
  Menu.Auto:addParam("autoBarrier", "Auto Barrier usage", SCRIPT_PARAM_ONOFF, true)
  Menu.Auto:addParam("autoBarrierHealth", "% Health for Barrier usage", SCRIPT_PARAM_SLICE, 10, 0, 100, 0)

  Menu:addSubMenu("[Killsteal]", "KS")
  Menu.KS:addParam("ksW", "Use W for killsteal", SCRIPT_PARAM_ONOFF, true)
  Menu.KS:addParam("ksWaa", "KS with W only if enemy out of AA range", SCRIPT_PARAM_ONOFF, true)
  Menu.KS:addParam("ksR", "Use R for killsteal", SCRIPT_PARAM_ONOFF, true)
  Menu.KS:addParam("ksRaa", "KS with R only if enemy out of AA range", SCRIPT_PARAM_ONOFF, true)
  Menu.KS:addParam("ksIgnite", "Use Ignite for killsteal", SCRIPT_PARAM_ONOFF, true)
  Menu.KS:addParam("UseItems", "Use Items in Killsteal", SCRIPT_PARAM_ONOFF, true)

  Menu:addParam("info1", "", SCRIPT_PARAM_INFO, "")
  Menu:addParam("info2", ""..scriptname.." [ver. "..version.."]", SCRIPT_PARAM_INFO, "")
  Menu:addParam("info3", "Created by "..developer.."", SCRIPT_PARAM_INFO, "")
  Menu:addParam("info4", "Contact me: "..contact.."", SCRIPT_PARAM_INFO, "")

  
  igniteslot = FindSlotByName("summonerdot")
  healslot = FindSlotByName("summonerheal")
  barrierslot = FindSlotByName("summonerbarrier")

  
  PrintChat("<font color = \"#B13070\">[HENTAI ASHE]</font> <font color = \"#4DFF4D\">LOADED</font>")
end


function OnTick()
  if Menu.Auto.autoHeal then
    AutoHeal()
  end
  if Menu.Auto.autoBarrier then
    AutoBarrier()
  end
  Killsteal()
  if igniteslot ~= nil then
    AutoIgnite()
  end
  
  if UNDERCC and Menu.Item.UseItem and Menu.Item.DefItem.EnableACC then
    if Menu.Item.DefItem.UseQSS and QSS then
      CastQSS()
    end
    if Menu.Item.DefItem.UseDervish and DERVISH then
      CastDervish()
    end
  end
  
  if Menu.Key.tryR then
    TryR()
  end
  
  if Menu.Key.combo then
    Combo()
  end
  
  if Menu.Key.harras then
    Harras()
  end
  
  if Menu.Key.lasthit then
    Lasthit()
  end
  
  if Menu.Key.laneclear then
    Laneclear()
  end
  
  if Menu.Auto.autoPots then
    CheckFountain()
  end
  if Menu.Auto.autoPots and not REGEN and not FONTAN then
    AutoPotion()
  end
  
  if Menu.Item.UseItem then
    FindItems()
  end 
end


function OnDraw()
  if not myHero.dead then
    if Menu.Key.tryR then
      DrawFPSCircle(mousePos.x, mousePos.z, 150, ARGB(255,225,255,255), 3)
    end
    if Menu.Draws.drawW then
      DrawFPSCircle(myHero.x, myHero.z, VARS.W.RANGE, ARGB(255,225,255,255), 3)
    end
    if Menu.Draws.drawHP then
      DrawHPbar()
    end
    if Menu.Draws.drawRstatus then
      if Menu.Combo.useR then
        DrawText ("ULT SBTW USAGE ACTIVATED [Z]", 20, 150, 80, 0xFF00FF00)
      else
        DrawText ("ULT SBTW USAGE DEACTIVATED [Z]", 20, 150, 80, 0xFFFF0000)
      end
    end
  end
end


function isWhitelisted(enemy)
  local index = whitelistIndex(enemy)
  if index == 1 then
    if Menu.Combo.whitelist.a1 then
      return true
    else
      return false
    end
  end
  if index == 2 then
    if Menu.Combo.whitelist.a2 then
      return true
    else
      return false
    end
  end
  if index == 3 then
    if Menu.Combo.whitelist.a3 then
      return true
    else
      return false
    end
  end
  if index == 4 then
    if Menu.Combo.whitelist.a4 then
      return true
    else
      return false
    end
  end
  if index == 5 then
    if Menu.Combo.whitelist.a5 then
      return true
    else
      return false
    end
  end
end

function whitelistIndex(enemy)
  for i = 1, #YOLO do
    if enemy.charName == YOLO[i] then
      return i
    end
  end
end


function Combo()
  if CanCast(_Q) and Menu.Combo.useQ then
    local target = GetHentaiTarget(VARS.AA.RANGE)
    if target ~= nil then
      CastQ()
    end
  end
  if CanCast(_W) and Menu.Combo.useW then
    local target = GetHentaiTarget(VARS.W.RANGE)
    if target ~= nil then
      if GetRastoyanie(target, myHero) > VARS.AA.RANGE then
        CastW(target)
      end
    end
  end
end


function Harras()
  if CanCast(_Q) and Menu.Harras.useQ then
    local target = GetHentaiTarget(VARS.AA.RANGE)
    if target ~= nil then
      CastQ()
    end
  end
  if CanCast(_W) and Menu.Harras.useW then
    local target = GetHentaiTarget(VARS.W.RANGE)
    if target ~= nil then
      if GetRastoyanie(target, myHero) > VARS.AA.RANGE then
        CastW(target)
      end
    end
  end
end


function Laneclear()
  if ((myHero.mana*100)/myHero.maxMana) < Menu.Farm.Laneclear.laneclearMana then return end
  if CanCast(_Q) and Menu.Farm.Laneclear.laneclearQ then
    for _, minion in pairs(minionManager(MINION_ENEMY, VARS.AA.RANGE, myHero, MINION_SORT_HEALTH_ASC).objects) do
      if ValidTarget(minion, VARS.AA.RANGE) and GetRastoyanie(myHero, minion) <= VARS.AA.RANGE then
        CastQ()
      end
    end
    for _, minion in pairs(minionManager(MINION_JUNGLE, VARS.AA.RANGE, myHero, MINION_SORT_MAXHEALTH_DEC).objects) do
      if ValidTarget(minion, VARS.AA.RANGE) and GetRastoyanie(myHero, minion) <= VARS.AA.RANGE then
        CastQ()
      end
    end
  end
  if CanCast(_W) and Menu.Farm.Laneclear.laneclearW then
    for _, minion in pairs(minionManager(MINION_ENEMY, VARS.W.RANGE, myHero, MINION_SORT_HEALTH_ASC).objects) do
      if ValidTarget(minion, VARS.W.RANGE) and GetRastoyanie(myHero, minion) > VARS.AA.RANGE then
        CastWclear(minion)
      end
    end
    for _, minion in pairs(minionManager(MINION_JUNGLE, VARS.W.RANGE, myHero, MINION_SORT_MAXHEALTH_DEC).objects) do
      if ValidTarget(minion, VARS.W.RANGE) and GetRastoyanie(myHero, minion) > VARS.AA.RANGE then
        CastWclear(minion)
      end
    end
  end
end


function Lasthit()
  if ((myHero.mana*100)/myHero.maxMana) < Menu.Farm.Lasthit.lasthitWmana then return end
  if CanCast(_W) and Menu.Farm.Lasthit.lasthitW then
    for _, minion in pairs(minionManager(MINION_ENEMY, VARS.W.RANGE, myHero, MINION_SORT_HEALTH_ASC).objects) do
      if ValidTarget(minion, VARS.W.RANGE) and GetRastoyanie(myHero, minion) > VARS.AA.RANGE and minion.health <= GetWDamage(minion) then
        CastW(minion)
      end
    end
  end
end


function Killsteal()
  for i,enemy in pairs(GetEnemyHeroes()) do
    if isValid(enemy, 4000) and not CheckInvul(enemy) then
      local WDmg = GetWDamage(enemy)
      local RDmg = GetRDamage(enemy)
      if CanCast(_W) and Menu.KS.ksW and WDmg >= enemy.health and GetRastoyanie(myHero, enemy) <= VARS.W.RANGE then
        if Menu.KS.ksWaa then
          if GetRastoyanie(myHero, enemy) > VARS.AA.RANGE then
            CastW(enemy)
          end  
        else
          CastW(enemy)
        end
      end
      if CanCast(_R) and Menu.KS.ksR and RDmg >= enemy.health then
        if Menu.KS.ksRaa then
          if GetRastoyanie(myHero, enemy) > VARS.AA.RANGE then
            CastR(enemy)
          end
        else
          CastR(enemy)
        end
      end
      if GetRastoyanie(myHero, enemy) <= 550 then
        if BOTRK and Menu.KS.UseItems then
          local BOTRKDamage = GetBOTRKDamage(enemy)
          if BOTRKDamage >= enemy.health and CanCast(BOTRKSLOT) and not enemy.dead then
            CastBOTRK(enemy)
          end
        end
        if CUTLASS and Menu.KS.UseItems then
          local CutlassDamage = GetCutlassDamage(enemy)
          if CutlassDamage >= enemy.health and CanCast(CUTLASSSLOT) and not enemy.dead then
            CastCutlass(enemy)
          end
        end
      end
      if GetRastoyanie(myHero, enemy) <= 700 then
        if GUNBLADE and Menu.KS.UseItems then
          local GunbladeDamage = GetGunbladeDamage(enemy)
          if GunbladeDamage >= enemy.health and CanCast(GUNBLADESLOT) and not enemy.dead then
            CastGunblade(enemy)
          end
        end
      end
    end
  end
end


function DrawHPbar()
  for i, HPbarEnemyChamp in pairs(GetEnemyHeroes()) do
    if not HPbarEnemyChamp.dead and HPbarEnemyChamp.visible then
      local dmg = myHero:CalcDamage(HPbarEnemyChamp, myHero.totalDamage)
      if myHero:CanUseSpell(_Q) == READY and not HPbarEnemyChamp.dead then
        dmg = dmg + GetQDamage(HPbarEnemyChamp)
      end
      if CanCast(_W) then
        dmg = dmg + GetWDamage(HPbarEnemyChamp)
      end
      if myHero:CanUseSpell(_R) == READY and not HPbarEnemyChamp.dead then
        dmg = dmg + GetRDamage(HPbarEnemyChamp)
      end
      if igniteslot ~= nil then
        if CanCast(igniteslot) then
          dmg = dmg + (50 + 20*myHero.level)
        end
      end
      DrawLineHPBar(dmg, "", HPbarEnemyChamp, HPbarEnemyChamp.team)
    end
  end
end


function TryR()
  if not CanCast(_R) then return end
  for i,enemy in pairs(GetEnemyHeroes()) do
    if isValid(enemy, VARS.R.RANGE) and not CheckInvul(enemy) then
      if GetRastoyanie(enemy, mousePos) <= 200 then
        CastR(enemy)
      end
    end
  end
end


local invul = {"undyingrage", "sionpassivezombie", "aatroxpassivedeath", "chronoshift", "judicatorintervention"}

function CheckInvul(unit)
  for i,buff in pairs(invul) do
    if TargetHaveBuff(buff, unit) then
      return true
    end
  end
    return false
end

function GetHentaiTarget(range)
  local hentaiTarget = nil
  local lessCast = 0
  for i = 1, #GetEnemyHeroes() do
    local enemy = GetEnemyHeroes()[i]
    if isValid(enemy, range) and not CheckInvul(enemy) then
      local kArmor = (100+enemy.armor)/100
      local kKillable = kArmor*enemy.health
      if kKillable <= lessCast or lessCast == 0 then
        hentaiTarget = enemy
        lessCast = kKillable
      end
    end
  end
  return hentaiTarget
end

function isValid(object, range)
  return object ~= nil and object.valid and object.visible and not object.dead and object.bInvulnerable == 0
   and object.bTargetable and (range == nil or GetRastoyanie(object, myHero) <= range)
end


function Ashe_ProcessAttack(unit, spell)
  if not unit.isMe then return end
  if isAutoAttack(spell.name) and spell.target and spell.target.type ~= myHero.type and Menu.Key.laneclear then
    if ((myHero.mana*100)/myHero.maxMana) < Menu.Farm.Laneclear.laneclearMana then return end
    local AADmg = myHero:CalcDamage(spell.target, myHero.totalDamage)
    if AADmg < spell.target.health and CanCast(_W) and not spell.target.dead and not (spell.target.type == "obj_AI_Turret") then
      if CanCast(_W) and Menu.Farm.Laneclear.laneclearW then
        CastWclear(spell.target)
      end
    end
  end
  if isAutoAttack(spell.name) and spell.target and spell.target.type == myHero.type and Menu.Key.combo then
    local AADmg = myHero:CalcDamage(spell.target, myHero.totalDamage)
    CastYoumu()
    CastBOTRK(spell.target)
    CastCutlass(spell.target)
    CastGunblade(spell.target)
    if not spell.target.dead and not (AADmg >= spell.target.health) then
      if CanCast(_R) and Menu.Combo.useR and isWhitelisted(spell.target) then
        CastR(spell.target)
      end
    end
    if not spell.target.dead then
      if CanCast(_W) and Menu.Combo.useW then
        CastW(spell.target)
      end
    end
  end
  if isAutoAttack(spell.name) and spell.target and spell.target.type == myHero.type and Menu.Key.harras then
    local AADmg = myHero:CalcDamage(spell.target, myHero.totalDamage)
    if not spell.target.dead then
      if CanCast(_W) and Menu.Harras.useW then
        CastW(spell.target)
      end
    end
  end
end


function isAutoAttack(name)
  local lName = string.lower(name)
  return (string.find(lName, "attack") and not table.contains(NoAttacks,lName)) or table.contains(Attacks,lName)
end


function FindItems()
  if (Menu.Item.AttackItem.UseBOTRK) then
    GetBOTRK()
  end
  if (Menu.Item.AttackItem.UseCutlass) then
    GetCutlass()
  end
  if (Menu.Item.AttackItem.UseYoumu) then
    GetYoumu()
  end
  if (Menu.Item.AttackItem.UseGunblade) then
    GetGunblade()
  end
  if (Menu.Item.DefItem.UseQSS) then
    GetQSS()
  end
  if (Menu.Item.DefItem.UseDervish) then
    GetDervish()
  end
end

function GetCutlass()
  local slot = GetItem(ATTACKITEMS[1])
  if (slot ~= nil) then
    CUTLASS = true
    CUTLASSSLOT = slot
  else
    CUTLASS = false
  end
end

function GetYoumu()
  local slot = GetItem(ATTACKITEMS[2])
  if (slot ~= nil) then
    YOUMU = true
    YOUMUSLOT = slot
  else
    YOUMU = false
  end
end

function GetGunblade()
  local slot = GetItem(ATTACKITEMS[3])
  if (slot ~= nil) then
    GUNBLADE = true
    GUNBLADESLOT = slot
  else
    GUNBLADE = false
  end
end

function GetBOTRK()
  local slot = GetItem(ATTACKITEMS[4])
  if (slot ~= nil) then
    BOTRK = true
    BOTRKSLOT = slot
  else
    BOTRK = false
  end
end

function GetQSS()
  local slot = GetItem(ANTICCITEMS[1])
  if (slot ~= nil) then
    QSS = true
    QSSSLOT = slot
  else
    QSS = false
  end
end

function GetDervish()
  local slot = GetItem(ANTICCITEMS[2])
  if (slot ~= nil) then
    DERVISH = true
    DERVISHSLOT = slot
  else
    DERVISH = false
  end
end

function CastYoumu()
  if YOUMU then
    if (CanCast(YOUMUSLOT)) then
      CastSpell(YOUMUSLOT)
    end
  end
end

function CastBOTRK(target)
  if BOTRK then
    if (CanCast(BOTRKSLOT)) then
      CastSpell(BOTRKSLOT, target)
    end
  end
end

function CastCutlass(target)
  if CUTLASS then
    if (CanCast(CUTLASSSLOT)) then
      CastSpell(CUTLASSSLOT, target)
    end
  end
end

function CastGunblade(target)
  if GUNBLADE then
    if (CanCast(GUNBLADESLOT)) then
      CastSpell(GUNBLADESLOT, target)
    end
  end
end

function CastQSS()
  if QSS then
    if CanCast(QSSSLOT) then
      CastSpell(QSSSLOT)
    end
  end
end

function CastDervish()
  if DERVISH then
    if CanCast(DERVISHSLOT) then
      CastSpell(DERVISHSLOT)
    end
  end
end

function GetBOTRKDamage(unit)
  local Dmg = myHero:CalcDamage(unit, unit.maxHealth*0.1)
  return Dmg
end

function GetCutlassDamage(unit)
  local Dmg = myHero:CalcMagicDamage(unit, 100)
  return Dmg
end

function GetGunbladeDamage(unit)
  local Dmg = myHero:CalcMagicDamage(unit, 150+myHero.ap*0.4)
  return Dmg
end


function AutoIgnite()
  if igniteslot == nil then return end
  for i,enemy in pairs(GetEnemyHeroes()) do
    if not enemy.dead and enemy.visible then
      local rastoyanie = math.sqrt((enemy.x-myHero.x)*(enemy.x-myHero.x) + (enemy.z-myHero.z)*(enemy.z-myHero.z))
      if rastoyanie <= 600 then
        if ((50 + (20*myHero.level)) >= enemy.health and igniteslot ~= nil and myHero:CanUseSpell(igniteslot) == READY and
          ValidTarget(enemy, 600)) then 
          CastSpell(igniteslot, enemy)
        end
      end
    end
  end
end


function AutoPotion()
  for i=1, 5 do
    local pot = GetItem(POTS[i])
    if (pot ~= nil) then
      if (((myHero.health*100)/myHero.maxHealth) <= Menu.Auto.autoPotsHealth and not REGEN) then
        CastSpell(pot)
      end
    end
  end
end

function AutoHeal()
  if healslot == nil then return end
  if ((myHero.health*100)/myHero.maxHealth) <= Menu.Auto.autoHealHealth and CanCast(healslot) then
    CastSpell(healslot)
  end
end

function AutoBarrier()
  if barrierslot == nil then return end
  if ((myHero.health*100)/myHero.maxHealth) <= Menu.Auto.autoBarrierHealth and CanCast(barrierslot) then
    CastSpell(barrierslot)
  end
end


function OnProcessSpell(unit, spell)
  if Menu.Auto.autoInterrupt and unit and spell and CanCast(_R) then
    if unit.team ~= myHero.team and PussyOut[spell.name] ~= nil then
      if GetRastoyanie(myHero, unit) < 2000 then
        CastR(unit)
      end
    end
  end
end


function GetQDamage(unit)
  
  local Qlvl = myHero:GetSpellData(_Q).level
  if Qlvl < 1 then return 0 end
  local QDmg = {myHero.totalDamage*0.23, myHero.totalDamage*0.24, myHero.totalDamage*0.25, myHero.totalDamage*0.26, myHero.totalDamage*0.27}
  local QDmgMod = 1
  local DmgRaw = QDmg[Qlvl] + myHero.totalDamage * QDmgMod
  local Dmg = myHero:CalcDamage(unit, DmgRaw)
  return Dmg
end

function GetWDamage(unit)
  
  local Wlvl = myHero:GetSpellData(_W).level
  if Wlvl < 1 then return 0 end
  local WDmg = {20, 35, 50, 65, 80}
  local WDmgMod = 1
  local DmgRaw = WDmg[Wlvl] + myHero.totalDamage * WDmgMod
  local Dmg = myHero:CalcDamage(unit, DmgRaw)
  return Dmg
end

function GetRDamage(unit)
  
  local Rlvl = myHero:GetSpellData(_R).level
  if Rlvl < 1 then return 0 end
  local RDmg = {250, 425, 600}
  local RDmgMod = 1
  local DmgRaw = RDmg[Rlvl] + myHero.ap * RDmgMod
  local Dmg = myHero:CalcMagicDamage(unit, DmgRaw)
  return Dmg
end


function CastQ()
  CastSpell(_Q)
end

function CastW(unit)
  if unit == nil then return end
  if VP ~= nil then
    local CastPosition, HitChance = VP:GetLineCastPosition(unit, VARS.W.DELAY, 60, VARS.W.RANGE, VARS.W.SPEED, myHero, true)
    if HitChance >= Menu.Prediction.WVPHC then
      CastSpell(_W, CastPosition.x, CastPosition.z)
    end
  end
  if DP ~= nil then
    local state,hitPos,perc = DP:predict(nil,unit,myHero,SkillShot.TYPE.LINE,VARS.W.SPEED,VARS.W.RANGE,60,VARS.W.DELAY*1000,0,{Minions = true,Champions = true})
    if perc >= Menu.Prediction.WHC then
      CastSpell(_W, hitPos.x, hitPos.z)
    end
  end
  if FHPred and Menu.Prediction.activePred == 3 then
    local CastPosition, hc, info = FHPrediction.GetPrediction(asheW, unit)
    if hc > 0 and CastPosition ~= nil then
      CastSpell(_W, CastPosition.x, CastPosition.z)
    end
  end
  if KP ~= nil then
    local CastPosition, hc = KP:GetPrediction(asheW, unit, myHero)
    if hc >= Menu.Prediction.WKPHC then
      CastSpell(_W, CastPosition.x, CastPosition.z)
    end
  end
end

function CastWclear(minion)
  CastSpell(_W, minion.x, minion.z)
end

function CastR(unit)
  if unit == nil then return end
  if VP ~= nil then
    local CastPosition, HitChance = VP:GetLineCastPosition(unit, VARS.R.DELAY, VARS.R.WIDTH, VARS.R.RANGE, VARS.R.SPEED, myHero, false)
    if HitChance >= Menu.Prediction.RVPHC then
      CastSpell(_R, CastPosition.x, CastPosition.z)
    end
  end
  if DP ~= nil then
    local state,hitPos,perc = DP:predict(nil,unit,myHero,SkillShot.TYPE.LINE,VARS.R.SPEED,VARS.R.RANGE,VARS.R.WIDTH,VARS.R.DELAY*1000,0,{Minions = false,Champions = true})
    if perc >= Menu.Prediction.RHC then
      CastSpell(_R, hitPos.x, hitPos.z)
    end
  end
  if FHPred and Menu.Prediction.activePred == 3 then
    local CastPosition, hc, info = FHPrediction.GetPrediction(asheR, unit)
    if hc > 0 and CastPosition ~= nil then
      CastSpell(_R, CastPosition.x, CastPosition.z)
    end
  end
  if KP ~= nil then
    local CastPosition, hc = KP:GetPrediction(asheR, unit, myHero)
    if hc >= Menu.Prediction.RKPHC then
      CastSpell(_R, CastPosition.x, CastPosition.z)
    end
  end
end


function Buff_Add(unit, target, buff)
  if target then
    if not (unit.isMe or target.isMe) then return end
  else
    if not unit.isMe then return end
  end
  for j = 1, #CCSPELLS do
    if target then
      if target.isMe and buff.name == CCSPELLS[j] then
        UNDERCC = true
      end
    end
  end
  for i=1, 5 do
    if (buff.name == POTS[i] and unit.isMe) then
      REGEN = true
    end
  end
end

function Buff_Rem(unit, buff)
  if not unit.isMe then return end
  for j = 1, #CCSPELLS do
    if unit.isMe and buff.name == CCSPELLS[j] then
      UNDERCC = false
    end
  end
  for i=1, 5 do
    if (buff.name == POTS[i] and unit.isMe) then
      REGEN = false
    end
  end
end


function FindSlotByName(name)
  if name ~= nil then
    for i=0, 12 do
      if string.lower(myHero:GetSpellData(i).name) == string.lower(name) then
        return i
      end
    end
  end  
  return nil
end

function GetItem(name)
  local slot = FindSlotByName(name)
  return slot 
end


function DrawLineA(x1, y1, x2, y2, color)
  DrawLine(x1, y1, x2, y2, 1, color)
end

function DrawFPSCircle(xCoordinate, zCoordinate, radius, color, quality)
  for i=-radius*math.cos(math.pi/4), radius*math.cos(math.pi/4)-1, radius*math.cos(math.pi/4)/quality do
    local nigger = WorldToScreen(D3DXVECTOR3((xCoordinate+i), myHero.y, (zCoordinate + math.sqrt(radius*radius-i*i))))
    local stalin = WorldToScreen(D3DXVECTOR3((xCoordinate+i), myHero.y, (zCoordinate - math.sqrt(radius*radius-i*i))))
    local hentai = WorldToScreen(D3DXVECTOR3((xCoordinate+i+radius*math.cos(math.pi/4)/quality), myHero.y, 
      (zCoordinate + math.sqrt(radius*radius-(i+radius*math.cos(math.pi/4)/quality)*(i+radius*math.cos(math.pi/4)/quality)))))
    local ebola = WorldToScreen(D3DXVECTOR3((xCoordinate+i+radius*math.cos(math.pi/4)/quality), myHero.y, 
      (zCoordinate - math.sqrt(radius*radius-(i+radius*math.cos(math.pi/4)/quality)*(i+radius*math.cos(math.pi/4)/quality)))))

    if (nigger.x>0 and nigger.x<WINDOW_W) and (nigger.y>0 and nigger.y<WINDOW_H) and (hentai.x>0 and hentai.x<WINDOW_W) and (hentai.y>0 and hentai.y<WINDOW_H) then
      DrawLineA(nigger.x,nigger.y,hentai.x,hentai.y, color)
    end
    if (stalin.x>0 and stalin.x<WINDOW_W) and (stalin.y>0 and stalin.y<WINDOW_H) and (ebola.x>0 and ebola.x<WINDOW_W) and (ebola.y>0 and ebola.y<WINDOW_H) then
      DrawLineA(stalin.x,stalin.y,ebola.x,ebola.y, color)
    end
  end

  for i=-radius*math.cos(math.pi/4), radius*math.cos(math.pi/4)-1, radius*math.cos(math.pi/4)/quality do
    local nigger = WorldToScreen(D3DXVECTOR3((xCoordinate+math.sqrt(radius*radius-i*i)), myHero.y, (zCoordinate + i)))
    local stalin = WorldToScreen(D3DXVECTOR3((xCoordinate-math.sqrt(radius*radius-i*i)), myHero.y, (zCoordinate +i)))
    local hentai = WorldToScreen(D3DXVECTOR3((xCoordinate+math.sqrt(radius*radius-(i+radius*math.cos(math.pi/4)/quality)*(i+radius*math.cos(math.pi/4)/quality))), 
      myHero.y, (zCoordinate + i+radius*math.cos(math.pi/4)/quality)))
    local ebola = WorldToScreen(D3DXVECTOR3((xCoordinate-math.sqrt(radius*radius-(i+radius*math.cos(math.pi/4)/quality)*(i+radius*math.cos(math.pi/4)/quality))), 
      myHero.y, (zCoordinate + i+radius*math.cos(math.pi/4)/quality)))

    if (nigger.x>0 and nigger.x<WINDOW_W) and (nigger.y>0 and nigger.y<WINDOW_H) and (hentai.x>0 and hentai.x<WINDOW_W) and (hentai.y>0 and hentai.y<WINDOW_H) then
      DrawLineA(nigger.x,nigger.y,hentai.x,hentai.y, color)
    end
    if (stalin.x>0 and stalin.x<WINDOW_W) and (stalin.y>0 and stalin.y<WINDOW_H) and (ebola.x>0 and ebola.x<WINDOW_W) and (ebola.y>0 and ebola.y<WINDOW_H) then
      DrawLineA(stalin.x,stalin.y,ebola.x,ebola.y, color)
    end
  end
end


function GetHPBarPos(enemy)
  enemy.barData = {PercentageOffset = {x = -0.05, y = 0}}
  local barPos = GetUnitHPBarPos(enemy)
  local barPosOffset = GetUnitHPBarOffset(enemy)
  local barOffset = { x = enemy.barData.PercentageOffset.x, y = enemy.barData.PercentageOffset.y }
  local barPosPercentageOffset = { x = enemy.barData.PercentageOffset.x, y = enemy.barData.PercentageOffset.y }
  local BarPosOffsetX = -50
  local BarPosOffsetY = 46
  local CorrectionY = 39
  local StartHpPos = 31 
  barPos.x = math.floor(barPos.x + (barPosOffset.x - 0.5 + barPosPercentageOffset.x) * BarPosOffsetX + StartHpPos)
  barPos.y = math.floor(barPos.y + (barPosOffset.y - 0.5 + barPosPercentageOffset.y) * BarPosOffsetY + CorrectionY)
  local StartPos = Vector(barPos.x , barPos.y, 0)
  local EndPos = Vector(barPos.x + 108 , barPos.y , 0)    
  return Vector(StartPos.x, StartPos.y, 0), Vector(EndPos.x, EndPos.y, 0)
end

function DrawLineHPBar(damage, text, unit, enemyteam)
  if unit.dead or not unit.visible then return end
  local p = WorldToScreen(D3DXVECTOR3(unit.x, unit.y, unit.z))
  if not OnScreen(p.x, p.y) then return end
  local thedmg = 0
  local line = 2
  local linePosA  = {x = 0, y = 0 }
  local linePosB  = {x = 0, y = 0 }
  local TextPos   = {x = 0, y = 0 }

  if damage >= unit.health then
    thedmg = unit.health - 1
    text = "KILLABLE!"
  else
    thedmg = damage
    text = "Possible Damage"
  end

  thedmg = math.round(thedmg)

  local StartPos, EndPos = GetHPBarPos(unit)
  local Real_X = StartPos.x + 24
  local Offs_X = (Real_X + ((unit.health - thedmg) / unit.maxHealth) * (EndPos.x - StartPos.x - 2))
  if Offs_X < Real_X then Offs_X = Real_X end 
  local mytrans = 350 - math.round(255*((unit.health-thedmg)/unit.maxHealth))
  if mytrans >= 255 then mytrans=254 end
  local my_bluepart = math.round(400*((unit.health-thedmg)/unit.maxHealth))
  if my_bluepart >= 255 then my_bluepart=254 end

  if enemyteam then
    linePosA.x = Offs_X-150
    linePosA.y = (StartPos.y-(30+(line*15)))    
    linePosB.x = Offs_X-150
    linePosB.y = (StartPos.y-10)
    TextPos.x = Offs_X-148
    TextPos.y = (StartPos.y-(30+(line*15)))
  else
    linePosA.x = Offs_X-125
    linePosA.y = (StartPos.y-(30+(line*15)))    
    linePosB.x = Offs_X-125
    linePosB.y = (StartPos.y-15)

    TextPos.x = Offs_X-122
    TextPos.y = (StartPos.y-(30+(line*15)))
  end

  DrawLine(linePosA.x, linePosA.y, linePosB.x, linePosB.y , 2, ARGB(mytrans, 255, my_bluepart, 0))
  DrawText(tostring(thedmg).." "..tostring(text), 15, TextPos.x, TextPos.y , ARGB(mytrans, 255, my_bluepart, 0))
end


function isTurret(obj)
  local flag = false
  if obj ~= nil then
    for i=1,#TURRETS do
      if obj.name == TURRETS[i] then
        flag = true
      end
    end
  end
  return flag
end


function GetRastoyanie(a, b)
  local rastoyanie = math.sqrt((b.x-a.x)*(b.x-a.x) + (b.z-a.z)*(b.z-a.z))
  return rastoyanie
end


function CanCast(spell)
  return myHero:CanUseSpell(spell) == READY
end


function CheckFountain()
  if not GetGame().map.index == 15 then return end
  if myHero.team == 100 then
    local rastoyanieDown = math.sqrt((myHero.x-lowBase.x)*(myHero.x-lowBase.x) + (myHero.z-lowBase.z)*(myHero.z-lowBase.z))
    if rastoyanieDown < 900 then
      FONTAN = true
    else
      FONTAN = false
    end
  elseif myHero.team == 200 then
    local rastoyanieUp = math.sqrt((myHero.x-upBase.x)*(myHero.x-upBase.x) + (myHero.z-upBase.z)*(myHero.z-upBase.z))
    if rastoyanieUp < 900 then
      FONTAN = true
    else
      FONTAN = false
    end
  end
end