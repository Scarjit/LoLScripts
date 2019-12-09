--[[
   ▄█    █▄       ▄████████ ███▄▄▄▄       ███        ▄████████  ▄█  
  ███    ███     ███    ███ ███▀▀▀██▄ ▀█████████▄   ███    ███ ███  
  ███    ███     ███    █▀  ███   ███    ▀███▀▀██   ███    ███ ███▌ 
 ▄███▄▄▄▄███▄▄  ▄███▄▄▄     ███   ███     ███   ▀   ███    ███ ███▌ 
▀▀███▀▀▀▀███▀  ▀▀███▀▀▀     ███   ███     ███     ▀███████████ ███▌ 
  ███    ███     ███    █▄  ███   ███     ███       ███    ███ ███  
  ███    ███     ███    ███ ███   ███     ███       ███    ███ ███  
  ███    █▀      ██████████  ▀█   █▀     ▄████▀     ███    █▀  █▀   
                                                                    
   ▄█   ▄█▄    ▄████████    ▄████████   ▄▄▄▄███▄▄▄▄      ▄████████  
  ███ ▄███▀   ███    ███   ███    ███ ▄██▀▀▀███▀▀▀██▄   ███    ███  
  ███▐██▀     ███    ███   ███    ███ ███   ███   ███   ███    ███  
 ▄█████▀      ███    ███  ▄███▄▄▄▄██▀ ███   ███   ███   ███    ███  
▀▀█████▄    ▀███████████ ▀▀███▀▀▀▀▀   ███   ███   ███ ▀███████████  
  ███▐██▄     ███    ███ ▀███████████ ███   ███   ███   ███    ███  
  ███ ▀███▄   ███    ███   ███    ███ ███   ███   ███   ███    ███  
  ███   ▀█▀   ███    █▀    ███    ███  ▀█   ███   █▀    ███    █▀   
  ▀                        ███    ███                               
--]]
--ver. 0.24

if myHero.charName ~= "Karma" then return end


assert(load(Base64Decode("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"), nil, "bt", _ENV))()
TrackerLoad("HqJ7Zu2sjLZnsRvO")



local version = "0.24"
local scriptname = "Hentai Karma"
local developer = "remembermyhentai"
local contact = "skype xd_kikass"
local REGEN, EMPOWERED, FONTAN = false
local ATTACKED = false
local FOCUSED = nil
local lowBase = {["x"] = 406, ["z"] = 424}
local upBase = {["x"] = 14322, ["z"] = 14394}
local POTS = {"ItemCrystalFlask", "RegenerationPotion", "ItemMiniRegenPotion", "ItemCrystalFlaskJungle", "ItemDarkCrystalFlask"}
local YOLO = {}
local ATTACKITEMS = {"ItemWillBoltSpellBase"}
local BOLT, BOLTSLOT
local VARS = {
  AA = {RANGE = 575},
  Q = {RANGE = 950, WIDTH = 60, DELAY = 0.25, SPEED = 1700},
  W = {RANGE = 700},
  E = {RANGE = 800}
}

local FAKER = {["AkaliMota"] = {delay = 0.1, ult = false, tricky = false},
["Headbutt"] = {delay = 0.1, ult = false, tricky = false},
["CaitlynAceintheHole"] = {delay = 1, ult = false, tricky = true},
["Feast"] = {delay = 0.1, ult = true, tricky = false},
["DariusExecute"] = {delay = 0.1, ult = true, tricky = true},
["VolibearW"] = {delay = 0.1, ult = false, tricky = false},
["GarenR"] = {delay = 0.1, ult = true, tricky = false},
["JudicatorReckoning"] = {delay = 0.1, ult = false, tricky = false},
["DianaTeleport"] = {delay = 0.1, ult = false, tricky = false},
["Terrify"] = {delay = 0, ult = false, tricky = true},
["FiddlesticksDarkWind"] = {delay = 0.1, ult = false, tricky = false},
["TristanaR"] = {delay = 0.1, ult = false, tricky = false},
["TristanaE"] = {delay = 0.1, ult = false, tricky = false},
["KhazixQ"] = {delay = 0.1, ult = false, tricky = false},
["LuluWTwo"] = {delay = 0.1, ult = false, tricky = true},
["khazixqlong"] = {delay = 0.1, ult = false, tricky = false},
["TwoShivPoison"] = {delay = 0.1, ult = false, tricky = false},
["BlindMonkRKick"] = {delay = 0.1, ult = false, tricky = true},
["AlZaharNetherGrasp"] = {delay = 0, ult = false, tricky = true},
["LissandraR"] = {delay = 0.1, ult = true, tricky = true},
["MaokaiUnstableGrowth"] = {delay = 0.1, ult = false, tricky = true},
["MordekaiserChildrenOfTheGrave"] = {delay = 0, ult = false, tricky = false},
["NasusW"] = {delay = 0.1, ult = false, tricky = false},
["NocturneUnspeakableHorror"] = {delay = 0, ult = false, tricky = false},
["IceBlast"] = {delay = 0.1, ult = false, tricky = false},
["OlafRecklessStrike"] = {delay = 0.1, ult = false, tricky = false},
["PantheonW"] = {delay = 0.1, ult = false, tricky = true},
["PuncturingTaunt"] = {delay = 0, ult = false, tricky = false},
["RyzeW"] = {delay = 0, ult = false, tricky = true},
["BrandWildfire"] = {delay = 0.1, ult = false, tricky = false},
["Fling"] = {delay = 0, ult = false, tricky = false},
["SkarnerImpale"] = {delay = 0.1, ult = false, tricky = true},
["IreliaEquilibriumStrike"] = {delay = 0.1, ult = false, tricky = true},
["JayceThunderingBlow"] = {delay = 0, ult = false, tricky = false},
["LeblancChaosOrb"] = {delay = 0.1, ult = false, tricky = true},
["LeblancChaosOrbM"] = {delay = 0.1, ult = false, tricky = false},
["tahmkenchw"] = {delay = 0.1, ult = false, tricky = false},
["SyndraR"] = {delay = 0.1, ult = false, tricky = false},
["Dazzle"] = {delay = 0.1, ult = false, tricky = false},
["BlindingDart"] = {delay = 0.1, ult = false, tricky = false},
["bluecardpreattack"] = {delay = 0.1, ult = false, tricky = false},
["redcardpreattack"] = {delay = 0.1, ult = false, tricky = false},
["VayneCondemn"] = {delay = 0.1, ult = false, tricky = true},
["VeigarPrimordialBurst"] = {delay = 0.1, ult = true, tricky = false},
["InfiniteDuress"] = {delay = 0, ult = false, tricky = false},
["zedult"] = {delay = 0.74, ult = true, tricky = false},
["Parley"] = {delay = 0.1, ult = false, tricky = false},
["KarthusFallenOne"] = {delay = 2.5, ult = false, tricky = true},
["Disintegrate"] = {delay = 0.1, ult = false, tricky = false},
["ViR"] = {delay = 0.1, ult = false, tricky = true}
}
local karmaQ = {range = VARS.Q.RANGE, speed = VARS.Q.SPEED, delay = VARS.Q.DELAY, radius = VARS.Q.WIDTH, type = "DelayLine", width = VARS.Q.WIDTH, collision = true}


function OnLoad()
  
  AddApplyBuffCallback(Buff_Add)
  AddRemoveBuffCallback(Buff_Rem)
  AddProcessAttackCallback(Karma_ProcessAttack)

  
  Menu = scriptConfig("[Hentai Karma]", "HentaiKarma")
  Menu:addSubMenu("[Key Binds]", "Key")
  Menu.Key:addParam("combo", "Combo", SCRIPT_PARAM_ONKEYDOWN, false, string.byte(" "))
  Menu.Key:addParam("harras", "Harras", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
  Menu.Key:addParam("lasthit", "Lasthit", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("X"))
  Menu.Key:addParam("laneclear", "Laneclear/Jungleclear", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
  Menu.Key:addParam("flee", "Flee", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("Z"))

  Menu:addSubMenu("[Combo]", "Combo")
  Menu.Combo:addParam("focus", "Focus selected Target/stick", SCRIPT_PARAM_ONOFF, true)
  Menu.Combo:addParam("useGLP", "Use GLP-800", SCRIPT_PARAM_ONOFF, true)
  Menu.Combo:addParam("useQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
  Menu.Combo:addParam("useMinionQ", "Use Q through minions", SCRIPT_PARAM_ONOFF, true)
  Menu.Combo:addParam("useW", "Use W", SCRIPT_PARAM_ONOFF, true)
  Menu.Combo:addParam("useE", "Use E as gapcloser", SCRIPT_PARAM_ONOFF, true)
  Menu.Combo:addParam("useEMana", "% Mana for E gapclose", SCRIPT_PARAM_SLICE, 50, 0, 100, 0)
  Menu.Combo:addParam("useR", "Use R", SCRIPT_PARAM_ONOFF, true)

  Menu:addSubMenu("[Harras]", "Harras")
  Menu.Harras:addParam("useQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
  Menu.Harras:addParam("useMinionQ", "Use Q through minions", SCRIPT_PARAM_ONOFF, true)
  Menu.Harras:addParam("useEmpQ", "Use empowered Q", SCRIPT_PARAM_ONOFF, true)
  Menu.Harras:addParam("useW", "Use W", SCRIPT_PARAM_ONOFF, false)

  Menu:addSubMenu("[Prediction]", "Prediction")
  Menu.Prediction:addParam("activePred", "Prediction (require reload)", SCRIPT_PARAM_LIST, 1, {"VPred", "DPred", "FHPred", "KPred"})
  if Menu.Prediction.activePred == 1 then
    if FileExist(LIB_PATH .. "VPrediction.lua") then
      require "VPrediction"
      VP = VPrediction()
      Menu.Prediction:addParam("QVPHC", "Q HitChance", SCRIPT_PARAM_SLICE, 2, 1, 5, 0)
    end
  elseif Menu.Prediction.activePred == 2 then
    if VIP_USER and FileExist(LIB_PATH.."DivinePred.lua") and FileExist(LIB_PATH.."DivinePred.luac") then
      require "DivinePred"
      DP = DivinePred()
      Menu.Prediction:addParam("QHC", "Q HitChance %", SCRIPT_PARAM_SLICE, 75, 50, 100, 0)
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
  elseif Menu.Prediction.activePred == 4 then
    if FileExist(LIB_PATH.."KPrediction.lua") then
      require "KPrediction"
      KP = KPrediction()
      Menu.Prediction:addParam("QKPHC", "Q HitChance", SCRIPT_PARAM_SLICE, 1.5, 1, 2, 1)
    end  
  end

  Menu:addSubMenu("[Farm]", "Farm")
  Menu.Farm:addSubMenu("[Lasthit]", "Lasthit")
  Menu.Farm.Lasthit:addParam("lasthitQ", "Use Q for lasthit", SCRIPT_PARAM_ONOFF, true)
  Menu.Farm.Lasthit:addParam("lasthitQmana", "% Mana for lasthit", SCRIPT_PARAM_SLICE, 60, 0, 100, 0)
  Menu.Farm:addSubMenu("[Clear]", "Laneclear")
  Menu.Farm.Laneclear:addParam("laneclearQ", "Use Q for clear", SCRIPT_PARAM_ONOFF, true)
  Menu.Farm.Laneclear:addParam("laneclearR", "Use R for clear", SCRIPT_PARAM_ONOFF, false)
  Menu.Farm.Laneclear:addParam("laneclearMana", "% Mana for clear", SCRIPT_PARAM_SLICE, 30, 0, 100, 0)

  Menu:addSubMenu("[Draws]", "Draws")
  Menu.Draws:addParam("drawTarget", "Draw target", SCRIPT_PARAM_ONOFF, true)
  Menu.Draws:addParam("drawQ", "Draw Q range", SCRIPT_PARAM_ONOFF, true)
  Menu.Draws:addParam("drawW", "Draw W range", SCRIPT_PARAM_ONOFF, false)
  Menu.Draws:addParam("drawE", "Draw E range", SCRIPT_PARAM_ONOFF, false)
  Menu.Draws:addParam("drawHP", "Draw damage on HP bars", SCRIPT_PARAM_ONOFF, true)

  Menu:addSubMenu("[Auto]", "Auto")
  Menu.Auto:addParam("autoPots", "Auto Potions usage", SCRIPT_PARAM_ONOFF, true)
  Menu.Auto:addParam("autoPotsHealth", "% Health for autopots", SCRIPT_PARAM_SLICE, 75, 0, 100, 0)
  Menu.Auto:addParam("autoW", "Auto W in comfort zone", SCRIPT_PARAM_ONOFF, true)
  Menu.Auto:addParam("comfortRange", "Comfort zone range", SCRIPT_PARAM_SLICE, 350, 200, VARS.W.RANGE, 0)
  for i,enemy in pairs(GetAllyHeroes()) do
    table.insert(YOLO, enemy.charName)
  end
  Menu.Auto:addParam("autoE", "Auto E usage", SCRIPT_PARAM_ONOFF, true)
  Menu.Auto:addParam("autoEHealth", "% Health for auto E", SCRIPT_PARAM_SLICE, 75, 0, 100, 0)
  Menu.Auto:addSubMenu("[E whitelist]", "whitelistE")
  for i = 1, #YOLO do
    local a1 = "a"..i
    local a2 = ""..YOLO[i]
    Menu.Auto.whitelistE:addParam(a1, "Cast E on "..a2, SCRIPT_PARAM_ONOFF, true)
  end
  Menu.Auto.whitelistE:addParam("me", "Cast E on mySelf", SCRIPT_PARAM_ONOFF, true)

  Menu:addSubMenu("[Killsteal]", "KS")
  Menu.KS:addParam("ksQ", "Use Q for killsteal", SCRIPT_PARAM_ONOFF, true)
  Menu.KS:addParam("ksW", "Use W for killsteal", SCRIPT_PARAM_ONOFF, true)
  Menu.KS:addParam("ksR", "Use R for killsteal", SCRIPT_PARAM_ONOFF, true)
  Menu.KS:addParam("ksIgnite", "Use Ignite for killsteal", SCRIPT_PARAM_ONOFF, true)

  Menu:addParam("info1", "", SCRIPT_PARAM_INFO, "")
  Menu:addParam("info2", ""..scriptname.." [ver. "..version.."]", SCRIPT_PARAM_INFO, "")
  Menu:addParam("info3", "Created by "..developer.."", SCRIPT_PARAM_INFO, "")
  Menu:addParam("info4", "Contact me: "..contact.."", SCRIPT_PARAM_INFO, "")

  
  igniteslot = FindSlotByName("summonerdot")

  
  PrintChat("<font color = \"#B13070\">[HENTAI KARMA]</font> <font color = \"#4DFF4D\">LOADED</font>")
end


function OnTick()
  if Menu.Key.flee then
    Flee()
  end
  if Menu.Auto.autoW then
    autoW()
  end
  if Menu.Auto.autoE then
    AutoE()
    AutoEme()
  end
  if FOCUSED ~= nil then
    if FOCUSED.dead or not FOCUSED.visible then
      FOCUSED = nil
    end
  end
  if igniteslot ~= nil then
    AutoIgnite()
  end
  Killsteal()
  
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

  FindItems()
end


function OnDraw()
  if not myHero.dead then
    if Menu.Draws.drawQ then
      DrawFPSCircle(myHero.x, myHero.z, VARS.Q.RANGE, ARGB(255,225,255,255), 3)
    end
    if Menu.Draws.drawW then
      DrawFPSCircle(myHero.x, myHero.z, VARS.W.RANGE, ARGB(255,225,255,255), 3)
    end
    if Menu.Draws.drawE then
      DrawFPSCircle(myHero.x, myHero.z, VARS.E.RANGE, ARGB(255,225,255,255), 3)
    end
    if Menu.Draws.drawHP then
      DrawHPbar()
    end
    if Menu.Draws.drawTarget then
      DrawSelectedTarget()
    end
  end
end


function DrawHPbar()
  for i, HPbarEnemyChamp in pairs(GetEnemyHeroes()) do
    if not HPbarEnemyChamp.dead and HPbarEnemyChamp.visible then
      local dmg = myHero:CalcDamage(HPbarEnemyChamp, myHero.totalDamage)
      if myHero:CanUseSpell(_Q) == READY and not HPbarEnemyChamp.dead then
        if CanCast(_R) then
          dmg = dmg + GetEmpQDamage(HPbarEnemyChamp)
        else
          dmg = dmg + GetQDamage(HPbarEnemyChamp)
        end
      end
      if CanCast(_W) then
        dmg = dmg + GetWDamage(HPbarEnemyChamp)
      end
      DrawLineHPBar(dmg, "", HPbarEnemyChamp, HPbarEnemyChamp.team)
    end
  end
end


function Flee()
  if GetRastoyanie(mousePos, myHero) > 300 then
    local a = (mousePos.x - myHero.x)/GetRastoyanie(mousePos, myHero) * 300 + myHero.x
    local b = (mousePos.z - myHero.z)/GetRastoyanie(mousePos, myHero) * 300 + myHero.z
    myHero:MoveTo(a, b)
  else
    myHero:MoveTo(mousePos.x, mousePos.z)
  end
  if CanCast(_E) then
    CastE(myHero)
  end
end


function Combo()
  if Menu.Combo.useGLP and BOLT then
    if CanCast(BOLTSLOT) then
      local target = GetHentaiTarget(825)
      if target ~= nil then
        if GetRastoyanie(myHero,target) <= 825 then
          CastBOLT(target)
        end
      end
    end
  end
  if ((myHero.health*100)/myHero.maxHealth) <= 40 and CanCast(_W) then
    local targetW = GetHentaiTarget(VARS.W.RANGE - 50)
    if targetW then
      CastR()
      CastW(targetW)
    end
  end
  if CanCast(_Q) and Menu.Combo.useQ then
    local target = GetHentaiTarget(VARS.Q.RANGE)
    if target ~= nil then
      CastQ(target)
      if Menu.Combo.useMinionQ and CanCast(_Q) then
        if CanCast(_R) then
          for _, minion in pairs(minionManager(MINION_ENEMY, VARS.Q.RANGE, myHero, MINION_SORT_HEALTH_ASC).objects) do
            if isValid(minion, VARS.Q.RANGE) and GetRastoyanie(target, minion) <= 150 then
              CastQ(minion)
            end
          end
        else
          for _, minion in pairs(minionManager(MINION_ENEMY, VARS.Q.RANGE, myHero, MINION_SORT_HEALTH_ASC).objects) do
            if isValid(minion, VARS.Q.RANGE) and GetRastoyanie(target, minion) <= 100 then
              CastQ(minion)
            end
          end
        end
      end
    end
  end
  if CanCast(_W) and not EMPOWERED and Menu.Combo.useW then
    local target = GetHentaiTarget(VARS.W.RANGE)
    if target ~= nil then
      if GetRastoyanie(myHero, target) <= VARS.W.RANGE then
        CastW(target)
      end
    end
  end
  if CanCast(_E) and Menu.Combo.useE and ((myHero.mana*100)/myHero.maxMana) >= Menu.Combo.useEMana then
    local target = GetHentaiTarget(VARS.Q.RANGE + 300)
    if target ~= nil then
      if GetRastoyanie(myHero, target) > VARS.Q.RANGE then
        CastE(myHero)
      end
    end
  end
end


function FindItems()
  GetBolt()
end

function GetBolt()
  local slot = GetItem(ATTACKITEMS[1])
  if (slot ~= nil) then
    BOLT = true
    BOLTSLOT = slot
  else
    BOLT = false
  end
end

function CastBOLT(unit)
  if BOLT then
    CastSpell(BOLTSLOT, unit)
  end
end


function Harras()
  if CanCast(_Q) and Menu.Harras.useQ then
    local target = GetHentaiTarget(VARS.Q.RANGE)
    if target ~= nil then
      CastQ(target)
      if Menu.Harras.useMinionQ and CanCast(_Q) then
        if CanCast(_R) then
          for _, minion in pairs(minionManager(MINION_ENEMY, VARS.Q.RANGE, myHero, MINION_SORT_HEALTH_ASC).objects) do
            if isValid(minion, VARS.Q.RANGE) and GetRastoyanie(target, minion) <= 175 then
              CastQ(minion)
            end
          end
        else
          for _, minion in pairs(minionManager(MINION_ENEMY, VARS.Q.RANGE, myHero, MINION_SORT_HEALTH_ASC).objects) do
            if isValid(minion, VARS.Q.RANGE) and GetRastoyanie(target, minion) <= 100 then
              CastQ(minion)
            end
          end
        end
      end
    end
  end
  if CanCast(_W) and not EMPOWERED and Menu.Harras.useW then
    local target = GetHentaiTarget(VARS.W.RANGE)
    if target ~= nil then
      if GetRastoyanie(myHero, target) <= VARS.W.RANGE then
        CastW(target)
      end
    end
  end
end


function Laneclear()
  if ((myHero.mana*100)/myHero.maxMana) <= Menu.Farm.Laneclear.laneclearMana then return end
  if CanCast(_Q) and Menu.Farm.Laneclear.laneclearQ then
    local CastPosition, NumHit = GetBestCircularFarmPosition(VARS.Q.RANGE, 150, minionManager(MINION_ENEMY, VARS.Q.RANGE, myHero, MINION_SORT_HEALTH_ASC).objects)
    if CastPosition ~= nil then
      if Menu.Farm.Laneclear.laneclearR and CanCast(_R) then
        CastR()
      end
      CastSpell(_Q, CastPosition.x, CastPosition.z)
    end
  end
  if CanCast(_Q) and Menu.Farm.Laneclear.laneclearQ then
    local CastPosition, NumHit = GetBestCircularFarmPosition(VARS.Q.RANGE, VARS.Q.WIDTH, minionManager(MINION_JUNGLE, VARS.Q.RANGE, myHero, MINION_SORT_MAXHEALTH_DEC).objects)
    if CastPosition ~= nil then
      if Menu.Farm.Laneclear.laneclearR and CanCast(_R) then
        CastR()
      end
      CastSpell(_Q, CastPosition.x, CastPosition.z)
    end
  end
end

function GetBestCircularFarmPosition(range, radius, objects)
  local BestPos 
  local BestHit = 0
  for i, object in ipairs(objects) do
    local hit = CountObjectsNearPos(object.pos or object, range, radius, objects)
    if hit > BestHit then
      BestHit = hit
      BestPos = Vector(object)
      if BestHit == #objects then
        break
      end
    end
  end
  return BestPos, BestHit
end

function CountObjectsNearPos(pos, range, radius, objects)
  local n = 0
  for i, object in ipairs(objects) do
    if GetDistanceSqr(pos, object) <= radius * radius then
      n = n + 1
    end
  end
  return n
end


function Lasthit()
  if not Menu.Farm.Lasthit.lasthitQ  then return end
  if ((myHero.mana*100)/myHero.maxMana) <= Menu.Farm.Lasthit.lasthitQmana then return end 
  for _, minion in pairs(minionManager(MINION_ENEMY, VARS.Q.RANGE, myHero, MINION_SORT_HEALTH_ASC).objects) do
    if ValidTarget(minion, VARS.Q.RANGE) then
      local QDmg = GetQDamage(minion)
      if QDmg >= minion.health then
        CastQ(minion)
      end
    end
  end
end


function Killsteal()
  for i,enemy in pairs(GetEnemyHeroes()) do
    if isValid(enemy, VARS.Q.RANGE) and not CheckInvul(enemy) then
      local QDmg = GetQDamage(enemy)
      local EmpQDmg = GetEmpQDamage(enemy)
      local WDmg = GetWDamage(enemy)
      if CanCast(_R) and CanCast(_Q) and Menu.KS.ksQ and Menu.KS.ksR and EmpQDmg >= enemy.health then
        CastR()
        CastQ(enemy)
      end
      if CanCast(_Q) and Menu.KS.ksQ and QDmg >= enemy.health then
        CastQ(enemy)
      end
      if CanCast(_W) and Menu.KS.ksW and WDmg >= enemy.health and GetRastoyanie(myHero, enemy) <= VARS.W.RANGE then
        CastW(enemy)
      end
    end
  end
end


function autoW()
  if not CanCast(_W) then return end
  for i,enemy in pairs(GetEnemyHeroes()) do
    if isValid(enemy, Menu.Auto.comfortRange) and not CheckInvul(enemy) then
      CastW(enemy)
    end
  end
end


function Karma_ProcessAttack(unit, spell)
  if unit ~= nil and spell ~= nil then
    if GetRastoyanie(myHero, unit) <= 1000 then
      if spell.target == myHero then
        ATTACKED = true
        DelayAction(function() ATTACKED = false end, 1)
      end
    end
  end
end


function AutoE()
  if not CanCast(_E) then return end
  for i,enemy in pairs(GetAllyHeroes()) do
    if not enemy.dead and GetRastoyanie(myHero, enemy) <= VARS.E.RANGE and isWhitelistedforE(enemy) and ((enemy.health*100)/enemy.maxHealth <= Menu.Auto.autoEHealth) and EnemyNear(enemy) then
      CastE(enemy)
    end
  end
end

function AutoEme()
  if not CanCast(_E) then return end
  if Menu.Auto.autoE and Menu.Auto.whitelistE.me and ((myHero.health*100)/myHero.maxHealth <= Menu.Auto.autoEHealth) and EnemyNearMe() and ATTACKED then
    CastE(myHero)
  end
end


function EnemyNear(unit)
  local bitch = false
  for i,enemy in pairs(GetEnemyHeroes()) do
    if isValid(enemy) then
      if GetRastoyanie(unit, enemy) <= 500 then
        bitch = true
      end
    end
  end
  return bitch
end

function EnemyNearMe()
  local bitch = false
  for i,enemy in pairs(GetEnemyHeroes()) do
    if isValid(enemy) then
      if GetRastoyanie(myHero, enemy) <= 700 then
        bitch = true
      end
    end
  end
  return bitch
end


function isWhitelistedforE(enemy)
  local index = whitelistIndex(enemy)
  if index == 1 then
    if Menu.Auto.whitelistE.a1 then
      return true
    else
      return false
    end
  end
  if index == 2 then
    if Menu.Auto.whitelistE.a2 then
      return true
    else
      return false
    end
  end
  if index == 3 then
    if Menu.Auto.whitelistE.a3 then
      return true
    else
      return false
    end
  end
  if index == 4 then
    if Menu.Auto.whitelistE.a4 then
      return true
    else
      return false
    end
  end
  if index == 5 then
    if Menu.Auto.whitelistE.a5 then
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


function OnProcessSpell(unit, spell)
  local topkek = false
  if spell ~= nil and spell.target ~= nil and unit ~= nil then
    if spell.target.isMe and unit.team ~= myHero.team then
      ATTACKED = true
      DelayAction(function() ATTACKED = false end, 1)
    end
    if FAKER[spell.name] ~= nil and spell.target.isMe then
      if CanCast(_W) and FAKER[spell.name].tricky and GetRastoyanie(myHero, unit) <= VARS.W.RANGE then
        CastW(unit)
      end
      if CanCast(_E) then
        CastE(myHero)
      end
      if FAKER[spell.name].ult then
        if CanCast(_R) then
          CastR()
          CastE(myHero)
        end
      end
    end
    if FAKER[spell.name] ~= nil and spell.target ~= nil then
      for i,enemy in pairs(GetAllyHeroes()) do
        if CanCast(_W) and FAKER[spell.name].tricky and GetRastoyanie(myHero, unit) <= VARS.W.RANGE then
          CastW(unit)
        end
        if isWhitelistedforE(enemy) and spell.target == enemy and CanCast(_E) and GetRastoyanie(myHero, enemy) <= VARS.E.RANGE and Menu.Auto.autoE then
          CastE(enemy)
        end
        if spell.target == enemy and CanCast(_R) and GetRastoyanie(myHero, enemy) < VARS.E.RANGE and Menu.Auto.autoE and isWhitelistedforE(enemy) then
          CastR()
          CastE(enemy)
        end
      end
    end
  end
end


function OnWndMsg(msg, key)
  if msg == WM_LBUTTONDOWN and Menu.Combo.focus and not myHero.dead then
    for i, pussy in ipairs(GetEnemyHeroes()) do
      if GetRastoyanie(mousePos, pussy) <= 120 and isValid(pussy) and not CheckInvul(pussy) then
        if FOCUSED ~= pussy then
          FOCUSED = pussy
          print("<font color = \"#B13070\">[HENTAI KARMA]</font> focus "..pussy.charName)
        else
          FOCUSED = nil
          print("<font color = \"#B13070\">[HENTAI KARMA]</font> stop focus "..pussy.charName)
        end
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

function DrawSelectedTarget()
  if not Menu.Combo.focus then return end
  local target = FOCUSED
  if target == nil then return end
  if (target ~= nil and target.type == myHero.type and target.team ~= myHero.team) then
    DrawFPSCircle(target.x, target.z, 150, ARGB(255,255,0,0), 4)
    local posMinion = WorldToScreen(D3DXVECTOR3(target.x, target.y, target.z))
    DrawText("FOCUS!", 20, posMinion.x, posMinion.y, ARGB(255,255,255,255))
  end
end

function GetHentaiTarget(range)
  local selectedTarget = FOCUSED
  if selectedTarget ~= nil and Menu.Combo.focus then
    if selectedTarget.type == myHero.type and selectedTarget.team ~= myHero.team and isValid(selectedTarget, range + 300) and not CheckInvul(enemy) then
      return selectedTarget
    end
  end
  local hentaiTarget = nil
  local lessCast = 0
  for i = 1, #GetEnemyHeroes() do
    local enemy = GetEnemyHeroes()[i]
    if isValid(enemy, range) and not CheckInvul(enemy) then
      local kArmor = (100+enemy.magicArmor)/100
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


function GetEmpQDamage(unit)
  
  
  local Qlvl = myHero:GetSpellData(_Q).level
  local Rlvl = myHero:GetSpellData(_R).level
  if Qlvl < 1 then return 0 end
  if Rlvl < 1 then return 0 end
  local QDmg = {80, 125, 170, 215, 260}
  local QBonusDmg = {25, 75, 125, 175}
  local QDmgMod = 0.6
  local QBonusDmgMod = 0.3
  local DmgBonusRaw = QBonusDmg[Rlvl] + myHero.ap * QBonusDmgMod
  local DmgRaw = QDmg[Qlvl] + myHero.ap * QDmgMod
  local Dmg = myHero:CalcMagicDamage(unit, DmgRaw+DmgBonusRaw)
  return Dmg
end

function GetQDamage(unit)
  
  local Qlvl = myHero:GetSpellData(_Q).level
  if Qlvl < 1 then return 0 end
  local QDmg = {80, 125, 170, 215, 260}
  local QDmgMod = 0.6
  local DmgRaw = QDmg[Qlvl] + myHero.ap * QDmgMod
  local Dmg = myHero:CalcMagicDamage(unit, DmgRaw)
  return Dmg
end

function GetWDamage(unit)
  
  local Wlvl = myHero:GetSpellData(_W).level
  if Wlvl < 1 then return 0 end
  local WDmg = {60, 110, 160, 210, 260}
  local WDmgMod = 0.9
  local DmgRaw = WDmg[Wlvl] + myHero.ap * WDmgMod
  local Dmg = myHero:CalcMagicDamage(unit, DmgRaw)
  return Dmg
end


function CastQ(unit)
  if unit == nil then return end
  if VP ~= nil then
    local CastPosition, HitChance = VP:GetLineCastPosition(unit, VARS.Q.DELAY, VARS.Q.WIDTH, VARS.Q.RANGE, VARS.Q.SPEED, myHero, true)
    if HitChance >= Menu.Prediction.QVPHC then
      if Menu.Key.combo and CanCast(_R) and Menu.Combo.useR then
        CastR()
      end
      if Menu.Key.harras and CanCast(_R) and Menu.Harras.useEmpQ then
        CastR()
      end
      CastSpell(_Q, CastPosition.x, CastPosition.z)
    end
  end
  if DP ~= nil then
    local state,hitPos,perc = DP:predict(nil,unit,myHero,SkillShot.TYPE.LINE,VARS.Q.SPEED,VARS.Q.RANGE,VARS.Q.WIDTH,VARS.Q.DELAY*1000,0,{Minions = true,Champions = true})
    if perc >= Menu.Prediction.QHC then
      if Menu.Key.combo and CanCast(_R) and Menu.Combo.useR then
        CastR()
      end
      if Menu.Key.harras and CanCast(_R) and Menu.Harras.useEmpQ then
        CastR()
      end
      CastSpell(_Q, hitPos.x, hitPos.z)
    end
  end
  if FHPred and Menu.Prediction.activePred == 3 then
    local CastPosition, hc, info = FHPrediction.GetPrediction(karmaQ, unit)
    if hc > 0 and CastPosition ~= nil and not info.collision then
      if Menu.Key.combo and CanCast(_R) and Menu.Combo.useR then
        CastR()
      end
      if Menu.Key.harras and CanCast(_R) and Menu.Harras.useEmpQ then
        CastR()
      end
      CastSpell(_Q, CastPosition.x, CastPosition.z)
    end
  end
  if KP ~= nil then
    local CastPosition, hc = KP:GetPrediction(karmaQ, unit, myHero)
    if hc >= Menu.Prediction.QKPHC then
      if Menu.Key.combo and CanCast(_R) and Menu.Combo.useR then
        CastR()
      end
      if Menu.Key.harras and CanCast(_R) and Menu.Harras.useEmpQ then
        CastR()
      end
      CastSpell(_Q, CastPosition.x, CastPosition.z)
    end
  end
end

function CastW(unit)
  CastSpell(_W, unit)
end

function CastE(unit)
  CastSpell(_E, unit)
end

function CastR()
  CastSpell(_R)
end


function Buff_Add(unit, target, buff)
  if unit.isMe and buff.name == "KarmaMantra" then
    EMPOWERED = true
  end
  for i=1, 5 do
    if (buff.name == POTS[i] and unit.isMe) then
      REGEN = true
    end
  end
end

function Buff_Rem(unit, buff)
  if unit.isMe and buff.name == "KarmaMantra" then
    EMPOWERED = false
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


function GetRastoyanie(a, b)
  local rastoyanie = math.sqrt((b.x-a.x)*(b.x-a.x) + (b.z-a.z)*(b.z-a.z))
  return rastoyanie
end


function CanCast(spell)
  return myHero:CanUseSpell(spell) == READY
end