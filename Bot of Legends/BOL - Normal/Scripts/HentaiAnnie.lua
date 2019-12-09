--[[
.----------------.  .----------------.  .-----------------. .----------------.  .----------------.  .----------------. 
| .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. |
| |  ____  ____  | || |  _________   | || | ____  _____  | || |  _________   | || |      __      | || |     _____    | |
| | |_   ||   _| | || | |_   ___  |  | || ||_   \|_   _| | || | |  _   _  |  | || |     /  \     | || |    |_   _|   | |
| |   | |__| |   | || |   | |_  \_|  | || |  |   \ | |   | || | |_/ | | \_|  | || |    / /\ \    | || |      | |     | |
| |   |  __  |   | || |   |  _|  _   | || |  | |\ \| |   | || |     | |      | || |   / ____ \   | || |      | |     | |
| |  _| |  | |_  | || |  _| |___/ |  | || | _| |_\   |_  | || |    _| |_     | || | _/ /    \ \_ | || |     _| |_    | |
| | |____||____| | || | |_________|  | || ||_____|\____| | || |   |_____|    | || ||____|  |____|| || |    |_____|   | |
| |              | || |              | || |              | || |              | || |              | || |              | |
| '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' |
'----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------' 

.----------------.  .-----------------. .-----------------. .----------------.  .----------------.
| .--------------. || .--------------. || .--------------. || .--------------. || .--------------. |
| |      __      | || | ____  _____  | || | ____  _____  | || |     _____    | || |  _________   | |
| |     /  \     | || ||_   \|_   _| | || ||_   \|_   _| | || |    |_   _|   | || | |_   ___  |  | |
| |    / /\ \    | || |  |   \ | |   | || |  |   \ | |   | || |      | |     | || |   | |_  \_|  | |
| |   / ____ \   | || |  | |\ \| |   | || |  | |\ \| |   | || |      | |     | || |   |  _|  _   | |
| | _/ /    \ \_ | || | _| |_\   |_  | || | _| |_\   |_  | || |     _| |_    | || |  _| |___/ |  | |
| ||____|  |____|| || ||_____|\____| | || ||_____|\____| | || |    |_____|   | || | |_________|  | |
| |              | || |              | || |              | || |              | || |              | |
| '--------------' || '--------------' || '--------------' || '--------------' || '--------------' |
'----------------'  '----------------'  '----------------'  '----------------'  '----------------'      
--]]
--ver. 1.0

if myHero.charName ~= "Annie" then return end

assert(load(Base64Decode("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"), nil, "bt", _ENV))()
TrackerLoad("lJjOQ2GyvDHARjzp")

require "VPrediction"
local VP = VPrediction()
local version = "1.0"
local scriptname = "Hentai Annie"
local developer = "remembermyhentai"
local contact = "skype xd_kikass"
local RREADY = false
local TibbersPartyHard = false
local Tibbers = nil
local lastAA = 0
local lastWnd = 64
local RECALLING = false
local REGEN = false
local POTS = {"ItemCrystalFlask", "RegenerationPotion", "ItemMiniRegenPotion", "ItemCrystalFlaskJungle", "ItemDarkCrystalFlask"}
local ATTACKITEMS = {"ItemWillBoltSpellBase"}
local BOLT, BOLTSLOT
local VARS = {
  R = {RANGE = 600, RADIUS = 225, DELAY = 0.3, SPEED = math.huge}
}

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

function OnLoad()

dts = TargetSelector(TARGET_LESS_CAST, 625, DAMAGE_MAGIC)
rts = TargetSelector(TARGET_LESS_CAST, 850, DAMAGE_MAGIC)
tts = TargetSelector(TARGET_LESS_CAST, 1500, DAMAGE_MAGIC)
tts1 = TargetSelector(TARGET_CLOSEST, 1500, DAMAGE_MAGIC)



AddApplyBuffCallback(function(unit, target, buff) ApplyBuff(unit, target, buff) end)
AddUpdateBuffCallback(function(unit, buff, stacks) UpdateBuff(unit, buff, stacks) end)
AddRemoveBuffCallback(function(unit, buff) RemoveBuff(unit, buff) end)
AddCreateObjCallback(TibbersLogic)
AddDeleteObjCallback(haveYouSeenMyTibbersDelete)
AddApplyBuffCallback(Buff_Add)
AddRemoveBuffCallback(Buff_Rem)


spellData = 
{
  [_Q] = {mana = function () return 55 + 5*myHero:GetSpellData(_Q).level end},
  [_W] = {mana = function () return 60 + 10*myHero:GetSpellData(_W).level end},
  [_E] = {mana = 20},
  [_R] = {mana = 100},
}


Menu = scriptConfig("[Hentai Annie]", "HentaiAnnie")
Menu:addSubMenu("[Key Binds]", "Key")
Menu.Key:addParam("lasthit", "Lasthit", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("X"))
Menu.Key:addParam("combo", "Combo", SCRIPT_PARAM_ONKEYDOWN, false, string.byte(" "))
Menu.Key:addParam("harras", "Harras", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
Menu.Key:addParam("burst", "Burst", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("Z"))
Menu.Key:addParam("laneclear", "Laneclear", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
Menu.Key:addParam("lasthitQstacks", "Dont farm if stun is up", SCRIPT_PARAM_ONKEYTOGGLE, true, string.byte("T"))
Menu.Key:addParam("AutoHarras", "Auto Harras", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("N"))
Menu.Key:addParam("AutoFarm", "Auto Farm with Q", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("M"))

Menu:addSubMenu("[Combo]", "Combo")
Menu.Combo:addParam("useGLP", "Use GLP-800", SCRIPT_PARAM_ONOFF, true)
Menu.Combo:addParam("comboRmax", "Use R at max range", SCRIPT_PARAM_ONOFF, true)
Menu.Combo:addParam("comboRstun", "Use R only if Stun is up", SCRIPT_PARAM_ONOFF, false)
Menu.Combo:addParam("HitChance", "R HitChance", SCRIPT_PARAM_SLICE, 2, 1, 5, 0)

Menu:addSubMenu("[Harras]", "Harras")
Menu.Harras:addParam("useQ", "Use Q for harras", SCRIPT_PARAM_ONOFF, true)
Menu.Harras:addParam("useW", "Use W for harras", SCRIPT_PARAM_ONOFF, true)

Menu:addSubMenu("[Burst]", "Burst")
Menu.Burst:addParam("flashburst", "Use Flash in burst", SCRIPT_PARAM_ONOFF, true)

Menu:addSubMenu("[Farm]", "Farm")
Menu.Farm:addSubMenu("[Lasthit]", "lasthit")
Menu.Farm.lasthit:addParam("lasthitQ", "Use Q for lasthit", SCRIPT_PARAM_ONOFF, true)
Menu.Farm:addSubMenu("[Laneclear]", "laneclear")
Menu.Farm.laneclear:addParam("laneclearQ", "Use Q for laneclear", SCRIPT_PARAM_ONOFF, true)

Menu:addSubMenu("[Move]", "Move")
Menu.Move:addParam("MoveLasthit", "Move to mouse in Lasthit mode", SCRIPT_PARAM_ONOFF, false)
Menu.Move:addParam("MoveCombo", "Move to mouse in Combo mode", SCRIPT_PARAM_ONOFF, false)
Menu.Move:addParam("MoveHarras", "Move to mouse in Harras mode", SCRIPT_PARAM_ONOFF, false)
Menu.Move:addParam("MoveBurst", "Move to mouse in Burst mode", SCRIPT_PARAM_ONOFF, true)
Menu.Move:addParam("MoveLaneClear", "Move to mouse in Laneclear mode", SCRIPT_PARAM_ONOFF, false)

Menu:addSubMenu("[Draws]", "Draws")
Menu.Draws:addParam("drawQ", "Draw Q range", SCRIPT_PARAM_ONOFF, true)
Menu.Draws:addParam("drawW", "Draw W range", SCRIPT_PARAM_ONOFF, false)
Menu.Draws:addParam("drawR", "Draw R range", SCRIPT_PARAM_ONOFF, false)
Menu.Draws:addParam("drawRmax", "Draw R max range", SCRIPT_PARAM_ONOFF, true)
Menu.Draws:addParam("drawAuto", "Draw Auto options status", SCRIPT_PARAM_ONOFF, true)

Menu:addSubMenu("[Auto]", "Auto")
Menu.Auto:addParam("autoInterrupt", "Auto Interrupt important enemy spells", SCRIPT_PARAM_ONOFF, true)
Menu.Auto:addParam("AutoR", "Auto R Stun", SCRIPT_PARAM_ONOFF, true)
Menu.Auto:addParam("AutoRx", "# enemies (R)", SCRIPT_PARAM_SLICE, 3, 1, 5, 0)
Menu.Auto:addParam("AutoW", "Auto W Stun", SCRIPT_PARAM_ONOFF, false)
Menu.Auto:addParam("AutoWx", "# enemies (W)", SCRIPT_PARAM_SLICE, 2, 1, 5, 0)
Menu.Auto:addParam("AutoE", "Auto E stack", SCRIPT_PARAM_ONOFF, true)
Menu.Auto:addParam("AutoEx", "% Mana for Auto E", SCRIPT_PARAM_SLICE, 80, 0, 100, 0)
Menu.Auto:addParam("autoPots", "Auto potion usage", SCRIPT_PARAM_ONOFF, true)
Menu.Auto:addParam("autoPotsHealth", "% Health for autopots", SCRIPT_PARAM_SLICE, 75, 0, 100, 0)

Menu:addSubMenu("[Killsteal]", "KS")
Menu.KS:addParam("ksON", "Enable KS", SCRIPT_PARAM_ONOFF, true)
Menu.KS:addParam("KSq", "Use Q for KS", SCRIPT_PARAM_ONOFF, true)
Menu.KS:addParam("KSw", "Use W for KS", SCRIPT_PARAM_ONOFF, true)
Menu.KS:addParam("KSr", "Use R for KS", SCRIPT_PARAM_ONOFF, true)
Menu.KS:addParam("KSignite", "Use Ignite for KS", SCRIPT_PARAM_ONOFF, true)

Menu:addSubMenu("[Tibbers]", "TibbersLogic")
Menu.TibbersLogic:addParam("TibbersON", "Enable Tibbers", SCRIPT_PARAM_ONOFF, true)
Menu.TibbersLogic:addParam("Target", "Target", SCRIPT_PARAM_LIST, 2, {"Closest", "TS"})
Menu.TibbersLogic:addParam("TibbersRange", "Target follow range", SCRIPT_PARAM_SLICE, 1500, 625, 1500, 0)

Menu:addParam("info1", "", SCRIPT_PARAM_INFO, "")
Menu:addParam("info2", ""..scriptname.." [ver. "..version.."]", SCRIPT_PARAM_INFO, "")
Menu:addParam("info3", "Created by "..developer.."", SCRIPT_PARAM_INFO, "")
Menu:addParam("info4", "Contact me: "..contact.."", SCRIPT_PARAM_INFO, "")


flashslot = FindSlotByName("summonerflash")
igniteslot = FindSlotByName("summonerdot")


PrintChat("<font color = \"#B13070\">[HENTAI ANNIE]</font> <font color = \"#4DFF4D\">LOADED</font>")
end

function OnTick()
  
  dts:update()
  rts:update()

  
  RREADY = myHero:CanUseSpell(_R) == READY and myHero:GetSpellData(_R).name ~= "InfernalGuardianGuide"

  
  if Menu.Key.AutoFarm and not (Menu.Key.combo or Menu.Key.burst or Menu.Key.harras) then
    Autofarm()
  end

  
  if Menu.Key.AutoHarras then
    Autoharras()
  end

  
  if (Menu.Key.lasthit) then
    Lasthit()
    if (Menu.Move.MoveLasthit) then
      myHero:MoveTo(mousePos.x,mousePos.z)
    end
  end

  
  if (Menu.Key.laneclear) then
    Laneclear()
    if (Menu.Move.MoveLaneClear) then 
      myHero:MoveTo(mousePos.x,mousePos.z)
    end
  end

  
  if (Menu.Key.combo) then
    Combo()
    if (Menu.Move.MoveCombo) then
      myHero:MoveTo(mousePos.x,mousePos.z)
    end
  end

  
  if (Menu.Key.harras) then
    Harras()
    if (Menu.Move.MoveHarras) then
      myHero:MoveTo(mousePos.x,mousePos.z)
    end
  end

  
  if (Menu.Key.burst) then
    local target = GetTarget()
    if (target ~= nil and target.type == myHero.type) then
      Burst(myHero.x, myHero.z, target.x, target.z)
    end
    if (Menu.Move.MoveBurst) then
      myHero:MoveTo(mousePos.x,mousePos.z)
    end
  end

  
  if Menu.KS.ksON then
    Killsteal()
  end

  
  if Menu.Auto.AutoR then
    AutoUlt()
  end
  if Menu.Auto.AutoW then
    AutoWstun()
  end

  
  if Menu.Auto.AutoE then
    AutoEstack()
  end

  
  if (Menu.KS.KSignite) then
    AutoIgnite()
  end

  
  if myHero:CanUseSpell(_R) == READY and myHero:GetSpellData(_R).name == "InfernalGuardianGuide" and Menu.TibbersLogic.TibbersON then
    if Menu.TibbersLogic.Target == 1 then
      tts1:update()
      TibbersControl()
    elseif Menu.TibbersLogic.Target == 2 then
      tts:update()
      TibbersControl()
    end

    
    FindItems()
  end

  
  if (Menu.Auto.autoPots and not REGEN) then
    AutoPotion()
  end  
end

function OnDraw()
  
  if not myHero.dead then
    if Menu.Draws.drawQ then
      DrawFPSCircle(myHero.x, myHero.z, 625, ARGB(255,255,128,0), 4)
    end
    if Menu.Draws.drawW then
      DrawFPSCircle(myHero.x, myHero.z, 625, ARGB(255,255,128,0), 4)
    end
    if Menu.Draws.drawR then
      DrawFPSCircle(myHero.x, myHero.z, 600, ARGB(255,255,128,0), 4)
    end
    if Menu.Draws.drawRmax then
      DrawFPSCircle(myHero.x, myHero.z, 850, ARGB(255,255,128,0), 4)
    end
    
    local target = GetTarget()
    if (target ~= nil and target.type == myHero.type and target.team ~= myHero.team) then
      DrawFPSCircle(target.x, target.z, 150, ARGB(255,255,0,0), 4)
    end
    if (myHero:CanUseSpell(_Q) == READY and myHero:CanUseSpell(_W) == READY and RREADY and myHero:CanUseSpell(flashslot) == READY and 
      flashslot ~= nil and Menu.Burst.flashburst and StunUP) then
      DrawFPSCircle(myHero.x, myHero.z, 1045, ARGB(255,255,0,0), 4)
    end
    
    for i, HPbarEnemyChamp in pairs(GetEnemyHeroes()) do
      local dmg = myHero:CalcDamage(HPbarEnemyChamp, myHero.totalDamage)
      if myHero:CanUseSpell(_Q) == READY and not HPbarEnemyChamp.dead then
        dmg = dmg + GetQDamage(HPbarEnemyChamp)
      end
      if myHero:CanUseSpell(_W) == READY and not HPbarEnemyChamp.dead then
        dmg = dmg + GetWDamage(HPbarEnemyChamp)
      end
      if RREADY and not HPbarEnemyChamp.dead then
        dmg = dmg + GetRDamage(HPbarEnemyChamp)
      end
      if igniteslot ~= nil then
        if myHero:CanUseSpell(igniteslot) == READY then
          dmg = dmg + (50 + 20*myHero.level)
        end
      end
      DrawLineHPBar(dmg, "", HPbarEnemyChamp, HPbarEnemyChamp.team)
    end 
  end
  
  if (Menu.Key.lasthitQstacks) then
    DrawText ("SAVE STUN [T]", 20, 150, 100, 0xFF00FF00)
  else 
    DrawText ("DON'T SAVE STUN [T]", 20, 150, 100, 0xFFFF0000)
  end
  
  if Menu.Draws.drawAuto then
    if Menu.Key.AutoHarras then
      DrawText ("AUTO HARRAS ON [N]", 20, 150, 80, 0xFF00FF00)
    else 
      DrawText ("AUTO HARRAS OFF [N]", 20, 150, 80, 0xFFFF0000)
    end
    if Menu.Key.AutoFarm then
      DrawText ("AUTO FARM ON [M]", 20, 150, 60, 0xFF00FF00)
    else 
      DrawText ("AUTO FARM OFF [M]", 20, 150, 60, 0xFFFF0000)
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


function Autofarm()
  qFarm()
end


function Autoharras()
  if ValidTarget(dts.target, 625) and not dts.target.dead then
    CastQ(dts.target)
  end
end


function ApplyBuff(unit, target, buff)
  if not unit.isMe then return end
  if unit and unit.isMe and buff and buff.name == "pyromania_particle" then
    StunUP = true
  end
end

function UpdateBuff(unit, buff, stacks)
  if unit and unit.isMe and buff and buff.name == "pyromania" then
    passiveStacks = stacks
  end
end

function RemoveBuff(unit, buff)
  if not unit.isMe then return end
  if unit and unit.isMe and buff and buff.name == "pyromania" then
    passiveStacks = 0
  end
  if unit and unit.isMe and buff and buff.name == "pyromania_particle" then
    StunUP = false 
  end
end


function Combo()
  if ValidTarget(rts.target, 850) and (CanCast(_Q) or CanCast(_W) or CanCast(_R)) and GetRastoyanie(myHero,rts.target) > 600 then
    OrbsOff()
  end
  if ValidTarget(rts.target, 850) then
    if (StunUP) then
      if RREADY then
        CastR(rts.target, myHero.x, myHero.z, rts.target.x, rts.target.z)
      end
      if (ValidTarget(dts.target, 625)) then
        if CanCast(_W) then
          CastW(dts.target, myHero.x, myHero.z, dts.target.x, dts.target.z)
        end
        if CanCast(_Q) then
          CastQ(dts.target)
        end
      end
      if (not Menu.Combo.comboRstun and ValidTarget(dts.target, 625)) then
        if RREADY then
          CastR(dts.target, myHero.x, myHero.z, dts.target.x, dts.target.z)
        end
        if CanCast(_W) then
          CastW(dts.target, myHero.x, myHero.z, dts.target.x, dts.target.z)
        end
        if CanCast(_Q) then
          CastQ(dts.target)
        end
      end
      if Menu.Combo.useGLP and BOLT then
        if CanCast(BOLTSLOT) then
          CastBOLT(rts.target)
        end
      end
    end
    if (not StunUP) then
      if (passiveStacks == 3 and Menu.Combo.comboRstun) then
        if (myHero:CanUseSpell(_E) == READY) then
          CastE()
        end
      end
      if (ValidTarget(dts.target, 625)) then
        if CanCast(_W) then
          CastW(dts.target, myHero.x, myHero.z, dts.target.x, dts.target.z)
        end
        if CanCast(_Q) then
          CastQ(dts.target)
        end
        if (not StunUP) then
          CastE()
        end
        if RREADY and not Menu.Combo.comboRstun then
          CastR(dts.target, myHero.x, myHero.z, dts.target.x, dts.target.z)
        end
      end
      if ValidTarget(rts.target, 850) then
        if Menu.Combo.useGLP and BOLT then
          if CanCast(BOLTSLOT) then
            CastBOLT(rts.target)
          end
        end
      end
    end
  end 
end


function CanCast(spell)
  return myHero:CanUseSpell(spell) == READY
end

function OrbsOff()
  if SAC then
    _G.AutoCarry.MyHero:AttacksEnabled(false)
    DelayAction(function()
      _G.AutoCarry.MyHero:AttacksEnabled(true)
    end, 1)
  end
  if MMA then
    _G.MMA_StopAttacks(false)
    DelayAction(function()
      _G.MMA_StopAttacks()
    end, 1)
  end
  if WOLFY then
    _G.NebelwolfisOrbWalker:SetAA(false)
    DelayAction(function()
      _G.NebelwolfisOrbWalker:SetAA(true)
    end, 1)
  end
  if PEW then
    _Pewalk.AllowAttack(false)
    DelayAction(function()
      _Pewalk.AllowAttack(true)
    end, 1)
  end
  if SXORB then
    SxOrb:DisableAttacks()
    DelayAction(function()
      SxOrb:EnableAttacks()
    end, 1)
  end
end


function Harras()
  if (ValidTarget(dts.target, 625) and rts.target.type == myHero.type) then
    if Menu.Harras.useW then
      CastW(dts.target, myHero.x, myHero.z, dts.target.x, dts.target.z)
    end
    if Menu.Harras.useQ then
      CastQ(dts.target)
    end
  end
end


function Burst(myX, myZ, enemyX, enemyZ)
  local target = GetTarget()
  if target == nil then
    PrintChat("Choose target for burst!")
    return 0
  end
  local BurstMana = spellData[_Q].mana() + spellData[_W].mana() + spellData[_R].mana
  local rastoyanie = math.sqrt((enemyX-myX)*(enemyX-myX) + (enemyZ-myZ)*(enemyZ-myZ))
  if (target ~= nil and target.type == myHero.type and myHero:CanUseSpell(_Q) == READY and myHero:CanUseSpell(_W) == READY and RREADY and
    target.team ~= myHero.team and rastoyanie <= 1040 and StunUP and rastoyanie >= 625 and myHero.mana > BurstMana) then
    if (Menu.Burst.flashburst and myHero:CanUseSpell(flashslot) == READY and flashslot ~= nil) then 
      local a = (enemyX-myX)/rastoyanie * 425 + myX
      local b = (enemyZ-myZ)/rastoyanie * 425 + myZ
      CastSpell(flashslot, a, b)
    end
  end
  if (ValidTarget(target, 625) and target ~= nil) then
    CastR(target, myHero.x, myHero.z, target.x, target.z)
    CastW(target, myHero.x, myHero.z, target.x, target.z)
    CastQ(target)
    if (not StunUP) then
      CastE()
    end
  end
end


function Killsteal()
  for i,enemy in pairs(GetEnemyHeroes()) do
    if isValid(enemy, 835) and not CheckInvul(enemy) then
      local rastoyanie = math.sqrt((enemy.x-myHero.x)*(enemy.x-myHero.x) + (enemy.z-myHero.z)*(enemy.z-myHero.z))
      if ValidTarget(enemy, 835) then
        if rastoyanie <= 835 and rastoyanie > 625 then
          if RREADY and Menu.KS.KSr then
            local RDmg = GetRDamage(enemy)
            if RDmg >= enemy.health then
              CastR(enemy, myHero.x, myHero.z, enemy.x, enemy.z)
            end
          end
        elseif rastoyanie <= 625 then  
          if myHero:CanUseSpell(_Q) == READY and Menu.KS.KSq then
            local QDmg = GetQDamage(enemy)
            if QDmg >= enemy.health then
              CastQ(enemy)
            end
          elseif myHero:CanUseSpell(_W) == READY and Menu.KS.KSw then
            local WDmg = GetWDamage(enemy)
            if WDmg >= enemy.health then
              CastW(enemy, myHero.x, myHero.z, enemy.x, enemy.z)
            end
          elseif RREADY and Menu.KS.KSr then
            local RDmg = GetRDamage(enemy)
            if RDmg >= enemy.health then
              CastR(enemy, myHero.x, myHero.z, enemy.x, enemy.z)
            end
          end 
        end 
      end
    end
  end
end


function GetRastoyanie(a, b)
  local rastoyanie = math.sqrt((b.x-a.x)*(b.x-a.x) + (b.z-a.z)*(b.z-a.z))
  return rastoyanie
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


function Lasthit()
  if (Menu.Farm.lasthit.lasthitQ) then
    qFarm()
  end
end


function Laneclear()
  if (Menu.Farm.laneclear.laneclearQ) then
    qFarm()
  end
end


function AutoUlt()
  if (StunUP and RREADY and Menu.Auto.AutoR) then
    for i,enemy in pairs(GetEnemyHeroes()) do
      if ValidTarget(enemy, 600) then
        local mainCastPosition, mainHitChance, numPoints, mainPosition = VP:GetCircularAOECastPosition(enemy, VARS.R.DELAY, VARS.R.RADIUS, VARS.R.RANGE, VARS.R.SPEED, myHero, false)
        if (numPoints ~= nil) then
          if (numPoints >= Menu.Auto.AutoRx) then
            CastSpell(_R, mainCastPosition.x, mainCastPosition.z)
          end
        end
      end
    end
  end
  if (passiveStacks == 3 and RREADY and Menu.Auto.AutoR) then
    for i,enemy in pairs(GetEnemyHeroes()) do
      if ValidTarget(enemy, 600) then
        local mainCastPosition, mainHitChance, numPoints, mainPosition = VP:GetCircularAOECastPosition(enemy, VARS.R.DELAY, VARS.R.RADIUS, VARS.R.RANGE, VARS.R.SPEED, myHero, false)
        if (numPoints ~= nil) then
          if (numPoints >= Menu.Auto.AutoRx and myHero:CanUseSpell(_E) == READY) then
            CastE()
            CastSpell(_R, mainCastPosition.x, mainCastPosition.z)
          end
        end  
      end
    end
  end      
end          

function AutoWstun()
  if (StunUP and myHero:CanUseSpell(_W) == READY and Menu.Auto.AutoW) then
    for i,enemy in pairs(GetEnemyHeroes()) do
      if ValidTarget(enemy, 625) then
        local mainCastPosition, mainHitChance, numPoints = VP:GetConeAOECastPosition(enemy, 0.3, 50, 625, math.huge, myHero, false)
        if (numPoints ~= nil) then
          if (numPoints >= Menu.Auto.AutoWx) then
            CastSpell(_W, mainCastPosition.x, mainCastPosition.z)
          end
        end
      end
    end   
  end  
end


function qFarm()
  if ((Menu.Farm.lasthit.lasthitQ or Menu.Farm.laneclear.laneclearQ) and not Menu.Key.lasthitQstacks) then
    for _, minion in pairs(minionManager(MINION_ENEMY, 625, myHero, MINION_SORT_HEALTH_ASC).objects) do
      local qDmg = GetQDamage(minion)
      local hp = VP:GetPredictedHealth(minion, GetDistance(minion)/2000 + 0.250)
      if (myHero:CanUseSpell(_Q) == READY and hp < qDmg) then
        CastQ(minion)
      end
    end
  end
  if ((Menu.Farm.lasthit.lasthitQ or Menu.Farm.laneclear.laneclearQ) and Menu.Key.lasthitQstacks) then
    if (not StunUP) then
      for _, minion in pairs(minionManager(MINION_ENEMY, 625, myHero, MINION_SORT_HEALTH_ASC).objects) do
        local qDmg = GetQDamage(minion)
        local hp = VP:GetPredictedHealth(minion, GetDistance(minion)/2000 + 0.250)
        if (myHero:CanUseSpell(_Q) == READY and hp < qDmg) then
          CastQ(minion)
        end
      end
    end
  end 
end


function Buff_Add(unit, target, buff)
  if not unit.isMe then return end
  if (buff.name == "OdinRecall" or buff.name == "recall") then
    RECALLING = true
  end
  for i=1, 5 do
    if (buff.name == POTS[i] and unit.isMe) then
      REGEN = true
    end
  end
end

function Buff_Rem(unit, buff)
  if not unit.isMe then return end
  if (buff.name == "OdinRecall" or buff.name == "recall") then
    RECALLING = false
  end
  for i=1, 5 do
    if (buff.name == POTS[i] and unit.isMe) then
      REGEN = false
    end
  end
end


function CastQ(unit)
  if myHero:CanUseSpell(_Q) == READY and ValidTarget(unit, 625) then
    CastSpell(_Q, unit)
  end
end

function CastW(unit, myX, myZ, enemyX, enemyZ)
  if (myHero:CanUseSpell(_W) == READY and math.sqrt((enemyX-myX)*(enemyX-myX) + (enemyZ-myZ)*(enemyZ-myZ)) < 620 and ValidTarget(unit, 625)) then
    CastSpell(_W, enemyX, enemyZ)
  end
end

function CastE()
  if (myHero:CanUseSpell(_E) == READY) then
    CastSpell(_E)
  end
end

function CastR(unit, myX, myZ, enemyX, enemyZ)
  local rastoyanie = math.sqrt((enemyX-myX)*(enemyX-myX) + (enemyZ-myZ)*(enemyZ-myZ))
  if RREADY and Menu.Combo.comboRmax and ValidTarget(unit, 850) and rastoyanie <= 845 and
    rastoyanie >= 600 then
    local a = (enemyX-myX)/rastoyanie * 600 + myX
    local b = (enemyZ-myZ)/rastoyanie * 600 + myZ
    CastSpell(_R, a, b)
  elseif RREADY and ValidTarget(unit, 850) then
    local CastPosition, HitChance = VP:GetCircularCastPosition(unit, VARS.R.DELAY, VARS.R.RADIUS, VARS.R.RANGE, VARS.R.SPEED, myHero, false)
      if HitChance >= Menu.Combo.HitChance then
        CastSpell(_R, CastPosition.x, CastPosition.z)
      end
    end
  end

  function TibbersLogic(obj)
    if obj.name == nil then return end
    if obj.name == "Tibbers" then
      Tibbers = obj
      TibbersPartyHard = true
    end
  end

  function haveYouSeenMyTibbersDelete(obj)
    if obj.name == "Tibbers" then
      TibbersPartyHard = false
    end
  end

  function TibbersControl()
    if TibbersPartyHard then
      if Menu.TibbersLogic.Target == 1 then
        if ValidTarget(tts1.target, 1500) and myHero.type == tts1.target.type and not RREADY then     
          AttackByTibbers(tts1.target)
        end
        if math.sqrt((Tibbers.x - myHero.x)*(Tibbers.x - myHero.x) + (Tibbers.z - myHero.z)*(Tibbers.z - myHero.z)) > Menu.TibbersLogic.TibbersRange
          and myHero:GetSpellData(_R).name == "InfernalGuardianGuide" then
          CastSpell(_R, myHero.x, myHero.z)
        end
      end
      if Menu.TibbersLogic.Target == 2 then
        if ValidTarget(tts.target, 1500) and myHero.type == tts.target.type and not RREADY then
          AttackByTibbers(tts.target)
        end
        if math.sqrt((Tibbers.x - myHero.x)*(Tibbers.x - myHero.x) + (Tibbers.z - myHero.z)*(Tibbers.z - myHero.z)) > Menu.TibbersLogic.TibbersRange
          and myHero:GetSpellData(_R).name == "InfernalGuardianGuide" then
          CastSpell(_R, myHero.x, myHero.z)
        end
      end
    end
  end

  function AttackByTibbers(unit)
    if GetTickCount() > lastAA + lastWnd + 720 then
      CastSpell(_R, unit)
      lastAA = GetTickCount()
    end
  end

  function OnAnimation(unit, animation)
    if unit == tibbers and animation:lower():find("attack") then
      lastAA = GetTickCount()
    end
  end

  function OnProcessAttack(unit, spell)
    if unit == tibbers and spell.name:lower():find("attack") then
      lastWnd = spell.windUpTime
    end
  end


function GetQDamage(unit)
  
  local Qlvl = myHero:GetSpellData(_Q).level
  if Qlvl < 1 then return 0 end
  local QDmg = {80, 115, 150, 185, 220}
  local QDmgMod = 0.8
  local DmgRaw = QDmg[Qlvl] + myHero.ap * QDmgMod
  local Dmg = myHero:CalcMagicDamage(unit, DmgRaw)
  return Dmg
end

function GetWDamage(unit)
  
  local Wlvl = myHero:GetSpellData(_W).level
  if Wlvl < 1 then return 0 end
  local WDmg = {70, 115, 160, 205, 250}
  local WDmgMod = 0.85
  local DmgRaw = WDmg[Wlvl] + myHero.ap * WDmgMod
  local Dmg = myHero:CalcMagicDamage(unit, DmgRaw)
  return Dmg
end

function GetRDamage(unit)
  
  local Rlvl = myHero:GetSpellData(_R).level
  if Rlvl < 1 then return 0 end
  local RDmg = {150, 275, 400}
  local RDmgMod = 0.65
  local DmgRaw = RDmg[Rlvl] + myHero.ap * RDmgMod
  local Dmg = myHero:CalcMagicDamage(unit, DmgRaw)
  return Dmg
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


function OnProcessSpell(unit, spell)
  if Menu.Auto.autoInterrupt and unit and spell then
    if unit.team ~= myHero.team and PussyOut[spell.name] ~= nil and isValid(unit) then
      if StunUP then
      CastQ(unit)
      CastW(unit, myHero.x, myHero.z, unit.x, unit.z)
      end
    end
  end
end


function isValid(object, range)
  return object ~= nil and object.valid and object.visible and not object.dead and object.bInvulnerable == 0
   and object.bTargetable and (range == nil or GetRastoyanie(object, myHero) <= range)
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


function AutoEstack()
  if (myHero:CanUseSpell(_E) == READY and ((myHero.mana*100)/myHero.maxMana) >= Menu.Auto.AutoEx  and not StunUP and not RECALLING) then
    CastE()
  end
end


function GetItem(name)
  local slot = FindSlotByName(name)
  return slot 
end