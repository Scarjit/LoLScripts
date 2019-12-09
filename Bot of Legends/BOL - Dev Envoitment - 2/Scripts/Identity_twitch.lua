local PassiveStacks = {}
local PassiveApply = {}
local eDamageAdLevelTable = {20,35,50,65,80}
local eDamageAdStackTable = {15,20,25,30,35}

function OnLoad()
print("<b> Twitch script loaded </b>")
end

function getDamageE(target)
	return myHero:CalcDamage(target,eDamageAdLevelTable[myHero:GetSpellData(_E).level] + (PassiveStacks[target.networkID]*(eDamageAdStackTable[myHero:GetSpellData(_E).level] + (0.2*myHero.ap) + (0.25*(myHero.totalDamage - myHero.damage)))))
end

function GetEnemyHPBarPos(enemy)
    if not enemy.barData then  enemy.barData = {PercentageOffset = {x = 0, y = 0} } end
    local barPos = GetUnitHPBarPos(enemy)
    local barPosOffset = GetUnitHPBarOffset(enemy)
    local barOffset = Point(enemy.barData.PercentageOffset.x, enemy.barData.PercentageOffset.y)
    local barPosPercentageOffset = Point(enemy.barData.PercentageOffset.x, enemy.barData.PercentageOffset.y)
    local BarPosOffsetX = 169
    local BarPosOffsetY = 47
    local CorrectionX = 16
    local CorrectionY = 4
    barPos.x = barPos.x + (barPosOffset.x - 0.5 + barPosPercentageOffset.x) * BarPosOffsetX + CorrectionX
    barPos.y = barPos.y + (barPosOffset.y - 0.5 + barPosPercentageOffset.y) * BarPosOffsetY + CorrectionY 
    local StartPos = Point(barPos.x, barPos.y)
    local EndPos = Point(barPos.x + 103, barPos.y)
    return Point(StartPos.x, StartPos.y), Point(EndPos.x, EndPos.y)
end

function DrawEstacks(enemy)
    local damage = getDamageE(enemy)
    local stacks = GetStacks(enemy)
    local SPos, EPos = GetEnemyHPBarPos(enemy)
    if not SPos then return end
    local barwidth = EPos.x - SPos.x
    local Position = SPos.x + math.max(0, (enemy.health - damage) / enemy.maxHealth * barwidth)

    if Position+damage > EPos.x then
    	damage = EPos.x
    end

    DrawRectangle(math.floor(Position), math.floor(SPos.y - 3), 1, 25, (stacks) > 5 and ARGB(255, 255, 0, 0) or  ARGB(255, 0, 255, 0))
    DrawRectangle(math.floor(Position), math.floor(SPos.y + 0), (damage), 10, (stacks) > 5 and ARGB(50, 255, 0, 0) or  ARGB(50, 0, 255, 0))
  	DrawText("___"..math.floor(stacks), 20, math.floor(Position), math.floor(SPos.y - 20), (stacks) > 5 and ARGB(255, 255, 0, 0) or  ARGB(255, 0, 255, 0))
end

function calculatePassiveDmg(tar)
	if not TargetHaveBuff("twitchdeadlyvenom", tar) then return end
	local dmgPerSec = 6
	if myHero.level < 17 then dmgPerSec = 5 end
	if myHero.level < 13 then dmgPerSec = 4 end
	if myHero.level < 9 then dmgPerSec = 3 end
	if myHero.level < 5 then dmgPerSec = 2 end
	local passiveTime = getPassiveTime(tar, 'twitchdeadlyvenom')--twitchdeadlyvenom
	return (dmgPerSec * PassiveStacks[tar.networkID] * passiveTime) - tar.hpRegen * passiveTime
end

function getPassiveTime(tar, buffName)
	local timer = PassiveApply[tar.networkID] - GetGameTimer()
	if timer > 0 then
		return PassiveApply[tar.networkID] - GetGameTimer()
	else
		return 0
	end
end

function OnUpdateBuff(unit, buff, stacks)
	if buff.name == 'twitchdeadlyvenom' then
	if not PassiveStacks[unit.networkID] then
		PassiveStacks[unit.networkID] = 1 
		elseif PassiveStacks[unit.networkID] and PassiveStacks[unit.networkID] < 6 then
			PassiveStacks[unit.networkID] = PassiveStacks[unit.networkID] + 1
		end
		--print(getDamageE(unit))
		--print(PassiveStacks[unit.networkID])
		PassiveApply[unit.networkID] = GetGameTimer() + 6
	end
end

function OnRemoveBuff(unit,buff)
	if buff.name == 'twitchdeadlyvenom' then
		PassiveStacks[unit.networkID] = 0
		PassiveApply[unit.networkID] = 0
	end	
end

function GetStacks(tar)
	return PassiveStacks[tar.networkID]
end

function OnDraw()
	if myHero:CanUseSpell(_E) == READY then
	 	for k,v in pairs(PassiveStacks) do
 			if v then
 			local target = objManager:GetObjectByNetworkId(k)
 		 		if target and target.valid and target.visible and not target.dead then
 			 	DrawEstacks(target)
 		 		end
 			end
 	 	end
 	end  
end