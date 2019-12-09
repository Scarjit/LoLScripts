class "Riven"
class "Download"

function Riven:__init()
  self:Variables()
  self:Menu()
  self:Callbacks()
  self:AutoUpdater()
  self:LoadTableOrbs()
  self:LoadOrb()
end

function Riven:Variables()
  self.Version = 3.8
  self.QTarget = nil
  self.QCount = 0
  self.LastQ = 0
  self.SelectedTarget = nil
  self.RTime = 0
  self.Ulted = false
  self.QAA = false
  self.WCasted = false

  if myHero:GetSpellData(SUMMONER_1).name:find("SummonerFlash") then 
    Flash = SUMMONER_1
  elseif myHero:GetSpellData(SUMMONER_2).name:find("SummonerFlash") then 
    Flash = SUMMONER_2
  end
  if myHero:GetSpellData(SUMMONER_1).name:find("SummonerDot") then 
    Ignite = SUMMONER_1
  elseif myHero:GetSpellData(SUMMONER_2).name:find("SummonerDot") then 
    Ignite = SUMMONER_2
  end
  ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, 1000, DAMAGE_PHYSICAL)
  enemyMinions = minionManager(MINION_ENEMY, 270, myHero, MINION_SORT_HEALTH_ASC)
  jungleMinions = minionManager(MINION_JUNGLE, 270, myHero, MINION_SORT_MAXHEALTH_DEC)
end

function Riven:Menu()
  Menu = scriptConfig("Shattered Blade", "ShatteredBlade")

  Menu:addSubMenu("Combo", "Combo")
  Menu.Combo:addParam("Mode", "Combo Mode", SCRIPT_PARAM_LIST, 1, {"BoxBox Mode"})
  Menu.Combo:addParam("Burst", "Burst Mode", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("T"))
  Menu.Combo:permaShow("Burst")
  Menu.Combo:addParam("useFlash", "Use Flash in Burst Mode", SCRIPT_PARAM_ONOFF, true)
  Menu.Combo:permaShow("useFlash")
  Menu.Combo:addParam("useFlashSlice", "Use Flash Above Range (BUGGY)", SCRIPT_PARAM_SLICE, 300, 0, 425)
  Menu.Combo:addParam("blank", "Let E and R Range the Same for R Animation Cancel", SCRIPT_PARAM_INFO, " ")
  Menu.Combo:addParam("useERange", "Use E Range Under", SCRIPT_PARAM_SLICE, 500, 175, 1000)
  Menu.Combo:addParam("useRRange", "Use R Range Under", SCRIPT_PARAM_SLICE, 500, 175, 1000)

  Menu:addSubMenu("LaneClear/JungleClear", "LaneJung")
  Menu.LaneJung:addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
  Menu.LaneJung:addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
  Menu.LaneJung:addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)

  Menu:addSubMenu("Auto W", "AutoW")
  Menu.AutoW:addParam("W", "Use Auto W",SCRIPT_PARAM_ONOFF, true)
  Menu.AutoW:addParam("S", "x Enemies for Auto W", SCRIPT_PARAM_SLICE, 2, 0, 5, 0)

  Menu:addSubMenu("Items Settings", "Items")
  Menu.Items:addParam("Use", "Use Items", SCRIPT_PARAM_ONOFF, true) 
  Menu.Items:addParam("UseBRK", "Use BRK", SCRIPT_PARAM_ONOFF, true) 
  Menu.Items:addParam("UseHydra", "Use Hydra", SCRIPT_PARAM_ONOFF, true) 
  Menu.Items:addParam("UseYoumu", "Use Youmus", SCRIPT_PARAM_ONOFF, true) 
  Menu.Items:addParam("UseQSS", "Use QSS", SCRIPT_PARAM_ONOFF, true)
  Menu.Items:addParam("UseZhonya", "Use Zhonyas", SCRIPT_PARAM_ONOFF, true)
  Menu.Items:addParam("ZhonyaAmount", "Zhonya %", SCRIPT_PARAM_SLICE, 15, 0, 100, 0)

  Menu:addSubMenu("Draws Settings", "Draws")
  Menu.Draws:addParam("CDTracker", "Use CD Tracker", SCRIPT_PARAM_ONOFF, true) 

  Menu:addSubMenu("Emote Cancel", "EmoteCancel")
  Menu.EmoteCancel:addParam("useEmoteC", "Use Emote Cancel", SCRIPT_PARAM_ONOFF, true)
  Menu.EmoteCancel:addParam("emoteC", "Choose Emote", SCRIPT_PARAM_LIST, 1, {"Dance", "Taunt", "Laugh", "Joke"})

  Menu:addSubMenu("Auto Leveler", "Leveler")
  if VIP_USER then
    Menu.Leveler:addParam("Enable", "Enable Auto Leveler", SCRIPT_PARAM_ONOFF, false)
    Menu.Leveler:addParam("Mode", "Mode", SCRIPT_PARAM_LIST, 2, {"Q>W>E", "Q>E>W", "E>Q>W", "E>W>Q"})
    Menu.Leveler.Enable = false
    DelayToLevel = 0
    SequenceLevel = {
    [1] = {1,2,3,1,1,4,2,1,2,3,4,1,2,3,2,4,3,3},
    [2] = {1,3,2,1,1,4,3,1,3,2,4,1,3,2,3,4,2,2},
    [3] = {3,1,2,3,3,4,1,3,1,2,4,3,1,2,1,4,2,2},
    [4] = {3,2,1,3,3,4,2,3,2,1,4,3,2,1,2,4,1,1},
    }
    AddTickCallback(function()
      if os.clock()-DelayToLevel >= 3 then
        DelayToLevel = os.clock()
        if Menu.Leveler.Enable then
          autoLevelSetSequence(SequenceLevel[Menu.Leveler.Mode])
        else
          autoLevelSetSequence(nil)
        end
      end
    end)
  else
    Menu.Leveler:addParam("info", "This is only for VIP Users", SCRIPT_PARAM_INFO, "")
  end

  Menu:addSubMenu("Skin Changer", "Skin")

  if VIP_USER then
    Menu.Skin:addParam("ChangeSkin", "Enable Skin Changer", SCRIPT_PARAM_ONOFF, false)
    Menu.Skin:setCallback('ChangeSkin', function(Change)
      if Change then
        SetSkin(myHero, Menu.Skin.SkinID-1)
      else
        SetSkin(myHero, -1)
      end
    end)
    Menu.Skin:addParam('SkinID', 'Skins', SCRIPT_PARAM_LIST, 1, {"Classic", "Redeemed", "Crimson Elite", "Battle Bunny", "Championship", "Dragonblade", "Arcade"})
    Menu.Skin.SkinID = 1
    Menu.Skin:setCallback('SkinID', function(Change)
    if Menu.Skin.ChangeSkin then
      SetSkin(myHero, Menu.Skin.SkinID-1)
    end
    end)
    
    if Menu.Skin.ChangeSkin then
      SetSkin(myHero, Menu.Skin.SkinID-1)
    end
  else
    Menu.Skin:addParam("info", "This is only for VIP Users", SCRIPT_PARAM_INFO, "")
  end
  if Ignite then
    Menu:addParam("AutoIgnite", "Use Auto Ignite in killable enemies", SCRIPT_PARAM_ONOFF, true)
  end
    Menu:addParam("Region", "Your Region:", SCRIPT_PARAM_INFO, GetGameRegion())
end

function Riven:Callbacks()
  AddTickCallback(function()
    if myHero.dead then return end
    Target = self:GetCustomTarget()
    self:ComboManager(Target)
    self:LaneClear()
    self:AutoW()
    self:Flee()
    self:Checks()
    self:AutoIgnite()
    if myHero:GetSpellData(_Q).currentCd > 0.5 then self.QAA = false end
    if myHero:GetSpellData(_W).currentCd > 1 then self.WCasted = true end
    if self.Wready then self.WCasted = false end
  end)
  AddAnimationCallback(function(unit, animation) 
    if unit and animation and unit.isMe then
        if animation == "Spell1a" or animation == "Spell1b" or animation == "Spell1c" then
          if animation == "Spell1a" or animation == "Spell1b" then
            DelayAction(function()
              if ValidTarget(self.QTarget) and GetDistance(self.QTarget) < 270 then
                if Menu.EmoteCancel.useEmoteC then DoEmote(Menu.EmoteCancel.emoteC-1) end
                self:ResetAAs()
              end
            end, 0.3-GetLatency()/1000)
          elseif animation == "Spell1c" then
            DelayAction(function()
              if ValidTarget(self.QTarget) and GetDistance(self.QTarget) < 270 then
                if Menu.EmoteCancel.useEmoteC then DoEmote(Menu.EmoteCancel.emoteC-1) end
                self:ResetAAs()
              end
            end, 0.4-GetLatency()/1000)
          end
        end
    end
  end)
  AddMsgCallback(function(msg, key)
    if msg == WM_LBUTTONDOWN and not myHero.dead then
      for i, enemy in ipairs(GetEnemyHeroes()) do
            if GetDistance(enemy, mousePos) <= 115 and ValidTarget(enemy) and enemy.type == "AIHeroClient" then
              if self.SelectedTarget ~= enemy then
                self.SelectedTarget = enemy
                SendMsg("Selected Target: "..enemy.charName)
              else
                self.SelectedTarget = nil 
                SendMsg("Unselected Target: "..enemy.charName)
              end
        end
      end
    end
  end)
  AddDrawCallback(function()
    if Menu.Draws.CDTracker then
      self:DrawCD() 
    end
    if(self:GetCustomTarget()) then
    	DrawTextA("Target: "..tostring(self:GetCustomTarget().charName),12,60,180)
    end
    if myHero.dead then return end
  end)
  AddProcessAttackCallback(function(unit, spell)
    self.AADone = false
    if unit.isMe and spell.name:lower():find("attack") then
      if self.QAA == true and self:Keys() == "Combo" or self:Keys() == "Laneclear" or self:Keys() == "Harass" then
      CastSpell(_Q, myHero.spell.target.x, myHero.spell.target.z)
      self:ResetAAs()
      end
      self.AADone = true
    end
  end)
  AddApplyBuffCallback(function(unit, source, buff)
    if unit and buff and unit.isMe and buff.name == "RivenFengShuiEngine" then
      self.Ulted = true
      self.RTime = os.clock()
    end
  end)
  AddRemoveBuffCallback(function(unit, buff)
    if unit and buff and unit.isMe and buff.name == "rivenwindslashready" then
      self.Ulted = false
      self.RTime = 0
    end
    if unit and buff and unit.isMe and buff.name == "riventricleavesoundthree" then
      --self.QAA = false
    end
  end)
  AddUnloadCallback(function()
    if VIP_USER then
      SetSkin(myHero, -1)
    end
  end)
end

function Riven:AutoIgnite()
  if Ignite and Menu.AutoIgnite then
    for i, enemy in ipairs(GetEnemyHeroes()) do
      if enemy.health <= 50 + (20 * myHero.level) and myHero:CanUseSpell(Ignite) == READY and GetDistance(enemy) < 650 then
        CastSpell(Ignite, enemy)
      end
    end
  end
end

function Riven:IsAfterAA()
  return os.clock() * 1000 + (GetLatency() / 2) < self.AfterAttackTime
end

function Riven:GetHPBarPos(enemy)
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

function Riven:DrawCD()
  for i = 1, heroManager.iCount, 1 do
    local champ = heroManager:getHero(i)
    if champ ~= nil and champ ~= myHero and champ.visible and champ.dead == false then
      local barPos = self:GetHPBarPos(champ)
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

function Riven:ResetAAs()
  if self.LoadedOrb == "Sac" and TIMETOSACLOAD then
    _G.AutoCarry.Orbwalker:ResetAttackTimer()
    --_G.AutoCarry.Orbwalker:IsAfterAttack()
  elseif LoadedOrb == "Mma" then
    _G.MMA_ResetAutoAttack()
  elseif self.LoadedOrb == "Pewalk" then
  
  elseif self.LoadedOrb == "Now" then
    _G.NebelwolfisOrbWalker:ResetAA()
  elseif self.LoadedOrb == "Big" then
  
  elseif self.LoadedOrb == "Sow" then
    _G.SOWi:resetAA()
  elseif self.LoadedOrb == "SxOrbWalk" then
    _G.SxOrb:ResetAA()
  elseif self.LoadedOrb == "S1mpleOrbWalker" then
    _G.S1mpleOrbWalker:ResetAA()
  end
end

function Riven:GetCustomTarget()
  ts:update()
  if self.SelectedTarget == nil then
    return ts.target
  elseif self.SelectedTarget ~= nil and ValidTarget(self.SelectedTarget, 750) then
    return self.SelectedTarget
  else
    return ts.target
  end
end

function Riven:AutoUpdater()
  local host = "www.scarjit.de"
  local file = "/HiranN/BoL/Scripts/Riven.lua"
  local file2 = "/HiranN/BoL/Versions/"
  local name = GetCurrentEnv().FILE_NAME
  local path = SCRIPT_PATH
  DelayAction(function()
    local ServerVersionDATA = GetWebResult(host, file2.."Riven.version")
    local ServerVersion = tonumber(ServerVersionDATA)
    if ServerVersion then
      if ServerVersion > tonumber(self.Version) then
        DL = Download()
        SendMsg("Updating to version: "..ServerVersion)
        DL:newDL(host, file, name, path, function()
          SendMsg("Updated to version: "..ServerVersion..", press 2x F9")
        end)
      else
        SendMsg("You have the latest version: "..self.Version)
      end
    else
      SendMsg("Can't connect to Updater Site")
    end
  end, 0.85)
end

function Riven:ComboManager(target)
  if Menu.Combo.Burst then
    self:Combo2(target)
  elseif Menu.Combo.Mode == 1 then 
    self:Combo1(target)
  end 
  if ValidTarget(target) then
    CastItems()
  end
end

function Riven:AutoW()
  if Menu.AutoW.S ~= 0 then
    if Menu.AutoW.W and CountEnemyHeroInRange(260) >= Menu.AutoW.S then
        CastSpell(_W)
    end
  end
end

DelayFleeM = 0
function Riven:Flee()
  if Menu.Keys.Flee then
    CastSpell(_Q, mousePos.x, mousePos.z)
    CastSpell(_E, mousePos.x, mousePos.z)
    if os.clock()-DelayFleeM > 0.15 then
      DelayFleeM = os.clock()
      myHero:MoveTo(mousePos.x, mousePos.z)
    end
  end
end

function Riven:Checks()
  self.Qready = (myHero:CanUseSpell(_Q) == READY and true or false)
  self.Wready = (myHero:CanUseSpell(_W) == READY and true or false)
  self.Eready = (myHero:CanUseSpell(_E) == READY and true or false)
  self.Rready = (myHero:CanUseSpell(_R) == READY and true or false)
  if Flash then
    self.Flash = (myHero:CanUseSpell(Flash) == READY and true or false)
  end
end

function Riven:Combo1(target)
  if ValidTarget(target) and self:Keys() == "Combo" then
    if self.Qready and not self.Eready and not self.Wready and not self.Rready then
      self:CastQAA2(target)
    end
    if self.Eready and self.Qready and not self.Wready and not self.Rready and not self.Ulted then
      self:CastE(target)
      self:CastQAA2(target)
    end
    if self.Eready and not self.Qready and not self.Wready and not self.Rready and not self.Ulted then
      self:CastE(target)
      if self.LoadedOrb == "Sac" then self:CastItems2(target) end
    end
    if self.Eready and self.Wready and not self.Qready and not self.Rready and not self.Ulted then
      self:CastE(target)
      self:CastW(target)
    end
    if self.Eready and self.Ulted and self.Rready and target.health <= self:rDmg(target) then
      self:CastE(target)
      self:CastR(target)
    end
    if self.Wready and self.Rready and not self.Qready and not self.Eready and not self.Ulted then
      self:CastR(target)
      self:CastW(target)
    end
    if self.Wready and not self.Qready and not self.Eready and not self.Rready then
      self:CastW(target)
      if self.LoadedOrb == "Sac" then self:CastItems2(target) end
    end
    if self.Wready and self.Ulted and self.Rready and target.health <= self:rDmg(target) and not self.Qready and not self.Eready then
      self:CastR(target)
      self:CastW(target)
    end
    if self.Qready and self.Ulted and target.health <= self:rDmg(target) and not self.Eready and not self.Wready then
      self:CastR(target)
      self:CastQAA2(target)
    end
    if self.Eready and self.Qready and not self.Wready and not self.Rready and not self.Ulted then
      self:CastE(target)
      --AA
      if self.LoadedOrb == "Sac" then self:CastItems2(target) end
      self:CastQAA2(target)
    end
    if self.Eready and self.Wready and not self.Qready and not self.Rready and not self.Ulted then
      self:CastE(target)
      -- AA
      if self.LoadedOrb == "Sac" then self:CastItems2(target) end
      self:CastW(target)
    end
    if self.Eready and self.Rready and self.Qready and not self.Wready and not self.Ulted then
      self:CastE(target)
      self:CastR(target)
      self:CastQAA2(target)
    end
    if self.Eready and self.Qready and self.Ulted and self.Rready and not self.Wready then
      self:CastE(target)
      self:CastR(target)
      self:CastQAA2(target)
    end
    if self.Eready and self.Qready and self.Wready and not self.Rready and not self.Ulted then
      self:CastE(target)
      --AA!!
      if self.LoadedOrb == "Sac" then self:CastItems2(target) end
      self:CastQAA2(target) --1 Q
      self:CastW(target)
    end
    if self.Eready and self.Rready and self.Qready and not self.Wready and not self.Ulted then
      self:CastE(target)
      if self.LoadedOrb == "Sac" then self:CastItems2(target) end
      self:CastR(target)
      self:CastQAA2(target)
    end
    if self.Eready and self.Ulted and self.Rready and self.Wready and not self.Qready and target.health <= self:rDmg(target) then
      self:CastE(target)
      if self.LoadedOrb == "Sac" then self:CastItems2(target) end
      self:CastR(target)
    end
    if self.Eready and self.Wready and self.Qready and not self.Rready and not self.Ulted then
      self:CastE(target)
      if self.LoadedOrb == "Sac" then self:CastItems2(target) end
      self:CastW(target)
      self:CastQAA2(target)
    end
    if self.Eready and self.Rready and not self.Ulted and self.Wready and self.Qready then
      self:CastE(target)
      if self.LoadedOrb == "Sac" then self:CastItems2(target) end
      self:CastR(target)
      self:CastW(target)
      self:CastQAA2(target)
    end
    if self.Eready and self.Ulted and self.Wready and self.Qready and target.health <= self:rDmg(target) then
      self:CastE(target)
      if self.LoadedOrb == "Sac" then self:CastItems2(target) end
      self:CastR(target)
      self:CastW(target)
      self:CastQAA2(target)
    end
  end
end

function Riven:Combo2(target)
  if ValidTarget(target) and self:Keys() == "Combo" then
    if self.Eready and self.Rready and self.Wready and self.Qready then -- noch Check hinzufÃ??Ã??Ã??Ã¢??Ã??Ã¢??Ã??Ã?Â¼gen fÃ??Ã??Ã??Ã¢??Ã??Ã¢??Ã??Ã?Â¼r Flash, Menu Flash nutzen
      self:CastE(target)
      self:CastR(target)
      if self.Flash and self.Ulted and GetDistance(target) <= Menu.Combo.useFlashSlice and Menu.Combo.useFlash then 
        CastSpell(Flash, target.x, target.z)
      end
      self:CastW(target)
      -- AA
      if self.WCasted == true then
        CastSpell(_R, target.x, target.z)
      else 
        DelayAction(function ()
          CastSpell(_R, target.x, target.z)
        end, 3)
      end
      self:CastQAA(target)
   elseif Menu.Combo.Burst then
      Menu.Combo.Burst = false
    end
  end
end

function Riven:LaneClear()
  if self:Keys() == "Laneclear" then
    enemyMinions:update()
    jungleMinions:update()

      for _, minion in pairs(enemyMinions.objects) do
      if Menu.LaneJung.Q then 
        self:CastQAA2(minion) 
      end
      if Menu.LaneJung.W then 

        self:CastW(minion) 
      end
    end

    for _, minion in pairs(jungleMinions.objects) do
      if Menu.LaneJung.Q then 
        self:CastQAA2(minion) 
      end
      if Menu.LaneJung.W then 
        self:CastW(minion) 
      end
      if Menu.LaneJung.E then
        self:CastE(minion)
      end
    end
  end
end
function Riven:CastItems2 (target)
  _G.AutoCarry.Items:UseAll(target)
end

function Riven:CastQAA(target)
  if ValidTarget(target) then
    self.QTarget = target
    if GetDistance(target) > 270 then
      self.QAA = true
    end
  end
end

function Riven:CastQAA2(target)
  if ValidTarget(target) then
    if GetDistance(target) < 270 then
      self.QAA = true
    else
      self:CastQAA(target)
    end
  end
end

function Riven:CastW(target)
  if ValidTarget(target, 255) and myHero:GetSpellData(_Q).currentCd > 0.5 then
    CastSpell(_W)
  end
end

function Riven:CastE(target)
  if ValidTarget(target, Menu.Combo.useERange) then
    CastSpell(_E, target.x, target.z)
  end
end

function Riven:CastR(target)
  if ValidTarget(target, Menu.Combo.useRRange) then
      if not self.Ulted then CastSpell(_R) end
      if self.Ulted then
        if self:rDmg(target) >= target.health or self.RTime-os.clock() <= -11 then
          CastSpell(_R, target.x, target.z) 
        end
      end
    end
end

function Riven:rDmg(unit)
  local Lvl = myHero:GetSpellData(_R).level
  if Lvl < 1 then return 0 end
  local DMGCALC = 0
  bad = myHero.addDamage*(1.2)
  ad = myHero.totalDamage+bad
  local hpercent = unit.health/unit.maxHealth
  if hpercent <= 0.25 then
  DMGCALC = 120*myHero:GetSpellData(_R).level+120+1.8*bad
  else
  DMGCALC = (40*myHero:GetSpellData(_R).level+40+0.6*bad) * (hpercent)*(-2.67) + 3.67
  end
  return myHero:CalcDamage(unit, DMGCALC)
end

function Riven:LoadTableOrbs()
  self.OrbWalkers = {}
  self.LoadedOrb = nil
  if _G.Reborn_Loaded or _G.Reborn_Initialised or _G.AutoCarry ~= nil then
    table.insert(self.OrbWalkers, "SAC")
  end
  if _G.MMA_IsLoaded then
    table.insert(self.OrbWalkers, "MMA")
  end
  if _G._Pewalk then
    table.insert(self.OrbWalkers, "Pewalk")
  end
  if FileExist(LIB_PATH .. "/Nebelwolfi's Orb Walker.lua") then
    table.insert(self.OrbWalkers, "NOW")
  end
  if FileExist(LIB_PATH .. "/Big Fat Orbwalker.lua") then
    table.insert(self.OrbWalkers, "Big Fat Walk")
  end
  if FileExist(LIB_PATH .. "/SOW.lua") then
    table.insert(self.OrbWalkers, "SOW")
  end
  if FileExist(LIB_PATH .. "/SxOrbWalk.lua") then
    table.insert(self.OrbWalkers, "SxOrbWalk")
  end
  if FileExist(LIB_PATH .. "/S1mpleOrbWalker.lua") then
    table.insert(self.OrbWalkers, "S1mpleOrbWalker")
  end
  if #self.OrbWalkers > 0 then
    Menu:addSubMenu("Orbwalkers", "Orbwalkers")
    Menu:addSubMenu("Keys", "Keys")
    Menu.Orbwalkers:addParam("Orbwalker", "OrbWalker", SCRIPT_PARAM_LIST, 1, self.OrbWalkers)
    Menu.Keys:addParam("info", "Detecting keys from :", SCRIPT_PARAM_INFO, self.OrbWalkers[Menu.Orbwalkers.Orbwalker])
    Menu.Keys:addParam("Flee", "Flee Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("G"))
    local OrbAlr = false
        Menu.Orbwalkers:setCallback("Orbwalker", function(value) 
        if OrbAlr then return end
        OrbAlr = true
      Menu.Orbwalkers:addParam("info", "Press F9 2x to load your selected Orbwalker.", SCRIPT_PARAM_INFO, "")
        SendMsg("Press F9 2x to load your selected Orbwalker")
      end)
  end
end

  function CastItems()
  ___GetInventorySlotItem = rawget(_G, "GetInventorySlotItem")
  _G.GetInventorySlotItem = GetSlotItem
  _G.ITEM_1 = 06
  _G.ITEM_2 = 07
  _G.ITEM_3 = 08
  _G.ITEM_4 = 09
  _G.ITEM_5 = 10
  _G.ITEM_6 = 11
  _G.ITEM_7 = 12
  ItemNames     = {
  [3144]        = "BilgewaterCutlass",
  [3153]        = "ItemSwordOfFeastAndFamine",
  [3405]        = "TrinketSweeperLvl1",
  [3166]        = "TrinketTotemLvl1",
  [3361]        = "TrinketTotemLvl3",
  [3362]        = "TrinketTotemLvl4",
  [2003]        = "RegenerationPotion",
  [3146]        = "HextechGunblade",
  [3187]        = "HextechSweeper",
  [3364]        = "TrinketSweeperLvl3",
  [3074]        = "ItemTiamatCleave",
  [3077]        = "ItemTiamatCleave",
  [3340]        = "TrinketTotemLvl1",
  [3090]        = "ZhonyasHourglass",
  [3142]        = "YoumusBlade",
  [3157]        = "ZhonyasHourglass",
  [3350]        = "TrinketTotemLvl2",
  [3140]        = "QuicksilverSash",
  [3139]        = "ItemMercurial",
  }
  if Target ~= nil then
  if Menu.Items.UseBRK then
  local slot = GetInventorySlotItem(3153)
  if Target ~= nil and ValidTarget(Target) and not Target.dead and slot ~= nil and myHero:CanUseSpell(slot) == READY and GetDistance(Target) <= 450 then
  CastSpell(slot, Target)
  end
  end

  if Menu.Items.UseHydra then
  local slot = GetInventorySlotItem(3074)
  if Target ~= nil and ValidTarget(Target) and not Target.dead and slot ~= nil and myHero:CanUseSpell(slot) == READY and GetDistance(Target) <= 300 then
  CastSpell(slot)
  end
  end

  if Menu.Items.UseQSS then

  if GetInventorySlotItem(3139) ~= nil then 
  local slot = GetInventorySlotItem(3139) 
  elseif GetInventorySlotItem(3140) ~= nil then 
  local slot = GetInventorySlotItem(3140) end 

  local buffsList = 6,8,9,11,20,21,23,24,29,30,31
  if Target ~= nil and ValidTarget(Target) and not Target.dead and slot ~= nil and myHero:CanUseSpell(slot) == READY and GetDistance(Target) <= 600 and HaveBuffs(myHero, buffsList) then
  CastSpell(slot)
  end
  end

  if Menu.Items.UseYoumu then
  local slot = GetInventorySlotItem(3142)
  if Target ~= nil and ValidTarget(Target) and not Target.dead and slot ~= nil and myHero:CanUseSpell(slot) == READY then
  CastSpell(slot)
  end
  end

  if Menu.Items.UseZhonya then
  local slot = GetInventorySlotItem(3157)
  if myHero.health <= (myHero.maxHealth * Menu.Items.ZhonyaAmount / 100) and slot ~= nil and myHero:CanUseSpell(slot) == READY and CountEnemyHeroInRange(900) >= 1 then CastSpell(slot) end
  end
  end
  end

  function GetSlotItem(id, unit)
  
  unit = unit or myHero

  if (not ItemNames[id]) then
  return ___GetInventorySlotItem(id, unit)
  end

  local name  = ItemNames[id]
  
  for slot = ITEM_1, ITEM_7 do
  local item = unit:GetSpellData(slot).name
  if ((#item > 0) and (item:lower() == name:lower())) then
  return slot
  end
  end
  end

function Riven:LoadOrb()
  if self.OrbWalkers[Menu.Orbwalkers.Orbwalker] == "SAC" then
    self.LoadedOrb = "Sac"
    TIMETOSACLOAD = false
    DelayAction(function()
      TIMETOSACLOAD = true
    end,15)
  elseif self.OrbWalkers[Menu.Orbwalkers.Orbwalker] == "MMA" then
    self.LoadedOrb = "Mma"
  elseif self.OrbWalkers[Menu.Orbwalkers.Orbwalker] == "Pewalk" then
    self.LoadedOrb = "Pewalk"
  elseif self.OrbWalkers[Menu.Orbwalkers.Orbwalker] == "NOW" then
    self.LoadedOrb = "Now"
    require "Nebelwolfi's Orb Walker"
    _G.NOWi = NebelwolfisOrbWalkerClass()
      --Menu.Orbwalkers:addSubMenu("NOW", "NOW")
      --_G.NebelwolfisOrbWalkerClass(Menu.Orbwalkers.NOW) 
  elseif self.OrbWalkers[Menu.Orbwalkers.Orbwalker] == "Big Fat Walk" then
    self.LoadedOrb = "Big"
    require "Big Fat Orbwalker"
  elseif self.OrbWalkers[Menu.Orbwalkers.Orbwalker] == "SOW" then
    self.LoadedOrb = "Sow"
    require "SOW"
      Menu.Orbwalkers:addSubMenu("SOW", "SOW")
      _G.SOWi = SOW(_G.VP)
    SOW:LoadToMenu(Menu.Orbwalkers.SOW)
  elseif self.OrbWalkers[Menu.Orbwalkers.Orbwalker] == "SxOrbWalk" then
    self.LoadedOrb = "SxOrbWalk"
    require "SxOrbWalk"
      Menu.Orbwalkers:addSubMenu("SxOrbWalk", "SxOrbWalk")
    SxOrb:LoadToMenu(Menu.Orbwalkers.SxOrbWalk)
  elseif self.OrbWalkers[Menu.Orbwalkers.Orbwalker] == "S1mpleOrbWalker" then 
    self.LoadedOrb = "S1mpleOrbWalker"
    require "S1mpleOrbWalker"
		_G.S1mpleOrbWalker = S1mpleOrbWalker()
    DelayAction(function()
      _G.S1mpleOrbWalker:AddToMenu(Menu.Orbwalkers)
    end, 1)
  end
end

function Riven:Keys()
  if self.LoadedOrb == "Sac" and TIMETOSACLOAD then
  if _G.AutoCarry.Keys.AutoCarry then return "Combo" end
  if _G.AutoCarry.Keys.MixedMode then return "Harass" end
  if _G.AutoCarry.Keys.LaneClear then return "Laneclear" end
  if _G.AutoCarry.Keys.LastHit then return "Lasthit" end
  elseif self.LoadedOrb == "Mma" then
  if _G.MMA_IsOrbwalking() then return "Combo" end
  if _G.MMA_IsDualCarrying() then return "Harass" end
  if _G.MMA_IsLaneClearing() then return "Laneclear" end
  if _G.MMA_IsLastHitting() then return "Lasthit" end
  elseif self.LoadedOrb == "Pewalk" then
  if _G._Pewalk.GetActiveMode().Carry then return "Combo" end
  if _G._Pewalk.GetActiveMode().Mixed then return "Harass" end
  if _G._Pewalk.GetActiveMode().LaneClear then return "Laneclear" end
  if _G._Pewalk.GetActiveMode().Farm then return "Lasthit" end
  elseif self.LoadedOrb == "Now" then
    if _G.NOWi.mode == "LastHit" then
      return "Lasthit"
    elseif _G.NOWi.mode ~= "JungleClear" then
      return _G.NOWi.mode
    end
  --[[
  if _G.NOWi.Config.k.Combo then return "Combo" end
  if _G.NOWi.Config.k.Harass then return "Harass" end
  if _G.NOWi.Config.k.LaneClear then return "Laneclear" end
  if _G.NOWi.Config.k.LastHit then return "Lasthit" end
  ]]--
  elseif self.LoadedOrb == "Big" then
  if _G["BigFatOrb_Mode"] == "Combo" then return "Combo" end
  if _G["BigFatOrb_Mode"] == "Harass" then return "Harass" end
  if _G["BigFatOrb_Mode"] == "LaneClear" then return "Laneclear" end
  if _G["BigFatOrb_Mode"] == "LastHit" then return "Lasthit" end
  elseif self.LoadedOrb == "Sow" then
  if _G.SOWi.Menu.Mode0 then return "Combo" end
  if _G.SOWi.Menu.Mode1 then return "Harass" end
  if _G.SOWi.Menu.Mode2 then return "Laneclear" end
  if _G.SOWi.Menu.Mode3 then return "Lasthit" end
  elseif self.LoadedOrb == "SxOrbWalk" then
  if _G.SxOrb.isFight then return "Combo" end
  if _G.SxOrb.isHarass then return "Harass" end
  if _G.SxOrb.isLaneClear then return "Laneclear" end
  if _G.SxOrb.isLastHit then return "Lasthit" end
  elseif self.LoadedOrb == "S1mpleOrbWalker" then
		return _G.S1mpleOrbWalker:GetOrbMode()
  end
end

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

if myHero.charName ~= "Riven" then return end

-- BoL Tools Tracker --
assert(load(Base64Decode("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"), nil, "bt", _ENV))()
TrackerLoad("SYmmrH5U23buufxE")
-- BoL Tools Tracker --

function OnLoad()
  Riven()
  SendMsg("Thanks "..GetUser().." for using Shattered Blade")
  Download()
end

function SendMsg(msg)
  PrintChat("<font color=\"#06CD51\"><b>[Shattered Blade]</b></font><font color=\"#C2FDF3\"><b> "..msg..".</b></font>")
end