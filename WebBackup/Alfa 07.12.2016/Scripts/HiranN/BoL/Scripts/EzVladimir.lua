--[[
Ez Scripts - Vladimir

BuffChecker

function OnLoad() 
    PrintChat('Buff Check loaded')
end

function OnDraw()
    for i = 1, myHero.buffCount do
        local tBuff = myHero:getBuff(i)
        if BuffIsValid(tBuff) then
                DrawTextA(tBuff.name,20,20,20*i+20)
        end
    end
end

if spell.name == "Tides of Blood" then
		if eStacks < 4 then
			eStacks = eStacks + 1
		end
	end

]]

------------------[[Champion Check]]------------

if myHero.charName ~= "Vladimir" then return end

------------------[[Champion Check End]]-------

-------------------[[Locals]]-------------------
local Version = 0.2
local QRange = 600
local WRange = 0
local ERange = 610
local RRange = 700 -- R Active Hitbox range = 175
local qDmg = 0
local wDmg = 0
local eDmg = 0
local rDmg = 0
local selfHeal = 0
local EStacks = 0
local EHealExtra = 0
local EHealProzent = 0
local scriptmsg = '<font color=\"#72427a\">[Ez Scripts]</font><font color=\"#888888\"> - </font><font color=\"#cc0000\">Ez Vladimir Loaded.</font>'
-------------------[[Locals End]]--------------

-------------------[[Bol-tool Tracker]]--------
assert(load(Base64Decode("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"), nil, "bt", _ENV))()
TrackerLoad("fSwwc4CK4adJ8h0l")
-------------------[[Bol-tool Tracker end]]----

--------------------[[CheckUpdates]]-----------
function CheckUpdates()
  local host = "www.scarjit.de"
  local ServerVersionDATA = GetWebResult(host, "/HiranN/BoL/Versions/EzVladimir.version")  
  local ServerVersion = tonumber(ServerVersionDATA)
  if ServerVersionDATA then
  if ServerVersion then
  if ServerVersion > tonumber(Version) then
  print(scriptmsg.."<font color=\"#C2FDF3\"><b> Updating, don't press F9.</b></font>")
  DL = Download()
  file = "/HiranN/BoL/Scripts/EzVladimir.lua"
  name = "EzVladimir.lua"
  DL:newDL(host, file, name, SCRIPT_PATH)
  else
  print(scriptmsg.."<font color=\"#C2FDF3\"><b> No updates found.</b></font>")
  end
  end
end
end
--------------------[[CheckUpdates End]]-------

-------------------[[Menu]]---------------------
function Menu ()
	Menu = scriptConfig("Ez Scripts - Vladimir", "EzVlad")

	--|---------[[Combo]]-----------
	Menu:addSubMenu("Combo", "comboMenu")
    Menu.comboMenu:addParam("blank", "DONT MARK ANY SPELL USE OFF IF THEN THIS SCRIPT WONT WORK! ", SCRIPT_PARAM_INFO, " ")
		Menu.comboMenu:addParam("useQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
		Menu.comboMenu:addParam("useW", "Use W", SCRIPT_PARAM_ONOFF, true)
		Menu.comboMenu:addParam("useWAs", "Use W for", SCRIPT_PARAM_LIST, 1, {"Damage", "Saving for CC", "Let the Script do it :p"})
    Menu.comboMenu:permaShow("useWAs")
		--Menu.comboMenu:addParam("useWSave", "Use W if health under x%", SCRIPT_PARAM_SLICE, 20, 0, 100)
    Menu.comboMenu:addParam("useWRange", "Use W Under Range", SCRIPT_PARAM_SLICE, 200, 0, 1000) 
		Menu.comboMenu:addParam("useE", "Use E", SCRIPT_PARAM_ONOFF, true)
		Menu.comboMenu:addParam("useR", "Use R", SCRIPT_PARAM_ONOFF, true)
		Menu.comboMenu:addParam("useRAs", "Use R for", SCRIPT_PARAM_LIST, 1, {"Damage", "Only if QWE Ready", "Let the Script do it :p"})
    Menu.comboMenu:permaShow("useRAs")
	--|--------[[Clear]]-------------
	Menu:addSubMenu("Clear", "clearMenu")
		Menu.clearMenu:addParam("useQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
		Menu.clearMenu:addParam("useE", "Use E", SCRIPT_PARAM_ONOFF, true)
		Menu.clearMenu:addParam("useW", "Use W", SCRIPT_PARAM_ONOFF, false)
	--|--------[[Lasthit]]-----------
	Menu:addSubMenu("Lasthit", "lasthitMenu")
		Menu.lasthitMenu:addParam("useQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
		Menu.lasthitMenu:addParam("useQAuto", "Auto Q on Lasthits", SCRIPT_PARAM_ONOFF, true)
		Menu.lasthitMenu:permaShow("useQAuto")
		Menu.lasthitMenu:addParam("useE", "Use E", SCRIPT_PARAM_ONOFF, true)
		Menu.lasthitMenu:addParam("useEAuto", "Auto E on Lasthits", SCRIPT_PARAM_ONOFF, false)
    Menu.lasthitMenu:permaShow("useEAuto")
	--|--------[[Keybinds]]---------
	Menu:addSubMenu("Keybinds", "keys")
		Menu.keys:addParam("comboKey", "Combo Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte (" "))
		Menu.keys:addParam("clearKey", "Clear Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte ("V"))
		Menu.keys:addParam("lasthKey", "Lasthit Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte ("X"))
	--|-------[[Skinchanger]]--------
	Menu:addSubMenu("Skinchanger", "skin")
		if VIP_USER then
			Menu.skin:addParam("blank", "Choose a Skin you want to use!", SCRIPT_PARAM_INFO, " ")
    end
		if not VIP_USER then
			Menu.skin:addParam("blank", "You need to be VIP to use this Feature!", SCRIPT_PARAM_INFO, " ")
    end
  --|-------[[Drawings]]----------
  Menu:addSubMenu("Drawings", "draws")
    Menu.draws:addParam("CDTracker", "Use CD Tracker", SCRIPT_PARAM_ONOFF, true)
    Menu.draws:addParam("RecallTracker", "Use Recall Message", SCRIPT_PARAM_ONOFF, true)
end
-----------------[[Menu End]]-------------------

-----------------[[Skinchanger]]----------------
function SkinLoad()
    Menu.skin:addParam('changeSkin', 'Change Skin', SCRIPT_PARAM_ONOFF, true);
    Menu.skin:setCallback('changeSkin', function(nV)
        if (nV) then
            SetSkin(myHero, Menu.skin.skinID)
        else
            SetSkin(myHero, -1)
        end
    end)
    Menu.skin:addParam('skinID', 'Skin', SCRIPT_PARAM_LIST, 5, {"Count", "Marquis", "Nosferatu", "Vandal", "Blood Lord", "Soulstealer", "Academy", "Classic"})
    Menu.skin:setCallback('skinID', function(nV)
        if (Menu.skin.changeSkin) then
            SetSkin(myHero, nV)
        end
    end)
    
    if (Menu.skin.changeSkin) then
        SetSkin(myHero, Menu.skin.skinID)
    end
end
-----------------[[Skinchanger End]]--------------------------------------------------------

-----------------[[Table]]------------------------------------------------------------------
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
        --['YasuoDashWrapper']      = {true, Champ = 'Yasuo',   spellKey = 'E'},
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
-----------------[[Table End]]--------------------------------------------------------------

-----------------[[ApplyBuff, RemoveBuff and ProcessSpell]]---------------------------------
function OnApplyBuff(unit, source, buff)
  if unit and unit.isMe and buff and buff.name == "vladimirtidesofbloodcost" then
    if EStacks < 4 then
      EStacks = EStacks + 1
      EHealExtra = EStacks * EHealProzent
    end
  end
  if unit and unit.team ~= not myHero.team and buff and buff.name == "recall" then 
    if Menu.draws.RecallTracker then
      print("<font color=\"#C2FDF3\"><b>["..unit.charName.."] Is Recalling") --"<font color=\"#C2FDF3\"><b>"["..unit.charName.."] Is Recalling"</b></font>"
    end
  end
end

function OnRemoveBuff(unit, buff)
  if unit and unit.team ~= not myHero.team and buff and buff.name == "recall" then 
    if Menu.draws.RecallTracker then
      print("<font color=\"#C2FDF3\"><b>["..unit.charName.."] Recalled OR Cancelled Recall")
    end
  end
  if unit and unit.isMe and buff and buff.name == "vladimirtidesofbloodcost" then
    EStacks = 0
    EHealExtra = 0
  end
end

function OnProcessSpell (source, spell, enemy)
  if Menu.comboMenu.useWAs == 2 or Menu.comboMenu.useWAs == 3 then
    if DashesTarget[spell.name] and spell.target and spell.target.isMe then
      CastSpell(_W)
    end
    if DashesNoTarget[spell.name] and GetDistance(Target) <= 200 and (spell.target == nil or (spell.target and spell.target.isMe)) then
      CastSpell(_W)
    end
  end
end
-----------------[[ApplyBuff, RemoveBuff and ProcessSpell End]]-----------------------------


-----------------[[OnLoad]]-----------------------------------------------------------------
function OnLoad () 
  --LoadMenu + Skinchanger + Functions
	Menu()
	SkinLoad()
  Tables()
  CheckUpdates()
  -- End here

  --TargetSelector, Ts Menu, Ts Name, enemy & Jungle Minions
  ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, 900, DAMAGE_MAGICAL)
  ts.name = "Vladimir"
  Menu:addTS(ts)
  enemyMinions = minionManager(MINION_ENEMY, 700, myHero, MINION_SORT_HEALTH_ASC)
  jungleMinions = minionManager(MINION_JUNGLE, 700, myHero, MINION_SORT_MAXHEALTH_DEC)
  -- End here
end
-----------------[[OnLoad End]]-------------------------------------------------------------

-----------------[[OnTick]]-----------------------------------------------------------------
function OnTick ()
  -- Functions
	Checks()
  WRange = Menu.comboMenu.useWRange
  dmgQ()
  dmgE()
  dmgW()
  dmgR()
  ComboDmg ()
  --
  --print("Heal: "..eDmg)

  -- Combos etc.
  if Menu.keys.comboKey then Combo() end
  if Menu.keys.lasthKey then Lasthit() end
  if Menu.lasthitMenu.useQAuto and not Menu.keys.comboKey then AutoQ() end
  if Menu.lasthitMenu.useEAuto and not Menu.keys.comboKey then AutoE() end
  if Menu.keys.clearKey then Clear() end
  --
end
-----------------[[OnTick End]]-------------------------------------------------------------

---------------[[Check OnTick]]---------------------------------------------------------------
function Checks ()
	ts:update()
	enemyMinions:update()
	jungleMinions:update()
	Qready = (myHero:CanUseSpell(_Q) == READY)
  Wready = (myHero:CanUseSpell(_W) == READY)
  Eready = (myHero:CanUseSpell(_E) == READY)
  Rready = (myHero:CanUseSpell(_R) == READY)
  Target = ts.target
end
--------------[[Check OnTick End]]--------------------------------------------------------------

-----------------[[OnDraw]]-----------------------------------------------------------------
--[[function OnDraw() -- vladimirtidesofbloodcost
  if Menu.draws.CDTracker then DrawCD() end
    for i = 1, myHero.buffCount do
        local tBuff = myHero:getBuff(i)
        if BuffIsValid(tBuff) then
                DrawTextA(tBuff.name,20,20,20*i+20)
        end
    end
    local pos = WorldToScreen(D3DXVECTOR3(myHero.x, myHero.y, myHero.z))
    DrawTextA("Extraheal %: "..EHealExtra, 18, pos.x, pos.y, 0xFFFFFF00)

    --DrawText("Stack:"..PassiveStacks, 18, pos.x, pos.y, 0xFFFFFF00)
    --DrawTextA(text, size, x, y, color, halign, valign)
end]]
-----------------[[OnDraw]]-----------------------------------------------------------------

-------------[[HPBarPos + CD Tracker]]----------------------------------------------------------
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
-----------------[[HPBarPos + CD Tracker End]]-----------------------------------------------------------------

-----------------[[Combo Mode + Logics]]-----------------------------------------------------------------------
function Combo ()
 --myHero:MoveTo(mousePos.x, mousePos.z)
  if ValidTarget(Target) then
    --Skill combo #1
    -- RW -> EQ + Zhonya -> EQW W Dmg - R Dmg WORKING
    if Menu.comboMenu.useQ and Menu.comboMenu.useE and Menu.comboMenu.useW and Menu.comboMenu.useWAs == 1 and Menu.comboMenu.useR and Menu.comboMenu.useRAs == 1 then
      if Rready and GetDistance(Target) <= RRange then
        CastSpell(_R, Target.x, Target.z)
      end
      if Wready and GetDistance(Target) <= WRange then
        CastSpell(_W)
      end
      if Eready and GetDistance(Target) <= ERange then
        CastSpell(_E)
      end
      if Qready and GetDistance(Target) <= QRange then
        CastSpell(_Q, Target)
      end
    end
    --- W Save - R Dmg WORKING
    if Menu.comboMenu.useQ and Menu.comboMenu.useE and Menu.comboMenu.useW and Menu.comboMenu.useWAs == 2 and Menu.comboMenu.useR and Menu.comboMenu.useRAs == 1 then
      if Rready and GetDistance(Target) <= RRange then
        CastSpell(_R, Target.x, Target.z)
      end
      if Wready then
        --
      end
      if Eready and GetDistance(Target) <= ERange then
        CastSpell(_E)
      end
      if Qready and GetDistance(Target) <= QRange then
        CastSpell(_Q, Target)
      end
    end
    --- W Save R RDY all WORKING
    if Menu.comboMenu.useQ and Menu.comboMenu.useE and Menu.comboMenu.useW and Menu.comboMenu.useWAs == 2 and Menu.comboMenu.useR and Menu.comboMenu.useRAs == 2 then
      if Rready and Qready and Eready and Wready and GetDistance(Target) <= RRange then
        CastSpell(_R, Target.x, Target.z)
      end
      if Wready then
        --
      end
      if Eready and GetDistance(Target) <= ERange then
        CastSpell(_E)
      end
      if Qready and GetDistance(Target) <= QRange then
        CastSpell(_Q, Target)
      end
    end
    --W DMG - R RDY ALL WORKING
    if Menu.comboMenu.useQ and Menu.comboMenu.useE and Menu.comboMenu.useW and Menu.comboMenu.useWAs == 1 and Menu.comboMenu.useR and Menu.comboMenu.useRAs == 2 then
      if Rready and Qready and Eready and Wready and GetDistance(Target) <= RRange then
        CastSpell(_R, Target.x, Target.z)
      end
      if Wready and GetDistance(Target) <= WRange then
        CastSpell(_W)
      end
      if Eready and GetDistance(Target) <= ERange then
        CastSpell(_E)
      end
      if Qready and GetDistance(Target) <= QRange then
        CastSpell(_Q, Target)
      end
    end
    --Script - R Dmg WORKING
    if Menu.comboMenu.useQ and Menu.comboMenu.useE and Menu.comboMenu.useW and Menu.comboMenu.useWAs == 3 and Menu.comboMenu.useR and Menu.comboMenu.useRAs == 1 then
      if Rready and GetDistance(Target) <= RRange then
        CastSpell(_R, Target.x, Target.z)
      end    
      -- W Script Logic                                             -- max * 80(the % of life i want) / 100  
      if Wready and GetDistance(Target) <= WRange and myHero.health >= (myHero.maxHealth*80/100) and CountEnemyHeroInRange(800) <= 3 then
        CastSpell(_W) --if myHero.health <= (myHero.maxHealth*Menu.r.autoR/100)
      elseif Wready and GetDistance(Target) <= WRange and myHero.health <= (myHero.maxHealth*75/100) and CountEnemyHeroInRange(800) >= 2 then
        -- Save W 
      elseif Wready and GetDistance(Target) <= WRange and myHero.health <= (myHero.maxHealth*75/100) and CountEnemyHeroInRange(800) <= 1 then
        CastSpell(_W) -- Bc only 1 enemy, cast W for the Dmg
      elseif Wready and GetDistance(Target) <= WRange and myHero.health <= (myHero.maxHealth*25/100) and CountEnemyHeroInRange(800) >= 2 then 
        -- Save W
      elseif Wready and GetDistance(Target) <= WRange and myHero.health <= (myHero.maxHealth*25/100) and CountEnemyHeroInRange(800) <= 1 then
        CastSpell(_W)
      elseif Wready and GetDistance(Target) <= WRange and myHero.health <= (myHero.maxHealth*25/100) and CountEnemyHeroInRange(800) >= 1 then
        CastSpell(_W)
      end
      --end
      if Eready and GetDistance(Target) <= ERange then
        CastSpell(_E)
      end
      if Qready and GetDistance(Target) <= QRange then
        CastSpell(_Q, Target)
      end
    end
    -- Script - R Rdy WORKING
    if Menu.comboMenu.useQ and Menu.comboMenu.useE and Menu.comboMenu.useW and Menu.comboMenu.useWAs == 3 and Menu.comboMenu.useR and Menu.comboMenu.useRAs == 2 then
      if Rready and Qready and Eready and Wready and GetDistance(Target) <= RRange then
        CastSpell(_R, Target.x, Target.z)
      end
      -- W Script Logic                                             -- max * 80(the % of life i want) / 100  
      if Wready and GetDistance(Target) <= WRange and myHero.health >= (myHero.maxHealth*80/100) and CountEnemyHeroInRange(800) <= 3 then
        CastSpell(_W) --if myHero.health <= (myHero.maxHealth*Menu.r.autoR/100)
      elseif Wready and GetDistance(Target) <= WRange and myHero.health <= (myHero.maxHealth*75/100) and CountEnemyHeroInRange(800) >= 2 then
        -- Save W 
      elseif Wready and GetDistance(Target) <= WRange and myHero.health <= (myHero.maxHealth*75/100) and CountEnemyHeroInRange(800) <= 1 then
        CastSpell(_W) -- Bc only 1 enemy, cast W for the Dmg
      elseif Wready and GetDistance(Target) <= WRange and myHero.health <= (myHero.maxHealth*25/100) and CountEnemyHeroInRange(800) >= 2 then 
        -- Save W
      elseif Wready and GetDistance(Target) <= WRange and myHero.health <= (myHero.maxHealth*25/100) and CountEnemyHeroInRange(800) <= 1 then
        CastSpell(_W)
      elseif Wready and GetDistance(Target) <= WRange and myHero.health <= (myHero.maxHealth*25/100) and CountEnemyHeroInRange(800) >= 1 then
        CastSpell(_W)
      end
      --end
      if Eready and GetDistance(Target) <= ERange then
        CastSpell(_E)
      end
      if Qready and GetDistance(Target) <= QRange then
        CastSpell(_Q, Target)
      end
    end
    -- Script - Script
    if Menu.comboMenu.useQ and Menu.comboMenu.useE and Menu.comboMenu.useW and Menu.comboMenu.useWAs == 3 and Menu.comboMenu.useR and Menu.comboMenu.useRAs == 3 then
      --- R logic Scriot
        if Rready and GetDistance(Target) <= RRange and Target.health <= (Target.maxHealth*50/100) then
          CastSpell(_R, Target.x, Target.z)
        elseif Rready and Wready and GetDistance(Target) <= RRange then
          CastSpell(_R, Target.x, Target.z)
        end
      --- R Logic Script
      -- W Script Logic                                             -- max * 80(the % of life i want) / 100  
      if Wready and GetDistance(Target) <= WRange and myHero.health >= (myHero.maxHealth*80/100) and CountEnemyHeroInRange(800) <= 3 then
        CastSpell(_W) --if myHero.health <= (myHero.maxHealth*Menu.r.autoR/100)
      elseif Wready and GetDistance(Target) <= WRange and myHero.health <= (myHero.maxHealth*75/100) and CountEnemyHeroInRange(800) >= 2 then
        -- Save W 
      elseif Wready and GetDistance(Target) <= WRange and myHero.health <= (myHero.maxHealth*75/100) and CountEnemyHeroInRange(800) <= 1 then
        CastSpell(_W) -- Bc only 1 enemy, cast W for the Dmg
      elseif Wready and GetDistance(Target) <= WRange and myHero.health <= (myHero.maxHealth*25/100) and CountEnemyHeroInRange(800) >= 2 then 
        -- Save W
      elseif Wready and GetDistance(Target) <= WRange and myHero.health <= (myHero.maxHealth*25/100) and CountEnemyHeroInRange(800) <= 1 then
        CastSpell(_W)
      elseif Wready and GetDistance(Target) <= WRange and myHero.health <= (myHero.maxHealth*25/100) and CountEnemyHeroInRange(800) >= 1 then
        CastSpell(_W)
      end
      --end
      if Eready and GetDistance(Target) <= ERange then
        CastSpell(_E)
      end
      if Qready and GetDistance(Target) <= QRange then
        CastSpell(_Q, Target)
      end
    end
    -- W Dmg - Script
    if Menu.comboMenu.useQ and Menu.comboMenu.useE and Menu.comboMenu.useW and Menu.comboMenu.useWAs == 1 and Menu.comboMenu.useR and Menu.comboMenu.useRAs == 3 then
      --- R logic Script
        if Rready and GetDistance(Target) <= RRange and Target.health <= (Target.maxHealth*50/100) then
          CastSpell(_R, Target.x, Target.z)
        elseif Rready and Wready and GetDistance(Target) <= RRange then
          CastSpell(_R, Target.x, Target.z)
        end
      --- R Logic Script
      if Wready and GetDistance(Target) <= WRange then
        CastSpell(_W)
      end
      if Eready and GetDistance(Target) <= ERange then
        CastSpell(_E)
      end
      if Qready and GetDistance(Target) <= QRange then
        CastSpell(_Q, Target)
      end
    end
    -- W Save - Script 
    if Menu.comboMenu.useQ and Menu.comboMenu.useE and Menu.comboMenu.useW and Menu.comboMenu.useWAs == 2 and Menu.comboMenu.useR and Menu.comboMenu.useRAs == 3 then
      --- R logic Scriot
        if Rready and GetDistance(Target) <= RRange and Target.health <= (Target.maxHealth*50/100) then
          CastSpell(_R, Target.x, Target.z)
        elseif Rready and Wready and GetDistance(Target) <= RRange then
          CastSpell(_R, Target.x, Target.z)
        end
      --- R Logic Script
      if Wready then
        -- Save W
      end
      if Eready and GetDistance(Target) <= ERange then
        CastSpell(_E)
      end
      if Qready and GetDistance(Target) <= QRange then
        CastSpell(_Q, Target)
      end
    end
    --
  end
end
-----------------[[Combo Mode + Logics End]]---------------------------------------------------------------------

-----------------[[Lasthit Mode]]-------------------------------------------------------------------------------
function Lasthit ()
  ComboDmg()
    enemyMinions:update()
    for i, minion in pairs (enemyMinions.objects) do
      if Menu.lasthitMenu.useQ and Qready and qDmg >= (minion.health) then
        CastSpell(_Q, minion)
      end
      if Menu.lasthitMenu.useE and Eready and GetDistance(minion) <= ERange and eDmg >= (minion.health) then
        CastSpell(_E)
      end
    end
end
function AutoQ ()
  ComboDmg()
  enemyMinions:update()
  for i, minion in pairs (enemyMinions.objects) do
    if Menu.lasthitMenu.useQAuto and Qready and qDmg >= (minion.health) then
      CastSpell(_Q, minion)
    end
  end
end
function AutoE ()
  ComboDmg()
  enemyMinions:update()
  for i, minion in pairs (enemyMinions.objects) do
    if Menu.lasthitMenu.useEAuto and Eready and eDmg >= (minion.health) then
      CastSpell(_E)
    end
  end
end
-----------------[[Lasthit Mode End]]----------------------------------------------------------------------------

-----------------[[Clear Mode]]----------------------------------------------------------------------------------
function Clear()
  enemyMinions:update()
  jungleMinions:update()
  for _, minion in pairs(enemyMinions.objects) do
    if Menu.clearMenu.useE then CastSpell(_E) end
    if Menu.clearMenu.useQ then CastSpell(_Q, minion) end 
    if Menu.clearMenu.useW then CastSpell(_W) end            
  end
  for _, minion in pairs(jungleMinions.objects) do
    if Menu.clearMenu.useE then CastSpell(_E) end
    if Menu.clearMenu.useQ then CastSpell(_Q, minion) end 
    if Menu.clearMenu.useW then CastSpell(_W) end               
  end               
end
---------------[[Clear Mode End]]--------------------------------------------------------------------------------

-----------------[[Get Dmg from Skills]]-------------------------------------------------------------------------
function dmgQ()
  local baseDmgQ = 0
  --This works much easier only do this : qDmg = (55 + (myHero:GetSpellData(_Q).level*35)) + (AP * .6) but i did it this way, its just FOR me, i need it this way.
  if myHero:GetSpellData(_Q).level == 1 then
    baseDmgQ = 90
    selfHeal = 15
  end
  if myHero:GetSpellData(_Q).level == 2 then
    baseDmgQ = 125
    selfHeal = 25
  end
  if myHero:GetSpellData(_Q).level == 3 then
    baseDmgQ = 160
    selfHeal = 35
  end
  if myHero:GetSpellData(_Q).level == 4 then
    baseDmgQ = 195
    selfHeal = 45
  end
  if myHero:GetSpellData(_Q).level == 5 then
    baseDmgQ= 230
    selfHeal = 55
  end
  qDmg = baseDmgQ + (myHero.ap*60/100)
  selfHeal = selfHeal + (myHero.ap*25/100) + (selfHeal + (myHero.ap*25/100))*EStacks/100  -- EHealExtra
end
function dmgE()
  local baseDmgE = 0
  if myHero:GetSpellData(_E).level == 1 then
    baseDmgE = 60
    EHealProzent = 4
  end
  if myHero:GetSpellData(_E).level == 2 then
    baseDmgE = 85
    EHealProzent = 5
  end
  if myHero:GetSpellData(_E).level == 3 then
    baseDmgE = 110
    EHealProzent = 6
  end
  if myHero:GetSpellData(_E).level == 4 then
    baseDmgE = 135
    EHealProzent = 7
  end
  if myHero:GetSpellData(_E).level == 5 then
    baseDmgE = 160
    EHealProzent = 8
  end
  eDmg = baseDmgE + (myHero.ap*45/100) + (baseDmgE*(EStacks*25)/100)
  --Stacks
end
function dmgW()
  local baseDmgW = 0
  if myHero:GetSpellData(_W).level == 1 then
    baseDmgW = 90
  end
  if myHero:GetSpellData(_W).level == 2 then
    baseDmgW = 125
  end
  if myHero:GetSpellData(_W).level == 3 then
    baseDmgW = 160
  end
  if myHero:GetSpellData(_W).level == 4 then
    baseDmgW = 195
  end
  if myHero:GetSpellData(_W).level == 5 then
    baseDmgW = 230
  end
  wDmg = baseDmgW 
end
function dmgR()
  local baseDmgR = 0
  if myHero:GetSpellData(_R).level == 1 then
    baseDmgR = 150
  end
  if myHero:GetSpellData(_R).level == 2 then
    baseDmgR = 250
  end
  if myHero:GetSpellData(_R).level == 3 then
    baseDmgR = 350
  end
  rDmg = baseDmgR + (myHero.ap*70/100)
end
function ComboDmg ()
  local qDmg2 = 0
  local wDmg2= 0
  local eDmg2 = 0
  local rDmg2 = 0
  local allDmg = 0
  if Qready then
    qDmg2 = qDmg
  end
  if Wready then
    wDmg2 = wDmg
  end
  if Eready then
   eDmg2 = eDmg
  end
  if Rready then
    rDmg2 = rDmg
  end
  local allDmg = qDmg2+wDmg2+eDmg2+rDmg2
  --DrawTextA("Combodamage: "..allDmg, 18, 600, 700, 0xFFFFFF00)
end
-----------------[[Get Dmg from Skills End]]----------------------------------------------------------------------

--------------------[[Downloader Class]]--------------------------------------------------------------------------
class "Download"
function Download:__init()
  self.aktivedownloads = {}
  self.callbacks = {}

  AddTickCallback(function ()
    self:RemoveDone()
  end)

  class("Async")
  function Async:__init(host, file, name,offset, path)
    self.host = host
    self.filepath = file
    self.savename = name
    self.savepath = path
    self.offset = offset
    self.CRLF = '\r\n';
    self.Data = ""
    self.Headerlenght = 0
    self.progress = 0
    self.lenght = 0
    self.status = ""

    self.canDownload = false
    self.isDownloading = false

    --Open Socket
    self.socket = require("socket")
    self.tcp = self.socket.tcp()
    self.tcp:settimeout(99999,'b')
    self.tcp:settimeout(99999,'t')
    self.tcp:connect(self.host, 80)
    --
    self:GetFileSize()

    AddTickCallback(function ()
      self:Tick()
    end)
    AddDrawCallback(function ()
      self:Draw()
    end)
  end

  function Async:GetFileSize()
    self.status = "Requesting HEADER"
    self.tcp:send('HEAD '..self.filepath..' HTTP/1.1'.. self.CRLF ..'Host: '..self.host.. self.CRLF ..'User-Agent: Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36'.. self.CRLF .. self.CRLF)
  end

  function Async:Tick()
    if self.cStatus ~= 'timeout' then
      self.fString, self.cStatus, self.pString = self.tcp:receive(1024);
    end
    if ((self.fString) or (#self.pString > 0)) then
      self.Data = self.Data .. (self.fString or self.pString)
    end

    if self.canDownload == false and self.isDownloading == false and self.Data then
      local begins = string.find(self.Data, "Length: ")
      local x = string.sub(self.Data, begins+8, #self.Data)

      local brea = false
      local n = begins+8
      for i = begins+8, #self.Data do
          local c = self.Data:sub(i,i)
          if tonumber(c) ~= nil and brea == false then
            n = n + 1
          else
            brea = true
          end
      end
      local ends = n

      if begins and ends then
        self.lenght = tonumber(string.sub(self.Data, begins+8,n))
        self.Headerlenght = #self.Data
      end
      if self.lenght and self.lenght ~= 0 then
        self.status = "Starting download"
        self.Data = ""
        self.canDownload = true
      elseif self.lenght then
        self.status = "ERROR"
        self.progress = 0
      end
      
    end
    if self.canDownload == true then
      self.isDownloading = true
      self.canDownload = false

      self.tcp:close()
      self.cStatus = ''
      self.tcp = nil
      self.socket = nil
      self.socket = require("socket")
      self.tcp = self.socket.tcp()
      self.tcp:settimeout(99999,'b')
      self.tcp:settimeout(99999,'t')
      self.tcp:connect(self.host, 80)
      self.status = "Send GET"
      self.tcp:send('GET '..self.filepath..' HTTP/1.1'.. self.CRLF ..'Host: '..self.host.. self.CRLF ..'User-Agent: Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36'.. self.CRLF .. self.CRLF)
    end
    if self.cStatus == 'closed' and self.isDownloading == true then
      self.tcp:close()
      local file = io.open(self.savepath.."\\"..self.savename, "w+b")
      file:write(string.sub(self.Data,self.Headerlenght+1))
      file:close()

    end
  end

  function Async:Draw()
    if not self.lenght or not self.isDownloading or self.lenght == 0 then return end
    self.progress = math.round(#self.Data/self.lenght*100)

    if self.progress < 100 then
      DrawTextA("Updating: "..self.savename,15,50,35+self.offset)
      DrawRectangleOutline(49,50+self.offset,250,20, ARGB(255,255,255,255),1)
      DrawLine(50,60+self.offset,50+(2.5*self.progress),60+self.offset,18,ARGB(150,255,255,255))
      if self.progress == 0 then
        DrawTextA(self.status,15,50,53+self.offset)
      else
        local dspl = #self.Data
        local filesize = self.lenght
        local unit = "Byte"
        if dspl >= 1000 then
          unit = "Kilo Byte"
          dspl = dspl/1000
        end
        if dspl >= 1000 then
          unit = "Mega Byte"
          dspl = dspl/1000
        end

        local unit2 = "Byte"
        if filesize >= 1000 then
          unit2 = "Kilo Byte"
          filesize = filesize/1000
        end
        if filesize >= 1000 then
          unit2 = "Mega Byte"
          filesize = filesize/1000
        end

        dspl = math.floor(dspl)
        filesize = math.floor(filesize)
        DrawTextA(dspl.." "..unit.."/"..filesize.." "..unit2,15,75,53+self.offset)
      end
    end
  end
end

function Download:newDL(host, file, name, path, callback)
  local offset = (#self.aktivedownloads)*40
  self.aktivedownloads[#self.aktivedownloads+1] = Async(host, file, name, offset, path)
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
    if v.progress < 100 then
      v.offset = k*40
      x[#x+1] = v
    else
      self.callbacks[k]()
    end
  end
  self.aktivedownloads = {}
  self.aktivedownloads = x
end
--------------------[[Downloader Class End]]------------------------