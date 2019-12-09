if myHero.charName ~= "Vayne" then return end

local Version = 29.1923
local FileName = _ENV.FILE_NAME
local ScriptName = "Turkish Vayne Force"
local Debug = false

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

-- ###################################################################################################### --
-- #                                                                                                    # --
-- #                                        INTERNAL CHECKS                                             # --
-- #                                                                                                    # --
-- #                                                                                                    # --
-- ###################################################################################################### --

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

if debug.getinfo(_G.GetUser).what == "Lua" or debug.getinfo(GetUser).what == "Lua" then
  PrintMessage("".. os.date() .. ": Unauthorized attempt; -> ".. GetUser() .."")
  return
end

local PEWLoaded = false

if _G._Pewalk then
  PEWLoaded = true
else
  PEWLoaded = false
end

local function LoadFHPrediction()

if not PEWLoaded then return end
  if FileExist(LIB_PATH .. "FHPrediction.lua") then
    require("FHPrediction")    
  else
    DownloadFile("http://api.funhouse.me/download-lua.php", LIB_PATH .. "FHPrediction.lua", function() LoadFHPrediction() end)
  end
end

local function LoadPEWPacketLib()

if not PEWLoaded then return end
  if FileExist(LIB_PATH .. "PewPacketLib.lua") then
    require("PewPacketLib")    
  else
    DownloadFile("https://raw.githubusercontent.com/PewPewPew2/BoL/master/PewPacketLib.lua", LIB_PATH .. "PewPacketLib.lua", function() LoadPEWPacketLib() end)
  end
end

local function CheckVersion()

if not PEWLoaded then return end
  r, s, t = TCPGetRequest("s1mplescripts.de", "/Izsha/BoL/LOS.version")
  if r and Version < tonumber(r) then
    AddDownload("s1mplescripts.de","/Izsha/BoL/VLOS2.0/VayneLOS.lua", SCRIPT_PATH .. FileName, 80, {}, {{key = "nicename", value = "*** Turkish Vayne Force ***"}})
  else
    PrintMessage("You are using latest version ".. Version .." .")
  end
end

local function immuneCheck(unit)

if not PEWLoaded then return end
  local buffs = _Pewalk and _Pewalk.GetBuffs(unit) or {}
  return buffs['blackshield'] == nil and buffs['fioraw'] == nil
end

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

-- ###################################################################################################### --
-- #                                                                                                    # --
-- #                                              CALLBACKS                                             # --
-- #                                                                                                    # --
-- #                                                                                                    # --
-- ###################################################################################################### --

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

AddLoadCallback(function()
if not PEWLoaded then return end

DelayAction(function()AutoBuy()end, 3)
LoadFHPrediction()
CheckVersion()
Variables()
VayneMenu()
end)

AddTickCallback(function()
if not PEWLoaded then return end

Target = _Pewalk.GetTarget(950)
Combo = _Pewalk.GetActiveMode().Carry
Harass = _Pewalk.GetActiveMode().Mixed
Clear = _Pewalk.GetActiveMode().LaneClear
LastHit = _Pewalk.GetActiveMode().Farm

CheckLevelChange()

if Menu.popup then
  Menu.popup = false
  PopUp = true
end

if Menu.Draw.stream and not ChatOff then
  dChat()
elseif not Menu.Draw.stream and ChatOff then
  eChat()
end

if CountEnemiesNearUnitReg(myHero, myHero.range+myHero.boundingRadius) >= Menu.ultimate.enemy and CountAlliesNearUnit(myHero, myHero.range+myHero.boundingRadius) >= Menu.ultimate.ally and (math.floor(myHero.health / myHero.maxHealth * 100)) <= Menu.ultimate.hp then
  if Menu.Combo.R and R.ready then
    CastSpell(_R)
  end
end

end)

AddAnimationCallback(function(unit, animation)
if not PEWLoaded then return end

end)

AddUpdateBuffCallback(function (unit, buff, stacks)
if not PEWLoaded then return end

end)

AddRemoveBuffCallback(function (unit, buff)
if not PEWLoaded then return end

end)

AddCreateObjCallback(function (object)
if not PEWLoaded then return end

end)

AddApplyBuffCallback(function (source, unit, buff)
if not PEWLoaded then return end
if not buff or not source or not source.valid or not unit or not unit.valid then return end

if unit and unit.isMe and buff.name == "vaynetumblefade" then
  TimeForReckoning = true
  if CountEnemiesNearUnitReg(myhero, myHero.range+myHero.boundingRadius) >= Menu.ultimate.minblock then
    if not InTurretRange() then
      _G._Pewalk.AllowAttack(false)
    end
  end
else
  TimeForReckoning = false
  _G._Pewalk.AllowAttack(true)
end

end)

AddProcessSpellCallback(function (unit, spell)
if not PEWLoaded then return end
if not unit or not unit.valid or not spell then return end

end)

AddProcessAttackCallback(function (unit, spell)
if not PEWLoaded then return end
if not unit or not unit.valid or not spell then return end

end)

AddDrawCallback(function ()
if not PEWLoaded then return end
if not Menu.Draw.On or myHero.dead then return end

if PopUp then
local w, h1, h2 = (WINDOW_W*0.50), (WINDOW_H*.15), (WINDOW_H*.9)
  DrawLine(w, h1/1.05, w, h2/1.97, w/1.75, ARGB(80, 0, 0, 0)) -- border & aero
  DrawLine(w, h1, w, h2/2, w/1.8, ARGB(255, 22, 12, 0)) -- background
  DrawTextA(tostring("Turkish Vayne Force"), WINDOW_H*.032, (WINDOW_W/2), (WINDOW_H*.18), ARGB(255, 0, 222, 225),"center","center")
  DrawTextA(tostring(""), WINDOW_H*.013, (WINDOW_W/1.79), (WINDOW_H*.199), ARGB(255, 0, 222, 225))
  DrawTextA(tostring("Latest Changelog (" .. Version .. ") ;"), WINDOW_H*.018, (WINDOW_W/2.65), (WINDOW_H*.229), ARGB(255, 0, 222, 225))
  DrawTextA(tostring(" "), WINDOW_H*.018, (WINDOW_W/2.65), (WINDOW_H*.210), ARGB(255, 255, 255, 255))
  DrawTextA(tostring(" "), WINDOW_H*.018, (WINDOW_W/2.65), (WINDOW_H*.225), ARGB(255, 255, 255, 255))
  DrawTextA(tostring("- B"), WINDOW_H*.016, (WINDOW_W/2.70), (WINDOW_H*.255), ARGB(255, 0, 222, 225))
  DrawTextA(tostring("- E"), WINDOW_H*.016, (WINDOW_W/2.70), (WINDOW_H*.280), ARGB(255, 0, 222, 225))
  DrawTextA(tostring("- T"), WINDOW_H*.016, (WINDOW_W/2.70), (WINDOW_H*.305), ARGB(255, 0, 222, 225))
  DrawTextA(tostring("- A"), WINDOW_H*.016, (WINDOW_W/2.70), (WINDOW_H*.330), ARGB(255, 0, 222, 225))
  DrawTextA(tostring(""), WINDOW_H*.016, (WINDOW_W/2.70), (WINDOW_H*.355), ARGB(255, 0, 222, 225))
local w, h1, h2 = (WINDOW_W*0.49), (WINDOW_H*.70), (WINDOW_H*.75)
  DrawLine(w, h1/1.775, w, h2/1.68, w*.11, ARGB(255, 0, 0, 0))
  DrawRectangleButton(WINDOW_W*0.467, WINDOW_H/2.375, WINDOW_W*.047, WINDOW_H*.041, ARGB(255, 255, 0, 0))
  DrawTextA(tostring("OK"), WINDOW_H*.02, (WINDOW_W/2)*.98, (WINDOW_H/2.375), ARGB(255, 0, 222, 225),"center","center")
  DrawTextA(tostring(""), WINDOW_H*.015, (WINDOW_W/2.65), (WINDOW_H*.355), ARGB(255, 0, 222, 225))
end

  local p1 = WorldToScreen(D3DXVECTOR3(myHero.x, myHero.y, myHero.z))

  if OnScreen(p1.x, p1.z) then
  
  if Menu.Draw.Q and Q.ready then
    DrawCircle3D(myHero.pos.x, myHero.pos.y, myHero.pos.z, Q.range+myHero.boundingRadius, 1, ARGB(220, 20, 60, 255), 35)
  end
    
  if Menu.Draw.E and E.ready then
    DrawCircle3D(myHero.pos.x, myHero.pos.y, myHero.pos.z, E.range+myHero.boundingRadius, 1, ARGB(220, 20, 60, 255), 35)
  end
end

  if E.ready and Menu.eafteraakey then
    local myPos = WorldToScreen(D3DXVECTOR3(myHero.x, myHero.y, myHero.z))
    DrawText("Condemn After Next AA is Active!", 31, myPos.x, myPos.y, ARGB(0xFF, 0, 0, 0xFF))
  end

end)

AddNewPathCallback(function (unit, startPos, endPos, isDash, dashSpeed, dashGravity, dashDistance)
if not PEWLoaded then return end

end)

AddMsgCallback(function (Msg, Key)
if not PEWLoaded then return end

  if Msg == WM_LBUTTONDOWN then
    if PopUp then
      PopUp = false
    end
  end

end)

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

-- ###################################################################################################### --
-- #                                                                                                    # --
-- #                                             VAYNE MENU                                             # --
-- #                                                                                                    # --
-- #                                                                                                    # --
-- ###################################################################################################### --

function VayneMenu()

    Menu = scriptConfig("*** Turkish Vayne Force ***", "TVF_MAIN")

    Menu:addSubMenu("Combo", "Combo")
    Menu.Combo:addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
    Menu.Combo:addParam("qforgap", "Q Gapcloser", SCRIPT_PARAM_ONOFF, true)
    Menu.Combo:addParam("qmethod", "Q Method", SCRIPT_PARAM_LIST, 1, {"AA Reset", "3rd AA"})
    Menu.Combo:addParam("Blank", "          ____________________", SCRIPT_PARAM_INFO, "")
    Menu.Combo:addParam("finishim", "Use E For Finisher", SCRIPT_PARAM_ONOFF, true)
    Menu.Combo:addParam("fie", "Disable If X Enemy Around", SCRIPT_PARAM_SLICE, 2, 0, 5, 0)
    Menu.Combo:addParam("fimh", "Disable If My Health < %X", SCRIPT_PARAM_SLICE, 0, 1, 100, 0)
    Menu.Combo:addParam("fieh", "Disable If Enemy Health < %X", SCRIPT_PARAM_SLICE, 0, 1, 100, 0)
    Menu.Combo:addParam("Blank", "          ____________________", SCRIPT_PARAM_INFO, "")
    Menu.Combo:addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)

    Menu:addParam("Blank", "          ____________________", SCRIPT_PARAM_INFO, "")
    Menu:addParam("eafteraakey", "Condemn after Next AA", SCRIPT_PARAM_ONKEYTOGGLE, false, GetKey("E"))

    Menu:addSubMenu("Wall-Condemn", "Condemn")
    Menu.Condemn:addParam("Blank", "          ____________________", SCRIPT_PARAM_INFO, "") 
    Menu.Condemn:addParam("Info", "Wall-Condemn Enabled For", SCRIPT_PARAM_INFO, "")
    for i, enemy in pairs(EnemyHeroes) do
    Menu.Condemn:addParam("enableCondemn"..i, " >> "..enemy.charName, SCRIPT_PARAM_ONOFF, true)
    Menu.Condemn["enableCondemn"..i] = true
    end
    Menu.Condemn:addParam("Blank", "          ____________________", SCRIPT_PARAM_INFO, "")
    Menu.Condemn:addParam("prediction", "Prediction Method", SCRIPT_PARAM_LIST, 1, {"FunHouse Prediction", "Guess(Only use this if FHPrediction is broken"})
    Menu.Condemn:addParam("frequancy", "HitChance", SCRIPT_PARAM_SLICE, 50, 25, 100, 0)

    Menu:addSubMenu("Anti-GapCloser", "extraa")
    for index, data in pairs(GapCloserList) do
        for index2, enemy in pairs(GetEnemyHeroes()) do
            if data["charName"] == enemy.charName then
                Menu.extraa:addSubMenu(enemy.charName.." "..data.Spell.." ", enemy.charName)
                Menu.extraa[enemy.charName]:addParam("Blank", "Save from "..enemy.charName.." "..data.Spell, SCRIPT_PARAM_INFO, "")
                Menu.extraa[enemy.charName]:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
                Menu.extraa[enemy.charName]:addParam("Key", "Press to be Enable", SCRIPT_PARAM_ONKEYDOWN, false, 32)
                Menu.extraa[enemy.charName]:addParam("Always", "Save Always", SCRIPT_PARAM_ONOFF, true)
                Menu.extraa[enemy.charName]:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
                Menu.extraa[enemy.charName]:addParam("hpm", "If My Health > %X", SCRIPT_PARAM_SLICE, 0, 1, 100, 0)
                Menu.extraa[enemy.charName]:addParam("hpe", "If Enemy Health > %X", SCRIPT_PARAM_SLICE, 0, 1, 100, 0)
                Menu.extraa[enemy.charName]:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
                Menu.extraa[enemy.charName]:addParam("hum", "Humanizer", SCRIPT_PARAM_ONOFF, true)
                Menu.extraa[enemy.charName]:addParam("delay", "Using Delay(ms)", SCRIPT_PARAM_SLICE, 0, 0, 400, 0)
                FoundAGapCloser = true
            end
        end
    end
    if not FoundAGapCloser then Menu.extraa:addParam("Blank", "Enemy Gap-Closers Not Found.", SCRIPT_PARAM_INFO, "") end

    Menu:addSubMenu("Interrupt", "extra")
    for index, data in pairs(InterruptList) do
        for index, enemy in pairs(GetEnemyHeroes()) do
            if data["charName"] == enemy.charName then
                Menu.extra:addSubMenu(enemy.charName.." "..data.Spell.." ", enemy.charName)
                Menu.extra[enemy.charName]:addParam("Blank", "Interrupt "..enemy.charName.." "..data.Spell, SCRIPT_PARAM_INFO, "")
                Menu.extra[enemy.charName]:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
                Menu.extra[enemy.charName]:addParam("Key", "Press to Interrupt", SCRIPT_PARAM_ONKEYDOWN, false, 32)
                Menu.extra[enemy.charName]:addParam("Always", "Interrupt Always", SCRIPT_PARAM_ONOFF, true)
                Menu.extra[enemy.charName]:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
                Menu.extra[enemy.charName]:addParam("hpm", "If My Health > %X", SCRIPT_PARAM_SLICE, 0, 1, 100, 0)
                Menu.extra[enemy.charName]:addParam("hpe", "If Enemy Health > %X", SCRIPT_PARAM_SLICE, 0, 1, 100, 0)
                Menu.extra[enemy.charName]:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
                Menu.extra[enemy.charName]:addParam("hum", "Humanizer", SCRIPT_PARAM_ONOFF, true)
                Menu.extra[enemy.charName]:addParam("delay", "Using Delay(ms)", SCRIPT_PARAM_SLICE, 0, 0, 400, 0)
                Menu.extra:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
                Menu.extra:addParam("inteleport", "Interrupt Teleport", SCRIPT_PARAM_ONOFF, true)
                Foundinterrupt = true
            end
        end
    end
    if not Foundinterrupt then 
      Menu.extra:addParam("Blank", "Spell-Enemy to Interrupt Not Found.", SCRIPT_PARAM_INFO, "")
      Menu.extra:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
      Menu.extra:addParam("inteleport", "Interrupt Teleport", SCRIPT_PARAM_ONOFF, true)
    end
    
    Menu:addSubMenu("Extra Ultimate", "ultimate")
    Menu.ultimate:addParam("enemy", "Enemies in range for R", SCRIPT_PARAM_SLICE, 3, 1, 5, 0)
    Menu.ultimate:addParam("ally", "Allies in range for R", SCRIPT_PARAM_SLICE, 2, 0, 5, 0)
    Menu.ultimate:addParam("minblock", "Stay invis. if enemy around", SCRIPT_PARAM_SLICE, 3, 0, 5, 0)
    Menu.ultimate:addParam("qfter", "Use Q After R if in danger", SCRIPT_PARAM_ONOFF, true)
    Menu.ultimate:addParam("Blank", "          ____________________", SCRIPT_PARAM_INFO, "")
    Menu.ultimate:addParam("hp", "Min. own % Health to use", SCRIPT_PARAM_SLICE, 65, 1, 100, 0)
    Menu.ultimate:addParam("Blank", "          ____________________", SCRIPT_PARAM_INFO, "")
    Menu.ultimate:addParam("invis", "Draw invis time", SCRIPT_PARAM_ONOFF, true)

    Menu:addSubMenu("Clear", "Clear")
    Menu.Clear:addSubMenu("LaneClear", "Farm")
    Menu.Clear.Farm:addParam("met", "Use Q To", SCRIPT_PARAM_LIST, 2, {"Everywhere", "Nearest Wall", "Back & Forward Toward"})
    Menu.Clear.Farm:addParam("Blank", "          ____________________", SCRIPT_PARAM_INFO, "")
    Menu.Clear.Farm:addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
    Menu.Clear.Farm:addParam("Q2", "Use if Mana Percent > %X", SCRIPT_PARAM_SLICE, 50, 0, 100, 0)
    Menu.Clear.Farm:addParam("Blank", "          ____________________", SCRIPT_PARAM_INFO, "")
    Menu.Clear.Farm:addParam("Q4", "AA-Reset Q attacking to tower", SCRIPT_PARAM_ONOFF, true)
    Menu.Clear.Farm:addParam("Blank", "          ____________________", SCRIPT_PARAM_INFO, "")
    Menu.Clear.Farm:addParam("Q3", "Q only if 2 minion is killable", SCRIPT_PARAM_ONOFF, true)
    Menu.Clear.Farm:addParam("Q4", "^ Also for LastHit mode", SCRIPT_PARAM_ONOFF, true)
    Menu.Clear.Farm:addParam("Blank", "          ____________________", SCRIPT_PARAM_INFO, "")
    Menu.Clear.Farm:addParam("Q5", "Under Tower Farm(BETA)", SCRIPT_PARAM_ONOFF, true)

    Menu.Clear:addSubMenu("JungleClear", "JFarm")
    Menu.Clear.JFarm:addParam("met", "Use Q To", SCRIPT_PARAM_LIST, 2, {"Everywhere", "Nearest Wall", "Back & Forward Toward"})
    Menu.Clear.JFarm:addParam("Blank", "          ____________________", SCRIPT_PARAM_INFO, "")
    Menu.Clear.JFarm:addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
    Menu.Clear.JFarm:addParam("Q3", "Use Q on only largeJungleMobs", SCRIPT_PARAM_ONOFF, true)
    Menu.Clear.JFarm:addParam("Q2", "Use if Mana Percent > %X", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
    Menu.Clear.JFarm:addParam("Blank", "          ____________________", SCRIPT_PARAM_INFO, "")
    Menu.Clear.JFarm:addParam("E", "Wall-Condemn on Large Junglemob", SCRIPT_PARAM_ONOFF, true)
    Menu.Clear.JFarm:addParam("E2", "Use if Mana Percent > %X", SCRIPT_PARAM_SLICE, 30, 0, 100, 0)
    Menu.Clear.JFarm:addParam("hpm", "Use if My Health > %X", SCRIPT_PARAM_SLICE, 0, 1, 100, 0)
    Menu.Clear.JFarm:addParam("Blank", "          ____________________", SCRIPT_PARAM_INFO, "")
    Menu.Clear.JFarm:addParam("E3", "Disable E if my level > X", SCRIPT_PARAM_SLICE, 9, 4, 16, 0)
    
    Menu:addSubMenu("General Draws", "Draw")
    Menu.Draw:addParam("On", "Enable Draws", SCRIPT_PARAM_ONOFF, true)
    Menu.Draw:addParam("Blank", "          ____________________", SCRIPT_PARAM_INFO, "")
    Menu.Draw:addParam("Q", "Draw Q range", SCRIPT_PARAM_ONOFF, true)
    Menu.Draw:addParam("E", "Draw E range", SCRIPT_PARAM_ONOFF, true)
    Menu.Draw:addParam("Blank", "          ____________________", SCRIPT_PARAM_INFO, "")
    if ignite then
    Menu.Draw:addParam("I", "Draw Ignite range", SCRIPT_PARAM_ONOFF, false)
    Menu.Draw:addParam("Blank", "          ____________________", SCRIPT_PARAM_INFO, "")
    end
    Menu.Draw:addParam("ComboDamage", "Draw Predicted Damage", SCRIPT_PARAM_ONOFF, true)
    Menu.Draw:addParam("Blank", "          ____________________", SCRIPT_PARAM_INFO, "")
    Menu.Draw:addParam("stream", "Enable Streaming Mode", SCRIPT_PARAM_ONKEYTOGGLE, false, 118)

    Menu:addSubMenu("Miscelleneus", "Miscelleneus")
    Menu.Miscelleneus:addParam("buyme", "Auto Buy Starting Items", SCRIPT_PARAM_ONOFF, false)
    Menu.Miscelleneus:addParam("Blank", "          ____________________", SCRIPT_PARAM_INFO, "")
    Menu.Miscelleneus:addParam("UseAutoLevelRest", "Auto-LevelSpells 4-18", SCRIPT_PARAM_ONOFF, true)
    Menu.Miscelleneus:addParam("RestLevel", "Sequance", SCRIPT_PARAM_LIST, 1, {"Q-W-E", "Q-E-W", "W-Q-E", "W-E-Q", "E-Q-W", "E-W-Q"})
    Menu.Miscelleneus:addParam("Blank", "          ____________________", SCRIPT_PARAM_INFO, "")
    Menu.Miscelleneus:addParam("upski", "Skin Changer", SCRIPT_PARAM_ONOFF, false);
    Menu.Miscelleneus:setCallback("upski", function(nV)
        if (nV) then
            SetSkin(myHero, Menu.Miscelleneus.skinID)
        else
            SetSkin(myHero, -1)
        end
    end)
    Menu.Miscelleneus:addParam("skinID", "Skin", SCRIPT_PARAM_LIST, 1, {"Vindicator", "Aristocrat", "Dragonslayer", "Heartseeker", "SKT T1", "Arclight", "Chroma Pack: Green", "Chroma Pack: Red", "Chroma Pack: Silver", "Soulstealer", "Classic"})
    Menu.Miscelleneus:setCallback("skinID", function(nV)
        if (Menu.Miscelleneus.upski) then
            SetSkin(myHero, nV)
        end
    end)
    if (Menu.Miscelleneus.upski) then
        SetSkin(myHero, Menu.Miscelleneus.skinID)
    end
    
  Menu:addParam("Blank", "          ____________________", SCRIPT_PARAM_INFO, "")
  Menu:addParam("Info", "       *** Turkish Scripter Forces ***", SCRIPT_PARAM_INFO, "")
  Menu:addParam("SVersion", "Script Version ", SCRIPT_PARAM_LIST, 1, {"" .. Version})
  Menu:addParam("Blank", "          ____________________", SCRIPT_PARAM_INFO, "")
  Menu:addParam("popup", "Latest Changelog", SCRIPT_PARAM_ONOFF, false)

end

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

-- ###################################################################################################### --
-- #                                                                                                    # --
-- #                                          REQUIRED VARIABLES                                        # --
-- #                                                                                                    # --
-- #                                                                                                    # --
-- ###################################################################################################### --

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

function Variables()

  Foundinterrupt, FoundAGapCloser = false, false
  Q, W, E, R = {}, {}, {}, {}
  Wstacks = {}
  TimeForReckoning = false
  LastLevelCheck = 0
  PopUp = false

  Q = {range = 250}
  E = {range = 950, speed = 2000, delay = 0.25, width = 0}
  
  S6SR = false
  TT = false

  if GetGame().map.index == 15 then
    S6SR = true
  elseif GetGame().map.index == 4 then
    TT = true
  end
  
  if S6SR then
    FocusJungleNames =
    {
    "SRU_Blue1.1.1",
    "SRU_Blue7.1.1",
    "Sru_Crab15.1.1",
    "Sru_Crab16.1.1",
    "SRU_Gromp13.1.1",
    "SRU_Gromp14.1.1",
    "SRU_Krug5.1.2",
    "SRU_Krug11.1.2",
    "SRU_Murkwolf2.1.1",
    "SRU_Murkwolf8.1.1",
    "SRU_Razorbeak3.1.1",
    "SRU_Razorbeak9.1.1",
    "SRU_Red4.1.1",
    "SRU_Red10.1.1"
    }
  JungleMobNames =
    {
    "SRU_BlueMini1.1.2",
    "SRU_BlueMini7.1.2",
    "SRU_BlueMini21.1.3",
    "SRU_BlueMini27.1.3",
    "SRU_KrugMini5.1.1",
    "SRU_KrugMini11.1.1",
    "SRU_MurkwolfMini2.1.2",
    "SRU_MurkwolfMini2.1.3",
    "SRU_MurkwolfMini8.1.2",
    "SRU_MurkwolfMini8.1.3",
    "SRU_RazorbeakMini3.1.2",
    "SRU_RazorbeakMini3.1.3",
    "SRU_RazorbeakMini3.1.4",
    "SRU_RazorbeakMini9.1.2",
    "SRU_RazorbeakMini9.1.3",
    "SRU_RazorbeakMini9.1.4",
    "SRU_RedMini4.1.2",
    "SRU_RedMini4.1.3",
    "SRU_RedMini10.1.2",
    "SRU_RedMini10.1.3"
    }
  elseif TT then
    FocusJungleNames =
    {
    "TT_NWraith1.1.1",
    "TT_NGolem2.1.1",
    "TT_NWolf3.1.1",
    "TT_NWraith4.1.1",
    "TT_NGolem5.1.1",
    "TT_NWolf6.1.1",
    "TT_Spiderboss8.1.1"
    }   
    JungleMobNames =
    {
    "TT_NWraith21.1.2",
    "TT_NWraith21.1.3",
    "TT_NGolem22.1.2",
    "TT_NWolf23.1.2",
    "TT_NWolf23.1.3",
    "TT_NWraith24.1.2",
    "TT_NWraith24.1.3",
    "TT_NGolem25.1.1",
    "TT_NWolf26.1.2",
    "TT_NWolf26.1.3"
    }
  else
    FocusJungleNames =
    {
    }   
    JungleMobNames =
    {
    }
  end

  for _, enemy in pairs(GetEnemyHeroes()) do
    Wstacks[enemy.networkID] = 0
  end

AutoLevelSpellTable = {
        ["SpellOrder"]  = {"QWE", "QEW", "WQE", "WEQ", "EQW", "EWQ"},
        ["QWE"] = {_Q,_W,_E,_Q,_Q,_R,_Q,_W,_Q,_W,_R,_W,_W,_E,_E,_R,_E,_E},
        ["QEW"] = {_Q,_E,_W,_Q,_Q,_R,_Q,_E,_Q,_E,_R,_E,_E,_W,_W,_R,_W,_W},
        ["WQE"] = {_W,_Q,_E,_W,_W,_R,_W,_Q,_W,_Q,_R,_Q,_Q,_E,_E,_R,_E,_E},
        ["WEQ"] = {_W,_E,_Q,_W,_W,_R,_W,_E,_W,_E,_R,_E,_E,_Q,_Q,_R,_Q,_Q},
        ["EQW"] = {_E,_Q,_W,_E,_E,_R,_E,_Q,_E,_Q,_R,_Q,_Q,_W,_W,_R,_W,_W},
        ["EWQ"] = {_E,_W,_Q,_E,_E,_R,_E,_W,_E,_W,_R,_W,_W,_Q,_Q,_R,_Q,_Q}
    }

InterruptList = {
        ["KatarinaR"]         = {true, charName = "Katarina",  Spell = "R"},
        ["GalioIdolOfDurand"]     = {true, charName = "Galio",   Spell = "R"},
        ["Crowstorm"]         = {true, charName = "FiddleSticks", Spell = "R"},
        ["DrainChannel"]           = {true, charName = "FiddleSticks", Spell = "W"},
        ["AbsoluteZero"]        = {true, charName = "Nunu",    Spell = "R"},
        ["ShenStandUnited"]       = {true, charName = "Shen",    Spell = "R"},
        ["UrgotSwap2"]          = {true, charName = "Urgot",   Spell = "R"},
        ["AlZaharNetherGrasp"]      = {true, charName = "Malzahar",  Spell = "R"},
        ["FallenOne"]         = {true, charName = "Karthus",   Spell = "R"},
        ["Pantheon_GrandSkyfall_Jump"]  = {true, charName = "Pantheon",  Spell = "R"},
        ["VarusQ"]            = {true, charName = "Varus",   Spell = "Q"},
        ["CaitlynAceintheHole"]     = {true, charName = "Caitlyn",   Spell = "R"},
        ["MissFortuneBulletTime"]   = {true, charName = "MissFortune", Spell = "R"},
        ["InfiniteDuress"]        = {true, charName = "Warwick",   Spell = "R"},
        ["LucianR"]           = {true, charName = "Lucian",    Spell = "R"},
        ["VelkozR"]           = {true, charName = "Velkoz",    Spell = "R"},
        ["ReapTheWhirlwind"]           = {true, charName = "Janna",    Spell = "R"}, --
        ["MasterYi"]           = {true, charName = "MasterYi",    Spell = "W"} --
    }

GapCloserList = {
        ["AkaliShadowDance"]    = {true, charName = "Akali",    range = 800,   projSpeed = 2200, Spell = "R"},
        ["Headbutt"]          = {true, charName = "Alistar",    range = 650,   projSpeed = 2200, Spell = "W"},
        ["DianaTeleport"]         = {true, charName = "Diana",    range = 825,   projSpeed = 2000, Spell = "R"},
        ["IreliaGatotsu"]         = {true, charName = "Irelia",    range = 650,   projSpeed = 2200, Spell = "Q"},
        ["JaxLeapStrike"]           = {true, charName = "Jax",    range = 700,   projSpeed = 2000, Spell = "Q"},
        ["JayceToTheSkies"]         = {true, charName = "Jayce",    range = 600,   projSpeed = 2000, Spell = "Q"},
        ["MaokaiUnstableGrowth"]    = {true, charName = "Maokai",    range = 525,   projSpeed = 2000, Spell = "W"},
        ["MonkeyKingNimbus"]      = {true, charName = "MonkeyKing",    range = 650,   projSpeed = 2200, Spell = "E"},
        ["Pantheon_LeapBash"]     = {true, charName = "Pantheon",    range = 600,   projSpeed = 2000, Spell = "W"},
        ["PoppyHeroicCharge"]       = {true, charName = "Poppy",    range = 525,   projSpeed = 2000, Spell = "E"},
        ["QuinnE"]            = {true, charName = "Quinn",    range = 375,   projSpeed = 1800, Spell = "E"},
        ["XenZhaoSweep"]        = {true, charName = "XinZhao",    range = 650,   projSpeed = 2000, Spell = "E"},
        ["blindmonkqtwo"]       = {true, charName = "LeeSin",    range = 600,   projSpeed = 1800, Spell = "Q"},
        ["FizzPiercingStrike"]      = {true, charName = "Fizz",    range = 550,   projSpeed = 2000, Spell = "Q"},
        ["RengarLeap"]          = {true, charName = "Rengar",    range = 525,   projSpeed = 2000, Spell = "AA"},
        ["AatroxQ"]         = {true, charName = "Aatrox",    range = 1000,   projSpeed = 1200, Spell = "Q"},
        ["GragasE"]         = {true, charName = "Gragas",    range = 600,    projSpeed = 2000, Spell = "E"},
        ["GravesMove"]        = {true, charName = "Graves",    range = 425,    projSpeed = 2000, Spell = "E"},
        ["HecarimUlt"]        = {true, charName = "Hecarim",   range = 1000,   projSpeed = 1200, Spell = "R"},
        ["JarvanIVDragonStrike"]  = {true, charName = "JarvanIV",  range = 770,    projSpeed = 2000, Spell = "Q"},
        ["JarvanIVCataclysm"]   = {true, charName = "JarvanIV",  range = 650,    projSpeed = 2000, Spell = "R"},
        ["KhazixE"]         = {true, charName = "Khazix",    range = 900,    projSpeed = 2000, Spell = "E"},
        ["khazixelong"]       = {true, charName = "Khazix",    range = 900,    projSpeed = 2000, Spell = "E"},
        ["LeblancSlide"]      = {true, charName = "Leblanc",   range = 600,    projSpeed = 2000, Spell = "W"},
        ["LeblancSlideM"]     = {true, charName = "Leblanc",   range = 600,    projSpeed = 2000, Spell = "WMimic"},
        ["LeonaZenithBlade"]    = {true, charName = "Leona",     range = 900,    projSpeed = 2000, Spell = "E"},
        ["UFSlash"]         = {true, charName = "Malphite",  range = 1000,   projSpeed = 1500, Spell = "R"},
        ["RenektonSliceAndDice"]  = {true, charName = "Renekton",  range = 450,    projSpeed = 2000, Spell = "E"},
        ["SejuaniArcticAssault"]  = {true, charName = "Sejuani",   range = 650,    projSpeed = 2000, Spell = "Q"},
        ["ShenShadowDash"]      = {true, charName = "Shen",    range = 575,    projSpeed = 2000, Spell = "E"},
        ["RocketJump"]        = {true, charName = "Tristana",  range = 900,    projSpeed = 2000, Spell = "W"},
        ["slashCast"]       = {true, charName = "Tryndamere",  range = 650,    projSpeed = 1450, Spell = "E"},
        ["YasuoSweepingBlade"]       = {true, charName = "Yasuo",  range = 475,    projSpeed = 1000, Spell = "E"}, --
        ["ShyvanaDragonsDescent"]       = {true, charName = "Shyvana",  range = 1000,    projSpeed = 2000, Spell = "R"}, --
        ["RivenValor"]       = {true, charName = "Riven",  range = 150,    projSpeed = 2000, Spell = "E"}, -- 
        ["LucianRelentlessPursuit"]       = {true, charName = "Lucian",  range = 425,    projSpeed = 2000, Spell = "E"}, -- 
        ["FioraLunge"]       = {true, charName = "Fiora",  range = 600,    projSpeed = 2000, Spell = "Q"}, -- 
        ["DariusNoxianGuillotine"]       = {true, charName = "Darius",  range = 460,    projSpeed = math.huge, Spell = "R"}, -- 
        ["CorkiValkyrie"]       = {true, charName = "Corki",  range = 800,    projSpeed = 650, Spell = "W"}, -- 
        ["BandageToss"]       = {true, charName = "Amumu",  range = 1100,    projSpeed = 1800, Spell = "Q"}, --
        ["AhriTumble"]       = {true, charName = "Ahri",  range = 450,    projSpeed = 2200, Spell = "R"} --
    }

end

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

-- ###################################################################################################### --
-- #                                                                                                    # --
-- #                                       MISC FUNCTION MANAGER                                        # --
-- #                                                                                                    # --
-- #                                                                                                    # --
-- ###################################################################################################### --

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

function PrintMessage(arg1, arg2)

    local a, b = "", ""
    if arg2 ~= nil then
        a = arg1
        b = arg2
    else
        a = ScriptName
        b = arg1
    end
    print("<font color=\"#298A46\"><b>" .. a .. ":</b></font> <font color=\"#FFFFFF\">" .. b .. "</font>") 
end

function IsUnderTower()

  for _, v in pairs(GetTurrets()) do
    if v and v.team ~= myHero.team then
      if GetDistanceSqr(v, myHero) < v.range*v.range then
        return true
      else
        return false
      end
    end
  end
end

function CountEnemiesNearUnitReg(unit, range)

  local count = 0
  for i, enemy in pairs(GetEnemyHeroes()) do
    if enemy and enemy.valid and not enemy.dead and enemy.visible then
      if  GetDistanceSqr(unit, enemy) < range * range  then 
        count = count + 1 
      end
    end
  end
  return count
end

function CountAlliesNearUnit(unit, range)

  local count = 0
  for i, ally in pairs(GetAllyHeroes()) do
    if GetDistanceSqr(ally, unit) <= range * range and not ally.dead then count = count + 1 end
  end
  return count
end

function isFleeingFromMe(target, range)

  local pos = FHPrediction.PredictPosition(Target, 0.26)
  if pos and GetDistanceSqr(pos) > range*range then
    return true
  end
  return false
end

function amIFleeing(target, range)

  local pos = FHPrediction.PredictPosition(myHero, 0.26)
  if pos and GetDistanceSqr(pos, target) > range*range then
    return true
  end
  return false
end

function AutoBuy()

  if GetGameTimer() < 60 then
    if Menu.Miscelleneus.buyme then
      BuyItem(1055)
      BuyItem(2003)
      BuyItem(3340)
    end
  end
end

function CheckLevelChange()

  if LastLevelCheck + 250 < GetTickCount() and myHero.level < 19 then

    LastLevelCheck = GetTickCount()
      if myHero.level ~= LastHeroLevel then
        DelayAction(function() LevelUpSpell() end, 0.35)
        LastHeroLevel = myHero.level
      end
  end
end

function LevelUpSpell()

  if myHero.level < 4 then 
    return
  end

    if Menu.Miscelleneus.UseAutoLevelRest then
      LevelSpell(AutoLevelSpellTable[AutoLevelSpellTable["SpellOrder"][Menu.Miscelleneus.RestLevel]][myHero.level])
    end
end

function DrawRectangleButton(x, y, w, h, color)

local floor = math.floor
local points = {}
points[1] = D3DXVECTOR2(floor(x), floor(y))
points[2] = D3DXVECTOR2(floor(x + w), floor(y))
local points2 = {}
points2[1] = D3DXVECTOR2(floor(x), floor(y - h/2))
points2[2] = D3DXVECTOR2(floor(x + w), floor(y - h/2))
points2[3] = D3DXVECTOR2(floor(x + w), floor(y + h/2))
points2[4] = D3DXVECTOR2(floor(x), floor(y + h/2))
local t = GetCursorPos()
polygon = Polygon(Point(points2[1].x, points2[1].y), Point(points2[2].x, points2[2].y), Point(points2[3].x, points2[3].y), Point(points2[4].x, points2[4].y))
  if polygon:contains(Point(t.x, t.y)) then
    DrawLines2(points, floor(h), color)
  else
    DrawLines2(points, floor(h), ARGB(255, 49, 112, 131))
  end
end

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

-- ###################################################################################################### --
-- #                                                                                                    # --
-- #                                          DOWNLOAD MANAGER                                          # --
-- #                                                                                                    # --
-- #                                                                                                    # --
-- ###################################################################################################### --

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

local function class(base, init)

    local c = {}
    if not init and type(base) == 'function' then
        init = base
        base = nil
    elseif type(base) == 'table' then
        for i,v in pairs(base) do
            c[i] = v
        end
        c._base = base
    end
    c.__index = c

    local mt = {}
    mt.__call = function(class_tbl, ...)
        local obj = {}
        setmetatable(obj,c)
        if init then
            init(obj,...)
        else
            if base and base.init then
                base.init(obj, ...)
            end
        end
        return obj
    end
    c.init = init
    c.is_a = function(self, klass)
        local m = getmetatable(self)
        while m do
            if m == klass then return true end
            m = m._base
        end
        return false
    end
    setmetatable(c, mt)
    return c
end

local downloads = {}
function AddDownload(server, server_path, localpath, port, data, options)
  local function sprite_file_exists()
    local file = io.open(SPRITE_PATH.."\\S1mple\\Downloader\\Sprite.png")
    if file then file:close() return true else return false end
  end
  if sprite_file_exists() then
    local dlsize = #downloads
    local pos_y = 20+dlsize*30
    downloads[#downloads+1] = FancyDownload(server, server_path, localpath, port, data, 20, pos_y, false, options, dlsize)
  else
    --Main Download
    local dlsize = #downloads
    local pos_y = 20+dlsize*30
    downloads[#downloads+1] = FancyDownload(server, server_path, localpath, port, data, 20, pos_y, true, options, dlsize)

    --Download sprite for next time
    local dlsize = #downloads
    local pos_y = 20+dlsize*30
    downloads[#downloads+1] = FancyDownload("s1mplescripts.de", "/S1mple/Scripts/BolStudio/FancyDownloader/Sprite.png", SPRITE_PATH.."\\S1mple\\Downloader\\Sprite.png", 80, {}, 20, pos_y, true)
  end
end

FancyDownload = class(function(fd,server, server_path, localpath, port, data, pos_x, pos_y, ncp, options, i)
    assert(type(server) == "string" or type(server_path) == "string", "FancyDownload: wrong argument types (<string><string> expected for server, server_path)")
    if not data then data = {} end
    if not port then port = 80 end
    if not options then options = {} end
    if not ncp then ncp = false end
    fd.server = server
    fd.server_path = server_path
    fd.localpath = localpath
    fd.port = port
    fd.data = data
    fd.progress = 0
    fd.ncp = ncp
    fd.pos_x = pos_x
    fd.pos_y = pos_y
    fd.file_size = math.huge
    fd.lua_socket = require("socket")
    fd.download_tcp = nil
    fd.response = ""
    fd.status = ""
    fd.cutheader = false
    fd.bytesperchunk = 8096
    fd.nicename = ""
    fd.i = i
    fd.c_time = 0
    fd.passed_time = 0
    fd.after_download_text = nil

    fd:parseoptions(options)
    fd:ncp_special_checks()
    fd:LoadSprite()
    fd:StartDownload()
    AddDrawCallback(function ()
      fd:DrawProgress()
    end)
    AddUnloadCallback(function ()
      fd:Cleanup()
    end)
end)

function FancyDownload:ncp_special_checks()
  CreateDirectory(SPRITE_PATH.."\\S1mple")
  CreateDirectory(SPRITE_PATH.."\\S1mple\\Downloader")
end

function FancyDownload:parseoptions(options)
  for _,v in pairs(options) do
    if v.key == "bps" then
      self.bytesperchunk = v.value
    elseif v.key == "nicename" then
      self.nicename = v.value
    elseif v.key == "afterdltext" then
      self.after_download_text = v.value
    end
  end
end

function FancyDownload:StartDownload()
  self:GetFileSize()
  self.download_tcp = self.lua_socket.connect(self.server,self.port)
  local requeststring = "GET "..self.server_path
  local first = true
  for i,v in pairs(self.data)do
    requeststring = requeststring..(first and "?" or "&")..i.."="..v
    first = false
  end
  requeststring = requeststring.. " HTTP/1.0\r\nHost: "..self.server.."\r\n\r\n"
  self.download_tcp:send(requeststring)
  AddTickCallback(function ()
    self:Tick()
  end)
end

function FancyDownload:Tick()
  if self.status == "timeout" or self.status == "closed" then
    self:WriteToFile(self.response)
    self.status = "end"
    self:Cleanup()
  elseif self.status ~= "end" then
    s,status, partial = self.download_tcp:receive(self.bytesperchunk)
    self.status = status
    self.response = self.response..(s or partial)

    local headerend = string.find(self.response, "\r\n\r\n")
    if (headerend and not self.cutheader) then
      self.response = self.response:sub(headerend+4)
      self.cutheader = true
    end
    self.progress = self.response:len()/self.file_size*100
    if(math.floor(os.clock()) > self.c_time)then
      self.passed_time = self.passed_time + 1
    end
  end
end

function FancyDownload:GetFileSize()
  local connection_tcp = self.lua_socket.connect(self.server,self.port)
  local requeststring = "HEAD "..self.server_path
  local first = true
  for i,v in pairs(self.data)do
    requeststring = requeststring..(first and "?" or "&")..i.."="..v
    first = false
  end
  requeststring = requeststring.. " HTTP/1.0\r\nHost: "..self.server.."\r\n\r\n"
  connection_tcp:send(requeststring)
  local response = ""
  local status
  while true do
    s,status, partial = connection_tcp:receive('*a')
    response = response..(s or partial)
    if(status == "closed" or status == "timeout")then
      break
    end
  end
  local snip_1 = string.find(response, "Length:")+8
  response = response:sub(snip_1)
  local snip_2 = string.find(response, "\n")-2
  response = response:sub(0,snip_2)
  self.file_size = tonumber(response)
end

function FancyDownload:DrawProgress()
  if self.ncp then return end

  --Background
  self.sprite:DrawEx(Rect(0,10,417,25), D3DXVECTOR3(0,0,0), D3DXVECTOR3(self.pos_x,self.pos_y,0), 255)
  --Foreground
  self.sprite:DrawEx(Rect(0,0,self.progress*4.17,10), D3DXVECTOR3(0,0,0), D3DXVECTOR3(self.pos_x+3,self.pos_y+2,0), 255)
  if self.status == "end" then
    if self.after_download_text then
      DrawTextA(self.after_download_text,12, self.pos_x+3,self.pos_y-12)
    else
      DrawTextA((self.nicename or self.localpath).. " downloaded. Please reload the Script",12, self.pos_x+3,self.pos_y-12)
    end
  else
    DrawTextA((self.nicename or self.localpath).." Speed: "..math.floor(self.response:len()/self.passed_time).." bytes/sec",12, self.pos_x+3,self.pos_y-12)
  end
end

function FancyDownload:LoadSprite()
  if self.ncp then return end
  self.sprite = GetSprite("S1mple\\Downloader\\Sprite.png")
end

function FancyDownload:Cleanup()
  if not self.ncp and self.sprite then
    self.sprite:Release()
  end
end

function FancyDownload:WriteToFile(text)
  local file = io.open(self.localpath, "wb")
  file:write(tostring(text))
  file:close()
end

local function TCPGetRequest(server, path, data, port)
  local start_t = os.clock()
  local port = port or 80
  local data = data or {}
  local lua_socket = require("socket")
  local connection_tcp = lua_socket.connect(server,port)
  local requeststring = "GET "..path
  local first = true
  for i,v in pairs(data)do
    requeststring = requeststring..(first and "?" or "&")..i.."="..v
    first = false
  end
  requeststring = requeststring.. " HTTP/1.0\r\nHost: "..server.."\r\n\r\n"
  connection_tcp:send(requeststring)
  local response = ""
  local status
  while true do
    s,status, partial = connection_tcp:receive('*a')
    response = response..(s or partial)
    if(status == "closed" or status == "timeout")then
      break
    end
  end
  local end_t = os.clock()
  local start_content = response:find("\r\n\r\n")+4
  response = response:sub(start_content)
  return response, status, end_t-start_t
end

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------