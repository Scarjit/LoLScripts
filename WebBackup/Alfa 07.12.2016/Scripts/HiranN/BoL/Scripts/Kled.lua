if myHero.charName ~= "Kled" then return end

function OnLoad()
	CheckPRED()
end

function CheckPRED()
	if not FileExist(LIB_PATH .. "/VPrediction.lua") then 
		DelayAction(function() DownloadFile("https://raw.github.com/SidaBoL/Scripts/master/Common/VPrediction.lua".."?rand="..math.random(1,10000), LIB_PATH.."VPrediction.lua", 
			function()
				Kled()
			end)
		end, 3)
	else
		Kled()
	end
end

function OrbsW()
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
        Menu.Orbwalkers:addSubMenu("Select Orbwalker", "Select")
        Menu.Orbwalkers:addSubMenu("Keys", "Keys")
        Menu.Orbwalkers.Select:addParam("Orbwalker", "OrbWalker", SCRIPT_PARAM_LIST, 1, OrbWalkers)
        Menu.Orbwalkers.Keys:addParam("info", "Detecting keys from: "..OrbWalkers[Menu.Orbwalkers.Select.Orbwalker], SCRIPT_PARAM_INFO, "")
        Menu.Orbwalkers.Select:setCallback("Orbwalker", function(value)
            if OrbAlr then 
                return 
            end
            OrbAlr = true
            Menu.Orbwalkers:addParam("info", "Press F9 2x to load your selected Orbwalker.", SCRIPT_PARAM_INFO, "")
            Print("Press F9 2x to load your selected Orbwalker")
        end)
        LoadedOrb = OrbWalkers[Menu.Orbwalkers.Select.Orbwalker]
  		if LoadedOrb == "NOW" then
            require "Nebelwolfi's Orb Walker"
            _G.NOWi = NebelwolfisOrbWalkerClass()	
        elseif LoadedOrb == "Big Fat Walk" then
            require "Big Fat Orbwalker"
        elseif LoadedOrb == "SOW" then
            require "SOW"
            Menu.Orbwalkers:addSubMenu("SOW", "SOW")
            _G.SOWi = SOW(_G.VP)
            SOW:LoadToMenu(Menu.Orbwalkers.SOW)
        elseif LoadedOrb == "SxOrbWalk" then
            require "SxOrbWalk"
            Menu.Orbwalkers:addSubMenu("SxOrbWalk", "SxOrbWalk")
            SxOrb:LoadToMenu(Menu.Orbwalkers.SxOrbWalk)
        elseif LoadedOrb == "S1mpleOrbWalker" then
            require "S1mpleOrbWalker"
            S1 = S1mpleOrbWalker()
            Menu.Orbwalkers:addSubMenu("S1mpleOrbWalker", "S1mpleOrbWalker")
            S1:AddToMenu(Menu.Orbwalkers.S1mpleOrbWalker)
        end
  		DelayAction(function() TIMEFORSAC = true end, 10)
	end
end

function OrbKeys()
	if LoadedOrb == "SAC" and TIMEFORSAC then
		if _G.AutoCarry.Keys.AutoCarry then 
			return "Combo"
		end
		if _G.AutoCarry.Keys.MixedMode then 
			return "Harass"
		end
		if _G.AutoCarry.Keys.LaneClear then 
			return "Laneclear"
		end
		if _G.AutoCarry.Keys.LastHit then 
			return "Lasthit"
		end
	elseif LoadedOrb == "MMA" then
		if _G.MMA_IsOrbwalking() then 
			return "Combo"
		end
		if _G.MMA_IsDualCarrying() then 
			return "Harass"
		end
		if _G.MMA_IsLaneClearing() then 
			return "Laneclear"
		end
		if _G.MMA_IsLastHitting() then 
			return "Lasthit"
		end
	elseif LoadedOrb == "Pewalk" then
		if _G._Pewalk.GetActiveMode().Carry then 
			return "Combo"
		end
		if _G._Pewalk.GetActiveMode().Mixed then 
			return "Harass"
		end
		if _G._Pewalk.GetActiveMode().LaneClear then 
			return "Laneclear"
		end
		if _G._Pewalk.GetActiveMode().Farm then 
			return "Lasthit"
		end
	elseif LoadedOrb == "NOW" then
		if _G.NOWi.mode == "Combo" then 
			return "Combo"
		end
		if _G.NOWi.mode == "Harass" then 
			return "Harass"
		end
		if _G.NOWi.mode == "LaneClear" then 
			return "Laneclear"
		end
		if _G.NOWi.mode == "LastHit" then 
			return "Lasthit"
		end
	elseif LoadedOrb == "Big Fat Walk" then
		if _G["BigFatOrb_Mode"] == "Combo" then 
			return "Combo"
		end
		if _G["BigFatOrb_Mode"] == "Harass" then 
			return "Harass"
		end
		if _G["BigFatOrb_Mode"] == "LaneClear" then 
			return "Laneclear"
		end
		if _G["BigFatOrb_Mode"] == "LastHit" then 
			return "Lasthit"
		end
	elseif LoadedOrb == "SOW" then
		if _G.SOWi.Menu.Mode0 then 
			return "Combo"
		end
		if _G.SOWi.Menu.Mode1 then 
			return "Harass"
		end
		if _G.SOWi.Menu.Mode2 then 
			return "Laneclear"
		end
		if _G.SOWi.Menu.Mode3 then 
			return "Lasthit"
		end
	elseif LoadedOrb == "SxOrbWalk" then
		if _G.SxOrb.isFight then 
			return "Combo"
		end
		if _G.SxOrb.isHarass then 
			return "Harass"
		end
		if _G.SxOrb.isLaneClear then 
			return "Laneclear"
		end
		if _G.SxOrb.isLastHit then 
			return "Lasthit"
		end
	elseif LoadedOrb == "S1mpleOrbWalker" then
		if S1.aamode == "sbtw" then 
			return "Combo"
		end
		if S1.aamode == "harass" then 
			return "Harass"
		end
		if S1.aamode == "laneclear" then 
			return "Laneclear"
		end
		if S1.aamode == "lasthit" then 
			return "Lasthit"
		end
	end
end

function Print(msg)
	print("<font color=\"#5E9C19\"><b>[HiranN's Kled]</b></font> ".."<font color=\"#158583\"><b>"..msg.."</b></font>")
end

class 'Kled'

function Kled:__init()
	require 'VPrediction'
	VP = VPrediction()
    self.Version = 0.10
	self:Callbacks()
	self:Menu()
	self:Update()
end

function SpellsRanges(spell)
	if spell == _Q then
		if myHero:GetSpellData(_Q).name == "KledQ" then
			return 750
		else
			return 680
		end
	end
	if spell == _E then
		return 610
	end
end

function Kled:Update()
    local host = "s1mplescripts.de"
    local ServerVersionDATA = GetWebResult(host, "/HiranN/BoL/Versions/Kled.version")  
    local ServerVersion = tonumber(ServerVersionDATA)
    if ServerVersionDATA then
        if ServerVersion then
            if ServerVersion > tonumber(self.Version) then
                Print("Downloading new version, don't press 2x F9.")
                GetWebFile("s1mplescripts.de","/HiranN/BoL/Scripts/Kled.lua",{},SCRIPT_PATH..GetCurrentEnv().FILE_NAME)
            else
                Print("You are using the latest version. ("..self.Version..")")
            end
        end
    else
        Print("Could not connect to update Server.")
    end
end

function Kled:Callbacks()
	AddTickCallback(function() self:Ticks() end)
	AddDrawCallback(function() self:Draws() end)
end

function Kled:Menu()
	Menu = scriptConfig("HiranN's Kled", "KledByHiranN")

	Menu:addSubMenu("Spell: Q", "Q")
	Menu:addSubMenu("Spell: E", "E")

	Menu:addSubMenu("Killsteal", "KS")

	Menu:addSubMenu("Draws", "DR")

	ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, SpellsRanges(_Q) + 100, DAMAGE_MAGICAL)
	ts.name = "Kled"
	Menu:addTS(ts)

	OrbsW()
	self:SubMenu()
end

function Kled:SubMenu()
	Menu.Q:addParam("Combo", "Use Q in : Combo", SCRIPT_PARAM_ONOFF, true)
	Menu.Q:addParam("Harass", "Use Q in : Harass", SCRIPT_PARAM_ONOFF, false)
	Menu.Q:addParam("HC", "Q HitChance", SCRIPT_PARAM_SLICE, 1, 1, 3, 0)

	Menu.E:addParam("Combo", "Use E in : Combo", SCRIPT_PARAM_ONOFF, true)

    if myHero:GetSpellData(SUMMONER_1).name:find("SummonerDot") then 
        Ignite = SUMMONER_1
    elseif myHero:GetSpellData(SUMMONER_2).name:find("SummonerDot") then 
        Ignite = SUMMONER_2
    end
    Menu.KS:addSubMenu("Champion Filter", "Filter")
    for _, enemy in pairs(GetEnemyHeroes()) do
        Menu.KS.Filter:addParam(enemy.charName, "Enable Killsteal in : "..enemy.charName, SCRIPT_PARAM_ONOFF, true)
    end
    if Ignite then
        Menu.KS:addParam("Ignite", "Use Ignite for : Killsteal", SCRIPT_PARAM_ONOFF, true)
    else
		Menu.KS:addParam("Info", "You don't have Ignite", SCRIPT_PARAM_INFO, "")
    end

	Menu.DR:addSubMenu("Colors", "Colors")
    Menu.DR.Colors:addParam("AA", "AA Range Color", SCRIPT_PARAM_COLOR, {00, 32, 00, 0})
	Menu.DR.Colors:addParam("Q", "Q Color", SCRIPT_PARAM_COLOR, {18, 22, 21, 0})
	Menu.DR.Colors:addParam("E", "E Color", SCRIPT_PARAM_COLOR, {04, 53, 61, 0})

	Menu.DR:addParam("All", "Disable all Drawings", SCRIPT_PARAM_ONOFF, false)
    Menu.DR:addParam("AA", "AA Range Drawing", SCRIPT_PARAM_ONOFF, true)
	Menu.DR:addParam("Q", "Q Drawing", SCRIPT_PARAM_ONOFF, true)
	Menu.DR:addParam("E", "E Drawing", SCRIPT_PARAM_ONOFF, true)
end

function Kled:Ticks()
	if not myHero.dead then
		ts:update()
		Target = ts.target
		if Target and Target.valid then
			self:Combo(Target)
			self:Harass(Target)
		end
		self:Killsteal()
	end
end

function Kled:Combo(enemy)
	if OrbKeys() == "Combo" then
		if Menu.E.Combo then
			self:E(enemy)
		end
		if Menu.Q.Combo then
			self:Q(enemy)
		end
	end
end

function Kled:Harass(enemy)
	if OrbKeys() == "Harass" then
		if Menu.Q.Harass then
			self:Q(enemy)
		end
		if Menu.E.Harass then
			self:E(enemy)
		end
	end
end

function Kled:Q(enemy)
	if self:CanUseSpell(_Q, enemy) and ValidTarget(enemy) then
		if myHero:GetSpellData(_Q).name == "KledQ" then
			local CastPosition, HitChance, Position = VP:GetLineCastPosition(enemy, 0.25, 50, SpellsRanges(_Q), 2000, myHero, false)
     		if CastPosition and HitChance >= Menu.Q.HC and GetDistance(CastPosition) < SpellsRanges(_Q) then
        		CastSpell(_Q, CastPosition.x, CastPosition.z)
     		end
     	else
			local CastPosition, HitChance, Position = VP:GetLineCastPosition(enemy, 0.25, 60, SpellsRanges(_Q), 2000, myHero, false)
     		if CastPosition and (GetDistance(CastPosition) < 250 or GetDistance(CastPosition) > SpellsRanges(_Q) - 50) then
        		CastSpell(_Q, CastPosition.x, CastPosition.z)
     		end
     	end
	end
end

function Kled:E(enemy)
	if self:CanUseSpell(_E, enemy) and ValidTarget(enemy) then
		if myHero:GetSpellData(_E).name == "KledE" then
			CastSpell(_E, enemy)
		else
			if GetDistance(enemy) >= myHero.range + 115 then
				CastSpell(_E, enemy)
			end
		end
	end
end

function Kled:Killsteal()
    if myHero.dead then
        return
    end
    for _, enemy in pairs(GetEnemyHeroes()) do
        if Menu.KS.Filter[enemy.charName] and GetDistance(enemy) <= 600 + 200 then
            if Ignite and Menu.KS.Ignite and enemy.health <= 50 + (20 * myHero.level) and myHero:CanUseSpell(Ignite) == READY and ValidTarget(enemy) and GetDistance(enemy) <= 600 then
                CastSpell(Ignite, enemy)
            end
        end
    end
end

function Kled:CanUseSpell(spell, enemy)
	if myHero:CanUseSpell(spell) == READY then
		if enemy and enemy.valid and GetDistance(myHero, enemy) > SpellsRanges(spell) then
			return false
		end
		return true
	end
	return false
end

function Kled:Draws()
	if myHero.dead or Menu.DR.All then 
		return 
	end

    if Menu.DR.AA then
        DrawCircle(myHero.x, myHero.y, myHero.z, myHero.range + 65, ARGB(Menu.DR.Colors.AA[1],Menu.DR.Colors.AA[2],Menu.DR.Colors.AA[3],Menu.DR.Colors.AA[4]))
    end

	if Menu.DR.Q and self:CanUseSpell(_Q) then
		DrawCircle(myHero.x, myHero.y, myHero.z, SpellsRanges(_Q), ARGB(Menu.DR.Colors.Q[1],Menu.DR.Colors.Q[2],Menu.DR.Colors.Q[3],Menu.DR.Colors.Q[4]))
	end

	if Menu.DR.E and self:CanUseSpell(_E) then
		DrawCircle(myHero.x, myHero.y, myHero.z, SpellsRanges(_E), ARGB(Menu.DR.Colors.E[1],Menu.DR.Colors.E[2],Menu.DR.Colors.E[3],Menu.DR.Colors.E[4]))
	end
end

function TCPGetRequest(server, path, data, port)
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

function GetWebFile(server, path, data, localfilename, port, b64)
	local r,s,t = TCPGetRequest(server, path, data, port)
	
	local a,b 
	if b64 then
		a,b = Base64Decode(r)
	else
		a = r
	end
	if (a ~= "No_new_version" and a ~= "Invalid Request" and a ~= "MYSQL Error" and a ~= "") then
		file = io.open(localfilename,"w+b")
		file:write(a)
		file:close()
		Print("New version downloaded, press 2x F9.")
		return true
	else
		if a ~= "No_new_version" then
			print(a, 4)
		end
		return false
	end
end

-- START: BOL TOOLS.
assert(load(Base64Decode("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"), nil, "bt", _ENV))()
TrackerLoad("er04abD5KXF1igcy")
-- END: BOL TOOLS.