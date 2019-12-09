version = "1.00"

--[[
 __          __                 _      _               _______ _            ____  _                 _   _    _             _            
 \ \        / /                (_)    | |             |__   __| |          |  _ \| |               | | | |  | |           | |           
  \ \  /\  / /_ _ _ ____      ___  ___| | __  ______     | |  | |__   ___  | |_) | | ___   ___   __| | | |__| |_   _ _ __ | |_ ___ _ __ 
   \ \/  \/ / _` | '__\ \ /\ / / |/ __| |/ / |______|    | |  | '_ \ / _ \ |  _ <| |/ _ \ / _ \ / _` | |  __  | | | | '_ \| __/ _ \ '__|
    \  /\  / (_| | |   \ V  V /| | (__|   <              | |  | | | |  __/ | |_) | | (_) | (_) | (_| | | |  | | |_| | | | | ||  __/ |   
     \/  \/ \__,_|_|    \_/\_/ |_|\___|_|\_\             |_|  |_| |_|\___| |____/|_|\___/ \___/ \__,_| |_|  |_|\__,_|_| |_|\__\___|_|   
                                                                                                                                        
                                                                                                                                        
--]]


if myHero.charName ~= "Warwick" then
	return 
end
	

	function Hello()

		PrintChat("<font color=\"#4000ff\">Warwick - The Blood Hunter</font>")
	end

	function OnLoad()

		Menu()
		Hello()

		if myHero:GetSpellData(SUMMONER_1).name:find("summonerdot") then Ignite = SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerdot") then Ignite = SUMMONER_2 end
	end

	function Menu()
		
		WWMenu = scriptConfig("Warwick - The Blood Hunter", "WW")


		WWMenu:addSubMenu("Combo Settings", "combo")
			WWMenu.combo:addParam("ComboKey", "Full Combo Key (SBTW)", SCRIPT_PARAM_ONKEYDOWN, false, string.byte (" "))

		WWMenu:addSubMenu("Harass Settings", "harass")
			WWMenu.harass:addParam("autoQ", "Auto-Q when Target in Range", SCRIPT_PARAM_ONKEYTOGGLE, false, GetKey('Z'))
			WWMenu.harass:addParam("HarassMana", "Min. Mana Percent: ", SCRIPT_PARAM_SLICE, 50, 0, 100, 0)

		WWMenu:addSubMenu("Last Hit Settings", "lasthit")
			WWMenu.lasthit:addParam("LastHitKey", "Farming Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("X"))
			WWMenu.lasthit:addParam("qLastHit", "Use (Q)", SCRIPT_PARAM_ONOFF, true)
			WWMenu.lasthit:addParam("LastHitMana", "Min. Mana Percent: ", SCRIPT_PARAM_SLICE, 50, 0, 100, 0)

		WWMenu:addSubMenu("Lane Clear Settings", "lane")
			WWMenu.lane:addParam("LaneKey", "Jungle Clear Key (V)", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
			WWMenu.lane:addParam("qLane", "Use (Q)", SCRIPT_PARAM_ONOFF, true)
			WWMenu.lane:addParam("wLane", "Use (W)", SCRIPT_PARAM_ONOFF, true)
			WWMenu.lane:addParam("LaneMana", "Min. Mana Percent: ", SCRIPT_PARAM_SLICE, 50, 0, 100, 0)

		WWMenu:addSubMenu("Jungle Clear Settings", "jungle")
			WWMenu.jungle:addParam("JungleKey", "Jungle Clear Key (V)", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
			WWMenu.jungle:addParam("qJungle", "Use (Q)", SCRIPT_PARAM_ONOFF, true)
			WWMenu.jungle:addParam("wJungle", "Use (W)", SCRIPT_PARAM_ONOFF, true)
			WWMenu.jungle:addParam("JungleMana", "Min. Mana Percent: ", SCRIPT_PARAM_SLICE, 50, 0, 100, 0)

		WWMenu:addSubMenu("KillSteal Settings", "ks")
			WWMenu.ks:addParam("KillSteal", "Use Smart Kill Steal -", SCRIPT_PARAM_ONOFF, true)
			WWMenu.ks:addParam("autoIgnite", "Auto Ignite", SCRIPT_PARAM_ONOFF, true)

		WWMenu:addSubMenu("Item Settings", "items")
				

		WWMenu:addSubMenu("Draw Settings", "drawing")	
			WWMenu.drawing:addParam("mDraw", "Disable All Range Draws", SCRIPT_PARAM_ONOFF, false)
			WWMenu.drawing:addParam("Target", "Draw Circle on Target", SCRIPT_PARAM_ONOFF, true)
			WWMenu.drawing:addParam("qDraw", "Draw (Q) Range", SCRIPT_PARAM_ONOFF, true)
			WWMenu.drawing:addParam("wDraw", "Draw (W) Range", SCRIPT_PARAM_ONOFF, true)
			WWMenu.drawing:addParam("eDraw", "Draw (E) Range", SCRIPT_PARAM_ONOFF, true)
			WWMenu.drawing:addParam("rDraw", "Draw (R) Range", SCRIPT_PARAM_ONOFF, true)

		WWMenu:addSubMenu("Target Selector", "TargetSelector")
            WWMenu.TargetSelector:addParam ("drawtext", "Draw Target Select Text", SCRIPT_PARAM_ONOFF, true)
            WWMenu.TargetSelector:addParam ("hitbox", "Target-Selector", SCRIPT_PARAM_LIST, 1, {"Hitbox", "3D Circle"})


		WWMenu:addParam("WWVer", "Version: ", SCRIPT_PARAM_INFO, version)

	end

	function OnDraw()
		
		if not myHero.dead then

			if not WWMenu.drawing.mDraw then

				if (WWMenu.drawing.qDraw) and qReady then
					DrawCircle3DQ(myHero.x, myHero.y, myHero.z)
				end

				if (WWMenu.drawing.eDraw) and eReady then
					DrawCircle3DE(myHero.x, myHero.y, myHero.z)
				end

				if (WWMenu.drawing.rDraw) and rReady then
					DrawCircle3DR(myHero.x, myHero.y, myHero.z)
				end

				if SelectedTarget ~= nil and WWMenu.TargetSelector.hitbox == 1 then 
                    DrawHitBox(SelectedTarget)
                end

                if SelectedTarget ~= nil and WWMenu.TargetSelector.hitbox == 2 then
                    DrawCircle3D4(SelectedTarget.x, SelectedTarget.y, SelectedTarget.z)
                end
			end
		end
	end

	function OnTick()

		ComboKey		= WWMenu.combo.ComboKey
		LastHitKey		= WWMenu.lasthit.LastHitKey
		LaneClearKey	= WWMenu.lane.LaneKey
		JungleClearKey	= WWMenu.jungle.JungleKey
		HarassQ 		= WWMenu.harass.autoQ

		ts = TargetSelector(TARGET_LOW_HP_PRIORITY, 650)
		target = ts.target
		ts:update()

		
		enemyMinions 	= minionManager(MINION_ENEMY, 1000, myHero, MINION_SORT_MAXHEALTH_ASC)
		jungleMinions = minionManager(MINION_JUNGLE, 1100, myHero, MINION_SORT_MAXHEALTH_DEC)


        qReady = myHero:CanUseSpell(_Q) == READY
        wReady = myHero:CanUseSpell(_W) == READY
        eReady = myHero:CanUseSpell(_E) == READY
        rReady = myHero:CanUseSpell(_R) == READY

        SpellQ = {name = "Hungering Strike",	range =  400	, ready = false, dmg = 0, manaUsage = 0				   }
		SpellW = {name = "Hunters Call",		range =  1250	, ready = false, dmg = 0, manaUsage = 0				   }
		SpellE = {name = "Blood Scent",			range =  0		, ready = false, dmg = 0, manaUsage = 0				   }
		SpellR = {name = "Infinite Duress",		range =  700	, ready = false, dmg = 0, manaUsage = 0				   }

        SpellQ.manaUsage = myHero:GetSpellData(_Q).mana
		SpellW.manaUsage = myHero:GetSpellData(_W).mana
		SpellE.manaUsage = myHero:GetSpellData(_E).mana
		SpellR.manaUsage = myHero:GetSpellData(_R).mana


		 
		if ComboKey then
			Combo(Target)
		end

		if LastHitKey then
			LastHit()
		end

		if LaneClearKey then
			LaneClear()
		end

		if JungleClearKey then
			JungleClear()
		end

		if WWMenu.harass.autoQ then
			HarassAutoQ()
		end

        if WWMenu.ks.KillSteal then
           	KillSteal()
        end

        if WWMenu.ks.autoIgnite then
            autoIgnite()
        end





		if SelectedTarget ~= nil then 
            SelectetTarget = Target 
            else Target = ts.target 
        end


	end

	function Combo()

		if ts.target and ValidTarget(ts.target) then

			if ComboKey then
				CastSpell(_Q, ts.target)
			end

			if GetDistance(ts.target) <= 125 then
				CastSpell(_W)
			end

			if GetDistance(ts.target) <= 700 then
				CastSpell(_R, ts.target)
			end
		end
	end

	function LastHit()

		enemyMinions:update()

		for each, minions in ipairs(enemyMinions.objects) do

            if minions and ValidTarget(minions) then

            	if GetDistance(minions) > 125 and minions.health <= getDmg("Q",minions,myHero) and WWMenu.lasthit.qLastHit and not isLow('Mana', myHero, WWMenu.lasthit.LastHitMana) then
            		CastSpell(_Q, minions)
            	end
            end
        end
	end

	function LaneClear()

		enemyMinions:update()

        for each, minions in ipairs(enemyMinions.objects) do

            if minions and ValidTarget(minions) then

            	if GetDistance(minions) <= 400 and WWMenu.lane.qLane and not isLow('Mana', myHero, WWMenu.lane.LaneMana) then
					CastSpell(_Q, minions)
				end

				if GetDistance(minions) <= 125 and WWMenu.lane.wLane and not isLow('Mana', myHero, WWMenu.lane.LaneMana) then
					CastSpell(_W, minions)
				end
			end
		end
	end

	function JungleClear()

		jungleMinions:update()

        for _,jm in pairs(jungleMinions.objects) do

            if jm and ValidTarget(jm) then

            	if GetDistance(jm) <= 125 and WWMenu.jungle.wJungle and not isLow('Mana', myHero, WWMenu.jungle.JungleMana) then
					CastSpell(_W, jm)
				end

            	if GetDistance(jm) <= 400 and WWMenu.jungle.qJungle and not isLow('Mana', myHero, WWMenu.jungle.JungleMana) then
					CastSpell(_Q, jm)
				end
			end
		end
	end

	function HarassAutoQ()
		
		for each, enemy in ipairs(GetEnemyHeroes()) do

            if enemy and ValidTarget(enemy) then

				if ts.target and ValidTarget(ts.target) then

					if GetDistance(ts.target) <= 400 and not isLow('Mana', myHero, WWMenu.harass.HarassMana) then
						CastSpell(_Q, ts.target)
					end
				end
			end
		end
	end

	function KillSteal()
		
		for each, enemy in ipairs(GetEnemyHeroes()) do

            if enemy and ValidTarget(enemy) then

                if GetDistance(enemy) <= 400 and enemy.health <= getDmg("Q",enemy,myHero) then
   					CastSpell(_Q, enemy)
                end       
            end
        end
	end

	function autoIgnite()

		if not Ignite then return end

		for each, enemy in ipairs(GetEnemyHeroes()) do

		       if enemy and ValidTarget(enemy) then

				if enemy.health <= 50 + (20 * myHero.level) and WWMenu.ks.autoIgnite and myHero:CanUseSpell(Ignite) == READY then
						CastSpell(Ignite, enemy)
				end
			end
		end
	end

	function DrawCircle3DQ(x, y, z, radius, width, color, quality)
                radius = radius or 400
                quality = quality and 2 * math.pi / quality or 2 * math.pi / (radius / 5)
                local points = {}
                    for theta = 0, 2 * math.pi + quality, quality do
                        local c = WorldToScreen(D3DXVECTOR3(x + radius * math.cos(theta), y, z - radius * math.sin(theta)))
                        points[#points + 1] = D3DXVECTOR2(c.x, c.y)
                    end
                DrawLines2(points, width or 1, color or 2294967295)
    end

    function DrawCircle3DE(x, y, z, radius, width, color, quality)
                radius = radius or 1250
                quality = quality and 2 * math.pi / quality or 2 * math.pi / (radius / 5)
                local points = {}
                    for theta = 0, 2 * math.pi + quality, quality do
                        local c = WorldToScreen(D3DXVECTOR3(x + radius * math.cos(theta), y, z - radius * math.sin(theta)))
                        points[#points + 1] = D3DXVECTOR2(c.x, c.y)
                    end
                DrawLines2(points, width or 1, color or 2294967295)
    end

    function DrawCircle3DR(x, y, z, radius, width, color, quality)
                radius = radius or 700
                quality = quality and 2 * math.pi / quality or 3 * math.pi / (radius / 5)
                local points = {}
                    for theta = 0, 2 * math.pi + quality, quality do
                        local c = WorldToScreen(D3DXVECTOR3(x + radius * math.cos(theta), y, z - radius * math.sin(theta)))
                        points[#points + 1] = D3DXVECTOR2(c.x, c.y)
                    end
                DrawLines2(points, width or 1, color or 4294967280)
    end

    function DrawCircle3D4(x, y, z, radius, width, color, quality)
                radius = radius or 100
                quality = quality and 2 * math.pi / quality or 2 * math.pi / (radius / 5)
                local points = {}
                    for theta = 0, 2 * math.pi + quality, quality do
                        local c = WorldToScreen(D3DXVECTOR3(x + radius * math.cos(theta), y, z - radius * math.sin(theta)))
                        points[#points + 1] = D3DXVECTOR2(c.x, c.y)
                    end
                DrawLines2(points, width or 1, color or 8294967295)
            end

    function DrawHitBox(object, linesize, linecolor)
        if object and object.valid and object.minBBox then
            DrawLine3D(object.minBBox.x, object.minBBox.y, object.minBBox.z, object.minBBox.x, object.minBBox.y, object.maxBBox.z, linesize, linecolor)
          	DrawLine3D(object.minBBox.x, object.minBBox.y, object.maxBBox.z, object.maxBBox.x, object.minBBox.y, object.maxBBox.z, linesize, linecolor)
         	DrawLine3D(object.maxBBox.x, object.minBBox.y, object.maxBBox.z, object.maxBBox.x, object.minBBox.y, object.minBBox.z, linesize, linecolor)
        	DrawLine3D(object.maxBBox.x, object.minBBox.y, object.minBBox.z, object.minBBox.x, object.minBBox.y, object.minBBox.z, linesize, linecolor)
       		DrawLine3D(object.minBBox.x, object.minBBox.y, object.minBBox.z, object.minBBox.x, object.maxBBox.y, object.minBBox.z, linesize, linecolor)
      		DrawLine3D(object.minBBox.x, object.minBBox.y, object.maxBBox.z, object.minBBox.x, object.maxBBox.y, object.maxBBox.z, linesize, linecolor)
       		DrawLine3D(object.maxBBox.x, object.minBBox.y, object.maxBBox.z, object.maxBBox.x, object.maxBBox.y, object.maxBBox.z, linesize, linecolor)
    		DrawLine3D(object.maxBBox.x, object.minBBox.y, object.minBBox.z, object.maxBBox.x, object.maxBBox.y, object.minBBox.z, linesize, linecolor)
     		DrawLine3D(object.minBBox.x, object.maxBBox.y, object.minBBox.z, object.minBBox.x, object.maxBBox.y, object.maxBBox.z, linesize, linecolor)   
     		DrawLine3D(object.minBBox.x, object.maxBBox.y, object.maxBBox.z, object.maxBBox.x, object.maxBBox.y, object.maxBBox.z, linesize, linecolor)
     		DrawLine3D(object.maxBBox.x, object.maxBBox.y, object.maxBBox.z, object.maxBBox.x, object.maxBBox.y, object.minBBox.z, linesize, linecolor)
      		DrawLine3D(object.maxBBox.x, object.maxBBox.y, object.minBBox.z, object.minBBox.x, object.maxBBox.y, object.minBBox.z, linesize, linecolor)
        end
    end


    function isLow(what, unit, slider)
		if what == 'Mana' then
			if unit.mana < (unit.maxMana * (slider / 100)) then
				return true
			else
				return false
			end
		elseif what == 'HP' then
			if unit.health < (unit.maxHealth * (slider / 100)) then
				return true
			else
				return false
			end
		end
	end


	function OnWndMsg(msg, key)

        if msg == WM_LBUTTONDOWN then
        	local minD = 200
            for i, unit in ipairs(GetEnemyHeroes()) do
            	if ValidTarget(unit) and not unit.dead then
                	if GetDistance(unit, mousePos) <= minD or target == nil then
                    	minD = GetDistance(unit, mousePos)
                        target = unit
                    end
                end
            end
            	if target and minD < 200 then
                	if SelectedTarget and target.charName == SelectedTarget.charName then
                    	SelectedTarget = nil
                    	if WWMenu.TargetSelector.drawtext then
                        print("Target unselected")
                    	end
                    else
                    	SelectedTarget = target
                        if WWMenu.TargetSelector.drawtext then
                        print("Target Selected: "..SelectedTarget.charName)
                        end
                    end
               	end
            
        end
    end
