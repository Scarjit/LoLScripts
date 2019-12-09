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

local script_version = 0.4
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

local function GetWebFile(server, path, data, localfilename, port)
	local r,s,t = TCPGetRequest(server, path, data, port)
	local a,b = Base64Decode(r)
	if (a ~= "No_new_version" and a ~= "Invalid Request" and a ~= "MYSQL Error" and a ~= "") then
		file = io.open(localfilename,"w+b")
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
  _______                            _   _            _    _                 _           _                  ______                      _    
 |___  (_)                          | | | |          | |  | |               | |         (_)                |  ____|                    | |   
    / / _  __ _  __ _ ___           | |_| |__   ___  | |__| | _____  ___ __ | | ___  ___ ___   _____  ___  | |__  __  ___ __   ___ _ __| |_  
   / / | |/ _` |/ _` / __|    __    | __| '_ \ / _ \ |  __  |/ _ \ \/ / '_ \| |/ _ \/ __| \ \ / / _ \/ __| |  __| \ \/ / '_ \ / _ \ '__| __| 
  / /__| | (_| | (_| \__ \   |__|   | |_| | | |  __/ | |  | |  __/>  <| |_) | | (_) \__ \ |\ V /  __/\__ \ | |____ >  <| |_) |  __/ |  | |_  
 /_____|_|\__, |\__, |___/           \__|_| |_|\___| |_|  |_|\___/_/\_\ .__/|_|\___/|___/_| \_/ \___||___/ |______/_/\_\ .__/ \___|_|   \__| 
           __/ | __/ |                                                | |                                              | |                   
          |___/ |___/                                                 |_|                                              |_|                   		 
--]]

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
		menu.key:addParam("Flee", "Flee Key", SCRIPT_PARAM_ONKEYDOWN, false, GetKey('G'))
		menu.key:addParam("asisted", "Assisted W Key", SCRIPT_PARAM_ONKEYDOWN, false, GetKey('T'))
		menu.key:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
		menu.key:addParam("Info", "Orbwalkers keys integrated with", SCRIPT_PARAM_INFO, "")
    	menu.key:addParam("Info", "your orbwalker.", SCRIPT_PARAM_INFO, "")

	menu:addSubMenu("Spell Settings", "spells")
		menu.spells:addSubMenu("Q", "q")
			menu.spells.q:addParam("Blank", "    General", SCRIPT_PARAM_INFO, "")
			menu.spells.q:addParam("onc", "Use on Combo", SCRIPT_PARAM_ONOFF, true)
			menu.spells.q:addParam("manaonc", "If My Mana Percent > %X", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
			menu.spells.q:addParam("onp", "Use on Mixed Mode", SCRIPT_PARAM_ONOFF, true)
			menu.spells.q:addParam("manaonp", "If My Mana Percent > %X", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
			menu.spells.q:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
			menu.spells.q:addParam("onf", "Use on LaneClear", SCRIPT_PARAM_ONOFF, true)
			menu.spells.q:addParam("manaonf", "If My Mana Percent > %X", SCRIPT_PARAM_SLICE, 60, 0, 100, 0)
			menu.spells.q:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
			menu.spells.q:addParam("onj", "Use on JungleClear", SCRIPT_PARAM_ONOFF, true)
			menu.spells.q:addParam("manaonj", "If My Mana Percent > %X", SCRIPT_PARAM_SLICE, 20, 0, 100, 0)
			menu.spells.q:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
			menu.spells.q:addParam("onh", "Use on LastHit", SCRIPT_PARAM_ONOFF, true)
			menu.spells.q:addParam("tog", "Toggle Use", SCRIPT_PARAM_ONOFF, false)
			menu.spells.q:addParam("manaonh", "If My Mana Percent > %X", SCRIPT_PARAM_SLICE, 60, 0, 100, 0)
			menu.spells.q:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
			menu.spells.q:addParam("Blank", "    Extras", SCRIPT_PARAM_INFO, "")
			menu.spells.q:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
			menu.spells.q:addParam("ksq", "Use Q for KS", SCRIPT_PARAM_ONOFF, true)
			menu.spells.q:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
			menu.spells.q:addParam("jsq", "Use Q for JS(JungleSteal)", SCRIPT_PARAM_ONOFF, true)
			menu.spells.q:addParam("baron", "Baron Nashor", SCRIPT_PARAM_ONOFF, true)
    		menu.spells.q:addParam("dragon", "Dragon", SCRIPT_PARAM_ONOFF, true)
    		menu.spells.q:addParam("crab", "Rift Scuttler", SCRIPT_PARAM_ONOFF, true)
    		menu.spells.q:addParam("blue", "Blue Sentinel", SCRIPT_PARAM_ONOFF, true)
    		menu.spells.q:addParam("red", "Red Brambleback", SCRIPT_PARAM_ONOFF, true)
    		menu.spells.q:addParam("gromp", "Gromp", SCRIPT_PARAM_ONOFF, true)
    		menu.spells.q:addParam("raptor", "Crimson Raptor", SCRIPT_PARAM_ONOFF, true)
    		menu.spells.q:addParam("wolf", "Greater Murk Wolf", SCRIPT_PARAM_ONOFF, true)
    		menu.spells.q:addParam("krug", "Ancient Krug", SCRIPT_PARAM_ONOFF, true)

		menu.spells:addSubMenu("W", "w")
			menu.spells.w:addParam("Blank", "    General", SCRIPT_PARAM_INFO, "")
			menu.spells.w:addParam("onc", "Use on Combo", SCRIPT_PARAM_ONOFF, true)
			menu.spells.w:addParam("manaonc", "If My Mana Percent > %X", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
			menu.spells.w:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
			menu.spells.w:addParam("onf", "Use on LaneClear", SCRIPT_PARAM_ONOFF, false)
			menu.spells.w:addParam("min", "Min. Minion For W", SCRIPT_PARAM_SLICE, 3, 1, 5, 0)
			menu.spells.w:addParam("manaonf", "If My Mana Percent > %X", SCRIPT_PARAM_SLICE, 60, 0, 100, 0)
			menu.spells.w:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
			menu.spells.w:addParam("onj", "Use on JungleClear", SCRIPT_PARAM_ONOFF, false)
			menu.spells.w:addParam("manaonj", "If My Mana Percent > %X", SCRIPT_PARAM_SLICE, 45, 0, 100, 0)
			menu.spells.w:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
			menu.spells.w:addParam("onh", "Use on LastHit", SCRIPT_PARAM_ONOFF, false)
			menu.spells.w:addParam("manaonh", "If My Mana Percent > %X", SCRIPT_PARAM_SLICE, 60, 0, 100, 0)
			menu.spells.w:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
			menu.spells.w:addParam("Blank", "    Extras", SCRIPT_PARAM_INFO, "")
			menu.spells.w:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
			menu.spells.w:addParam("tur", "Use W for Destroy Turret", SCRIPT_PARAM_ONOFF, true)
			menu.spells.w:addParam("ksw", "Use W for KS", SCRIPT_PARAM_ONOFF, true)
			menu.spells.w:addParam("wint", "Use W for Interrupt", SCRIPT_PARAM_ONOFF, true)
			menu.spells.w:addParam("wgap", "Use W for Anti-Gapcloser", SCRIPT_PARAM_ONOFF, true)
			menu.spells.w:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
			menu.spells.w:addParam("jsw", "Use W for JS(JungleSteal)", SCRIPT_PARAM_ONOFF, false)
			menu.spells.w:addParam("baron", "Baron Nashor", SCRIPT_PARAM_ONOFF, true)
    		menu.spells.w:addParam("dragon", "Dragon", SCRIPT_PARAM_ONOFF, true)
    		menu.spells.w:addParam("crab", "Rift Scuttler", SCRIPT_PARAM_ONOFF, true)
    		menu.spells.w:addParam("blue", "Blue Sentinel", SCRIPT_PARAM_ONOFF, true)
    		menu.spells.w:addParam("red", "Red Brambleback", SCRIPT_PARAM_ONOFF, true)
    		menu.spells.w:addParam("gromp", "Gromp", SCRIPT_PARAM_ONOFF, true)
    		menu.spells.w:addParam("raptor", "Crimson Raptor", SCRIPT_PARAM_ONOFF, true)
    		menu.spells.w:addParam("wolf", "Greater Murk Wolf", SCRIPT_PARAM_ONOFF, true)
    		menu.spells.w:addParam("krug", "Ancient Krug", SCRIPT_PARAM_ONOFF, true)

		menu.spells:addSubMenu("E", "e")
			menu.spells.e:addParam("Blank", "    General", SCRIPT_PARAM_INFO, "")
			menu.spells.e:addParam("onc", "Use on Combo", SCRIPT_PARAM_ONOFF, true)
			menu.spells.e:addParam("manaonc", "If My Mana Percent > %X", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
			menu.spells.e:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
			menu.spells.e:addParam("onf", "Use on LaneClear", SCRIPT_PARAM_ONOFF, false)
			menu.spells.e:addParam("min", "Min. Minion For E", SCRIPT_PARAM_SLICE, 3, 1, 5, 0)
			menu.spells.e:addParam("manaonf", "If My Mana Percent > %X", SCRIPT_PARAM_SLICE, 50, 0, 100, 0)
			menu.spells.e:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
			menu.spells.e:addParam("onj", "Use on JungleClear", SCRIPT_PARAM_ONOFF, false)
			menu.spells.e:addParam("manaonj", "If My Mana Percent > %X", SCRIPT_PARAM_SLICE, 50, 0, 100, 0)
			menu.spells.e:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
			menu.spells.e:addParam("Blank", "    Extras", SCRIPT_PARAM_INFO, "")
			menu.spells.e:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
			menu.spells.e:addParam("egap", "Use E for Anti-Gapcloser", SCRIPT_PARAM_ONOFF, true)

		menu.spells:addSubMenu("R", "r")
			menu.spells.r:addParam("Blank", "    General", SCRIPT_PARAM_INFO, "")
			menu.spells.r:addParam("onc", "Use on Combo", SCRIPT_PARAM_ONOFF, true)
			menu.spells.r:addParam("manaonc", "If My Mana Percent > %X", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
			menu.spells.r:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
			menu.spells.r:addParam("Blank", "    Extras", SCRIPT_PARAM_INFO, "")
			menu.spells.r:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
			menu.spells.r:addParam("ksr", "Use R for KS", SCRIPT_PARAM_ONOFF, true)
			menu.spells.r:addParam("minrange", "Min. Range to use", SCRIPT_PARAM_SLICE, 1000, 550, 5300, 0)
			menu.spells.r:addParam("maxrange", "Max. Range to use", SCRIPT_PARAM_SLICE, 3500, 1000, 5300, 0)
			menu.spells.r:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
			menu.spells.r:addParam("jsr", "Use R for JS(JungleSteal)", SCRIPT_PARAM_ONOFF, true)
			menu.spells.r:addParam("baron", "Baron Nashor", SCRIPT_PARAM_ONOFF, true)
    		menu.spells.r:addParam("dragon", "Dragon", SCRIPT_PARAM_ONOFF, true)

    	menu:addSubMenu("Draw Settings", "draws")
    		menu.draws:addParam("On", "Draw", SCRIPT_PARAM_ONOFF, true)
    		menu.draws:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
    		menu.draws:addParam("AA", "Draw Attack range", SCRIPT_PARAM_ONOFF, false)
    		menu.draws:addParam("Q", "Draw Q range", SCRIPT_PARAM_ONOFF, true)
    		menu.draws:addParam("W", "Draw W range", SCRIPT_PARAM_ONOFF, false)
    		menu.draws:addParam("E", "Draw E range", SCRIPT_PARAM_ONOFF, false)
    		menu.draws:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
    		menu.draws:addParam("ppQ", "Draw Q Bounce Prediction", SCRIPT_PARAM_ONOFF, true)
    		menu.draws:addParam("Hitchance", "Draw Hitchance", SCRIPT_PARAM_ONOFF, true)



	--End Champ Specific
	
	menu:addParam("autoupdate","Autoupdate", SCRIPT_PARAM_ONOFF, true) --DONE
	menu:addParam("version", "Version: ", SCRIPT_PARAM_INFO, script_version) --DONE
end

--VARIABLES

local function Variables()

  Q = {range = 1400, radius = 155, speed = 1750, delay = 0.25}
  W = {range = 970, radius = 275, speed = 1800, delay = 0.25}
  E = {range = 900, radius = 350, speed = 1750, delay = 0.12}
  R = {range = 5300, radius = 525, speed = 1750, delay = 0.14}

  JungleMobs = minionManager(MINION_JUNGLE, Q.range+100, myHero, MINION_SORT_MAXHEALTH_DEC)
  EnemyMinions = minionManager(MINION_ENEMY, E.range+100, myHero, MINION_SORT_MAXHEALTH_DEC)

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
--END VARIABLES

--LOADED ORBWWALKER
local LoadedWalker

local function GetOrbWalker()
	if _G.S1OrbLoading or _G.S1mpleOrbLoaded then LoadedWalker = "S1Orb" end
	if _G.Reborn_Loaded or _G.AutoCarry then LoadedWalker = "SAC:R" end
	if SAC then LoadedWalker = "SAC:P" end
	if _Pewalk then LoadedWalker = "PEW" end
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
		return 0
	elseif LoadedWalker == "SAC:R" then
		if not _G.AutoCarry or not _G.AutoCarry.Keys then return 0 end
		if _G.AutoCarry.Keys.MixedMode then return 1 end
		if _G.AutoCarry.Keys.LaneClear then return 2 end
		if _G.AutoCarry.Keys.LastHit then return 3 end
		if _G.AutoCarry.Keys.AutoCarry then return 4 end
		return 0
	elseif LoadedWalker == "SAC:P" then
		if SAC:GetActiveMode() == "MixedMode" then return 1 end
		if SAC:GetActiveMode() == "Laneclear" then return 2 end
		if SAC:GetActiveMode() == "LastHit" then return 3 end
		if SAC:GetActiveMode() == "AutoCarry" then return 4 end		
		return 0
	elseif LoadedWalker == "PEW" then
		if not _Pewalk then return 0 end
		if _Pewalk.GetActiveMode().Mixed then return 1 end
		if _Pewalk.GetActiveMode().LaneClear then return 2 end
		if _Pewalk.GetActiveMode().Farm then return 3 end
		if _Pewalk.GetActiveMode().Carry then return 4 end
		return 0
	end
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
	end
end

local function GetCTarget(range)
	if not range then return end
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
      APDmg = 45*myHero:GetSpellData(_Q).level+25+.65*AP
    end
    
    elseif spell == "W" then
  
    if myHero:CanUseSpell(_W) == READY then
      APDmg = 35*myHero:GetSpellData(_W).level+35+.35*AP
    end
    
    elseif spell == "E" then
  
    if myHero:CanUseSpell(_E) == READY then
      APDmg = (25*myHero:GetSpellData(_E).level+15+.3*AP)+(10*myHero:GetSpellData(_E).level+6+.12*AP)
    end

    elseif spell == "R" then
  
    if myHero:CanUseSpell(_R) == READY then
      APDmg = 100*myHero:GetSpellData(_R).level+100+.7*AP
    end
    
  end
  
  local TrueDmg = ADDmg*(1-ArmorPercent)+APDmg*(1-MagicArmorPercent)
  
  return TrueDmg
end
end

local function CastQ(unit)
 
	if unit.dead then return end 

	if GetDistance(unit, myHero) > Q.range-5 then
      QStartPos = CircleIntersection(myHero, unit, myHero, Q.range-5)
    else
      QStartPos = Vector(unit.x, unit.y, unit.z)
	end

	local PosQ, HcQ, info = FHPrediction.GetPrediction("Q", unit, QStartPos)
    if HcQ > 1.1 and PosQ ~= nil then
       if not info.collision then
        CastSpell3(_Q, D3DXVECTOR3(QStartPos.x, 0, QStartPos.z), D3DXVECTOR3(PosQ.x, 0, PosQ.z))
	   end
    end
end

local function CastW(unit)
  
if unit.dead then return end  

local PosW, HcW, info = FHPrediction.GetPrediction("W", unit)
    if HcW > 1.3 and PosW ~= nil then
       CastSpell(_W, PosW.x, PosW.z)
	end
end

local function CastE(unit)
  
if unit.dead then return end  

local PosE, HcE, info = FHPrediction.GetPrediction("E", unit)
    if HcE > 1.5 and PosE ~= nil then
       CastSpell(_E, PosE.x, PosE.z)
	end
end

local function CastR(unit)

if unit.dead then return end 
  
local PosR, HcR, info = FHPrediction.GetPrediction({range = R.range, speed = R.speed, delay = R.delay, radius = R.radius, type = SkillShotType.SkillshotCircle}, unit)
    if HcR > 1.4 and PosR ~= nil then
      CastSpell(_R, PosR.x, PosR.z)
    end
end

--END LOADED ORBWWALKER

-- NORMAL MODES

local function Flee()
  MoveToMouse()
end

function MoveToMouse()

  MPos = Vector(mousePos.x, mousePos.y, mousePos.z)
  HeroPos = Vector(myHero.x, myHero.y, myHero.z)
  DashPos = HeroPos + ( HeroPos - MPos )*(100/GetDistance(mousePos))
  myHero:MoveTo(mousePos.x, mousePos.z)
  CastSpell(_W, DashPos.x, DashPos.z)
  myHero:MoveTo(mousePos.x, mousePos.z)

end

local function AsistedW()

local WTarget = GetCTarget(970)
  myHero:MoveTo(mousePos.x, mousePos.z)
    if myHero:CanUseSpell(_W) == READY then
      if WTarget and WTarget.visible and not WTarget.dead and WTarget.bTargetable and WTarget.type == myHero.type then
        CastW(WTarget)
      end
    end
  myHero:MoveTo(mousePos.x, mousePos.z)

end

local function DestroyTower()

for i, turret in pairs(GetTurrets()) do
	if turret ~= nil and turret.team ~= player.team and GetDistanceSqr(turret) <= (950*950) then

			if (.025*myHero:GetSpellData(_W).level+.225)*turret.maxHealth >= turret.health then
				CastW(turret)
			end

		end
	end
end


local function Combo()
  	
  	local QTarget = GetCTarget(1400)
    local ComboQ = menu.spells.q.onc
    local ComboQ1 = menu.spells.q.manaonc
  
    if myHero:CanUseSpell(_Q) == READY and ComboQ and ComboQ1 <= (myHero.mana/myHero.maxMana*100) then
    
      if QTarget and QTarget.visible and not QTarget.dead and QTarget.bTargetable and QTarget.type == myHero.type then
        CastQ(QTarget)
      end
      
    end
    
    local WTarget = GetCTarget(970)
    local ComboW = menu.spells.w.onc
    local ComboW1 = menu.spells.w.manaonc
  
    if myHero:CanUseSpell(_W) == READY and ComboW and ComboW1 <= (myHero.mana/myHero.maxMana*100) then
    
      if WTarget and WTarget.visible and not WTarget.dead and WTarget.bTargetable and WTarget.type == myHero.type then
        CastW(WTarget)
      end
       
    end
    
    local ETarget = GetCTarget(900)
    local ComboE = menu.spells.e.onc
    local ComboE1 =menu.spells.e.manaonc
  
    if myHero:CanUseSpell(_E) == READY and ComboE and ComboE1 <= (myHero.mana/myHero.maxMana*100) then
    
      if ETarget and ETarget.visible and not ETarget.dead and ETarget.bTargetable and ETarget.type == myHero.type then
        CastE(ETarget)
      end
        
    end
    
    local RTarget = GetCTarget(1800) -------------------------------
    local ComboR = menu.spells.r.onc
    local ComboR1 =menu.spells.r.manaonc
  
    if myHero:CanUseSpell(_R) == READY and ComboR and ComboR1 <= (myHero.mana/myHero.maxMana*100) then
    
     	if RTarget and RTarget.visible and not RTarget.dead and RTarget.bTargetable and RTarget.type == myHero.type then
      	 	if (GetDmg("Q", RTarget)+GetDmg("W", RTarget)+GetDmg("R", RTarget)) >= RTarget.health then
        		CastR(RTarget)
      		end
      
    	end

	end

end

local function Harras()

	local QTarget = GetCTarget(1400)
    local HarassQ = menu.spells.q.onp
    local HarassQ1 = menu.spells.q.manaonp
  
    if myHero:CanUseSpell(_Q) == READY and HarassQ and HarassQ1 <= (myHero.mana/myHero.maxMana*100) then
    
      if QTarget and QTarget.visible and not QTarget.dead and QTarget.bTargetable and QTarget.type == myHero.type then
        CastQ(QTarget)
      end
      
    end

end

local function Laneclear()

	--local QTarget = GetCTarget(1400)
    local JFarmQ = menu.spells.q.onj
    local JFarmQ1 = menu.spells.q.manaonj

	for i, minion in pairs(mm_instance.objects) do
  
    	if myHero:CanUseSpell(_Q) == READY and JFarmQ and JFarmQ1 <= (myHero.mana/myHero.maxMana*100) then
    
      		if minion and minion.visible and not minion.dead and minion.bTargetable then
        		CastQ(minion)
      		end
      
    	end

    end
    
    --local WTarget = GetCTarget(970)
    local FarmW = menu.spells.w.onf
    local FarmW1 = menu.spells.w.manaonf
    local WMin = menu.spells.w.min
  
    if myHero:CanUseSpell(_W) == READY and FarmW and FarmW1 <= (myHero.mana/myHero.maxMana*100) then
    	
    	for i, minion in pairs(mm_instance.objects) do
			local N = 0
			local PosW = FHPrediction.PredictPosition(minion, W.delay)


			for j, minion_2 in pairs(mm_instance.objects) do
		    local PosW_2 = FHPrediction.PredictPosition(minion_2, W.delay)

				if PosW and PosW_2 and (GetDistance(PosW_2, PosW) <= W.radius) then
					N = N+1
				end

				if (N >= WMin) and PosW then
					CastSpell(_W, PosW.x, PosW.z)
					break
					break
				end
				
			end
			
		end
       
    end
	
    
    --local ETarget = GetCTarget(900)
    local FarmE = menu.spells.e.onf
    local FarmE1 =menu.spells.e.manaonf
  	local EMin = menu.spells.e.min
  
    if myHero:CanUseSpell(_E) == READY and FarmE and FarmE1 <= (myHero.mana/myHero.maxMana*100) then
    
    	for i, minion in pairs(mm_instance.objects) do
			local N = 0
			local PosE = FHPrediction.PredictPosition(minion, E.delay)

			for j, minion_2 in pairs(mm_instance.objects) do
		    local PosE_2 = FHPrediction.PredictPosition(minion_2, E.delay)

				if PosE and PosE_2 and (GetDistance(PosE_2, PosE) <= E.radius) then
					N = N+1
				end
				
				if (N >= EMin) and PosE then
					CastSpell(_E, PosE.x, PosE.z)
					break
					break
				end
				
			end
			
		end
       
    end

end

local function Jungleclear()

	--local QTarget = GetCTarget(1400)
    local JFarmQ = menu.spells.q.onj
    local JFarmQ1 = menu.spells.q.manaonj

	for i, junglemob in pairs(jm_instance.objects) do
  
    	if myHero:CanUseSpell(_Q) == READY and JFarmQ and JFarmQ1 <= (myHero.mana/myHero.maxMana*100) then
    
      		if junglemob and junglemob.visible and not junglemob.dead and junglemob.bTargetable then
        		CastQ(junglemob)
      		end
      
    	end

    --local QTarget = GetCTarget(1400)
    local JFarmW = menu.spells.w.onj
    local JFarmW1 = menu.spells.w.manaonj
  
    	if myHero:CanUseSpell(_W) == READY and JFarmW and JFarmW1 <= (myHero.mana/myHero.maxMana*100) then
    
      		if junglemob and junglemob.visible and not junglemob.dead and junglemob.bTargetable then
        		CastW(junglemob)
      		end
      
    	end

    --local QTarget = GetCTarget(1400)
    local JFarmE = menu.spells.e.onj
    local JFarmE1 = menu.spells.e.manaonj
  
    	if myHero:CanUseSpell(_E) == READY and JFarmE and JFarmE1 <= (myHero.mana/myHero.maxMana*100) then
    
      		if junglemob and junglemob.visible and not junglemob.dead and junglemob.bTargetable then
        		CastE(junglemob)
      		end
      
    	end
    end

end

local function LastHit()

  local QTarget = GetCTarget(1400)
  local LastHitQ = menu.spells.q.onh
  local LastHitQ2 = menu.spells.q.manaonh
  
  if myHero:CanUseSpell(_Q) and LastHitQ and LastHitQ2 <= (myHero.mana/myHero.maxMana*100) then
    
      local QMinionDmg = GetDmg("Q", QTarget)
      
      if QMinionDmg >= QTarget.health and ValidTarget(GetCTarget(1400)) then
        CastQ(QTarget)
      end
      
    end
  
end

local function JungleSteal()

  local JStealQ = menu.spells.q.jsq
  local JStealW = menu.spells.w.jsw
  local JStealR = menu.spells.r.jsr
  
  if myHero:CanUseSpell(_Q) == READY and JStealQ then
  
    for i, junglemob in pairs(jm_instance.objects) do
    
      local QJunglemobDmg = GetDmg("Q", junglemob)
      
      if menu.spells.q.dragon then 
        if junglemob.charName:lower():find("dragon") and QJunglemobDmg >= junglemob.health and ValidTarget(junglemob, Q.range+junglemob.boundingRadius) then
          CastQ(junglemob)
        end
      end
      if menu.spells.q.baron then
        if junglemob.name == "SRU_Baron12.1.1" and QJunglemobDmg >= junglemob.health and ValidTarget(junglemob, Q.range+junglemob.boundingRadius) then
          CastQ(junglemob)
        end
      end
      if menu.spells.q.blue then
        if junglemob.name == "SRU_Blue7.1.1" and QJunglemobDmg >= junglemob.health and ValidTarget(junglemob, Q.range+junglemob.boundingRadius) or junglemob.name == "SRU_Blue1.1.1" and QJunglemobDmg >= junglemob.health and ValidTarget(junglemob, Q.range+junglemob.boundingRadius) then
          CastQ(junglemob)
        end
      end
      if menu.spells.q.red then
        if junglemob.name == "SRU_Red10.1.1" and QJunglemobDmg >= junglemob.health and ValidTarget(junglemob, Q.range+junglemob.boundingRadius) or junglemob.name == "SRU_Red4.1.1" and QJunglemobDmg >= junglemob.health and ValidTarget(junglemob, Q.range+junglemob.boundingRadius) then
          CastQ(junglemob)
        end
      end
      if menu.spells.q.gromp then
        if junglemob.name == "SRU_Gromp14.1.1" and QJunglemobDmg >= junglemob.health and ValidTarget(junglemob, Q.range+junglemob.boundingRadius) or junglemob.name == "SRU_Gromp13.1.1" and QJunglemobDmg >= junglemob.health and ValidTarget(junglemob, Q.range+junglemob.boundingRadius) then
          CastQ(junglemob)
        end
      end
      if menu.spells.q.raptor then
        if junglemob.name == "SRU_Razorbeak9.1.1" and QJunglemobDmg >= junglemob.health and ValidTarget(junglemob, Q.range+junglemob.boundingRadius) or junglemob.name == "SRU_Razorbeak3.1.1" and QJunglemobDmg >= junglemob.health and ValidTarget(junglemob, Q.range+junglemob.boundingRadius) then
          CastQ(junglemob)
        end
      end
      if menu.spells.q.wolf then
        if junglemob.name == "SRU_Murkwolf8.1.1" and QJunglemobDmg >= junglemob.health and ValidTarget(junglemob, Q.range+junglemob.boundingRadius) or junglemob.name == "SRU_Murkwolf2.1.1" and QJunglemobDmg >= junglemob.health and ValidTarget(junglemob, Q.range+junglemob.boundingRadius) then
          CastQ(junglemob)
        end
      end
      if menu.spells.q.krug then
        if junglemob.name == "SRU_Krug5.1.2" and QJunglemobDmg >= junglemob.health and ValidTarget(junglemob, Q.range+junglemob.boundingRadius) or junglemob.name == "SRU_Krug11.1.2" and QJunglemobDmg >= junglemob.health and ValidTarget(junglemob, Q.range+junglemob.boundingRadius) then
          CastQ(junglemob)
        end
      end
      if menu.spells.q.crab then
        if junglemob.name == "Sru_Crab15.1.1" and QJunglemobDmg >= junglemob.health and ValidTarget(junglemob, Q.range+junglemob.boundingRadius) or junglemob.name == "Sru_Crab16.1.1" and QJunglemobDmg >= junglemob.health and ValidTarget(junglemob, Q.range+junglemob.boundingRadius) then
          CastQ(junglemob)
        end
      end
        
    end
    
  end

  if myHero:CanUseSpell(_W) == READY and JStealW then
  
    for i, junglemob in pairs(jm_instance.objects) do
    
      local WJunglemobDmg = GetDmg("W", junglemob)
      
      if menu.spells.w.dragon then 
        if junglemob.charName:lower():find("dragon") and WJunglemobDmg >= junglemob.health and ValidTarget(junglemob, W.range+junglemob.boundingRadius) then
          CastW(junglemob)
        end
      end
      if menu.spells.w.baron then
        if junglemob.name == "SRU_Baron12.1.1" and WJunglemobDmg >= junglemob.health and ValidTarget(junglemob, W.range+junglemob.boundingRadius) then
          CastW(junglemob)
        end
      end
      if menu.spells.w.blue then
        if junglemob.name == "SRU_Blue7.1.1" and WJunglemobDmg >= junglemob.health and ValidTarget(junglemob, W.range+junglemob.boundingRadius) or junglemob.name == "SRU_Blue1.1.1" and WJunglemobDmg >= junglemob.health and ValidTarget(junglemob, W.range+junglemob.boundingRadius) then
          CastW(junglemob)
        end
      end
      if menu.spells.w.red then
        if junglemob.name == "SRU_Red10.1.1" and WJunglemobDmg >= junglemob.health and ValidTarget(junglemob, W.range+junglemob.boundingRadius) or junglemob.name == "SRU_Red4.1.1" and WJunglemobDmg >= junglemob.health and ValidTarget(junglemob, W.range+junglemob.boundingRadius) then
          CastW(junglemob)
        end
      end
      if menu.spells.w.gromp then
        if junglemob.name == "SRU_Gromp14.1.1" and WJunglemobDmg >= junglemob.health and ValidTarget(junglemob, W.range+junglemob.boundingRadius) or junglemob.name == "SRU_Gromp13.1.1" and WJunglemobDmg >= junglemob.health and ValidTarget(junglemob, W.range+junglemob.boundingRadius) then
          CastW(junglemob)
        end
      end
      if menu.spells.w.raptor then
        if junglemob.name == "SRU_Razorbeak9.1.1" and WJunglemobDmg >= junglemob.health and ValidTarget(junglemob, W.range+junglemob.boundingRadius) or junglemob.name == "SRU_Razorbeak3.1.1" and WJunglemobDmg >= junglemob.health and ValidTarget(junglemob, W.range+junglemob.boundingRadius) then
          CastW(junglemob)
        end
      end
      if menu.spells.w.wolf then
        if junglemob.name == "SRU_Murkwolf8.1.1" and WJunglemobDmg >= junglemob.health and ValidTarget(junglemob, W.range+junglemob.boundingRadius) or junglemob.name == "SRU_Murkwolf2.1.1" and WJunglemobDmg >= junglemob.health and ValidTarget(junglemob, W.range+junglemob.boundingRadius) then
          CastW(junglemob)
        end
      end
      if menu.spells.w.krug then
        if junglemob.name == "SRU_Krug5.1.2" and WJunglemobDmg >= junglemob.health and ValidTarget(junglemob, W.range+junglemob.boundingRadius) or junglemob.name == "SRU_Krug11.1.2" and WJunglemobDmg >= junglemob.health and ValidTarget(junglemob, W.range+junglemob.boundingRadius) then
          CastW(junglemob)
        end
      end
      if menu.spells.w.crab then
        if junglemob.name == "Sru_Crab15.1.1" and WJunglemobDmg >= junglemob.health and ValidTarget(junglemob, W.range+junglemob.boundingRadius) or junglemob.name == "Sru_Crab16.1.1" and WJunglemobDmg >= junglemob.health and ValidTarget(junglemob, W.range+junglemob.boundingRadius) then
          CastW(junglemob)
        end
      end
        
    end
    
  end
  
  if myHero:CanUseSpell(_R) == READY and JStealR then
  
    for i, junglemob in pairs(jm_instance.objects) do
    
      local RJunglemobDmg = GetDmg("R", junglemob)
      
      	if menu.spells.r.dragon then 
        if junglemob.charName:lower():find("dragon") and RJunglemobDmg >= junglemob.health and ValidTarget(junglemob, R.range+junglemob.boundingRadius) then
          CastR(junglemob)
        end
      end

      if menu.spells.r.baron then
        if junglemob.name == "SRU_Baron12.1.1" and RJunglemobDmg >= junglemob.health and ValidTarget(junglemob, R.range+junglemob.boundingRadius) then
          CastR(junglemob)
        end
      end
        
    end
    
  end
  
end

local function KillSteal()

  local KillStealQ = menu.spells.q.ksq
  local KillStealW = menu.spells.q.ksw
  local KillStealR = menu.spells.q.ksr
  local QTarget = GetCTarget(1400)
  local WTarget = GetCTarget(970)
  local RTarget = GetCTarget(5300)

    local QTargetDmg = GetDmg("Q", QTarget)
    local WTargetDmg = GetDmg("W", WTarget)
    local RTargetDmg = GetDmg("R", RTarget)
    
    if QTarget and QTarget.visible and not QTarget.dead and QTarget.bTargetable and QTarget.type == myHero.type then
    	if myHero:CanUseSpell(_Q) == READY and KillStealQ and QTargetDmg >= QTarget.health then
      		CastQ(QTarget)
      	end
    end

    if WTarget and WTarget.visible and not WTarget.dead and WTarget.bTargetable and WTarget.type == myHero.type then
    	if myHero:CanUseSpell(_W) == READY and KillStealW and WTargetDmg >= WTarget.health then
      		CastW(WTarget)
      	end
    end

    if RTarget and RTarget.visible and not RTarget.dead and RTarget.bTargetable and RTarget.type == myHero.type then
    	if myHero:CanUseSpell(_R) == READY and KillStealR and RTargetDmg >= RTarget.health then
    		if GetDistance(RTarget) <= menu.spells.r.maxrange and  GetDistance(RTarget) >= menu.spells.r.minrange then
      			CastR(RTarget)
      		end
      	end
    end

end

local function Modes()
	local mode = GetOrbMode()
	if mode == 4 then
		Combo()
	elseif mode == 1 then
		Harras()
	elseif mode == 2 then
		Jungleclear()
		Laneclear()
	elseif mode == 3 then
		LastHit()
	end
end

--END NORMAL MODES

--MATH
function CalcVector(source,target)
	local V = Vector(source.x, source.y, source.z)
	local V2 = Vector(target.x, target.y, target.z)
	local vec = V-V2
	local vec2 = vec:normalized()
	return vec2
end

function CircleIntersection(v1, v2, c, radius)

  assert(VectorType(v1) and VectorType(v2) and VectorType(c) and type(radius) == "number", "wrong argument types (<Vector>, <Vector>, <Vector>, integer expected)")
  
  local x1, y1, x2, y2, x3, y3 = v1.x, v1.z or v1.y, v2.x, v2.z or v2.y, c.x, c.z or c.y
  local r = radius
  local xp, yp, xm, ym = nil, nil, nil, nil
  local IsOnSegment = nil
  
  if x1 == x2 then
  
    local B = math.sqrt(r^2-(x1-x3)^2)
    
    xp, yp, xm, ym = x1, y3+B, x1, y3-B
  else
  
    local m = (y2-y1)/(x2-x1)
    local n = y1-m*x1
    local A = x3-m*(n-y3)
    local B = math.sqrt(A^2-(1+m^2)*(x3^2-r^2+(n-y3)^2))
    
    xp, xm = (A+B)/(1+m^2), (A-B)/(1+m^2)
    yp, ym = m*xp+n, m*xm+n
  end
  
  if x1 <= x2 then
    IsOnSegment = x1 <= xp and xp <= x2
  else
    IsOnSegment = x2 <= xp and xp <= x1        
  end
  
  if IsOnSegment then
    return Vector(xp, 0, yp)
  else
    return Vector(xm, 0, ym)
  end
  
end
--END MATH

--DRAWS

local function Draws()

  if not menu.draws.On or myHero.dead then
    return
  end
  
  if HcQ ~= nil then
  
    if HcQ < 1 then
      Qcolor = ARGB(0xFF, 0xFF, 0x00, 0x00)
    elseif HcQ == 2 then
      Qcolor = ARGB(0xFF, 0x00, 0x54, 0xFF)
    elseif HcQ >= 1.5 then
      Qcolor = ARGB(0xFF, 0x1D, 0xDB, 0x16)
    elseif HcQ >= 1 then
      Qcolor = ARGB(0xFF, 0xFF, 0xE4, 0x00)
    end
  
  end
  
  if HcW ~= nil then
  
    if HcW < 1 then
      Wcolor = ARGB(0xFF, 0xFF, 0x00, 0x00)
    elseif HcW == 2 then
      Wcolor = ARGB(0xFF, 0x00, 0x54, 0xFF)
    elseif HcW >= 1.5 then
      Wcolor = ARGB(0xFF, 0x1D, 0xDB, 0x16)
    elseif HcW >= 1 then
      Wcolor = ARGB(0xFF, 0xFF, 0xE4, 0x00)
    end
  
  end
  
  if HcE ~= nil then
  
    if HcE < 1 then
      Ecolor = ARGB(0xFF, 0xFF, 0x00, 0x00)
    elseif HcE == 2 then
      Ecolor = ARGB(0xFF, 0x00, 0x54, 0xFF)
    elseif HcE >= 1.5 then
      Ecolor = ARGB(0xFF, 0x1D, 0xDB, 0x16)
    elseif HcE >= 1 then
      Ecolor = ARGB(0xFF, 0xFF, 0xE4, 0x00)
    end
  
  end

  if HcR ~= nil then
  
    if HcR < 1 then
      Rcolor = ARGB(0xFF, 0xFF, 0x00, 0x00)
    elseif HcR == 2 then
      Rcolor = ARGB(0xFF, 0x00, 0x54, 0xFF)
    elseif HcR >= 1.5 then
      Rcolor = ARGB(0xFF, 0x1D, 0xDB, 0x16)
    elseif HcR >= 1 then
      Rcolor = ARGB(0xFF, 0xFF, 0xE4, 0x00)
    end
  
  end
  
  if menu.draws.ppQ and PosQ then
  
    DrawCircle3D(QStartPos.pos.x, QStartPos.pos.y, QStartPos.pos.z, Q.radius, 2, ARGB(0xFF, 0xFF, 0x00, 0x00))
    DrawCircle3D(PosQ.pos.x, PosQ.pos.y, PosQ.pos.z, Q.radius/2, 2, Qcolor)
    
    if menu.draws.ppQ then
      DrawLine3D(QStartPos.x, QStartPos.y, QStartPos.z, PosQ.x, PosQ.y, PosQ.z, 2, Qcolor)
    end
    
  end
  
  if menu.draws.Hitchance then
  
    if HcQ ~= nil then
      DrawText("Q HitChance: "..HcQ, 20, 1250, 550, Qcolor)
    end
  
    if HcW ~= nil then
      DrawText("W HitChance: "..HcW, 20, 1250, 600, Wcolor)
    end
  
    if HcE ~= nil then
      DrawText("E HitChance: "..HcE, 20, 1250, 650, Ecolor)
    end

    if HcR ~= nil then
      DrawText("R HitChance: "..HcR, 20, 1250, 700, Rcolor)
    end
    
  end
  
  if menu.draws.AA then
  	DrawCircle3D(myHero.pos.x, myHero.pos.y, myHero.pos.z, myHero.range+myHero.boundingRadius, 2, ARGB(0xFF, 0, 0xFF, 0))
  end
  
  if menu.draws.Q and myHero:CanUseSpell(_Q) == READY then
    DrawCircle3D(myHero.pos.x, myHero.pos.y, myHero.pos.z, Q.range, 2, ARGB(0xFF, 0, 0xFF, 0))
  end
  
  if menu.draws.W and myHero:CanUseSpell(_W) == READY then
    DrawCircle3D(myHero.pos.x, myHero.pos.y, myHero.pos.z, W.range, 2, ARGB(0xFF, 0, 0xFF, 0))
  end
  
  if menu.draws.E and myHero:CanUseSpell(_E) == READY then
    DrawCircle3D(myHero.pos.x, myHero.pos.y, myHero.pos.z, E.range, 2, ARGB(0xFF, 0, 0xFF, 0))
  end

end

local function DebugDraws()
	if min_log_level ~= 1 then return end
	DrawTextA(GetOrbMode())
		--[[
		Target <= 850 Units away
			-> No bounce
		Target >= 1400 Units away
			-> Out of Range
		Else
			Predict if explode at Bounce 1 (850 U)
				If not
					Cast
				Else
					Don't Cast
	]]
end
--END DRAWS

AddLoadCallback(function()
	if not GetOrbWalker() then return end
	Menu()
	Variables()
	Update()
end)

AddDrawCallback(function()
	--if not LoadedWalker then return end
	Draws()
	DebugDraws()
end)

AddTickCallback(function()
	ts_instance:update()
	jm_instance:update()
	mm_instance:update()
	Modes()
	if menu.spells.w.tur then
	DestroyTower()
	end
	if menu.key.Flee then
	Flee()
	end
	if menu.key.asisted then
	AsistedW()
	end
	JungleSteal()
	KillSteal()
end)

AddProcessSpellCallback(function(unit, spell)
	if not LoadedWalker then return end

if menu.spells.w.wint then
for index, data in pairs(InterruptList) do
  for index, enemy in pairs(GetEnemyHeroes()) do
     if data["charName"] == enemy.charName then
        if InterruptList[spell.name] and GetDistanceSqr(unit) <= 750*750 and myHero:CanUseSpell(_W) == READY then
        CastW(unit)
        end
    end
  end
end
end

if menu.spells.w.wgap then
for index, data in pairs(GapCloserList) do
  for index, enemy in pairs(GetEnemyHeroes()) do
    if data["charName"] == enemy.charName then
        if GapCloserList[spell.name] then
            if spell.target and spell.target.networkID == myHero.networkID then
              if unit.team ~= myHero.team and myHero:CanUseSpell(_W) == READY then
              CastW(unit)
              end
            end
        end
    end
  end
end
end

if menu.spells.w.wgap then
for index, data in pairs(GapCloserList) do
  for index, enemy in pairs(GetEnemyHeroes()) do
    if data["charName"] == enemy.charName then
        if GapCloserList[spell.name] and GetDistanceSqr(unit) <= 2000*2000 and (spell.target == nil or (spell.target and spell.target.isMe)) then
            if unit.team ~= myHero.team and myHero:CanUseSpell(_W) == READY then
                SpellInfo = {
                  Source = unit,
                  CastTime = os.clock(),
                  StartPos = Point(unit.pos.x, unit.pos.z),
                  Range = GapCloserList[spell.name].range,
                  Speed = GapCloserList[spell.name].projSpeed,
                }
                CastW(unit)
            end
        end
    end
  end
end
end

if menu.spells.e.egap then
for index, data in pairs(GapCloserList) do
  for index, enemy in pairs(GetEnemyHeroes()) do
    if data["charName"] == enemy.charName then
        if GapCloserList[spell.name] then
            if spell.target and spell.target.networkID == myHero.networkID then
              if unit.team ~= myHero.team and myHero:CanUseSpell(_E) == READY then
              CastE(unit)
              end
            end
        end
    end
  end
end
end

if menu.spells.e.egap then
for index, data in pairs(GapCloserList) do
  for index, enemy in pairs(GetEnemyHeroes()) do
    if data["charName"] == enemy.charName then
        if GapCloserList[spell.name] and GetDistanceSqr(unit) <= 2000*2000 and (spell.target == nil or (spell.target and spell.target.isMe)) then
            if unit.team ~= myHero.team and myHero:CanUseSpell(_E) == READY then
                SpellInfo = {
                  Source = unit,
                  CastTime = os.clock(),
                  StartPos = Point(unit.pos.x, unit.pos.z),
                  Range = GapCloserList[spell.name].range,
                  Speed = GapCloserList[spell.name].projSpeed,
                }
                CastE(unit)
            end
        end
    end
  end
end
end

end)

AddProcessAttackCallback(function(unit, spell)
	if not LoadedWalker then return end
end)

--[[AddCreateObjCallback(function(object)
	if not LoadedWalker then return end
end)]]

AddBugsplatCallback(function ()
	local file = io.open(SCRIPT_PATH.."S1Ts.bugsplat", "a")
	file:write("\n"..tostring(debug.traceback()))
	file:close()
end)