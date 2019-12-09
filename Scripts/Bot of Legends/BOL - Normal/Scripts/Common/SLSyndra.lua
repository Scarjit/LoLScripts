--Author: S1mple
--[[
   _____ _        _____           _        _      _____               
  / ____| |      |  __ \         | |      | |    / ____|              
 | (___ | |      | |__) |_ _  ___| | _____| |_  | |     ___  _ __ ___ 
  \___ \| |      |  ___/ _` |/ __| |/ / _ \ __| | |    / _ \| '__/ _ \
  ____) | |____  | |  | (_| | (__|   <  __/ |_  | |___| (_) | | |  __/
 |_____/|______| |_|   \__,_|\___|_|\_\___|\__|  \_____\___/|_|  \___|
                                                                      
                                                                      
--]]
require("FHPrediction")
local ts_instance = TargetSelector(TARGET_PRIORITY, 4000)
local mm_instance = minionManager(MINION_ENEMY, 1500, player, MINION_SORT_HEALTH_ASC)
local jm_instance = minionManager(MINION_JUNGLE, 1500, player, MINION_SORT_HEALTH_ASC)

local enemy_heroes = GetEnemyHeroes()
local script_version = 1.0
local min_log_level = 2
local menu
local oldprint = print
local print = function(arg,loglevel)

	if(loglevel and loglevel < min_log_level) then
		return
	elseif not loglevel then
		loglevel = 2
	end
	
	local ll = {
		"/DEBUG",
		"/Information",
		"/Warning",
		"/Error",
	}
	oldprint('<font color=\"#808080\">S1mple_Loader </font><font color=\"#10FFFF\">['..myHero.charName..(ll[loglevel] and ll[loglevel] or "")..']</font><font color=\"#515151\"> - </font><font color=\"#FFFFFF\">'..tostring(arg)..'</font>')
end

local function TCPGetRequest(server, path, data, port)
	local start_t = os.clock()
	local port = port or 80
	local data = data or {}
	local lua_socket = require("socket")
	local connection_tcp = lua_socket.connect(server,port)
	local requeststring = "GET "..path
	local first = true

	for i,v in pairs(data) do
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

local function GetWebFile(server, path, data, localfilename, port)
	local r,s,t = TCPGetRequest(server, path, data, port)
	local a,b = Base64Decode(r)
	if (a ~= "No_new_version" and a ~= "Invalid Request" and a ~= "MYSQL Error" and a ~= "") then
		local file = io.open(localfilename,"w+b")
		file:write(a)
		file:close()
		return true
	else
		if a ~= "No_new_version" then
			print(a, 4)
		end
		return false
	end
end

local function Update()
	if(menu.autoupdate)then
		if(GetWebFile("s1mplescripts.de","/S1mple/Scripts/BolStudio/RandomBundle/index.php", {fn = myHero.charName, v = script_version}, LIB_PATH.."SL"..myHero.charName..".lua"))then
			print("Updated, please reload",2)
		else
			print("No update found",2)
		end
	else
		print("Updates disabled", 3)
	end
end

--[[
--]]

local got_w_buff = false
local orbs = {}

local function Menu()
	menu = scriptConfig("Simple Loader ["..myHero.charName.."]", "SL"..myHero.charName)
	menu:addSubMenu("Advanced Settings", "adv") --DONE
		menu.adv:addParam("debuglvl", "Debug Level", SCRIPT_PARAM_LIST, 2, {"DEBUG", "Information", "Warning", "Error"}) --DONE
		menu.adv:setCallback("debuglvl", function(value) --DONE
			min_log_level = value
		end)
		min_log_level = menu.adv.debuglvl
		
	--Champ Specific

	menu:addSubMenu("Key Settings", "key")
		menu.key:addParam("Info", "Orbwalkers keys integrated with", SCRIPT_PARAM_INFO, "")
    	menu.key:addParam("Info", "your orbwalker.", SCRIPT_PARAM_INFO, "")

	menu:addSubMenu("Spell Settings", "spells")
		menu.spells:addSubMenu("Q", "q")

			menu.spells.q:addParam("Blank", "    General", SCRIPT_PARAM_INFO, "")
			menu.spells.q:addParam("onc", "Use on Combo", SCRIPT_PARAM_ONOFF, true)
			menu.spells.q:addParam("manaonc", "If My Mana Percent > %X", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
			menu.spells.q:addParam("usemec", "Use MEC in Combo", SCRIPT_PARAM_ONOFF, false)
			
			menu.spells.q:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
			menu.spells.q:addParam("onf", "Use on LaneClear", SCRIPT_PARAM_ONOFF, true)
			menu.spells.q:addParam("manaonf", "If My Mana Percent > %X", SCRIPT_PARAM_SLICE, 20, 0, 100, 0)

			menu.spells.q:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
			menu.spells.q:addParam("onh", "Use on Harras", SCRIPT_PARAM_ONOFF, true)
			menu.spells.q:addParam("manaonh", "If My Mana Percent > %X", SCRIPT_PARAM_SLICE, 20, 0, 100, 0)

		menu.spells:addSubMenu("W", "w")

			menu.spells.w:addParam("Blank", "    General", SCRIPT_PARAM_INFO, "")
			menu.spells.w:addParam("onc", "Use on Combo", SCRIPT_PARAM_ONOFF, true)
			menu.spells.w:addParam("manaonc", "If My Mana Percent > %X", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)

			menu.spells.w:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
			menu.spells.w:addParam("onf", "Use on LaneClear", SCRIPT_PARAM_ONOFF, true)
			menu.spells.w:addParam("manaonf", "If My Mana Percent > %X", SCRIPT_PARAM_SLICE, 20, 0, 100, 0)

			menu.spells.w:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
			menu.spells.w:addParam("onh", "Use on Harras", SCRIPT_PARAM_ONOFF, true)
			menu.spells.w:addParam("manaonh", "If My Mana Percent > %X", SCRIPT_PARAM_SLICE, 20, 0, 100, 0)

		menu.spells:addSubMenu("E", "e")

			menu.spells.e:addParam("Blank", "    General", SCRIPT_PARAM_INFO, "")
			menu.spells.e:addParam("onc", "Use on Combo", SCRIPT_PARAM_ONOFF, true)
			menu.spells.e:addParam("manaonc", "If My Mana Percent > %X", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)

			menu.spells.e:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
			menu.spells.e:addParam("onf", "Use on LaneClear", SCRIPT_PARAM_ONOFF, true)
			menu.spells.e:addParam("manaonf", "If My Mana Percent > %X", SCRIPT_PARAM_SLICE, 20, 0, 100, 0)

			menu.spells.e:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
			menu.spells.e:addParam("onh", "Use on Harras", SCRIPT_PARAM_ONOFF, true)
			menu.spells.e:addParam("manaonh", "If My Mana Percent > %X", SCRIPT_PARAM_SLICE, 20, 0, 100, 0)


		menu.spells:addSubMenu("R", "r") --tbd

			menu.spells.r:addParam("Blank", "    General", SCRIPT_PARAM_INFO, "")
			menu.spells.r:addParam("onc", "Use on Combo", SCRIPT_PARAM_ONOFF, true)
			menu.spells.r:addParam("manaonc", "If My Mana Percent > %X", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
			menu.spells.r:addParam("killonlyc", "Only if killable", SCRIPT_PARAM_ONOFF, true)

			menu.spells.r:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
			menu.spells.r:addParam("onh", "Use on Harras", SCRIPT_PARAM_ONOFF, true)
			menu.spells.r:addParam("manaonh", "If My Mana Percent > %X", SCRIPT_PARAM_SLICE, 20, 0, 100, 0)
			menu.spells.r:addParam("killonlyh", "Only if killable", SCRIPT_PARAM_ONOFF, true)


		menu.spells:addSubMenu("Q/E", "qe")

			menu.spells.qe:addParam("Blank", "    General", SCRIPT_PARAM_INFO, "")
			menu.spells.qe:addParam("onc", "Use on Combo", SCRIPT_PARAM_ONOFF, true)
			menu.spells.qe:addParam("manaonc", "If My Mana Percent > %X", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
			
			menu.spells.qe:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
			menu.spells.qe:addParam("onh", "Use on Harras", SCRIPT_PARAM_ONOFF, true)
			menu.spells.qe:addParam("manaonh", "If My Mana Percent > %X", SCRIPT_PARAM_SLICE, 20, 0, 100, 0)

	menu:addSubMenu("Killsteal", "ks")
		menu.ks:addParam("q", "Killsteal with Q", SCRIPT_PARAM_ONOFF, true)
		menu.ks:addParam("w", "Killsteal with W", SCRIPT_PARAM_ONOFF, true)
		menu.ks:addParam("e", "Killsteal with E", SCRIPT_PARAM_ONOFF, true)
		menu.ks:addParam("r", "Killsteal with R", SCRIPT_PARAM_ONOFF, true)

    menu:addSubMenu("Drawings", "draws")
    	menu.draws:addParam("target", "Draw Target", SCRIPT_PARAM_ONOFF, true)
	--End Champ Specific

		menu:addSubMenu("Skin Changer", "sc")
		menu.sc:addParam("activehero", "Active (Hero)", SCRIPT_PARAM_ONOFF, false)
		menu.sc:addParam("heroskin", "Choose Skin (Hero)", SCRIPT_PARAM_LIST,1, {"Classic", "Justicar","Atlantean","Queen of Diamonds", "Snow Day"})
		menu.sc:setCallback("activehero", function (value)
			if(value == false)then
				SetSkin(myHero, 0)
			else				
				SetSkin(myHero, menu.sc.heroskin-1)
			end
		end)
		menu.sc:setCallback("heroskin", function (value)
			if(menu.sc.activehero)then
				SetSkin(myHero, value-1)
			end
		end)
		if(menu.sc.activehero)then
			SetSkin(myHero, menu.sc.heroskin-1)
		end
	
	menu:addParam("autoupdate","Autoupdate", SCRIPT_PARAM_ONOFF, true) --DONE
	menu:addParam("version", "Version: ", SCRIPT_PARAM_INFO, script_version) --DONE
end

local LoadedWalker
local function GetOrbWalker()
	if _G.S1OrbLoading or _G.S1mpleOrbLoaded then LoadedWalker = "S1Orb" end
	if _G.Reborn_Loaded or _G.AutoCarry then LoadedWalker = "SAC:R" end
	if SAC then LoadedWalker = "SAC:P" end
	if _Pewalk then LoadedWalker = "PEW" end
	if _G.NebelwolfisOrbWalkerInit then LoadedWalker = "NOW" end
	if not LoadedWalker then print("You need to load an OrbWalker to load this Script",4) return false end
	return true
end


local function GetOrbMode()
	if LoadedWalker == "S1Orb" then
		if _G.S1mpleOrbLoaded and _G.S1.aamode == "none" then return 0 end
		if _G.S1mpleOrbLoaded and _G.S1.aamode == "harass" then return 1 end
		if _G.S1mpleOrbLoaded and _G.S1.aamode == "laneclear" then return 2 end
		if _G.S1mpleOrbLoaded and _G.S1.aamode == "lasthit" then return 3 end
		if _G.S1mpleOrbLoaded and _G.S1.aamode == "sbtw" then return 4 end
	elseif LoadedWalker == "SAC:R" then
		if not _G.AutoCarry or not _G.AutoCarry.Keys then return 0 end
		if _G.AutoCarry.Keys.MixedMode then return 1 end
		if _G.AutoCarry.Keys.LaneClear then return 2 end
		if _G.AutoCarry.Keys.LastHit then return 3 end
		if _G.AutoCarry.Keys.AutoCarry then return 4 end
	elseif LoadedWalker == "SAC:P" then
		if SAC:GetActiveMode() == "MixedMode" then return 1 end
		if SAC:GetActiveMode() == "Laneclear" then return 2 end
		if SAC:GetActiveMode() == "LastHit" then return 3 end
		if SAC:GetActiveMode() == "AutoCarry" then return 4 end		
	elseif LoadedWalker == "PEW" then
		if not _Pewalk then return 0 end
		if _Pewalk.GetActiveMode().Mixed then return 1 end
		if _Pewalk.GetActiveMode().LaneClear then return 2 end
		if _Pewalk.GetActiveMode().Farm then return 3 end
		if _Pewalk.GetActiveMode().Carry then return 4 end
	elseif LoadedWalker == "NOW" then
		if not _G.NebelwolfisOrbWalkerInit then return 0 end
		if _G.NebelwolfisOrbWalker.mode == "Mixed" then return 1 end
		if _G.NebelwolfisOrbWalker.mode == "LaneClear" then return 2 end		
		if _G.NebelwolfisOrbWalker.mode == "LastHit" then return 3 end	
		if _G.NebelwolfisOrbWalker.mode == "Combo" then return 4 end
	end

	return 0
end

local function GetOrbTarget()
	if LoadedWalker == "S1Orb" then
		return (_G.S1mpleOrbLoaded and _G.S1:GetTarget() or nil)
	elseif LoadedWalker == "SAC:R" and _G.AutoCarry and _G.AutoCarry.SkillsCrosshair then
		return _G.AutoCarry.SkillsCrosshair.target
	elseif LoadedWalker == "SAC:P" then
		return SAC:GetTarget()
	elseif LoadedWalker == "PEW" then
		return _Pewalk.GetTarget()
	elseif LoadedWalker == "NOW" then
		return _G.NebelwolfisOrbWalker:GetTarget()
	end
end

local function GetCTarget(range)
	if not range then range = myHero.range end
	local target = GetOrbTarget()
	if not target or GetDistance(target) > range then
		local mode = GetOrbMode()
		if mode == 1 then -- Mixed Mode (Harras)
			ts_instance.range = range
			target = ts_instance.target
			ts_instance.range = 4000
			if not target then
				mm_instance.range = range
				target = mm_instance.objects[1]
				mm_instance.range = 1500
			end
			if not target then
				jm_instance.range = range
				target = jm_instance.objects[1]
				jm_instance.range = 1500
			end
		elseif mode == 2 then -- LaneClear
			mm_instance.range = range
			target = mm_instance.objects[1]
			mm_instance.range = 4000
			if not target then
				jm_instance.range = range
				target = jm_instance.objects[1]
				jm_instance.range = 1500
			end
		elseif mode == 3 then -- LastHit
			mm_instance.range = range
			target = mm_instance.objects[1]
			mm_instance.range = 1500		
			if not target then
				jm_instance.range = range
				target = jm_instance.objects[1]
				jm_instance.range = 1500
			end
		elseif mode == 4 then --SBTW
			ts_instance.range = range
			target = ts_instance.target
			ts_instance.range = 400
		end			
	end
	
	return target
end


--MATH
local sqrt = math.sqrt
local function CalcVector(source,target)
	local V = Vector(source.x, source.y, source.z)
	local V2 = Vector(target.x, target.y, target.z)
	local vec = V-V2
	local vec2 = vec:normalized()
	return vec2
end

--[[
local function GetDistance(p1, p2)
	if not p1 then oldprint(debug.getinfo(2)) end 
	p2 = p2 or player
    local s = (p1.x - p2.x) ^ 2 + ((p1.z or p1.y) - (p2.z or p2.y)) ^ 2
	return sqrt(s)
end
]]
--END MATH

local function GetMana()
	return myHero.mana/myHero.maxMana*100	
end

local function _CalcSpellPosForGroup(radius, range, points)
    if #points == 0 then
        return nil
    elseif #points == 1 then
        return {center = Vector(points[1]), radius = nil}
    end
    local mec = MEC()
    local combos = {}
    for j = #points, 2, -1 do
        local spellPos
        combos[j] = {}
        _CalcCombos(j, points, combos[j])
        for _, v in ipairs(combos[j]) do
            mec:SetPoints(v)
            local c = mec:Compute()
            if c ~= nil and c.radius <= radius and c.center:dist(player) <= range and (spellPos == nil or c.radius < spellPos.radius) then
                spellPos = {center = c.center, radius = c.radius}
            end
        end
        if spellPos ~= nil then return spellPos end
    end
end

local function GetDmg(spell, unit)
	if unit and unit.visible and not unit.dead and unit.bTargetable then

		local ADDmg = 0
		local APDmg = 0

		local Level = myHero.level
		local TotalDmg = myHero.totalDamage
		local AddDmg = myHero.addDamage
		local AP = myHero.ap
		local ArmorPen = myHero.armorPen
		local ArmorPenPercent = myHero.armorPenPercent
		local MagicPen = myHero.magicPen
		local MagicPenPercent = myHero.magicPenPercent

		local Armor = math.max(0, unit.armor*ArmorPenPercent-ArmorPen)
		local ArmorPercent = Armor/(100+Armor)
		local MagicArmor = math.max(0, unit.magicArmor*MagicPenPercent-MagicPen)
		local MagicArmorPercent = MagicArmor/(100+MagicArmor)

		if spell == "AA" then
			ADDmg = TotalDmg
		elseif spell == "Q" then
			if myHero:CanUseSpell(_Q) == READY then
				APDmg = 45*myHero:GetSpellData(_Q).level+5+0.75*AP
			end
		elseif spell == "W" then
			if myHero:CanUseSpell(_W) == READY then
				APDmg = 40*myHero:GetSpellData(_W).level+40+0.8*AP	
			end
		elseif spell == "E" then
			if myHero:CanUseSpell(_E) == READY then
				APDmg = 45*myHero:GetSpellData(_W).level+25+0.5*AP			
			end
		elseif spell == "R" then
			if myHero:CanUseSpell(_R) == READY then
				local spheres = math.min(3+#orbs,7)
				local DmgperSphere = 45*myHero:GetSpellData(_R).level+45+0.2*AP
				local SphereDamage = DmgperSphere*spheres
				APDmg = 135*myHero:GetSpellData(_R).level+270+0.6*AP+SphereDamage
				APDmg = APDmg*0.9
			end
		end

		local TrueDmg = ADDmg*(1-ArmorPercent)+APDmg*(1-MagicArmorPercent)
		return TrueDmg
	end
	return 0
end

local Qdata = {
	range = 790
	speed = math.huge
	delay = 0.6
	radius = 125
}

local Wdata = {
	range = 950,
	speed = 1450,
	delay = 0.25,
	radius = 210,
}

local QEdata = {
	range = 1290,
	speed = 9000,
	delay = 0.98,
	radius = 55,
}

local ValidTarget = ValidTarget

local ex_draw_table = {}

local function CastQ(target)
	if --[[target and target.valid and not target.dead and target.visible--]] ValidTarget(target) then
		local CastPos, HitChance, _ = FHPrediction.GetPrediction("Q", target)
		if CastPos and HitChance > 1.1 then
			CastSpell(_Q, CastPos.x, CastPos.z)
			return true
		end
	end
end

local function CastQPos(mode)
	local x = {}
	local objs = {}
	if mode == 1 then
		objs = mm_instance.objects
	elseif mode == 2 then
		objs = GetEnemyHeroes()
	end
	for k,v in pairs(objs) do
		if --[[v and v.valid and not v.dead and v.visible and GetDistance(v) <=970--]] ValidTarget(v, 970) then
			x[#x+1] = v
			if #x > 7 then break end
		end
	end
	if #x >= 1 then

		local a = _CalcSpellPosForGroup(170,800,x)
		if a ~= nil then
			local center = a.center
			local radius = a.radius
			CastSpell(_Q, center.x, center.z)
			ex_draw_table["Q"] = nil
			ex_draw_table["Q"] = a
		end
	end
end

local function CastWPos(mode)
	local x = {}
	local objs = {}
	if mode == 1 then
		objs = mm_instance.objects
	elseif mode == 2 then
		objs = GetEnemyHeroes()
	end
	for k,v in pairs(objs) do
		if --[[v and v.valid and not v.dead and v.visible and GetDistance(v) <=1160--]] ValidTarget(v, 1160) then
			x[#x+1] = v
			if #x > 7 then break end
		end
	end
	if #x >= 1 then

		local a = _CalcSpellPosForGroup(210,950,x)
		if a ~= nil then
			local center = a.center
			local radius = a.radius
			CastSpell(_W, center.x, center.z)
			ex_draw_table["W"] = nil
			ex_draw_table["W"] = a
		end
	end
end

local function CastW(target)
	if --[[target and target.valid and not target.dead and target.visible--]] ValidTarget(target) then
		local CastPos, HitChance, _ = FHPrediction.GetPrediction(Wdata, target)
		if CastPos and HitChance >= 1 then
			CastSpell(_W, CastPos.x, CastPos.z)
		end
	end
end


local function CastE(target)
	if --[[target and target.valid and not target.dead and target.visible--]] ValidTarget(target) then
		if got_w_buff then return end

		if target and GetDistance(target) < GetDistance(myHero) then
			local CastPos, HitChance, _ = FHPrediction.GetPrediction("E", target)
			if CastPos and HitChance > 1 then
				CastSpell(_E, CastPos.x, CastPos.z)
			end
		end
	end
end

local function CastR(target)
	if --[[target and target.valid and not target.dead and target.visible--]] ValidTarget(target) then
		CastSpell(_R, target)
	end
end

local function QENeededMana()
	local q_lvl = myHero:GetSpellData(_Q).level
	local q_mana = (q_lvl*10)+60
	local e_mana = 50
	if (q_mana+e_mana <= myHero.mana) then
		return true
	else
		return false
	end
end

local function predictPosition(o, spelldata)
	if not o or not spelldata then
		return Vector(0,0,0), -1
	end
	
	if o.hasMovePath and o.path.valid and o.path.count > 1 then
		local prev_waypoint = nil
		local max_hit_time = spelldata.radius/o.ms
		for i=0, o.path.count do
			local waypoint = o.path:Path(i)
			if waypoint then

				if i == o.path.curPath then
					if prev_waypoint then
						
						local dst_o_wp = GetDistance(o, waypoint)
						local traveltime_o = dst_o_wp/o.ms
						local missle_dst = GetDistance(myHero, waypoint)
						local traveltime_m = missle_dst/spelldata.speed						
						local a,b = VectorMovementCollision(o, waypoint, o.ms, myHero, spelldata.speed, spelldata.delay)
						local castPos = Vector(b.x, o.y, b.y)						
						local mt_VMC = GetDistance(myHero, castPos)/spelldata.speed
						local ot_VMC = GetDistance(o, castPos)/o.ms						
						if GetDistance(castPos) < spelldata.range + spelldata.radius then
							return castPos, 1-math.max(GetDistance(castPos)/spelldata.range,0)
						else
							return Vector(0,0,0), -1							
						end
					end
				else
					prev_waypoint = waypoint
				end
			end
		end
	else
		return Vector(o.x, o.y, o.z), 1
	end
	return Vector(0,0,0), -1
end

local function CastQE(target)
	if --[[target and target.valid and not target.dead and target.bTargetable--]] ValidTarget(target) then
		local predPos, hitchance = predictPosition(target, QEdata)
		if predPos and hitchance and hitchance > 0 and predPos ~= Vector(0,0,0) then
			if GetDistance(predPos) < 700 then
				CastSpell(_Q, predPos.x, predPos.z)
				CastSpell(_E, predPos.x, predPos.z)
			else
				local myPos = Vector(myHero.x, myHero.y, myHero.z)
				local vec = CalcVector(myPos, predPos)*700*-1
				CastSpell(_Q, vec.x, vec.z)
				CastSpell(_E, vec.x, vec.z)
			end
		end
	end
end

-- NORMAL MODES
local function Combo()
	local Target = GetCTarget(1290)
	if not Target then return end

	if myHero:CanUseSpell(_Q) and myHero:CanUseSpell(_E) and menu.spells.qe.onc and menu.spells.qe.manaonc <= GetMana() then
		if QENeededMana() then
			CastQE(Target)
		end
	end

	if myHero:CanUseSpell(_Q) == READY and menu.spells.q.onc and menu.spells.q.manaonc <= GetMana() then
		if menu.spells.q.usemec then
			CastQPos(2)
		else
			CastQ(Target)
		end
	end

	if myHero:CanUseSpell(_W) == READY and menu.spells.w.onc and (menu.spells.w.manaonc <= GetMana() or TargetHaveBuff("syndrawtooltip")) then
		CastW(Target)
	end

	if myHero:CanUseSpell(_E) == READY and menu.spells.e.onc and menu.spells.e.manaonc <= GetMana() then
		CastE(Target)
	end
	
	if myHero:CanUseSpell(_R) == READY and menu.spells.r.onc and menu.spells.r.manaonc <= GetMana() then
		if menu.spells.r.killonlyc then
			local dmg = GetDmg("R", Target)
			if dmg >= Target.health then
				print(dmg, 1)
				print(Target.health,1)
				CastR(Target)
			end
		else
			CastR(Target)
		end
	end
end

local function Harras()
	local Target = GetCTarget(1290)
	if not Target or Target.type ~= myHero.type then return end

	if myHero:CanUseSpell(_Q) == READY and menu.spells.q.onh and menu.spells.q.manaonh <= GetMana() then
		CastQ(Target)
	end

	if myHero:CanUseSpell(_W) == READY and menu.spells.w.onh and (menu.spells.w.manaonh <= GetMana() or TargetHaveBuff("syndrawtooltip")) then
		CastW(Target)
	end

	if myHero:CanUseSpell(_E) == READY and menu.spells.e.onh and menu.spells.e.manaonh <= GetMana() then
		CastE(Target)
	end
	
	if myHero:CanUseSpell(_R) == READY and menu.spells.r.onh and menu.spells.r.manaonh <= GetMana() then
		if menu.spells.r.killonlyh then
			local dmg = GetDmg("R", Target)
			if dmg >= Target.health then
				CastR(Target)
			end
		else
			CastR(Target)
		end
	end
end

local function Laneclear()
	local Target = GetCTarget(1290)
	if not Target then return end

	if myHero:CanUseSpell(_Q) == READY and menu.spells.q.onf and menu.spells.q.manaonf <= GetMana() then
		CastQPos(1)
	end

	if myHero:CanUseSpell(_W) == READY and menu.spells.w.onf and (menu.spells.w.manaonf <= GetMana() or TargetHaveBuff("syndrawtooltip")) then
		CastWPos(1)
	end

	if myHero:CanUseSpell(_E) == READY and menu.spells.e.onf and menu.spells.e.manaonf <= GetMana() then
		CastE(Target)
	end
end

local function Modes()
	local mode = GetOrbMode()
	if mode == 4 then
		Combo()
	elseif mode == 1 then
		Harras()
	elseif mode == 2 then
		Laneclear()
	end
end

--END NORMAL MODES

function OrbManager_add(obj)
	if obj and obj.name and obj.name == "Seed" and obj.type == "obj_AI_Minion" then
		orbs[#orbs+1] = obj
	end
end
function OrbManager_del(obj)
	if obj and obj.name and obj.name == "Seed" and obj.type == "obj_AI_Minion" then
		orbs[#orbs+1] = obj
	end
end


local function Killsteal()
	local q_ks = menu.ks.q
	local w_ks = menu.ks.w
	local e_ks = menu.ks.e
	local r_ks = menu.ks.r
	
	if q_ks or w_ks or e_ks or r_ks then
		for _,v in pairs(enemy_heroes) do
			if --[[v and v.valid and v.visible and not v.dead and v.bTargetable--]] ValidTarget(v) then
				if q_ks and GetDistance(800) and myHero:CanUseSpell(_Q) then
					if GetDmg("Q",v) > v.health then
						CastQ(v)
						break
					end
				end
				if w_ks and GetDistance(950) and myHero:CanUseSpell(_W) then
					if GetDmg("W",v) > v.health then
						CastW(v)
						break
					end
				end
				if e_ks and GetDistance(700) and myHero:CanUseSpell(_E) then
					if GetDmg("E",v) > v.health then
						CastE(v)
						break
					end
				end
				if r_ks and GetDistance(675) and myHero:CanUseSpell(_R) then
					if GetDmg("R",v) > v.health then
						CastR(v)
						break
					end
				end
			end
		end		
	end
end


--BEGIN DRAWS
local function Draws()
	if menu.draws.target then
		local t = GetCTarget(1290)
		if t then
			DrawCircle3D(t.x, t.y, t.z,50,2,ARGB(255,255,0,255))
		end

		if ex_draw_table["Q"] then
			local a = ex_draw_table["Q"]
			local center = a.center
			local radius = a.radius
			if center and radius then
				DrawCircle3D(center.x,center.y,center.z, radius, 1, ARGB(255,255,0,128))
			end
		end

		if ex_draw_table["W"] then
			local a = ex_draw_table["W"]
			local center = a.center
			local radius = a.radius
			if center and radius then
				DrawCircle3D(center.x,center.y,center.z, radius, 1, ARGB(255,255,0,128))
			end
		end

		if myHero:CanUseSpell(_R)then
			for k,v in pairs(GetEnemyHeroes()) do
				DrawText3D(tostring(GetDmg(v)), v.x, v.y, v.z)
			end
		end
	end
end

local function drawDebugStuff()
	if min_log_level > 1 then return end

end
--END DRAWS

AddLoadCallback(function()
	if not GetOrbWalker() then return end
	Menu()
	Update()
end)

AddDrawCallback(function()
	if not LoadedWalker then return end
	Draws()
end)

AddTickCallback(function()
	if not LoadedWalker then return end
	ts_instance:update()
	jm_instance:update()
	mm_instance:update()
	Modes()
end)

AddProcessSpellCallback(function(unit, spell)
	if not LoadedWalker then return end
end)

AddCreateObjCallback(function(object)
	if not LoadedWalker then return end
	OrbManager_add(object)
end)

AddDeleteObjCallback(function (obj)
	if not LoadedWalker then return end
	OrbManager_del(object)
end)

AddBugsplatCallback(function ()
	local file = io.open(SCRIPT_PATH.."SLSyndra.bugsplat", "a")
	file:write(tostring(debug.traceback()))
	file:close()
end)

AddRemoveBuffCallback(function (a,b)
	if a.isMe and b.name == "syndrawtooltip" then
		got_w_buff = false
	end
end)

AddApplyBuffCallback(function (a,b,c)
	if a.isMe and c.name == "syndrawtooltip" then
		got_w_buff = true
	end
end)