if not FileExist(LIB_PATH.."Nebelwolfi's Orb Walker.lua") then
	DownloadFile("http://raw.githubusercontent.com/nebelwolfi/BoL/master/Common/Nebelwolfi's Orb Walker.lua", LIB_PATH.."Nebelwolfi's Orb Walker.lua", function()
		print("Please press 2x F9")
	end)
end
require("Nebelwolfi's Orb Walker")

class("SxOrb")
--Members
SxOrb.enemyHeroes = nil
SxOrb.lastAA = 0
SxOrb.enemyMinions = nil
SxOrb.jungleMinions = nil
SxOrb.ownMinions = nil
SxOrb.minionAttacks = {} --NOP
SxOrb.version = "3.29"
SxOrb.Version = tonumber(SxOrb.version)
SxOrb.doMove = true
SxOrb.doAttack = true

SxOrb.isFight = false
SxOrb.isHarass = false
SxOrb.isLaneClear = false
SxOrb.isLastHit = false

--SxOrb.menu = nil
--SxOrb.menu.TS.focusSelectedTarget = false -- NOP
--SxOrb.menu.TS.mode = 4 -- NOP
--SxOrb.menu.TS.prioritySettings[champname] --Nol

function SxOrb:__init()
	local function LoadCallBacks()
		if not _G.NebelwolfisOrbWalkerLoaded then
			DelayAction(LoadCallBacks(),2)
		else
		_G.NebelwolfisOrbWalker.Config.k:setCallback("Combo", function ()
			SxOrb.isFight = _G.NebelwolfisOrbWalker.Config.k.Combo
		end)

		_G.NebelwolfisOrbWalker.Config.k:setCallback("Harass", function ()
			SxOrb.isHarass = _G.NebelwolfisOrbWalker.Config.k.Harass
		end)

		_G.NebelwolfisOrbWalker.Config.k:setCallback("LastHit", function ()
			SxOrb.isLastHit = _G.NebelwolfisOrbWalker.Config.k.LastHit
		end)

		_G.NebelwolfisOrbWalker.Config.k:setCallback("LaneClear", function ()
			SxOrb.isLaneClear = _G.NebelwolfisOrbWalker.Config.k.LaneClear
		end)
		end
	end
	--Members
	SxOrb.enemyHeroes = GetEnemyHeroes()
	SxOrb.enemyMinions = minionManager(MINION_ENEMY, 700, player, MINION_SORT_HEALTH_ASC)
	SxOrb.jungleMinions = minionManager(MINION_JUNGLE, 700, player, MINION_SORT_HEALTH_ASC)
	SxOrb.ownMinions = minionManager(MINION_ALLY, 700, player, MINION_SORT_HEALTH_ASC)

	print("SxOrb -> Nebelwolfi's Orb Walk Bride Loaded Version: "..SxOrb.version)

end

function SxOrb:LoadToMenu(menu, useless)
	NebelwolfisOrbWalkerClass(menu)
end

function SxOrb:Clock()
	return os.clock()
end

function SxOrb:WindUpTime()
	return _G.NebelwolfisOrbWalker:GetWindUp()
end

function SxOrb:CanMove()
	return _G.NebelwolfisOrbWalker:TimeToMove()
end

function SxOrb:CanAttack()
	return _G.NebelwolfisOrbWalker:TimeToAttack()
end

function SxOrb:GetAADmg(unit)
	return _G.NebelwolfisOrbWalker:GetDmg(myHero, unit)
end

function SxOrb:ResetAA()
	return _G.NebelwolfisOrbWalker:ResetAA()
end

function SxOrb:GetTarget(range)
	if not range then range = 600 end
	local target = _G.NebelwolfisOrbWalker:GetTarget()
	if target and GetDistance(myHero, target) <= range then
		return target
	else
		return nil
	end
end

function SxOrb:ForceTarget(unit, range)
	return _G.NebelwolfisOrbWalker:SetTarget(unit)
end

function SxOrb:ForcePoint(x,y)
	local pos = {x,y}
	return _G.NebelwolfisOrbWalker:ForcePos(pos)
end

function SxOrb:DisableAttacks()
	SxOrb.doAttack = false
	_G.NebelwolfisOrbWalker:SetAA(false)
end

function SxOrb:EnableAttacks()
	SxOrb.doAttack = true
	_G.NebelwolfisOrbWalker:SetAA(true)
end

function SxOrb:DisableMove()
	SxOrb.doMove = false
	_G.NebelwolfisOrbWalker:SetMove(false)
end

function SxOrb:EnableMove()
	SxOrb.doMove = true
	_G.NebelwolfisOrbWalker:SetMove(true)
end

function SxOrb:RegisterBeforeAttackCallback(func)
	_G.NebelwolfisOrbWalker:AddCallback(BEFORE_ATTACK, func)
end

function SxOrb:RegisterOnAttackCallback(func)
	_G.NebelwolfisOrbWalker:AddCallback(ON_ATTACK, func)
end

function SxOrb:RegisterAfterAttackCallback(func)
	_G.NebelwolfisOrbWalker:AddCallback(AFTER_ATTACK, func)
end

function SxOrb:GetMode() -- Returns current mode from SxOrb, 0 = NoMode, 1 = Fight, 2 = Harass, 3 = LaneClear, 4 = LastHit
	if _G.NebelwolfisOrbWalker.Config.k.Combo then
		return 1
	elseif _G.NebelwolfisOrbWalker.Config.k.Harass then
		return 2
	elseif _G.NebelwolfisOrbWalker.Config.k.LaneClear then
		return 3
	elseif _G.NebelwolfisOrbWalker.Config.k.LaneClear then
		return 4
	else
		return 0
	end
end

function SxOrb:HasBuff(unit, buff)
	return TargetHaveBuff(buff, unit)
end

function SxOrb:isAA(spell)
	if spell and spell.name:lower():find("attack") then
		return true
	else
		return false
	end
end

function SxOrb:Latency()
	return GetLatency()
end

animtime = 0
function SxOrb:AnimationTime()
	return animtime
end

function SxOrb:Attack(unit)
	myHero:Attack(unit)
end

function SxOrb:Range()
	return myHero.range
end

--Register LastAA and Timings
function OnAnimation(unit, animation)
    if unit.isMe and animation:find("Attack") then        
        SxOrb.lastAA = os.clock()
        local spellProc = unit.spell
        animtime = spellProc.animationTime

    end
end


--Not jet Working

function SxOrb:ProjSpeed()
	return math.huge
end

function SxOrb:RegisterHotKey(Mode,MainMenu,SubMenu)
	print("Sry you can't use that function atm")
end