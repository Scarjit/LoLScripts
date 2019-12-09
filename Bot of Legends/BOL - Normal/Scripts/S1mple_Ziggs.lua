--[[ 
   _____ __                 _        _______                   _              _____ __                 _       _____           _       _       
  / ____/_ |               | |      |___  (_)                 | |            / ____/_ |               | |     / ____|         (_)     | |      
 | (___  | |_ __ ___  _ __ | | ___     / / _  __ _  __ _ ___  | |__  _   _  | (___  | |_ __ ___  _ __ | | ___| (___   ___ _ __ _ _ __ | |_ ___ 
  \___ \ | | '_ ` _ \| '_ \| |/ _ \   / / | |/ _` |/ _` / __| | '_ \| | | |  \___ \ | | '_ ` _ \| '_ \| |/ _ \\___ \ / __| '__| | '_ \| __/ __|
  ____) || | | | | | | |_) | |  __/  / /__| | (_| | (_| \__ \ | |_) | |_| |  ____) || | | | | | | |_) | |  __/____) | (__| |  | | |_) | |_\__ \
 |_____/ |_|_| |_| |_| .__/|_|\___| /_____|_|\__, |\__, |___/ |_.__/ \__, | |_____/ |_|_| |_| |_| .__/|_|\___|_____/ \___|_|  |_| .__/ \__|___/
                     | |                      __/ | __/ |             __/ |                     | |                             | |            
                     |_|                     |___/ |___/             |___/                      |_|                             |_|            

	Yeah, finaly got an ASCII Art :)

	S1mple Ziggs by S1mple
	Credit's:
	Orianna for helping me out with the Orbwalker Detection
	PvPSuite for the Keydown Fix
	KuroXNeko for the Banner on my Thread
	giannis koulis_418212 for reporting a Bug (Ulthelper was not working) i had, wich was in the end a not implemented function ^^ (Failed to put the Function into OnTick())
]]--
local chkupdates = false --Set to "true" to check for updates without downloading them
local autoupdate = true --Set to "true" for autoupdate
local chknews = true
local iskeydownfix = true
local version = "3.1"
local lolversion = "5.19"
local Update_HOST = "raw.github.com"
local Update_PATH = "/Scarjit/Scripts/master/S1mple_Ziggs.lua?rand="..math.random(1,10000)
local Update_FILE_PATH = "S1mple_Ziggs.lua"
local Update_URL = "https://"..Update_HOST..Update_PATH
myHero = GetMyHero()
if myHero.charName ~= 'Ziggs' then return end
require "VPrediction"
--BEGINN INI VARS
	local ts = nil
	local c_red = ARGB(255, 255,0,0)
	local c_green = ARGB(255,9,255,0)
	local c_blue = ARGB(255,51,51,255)
	local ZiggsQ = { range = 850, width = 155, speed = 1750, delay = .25, collision=true }
	local ZiggsW = { range = 1000, width = 225, speed = math.huge, delay = .25, collision=false }
	local ZiggsE = { range = 900, width = 350, speed = 1750, delay = .12, collision=false }
	local ZiggsR = { range = 5300, width = 600, speed = 1750, delay = 0.5, collision=false }
	local HpredQ
	local HpredW
	local HpredE
	local HpredR
	local VP = VPrediction()
	local ts = TargetSelector(TARGET_LESS_CAST, 2000, DAMAGE_MAGIC, true)
	local Config = scriptConfig("S1mple_Ziggs", "s1mple_ziggs")
	local currentXN = 0
	local currentYN = 0
	local currentZN = 0
	local tlsarray = {"Low HP", "High HP" , "Max Damage", "Random", "Low Range", "High Range"}
	local rpreds = {"VPrediction", "S1mplePredict", "On Target"}
	local qpreds = {"VPrediction", "On Target", "S1mplePredict", "Smart Mode"}
	local wpreds = {"VPrediction"}
	local epreds = {"VPrediction"}
	local qtm = ""
	local ulthelpertarget = nil
	enemyHeros = GetEnemyHeroes()
--END INI VARS
--Keydown Fix
-- Developer: PvPSuite (http://forum.botoflegends.com/user/76516-pvpsuite/)
local originalKD = _G.IsKeyDown;
_G.IsKeyDown = function(theKey)
	if iskeydownfix then
		if (type(theKey) ~= 'number') then
			local tn = tonumber(theKey);
			if (tn ~= nil) then
				return originalKD(tn);
			else
				return originalKD(GetKey(theKey));
			end;
		else
			return originalKD(theKey);
		end
	end
end
--End Keydown Fix
function p(arg)
	print("[S1mple_Ziggs] <font color=\"#570BB2\">"..arg.."</font>")
end
function findorbwalker() --Thanks to http://forum.botoflegends.com/user/431842-orianna/ for this Simple solution
	if _G.Reborn_Loaded then
		SAC=true
		p("Sida's Auto Carry found")
	elseif not _G.Reborn_Loaded and FileExist(LIB_PATH .. "SxOrbWalk.lua") then
		SxOrb=true
		require("SxOrbWalk")
		DelayAction(function() Config:addSubMenu("SxOrbWalk","orbWalk") end,5)
		DelayAction(function() _G.SxOrb:LoadToMenu(Config.orbWalk) end,5)
		p("SxOrbWalk found")
	elseif SAC~=true and SxOrb~= true then
		p("=================")
		p("=================")
		p("SxOrb or SAC:R is required.")
		p("=================")
		p("=================")
	end
end
function findprediction()
	if FileExist(LIB_PATH.."SPrediction.lua") then
		require("SPrediction")
		SPred = SPrediction()
		p("Found SPrediction")
		table.insert(qpreds,"SPrediction")
		table.insert(wpreds,"SPrediction")
		table.insert(epreds,"SPrediction")
		table.insert(rpreds,"SPrediction")
	end
	if FileExist(LIB_PATH.."HPrediction.lua") then
		require("HPrediction")
		HPred = HPrediction()
		p("Found HPrediction")
		table.insert(qpreds,"HPrediction")
		table.insert(wpreds,"HPrediction")
		table.insert(epreds,"HPrediction")
		table.insert(rpreds,"HPrediction")
		HpredQ = HPSkillshot({type = "DelayCircle", delay = ZiggsQ.delay, range = ZiggsQ.range, radius = ZiggsQ.width, speed = ZiggsQ.speed})
		HpredW = HPSkillshot({type = "DelayCircle", delay = ZiggsW.delay, range = ZiggsW.range, radius = ZiggsW.width, speed = ZiggsW.speed})
		HpredE = HPSkillshot({type = "DelayCircle", delay = ZiggsE.delay, range = ZiggsE.range, radius = ZiggsE.width, speed = ZiggsE.speed})
		HpredR = HPSkillshot({type = "DelayCircle", delay = ZiggsR.delay, range = ZiggsR.range, radius = ZiggsR.width, speed = ZiggsR.speed})
	end
end
function Update(arg)
	if arg ~= "force" then
		if not autoupdate then
			p("Autoupdate's disabled")
		return
		end
	end
		p("Updating S1mple_Ziggs")
		local ServerData = GetWebResult(Update_HOST, "/Scarjit/Scripts/master/S1mple_Ziggs.version")
		if ServerData then
			ServerVersion = type(tonumber(ServerData)) == "number" and tonumber(ServerData) or nil
			if ServerVersion then
				if tonumber(version) < ServerVersion then
					p("Update found")
					p("Local Version: "..version" <==> ServerVersion: "..ServerVersion)
					p("Updating, don't press F9")
					DelayAction(function() DownloadFile(Update_URL, Update_FILE_PATH, function () p("Successfully updated. ("..version.." => "..ServerVersion.."), press F9 twice to load the updated version.") end) end, 3)
				elseif  tonumber(version) == ServerVersion then
					p("No Update found")
				elseif tonumber(version) > ServerVersion then
					p("WARNING: There is something wrong, with the Updater")
					p("or you have manually changed your Version Number")
				end
			end
		else
			p("Autoupdate failed")
		end
end
function ChkUpdate()
	if not chkupdates then return end
	if autoupdate then return end
	p("Checking for Updates")
			local ServerData = GetWebResult(Update_HOST, "/Scarjit/Scripts/master/S1mple_Ziggs.version")
		if ServerData then
			ServerVersion = type(tonumber(ServerData)) == "number" and tonumber(ServerData) or nil
			if ServerVersion then
				if tonumber(version) < ServerVersion then
					p("Update found")
					p("Local Version: "..version" <==> ServerVersion: "..ServerVersion)
					p("Please update manually or turn autoupdate on")
				else
					p("No Update found")
				end
			end
		else
			p("Update Check failed")
		end
end
function ChkNews()
	if not chknews then return end
			local ServerData = GetWebResult(Update_HOST, "/Scarjit/Scripts/master/S1mple_Ziggs.news")
		if ServerData then
			Config:addParam("news", ServerData,SCRIPT_PARAM_INFO, "")
		else
			p("News Check failed")
		end
end
function OnLoad()
	p("S1mple_Ziggs Version</font> "..version.." <font color=\"#570BB2\">loading</font>")
	ChkUpdate()
	Update()
	findprediction()
	--Config START
	Config:addParam("active", "Activated", SCRIPT_PARAM_ONOFF, false)
	Config:addParam("hc", "Accuracy (Default: 2)", SCRIPT_PARAM_SLICE, 2, -1, 5, 1)
	Config:addParam("version", "Current Version", SCRIPT_PARAM_INFO, version)
	Config:addParam("leagueversion", "Build for League of Legends Version: ", SCRIPT_PARAM_INFO, lolversion)
	Config:addParam("forceupdate", "Update now", SCRIPT_PARAM_ONOFF, false)
	Config:addTS(ts)
	Config:addSubMenu("Draws", "draws")
	Config:addSubMenu("Keys", "keys")
	Config:addSubMenu("Humanizer", "human")
	Config:addSubMenu("Advanced", "adv")
	Config:addSubMenu("Cancel Spells", "cancelspell")
	for key,value in pairs(enemyHeros) do
		Config.cancelspell:addParam("qcancel"..value.charName, "Cancel "..value.charName.." Q", SCRIPT_PARAM_ONOFF, false)
		Config.cancelspell:addParam("wcancel"..value.charName, "Cancel "..value.charName.." W", SCRIPT_PARAM_ONOFF, false)
		Config.cancelspell:addParam("ecancel"..value.charName, "Cancel "..value.charName.." E", SCRIPT_PARAM_ONOFF, false)
		Config.cancelspell:addParam("rcancel"..value.charName, "Cancel "..value.charName.." R", SCRIPT_PARAM_ONOFF, false)
	end
	Config.adv:addParam("debug", "Enable Debug Options", SCRIPT_PARAM_ONOFF, false)
	Config.adv:addParam("movewalljump", "Move to Mouse in Walljump Mode", SCRIPT_PARAM_ONOFF, true)
	Config.adv:addSubMenu("Laneclear", "lc")
	Config.adv.lc:addParam("laneclearpredhealth", "Don't cast spells on Minions below: ", SCRIPT_PARAM_SLICE,5,0,100,1)
	Config.adv:addSubMenu("Q", "q")
	Config.adv.q:addParam("qpres", "Q Prediction", SCRIPT_PARAM_LIST, 3, qpreds)
	Config.adv.q:addParam("qcollision", "Q Minion Collision", SCRIPT_PARAM_ONOFF, true)
	Config.adv.q:addParam("combocast", "Cast in Combo Mode", SCRIPT_PARAM_ONOFF, true)
	Config.adv.q:addParam("combominmana", "Minimum Mana % (Combo)", SCRIPT_PARAM_SLICE, 10, 0, 100, 1)
	Config.adv.q:addParam("harrascast", "Cast in Harras Mode", SCRIPT_PARAM_ONOFF, true)
	Config.adv.q:addParam("harrasminmana", "Minimum Mana % (Harras)", SCRIPT_PARAM_SLICE, 10, 0, 100, 1)
	Config.adv.q:addParam("laneclearcast", "Cast in Laneclear Mode", SCRIPT_PARAM_ONOFF, true)
	Config.adv.q:addParam("laneclearminmana", "Minimum Mana % (Laneclear)", SCRIPT_PARAM_SLICE, 10, 0, 100, 1)
	Config.adv:addSubMenu("W", "w")
	Config.adv.w:addParam("wpres", "W Prediction", SCRIPT_PARAM_LIST, 1, wpreds)
	Config.adv.w:addParam("combocast", "Cast in Combo Mode", SCRIPT_PARAM_ONOFF, true)
	Config.adv.w:addParam("combominmana", "Minimum Mana % (Combo)", SCRIPT_PARAM_SLICE, 10, 0, 100, 1)
	Config.adv.w:addParam("harrascast", "Cast in Harras Mode", SCRIPT_PARAM_ONOFF, true)
	Config.adv.w:addParam("harrasminmana", "Minimum Mana % (Harras)", SCRIPT_PARAM_SLICE, 10, 0, 100, 1)
	Config.adv.w:addParam("laneclearcast", "Cast in Laneclear Mode", SCRIPT_PARAM_ONOFF, true)
	Config.adv.w:addParam("laneclearminmana", "Minimum Mana % (Laneclear)", SCRIPT_PARAM_SLICE, 10, 0, 100, 1)
	Config.adv.w:addParam("fleecast", "Cast in Flee Mode", SCRIPT_PARAM_ONOFF, true)
	Config.adv:addSubMenu("E", "e")
	Config.adv.e:addParam("epres", "E Prediction", SCRIPT_PARAM_LIST, 1, epreds)
	Config.adv.e:addParam("combocast", "Cast in Combo Mode", SCRIPT_PARAM_ONOFF, true)
	Config.adv.e:addParam("combominmana", "Minimum Mana % (Combo)", SCRIPT_PARAM_SLICE, 10, 0, 100, 1)
	Config.adv.e:addParam("harrascast", "Cast in Harras Mode", SCRIPT_PARAM_ONOFF, true)
	Config.adv.e:addParam("harrasminmana", "Minimum Mana (Harras)%", SCRIPT_PARAM_SLICE, 10, 0, 100, 1)
	Config.adv.e:addParam("laneclearcast", "Cast in Laneclear Mode", SCRIPT_PARAM_ONOFF, true)
	Config.adv.e:addParam("laneclearminmana", "Minimum Mana % (Laneclear)", SCRIPT_PARAM_SLICE, 10, 0, 100, 1)
	Config.adv.e:addParam("fleecast", "Cast in Flee Mode", SCRIPT_PARAM_ONOFF, true)
	Config.adv:addSubMenu("R", "r")
	Config.adv.r:addParam("combocast", "Cast in Combo Mode", SCRIPT_PARAM_ONOFF, false)
	Config.adv.r:addParam("combominmana", "Minimum Mana % (Combo)", SCRIPT_PARAM_SLICE, 10, 0, 100, 1)
	Config.adv.r:addParam("rinfo1", "Use the Sliders below to use different", SCRIPT_PARAM_INFO, "")
	Config.adv.r:addParam("rinfo2", "Predictions, based on Target Distance.", SCRIPT_PARAM_INFO, "")
	Config.adv.r:addParam("rinfo3", "===========WARNING============", SCRIPT_PARAM_INFO, "")
	Config.adv.r:addParam("rinfo4", "Do not put Phase 1 above Phase 2 or", SCRIPT_PARAM_INFO, "")
	Config.adv.r:addParam("rinfo5", "Phase 2 above Phase 3.", SCRIPT_PARAM_INFO, "")
	Config.adv.r:addParam("rinfo6", "Otherwise it might break the Script", SCRIPT_PARAM_INFO, "")
	Config.adv.r:addParam("rinfo7", "===============================", SCRIPT_PARAM_INFO, "")
	Config.adv.r:addParam("phase1", "Phase 1", SCRIPT_PARAM_SLICE, 1800, 1, 5300, 1)
	Config.adv.r:addParam("phase2", "Phase 2", SCRIPT_PARAM_SLICE, 3000, 2, 5300, 1)
	Config.adv.r:addParam("phase3", "Phase 3", SCRIPT_PARAM_SLICE, 5300, 3, 5300, 1)
	Config.adv.r:addParam("phase1pred", "Phase 1 Prediction: ", SCRIPT_PARAM_LIST, 0, rpreds)
	Config.adv.r:addParam("phase2pred", "Phase 2 Prediction: ", SCRIPT_PARAM_LIST, 0, rpreds)
	Config.adv.r:addParam("phase3pred", "Phase 3 Prediction: ", SCRIPT_PARAM_LIST, 0, rpreds)
	Config.adv.r:addParam("rrand", "Additional Random Distance: " , SCRIPT_PARAM_SLICE, 0, 0, 250, 1)
	Config.adv.r:addParam("tsl", "Target Selection Mode:" , SCRIPT_PARAM_LIST, 0, tlsarray)
	Config.adv.r:addParam("rinfo8", "If you choose V/S/H/DevinePrediction, please choose", SCRIPT_PARAM_INFO, "")
	Config.adv.r:addParam("rinfo9", "a HitChance below", SCRIPT_PARAM_INFO, "")
	Config.adv.r:addParam("phase1hs", "Phase 1 Hitchance", SCRIPT_PARAM_SLICE, 2, 0, 5,1)
	Config.adv.r:addParam("phase2hs", "Phase 2 Hitchance", SCRIPT_PARAM_SLICE, 2, 0, 5,1)
	Config.adv.r:addParam("phase3hs", "Phase 3 Hitchance", SCRIPT_PARAM_SLICE, 2, 0, 5,1)
	Config.human:addParam("delayflee", "Delay Double W in Fleemode", SCRIPT_PARAM_SLICE, 0, 0, 4, 1)
	Config.human:addParam("hinfo1", "Use the Sliders below to add a", SCRIPT_PARAM_INFO, "")
	Config.human:addParam("hinfo2", "random Position Variance", SCRIPT_PARAM_INFO, "")
	Config.human:addParam("qjitter", "Q Jitter", SCRIPT_PARAM_SLICE, 0,0,100,1)
	Config.human:addParam("wjitter", "W Jitter", SCRIPT_PARAM_SLICE, 0,0,100,1)
	Config.human:addParam("ejitter", "E Jitter", SCRIPT_PARAM_SLICE, 0,0,100,1)
	Config.draws:addParam("drawq", "Draw Q",SCRIPT_PARAM_ONOFF,false)
	Config.draws:addParam("draww", "Draw W",SCRIPT_PARAM_ONOFF,false)
	Config.draws:addParam("drawe", "Draw E",SCRIPT_PARAM_ONOFF,false)
	Config.draws:addParam("drawr", "Draw R (lags alot)",SCRIPT_PARAM_ONOFF,false)
	Config.draws:addParam("drawrmini", "Draw R on Minimap",SCRIPT_PARAM_ONOFF,false)
	Config.draws:addParam("drawenemy", "Draw Selected Enemy", SCRIPT_PARAM_ONOFF, false)
	Config.draws:addParam("drawenemyult", "Draw Selected Enemy (Forceult)", SCRIPT_PARAM_ONOFF, false)
	Config.draws:addParam("drawwalljumpmini", "Draw Walljumps on Minimap", SCRIPT_PARAM_ONOFF, false)
	Config.draws:addParam("drawwalljumprange", "Draw Walljump in Range", SCRIPT_PARAM_SLICE, 3000, 0, 10000, 10)
	Config.draws:addParam("ulthelper", "Show Killable Champions", SCRIPT_PARAM_ONOFF, true)
	Config.draws:addParam("drawenemyminion", "Draw selected Minion", SCRIPT_PARAM_ONOFF, false)
	Config.keys:addParam("combo", "Combo Key", SCRIPT_PARAM_ONKEYDOWN, false, 32)
	Config.keys:addParam("harras", "Harras Key", SCRIPT_PARAM_ONKEYDOWN, false, 67)
	Config.keys:addParam("laneclear", "Lane Clear", SCRIPT_PARAM_ONKEYDOWN, false, 86)
	Config.keys:addParam("lasthit", "Last Hit", SCRIPT_PARAM_ONKEYDOWN, false, 88)
	Config.keys:addParam("flee", "Flee Key", SCRIPT_PARAM_ONKEYDOWN, false, 71)
	Config.keys:addParam("forceult", "Forceult", SCRIPT_PARAM_ONKEYDOWN, false, 84)
	Config.keys:addParam("ulthelper", "Ulthelper Key", SCRIPT_PARAM_ONKEYDOWN, false, 72)
	Config.keys:addParam("walljump", "Walljump", SCRIPT_PARAM_ONKEYDOWN, false, 85)
	Config.keys:permaShow("combo")
	Config.keys:permaShow("harras")
	Config.keys:permaShow("laneclear")
	Config.keys:permaShow("lasthit")
	Config.keys:permaShow("flee")
	Config.keys:permaShow("forceult")
	Config.keys:permaShow("walljump")
	Config.adv.r:permaShow("tsl")
	Config.adv.q:permaShow("qpres")
	--Config END
	flee_recasttime = os.time()
	waypoints_ctime = os.time()
	laneclear_recasttime = os.time()
	enemyMinions = minionManager(MINION_ENEMY, 850, player, MINION_SORT_HEALTH_ASC)
	Config.active = true
	Config.forceupdate = false
	findorbwalker()
	ChkNews()
	p("S1mple_Ziggs loaded")
	ontickruns = 0
end
function OnProcessSpell(unit, spell)
	if unit.team ~= myHero.team then
		if unit.charName and unit.dead == false then
			if myHero:CanUseSpell(_W) == READY and GetDistance(myHero,unit) <= ZiggsW.range then
				if Config.cancelspell["qcancel"..unit.charName] == true or Config.cancelspell["wcancel"..unit.charName] == true or Config.cancelspell["ecancel"..unit.charName] == true or Config.cancelspell["rcancel"..unit.charName] == true then
					p("Interrupting: "..spell.name.." by "..unit.charName)
					CastSpell(_W,unit.x+math.random(Config.human.qjitter*-1,Config.human.qjitter),unit.z+math.random(Config.human.qjitter*-1,Config.human.qjitter))
					DelayAction(function() CastSpell(_W) end,0.5)
				end
			end
		end
	end
end
X = 0
Y = 0
Z = 0
function LongRangeTargetSelector()
	local tsmode = Config.adv.r.tsl
	local preftarget = nil
	local tsv = 0
	for key,value in pairs(enemyHeros) do
		--(X-X1)^2+(Z-Z1)^2 <= R^2 if in range
		local X1 = value.x
		local Z1 = value.z
		local n = math.sqrt((X-X1)^2+(Z-Z1)^2)
		if n >= 5300 and value.dead == false and value.visible == true then return end
		--Low HP Mode
		if Config.adv.r.tsl == 1 then
			if preftarget == nil then
				if value.visible == true then
					preftarget = value
				end
			else
				if preftarget.health > value.health then
					preftarget = value
				end
			end
		end
		--End Low HP Mode
		--High HP Mode
		if Config.adv.r.tsl == 2 then
			if preftarget == nil  then
				if value.visible == true then
					preftarget = value
				end
			else
				if preftarget.health < value.health then
					preftarget = value
				end
			end
		end
		--End High HP Mode
		--Begin Max Damage Mode
		if Config.adv.r.tsl == 3 then
			local md = 0
			for k2,v2 in pairs(enemyHeros) do
				md = 0
				local n2 = math.sqrt((X-X1)^2+(Z-Z1)^2)
				if n <= 275	then
					md = md + 100
				elseif n <= 550 then
					md = md + 80
				end
				if tsv < md then
					preftarget = value
					tsv = md
				end
			end
		end
		--End Max Damage Mode
		--Begin Random Mode
		if Config.adv.r.tsl == 3 then
			local md = math.random(1,100)
			if md > tsv then
				tsv = md
				preftarget = value
			end
		end
		--End Random Mode
		--Begin Low Range Mode
		if Config.adv.r.tsl == 4 then
			if preftarget == nil then
				preftarget = value
				tsv = n
			elseif md < tsv then
				preftarget = value
				tsv = n
			end
		end
		--End Low Range Mode
		--Begin High Range Mode
		if Config.adv.r.tsl == 5 then
			if preftarget == nil then
				preftarget = value
				tsv = n
			elseif md > tsv then
				preftarget = value
				tsv = n
			end
		end
		--End High Range Mode
	end
	return preftarget
end
function OnTick()
if SAC~=true and SxOrb~= true and GetGameTimer() <= 100 and myHero.dead and not Config.active then return end
if ontickruns >= math.huge - 1000 then
	ontickruns = math.huge - 2000
end
if Config.forceupdate and ontickruns > 500 then
	Config.forceupdate = false
	Update("force")
end
ontickruns =  ontickruns+1
ts:update()
X = myHero.x
Y = myHero.y
Z = myHero.z
	if Config.keys.combo == true then
		if ts.target ~= nil then
			tname = string.upper(string.sub(ts.target.charName, 0, 3))
			if tname ~= "SRU" then
				if Config.adv.q.combocast and ((myHero.mana/myHero.maxMana)*100) >= Config.adv.q.combominmana then
					CastQ(ts.target)
				end
				if Config.adv.w.combocast and ((myHero.mana/myHero.maxMana)*100) >= Config.adv.w.combominmana then
					CastW(ts.target)
				end
				if Config.adv.e.combocast and ((myHero.mana/myHero.maxMana)*100) >= Config.adv.e.combominmana then
					CastE(ts.target)
				end
				if Config.adv.r.combocast and ((myHero.mana/myHero.maxMana)*100) >= Config.adv.r.combominmana then
					CastR(ts.target)
				end
			end
		end
	end
	if Config.keys.harras == true then
		if ts.target ~= nil then
			if Config.adv.q.harrascast and ((myHero.mana/myHero.maxMana)*100) >= Config.adv.q.harrasminmana then
				CastQ(ts.target)
			end
			if Config.adv.w.harrascast and ((myHero.mana/myHero.maxMana)*100) >= Config.adv.w.harrasminmana then
				CastW(ts.target)
			end
			if Config.adv.e.harrascast and ((myHero.mana/myHero.maxMana)*100) >= Config.adv.e.harrasminmana then
				CastE(ts.target)
			end
		end
	end
	if Config.keys.lasthit == true then return end
	if Config.keys.laneclear == true then
		if os.time() > laneclear_recasttime then
			laneclear_recasttime = os.time() + 0.25
			enemyMinions:update()
			prefminion = nil
			local prefminion_inrange = 0
			for key,value in pairs(enemyMinions.objects) do
				if  ((value.health/value.maxHealth)*100) >= Config.adv.lc.laneclearpredhealth then
					prefminion_inrange_N = 0
					local X1 = value.x
					local Z1 = value.z
					local n = math.sqrt((X-X1)^2+(Z-Z1)^2)
					if  n <= 550 then
						for key2,value2 in pairs(enemyMinions.objects) do
							local X2 = value2.x
							local Z2 = value2.z
							local n2 = math.sqrt((X-X2)^2+(Z-Z2)^2)
							if n2 >= 225 then
								prefminion_inrange_N = prefminion_inrange_N+1
							end
						end
						if prefminion == nil then
							prefminion = value
							prefminion_inrange = prefminion_inrange_N
						end
						if prefminion_inrange < prefminion_inrange_N then
							prefminion = value
							prefminion_inrange = prefminion_inrange_N
						end
					end
				end
			end
			local b_castlc = false
			if prefminion then
				if myHero:CanUseSpell(SPELL_1) == READY and b_castlc == false and Config.adv.q.laneclearcast and not prefminion.dead and ((myHero.mana/myHero.maxMana)*100) >= Config.adv.q.laneclearminmana then
					b_castlc = true
					CastQ(prefminion)
				end
				if myHero:CanUseSpell(SPELL_2) == READY and b_castlc == false and Config.adv.w.laneclearcast and not prefminion.dead and ((myHero.mana/myHero.maxMana)*100) >= Config.adv.w.laneclearminmana then
					b_castlc = true
					CastW(prefminion)
				end
				if myHero:CanUseSpell(SPELL_3) == READY and b_castlc == false and Config.adv.e.laneclearcast and not prefminion.dead and ((myHero.mana/myHero.maxMana)*100) >= Config.adv.e.laneclearminmana then
					b_castlc = true
					CastE(prefminion)
				end
			end
			if prefminion ~= nil then
				if prefminion.dead == true then prefminion = nil end
			end
		end
	end
	if Config.keys.flee == true then
		myHero:MoveTo(mousePos.x, mousePos.z)
		if Config.adv.e.fleecast then
			if ts.target ~= nil then
				CastE(ts.target)
			else
				CastE(myHero)
			end
		end
		if os.time() > flee_recasttime then
			flee_recasttime = os.time() + Config.human.delayflee
			if Config.adv.w.fleecast then
				CastW(myHero)
			end
		end
	end
	if Config.keys.forceult == true then
		CastR()
	end
	if Config.keys.walljump == true then
		Jump()
	end
	if Config.keys.ulthelper == true then
		local dmg = 0
		if myHero:CanUseSpell(SPELL_4) == READY then
			if myHero:GetSpellData(SPELL_4).level == 1 then
				dmg = 250
			elseif myHero:GetSpellData(SPELL_4).level == 2 then
				dmg = 375
			elseif myHero:GetSpellData(SPELL_4).level == 3 then
				dmg = 500
			end
			dmg = dmg+(myHero.ap*0.9)
			if enemyHeros ~= nil then
				for k,v in pairs(enemyHeros) do
					if v.health <= dmg and v.dead == false and GetDistance(myHero,v) <= ZiggsR.range and v.visible == true then
						CastR(v)
						p("Casted Ultimate on: "..v.charName)
					end
				end
			end
		end
	end
end
function OnDraw()
if Config.active == false then return end
	ts:update()
	if ts.target ~= nil then
		DrawText("Normal Target: "..ts.target.charName, 18, 100, 140, c_green)
	end
	if LongRangeTargetSelector() ~= nil and myHero:CanUseSpell(SPELL_4) == READY then
		DrawText("Ultimate Target: "..LongRangeTargetSelector().charName, 18, 100, 160, c_green)
	end
	if Config.draws.drawq == true and myHero:CanUseSpell(_Q) == 0 then
		DrawCircle3D(X,Y,Z,850,5,c_red)
		DrawCircle3D(X,Y,Z,1400,5,c_red)
	end
	if Config.draws.draww == true and myHero:CanUseSpell(_W) == 0 then
		DrawCircle3D(X,Y,Z,1000,5,c_blue)
	end
	if Config.draws.drawe == true and myHero:CanUseSpell(_E) == 0 then
		DrawCircle3D(X,Y,Z,900,5,c_blue)
	end
	if Config.draws.drawr == true and myHero:CanUseSpell(_R) == 0 then
		DrawCircle3D(X,Y,Z,5300,5,c_green)
	end
	if Config.draws.drawrmini == true then
		DrawCircleMinimap(X,Y,Z,5300,1,c_green)
	end
	if Config.draws.drawenemy == true then
		if ts.target ~= nil then
				DrawCircle3D(ts.target.x,ts.target.y,ts.target.z,100,5,c_blue)
				DrawCircle3D(ts.target.x,ts.target.y,ts.target.z,80,5,c_blue)
				DrawCircle3D(ts.target.x,ts.target.y,ts.target.z,60,5,c_blue)
				DrawCircle3D(ts.target.x,ts.target.y,ts.target.z,40,5,c_blue)
			end
	end
	if Config.draws.drawenemyminion == true then
		if prefminion ~= nil and prefminion.dead == false and prefminion.health > 1 and prefminion.charName ~= nil then
				DrawText("prefminion: "..prefminion.charName, 20, 100,180, c_red)
				DrawCircle3D(prefminion.x,prefminion.y,prefminion.z,100,5,c_blue)
				DrawCircle3D(prefminion.x,prefminion.y,prefminion.z,80,5,c_blue)
				DrawCircle3D(prefminion.x,prefminion.y,prefminion.z,60,5,c_blue)
				DrawCircle3D(prefminion.x,prefminion.y,prefminion.z,40,5,c_blue)
		end
	end
	if Config.adv.r.phase1 > Config.adv.r.phase2 then
		DrawText("Phase 1 is greater then Phase 2", 20, 100,200, c_red)
	end
	if Config.adv.r.phase2 > Config.adv.r.phase3 then
		DrawText("Phase 2 is greater then Phase 3", 20, 100,220, c_red)
	end
	if Config.adv.r.phase1 > Config.adv.r.phase3 then
		DrawText("Phase 1 is greater then Phase 3", 20, 100,240, c_red)
	end
	if Config.keys.walljump == true or Config.draws.drawwalljumpmini == true then
		MarkJumps()
	end
	if Config.adv.debug == true then
		DrawText("Current Time: "..os.time(),20,100,20,c_red)
		DrawText("Max Mana: "..myHero.maxMana, 20, 100, 40, c_red)
		DrawText("Current Mana: "..myHero.mana, 20,100,60,c_red)
		DrawText("Mana Percentage: "..((myHero.mana/myHero.maxMana)*100), 20, 100, 80, c_red)
		DrawText("Location: "..tostring(math.round(myHero.x)).." : "..tostring(math.round(myHero.y)).." : "..tostring(math.round(myHero.z)),20, 100,100, c_red)
		DrawText("Mouse: "..tostring(math.round(mousePos.x)).." : "..tostring(math.round(mousePos.y)).." : "..tostring(math.round(mousePos.z)),20, 100,120, c_red)
		DrawText("Q Target Mode: "..qtm,20,100,260,c_red)
		DrawText("ontickruns: "..ontickruns,20,100,280,c_red)
		ts:update()
		if ts.target ~= nil then
			local CastPosition, HitChance, Position = VP:GetCircularCastPosition(ts.target, ZiggsQ.delay, ZiggsQ.width, ZiggsQ.range, ZiggsQ.speed, myHero, false)
			DrawText("Q VPrediction Chance: "..HitChance,20,100,340,c_green)
			local CastPosition, HitChance, Position = VP:GetCircularCastPosition(ts.target, ZiggsW.delay, ZiggsW.width, ZiggsW.range, ZiggsW.speed, myHero, false)
			DrawText("W VPrediction Chance: "..HitChance,20,100,360,c_green)
			local CastPosition, HitChance, Position = VP:GetCircularCastPosition(ts.target, ZiggsE.delay, ZiggsE.width, ZiggsE.range, ZiggsE.speed, myHero, false)
			DrawText("E VPrediction Chance: "..HitChance,20,100,380,c_green)
			if SPred then
				local CastPosition, Chance, PredPos = SPred:Predict(ts.target, ZiggsQ.range, ZiggsQ.speed, ZiggsQ.delay, ZiggsQ.width, false, myHero)
				DrawText("Q SPrediction Chance: "..Chance,20,100,400,c_green)
				local CastPosition, Chance, PredPos = SPred:Predict(ts.target, ZiggsW.range, ZiggsW.speed, ZiggsW.delay, ZiggsW.width, false, myHero)
				DrawText("W SPrediction Chance: "..Chance,20,100,420,c_green)
				local CastPosition, Chance, PredPos = SPred:Predict(ts.target, ZiggsE.range, ZiggsE.speed, ZiggsE.delay, ZiggsE.width, false, myHero)
				DrawText("E SPrediction Chance: "..Chance,20,100,440,c_green)
			end
			if HPred then
				local QPos, QHitChance = HPred:GetPredict(HpredQ, ts.target, myHero)
				DrawText("Q HPrediction Chance: "..QHitChance,20,100,460,c_green)
				local WPos, WHitChance = HPred:GetPredict(HpredW, ts.target, myHero)
				DrawText("W HPrediction Chance: "..WHitChance,20,100,480,c_green)
				local EPos, EHitChance = HPred:GetPredict(HpredE, ts.target, myHero)
				DrawText("E HPrediction Chance: "..EHitChance,20,100,500,c_green)
				local RPos, RHitChance = HPred:GetPredict(HpredR, ts.target, myHero)
				DrawText("R HPrediction Chance: "..RHitChance,20,100,520,c_green)
			end
		end
		if Config.forceupdate == true then
			DrawText("Config.forceupdate: true",20,100,300,c_red)
		else
			DrawText("Config.forceupdate: false",20,100,300,c_red)
		end
	end
	if Config.draws.ulthelper == true then
		local dmg = 0
		if myHero:CanUseSpell(SPELL_4) == READY then
			if myHero:GetSpellData(SPELL_4).level == 1 then
				dmg = 250
			elseif myHero:GetSpellData(SPELL_4).level == 2 then
				dmg = 375
			elseif myHero:GetSpellData(SPELL_4).level == 3 then
				dmg = 500
			end
			dmg = dmg+(myHero.ap*0.9)
			DrawText("Ult Dmg: "..math.round(dmg),20, 100,320, c_red)
			if enemyHeros ~= nil then
				for k,v in pairs(enemyHeros) do
					if v.health <= dmg and v.dead == false and GetDistance(myHero,v) <= ZiggsR.range and v.visible == true then
						DrawText("Press your Ulthelper Key to kill: "..v.charName,50, 500,30, c_red)
					end
				end
			end
		end
	end
end
function S1mplePredict(target)
	--The Waypoint's are Predicted based on Current Movement
	local currentX = target.x
	local currentY = target.y
	local currentZ = target.z
	if Config.draws.waypoints then
		DrawText(math.round(currentX).." : "..math.round(currentY).." : "..math.round(currentZ), 18,100,100,c_red)
	end
	if os.time() > waypoints_ctime  then
		waypoints_ctime = os.time() + 0.025
		currentXN = target.x
		currentYN = target.y
		currentZN = target.z
		local preX = (currentX-currentXN)+target.x
		local preY = (currentY-currentYN)+target.y
		local preZ = (currentZ-currentZN)+target.z
		if Config.draws.waypoints then
			DrawCircle3D(preX,preY,preZ, 40,5,c_red)
		end
		return preX, preZ
	end
	if Config.draws.waypoints then
		DrawText(math.round(currentXN).." : "..math.round(currentYN).." : "..math.round(currentZN), 18,100,120,c_red)
		DrawLine3D(currentX, currentY, currentZ, currentXN, currentYN, currentZN, 10, c_green)
	end
	return nil, nil
end
function CastQ(target)
	enemyMinions:update()
	if target == nil then return end
	if Config.adv.q.qpres == 1 then --VPrediction
		qtm = "VPrediction"
		local CastPosition, HitChance, Position = VP:GetLineCastPosition(target, ZiggsQ.delay, ZiggsQ.width, ZiggsQ.range, ZiggsQ.speed, myHero, Config.adv.q.qcollision)
		if CastPosition and HitChance >= 2 and GetDistance(CastPosition) < ZiggsQ.range then
			CastSpell(_Q,CastPosition.x+math.random(Config.human.qjitter*-1,Config.human.qjitter), CastPosition.z+math.random(Config.human.qjitter*-1,Config.human.qjitter))
		end
	elseif Config.adv.q.qpres == 2 then --On Target
		qtm = "On Target"
		CastSpell(_Q,target.x+math.random(Config.human.qjitter*-1,Config.human.qjitter),target.z+math.random(Config.human.qjitter*-1,Config.human.qjitter))
		elseif Config.adv.q.qpres == 3 then --Simple Prediction
		qtm = "S1mple Prediction"
		local hx, hz = S1mplePredict(target)
		if hx and hz then
			CastSpell(_Q,hx+math.random(Config.human.qjitter*-1,Config.human.qjitter),hz+math.random(Config.human.qjitter*-1,Config.human.qjitter))
		end
	elseif Config.adv.q.qpres == 4 then --Smart Prediction
		qtm = "Smart Prediction"
		--Low Range Predict
		if GetDistance(target) <= ZiggsQ.range then --850
			if GetDistance(target) <= 280 then
				qtm = "Smart Prediction | On Target Mode"
				CastSpell(_Q,target.x+math.random(Config.human.qjitter*-1,Config.human.qjitter),target.z+math.random(Config.human.qjitter*-1,Config.human.qjitter))
			elseif GetDistance(target) <= 560 then
				qtm = "Smart Prediction | S1mplePredict"
				local hx, hz = S1mplePredict(target)
				if hx and hz then
					CastSpell(_Q,hx+math.random(Config.human.qjitter*-1,Config.human.qjitter),hz+math.random(Config.human.qjitter*-1,Config.human.qjitter))
				end
			else
				qtm = "Smart Prediction | VPrediction"
				local CastPosition, HitChance, Position = VP:GetLineCastPosition(target, ZiggsQ.delay, ZiggsQ.width, ZiggsQ.range, ZiggsQ.speed, myHero, Config.adv.q.qcollision)
				if CastPosition and HitChance >= 2 and GetDistance(CastPosition) < ZiggsQ.range then
					CastSpell(_Q,CastPosition.x+math.random(Config.human.qjitter*-1,Config.human.qjitter), CastPosition.z+math.random(Config.human.qjitter*-1,Config.human.qjitter))
				end
			end
		--End Low Range Predict
		--Bounce Predict
		elseif GetDistance(target) > ZiggsQ.range and target.type ~= "obj_AI_Minion" and GetDistance(target) <= 1400 then
		qtm = "Smart Prediction | Bounce Mode"
			local firstBounce = Vector(myHero) + ZiggsQ.range * (Vector(target) - Vector(myHero)):normalized()
			local secondBounce = Vector(myHero) + (ZiggsQ.range + (ZiggsQ.range * 0.447)) * (Vector(target) - Vector(myHero)):normalized()
			if Config.adv.q.qcollision == true then
				for i, minion in pairs(enemyMinions.objects) do
					if GetDistanceSqr(minion, firstBounce) <= 150 * 150 and GetDistanceSqr(target, firstBounce) > 150 * 150 then
						qtm = "Smart Prediction | Bounce Mode | First Bounce Mode | VPrediction"
						local CastPosition, HitChance, Position = VP:GetLineCastPosition(target, ZiggsQ.delay, ZiggsQ.width, 1400, ZiggsQ.speed, myHero, false)
						if CastPosition and HitChance >= 2 and GetDistance(CastPosition) < 1400 then
							CastSpell(_Q,CastPosition.x+math.random(Config.human.qjitter*-1,Config.human.qjitter), CastPosition.z+math.random(Config.human.qjitter*-1,Config.human.qjitter))
						end
					end
					if GetDistanceSqr(minion, secondBounce) <= 150 * 150 and GetDistanceSqr(target, secondBounce) > 150 * 150 then
						qtm = "Smart Prediction | Bounce Mode | Secound Bounce Mode | VPrediction"
						local CastPosition, HitChance, Position = VP:GetLineCastPosition(target, ZiggsQ.delay, ZiggsQ.width, 1400, ZiggsQ.speed, myHero, false)
						if CastPosition and HitChance >= 2 and GetDistance(CastPosition) < 1400 then
							CastSpell(_Q,CastPosition.x+math.random(Config.human.qjitter*-1,Config.human.qjitter), CastPosition.z+math.random(Config.human.qjitter*-1,Config.human.qjitter))
						end
					end
				end
			else
			qtm = "Smart Prediction | Bounce Mode | VPrediction"
				local CastPosition, HitChance, Position = VP:GetLineCastPosition(target, ZiggsQ.delay, ZiggsQ.width, 1400, ZiggsQ.speed, myHero, false)
				if CastPosition and HitChance >= 2 and GetDistance(CastPosition) < 1400 then
					CastSpell(_Q,CastPosition.x+math.random(Config.human.qjitter*-1,Config.human.qjitter), CastPosition.z+math.random(Config.human.qjitter*-1,Config.human.qjitter))
				end
			end
		--End Bounce Predict
		end
	elseif qpreds[Config.adv.q.qpres] == "SPrediction" then
		qtm = "SPrediction"
		CastPosition, Chance, PredPos = SPred:Predict(target, ZiggsQ.range, ZiggsQ.speed, ZiggsQ.delay, ZiggsQ.width, Config.adv.q.qcollision, myHero)
		if Chance >= 2 then
			CastSpell(_Q, CastPosition.x+math.random(Config.human.qjitter*-1,Config.human.qjitter), CastPosition.z+math.random(Config.human.qjitter*-1,Config.human.qjitter))
		end
	elseif qpreds[Config.adv.q.qpreds] == "HPrediction" then
		qtm = "HPrediction"
		local QPos, QHitChance = HPred:GetPredict(HpredQ, target, myHero)
		if QHitChance >= 2 then
			CastSpell(_Q, QPos.x+math.random(Config.human.qjitter*-1,Config.human.qjitter), QPos.z+math.random(Config.human.qjitter*-1,Config.human.qjitter))
		end
	end
end
function CastW(target)
	if target == nil then return end
	if wpreds[Config.adv.w.wpres] == "VPrediction" then
		local CastPosition, HitChance, Position = VP:GetCircularCastPosition(target, ZiggsW.delay, ZiggsW.width, ZiggsW.range, ZiggsW.speed, myHero, false)
		if CastPosition and HitChance >= 2 and GetDistance(CastPosition) < ZiggsW.range then
			CastSpell(_W,CastPosition.x+math.random(Config.human.wjitter*-1,Config.human.wjitter), CastPosition.z+math.random(Config.human.wjitter*-1,Config.human.wjitter))
		end
	elseif wpreds[Config.adv.w.wpres] == "SPrediction" then
		CastPosition, Chance, PredPos = SPred:Predict(target, ZiggsW.range, ZiggsW.speed, ZiggsW.delay, ZiggsW.width, false, myHero)
		if Chance >= 2 and GetDistance(CastPosition) < ZiggsW.range then
			CastSpell(_W, CastPosition.x+math.random(Config.human.wjitter*-1,Config.human.wjitter), CastPosition.z+math.random(Config.human.wjitter*-1,Config.human.wjitter))
		end
	elseif qpreds[Config.adv.w.wpreds] == "HPrediction" then
		local WPos, WHitChance = HPred:GetPredict(HpredW, target, myHero)
		if WHitChance >= 2 then
			CastSpell(_W, WPos.x+math.random(Config.human.wjitter*-1,Config.human.wjitter), WPos.z+math.random(Config.human.wjitter*-1,Config.human.wjitter))
		end
	end
end
function CastE(target)
	if target == nil then return end
	if epreds[Config.adv.e.epres] == "VPrediction" then
		local CastPosition, HitChance, Position = VP:GetCircularCastPosition(target, ZiggsE.delay, ZiggsE.width, ZiggsE.range, ZiggsE.speed, myHero, false)
		if CastPosition and HitChance >= 2 and GetDistance(CastPosition) < ZiggsE.range then
			CastSpell(_E,CastPosition.x+math.random(Config.human.ejitter*-1,Config.human.ejitter), CastPosition.z+math.random(Config.human.ejitter*-1,Config.human.ejitter))
		end
	elseif epreds[Config.adv.e.epres] == "SPrediction" then
		CastPosition, Chance, PredPos = SPred:Predict(target, ZiggsE.range, ZiggsE.speed, ZiggsE.delay, ZiggsE.width, false, myHero)
		if Chance >= 2 and GetDistance(CastPosition) < ZiggsE.range then
			CastSpell(_E, CastPosition.x+math.random(Config.human.ejitter*-1,Config.human.ejitter), CastPosition.z+math.random(Config.human.ejitter*-1,Config.human.ejitter))
		end
	elseif epreds[Config.adv.e.epreds] == "HPrediction" then
		local EPos, EHitChance = HPred:GetPredict(HpredE, target, myHero)
		if EHitChance >= 2 then
			CastSpell(_E, EPos.x+math.random(Config.human.ejitter*-1,Config.human.ejitter), EPos.z+math.random(Config.human.ejitter*-1,Config.human.ejitter))
		end
	end
end
function CastR(arg)
	--[[
		Phase 1 <= 600
		Phase 2 601 - 2000
		Phase 3 2001 - 5300
		All 3 Phases can be overriden in Advanced Config
	]]--
	local randdstx = 0
	local randdstz = 0
	if not arg then
		local target = LongRangeTargetSelector()
	end
	if arg then
		p(arg.charName)
		target = arg
	end
	if target == nil or target.dead == true or myHero:CanUseSpell(SPELL_4) ~= READY then return end
	local distance = getDistance(myHero.x, myHero.z, target.x, target.z)
	if not distance then return end
	if distance >= 6000 then return end
	if Config.adv.r.rrand ~= 0 then
		randdstx = math.random((Config.adv.r.rrand*-1),Config.adv.r.rrand)
		randdstz = math.random((Config.adv.r.rrand*-1),Config.adv.r.rrand)
	end
	--PHASE 1
	if distance < Config.adv.r.phase1 then
		if rpreds[Config.adv.r.phase1pred] == "VPrediction" then
			local  CastPosition, HitChance, Position = VP:GetCircularCastPosition(target, ZiggsR.delay, ZiggsR.width, ZiggsR.range, ZiggsR.speed, myHero, false)
			if CastPosition and HitChance >= Config.adv.r.phase1hs and GetDistance(CastPosition) <= 5850 then
				CastSpell(_R, CastPosition.x+randdstx, CastPosition.z+randdstz)
			end
		end
		if rpreds[Config.adv.r.phase1pred] == "SPrediction" then
			CastPosition, Chance, PredPos = SPred:Predict(target, ZiggsR.range, ZiggsR.speed, ZiggsR.delay, ZiggsR.width, false, myHero)
			if Chance >= Config.adv.r.phase1hs and GetDistance(CastPosition) < 5850 then
				CastSpell(_R, CastPosition.x+randdstx, CastPosition.z+randdstz)
			end
		end
		if rpreds[Config.adv.r.rpreds] == "HPrediction" then
			local RPos, RHitChance = HPred:GetPredict(HpredR, target, myHero)
			if RHitChance >= Config.adv.r.phase2hs then
				CastSpell(_R, RPos.x+math.random(Config.human.rjitter*-1,Config.human.rjitter), RPos.z+math.random(Config.human.rjitter*-1,Config.human.rjitter))
			end
		end
		if rpreds[Config.adv.r.phase1pred] == "S1mplePredict" then
			preX, preZ = S1mplePredict(target)
			if preX and preZ then
				CastSpell(_R,preX+randdstx, preZ+randdstz)
			end
		end
		if rpreds[Config.adv.r.phase1pred] == "On Target" then
			CastSpell(_R,target.x+randdstx, target.z+randdstz)
		end
		p("Phase 1 Ultimate casted using: "..rpreds[Config.adv.r.phase1pred])
	else
		--PHASE 2
		if distance < Config.adv.r.phase2 then
			if rpreds[Config.adv.r.phase2pred] == "VPrediction" then
				local  CastPosition, HitChance, Position = VP:GetCircularCastPosition(target, ZiggsR.delay, ZiggsR.width, ZiggsR.range, ZiggsR.speed, myHero, false)
				if CastPosition and HitChance >= Config.adv.r.phase2hs and GetDistance(CastPosition) <= 5850 then
					CastSpell(_R, CastPosition.x+randdstx, CastPosition.z+randdstz)
				end
			end
			if rpreds[Config.adv.r.phase2pred] == "SPrediction" then
				CastPosition, Chance, PredPos = SPred:Predict(target, ZiggsR.range, ZiggsR.speed, ZiggsR.delay, ZiggsR.width, false, myHero)
				if Chance >= Config.adv.r.phase2hs and GetDistance(CastPosition) < 5850 then
					CastSpell(_R, CastPosition.x+randdstx, CastPosition.z+randdstz)
				end
			end
			if rpreds[Config.adv.r.rpreds] == "HPrediction" then
				local RPos, RHitChance = HPred:GetPredict(HpredR, target, myHero)
				if RHitChance >= Config.adv.r.phase2hs then
					CastSpell(_R, RPos.x+math.random(Config.human.rjitter*-1,Config.human.rjitter), RPos.z+math.random(Config.human.rjitter*-1,Config.human.rjitter))
				end
			end
			if rpreds[Config.adv.r.phase2pred] == "S1mplePredict" then
				preX, preZ = S1mplePredict(target)
				if preX and preZ then
					CastSpell(_R,preX+randdstx, preZ+randdstz)
				end
			end
			if rpreds[Config.adv.r.phase2pred] == "On Target" then
				CastSpell(_R,target.x+randdstx, target.z+randdstz)
			end
			p("Phase 2 Ultimate casted using: "..rpreds[Config.adv.r.phase2pred])
			return
		else
		--PHASE 3
			if distance < Config.adv.r.phase3 then
				if rpreds[Config.adv.r.phase3pred] == "VPrediction" then
					local  CastPosition, HitChance, Position = VP:GetCircularCastPosition(target, ZiggsR.delay, ZiggsR.width, ZiggsR.range, ZiggsR.speed, myHero, false)
					if CastPosition and HitChance >= Config.adv.r.phase3hs and GetDistance(CastPosition) <= 5850 then
						CastSpell(_R, CastPosition.x+randdstx, CastPosition.z+randdstz)
					end
				end
				if rpreds[Config.adv.r.phase3pred] == "SPrediction" then
					CastPosition, Chance, PredPos = SPred:Predict(target, ZiggsR.range, ZiggsR.speed, ZiggsR.delay, ZiggsR.width, false, myHero)
					if Chance >= Config.adv.r.phase3hs and GetDistance(CastPosition) < 5850 then
						CastSpell(_R, CastPosition.x+randdstx, CastPosition.z+randdstz)
					end
				end
				if rpreds[Config.adv.r.rpreds] == "HPrediction" then
					local RPos, RHitChance = HPred:GetPredict(HpredR, target, myHero)
					if RHitChance >= Config.adv.r.phase2hs then
						CastSpell(_R, RPos.x+math.random(Config.human.rjitter*-1,Config.human.rjitter), RPos.z+math.random(Config.human.rjitter*-1,Config.human.rjitter))
					end
				end
				if rpreds[Config.adv.r.phase3pred] == "S1mplePredict" then
					preX, preZ = S1mplePredict(target)
					if preX and preZ then
						CastSpell(_R,preX+randdstx, preZ+randdstz)
					end
				end
				if rpreds[Config.adv.r.phase3pred] == "On Target" then
					CastSpell(_R,target.x+randdstx, target.z+randdstz)
				end
				p("Phase 3 Ultimate casted using: "..rpreds[Config.adv.r.phase3pred])
				return
			end
		end
	end
end
function OnUnload()
	p("Unloaded")
end
--[[========= S1mple Libary =========]]--
function lines(str)
  local t = {}
  local function helper(line) table.insert(t, line) return "" end
  helper((str:gsub("(.-)\r?\n", helper)))
  return t
end
function getDistance(X,Y,X1,Y1)
	--(X-X1)^2+(Z-Z1)^2 <= R^2 if in range
	return math.sqrt(((X-X1)^2)+((Y-Y1)^2))
end
--[[========= Walljumps =========]]--
--startX,startY,start,Z,endX,endY,endZ
jumps = {{5948,52,2458,5424,51,2458},{8348,52,3276,8395,51,2798},{6398,50,3460,6775,49,3814},{11780,-71,4554,11973,52,4753},{9338,-71,4490,8969,53,4541},{9722,71,3908,9659,58,3513},{9446,-62,4146,9124,54,3859},{8022,54,4258,7972,51,4738},{3080,57,6014,3319,52,6224},{3924,51,7408,3865,52,7736},{2224,52,8256,2017,50,7936},{2874,51,9156,2516,52,9107},{2916,52,8348,3168,51,8848},{3078,54,10010,3334,-65,10249},{4024,51,8056,4340,49,8154},{9496,58,3146,9404,49,2810},{8942,52,4962,9142,-71,5402},{7822,52,6008,8012,-11,6240},{5724,52,7806,6024,68,8206},{4624,71,10756,4374,49,11250},{5374,-71,10756,5532,57,11136},{5448,71,10326,5840,55,10350},{5284,57,11818,5356,58,12092},{6524,56,12006,6564,54,11722},{8522,53,11356,8172,51,11106},{11072,67,9106,11172,52,9706},{11772,50,8856,11588,64,8726},{11722,56,8356,12075,52,8106},{12620,52,6642,12920,52,6942},{12768,52,6124,13160,57,5946},{12306,59,5826,11972,51,5728},{7124,52,6058,7030,56,5546},{7224,55,10206,7074,56,10606},{6824,56,10950,6418,56,11168},{10712,52,7034,10322,52,6958},{11072,52,7208,11048,52,7500},{11122,52,7806,11022,63,8156},{10772,63,8306,10322,60,8406},{9222,53,7058,8872,-71,6608},{7054,53,8744,6874,-70,8626},{7572,53,8956,7822,52,9306}}
function MarkJumps()
	for key, value in pairs(jumps) do
		local n = ((myHero.x-value[1])^2+(myHero.z-value[3])^2)
		n = math.sqrt(math.round(n))
		if n <= Config.draws.drawwalljumprange then
			if Config.draws.drawwalljumpmini == true then
				DrawCircleMinimap(value[1], value[2], value[3], 100, 2, c_green)
				DrawCircleMinimap(value[4], value[5], value[6], 100, 2, c_green)
			end
			if Config.keys.walljump == true then
				DrawCircle3D(value[1], value[2], value[3], 100, 2, c_green)
				DrawLine3D(value[1],value[2],value[3],value[4],value[5],value[6], 3, c_green)
				DrawCircle3D(value[4], value[5], value[6], 100, 2, c_green)
			end
		end
	end
end
function Jump()
	Jump_inrange = false
	if Config.adv.movewalljump == true and Jump_inrange == false then
		myHero:MoveTo(mousePos.x, mousePos.z)
	end
	for key, value in pairs(jumps) do
		local n = ((mousePos.x-value[1])^2+(mousePos.z-value[3])^2)
		n = math.sqrt(math.round(n))
		if n <= 100 then
			Jump_inrange = true
			myHero:MoveTo(value[1],value[3])
		else
			Jump_inrange = false
		end
		if inRange(math.round(myHero.x), value[1]) == true and inRange(math.round(myHero.z), value[3]) == true then
			local v5 = value[4]-value[1]
			local v6 = value[6]-value[3]
			local cp1 = (value[1]-v5/2)
			local cp2 = (value[3]-v6/2)
			CastSpell(_W,cp1,cp2)
		end
	end
	for key, value in pairs(jumps) do --Reverse jump
		local n = ((mousePos.x-value[4])^2+(mousePos.z-value[6])^2)
		n = math.sqrt(math.round(n))
		if n <= 100 then
			Jump_inrange = true
			myHero:MoveTo(value[4],value[6])
		else
			Jump_inrange = false
		end
		if inRange(math.round(myHero.x), value[4]) == true and inRange(math.round(myHero.z), value[6]) == true then
			local v7 = value[1]-value[4]
			local v8 = value[3]-value[6]
			local cp3 = (value[4]-v7/2)
			local cp4 = (value[6]-v8/2)
			CastSpell(_W,cp3,cp4)
		end
	end
end
function inRange(cmp1, cmp2, range)
	if not range then
		range = 20
	end
	if cmp1 >= cmp2-range and cmp1 <= cmp2+range then
		return true
	else
		return false
	end
end