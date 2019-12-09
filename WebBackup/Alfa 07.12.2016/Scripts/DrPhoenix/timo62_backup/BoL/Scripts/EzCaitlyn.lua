--[[
Ez Caitlyn Beta test
]]

if myHero.charName ~= "Caitlyn" then return end

local Version = 0.9
local AACharged = false
local AARange = 650 
local QRange = 1250
local ERange = 925
local ECasted = false
local RRange = (500 * myHero:GetSpellData(_R).level) + 1500
local VP = nil
local MenuTrueFalseQ = false
local MenuTrueFalseE = false
local scriptmsg = '<font color=\"#72427a\">[Ez Scripts]</font><font color=\"#888888\"> - </font><font color=\"#cccbbb\">Ez Caitlyn Loaded.</font>'

-- Bol Tools Tracker --
assert(load(Base64Decode("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"), nil, "bt", _ENV))()
TrackerLoad("UcCRY46ZRhTYhKJD")
-- Bol Tools Tracker --

-- VP
require "VPrediction"
-- VP

function CheckUpdates()
  local host = "www.scarjit.de"
  local ServerVersionDATA = GetWebResult(host, "/HiranN/BoL/Versions/EzCaitlyn.version")  
  local ServerVersion = tonumber(ServerVersionDATA)
  if ServerVersionDATA then
  if ServerVersion then
  if ServerVersion > tonumber(Version) then
  print(scriptmsg.."<font color=\"#C2FDF3\"><b> Updating, don't press F9.</b></font>")
  DL = Download()
  file = "/HiranN/BoL/Scripts/EzCaitlyn.lua"
  name = GetCurrentEnv().FILE_NAME
  DL:newDL(host, file, name, SCRIPT_PATH, function()
  print(scriptmsg.."<font color=\"#C2FDF3\"><b> No updates found.</b></font>")
  end)
  else
  print(scriptmsg.."<font color=\"#C2FDF3\"><b> No updates found.</b></font>")
  end
  end
end
end


function OnLoad()
  Menu()
    if VIP_USER then SkinLoad() end

  ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, 1250, DAMAGE_PHYSICAL)
  tsAA = TargetSelector(TARGET_LESS_CAST_PRIORITY, AARange, DAMAGE_PHYSICAL)
    tsQ = TargetSelector(TARGET_LESS_CAST_PRIORITY, 1250, DAMAGE_PHYSICAL)
    tsW = TargetSelector(TARGET_LESS_CAST_PRIORITY, 260, DAMAGE_PHYSICAL)
    tsE = TargetSelector(TARGET_LESS_CAST_PRIORITY, 325, DAMAGE_PHYSICAL)
    tsR = TargetSelector(TARGET_LESS_CAST_PRIORITY, 3000, DAMAGE_PHYSICAL)
    ts.name = "Caitlyn"
    Menu:addTS(ts)
    enemyMinions = minionManager(MINION_ENEMY, 285, myHero, MINION_SORT_HEALTH_ASC)
    jungleMinions = minionManager(MINION_JUNGLE, 285, myHero, MINION_SORT_MAXHEALTH_DEC)
    Tables()
    VP = VPrediction()
    CheckUpdates()

end

function OnTick ()
  Checks()
  --print(HitChance)
  if Menu.qeSett.Qcollisions then MenuTrueFalseQ = true else MenuTrueFalseQ = false end
  if Menu.qeSett.Ecollisions then MenuTrueFalseE = true else MenuTrueFalseE = false end
  if Menu.key.comboKey then Combo(Target) end
  if Menu.h.useQToggle and Menu.key.harassKey then Harass(Target) end
  if Menu.key.clearKey then Clear() end
  if Menu.key.lasthitKey then Lasthit() end
  if Menu.killsteal.useR then AutoR() end
  if not Eready then ECasted = true else ECasted = false end 
end
function OnApplyBuff(source, unit, buff) 
  if source and source.isMe and buff and buff.name and buff.name:find("caitlynheadshot") then
    AACharged = true
  end
  if not source.isMe and not source.team ~= myHero.team and buff.type == 24 or buff.type == 5 or buff.type == 11 or buff.type == 8 then
    if unit.networkID ~= myHero.networkID and GetDistance(unit) <= 800 and Menu.wSett.useWAuto then
      CastSpell(_W, unit.x, unit.z)
    end
  end
  if unit and unit.team ~= not myHero.team and buff and buff.name == "recall" then 
    if Menu.draws.RecallTracker then
      print("<font color=\"#C2FDF3\"><b>["..unit.charName.."] Is Recalling") 
    end
  end
  if unit and buff and buff.name == "SummonerTeleport" then
    if unit.team == myHero.team and Menu.draws.TeleportTracker then
      print("<font color=\"#C2FDF3\"><b>["..unit.charName.."][Ally] Is Teleporting!")
    else 
      print("<font color=\"#C2FDF3\"><b>["..unit.charName.."][Enemy] Is Teleporting!")
    end
  end
end
function OnRemoveBuff(unit, buff)
  if unit and unit.team ~= myHero.team and buff and buff.name == "recall" then 
    if Menu.draws.RecallTracker then
      print("<font color=\"#C2FDF3\"><b>["..unit.charName.."] Recalled OR Cancelled Recall")
    end
  end
end

function OnProcessSpell (source, spell, enemy)
    if DashesTarget[spell.name] and spell.target and spell.target.isMe then
      if Menu.wSett.useWGap then
        CastSpell(_W, myHero.x, myHero.z)
      end
    end
    if DashesNoTarget[spell.name] and GetDistance(Target) <= 200 and (spell.target == nil or (spell.target and spell.target.isMe)) then
      if Menu.wSett.useWGapNo then
        CastSpell(_W, myHero.x, myHero.z)
      end
    end
end

function Tables()
    DashesTarget = {
        ['AkaliShadowDance']    = {true, Champ = 'Akali',     spellKey = 'R'},
        ['Headbutt']          = {true, Champ = 'Alistar',   spellKey = 'W'},
        ['DianaTeleport']         = {true, Champ = 'Diana',     spellKey = 'R'},
        ['IreliaGatotsu']         = {true, Champ = 'Irelia',    spellKey = 'Q'},
        ['JaxLeapStrike']           = {true, Champ = 'Jax',     spellKey = 'Q'},
        ['JayceToTheSkies']         = {true, Champ = 'Jayce',   spellKey = 'Q'},
        ['MaokaiUnstableGrowth']    = {true, Champ = 'Maokai',    spellKey = 'W'},
        ['MonkeyKingNimbus']      = {true, Champ = 'MonkeyKing',  spellKey = 'E'},
        ['Pantheon_LeapBash']     = {true, Champ = 'Pantheon',  spellKey = 'W'},
        ['PoppyHeroicCharge']       = {true, Champ = 'Poppy',   spellKey = 'E'},
        ['QuinnE']            = {true, Champ = 'Quinn',   spellKey = 'E'},
        ['XenZhaoSweep']        = {true, Champ = 'XinZhao',   spellKey = 'E'},
        ['blindmonkqtwo']       = {true, Champ = 'LeeSin',    spellKey = 'Q'},
        ['FizzPiercingStrike']      = {true, Champ = 'Fizz',    spellKey = 'Q'},
        ['RengarLeap']          = {true, Champ = 'Rengar',    spellKey = 'Q/R'},
        ['YasuoDashWrapper']      = {true, Champ = 'Yasuo',   spellKey = 'E'},
    }
  
    DashesNoTarget = {
        ['AatroxQ']         = {true, Champ = 'Aatrox',    range = 1000,   projSpeed = 1200, spellKey = 'Q'},
        ['GragasE']         = {true, Champ = 'Gragas',    range = 600,    projSpeed = 2000, spellKey = 'E'},
        ['HecarimUlt']        = {true, Champ = 'Hecarim',   range = 1000,   projSpeed = 1200, spellKey = 'R'},
        ['JarvanIVDragonStrike']  = {true, Champ = 'JarvanIV',  range = 770,    projSpeed = 2000, spellKey = 'Q'},
        ['JarvanIVCataclysm']   = {true, Champ = 'JarvanIV',  range = 650,    projSpeed = 2000, spellKey = 'R'},
        ['KhazixE']         = {true, Champ = 'Khazix',    range = 900,    projSpeed = 2000, spellKey = 'E'},
        ['khazixelong']       = {true, Champ = 'Khazix',    range = 900,    projSpeed = 2000, spellKey = 'E'},
        ['LeblancSlide']      = {true, Champ = 'Leblanc',   range = 600,    projSpeed = 2000, spellKey = 'W'},
        ['LeblancSlideM']     = {true, Champ = 'Leblanc',   range = 600,    projSpeed = 2000, spellKey = 'WMimic'},
        ['LeonaZenithBlade']    = {true, Champ = 'Leona',     range = 900,    projSpeed = 2000, spellKey = 'E'},
        ['UFSlash']         = {true, Champ = 'Malphite',  range = 1000,   projSpeed = 1800, spellKey = 'R'},
        ['RenektonSliceAndDice']  = {true, Champ = 'Renekton',  range = 450,    projSpeed = 2000, spellKey = 'E'},
        ['SejuaniArcticAssault']  = {true, Champ = 'Sejuani',   range = 650,    projSpeed = 2000, spellKey = 'Q'},
        ['ShenShadowDash']      = {true, Champ = 'Shen',    range = 575,    projSpeed = 2000, spellKey = 'E'},
    }
end

function Menu ()
  Menu = scriptConfig("Ez Caitlyn", "EZCait")

    Menu:addSubMenu("Combo", "c")
        Menu.c:addParam("useQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
        Menu.c:addParam("useE", "Use E", SCRIPT_PARAM_ONOFF, true)

    Menu:addSubMenu("Harass", "h")
      Menu.h:addParam("useQToggle", "Auto Q in Harass Mode", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("T"))
      Menu.h:permaShow("useQToggle")
      Menu.h:addParam("useQTSettings", "Q Settings in Toggle", SCRIPT_PARAM_LIST, 1, {"Always", "If E Not Ready", "Soon! Out of AA Range"})
    Menu:addSubMenu("Clear", "clearMenu")
      Menu.clearMenu:addParam("useQ", "Use Q", SCRIPT_PARAM_ONOFF, false)
      Menu.clearMenu:addParam("useE", "Use E", SCRIPT_PARAM_ONOFF, false)
    Menu:addSubMenu("Lasthit", "lasthitMenu")
      Menu.lasthitMenu:addParam("useQ", "Use Q", SCRIPT_PARAM_ONOFF, false)
      Menu.lasthitMenu:addParam("useE", "Use E", SCRIPT_PARAM_ONOFF, false)
    Menu:addSubMenu("W Settings", "wSett")
      Menu.wSett:addParam("useWAuto", "Auto W on CC'd enemies", SCRIPT_PARAM_ONOFF, true)
      Menu.wSett:addParam("useWGap", "Auto W on Targeted Dash Spells", SCRIPT_PARAM_ONOFF, true)
      Menu.wSett:addParam("useWGapNo", "Auto W on Non Targeted Dash Spells", SCRIPT_PARAM_ONOFF, true)
    Menu:addSubMenu("Q & E Settings", "qeSett")
      Menu.qeSett:addParam("Qcollisions", "Use Q Collision", SCRIPT_PARAM_ONOFF, true)
      Menu.qeSett:addParam("Ecollisions", "Use E Collision", SCRIPT_PARAM_ONOFF, true)
      Menu.qeSett:addParam("blank", "Choose your EQ Settings", SCRIPT_PARAM_INFO, " ")
      Menu.qeSett:addParam("useQEList", "EQ Settings", SCRIPT_PARAM_LIST, 1, {"EQ Combo", "Off"})
      Menu.qeSett:addParam("useQEQSettings", "Q Settings in EQ Mode", SCRIPT_PARAM_LIST, 1, {"Only in EQ Combo", "Always"})
      Menu.qeSett:addParam("useQEESettings", "E Settings in EQ Mode", SCRIPT_PARAM_LIST, 1, {"Only in EQ Combo", "Always"})
      Menu.qeSett:addParam("blank", "If EQ Settings is Off ^ This will be Off too.", SCRIPT_PARAM_INFO, "")
      Menu.qeSett:addParam("blank", "If you use EQ Settings let this Off!", SCRIPT_PARAM_INFO, " ")
      Menu.qeSett:addParam("useQList", "Q Settings", SCRIPT_PARAM_LIST, 1, {"Off", "If E Not Ready", "Always", "Soon! Out of AA Range"})
      Menu.qeSett:addParam("blank", "If you use EQ Settings let this Off!", SCRIPT_PARAM_INFO, " ")
      Menu.qeSett:addParam("useEList", "E Settings", SCRIPT_PARAM_LIST, 1, {"Off", "If Q Not Ready", "Always", "Soon! Out of AA Range"})
    Menu:addSubMenu("Key Settings", "key")
      Menu.key:addParam("comboKey", "Combo Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte(" "))
      Menu.key:permaShow("comboKey")
      Menu.key:addParam("clearKey", "Clear Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
      Menu.key:addParam("lasthitKey", "Lasthit Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("X"))
      Menu.key:addParam("harassKey", "Harass Mode", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
      Menu.key:permaShow("harassKey")
    Menu:addSubMenu("Killsteal", "killsteal")
      Menu.killsteal:addParam("blank", "Will Auto R if NOT in Combo Mode", SCRIPT_PARAM_INFO, " ")
      Menu.killsteal:addParam("useR", "Killsteal with R", SCRIPT_PARAM_ONOFF, true)
      Menu.killsteal:addParam("useRRange", "Use R Above Range", SCRIPT_PARAM_SLICE, 700, 0, 3000)
    Menu:addSubMenu("Skinchanger", "skin")
      Menu.skin:addParam("blank", "Choose your Skin!", SCRIPT_PARAM_INFO, " ")
    Menu:addSubMenu("Drawings", "draws")
      Menu.draws:addParam("CDTracker", "Use CD Tracker", SCRIPT_PARAM_ONOFF, true) 
      Menu.draws:addParam("AARange", "AA Range", SCRIPT_PARAM_ONOFF, true)
      Menu.draws:addParam("RecallTracker", "Use Recallmessage", SCRIPT_PARAM_ONOFF, true)
      Menu.draws:addParam("TeleportTracker", "Use Teleportmessage", SCRIPT_PARAM_ONOFF, true)
    Menu:addParam("kl1", "Author:", SCRIPT_PARAM_INFO, "timo62")
    Menu:addParam("kl2", "Your Region:", SCRIPT_PARAM_INFO, GetGameRegion())
    Menu:addParam("kl3", "Your BoL ID:", SCRIPT_PARAM_INFO, GetUser())

                 
end

function Combo(enemy)
  if ValidTarget(enemy) then 
    -- Menu EQ Settings
    if Menu.qeSett.useQEList == 1 then
      if Menu.c.useE and Eready and Menu.c.useQ and Qready and GetDistance(enemy) <= 875 and Menu.qeSett.useQEQSettings == 1 and Menu.qeSett.useQEQSettings == 1 then
        CastE(enemy)
        CastQ(enemy)
      elseif Menu.c.useQ and Qready and not Eready and Menu.qeSett.useQEQSettings == 2 then
        CastQ(enemy)
      elseif Menu.c.useE and Eready and not Qready and Menu.qeSett.useQEESettings == 2 then
        CastE(enemy)
      end
    end
     -- Menu EQ Settings

    -- Menu Q Settings
    if Menu.qeSett.useQList == 2 and Menu.qeSett.useQEList == 2 then
      if Menu.c.useQ and Qready and not Eready then
        CastQ(enemy)
      end
    end

    if Menu.qeSett.useQList == 3 and Menu.qeSett.useQEList == 2 then 
      if Menu.c.useQ and Qready --[[and GetDistance(enemy) >= AARange]] and GetDistance(enemy) <= QRange then
        CastQ(enemy)
      end
    end
    -- Menu Q Settings

    -- Menu E Settings
    if Menu.qeSett.useEList == 2 and Menu.qeSett.useQEList == 2 then
      if Menu.c.useE and Eready and not Qready then
        CastE(enemy)
      end
    end

    if Menu.qeSett.useEList == 3 and Menu.qeSett.useQEList == 2 then
      if Menu.c.useE and Eready --[[and GetDistance(enemy) >= AARange]] and GetDistance(enemy) <= ERange then
        CastE(enemy)
      end
    end
  end
end

function Harass (enemy)
  if ValidTarget(enemy) then 
    if Menu.h.useQTSettings == 1 then 
      CastSpell(_Q, enemy.x, enemy.z)
    elseif Menu.h.useQTSettings == 2 then
      if not Eready then 
        CastSpell(_Q, enemy.x, enemy.z)
      end
      elseif Menu.h.useQTSettings == 3 then
        -- Out of AA Range soon
      end
   end
end

function Clear ()
  for _, minion in pairs(enemyMinions.objects) do
      if Menu.clearMenu.useE then CastSpell(_E, minion.x, minion.z) end
      if Menu.clearMenu.useQ then CastSpell(_Q, minion.x, minion.z) end
    end
    for _, minion in pairs(jungleMinions.objects) do
      if Menu.clearMenu.useE then CastSpell(_E, minion.x, minion.z) end
      if Menu.clearMenu.useQ then CastSpell(_Q, minion.x, minion.z) end
    end
end

function AutoR()
    for i, enemy in ipairs(GetEnemyHeroes()) do
  --rDmg calculation is from PewPewPew
  local rDmg = (((225*myHero:GetSpellData(_R).level) + (myHero.addDamage * 2)) * (100 / (100 + ((enemy.armor * myHero.armorPenPercent) - myHero.armorPen)))) - (enemy.hpRegen * (1 + (GetDistance(enemy) / 3000)))
  --^ from PewPewPew
      if Menu.killsteal.useR and ValidTarget(enemy) and GetDistance(enemy) <= Menu.killsteal.useRRange then
        if enemy.health <= rDmg then
          if not Menu.key.comboKey then
            CastSpell(_R, enemy)
          end
      end
    end
  end
end

function Lasthit ()
  if  Menu.lasthitMenu.useE then
        for i, minion in pairs (enemyMinions.objects) do
        local eDmg = getDmg("E", minion, myHero)
            if Eready and eDmg >= (minion.health+20) then
                CastSpell(_E, minion.x, minion.z)
            end
      end
    end
    if  Menu.lasthitMenu.useQ then
        for i, minion in pairs (enemyMinions.objects) do
        local qDmg = getDmg("Q", minion, myHero)
            if Qready and qDmg >= (minion.health+20) then
                CastSpell(_Q, minion.x, minion.z)
            end
      end
    end
end

function Checks()
    enemyMinions:update()
    jungleMinions:update()
    ts:update()
    tsQ:update()
    tsW:update()
    tsE:update()
    tsR:update()
    Qready = (myHero:CanUseSpell(_Q) == READY)
    Wready = (myHero:CanUseSpell(_W) == READY)
    Eready = (myHero:CanUseSpell(_E) == READY)
    Rready = (myHero:CanUseSpell(_R) == READY)
    Target = ts.target
    TargetR = tsR.target
end

function CastQ(enemy)
  if GetDistance(enemy) <= QRange and Qready then 
  local CastPosition, HitChance, CastPos = VP:GetLineCastPosition(enemy, 0.625, 80, 1300, 2200, myHero, MenuTrueFalseQ)
    if HitChance >= 2 and GetDistance(CastPosition) <= QRange and GetDistance(CastPosition) >= 700  then
      CastSpell(_Q, CastPosition.x, CastPosition.z)
    end
  end
end
function CastE(enemy)
  if GetDistance(enemy) <= ERange and Eready then 
  local CastPosition, HitChance, CastPos = VP:GetLineCastPosition(enemy, 0.4, 80, 1000, 2000, myHero, MenuTrueFalseE)
    if HitChance >= 2 and GetDistance(CastPosition) <= ERange and GetDistance(CastPosition) >= 700 then
      CastSpell(_E, CastPosition.x, CastPosition.z)
    end
  end
end

-- Credits PvPSuite
function SkinLoad()
    Menu.skin:addParam('changeSkin', 'Change Skin', SCRIPT_PARAM_ONOFF, false);
    Menu.skin:setCallback('changeSkin', function(nV)
        if (nV) then
            SetSkin(myHero, Menu.skin.skinID)
        else
            SetSkin(myHero, -1)
        end
    end)
    Menu.skin:addParam('skinID', 'Skin', SCRIPT_PARAM_LIST, 1, {"Resistance", "Sheriff", "Safari", "Arctic Warfare", "Officer", "Headhunter", "Chroma Pack: Pink", "Chroma Pack: Green", "Chroma Pack: Blue","Lunar", "Classic"})
    Menu.skin:setCallback('skinID', function(nV)
        if (Menu.skin.changeSkin) then
            SetSkin(myHero, nV)
        end
    end)
    
    if (Menu.skin.changeSkin) then
        SetSkin(myHero, Menu.skin.skinID)
    end
end
-- Credits PvPSuite

function DrawCircle3D(x, y, z, radius, width, color, quality)
    radius = radius or AARange
    quality = quality and 2 * math.pi / quality or 2 * math.pi / (radius / 5)
    local points = {}
    for theta = 0, 2 * math.pi + quality, quality do
        local c = WorldToScreen(D3DXVECTOR3(x + radius * math.cos(theta), y, z - radius * math.sin(theta)))
        points[#points + 1] = D3DXVECTOR2(c.x, c.y)
    end
DrawLines2(points, width or 1, color or 2294967295)
end

function OnDraw()
  if Menu.draws.CDTracker then DrawCD() end

  if Menu.draws.AARange then DrawCircle3D(myHero.x, myHero.y, myHero.z) end
end

function GetHPBarPos(enemy)
  enemy.barData = {PercentageOffset = {x = -0.05, y = 0}}--GetEnemyBarData()
  local barPos = GetUnitHPBarPos(enemy)
  local barPosOffset = GetUnitHPBarOffset(enemy)
  local barOffset = { x = enemy.barData.PercentageOffset.x, y = enemy.barData.PercentageOffset.y }
  local barPosPercentageOffset = { x = enemy.barData.PercentageOffset.x, y = enemy.barData.PercentageOffset.y }
  local BarPosOffsetX = 171
  local BarPosOffsetY = 46
  local CorrectionY = 39
  local StartHpPos = 31

  barPos.x = math.floor(barPos.x + (barPosOffset.x - 0.5 + barPosPercentageOffset.x) * BarPosOffsetX + StartHpPos)
  barPos.y = math.floor(barPos.y + (barPosOffset.y - 0.5 + barPosPercentageOffset.y) * BarPosOffsetY + CorrectionY)

  local StartPos = Vector(barPos.x , barPos.y, 0)
  local EndPos = Vector(barPos.x + 108 , barPos.y , 0)
  return Vector(StartPos.x, StartPos.y, 0), Vector(EndPos.x, EndPos.y, 0)
end

function DrawCD()
  for i = 1, heroManager.iCount, 1 do
    local champ = heroManager:getHero(i)
    if champ ~= nil and champ ~= myHero and champ.visible and champ.dead == false then
      local barPos = GetHPBarPos(champ)
      if OnScreen(barPos.x, barPos.y) then
        local cd = {}
        cd[0] = math.ceil(champ:GetSpellData(SPELL_1).currentCd)
        cd[1] = math.ceil(champ:GetSpellData(SPELL_2).currentCd)
        cd[2] = math.ceil(champ:GetSpellData(SPELL_3).currentCd)
        cd[3] = math.ceil(champ:GetSpellData(SPELL_4).currentCd)
        
        local spellColor = {}
        spellColor[0] = 0xBBFFD700;
        spellColor[1] = 0xBBFFD700;
        spellColor[2] = 0xBBFFD700;
        spellColor[3] = 0xBBFFD700;
                     
        if cd[0] == nil or cd[0] == 0 then cd[0] = "Q" spellColor[0] = 0xBBFFFFFF end
        if cd[1] == nil or cd[1] == 0 then cd[1] = "W" spellColor[1] = 0xBBFFFFFF end
        if cd[2] == nil or cd[2] == 0 then cd[2] = "E" spellColor[2] = 0xBBFFFFFF end
        if cd[3] == nil or cd[3] == 0 then cd[3] = "R" spellColor[3] = 0xBBFFFFFF end
        
        if champ:GetSpellData(SPELL_1).level == 0 then spellColor[0] = 0xBBFF0000 end
        if champ:GetSpellData(SPELL_2).level == 0 then spellColor[1] = 0xBBFF0000 end
        if champ:GetSpellData(SPELL_3).level == 0 then spellColor[2] = 0xBBFF0000 end
        if champ:GetSpellData(SPELL_4).level == 0 then spellColor[3] = 0xBBFF0000 end
        DrawRectangle(barPos.x-6, barPos.y-40, 80, 15, 0xBB202020)
        DrawText("[" .. cd[0] .. "]" ,12, barPos.x-5+2, barPos.y-40, spellColor[0])
        DrawText("[" .. cd[1] .. "]", 12, barPos.x+15+2, barPos.y-40, spellColor[1])
        DrawText("[" .. cd[2] .. "]", 12, barPos.x+35+2, barPos.y-40, spellColor[2])
        DrawText("[" .. cd[3] .. "]", 12, barPos.x+54+2, barPos.y-40, spellColor[3])
      end
    end
  end
end

class 'Download'

function Download:__init()
  socket = require("socket")
  self.aktivedownloads = {}
  self.callbacks = {}

  AddTickCallback(function ()
    self:RemoveDone()
  end)

  class("Async")
  function Async:__init(host, filepath, localname, drawoffset, localpath)
    self.progress = 0
    self.host = host
    self.filepath = filepath
    self.localname = localname
    self.offset = drawoffset
    self.localpath = localpath
    self.CRLF = '\r\n'

    self.headsocket = socket.tcp()
    self.headsocket:settimeout(1)
    self.headsocket:connect(self.host, 80)
    self.headsocket:send('HEAD '..self.filepath..' HTTP/1.1'.. self.CRLF ..'Host: '..self.host.. self.CRLF ..'User-Agent: Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36'.. self.CRLF .. self.CRLF)

    self.HEADdata = ""
    self.DLdata = ""
    self.StartedDownload = false
    self.canDL = true

    AddTickCallback(function ()
      self:tick()
    end)
    AddDrawCallback(function ()
      self:draw()
    end)
  end

  function Async:tick()
    if self.progress == 100 then return end
    if self.HEADcStatus ~= "timeout" and self.HEADcStatus ~= "closed" then
      self.HEADfString, self.HEADcStatus, self.HEADpString = self.headsocket:receive(16);
      if self.HEADfString then
        self.HEADdata = self.HEADdata..self.HEADfString
      elseif self.HEADpString and #self.HEADpString > 0 then
        self.HEADdata = self.HEADdata..self.HEADpString
      end
    elseif self.HEADcStatus == "timeout" then
      self.headsocket:close()
      --Find Lenght
      local begin = string.find(self.HEADdata, "Length: ")
      if begin then
        self.HEADdata = string.sub(self.HEADdata,begin+8)
        local n = 0
        local _break = false
        for i=1, #self.HEADdata do
          local c = tonumber(string.sub(self.HEADdata,i,i))
          if c and _break == false then
            n = n+1
          else
            _break = true
          end
        end
        self.HEADdata = string.sub(self.HEADdata,1,n)
        self.StartedDownload = true
        self.HEADcStatus = "closed"
      end
    end
    if self.HEADcStatus == "closed" and self.StartedDownload == true and self.canDL == true then --Double Check
      self.canDL = false
      self.DLsocket = socket.tcp()
      self.DLsocket:settimeout(1)
      self.DLsocket:connect(self.host, 80)
      --Start Main Download
      self.DLsocket:send('GET '..self.filepath..' HTTP/1.1'.. self.CRLF ..'Host: '..self.host.. self.CRLF ..'User-Agent: Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36'.. self.CRLF .. self.CRLF)
    end
    
    if self.DLsocket and self.DLcStatus ~= "timeout" and self.DLcStatus ~= "closed" then
      self.DLfString, self.DLcStatus, self.DLpString = self.DLsocket:receive(1024);
      
      if ((self.DLfString) or (self.DLpString and #self.DLpString > 0)) then
        self.DLdata = self.DLdata .. (self.DLfString or self.DLpString)
      end

    elseif self.DLcStatus and self.DLcStatus == "timeout" then
      self.DLsocket:close()
      self.DLcStatus = "closed"
      self.DLdata = string.sub(self.DLdata,#self.DLdata-tonumber(self.HEADdata)+1)

      local file = io.open(self.localpath.."\\"..self.localname, "w+b")
      file:write(self.DLdata)
      file:close()
      self.progress = 100
    end

    if self.progress ~= 100 and self.DLdata and #self.DLdata > 0 then
      self.progress = (#self.DLdata/tonumber(self.HEADdata))*100
    end
  end

  function Async:draw()
    if self.progress < 100 then
      DrawTextA("Downloading: "..self.localname,15,50,35+self.offset)
      DrawRectangleOutline(49,50+self.offset,250,20, ARGB(255,255,255,255),1)
      if self.progress ~= 100 then
        DrawLine(50,60+self.offset,50+(2.5*self.progress),60+self.offset,18,ARGB(150,255-self.progress*2.5,self.progress*2.5,255-self.progress*2.5))
        DrawTextA(tostring(math.round(self.progress).." %"), 15,150,52+self.offset)
      end
    end
  end

end

function Download:newDL(host, file, name, path, callback)
  local offset = (#self.aktivedownloads+1)*40
  self.aktivedownloads[#self.aktivedownloads+1] = Async(host, file, name, offset-40, path)
  if not callback then
    callback = (function ()
    end)
  end

  self.callbacks[#self.callbacks+1] = callback

end

function Download:RemoveDone()
  if #self.aktivedownloads == 0 then return end
  local x = {}
  for k, v in pairs(self.aktivedownloads) do
    if math.round(v.progress) < 100 then
      v.offset = k*40-40
      x[#x+1] = v
    else
      self.callbacks[k]()
    end
  end
  self.aktivedownloads = {}
  self.aktivedownloads = x
end