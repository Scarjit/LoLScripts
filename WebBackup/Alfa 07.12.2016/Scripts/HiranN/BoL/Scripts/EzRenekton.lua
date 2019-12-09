--[[
Ez Scripts - Renekton]]

if myHero.charName ~= "Renekton" then return end


local Version = 0.3
local scriptmsg = "<font color=\"#06CD51\"><b>Renekton</b></font>"
local QRange, ERange = 260, 450
local RageRdy = false
local IsAfterAA = false
-- Bol Tools Tracker --
assert(load(Base64Decode("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"), nil, "bt", _ENV))()
TrackerLoad("IpNO2EoMIEpGTS6o")
-- Bol Tools Tracker --

function CheckUpdates()
  local host = "www.scarjit.de"
  local ServerVersionDATA = GetWebResult(host, "/HiranN/BoL/Versions/EzRenekton.version")  
  local ServerVersion = tonumber(ServerVersionDATA)
  if ServerVersionDATA then
  if ServerVersion then
  if ServerVersion > tonumber(Version) then
  print(scriptmsg.."<font color=\"#C2FDF3\"><b> Updating, don't press F9.</b></font>")
  DL = Download()
  file = "/HiranN/BoL/Scripts/EzRenekton.lua"
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

function LoadTableOrbs()
    OrbWalkers = {}
    LoadedOrb = nil
    if _G.Reborn_Loaded or _G.Reborn_Initialised or _G.AutoCarry ~= nil then
        table.insert(OrbWalkers, "SAC")
    end
    if _G.MMA_IsLoaded then
        table.insert(OrbWalkers, "MMA")
    end
    if _G._Pewalk then
        table.insert(OrbWalkers, "Pewalk")
    end
    if FileExist(LIB_PATH .. "/Nebelwolfi's Orb Walker.lua") then
        table.insert(OrbWalkers, "NOW")
    end
    if FileExist(LIB_PATH .. "/Big Fat Orbwalker.lua") then
        table.insert(OrbWalkers, "Big Fat Walk")
    end
    if FileExist(LIB_PATH .. "/SOW.lua") then
        table.insert(OrbWalkers, "SOW")
    end
    if FileExist(LIB_PATH .. "/SxOrbWalk.lua") then
        table.insert(OrbWalkers, "SxOrbWalk")
    end
    if FileExist(LIB_PATH .. "/S1mpleOrbWalker.lua") then
        table.insert(OrbWalkers, "S1mpleOrbWalker")
    end
    if #OrbWalkers > 0 then
        Menu:addSubMenu("Orbwalkers", "Orbwalkers")
        Menu:addSubMenu("Keys", "Keys")
        Menu.Orbwalkers:addParam("Orbwalker", "OrbWalker", SCRIPT_PARAM_LIST, 1, OrbWalkers)
        Menu.Keys:addParam("info", "Detecting keys from :", SCRIPT_PARAM_INFO, OrbWalkers[Menu.Orbwalkers.Orbwalker])
        Menu.Keys:addParam("fleeKey", "Key to Flee", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("T"))
        --Menu.Keys:addParam("LaneClear", "--> Key to toggle LaneClear", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("K"))
        --Menu.Keys:addParam("Steal", "--> Key to toggle Jungle Steal", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("G"))
        Menu.Keys.Harass = false
        Menu.Keys.LaneClear = false
        Menu.Keys.Steal = false
        local OrbAlr = false
            Menu.Orbwalkers:setCallback("Orbwalker", function(value) 
            if OrbAlr then return end
            OrbAlr = true
            Menu.Orbwalkers:addParam("info", "Press F9 2x to load your selected Orbwalker.", SCRIPT_PARAM_INFO, "")
            SendMsg("Press F9 2x to load your selected Orbwalker")
        end)
    end
end

function LoadOrb()
    if OrbWalkers[Menu.Orbwalkers.Orbwalker] == "SAC" then
        LoadedOrb = "Sac"
        TIMETOSACLOAD = false
        DelayAction(function() TIMETOSACLOAD = true end,15)
    elseif OrbWalkers[Menu.Orbwalkers.Orbwalker] == "MMA" then
        LoadedOrb = "Mma"
    elseif OrbWalkers[Menu.Orbwalkers.Orbwalker] == "Pewalk" then
        LoadedOrb = "Pewalk"
    elseif OrbWalkers[Menu.Orbwalkers.Orbwalker] == "NOW" then
        LoadedOrb = "Now"
        require "Nebelwolfi's Orb Walker"
        _G.NOWi = NebelwolfisOrbWalkerClass()
        --Menu.Orbwalkers:addSubMenu("NOW", "NOW")
        --_G.NebelwolfisOrbWalkerClass(Menu.Orbwalkers.NOW) 
    elseif OrbWalkers[Menu.Orbwalkers.Orbwalker] == "Big Fat Walk" then
        LoadedOrb = "Big"
        require "Big Fat Orbwalker"
    elseif OrbWalkers[Menu.Orbwalkers.Orbwalker] == "SOW" then
        LoadedOrb = "Sow"
        require "SOW"
        Menu.Orbwalkers:addSubMenu("SOW", "SOW")
        _G.SOWi = SOW(_G.VP)
        SOW:LoadToMenu(Menu.Orbwalkers.SOW)
    elseif OrbWalkers[Menu.Orbwalkers.Orbwalker] == "SxOrbWalk" then
        LoadedOrb = "SxOrbWalk"
        require "SxOrbWalk"
        Menu.Orbwalkers:addSubMenu("SxOrbWalk", "SxOrbWalk")
        SxOrb:LoadToMenu(Menu.Orbwalkers.SxOrbWalk)
    elseif OrbWalkers[Menu.Orbwalkers.Orbwalker] == "S1mpleOrbWalker" then 
        require "S1mpleOrbWalker"
        DelayAction(function()
            _G.S1mpleOrbWalker:AddToMenu(Menu.Orbwalkers)
        end, 1)
    end
end

function Keys()
    if LoadedOrb == "Sac" and TIMETOSACLOAD then
    if _G.AutoCarry.Keys.AutoCarry then return "Combo" end
    if _G.AutoCarry.Keys.MixedMode then return "Harass" end
    if _G.AutoCarry.Keys.LaneClear then return "Laneclear" end
    if _G.AutoCarry.Keys.LastHit then return "Lasthit" end
    elseif LoadedOrb == "Mma" then
    if _G.MMA_IsOrbwalking() then return "Combo" end
    if _G.MMA_IsDualCarrying() then return "Harass" end
    if _G.MMA_IsLaneClearing() then return "Laneclear" end
    if _G.MMA_IsLastHitting() then return "Lasthit" end
    elseif LoadedOrb == "Pewalk" then
    if _G._Pewalk.GetActiveMode().Carry then return "Combo" end
    if _G._Pewalk.GetActiveMode().Mixed then return "Harass" end
    if _G._Pewalk.GetActiveMode().LaneClear then return "Laneclear" end
    if _G._Pewalk.GetActiveMode().Farm then return "Lasthit" end
    elseif LoadedOrb == "Now" then
    if _G.NOWi.Config.k.Combo then return "Combo" end
    if _G.NOWi.Config.k.Harass then return "Harass" end
    if _G.NOWi.Config.k.LaneClear then return "Laneclear" end
    if _G.NOWi.Config.k.LastHit then return "Lasthit" end
    elseif LoadedOrb == "Big" then
    if _G["BigFatOrb_Mode"] == "Combo" then return "Combo" end
    if _G["BigFatOrb_Mode"] == "Harass" then return "Harass" end
    if _G["BigFatOrb_Mode"] == "LaneClear" then return "Laneclear" end
    if _G["BigFatOrb_Mode"] == "LastHit" then return "Lasthit" end
    elseif LoadedOrb == "Sow" then
    if _G.SOWi.Menu.Mode0 then return "Combo" end
    if _G.SOWi.Menu.Mode1 then return "Harass" end
    if _G.SOWi.Menu.Mode2 then return "Laneclear" end
    if _G.SOWi.Menu.Mode3 then return "Lasthit" end
    elseif LoadedOrb == "SxOrbWalk" then
    if _G.SxOrb.isFight then return "Combo" end
    if _G.SxOrb.isHarass then return "Harass" end
    if _G.SxOrb.isLaneClear then return "Laneclear" end
    if _G.SxOrb.isLastHit then return "Lasthit" end
    elseif LoadedOrb == "S1mpleOrbWalker" then
    if _G.S1mpleOrbWalker.aamode == "sbtw" then return "Combo" end
    if _G.S1mpleOrbWalker.aamode == "harass" then return "Harass" end
    if _G.S1mpleOrbWalker.aamode == "laneclear" then return "Laneclear" end
    if _G.S1mpleOrbWalker.aamode == "lasthit"then return "Lasthit" end
    end
end

function ResetAAs()
  if LoadedOrb == "Sac" and TIMETOSACLOAD then
  _G.AutoCarry.Orbwalker:ResetAttackTimer()
  elseif LoadedOrb == "Mma" then
  _G.MMA_ResetAutoAttack()
  elseif LoadedOrb == "Pewalk" then
  
  elseif LoadedOrb == "Now" then
  _G.NebelwolfisOrbWalker:ResetAA()
  elseif LoadedOrb == "Big" then
  
  elseif LoadedOrb == "Sow" then
  _G.SOWi:resetAA()
  elseif LoadedOrb == "SxOrbWalk" then
  _G.SxOrb:ResetAA()
  end
end

function OnLoad ()
    ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, 450, DAMAGE_PHYSICAL)
   -- tsQ = TargetSelector(TARGET_LESS_CAST_PRIORITY, 285, DAMAGE_PHYSICAL)   
    --tsW = TargetSelector(TARGET_LESS_CAST_PRIORITY, 280, DAMAGE_PHYSICAL)   
    --tsE = TargetSelector(TARGET_LESS_CAST_PRIORITY, 325, DAMAGE_PHYSICAL)   
    --tsR = TargetSelector(TARGET_LESS_CAST_PRIORITY, 900, DAMAGE_PHYSICAL)
    enemyMinions = minionManager(MINION_ENEMY, 285, myHero, MINION_SORT_HEALTH_ASC)
    jungleMinions = minionManager(MINION_JUNGLE, 285, myHero, MINION_SORT_MAXHEALTH_DEC)
    Menu()
    if VIP_USER then SkinLoad() end
    LoadTableOrbs()
    LoadOrb()
    --CheckUpdates()
end

function OnTick ()
    Checks()
    if Menu.Keys.fleeKey then Flee() end
    if Keys() == "Combo" then Combo(Target) end
    if Keys() == "Harass" then Harass(Target) end
    if Keys() == "Laneclear" then Clear() end
    if Menu.r.useAutoR then AutoR() end
    --print(myHero:GetSpellData(_E).name)
end

function Menu ()
    Menu = scriptConfig("Ez Scripts - Renekton", "ez renek")
    Menu:addSubMenu("Combo", "c")
        Menu.c:addParam("comboMode", "Set Combo Mode", SCRIPT_PARAM_LIST, 1, {"E W Q E"--[["W E Q E"]]})
        Menu.c:addParam("useQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
        Menu.c:addParam("useW", "Use W", SCRIPT_PARAM_ONOFF, true)
        Menu.c:addParam("useE", "Use E", SCRIPT_PARAM_ONOFF, true)
        Menu.c:addParam("useEAs", "Use E to", SCRIPT_PARAM_LIST, 1, {"Target Position", "Mouse Position"})
        --Menu.c:addParam("useEFirst", "Only use First E", SCRIPT_PARAM_ONOFF, false)
        Menu.c:addParam("useRAs", "Use R As", SCRIPT_PARAM_LIST, 1, {"For DMG", "If Low Life"})

    Menu:addSubMenu("Harass", "h")
        Menu.h:addParam("useQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
        Menu.h:addParam("useW", "Use W", SCRIPT_PARAM_ONOFF, true)
        Menu.h:addParam("useE", "Use E", SCRIPT_PARAM_ONOFF, true)
        Menu.h:addParam("x2", "Harass Key is bindet to your Orbwalker Hotkeys", SCRIPT_PARAM_INFO, " ")

    Menu:addSubMenu("Lane Clear", "l")
        Menu.l:addParam("useQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
        Menu.l:addParam("useW", "Use W", SCRIPT_PARAM_ONOFF, true)
        Menu.l:addParam("useE", "Use E", SCRIPT_PARAM_ONOFF, true)
        Menu.l:addParam("useItems", "Use Items", SCRIPT_PARAM_ONOFF, true)

    Menu:addSubMenu("Auto R","r")
        Menu.r:addParam("useAutoR", "Use Auto R?", SCRIPT_PARAM_ONOFF, true)
        Menu.r:addParam ("autoR", "Auto R at % life", SCRIPT_PARAM_SLICE, 20, 0, 100)

    if VIP_USER then
    Menu:addSubMenu("Skin Changer", "skin")
    end

    --[[Menu:addSubMenu("Drawing", "draw")
        Menu.draw:addParam ("qd", "Draw Q Range", SCRIPT_PARAM_ONOFF, true)
        Menu.draw:addParam ("ed", "Draw E Range", SCRIPT_PARAM_ONOFF, true)
        Menu.draw:addParam ("aad", "Draw AA Range", SCRIPT_PARAM_ONOFF, true)

    Menu:addSubMenu("|->Target Selector", "TargetSelector")
        Menu.TargetSelector:addParam ("drawtext", "Draw Target Select Text", SCRIPT_PARAM_ONOFF, true)
        Menu.TargetSelector:addParam ("hitbox", "Target-Selector", SCRIPT_PARAM_LIST, 1, {"Hitbox", "3D Circle"})]]

    Menu:addParam("kl1", "Author:", SCRIPT_PARAM_INFO, "timo62")
    Menu:addParam("kl2", "Your Region:", SCRIPT_PARAM_INFO, GetGameRegion())
    Menu:addParam("kl3", "Your BoL ID:", SCRIPT_PARAM_INFO, GetUser())

    ts.name = "Renekton"
    Menu:addTS(ts)
end

function OnAnimation(unit, animation)
    if unit and animation and unit.isMe and animation:lower():find("attack") then
      DelayAction(function() IsAfterAA = true end, 0.15)
    end
end

function OnProcessAttack(unit, spell)
   if unit and spell and unit.isMe and spell.name:lower():find("attack") then
      IsAfterAA = false
   end
end

function AutoR ()
    if myHero.health <= (myHero.maxHealth*Menu.r.autoR/100) and Rready then 
        CastSpell(_R)
    end
end

function Combo(enemy)
    --local gd = GetDistance(enemy)
    if ValidTarget(enemy) then 
        if Menu.c.useQ and GetDistance(enemy) <= 285 then
            CastSpell(_Q)
        end 
        if Menu.c.useW and GetDistance(enemy) <= 500 then 
            CastSpell(_W)
        end

        --[[if Menu.c.useEFirst then 
            if Menu.c.useEAs == 1 then
                if myHero:GetSpellData(_E).name ~= "RenektonDice" and Menu.c.useE and GetDistance(enemy) <= 450 then
                    ResetAAs()
                    CastSpell(_E, enemy.x, enemy.z)
                end
            end
            if Menu.c.useEAs == 2 then
                if myHero:GetSpellData(_E).name ~= "RenektonDice" and Menu.c.useE and GetDistance(enemy) <= 450 then
                    ResetAAs()
                    CastSpell(_E, mousePos.x, mousePos.z)
                end
            end
        end]]


        --if not Menu.c.useEFirst then
            if Menu.c.useEAs == 1 then
                if myHero:GetSpellData(_E).name ~= "RenektonDice" and Menu.c.useE and GetDistance(enemy) <= 450 then
                    ResetAAs()
                    CastSpell(_E, enemy.x, enemy.z)
                elseif myHero:GetSpellData(_E).name == "RenektonDice" and Menu.c.useE and GetDistance(enemy) <= 450 and IsAfterAA then
                    CastSpell(_E, enemy.x, enemy.z)      
                end
            end

            if Menu.c.useEAs == 2 then
                if myHero:GetSpellData(_E).name ~= "RenektonDice" and Menu.c.useE and GetDistance(enemy) <= 450 then
                    ResetAAs()
                    CastSpell(_E, mousePos.x, mousePos.z)
                elseif myHero:GetSpellData(_E).name == "RenektonDice" and Menu.c.useE and GetDistance(enemy) <= 450 and IsAfterAA then
                    CastSpell(_E, mousePos.x, mousePos.z)      
                end
            end
        --end

        if Menu.c.useRAs == 1 and GetDistance(enemy) <= 250 then 
            CastSpell(_R)
        end
    end
    
end

function Harass(enemy)
    local gd = GetDistance(enemy)
    if ValidTarget(enemy) then 
        if Menu.h.useQ and gd <= 285 then
            CastSpell(_Q)
        end 
        if Menu.h.useW and gd <= 500 then 
            CastSpell(_W)
        end
        if myHero:GetSpellData(_E).name ~= "RenektonDice" and Menu.h.useE and gd <= 450 then
            ResetAAs()
            CastSpell(_E, enemy.x, enemy.z)
        elseif myHero:GetSpellData(_E).name == "RenektonDice" and Menu.h.useE and gd <= 450 and IsAfterAA then
            CastSpell(_E, enemy.x, enemy.z)      
        end
    end
end

function Clear ()
    for _, minion in pairs(enemyMinions.objects) do
      if Menu.l.useQ and GetDistance(minion) <= 285 then 
        CastSpell(_Q) 
      end
      if Menu.l.useW and GetDistance(minion) <= 200 then 
        CastSpell(_W) 
      end
      if Menu.l.useE then
        CastSpell(_E, minion.x, minion.z)
      end
    end

    for _, minion in pairs(jungleMinions.objects) do
      if Menu.l.useQ and GetDistance(minion) <= 285 then 
        CastSpell(_Q) 
      end
      if Menu.l.useW and GetDistance(minion) <= 200 then 
        CastSpell(_W) 
      end
      if Menu.l.useE then
        CastSpell(_E, minion.x, minion.z)
      end
    end
end

function Flee()
    myHero:MoveTo(mousePos.x, mousePos.z)
    if Eready then
        CastSpell(_E, mousePos.x, mousePos.z)
        CastSpell(_E, mousePos.x, mousePos.z)
    end
end

function OnApplyBuff(unit, source, buff)
  if unit and buff and unit == myHero and buff.name == "renektonrageready" then RageRdy = true end
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
    Menu.skin:addParam('skinID', 'Skin', SCRIPT_PARAM_LIST, 1, {"Redeemed", "Crimson Elite", "Battle Bunny", "Championship", "Dragonblade", "Arcade", "Classic"})
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

function Checks()
    enemyMinions:update()
    --enemyMinionsQ:update()
    jungleMinions:update()
    --jungleMinionsQ:update()
    ts:update()
   -- tsQ:update()
   -- tsW:update()
   -- tsE:update()
    --tsR:update()
    Qready = (myHero:CanUseSpell(_Q) == READY)
    Wready = (myHero:CanUseSpell(_W) == READY)
    Eready = (myHero:CanUseSpell(_E) == READY)
    Rready = (myHero:CanUseSpell(_R) == READY)
    Target = ts.target
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

