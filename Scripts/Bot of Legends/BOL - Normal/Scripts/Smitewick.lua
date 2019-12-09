
--[[
add stealth detection via W
add peel for most AD teammate

]]--

if myHero.charName ~= "Warwick" then return end

local qrange = 400
local wrange = 1250
local rrange = 700
local smiterange = 760
local SmiteSlot = nil
local ts

local QREADY, WREADY, EREADY, RREADY  = false, false, false, false
local BRKSlot, DFGSlot, HXGSlot, BWCSlot, TMTSlot, RAHSlot, RNDSlot, YGBSlot = nil, nil, nil, nil, nil, nil, nil, nil
local BRKREADY, DFGREADY, HXGREADY, BWCREADY, TMTREADY, RAHREADY, RNDREADY, YGBREADY = false, false, false, false, false, false, false, false
local QREADY, WREADY, EREADY, RREADY = false, false, false, false


--myHero:GetSpellData(_E).level == 1 then erange = 1500


function OnLoad()
PrintChat(">> Loaded Smitewick V3 by Silent Man.")

	ww = scriptConfig("Smitewick", "IfYouReadThisBuyMeAPizza")
	
	ww:addSubMenu("ComboSettings" , "comboConfig")
	ww.comboConfig:addParam("combo", "Combo", SCRIPT_PARAM_ONKEYDOWN, false, 32)
	ww.comboConfig:addParam("useQ", "Use Q in combo", SCRIPT_PARAM_ONOFF, true)
	ww.comboConfig:addParam("useQ2", "Auto Harass with Q", SCRIPT_PARAM_ONOFF, true)
	ww.comboConfig:addParam("useW", "Use W when ally near", SCRIPT_PARAM_ONOFF, false)
	ww.comboConfig:addParam("useR", "Use R in combo", SCRIPT_PARAM_ONOFF, true)
	ww.comboConfig:addParam("autoitem", "Auto use items", SCRIPT_PARAM_ONOFF, true)

	ww:addSubMenu("SmiteSettings" , "smitesettings")
	--ww.smitesettings:addParam("disablesmite", "Toggle Smite Players", SCRIPT_PARAM_ONKEYTOGGLE, true, GetKey("L"))
	ww.smitesettings:addParam("smiteks", "Smite to Killsteal", SCRIPT_PARAM_ONOFF, true)
	ww.smitesettings:addParam("smiteult", "Smite+Ult Combo", SCRIPT_PARAM_ONOFF, true)
	
	ww:addSubMenu("UltSettings" , "ultsettings")
	ww.ultsettings:addParam("ksR", "Ks with R", SCRIPT_PARAM_ONOFF, true)
	ww.ultsettings:addParam("ccR", "Use R on CC'd", SCRIPT_PARAM_ONOFF, true)
	
	--[[ww:addSubMenu("Draw Circles", "draw")
	ww.draw:addParam("drawq", "Draw Q", SCRIPT_PARAM_ONOFF, true)
	ww.draw:addParam("drawr", "Draw R", SCRIPT_PARAM_ONOFF, true)
	ww.draw:addParam("drawsmite", "Draw Smite Range", SCRIPT_PARAM_ONOFF, false)]]--
	ww:addSubMenu("Orbwalker Settings", "Orbwalking")
	ww.smitesettings:permaShow("smiteult")
	
	--ww:addParam("savelife", "Safe Life with Q", SCRIPT_PARAM_ONOFF, false)
	


	ts = TargetSelector(TARGET_LOW_HP, 760, DAMAGE_PHYSICAL)
  ts.name = "Warwick"
  ww:addTS(ts)
	if myHero:GetSpellData(SUMMONER_1).name:lower():find("smite") then SmiteSlot = SUMMONER_1
	elseif myHero:GetSpellData(SUMMONER_2).name:lower():find("smite") then SmiteSlot = SUMMONER_2
	else SmiteSlot = nil
	end
DelayAction(CheckOrbwalk, 8)

end

 function CheckOrbwalk()
	 if _G.Reborn_Loaded and not _G.Reborn_Initialised then
        DelayAction(CheckOrbwalk, 1)
    elseif _G.Reborn_Initialised then
        sacused = true
		ww.Orbwalking:addParam("info11","SAC Detected", SCRIPT_PARAM_INFO, "")
    elseif _G.MMA_Loaded then
		ww.Orbwalking:addParam("info11","MMA Detected", SCRIPT_PARAM_INFO, "")
		mmaused = true
	else
		require "SxOrbWalk"
		SxOrb:LoadToMenu(ww.Orbwalking, false) 
		sxorbused = true
		SxOrb:RegisterAfterAttackCallback(MyAfterAttack)
		DelayAction(function()		
			if SxOrb.Version < 2.3 then
				Print("Your SxOrbWalk library is outdated, please get the latest version!")
			end
		end, 5)
	end
end

function Checks()
    QREADY = (myHero:CanUseSpell(_Q) == READY)
    WREADY = (myHero:CanUseSpell(_W) == READY)
    EREADY = (myHero:CanUseSpell(_E) == READY)
    RREADY = (myHero:CanUseSpell(_R) == READY)
    IGNITEREADY = (IGNITESlot ~= nil and myHero:CanUseSpell(IGNITESlot) == READY)
	        BRKSlot, DFGSlot, HXGSlot, BWCSlot, TMTSlot, RAHSlot, RNDSlot, YGBSlot = GetInventorySlotItem(3153), GetInventorySlotItem(3128), GetInventorySlotItem(3146), GetInventorySlotItem(3144), GetInventorySlotItem(3077), GetInventorySlotItem(3074),  GetInventorySlotItem(3143), GetInventorySlotItem(3142)
        QREADY = (myHero:CanUseSpell(_Q) == READY)
        WREADY = (myHero:CanUseSpell(_W) == READY)
        EREADY = (myHero:CanUseSpell(_E) == READY)
        RREADY = (myHero:CanUseSpell(_R) == READY)
        DFGREADY = (DFGSlot ~= nil and myHero:CanUseSpell(DFGSlot) == READY)
        HXGREADY = (HXGSlot ~= nil and myHero:CanUseSpell(HXGSlot) == READY)
        BWCREADY = (BWCSlot ~= nil and myHero:CanUseSpell(BWCSlot) == READY)
        BRKREADY = (BRKSlot ~= nil and myHero:CanUseSpell(BRKSlot) == READY)
        TMTREADY = (TMTSlot ~= nil and myHero:CanUseSpell(TMTSlot) == READY)
        RAHREADY = (RAHSlot ~= nil and myHero:CanUseSpell(RAHSlot) == READY)
        RNDREADY = (RNDSlot ~= nil and myHero:CanUseSpell(RNDSlot) == READY)
        YGBREADY = (YGBSlot ~= nil and myHero:CanUseSpell(YGBSlot) == READY)
        IREADY = (ignite ~= nil and myHero:CanUseSpell(ignite) == READY)
				ts:update()
end


function OnTick()
Checks()
if ww.comboConfig.useQ2 then
	QHarass()
end
if ww.comboConfig.combo then
	Combo()
end
autoW()
if ww.ultsettings.ksR then
	autoult()
end
if ww.ultsettings.ccR then
	ccR()
end
if ww.smitesettings.smiteks then
	SmiteKS()
end
end

--[[unction UseUlt()
  local erange = GetERange()
  if EREADY and GetDistance(ts.target) <= erange and not ts.target.visable then
    CastSpell(_E)

function GetERange()
        if myHero:GetSpellData(_E).level == 1 then
                return 1500
        elseif myHero:GetSpellData(_E).level == 2 then
                return 2300
        elseif myHero:GetSpellData(_E).level == 3 then
                return 3100
		elseif myHero:GetSpellData(_E).level == 4 then
                return 3900
		elseif myHero:GetSpellData(_E).level == 5 then
				return 4700
		end
end
end
end ]]--

function ccR()
	if ValidTarget(ts.target, 700) and ww.ultsettings.ccR then
		if RREADY and (ts.target.canMove == false) then
			CastSpell(_R, ts.target)
		end
	end
end

function Combo()
if ww.comboConfig.useQ then
	QHarass()
end
if ww.comboConfig.autoitem then 
	useitems()
end
if ww.smitesettings.smiteult then 
	smiteChamp()
end
if ww.comboConfig.useR then
	Ult()
end
end


function Ult()
	if ValidTarget(ts.target, 700) and ww.comboConfig.useR then
		if RREADY then
			CastSpell(_R, ts.target)
		end
	end
end

function autoW()
	if ww.comboConfig.useW then
		for k, ally in pairs(GetAllyHeroes()) do
				if GetDistance(ally) <= 1250 then
            CastSpell(_W)
		end
	end
end
end

function QHarass()	
	Checks()
		if ValidTarget(ts.target, qrange) then
			if QREADY then
				CastSpell(_Q, ts.target)
			end
		end
	end
		
function autoult()
        if RREADY then
                local rDmg = 0    
                for i = 1, heroManager.iCount, 1 do
                        local enemyhero = heroManager:getHero(i)
                        if ValidTarget(enemyhero, (rrange+50)) then
                                rDmg = getDmg("R", enemyhero, myHero)
                                if enemyhero.health <= rDmg then
                                        CastSpell(_R, enemyhero)
                                end
                        end
                end
        end
end

function smiteChamp()
	local smiteDmg = 0		
	if SmiteSlot ~= nil and myHero:CanUseSpell(SmiteSlot) == READY then
		for i = 1, heroManager.iCount, 1 do
		local target = heroManager:getHero(i)
			if ValidTarget(target) then
			smiteDmg = 15 + 3 * myHero.level
				if target ~= nil and target.team ~= myHero.team and not target.dead and target.visible and GetDistance(target) < 760 then
					CastSpell(SmiteSlot, target)
				end
					
			end
		end
	end
end



function SmiteKS()
if ww.smitesettings.smiteks then
                local smiteDmg = 0         
                if SmiteSlot ~= nil and myHero:CanUseSpell(SmiteSlot) == READY then
                        for i = 1, heroManager.iCount, 1 do
                                local target = heroManager:getHero(i)
                                if ValidTarget(target) then
                                        smiteDmg = 15 + 3 * myHero.level
                                        if target ~= nil and target.team ~= myHero.team and not target.dead and target.visible and GetDistance(target) < 700 and target.health < smiteDmg then CastSpell(SmiteSlot, target)
                                                end
                                        end
                                end
                        end
                end
end


function useitems()
    if ts.target ~= nil and ww.comboConfig.autoitem then
    --[[    Items   ]]--
        if GetDistance(ts.target) < 450 then
        if DFGREADY then CastSpell(DFGSlot, ts.target) end
        if HXGREADY then CastSpell(HXGSlot, ts.target) end
        if BWCREADY then CastSpell(BWCSlot, ts.target) end
        if BRKREADY then CastSpell(BRKSlot, ts.target) end
        if YGBREADY then CastSpell(YGBSlot, ts.target) end
        if TMTREADY and GetDistance(ts.target) < 275 then CastSpell(TMTSlot) end
        if RAHREADY and GetDistance(ts.target) < 275 then CastSpell(RAHSlot) end
        if RNDREADY and GetDistance(ts.target) < 275 then CastSpell(RNDSlot) end
		end
	end
end


function OnDraw()
Checks()
	if myHero.dead then return end
	if QREADY then DrawCircle(myHero.x, myHero.y, myHero.z, qrange, 0x19A712)
       else DrawCircle(myHero.x, myHero.y, myHero.z, qrange, 0x992D3D)
	end

	if RREADY then DrawCircle(myHero.x, myHero.y, myHero.z, rrange, 0x19A712)
         else DrawCircle(myHero.x, myHero.y, myHero.z, rrange, 0x992D3D)
	end
	if (myHero:CanUseSpell(SmiteSlot) == READY) then DrawCircle(myHero.x, myHero.y, myHero.z, smiterange, 0x19A712)
         else DrawCircle(myHero.x, myHero.y, myHero.z, smiterange, 0x992D3D)
	end
	end


--[[ 
smite+bork+ultdmg

function doDraw(enemy)
	local smiteDmg = 0
	if SmiteSlot ~= nil and myHero:CanUseSpell(SmiteSlot) == READY then
		smiteDmg = 15 + 3 * myHero.level
	end
	local BoRKDmg = 0
	if BoRKREADY and ValidTarget(target) then
		BoRKDmg = target.maxHealth*.10
	end
	--local bwcDmg = 100
	totaldamage = BoRKDmg + smiteDmg

  PrintFloatText(myHero, 0, "..BoRKDmg)
	--PrintAlert(""..enemy.charName.." is killable",
	end
	end
]]--
	
	--[[savelifewithQfunction]


function savelife()
if myhero.Health < blahblah and no enemy in qrange then
CastSpell(_Q, enemyminion)
end]]--
--[[
function ClosestAllyMostAD()
    local attackdamage = 0
    local closest = nil
    for i=1, heroManager.iCount do
        currentAlly = heroManager:GetHero(i)
        if currentAlly.team == myHero.team and currentAlly.charName ~= myHero.charName then
            if not currentAlly.dead and currentAlly.totalDamage >= attackdamage and myHero:GetDistance(currentAlly) <= rrange then
                attackdamage = currentAlly.totalDamage
                closest = currentAlly
            end
        end
    end
    return closest
end

function FindClosestEnemy(person)
    local distance = 25000
    local closest = nil
    for i=1, heroManager.iCount do
        currentEnemy = heroManager:GetHero(i)
        if currentEnemy.team ~= myHero.team and not currentEnemy.dead and person:GetDistance(currentEnemy) < distance then
            distance = person:GetDistance(currentEnemy)
            closest = currentEnemy
        end
    end
    return closest
end]]--
