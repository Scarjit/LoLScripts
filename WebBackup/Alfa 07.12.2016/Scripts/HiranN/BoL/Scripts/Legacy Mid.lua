function OnLoad()
	Print("Loading !")
	DelayAction(function() Basic() end, 3.25)
end

function Print(msg)
	print("<font color=\"#5E9C19\">Legacy Mid ></font><font color=\"#5E9C41\"> "..msg.."</font>")
end

Champions = {
	["Viktor"] = true,
	["TwistedFate"] = true,
}

class 'Basic'
class 'Viktor'
class 'TwistedFate'

-- Viktor: START.
function Viktor:__init()
	UPL:AddSpell(_W, {speed = 2000, delay = 0.25, range = function() if myHero:GetSpellData(_W).name == "ViktorGravitonField" then return 625 else return 812 end end, width = 290, collsion = false, aoe = true, type = "circular"})
	UPL:AddSpell(_E, {speed = 1350, delay = 0.25, range = 1140, width = 40, collsion = false, aoe = true, type = "linear"})
	UPL:AddSpell(_R, {speed = 2000, delay = 0.25, range = 700, width = 290, collsion = false, aoe = true, type = "circular"})
    if myHero:GetSpellData(SUMMONER_1).name:find("SummonerDot") then 
        Ignite = SUMMONER_1
    elseif myHero:GetSpellData(SUMMONER_2).name:find("SummonerDot") then 
        Ignite = SUMMONER_2
    end
	IgniteDamage = 50 + (20 * myHero.level)
	self:Menu()
	self:Callbacks()
end

function Viktor:Menu()
	Menu:addSubMenu("Combo", "Combo")
	Menu.Combo:addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.Combo:addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
	Menu.Combo:addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
	Menu.Combo:addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)

	Menu:addSubMenu("Harass", "Harass")
	Menu.Harass:addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.Harass:addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)

	Menu:addSubMenu("KillSteal", "KS")
    Menu.KS:addSubMenu("Champion Filter", "Filter")
    for _, enemy in pairs(GetEnemyHeroes()) do
        Menu.KS.Filter:addParam(enemy.charName, "Enable Killsteal in : "..enemy.charName, SCRIPT_PARAM_ONOFF, true)
    end
	Menu.KS:addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.KS:addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
	Menu.KS:addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
	if Ignite then
		Menu.KS:addParam("Ignite", "Use Ignite", SCRIPT_PARAM_ONOFF, true)
	end

	ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, 1145, DAMAGE_MAGICAL)
	ts.name = myHero.charName
	Menu:addTS(ts)
	enemyMinions = minionManager(MINION_ENEMY, 855, myHero, MINION_SORT_HEALTH_ASC)
end

function Viktor:Callbacks()
	AddTickCallback(function() self:Ticks() end)
end

function Viktor:Ticks()
	if myHero.dead then 
		return
	end
	ts:update()
	enemyMinions:update()
	Target = ts.target

	self:Combo(Target)
	self:Harass(Target)
	self:KillSteal()
end

function Viktor:GetDamage(spell, target)
	Damage = 0
	if spell and target and ValidTarget(target) then
		if spell == _Q and myHero:CanUseSpell(_Q) == READY then
			return ({60, 80, 100, 120, 140})[myHero:GetSpellData(_Q).level] + 0.4 * myHero.ap
		end
		if spell == _E and myHero:CanUseSpell(_E) == READY then
			return ({70, 110, 150, 190, 230})[myHero:GetSpellData(_E).level] + 0.5 * myHero.ap
		end
		if spell == _R and myHero:CanUseSpell(_R) == READY then
			return ({100, 175, 250})[myHero:GetSpellData(_R).level] + 0.5 * myHero.ap
		end
	end
	return Damage
end

function Viktor:Combo(target)
	if Basic:OrbKey() == 1 and ValidTarget(target) then
		if Menu.Combo.Q then
			self:Q(target)
		end
		if Menu.Combo.W then
			self:W(target)
		end
		if Menu.Combo.E then
			self:E(target)
		end
		if Menu.Combo.R then
			if myHero:CanUseSpell(_R) == READY and target.health <= self:GetDamage(_R, target) then
				self:R(target)
			elseif Ignite and myHero:CanUseSpell(Ignite) == READY and myHero:CanUseSpell(_R) == READY then
				if target.health <= IgniteDamage + self:GetDamage(_R, target) and GetDistance(target) <= 600 then
					self:R(target)
					CastSpell(Ignite, target)
				end
			end
		end
	end
end

function Viktor:Harass(target)
	if Basic:OrbKey() == 2 and ValidTarget(target) then
		if Menu.Harass.Q then
			self:Q(target)
		end
		if Menu.Harass.E then
			self:E(target)
		end
	end
end

function Viktor:KillSteal()
    if myHero.dead then
        return
    end
    for _, enemy in pairs(GetEnemyHeroes()) do
        if Menu.KS.Filter[enemy.charName] then
        	if Menu.KS.Q and enemy.health <= self:GetDamage(_Q, enemy) then
        		self:Q(enemy)
        	end
        	if Menu.KS.E and enemy.health <= self:GetDamage(_E, enemy) then
        		self:E(enemy)
        	end
			if Menu.KS.R and myHero:CanUseSpell(_R) == READY and enemy.health <= self:GetDamage(_R, enemy) then
				self:R(enemy)
			elseif Menu.KS.R and Ignite and myHero:CanUseSpell(Ignite) == READY and myHero:CanUseSpell(_R) == READY then
				if enemy.health <= IgniteDamage + self:GetDamage(_R, enemy) and GetDistance(enemy) <= 600 then
					self:R(enemy)
					CastSpell(Ignite, enemy)
				end
			end
            if Ignite and Menu.KS.Ignite and enemy.health <= IgniteDamage and myHero:CanUseSpell(Ignite) == READY and ValidTarget(enemy) and GetDistance(enemy) <= 600 then
                CastSpell(Ignite, enemy)
            end
        end
    end
end

function Viktor:Q(target)
	if ValidTarget(target) and myHero:CanUseSpell(_Q) == READY then
		if GetDistance(target) <= 600 then
			CastSpell(_Q, target)
		end
	end
end

function Viktor:W(target)
	Range = 0
	if myHero:GetSpellData(_W).name == "ViktorGravitonField" then 
		Range = 625 
	else 
		Range = 812 
	end
	if ValidTarget(target) and myHero:CanUseSpell(_W) == READY then
		if GetDistance(target) <= Range then
        	local CastPosition, HitChance, Position = UPL:Predict(_W, myHero, target)
        	if CastPosition and HitChance > 0 and GetDistance(CastPosition) < Range then
        		CastSpell(_W, CastPosition.x, CastPosition.z)
     		end
		end
	end
end

function Viktor:E(target)
	if ValidTarget(target) and myHero:CanUseSpell(_E) == READY then
		if GetDistance(target) <= 1140 then
			local CastPosition, HitChance, Position = UPL:Predict(_E, myHero, target)
     		if CastPosition and HitChance > 0 and GetDistance(CastPosition) < 1140 then
     			local Initial = Vector(myHero) - 540 * (Vector(myHero) - Vector(target)):normalized()
     			CastSpell3(_E, D3DXVECTOR3(Initial.x, Initial.y, Initial.z), D3DXVECTOR3(CastPosition.x, CastPosition.y, CastPosition.z))
     		end
    	end
	end
end

function Viktor:R(target)
	if ValidTarget(target) and myHero:CanUseSpell(_R) == READY then
		if GetDistance(target) <= 700 then
        	local CastPosition, HitChance, Position = UPL:Predict(_R, myHero, target)
        	if CastPosition and HitChance > 0 and GetDistance(CastPosition) < 700 then
        		CastSpell(_R, CastPosition.x, CastPosition.z)
     		end
		end
	end
end
-- Viktor: END.

-- TwistedFate: START.
function TwistedFate:__init()
	UPL:AddSpell(_Q, {speed = 1000, delay = 0.30, range = 1450, width = 50, collsion = false, aoe = false, type = "linear"})
    if myHero:GetSpellData(SUMMONER_1).name:find("SummonerDot") then 
        Ignite = SUMMONER_1
    elseif myHero:GetSpellData(SUMMONER_2).name:find("SummonerDot") then 
        Ignite = SUMMONER_2
    end
	IgniteDamage = 50 + (20 * myHero.level)
    ToSelectCard = nil
    CardsLost = 0
    RN = 0
	self:Menu()
	self:Callbacks()
end

function TwistedFate:Menu()
	Menu:addSubMenu("Combo", "Combo")
	Menu.Combo:addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.Combo:addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
	Menu.Combo:addParam("WLogic", "W Logic: ", SCRIPT_PARAM_LIST, 1, {"W Logic 1", "W Logic 2", "Only Gold", "Only Red", "Only Blue"})
	if Menu.Combo.WLogic == 1 then
		Menu.Combo:addParam("EnW", "Enemies number to use RED CARD", SCRIPT_PARAM_SLICE, 3, 1, 5, 0)
	end
	Menu.Combo:setCallback("WLogic", function(value)
		if value == 1 then
			Menu.Combo:addParam("EnW", "Enemies number to use RED CARD", SCRIPT_PARAM_SLICE, 3, 1, 5, 0)
		elseif value ~= 1 then
			Menu.Combo:removeParam("EnW")
		end
	end)
	Menu:addSubMenu("Harass", "Harass")
	Menu.Harass:addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)

	Menu:addSubMenu("LaneClear", "Laneclear")
	Menu.Laneclear:addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.Laneclear:addParam("W", "Use W Logic", SCRIPT_PARAM_ONOFF, true)
	Menu.Laneclear:addParam("Qm", "Mana % to stop using Q", SCRIPT_PARAM_SLICE, 50, 1, 100, 0)
	Menu.Laneclear:addParam("Wm", "Mana % to pick Blue Card", SCRIPT_PARAM_SLICE, 40, 1, 100, 0)

	Menu:addSubMenu("JungleClear", "Jungleclear")
	Menu.Jungleclear:addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Menu.Jungleclear:addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
	Menu.Jungleclear:addParam("WLogic", "W Logic: ", SCRIPT_PARAM_LIST, 1, {"W Logic", "Only Gold", "Only Red", "Only Blue"})
	Menu.Jungleclear:addParam("Qm", "Mana % to stop using Q", SCRIPT_PARAM_SLICE, 25, 1, 100, 0)
	Menu.Jungleclear:addParam("Wm", "Mana % to pick Blue Card", SCRIPT_PARAM_SLICE, 35, 1, 100, 0)

	Menu:addSubMenu("KillSteal", "KS")
    Menu.KS:addSubMenu("Champion Filter", "Filter")
    for _, enemy in pairs(GetEnemyHeroes()) do
        Menu.KS.Filter:addParam(enemy.charName, "Enable Killsteal in : "..enemy.charName, SCRIPT_PARAM_ONOFF, true)
    end
	Menu.KS:addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
	if Ignite then
		Menu.KS:addParam("Ignite", "Use Ignite", SCRIPT_PARAM_ONOFF, true)
	end

	Menu:addSubMenu("Card Picker", "CP")
	Menu.CP:addParam("Yellow", "Yellow Card Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("W"))
	Menu.CP:addParam("Red", "Red Card Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("E"))
	Menu.CP:addParam("Blue", "Blue Card Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("T"))
    Menu.CP:addParam("R", "Select Gold Card in Ultimate", SCRIPT_PARAM_ONOFF, true)
    MenuDraw:addParam("DrawCL", "Draw Card Lost", SCRIPT_PARAM_ONOFF, true)

	ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, 1450, DAMAGE_MAGICAL)
	ts.name = myHero.charName
	Menu:addTS(ts)
	enemyMinions = minionManager(MINION_ENEMY, 855, myHero, MINION_SORT_HEALTH_ASC)
	jungleMinions = minionManager(MINION_JUNGLE, 855, myHero, MINION_SORT_HEALTH_ASC)
end

function TwistedFate:Callbacks()
	AddTickCallback(function() self:Ticks() end)
	AddTickCallback(function() self:CPTicks() end)
	AddDrawCallback(function() self:Draws() end)
    AddApplyBuffCallback(function(Src, Target, Buff) self:OnApplyBuff(Src, Target, Buff) end)
	AddCastSpellCallback(function(iSpell, startPos, endPos, targetUnit) self:OnCastSpell(iSpell, startPos, endPos, targetUnit) end)
end

function TwistedFate:Ticks()
	if myHero.dead then 
		return
	end
	ts:update()
	enemyMinions:update()
	jungleMinions:update()
	Target = ts.target

	self:Combo(Target)
	self:Harass(Target)
	self:LaneClear()
	self:KillSteal()
end

function TwistedFate:CPTicks()
	if myHero.dead then
		ToSelectCard = nil
		return
	end
    if myHero:CanUseSpell(_W) == READY then
        if Menu.CP.Yellow then
            ToSelectCard = "Gold"
        end
        if Menu.CP.Red then
            ToSelectCard = "Red"
        end
        if Menu.CP.Blue then
            ToSelectCard = "Blue"
        end
    end
	if myHero:CanUseSpell(_W) == READY then
		if ToSelectCard ~= nil and myHero:GetSpellData(_W).name == "PickACard" then
			CastSpell(_W)
		end
		if ToSelectCard ~= nil and myHero:GetSpellData(_W).name:find(ToSelectCard) then
			CastSpell(_W)
		end
	end
    if myHero:GetSpellData(_W).currentCd >= 1 then
        ToSelectCard = nil
    end
end

function TwistedFate:OnApplyBuff(Src, Target, Buff)
    if Target and Target.valid and Target.isMe and ToSelectCard ~= nil and Buff.name:find("CardPreAttack") and not Buff.name:find(ToSelectCard) then
        CardsLost = CardsLost + 1
    end
end

function TwistedFate:OnCastSpell(iSpell, startPos, endPos, targetUnit)
    if iSpell == 3 then
        RN = RN + 1
        if Menu.CP.R and RN >= 2 and myHero:CanUseSpell(_W) == READY then
            ToSelectCard = "Gold"
            RN = 0
        end
    end
end

function TwistedFate:Draws()
    if MenuDraw.DrawCL then
        DrawText3D("Lost Cards: "..CardsLost, myHero.x, myHero.y + 30, myHero.z, 13, 0xFFFFFFFF)
    end
end

function TwistedFate:GetDamage(spell, target)
	Damage = 0
	if spell and target and ValidTarget(target) then
		if spell == _Q and myHero:CanUseSpell(_Q) == READY then
			return ({60, 80, 100, 120, 140})[myHero:GetSpellData(_Q).level] + 0.4 * myHero.ap
		end
		if spell == BLUE then
			return ({40, 60, 80, 100, 120})[myHero:GetSpellData(_W).level] + myHero.totalDamage + 0.5 * myHero.ap
		end
	end
	return Damage
end

function TwistedFate:Combo(target)
	if Basic:OrbKey() == 1 and ValidTarget(target) then
		if Menu.Combo.Q then
			self:Q(target)
		end

		if Menu.Combo.W and myHero:CanUseSpell(_W) == READY and ToSelectCard == nil and GetDistance(target) <= myHero.range + 110 then
			if Menu.Combo.WLogic == 1 then
				if self:GetDamage(Blue) > target.health then
					ToSelectCard = "Blue"
				elseif CountEnemyHeroInRange(200, enemy) >= Menu.Combo.EnW then
					ToSelectCard = "Red"
				else
					ToSelectCard = "Gold"
				end
			elseif Menu.Combo.WLogic == 2 then
				if self:GetDamage(Blue) > target.health then
					ToSelectCard = "Blue"
				else
					ToSelectCard = "Gold"
				end
			elseif Menu.Combo.WLogic == 3 then
				ToSelectCard = "Gold"
			elseif Menu.Combo.WLogic == 4 then
				ToSelectCard = "Red"
			elseif Menu.Combo.WLogic == 5 then
				ToSelectCard = "Blue"
			end
		end
	end
end

function TwistedFate:Harass(target)
	if Basic:OrbKey() == 2 and ValidTarget(target) then
		if Menu.Harass.Q then
			self:Q(target)
		end
	end
end

function TwistedFate:LaneClear()
	if Basic:OrbKey() == 3 then
		local QManaL = myHero.mana < (myHero.maxMana * ( Menu.Laneclear.Qm / 100))
		local WManaL = myHero.mana < (myHero.maxMana * ( Menu.Laneclear.Wm / 100))
		local QManaJ = myHero.mana < (myHero.maxMana * ( Menu.Jungleclear.Qm / 100))
		local WManaJ = myHero.mana < (myHero.maxMana * ( Menu.Jungleclear.Wm / 100))
		for i, minion in pairs(enemyMinions.objects) do
			if Menu.Laneclear.Q and myHero:CanUseSpell(_Q) == READY and not QManaL then
				local BestMinion = self:GetBestQ()
				self:Q(BestMinion)
			end
			if Menu.Laneclear.W and myHero:CanUseSpell(_W) == READY and ToSelectCard == nil then
				if WManaL then
					ToSelectCard = "Blue"
				else
					ToSelectCard = "Red"
				end
			end
		end
		for i, minion in pairs(jungleMinions.objects) do
			if Menu.Jungleclear.Q and myHero:CanUseSpell(_Q) == READY and not QManaJ then
				self:Q(minion)
			end
			if Menu.Jungleclear.W and myHero:CanUseSpell(_W) == READY and ToSelectCard == nil then
				if Menu.Jungleclear.WLogic == 1 then
					if WManaJ then
						ToSelectCard = "Blue"
					else
						ToSelectCard = "Red"
					end
				elseif Menu.Jungleclear.WLogic == 2 then
					ToSelectCard = "Gold"
				elseif Menu.Jungleclear.WLogic == 3 then
					ToSelectCard = "Red"
				elseif Menu.Jungleclear.WLogic == 4 then
					ToSelectCard = "Blue"
				end
			end
		end
	end
end

function TwistedFate:GetBestQ()
	local HitQ = 0 
	local BestQ
	for i, minion in pairs(enemyMinions.objects) do
		local Hits = self:CountMaxHit(minion)
		if Hits > HitQ or BestQ == nil then
			BestQ = minion
			HitQ = Hits
		end
	end
	return BestQ
end

function TwistedFate:CountMaxHit(pos)
	local HitNumber = 0
	local ExtendedVector = Vector(myHero) + Vector(Vector(pos) - Vector(myHero)):normalized() * 1145
	local EndPoint = Vector(myHero) + ExtendedVector
	for i, minion in ipairs(enemyMinions.objects) do
		local MinionPointSegment, MinionPointLine, MinionIsOnSegment =  VectorPointProjectionOnLineSegment(Vector(myHero), Vector(EndPoint), Vector(minion)) 
		local MinionPointSegment3D = {x = MinionPointSegment.x, y = pos.y, z = MinionPointSegment.y}
		if MinionIsOnSegment and GetDistance(MinionPointSegment3D, pos) < 40 then
			HitNumber = HitNumber + 1
		end
	end
	return HitNumber
end

function TwistedFate:KillSteal()
    if myHero.dead then
        return
    end
    for _, enemy in pairs(GetEnemyHeroes()) do
        if Menu.KS.Filter[enemy.charName] then
        	if Menu.KS.Q and enemy.health <= self:GetDamage(_Q, enemy) then
        		self:Q(enemy)
        	end
			if Menu.KS.Q and myHero:CanUseSpell(_Q) == READY and enemy.health <= self:GetDamage(_Q, enemy) then
				self:Q(enemy)
			elseif Menu.KS.Q and Ignite and myHero:CanUseSpell(Ignite) == READY and myHero:CanUseSpell(_Q) == READY then
				if enemy.health <= IgniteDamage + self:GetDamage(_Q, enemy) and GetDistance(enemy) <= 600 then
        			local CastPosition, HitChance, Position = UPL:Predict(_Q, myHero, target)
        			if CastPosition and HitChance > 0 then
        				CastSpell(_Q, CastPosition.x, CastPosition.z)
        				CastSpell(Ignite, enemy)
     				end
				end
			end
            if Ignite and Menu.KS.Ignite and enemy.health <= IgniteDamage and myHero:CanUseSpell(Ignite) == READY and ValidTarget(enemy) and GetDistance(enemy) <= 600 then
                CastSpell(Ignite, enemy)
            end
        end
    end
end

function TwistedFate:Q(target)
	if ValidTarget(target) and myHero:CanUseSpell(_Q) == READY then
        local CastPosition, HitChance, Position = UPL:Predict(_Q, myHero, target)
        if CastPosition and HitChance > 0 then
        	CastSpell(_Q, CastPosition.x, CastPosition.z)
		end
	end
end
-- TwistedFate: END.

-- Basic: START.
function Basic:__init()
	MenuSpace = scriptConfig("                              [Legacy Mid]", "Legacy")
	if Champions[myHero.charName] then
		Menu = scriptConfig("Legacy Mid: "..myHero.charName, "Legacy"..myHero.charName)
		MenuDraw = scriptConfig("Draws", "DrawsLegacy"..myHero.charName)
		MenuDraw:addParam("On", "Disable All Draws", SCRIPT_PARAM_ONOFF, false)
		MenuDraw:addParam("AA", "Enable AA Range", SCRIPT_PARAM_ONOFF, true)
		MenuDraw:addParam("Waypoints", "Enable Enemy Waypoints", SCRIPT_PARAM_ONOFF, true)
		self:OrbWalkers()
		self:Predictions()
		AddDrawCallback(function() self:Draw() end)
		Print("Loaded.")
	else
		Print("Champion not supported.")
		Print("Loading : Skin Changer, Auto Leveler.")
	end

	-- Skin Changer : START.
	MenuSkin = scriptConfig("SkinChanger", "SkinLegacy"..myHero.charName)
	MenuSkin:addParam("ChangeSkin", "Enable Skin Changer", SCRIPT_PARAM_ONOFF, false)
	MenuSkin:setCallback('ChangeSkin', function(Change)
		if Change then
			SetSkin(myHero, MenuSkin.SkinID - 1)
		else
			SetSkin(myHero, - 1)
		end
	end)
	MenuSkin:addParam('SkinID', 'Skins', SCRIPT_PARAM_LIST, 1, {"Classic","2","3","4","5","6","7","8","9","10","11","12","13","14","15"})
	MenuSkin:setCallback('SkinID', function(Change)
		if MenuSkin.ChangeSkin then
			SetSkin(myHero, MenuSkin.SkinID - 1)
		end
	end)
    
	if MenuSkin.ChangeSkin then
		SetSkin(myHero, MenuSkin.SkinID - 1)
	end
	-- Skin Changer : END

	-- Auto Leveler : START.
	LastSpell = 0
	MenuLvl = scriptConfig("Auto Leveler", "LevelerLegacy"..myHero.charName)
	MenuLvl:addParam("On", "Enable Auto Leveler", SCRIPT_PARAM_ONOFF, false)
	-- Auto Leveler : END.
	MenuSpace1 = scriptConfig("                              [Legacy Mid]", "Legacy")

	AddTickCallback(function() self:Tick() end)
	AddUnloadCallback(function() SetSkin(myHero, - 1) end)
	self:Update()
end

function Basic:Tick()
	if os.clock() - LastSpell >= 3.5 then
		LastSpell = os.clock() 
		if MenuLvl.On then
			autoLevelSetSequence(LvLSequence[myHero.charName])
		elseif not MenuLvl.On then
			autoLevelSetSequence(nil)
		end
	end
end

function Basic:Draw()
	if not MenuDraw.On and not myHero.dead then
		if MenuDraw.AA then
			DrawCircle(myHero.x, myHero.y, myHero.z, myHero.range + 65, ARGB(100, 0, 252, 255))
		end
		if MenuDraw.Waypoints then
			--By Sida.
    		for _, enemy in pairs(GetEnemyHeroes()) do
    			if enemy and enemy.path.count > 1 then
      				for j = enemy.path.curPath, enemy.path.count do
        				local p1 = j == enemy.path.curPath and enemy or enemy.path:Path(j-1)
        				local p2 = enemy.path:Path(j)
        				DrawLine3D(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z, 1, 0xFFFFFFFF)
        				DrawText3D(enemy.charName, p2.x, p2.y, p2.z, 11, 0xFFFFFFFF)
        			end
    			end
    		end
    		--
		end
	end
end

function Basic:OrbWalkers()
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
		MenuOrb = scriptConfig("OrbWalkers", "OrbLegacy"..myHero.charName)
        MenuOrb:addSubMenu("Select Orbwalker", "Select")
        MenuOrb:addSubMenu("Keys", "Keys")
        MenuOrb.Select:addParam("Orbwalker", "OrbWalker", SCRIPT_PARAM_LIST, 1, OrbWalkers)
        MenuOrb.Keys:addParam("info", "Detecting keys from: "..OrbWalkers[MenuOrb.Select.Orbwalker], SCRIPT_PARAM_INFO, "")
        MenuOrb.Select:setCallback("Orbwalker", function(value)
            if OrbAlr then 
                return 
            end
            OrbAlr = true
            MenuOrb:addParam("info", "Press F9 2x to load your selected Orbwalker", SCRIPT_PARAM_INFO, "")
            Print("Press F9 2x to load your selected Orbwalker.")
        end)
        LoadedOrb = OrbWalkers[MenuOrb.Select.Orbwalker]
  		if LoadedOrb == "NOW" then
            require "Nebelwolfi's Orb Walker"
            _G.NOWi = NebelwolfisOrbWalkerClass()	
        elseif LoadedOrb == "Big Fat Walk" then
            require "Big Fat Orbwalker"
        elseif LoadedOrb == "SOW" then
            require "SOW"
            MenuOrb:addSubMenu("SOW", "SOW")
            _G.SOWi = SOW(_G.VP)
            SOW:LoadToMenu(MenuOrb.SOW)
        elseif LoadedOrb == "SxOrbWalk" then
            require "SxOrbWalk"
            MenuOrb:addSubMenu("SxOrbWalk", "SxOrbWalk")
            SxOrb:LoadToMenu(MenuOrb.SxOrbWalk)
        elseif LoadedOrb == "S1mpleOrbWalker" then
            require "S1mpleOrbWalker"
            S1 = S1mpleOrbWalker()
            MenuOrb:addSubMenu("S1mpleOrbWalker", "S1mpleOrbWalker")
            S1:AddToMenu(MenuOrb.S1mpleOrbWalker)
        end
  		DelayAction(function() TIMEFORSAC = true end, 10)
	end
end

function Basic:OrbKey()
	--[[
	1 = Combo. 
	2 = Harass.
	3 = LaneClear.
	4 = LastHit.
	]]
	if LoadedOrb == "SAC" and TIMEFORSAC then
		if _G.AutoCarry.Keys.AutoCarry then 
			return 1
		end
		if _G.AutoCarry.Keys.MixedMode then 
			return 2
		end
		if _G.AutoCarry.Keys.LaneClear then 
			return 3
		end
		if _G.AutoCarry.Keys.LastHit then 
			return 4
		end
	elseif LoadedOrb == "MMA" then
		if _G.MMA_IsOrbwalking() then 
			return 1
		end
		if _G.MMA_IsDualCarrying() then 
			return 2
		end
		if _G.MMA_IsLaneClearing() then 
			return 3
		end
		if _G.MMA_IsLastHitting() then 
			return 4
		end
	elseif LoadedOrb == "Pewalk" then
		if _G._Pewalk.GetActiveMode().Carry then 
			return 1
		end
		if _G._Pewalk.GetActiveMode().Mixed then 
			return 2
		end
		if _G._Pewalk.GetActiveMode().LaneClear then 
			return 3
		end
		if _G._Pewalk.GetActiveMode().Farm then 
			return 4
		end
	elseif LoadedOrb == "NOW" then
		if _G.NOWi.mode == "Combo" then 
			return 1
		end
		if _G.NOWi.mode == "Harass" then 
			return 2
		end
		if _G.NOWi.mode == "LaneClear" then 
			return 3
		end
		if _G.NOWi.mode == "LastHit" then 
			return 4
		end
	elseif LoadedOrb == "Big Fat Walk" then
		if _G["BigFatOrb_Mode"] == "Combo" then 
			return 1
		end
		if _G["BigFatOrb_Mode"] == "Harass" then 
			return 2
		end
		if _G["BigFatOrb_Mode"] == "LaneClear" then 
			return 3
		end
		if _G["BigFatOrb_Mode"] == "LastHit" then 
			return 4
		end
	elseif LoadedOrb == "SOW" then
		if _G.SOWi.Menu.Mode0 then 
			return 1
		end
		if _G.SOWi.Menu.Mode1 then 
			return 2
		end
		if _G.SOWi.Menu.Mode2 then 
			return 3
		end
		if _G.SOWi.Menu.Mode3 then 
			return 4
		end
	elseif LoadedOrb == "SxOrbWalk" then
		if _G.SxOrb.isFight then 
			return 1
		end
		if _G.SxOrb.isHarass then 
			return 2
		end
		if _G.SxOrb.isLaneClear then 
			return 3
		end
		if _G.SxOrb.isLastHit then 
			return 4
		end
	elseif LoadedOrb == "S1mpleOrbWalker" then
		if S1.aamode == "sbtw" then 
			return 1
		end
		if S1.aamode == "harass" then 
			return 2
		end
		if S1.aamode == "laneclear" then 
			return 3
		end
		if S1.aamode == "lasthit" then 
			return 4
		end
	end
end

function Basic:Predictions()
	if not FileExist(LIB_PATH .. "/UPL.lua") then 
		DelayAction(function() DownloadFile("https://raw.githubusercontent.com/nebelwolfi/BoL/master/Common/UPL.lua".."?rand="..math.random(1,10000), LIB_PATH.."VPrediction.lua", 
			function()
				self:InitUPL()
			end)
		end, 3)
	else
		self:InitUPL()
	end
end

function Basic:InitUPL()
	require "UPL"
	UPL = UPL()
	MenuPred = scriptConfig("Predictions", "PredLegacy"..myHero.charName)
	UPL:AddToMenu(MenuPred)
	_ENV[myHero.charName]()
end

function Basic:Update()
	self.Version = 0.10
    local host = "s1mplescripts.de"
    local ServerVersionDATA = GetWebResult(host, "/HiranN/BoL/Versions/Legacy%20Mid.version")  
    local ServerVersion = tonumber(ServerVersionDATA)
    if ServerVersionDATA then
        if ServerVersion then
            if ServerVersion > tonumber(self.Version) then
				AddDownload("s1mplescripts.de","/HiranN/BoL/Scripts/Legacy%20Mid.lua", SCRIPT_PATH.._ENV.FILE_NAME, 80, {}, {{key = "afterdltext", value = "(Press 2x F9 to RELOAD) Legacy Mid Updated to Version: "..ServerVersionDATA}})
			end
		end
	end
end
-- Basic: END.

LvLSequence = {
	["Kled"] = {1,2,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
	["Taliyah"] = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
	["AurelionSol"] = {2,1,3,2,2,4,2,1,2,1,4,1,1,3,3,4,3,3},
	["Shyvana"] = {2,1,3,2,2,4,2,1,2,1,4,1,1,3,3,4,3,3},
	["Gragas"] = {1,2,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
	["JarvanIV"] = {3,1,2,1,1,4,2,3,1,3,4,1,2,2,3,4,3,2},
	["Irelia"] = {2,3,1,2,2,4,3,3,2,1,4,2,3,1,1,4,3,1},
	["Garen"] = {1,3,3,2,3,4,3,1,3,1,4,1,1,2,2,4,2,2},
	["Gnar"] = {1,2,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
	["Aatrox"] = {2,1,2,3,2,4,2,1,2,1,4,1,1,3,3,4,3,3},
	["Amumu"] = {2,3,1,2,2,4,2,3,2,3,4,3,3,1,1,4,1,1},
	["Nunu"] = {1,2,3,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
	["Fiddlesticks"] = {2,3,2,1,1,4,1,3,1,3,4,1,2,3,2,4,3,2},
	["Teemo"] = {3,1,2,1,1,4,3,3,2,3,4,1,1,3,2,4,2,2},
	["ChoGath"] = {1,2,3,1,1,4,1,1,2,2,4,2,3,2,3,4,3,3},
	["Darius"] = {1,2,3,1,1,4,1,2,1,2,4,3,2,2,3,4,3,3},
	["DrMundo"] = {1,3,2,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
	["Elise"] = {2,1,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
	["Evelynn"] = {1,3,2,1,1,4,3,1,3,1,4,3,3,2,2,4,2,2},
	["Fiora"] = {2,3,1,2,2,4,2,1,2,1,4,1,1,3,3,4,3,3},
	["Gangplank"] = {1,2,2,3,2,4,2,1,2,1,4,1,1,3,3,4,3,3},
	["Hecarim"] = {1,2,3,1,1,4,3,1,3,1,4,3,3,2,2,4,2,2},
	["Jax"] = {2,3,1,1,1,4,3,2,3,2,4,2,1,1,3,4,2,3},
	["Jayce"] = {1,3,1,2,1,2,1,2,1,2,1,2,2,3,3,3,3,3},
	["Ahri"] = {1,3,2,1,1,4,1,2,1,2,4,2,3,2,3,4,3,3},
	["Akali"] = {1,2,1,3,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
	["Anivia"] = {1,3,3,1,3,4,3,2,3,2,4,2,2,2,1,4,1,1},
	["Annie"] = {1,2,1,3,1,4,1,1,2,2,4,2,2,3,3,4,3,3},
	["Azir"] = {2,1,3,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
	["Brand"] = {2,1,3,2,2,4,2,1,2,1,4,1,1,3,3,4,3,3},
	["Cassiopeia"] = {3,1,2,3,3,4,1,1,3,3,4,1,1,2,2,4,2,2},
	["Orianna"] = {3,1,2,1,1,4,2,1,3,1,4,2,3,2,2,4,3,3},
	["Lux"] = {3,1,2,3,3,4,1,2,3,1,4,2,3,1,1,4,2,2},
	["Diana"] = {2,1,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
	["Ekko"] = {2,1,3,1,1,4,2,2,1,2,4,1,2,3,3,4,3,3},
	["Ezreal"] = {1,2,3,1,1,4,2,2,1,3,4,1,2,2,3,4,3,3},
	["Fizz"] = {2,1,3,2,2,4,3,2,1,2,4,1,1,3,1,4,3,3},
	["Galio"] = {1,2,3,1,1,4,1,2,1,2,4,2,3,2,3,4,3,3},
	["Heimerdinger"] = {1,2,3,1,1,4,2,2,2,1,4,1,2,3,3,4,3,3},
	["Ashe"] = {2,1,3,2,2,4,1,2,1,2,4,1,1,3,3,4,3,3},
	["Kalista"] = {3,1,3,2,3,4,3,1,3,1,4,1,1,2,2,4,2,2},
	["Graves"] = {1,2,3,1,1,4,3,1,3,1,4,3,3,2,2,4,2,2},
	["Caitlyn"] = {1,3,1,2,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
	["Vayne"] = {2,1,3,2,2,4,1,2,2,1,4,1,1,3,3,4,3,3},
	["MissFortune"] = {1,2,3,1,2,4,1,1,2,1,4,2,2,3,3,4,3,3},
	["Corki"] = {1,2,3,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
	["Draven"] = {1,2,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
	["Jinx"] = {1,2,3,1,1,4,2,1,2,1,4,2,2,3,3,4,3,3},
	["Leona"] = {1,3,2,2,2,4,2,1,2,1,4,1,1,3,3,4,3,3},
	["Alistar"] = {1,2,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
	["Janna"] = {3,1,3,2,3,4,3,2,3,2,4,2,2,1,1,4,1,1},
	["Braum"] = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
	["Bard"] = {1,2,3,1,1,4,2,1,1,2,4,2,2,3,3,4,3,3},
	["Blitzcrank"] = {1,3,2,1,1,4,2,1,3,1,4,2,2,2,3,4,3,3},
	["Morgana"] = {2,1,3,2,2,4,1,1,3,1,4,1,2,2,3,4,3,3},
	["Soraka"] = {1,2,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
	["Karma"] = {1,3,1,2,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
	["Karthus"] = {1,3,1,2,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
	["Kassadin"] = {2,1,3,3,2,4,1,1,3,1,4,2,1,2,3,4,3,2},
	["Katarina"] = {1,2,3,1,1,4,2,2,1,2,4,1,2,3,3,4,3,3},
	["Kayle"] = {3,2,1,3,3,4,3,1,3,1,4,1,1,2,2,4,2,2},
	["Kennen"] = {1,2,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
	["KhaZix"] = {1,3,2,1,1,4,1,1,3,3,4,3,3,2,2,4,2,2},
	["KogMaw"] = {2,3,3,1,3,4,3,2,3,2,4,2,2,1,1,4,1,1},
	["Leblanc"] = {2,1,3,2,1,4,2,2,1,3,4,2,1,1,3,4,3,3},
	["LeeSin"] = {1,2,3,1,1,4,1,3,1,3,4,2,2,2,2,4,3,3},
	["Riven"] = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
	["Viktor"] = {1,3,3,2,3,4,3,1,3,1,4,1,2,1,2,4,2,2},
	["Lissandra"] = {1,3,2,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
	["Lucian"] = {1,3,2,1,1,4,1,2,1,3,4,3,2,3,2,4,2,3},
	["Lulu"] = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
	["MasterYi"] = {1,2,3,1,1,4,3,1,3,1,4,3,3,2,2,4,2,2},
	["Malphite"] = {3,2,1,3,3,4,3,1,3,1,4,1,1,2,2,4,2,2},
	["Malzahar"] = {3,2,1,3,3,4,1,3,2,3,4,2,2,1,1,4,1,2},
	["Maokai"] = {3,1,2,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
	["Mordekaiser"] = {3,2,3,2,1,4,3,1,3,2,4,2,2,3,1,4,1,1},
	["Nami"] = {1,2,3,2,2,4,2,3,2,1,4,3,3,3,1,4,1,1},
	["Nasus"] = {1,2,3,1,1,4,3,1,2,1,4,3,3,2,3,4,2,2},
	["Nautilus"] = {3,1,2,3,3,4,3,2,3,2,4,2,2,1,1,4,1,1},
	["Nidalee"] = {1,3,2,1,1,4,3,1,1,3,4,3,3,2,2,4,2,2},
	["Nocturne"] = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
	["Olaf"] = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
	["Pantheon"] = {1,2,3,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
	["Poppy"] = {1,3,2,1,1,4,2,1,3,1,4,2,2,2,3,4,3,3},
	["Quinn"] = {1,3,2,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
	["Rammus"] = {2,1,3,3,2,4,3,3,3,2,4,2,2,1,1,4,1,1},
	["RekSai"] = {2,1,3,2,1,4,1,1,2,1,4,3,2,2,3,4,2,3},
	["Renekton"] = {2,3,1,1,1,4,1,3,1,3,4,3,2,3,2,4,2,2},
	["Rengar"] = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
	["Rumble"] = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
	["Ryze"] = {1,2,3,1,1,4,2,1,2,1,4,3,2,3,2,4,3,3},
	["Sejuani"] = {2,3,1,2,2,4,2,3,2,3,4,3,3,1,1,4,1,1},
	["Shaco"] = {2,3,1,3,3,4,3,2,3,2,4,2,2,1,1,4,1,1},
	["Shen"] = {1,3,1,2,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
	["Singed"] = {1,3,1,3,1,4,1,2,1,3,4,3,3,2,2,4,2,2},
	["Sion"] = {1,2,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
	["Sivir"] = {1,3,2,1,1,4,3,2,1,2,4,1,2,2,3,4,3,3},
	["Skarner"] = {1,2,1,3,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
	["Sona"] = {1,2,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
	["Swain"] = {2,3,3,1,3,4,3,1,3,1,4,1,1,2,2,4,2,2},
	["Syndra"] = {1,3,1,2,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
	["TahmKench"] = {1,2,3,2,2,4,2,1,2,1,4,1,1,3,3,4,3,3},
	["Talon"] = {2,3,2,1,2,4,2,1,2,1,4,1,1,3,3,4,3,3},
	["Taric"] = {3,1,2,3,3,4,3,2,3,2,4,2,2,1,1,4,1,1},
	["Teemo"] = {3,1,2,1,3,4,1,3,1,3,4,3,1,2,2,4,2,2},
	["Thresh"] = {3,1,2,3,3,4,3,1,3,1,4,1,1,2,2,4,2,2},
	["Tristana"] = {3,1,2,1,1,4,3,1,3,1,4,3,3,2,2,4,2,2},
	["Trundle"] = {1,2,1,3,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
	["Tryndamere"] = {3,1,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
	["TwistedFate"] = {2,1,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
	["Twitch"] = {3,2,3,1,3,4,3,1,3,1,4,1,1,2,2,4,2,2},
	["Udyr"] = {4,2,4,3,4,2,4,2,4,3,2,3,2,3,3,1,1,1},
	["Urgot"] = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
	["Zed"] = {1,2,3,1,1,4,1,3,2,1,4,3,3,2,3,4,2,2},
	["Varus"] = {1,2,3,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
	["Veigar"] = {1,2,3,2,2,4,1,2,3,1,4,2,1,1,3,4,3,3},
	["VelKoz"] = {2,3,1,2,2,4,2,1,2,1,4,1,1,3,3,4,3,3},
	["Vi"] = {2,3,1,1,1,4,1,2,3,1,4,3,2,3,2,4,2,3},
	["Viktor"] = {1,3,3,2,3,4,3,1,3,1,4,1,2,1,2,4,2,2},
	["Vladimir"] = {1,2,1,3,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
	["Volibear"] = {3,2,1,2,2,4,2,3,2,3,4,3,3,1,1,4,1,1},
	["Warwick"] = {2,1,3,1,2,4,2,1,2,1,4,2,1,3,3,4,3,3},
	["MonkeyKing"] = {3,1,2,3,3,4,3,1,3,1,4,1,1,2,2,4,2,2},
	["Xerath"] = {1,2,3,1,1,4,2,1,2,1,4,2,2,3,3,4,3,3},
	["XinZhao"] = {1,2,3,1,1,4,2,1,2,1,4,2,2,3,3,4,3,3},
	["Yasuo"] = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
	["Yorick"] = {3,2,3,1,3,4,3,2,3,2,4,2,2,1,1,4,1,1},
	["Zac"] = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
	["Ziggs"] = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},  
	["Zyra"] = {3,1,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},  
	["Zilean"] = {1,2,1,3,1,4,1,3,1,3,4,3,2,3,2,4,2,2},
	["Kindred"] = {1,2,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3},
	["Illaoi"] = {1,2,3,2,2,4,2,1,2,1,4,1,1,3,3,4,3,3},
	["Jhin"] = {1,2,3,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2},
}

-- Updater --
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
			DrawTextA((self.nicename or self.localpath).. " downloaded",12, self.pos_x+3,self.pos_y-12)
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

--[[
	API:
		AddDownload(server, server_path, localpath, port, data (table), options)

	Usage Example:
		AddDownload("s1mplescripts.de","/S1mple/Scripts/BolStudio/Syndra/S1mple_Syndra.lua", SPRITE_PATH.."test.lua", 80, {}, {{key = "nicename", value = "S1mple_Syndra"}})
		AddDownload("ddragon.leagueoflegends.com","/cdn/dragontail-6.18.1.tgz", SPRITE_PATH.."test2.tgz", 80, {}, {{key = "nicename", value = "DDragon"}})

	Made by:
	S1mple (https://forum.botoflegends.com/user/494545-)
--]]

-- Updater --

-- START: BOL TOOLS.
assert(load(Base64Decode("G0x1YVIAAQQEBAgAGZMNChoKAAAAAAAAAAAAAQpQAAAABAAAAEYAQAClAAAAXUAAAUZAQAClQAAAXUAAAWWAAAAIQACBZcAAAAhAgIFLAAAAgQABAMZAQQDHgMEBAQEBAKGACoCGQUEAjMFBAwACgAKdgYABmwEAABcACYDHAUID2wEAABdACIDHQUIDGIDCAxeAB4DHwUIDzAHDA0FCAwDdgYAB2wEAABdAAoDGgUMAx8HDAxgAxAMXgACAwUEEANtBAAAXAACAwYEEAEqAgQMXgAOAx8FCA8wBwwNBwgQA3YGAAdsBAAAXAAKAxoFDAMfBwwMYAMUDF4AAgMFBBADbQQAAFwAAgMGBBABKgIEDoMD0f4ZARQDlAAEAnUAAAYaARQDBwAUAnUAAAYbARQDlQAEAisAAjIbARQDlgAEAisCAjIbARQDlwAEAisAAjYbARQDlAAIAisCAjR8AgAAcAAAABBIAAABBZGRVbmxvYWRDYWxsYmFjawAEFAAAAEFkZEJ1Z3NwbGF0Q2FsbGJhY2sABAwAAABUcmFja2VyTG9hZAAEDQAAAEJvbFRvb2xzVGltZQADAAAAAAAA8D8ECwAAAG9iak1hbmFnZXIABAsAAABtYXhPYmplY3RzAAQKAAAAZ2V0T2JqZWN0AAQGAAAAdmFsaWQABAUAAAB0eXBlAAQHAAAAb2JqX0hRAAQFAAAAbmFtZQAEBQAAAGZpbmQABAIAAAAxAAQHAAAAbXlIZXJvAAQFAAAAdGVhbQADAAAAAAAAWUAECAAAAE15TmV4dXMABAsAAABUaGVpck5leHVzAAQCAAAAMgADAAAAAAAAaUAEFQAAAEFkZERlbGV0ZU9iakNhbGxiYWNrAAQGAAAAY2xhc3MABA4AAABTY3JpcHRUcmFja2VyAAQHAAAAX19pbml0AAQSAAAAU2VuZFZhbHVlVG9TZXJ2ZXIABAoAAABzZW5kRGF0YXMABAsAAABHZXRXZWJQYWdlAAkAAAACAAAAAwAAAAAAAwkAAAAFAAAAGABAABcAAIAfAIAABQAAAAxAQACBgAAAHUCAAR8AgAADAAAAAAQSAAAAU2VuZFZhbHVlVG9TZXJ2ZXIABAcAAAB1bmxvYWQAAAAAAAEAAAABAAAAAAAAAAAAAAAAAAAAAAAEAAAABQAAAAAAAwkAAAAFAAAAGABAABcAAIAfAIAABQAAAAxAQACBgAAAHUCAAR8AgAADAAAAAAQSAAAAU2VuZFZhbHVlVG9TZXJ2ZXIABAkAAABidWdzcGxhdAAAAAAAAQAAAAEAAAAAAAAAAAAAAAAAAAAAAAUAAAAHAAAAAQAEDQAAAEYAwACAAAAAXYAAAUkAAABFAAAATEDAAMGAAABdQIABRsDAAKUAAADBAAEAXUCAAR8AgAAFAAAABA4AAABTY3JpcHRUcmFja2VyAAQSAAAAU2VuZFZhbHVlVG9TZXJ2ZXIABAUAAABsb2FkAAQMAAAARGVsYXlBY3Rpb24AAwAAAAAAQHpAAQAAAAYAAAAHAAAAAAADBQAAAAUAAAAMAEAAgUAAAB1AgAEfAIAAAgAAAAQSAAAAU2VuZFZhbHVlVG9TZXJ2ZXIABAgAAAB3b3JraW5nAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAEAAAAAAAAAAAAAAAAAAAAAAAAACAAAAA0AAAAAAAYyAAAABgBAAB2AgAAaQEAAF4AAgEGAAABfAAABF0AKgEYAQQBHQMEAgYABAMbAQQDHAMIBEEFCAN0AAAFdgAAACECAgUYAQQBHQMEAgYABAMbAQQDHAMIBEMFCAEbBQABPwcICDkEBAt0AAAFdgAAACEAAhUYAQQBHQMEAgYABAMbAQQDHAMIBBsFAAA9BQgIOAQEARoFCAE/BwgIOQQEC3QAAAV2AAAAIQACGRsBAAIFAAwDGgEIAAUEDAEYBQwBWQIEAXwAAAR8AgAAOAAAABA8AAABHZXRJbkdhbWVUaW1lcgADAAAAAAAAAAAECQAAADAwOjAwOjAwAAQGAAAAaG91cnMABAcAAABzdHJpbmcABAcAAABmb3JtYXQABAYAAAAlMDIuZgAEBQAAAG1hdGgABAYAAABmbG9vcgADAAAAAAAgrEAEBQAAAG1pbnMAAwAAAAAAAE5ABAUAAABzZWNzAAQCAAAAOgAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAABUAAAAcAAAAAQAFIwAAABsAAAAXwAeARwBAAFsAAAAXAAeARkBAAFtAAAAXQAaACIDAgEfAQABYAMEAF4AAgEfAQAAYQMEAF4AEgEaAwQCAAAAAxsBBAF2AgAGGgMEAwAAAAAYBQgCdgIABGUAAARcAAYBFAAABTEDCAMGAAgBdQIABF8AAgEUAAAFMQMIAwcACAF1AgAEfAIAADAAAAAQGAAAAdmFsaWQABAcAAABEaWRFbmQAAQEEBQAAAG5hbWUABB4AAABTUlVfT3JkZXJfbmV4dXNfc3dpcmxpZXMudHJveQAEHgAAAFNSVV9DaGFvc19uZXh1c19zd2lybGllcy50cm95AAQMAAAAR2V0RGlzdGFuY2UABAgAAABNeU5leHVzAAQLAAAAVGhlaXJOZXh1cwAEEgAAAFNlbmRWYWx1ZVRvU2VydmVyAAQEAAAAd2luAAQGAAAAbG9vc2UAAAAAAAMAAAABAQAAAQAAAAAAAAAAAAAAAAAAAAAAHQAAAB0AAAACAAICAAAACkAAgB8AgAABAAAABAoAAABzY3JpcHRLZXkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHQAAAB4AAAACAAUKAAAAhgBAAMAAgACdgAABGEBAARfAAICFAIAAjIBAAQABgACdQIABHwCAAAMAAAAEBQAAAHR5cGUABAcAAABzdHJpbmcABAoAAABzZW5kRGF0YXMAAAAAAAIAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAB8AAAAuAAAAAgATPwAAAApAAICGgEAAnYCAAAqAgICGAEEAxkBBAAaBQQAHwUECQQECAB2BAAFGgUEAR8HBAoFBAgBdgQABhoFBAIfBQQPBgQIAnYEAAcaBQQDHwcEDAcICAN2BAAEGgkEAB8JBBEECAwAdggABFgECAt0AAAGdgAAACoCAgYaAQwCdgIAACoCAhgoAxIeGQEQAmwAAABdAAIAKgMSHFwAAgArAxIeGQEUAh4BFAQqAAIqFAIAAjMBFAQEBBgBBQQYAh4FGAMHBBgAAAoAAQQIHAIcCRQDBQgcAB0NAAEGDBwCHw0AAwcMHAAdEQwBBBAgAh8RDAFaBhAKdQAACHwCAACEAAAAEBwAAAGFjdGlvbgAECQAAAHVzZXJuYW1lAAQIAAAAR2V0VXNlcgAEBQAAAGh3aWQABA0AAABCYXNlNjRFbmNvZGUABAkAAAB0b3N0cmluZwAEAwAAAG9zAAQHAAAAZ2V0ZW52AAQVAAAAUFJPQ0VTU09SX0lERU5USUZJRVIABAkAAABVU0VSTkFNRQAEDQAAAENPTVBVVEVSTkFNRQAEEAAAAFBST0NFU1NPUl9MRVZFTAAEEwAAAFBST0NFU1NPUl9SRVZJU0lPTgAECwAAAGluZ2FtZVRpbWUABA0AAABCb2xUb29sc1RpbWUABAYAAABpc1ZpcAAEAQAAAAAECQAAAFZJUF9VU0VSAAMAAAAAAADwPwMAAAAAAAAAAAQJAAAAY2hhbXBpb24ABAcAAABteUhlcm8ABAkAAABjaGFyTmFtZQAECwAAAEdldFdlYlBhZ2UABA4AAABib2wtdG9vbHMuY29tAAQXAAAAL2FwaS9ldmVudHM/c2NyaXB0S2V5PQAECgAAAHNjcmlwdEtleQAECQAAACZhY3Rpb249AAQLAAAAJmNoYW1waW9uPQAEDgAAACZib2xVc2VybmFtZT0ABAcAAAAmaHdpZD0ABA0AAAAmaW5nYW1lVGltZT0ABAgAAAAmaXNWaXA9AAAAAAACAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAvAAAAMwAAAAMACiEAAADGQEAAAYEAAN2AAAHHwMAB3YCAAArAAIDHAEAAzADBAUABgACBQQEA3UAAAscAQADMgMEBQcEBAIABAAHBAQIAAAKAAEFCAgBWQYIC3UCAAccAQADMgMIBQcECAIEBAwDdQAACxwBAAMyAwgFBQQMAgYEDAN1AAAIKAMSHCgDEiB8AgAASAAAABAcAAABTb2NrZXQABAgAAAByZXF1aXJlAAQHAAAAc29ja2V0AAQEAAAAdGNwAAQIAAAAY29ubmVjdAADAAAAAAAAVEAEBQAAAHNlbmQABAUAAABHRVQgAAQSAAAAIEhUVFAvMS4wDQpIb3N0OiAABAUAAAANCg0KAAQLAAAAc2V0dGltZW91dAADAAAAAAAAAAAEAgAAAGIAAwAAAPyD15dBBAIAAAB0AAQKAAAATGFzdFByaW50AAQBAAAAAAQFAAAARmlsZQAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAABAAAAAAAAAAAAAAAAAAAAAAA="), nil, "bt", _ENV))()
TrackerLoad("5j30YsUkHTtRGYBH")
-- END: BOL TOOLS.