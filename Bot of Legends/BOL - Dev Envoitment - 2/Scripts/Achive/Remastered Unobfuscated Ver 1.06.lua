local scriptVersion = 1.07

-- Script Status --
assert(load(Base64Decode("G0x1YVIAAQQEBAgAGZMNChoKAAAAAAAAAAAAAQIKAAAABgBAAEFAAAAdQAABBkBAAGUAAAAKQACBBkBAAGVAAAAKQICBHwCAAAQAAAAEBgAAAGNsYXNzAAQNAAAAU2NyaXB0U3RhdHVzAAQHAAAAX19pbml0AAQLAAAAU2VuZFVwZGF0ZQACAAAAAgAAAAgAAAACAAotAAAAhkBAAMaAQAAGwUAABwFBAkFBAQAdgQABRsFAAEcBwQKBgQEAXYEAAYbBQACHAUEDwcEBAJ2BAAHGwUAAxwHBAwECAgDdgQABBsJAAAcCQQRBQgIAHYIAARYBAgLdAAABnYAAAAqAAIAKQACFhgBDAMHAAgCdgAABCoCAhQqAw4aGAEQAx8BCAMfAwwHdAIAAnYAAAAqAgIeMQEQAAYEEAJ1AgAGGwEQA5QAAAJ1AAAEfAIAAFAAAAAQFAAAAaHdpZAAEDQAAAEJhc2U2NEVuY29kZQAECQAAAHRvc3RyaW5nAAQDAAAAb3MABAcAAABnZXRlbnYABBUAAABQUk9DRVNTT1JfSURFTlRJRklFUgAECQAAAFVTRVJOQU1FAAQNAAAAQ09NUFVURVJOQU1FAAQQAAAAUFJPQ0VTU09SX0xFVkVMAAQTAAAAUFJPQ0VTU09SX1JFVklTSU9OAAQEAAAAS2V5AAQHAAAAc29ja2V0AAQIAAAAcmVxdWlyZQAECgAAAGdhbWVTdGF0ZQAABAQAAAB0Y3AABAcAAABhc3NlcnQABAsAAABTZW5kVXBkYXRlAAMAAAAAAADwPwQUAAAAQWRkQnVnc3BsYXRDYWxsYmFjawABAAAACAAAAAgAAAAAAAMFAAAABQAAAAwAQACBQAAAHUCAAR8AgAACAAAABAsAAABTZW5kVXBkYXRlAAMAAAAAAAAAQAAAAAABAAAAAQAQAAAAQG9iZnVzY2F0ZWQubHVhAAUAAAAIAAAACAAAAAgAAAAIAAAACAAAAAAAAAABAAAABQAAAHNlbGYAAQAAAAAAEAAAAEBvYmZ1c2NhdGVkLmx1YQAtAAAAAwAAAAMAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAUAAAAFAAAABQAAAAUAAAAFAAAABQAAAAUAAAAFAAAABgAAAAYAAAAGAAAABgAAAAUAAAADAAAAAwAAAAYAAAAGAAAABgAAAAYAAAAGAAAABgAAAAYAAAAHAAAABwAAAAcAAAAHAAAABwAAAAcAAAAHAAAABwAAAAcAAAAIAAAACAAAAAgAAAAIAAAAAgAAAAUAAABzZWxmAAAAAAAtAAAAAgAAAGEAAAAAAC0AAAABAAAABQAAAF9FTlYACQAAAA4AAAACAA0XAAAAhwBAAIxAQAEBgQAAQcEAAJ1AAAKHAEAAjABBAQFBAQBHgUEAgcEBAMcBQgABwgEAQAKAAIHCAQDGQkIAx4LCBQHDAgAWAQMCnUCAAYcAQACMAEMBnUAAAR8AgAANAAAABAQAAAB0Y3AABAgAAABjb25uZWN0AAQRAAAAc2NyaXB0c3RhdHVzLm5ldAADAAAAAAAAVEAEBQAAAHNlbmQABAsAAABHRVQgL3N5bmMtAAQEAAAAS2V5AAQCAAAALQAEBQAAAGh3aWQABAcAAABteUhlcm8ABAkAAABjaGFyTmFtZQAEJgAAACBIVFRQLzEuMA0KSG9zdDogc2NyaXB0c3RhdHVzLm5ldA0KDQoABAYAAABjbG9zZQAAAAAAAQAAAAAAEAAAAEBvYmZ1c2NhdGVkLmx1YQAXAAAACgAAAAoAAAAKAAAACgAAAAoAAAALAAAACwAAAAsAAAALAAAADAAAAAwAAAANAAAADQAAAA0AAAAOAAAADgAAAA4AAAAOAAAACwAAAA4AAAAOAAAADgAAAA4AAAACAAAABQAAAHNlbGYAAAAAABcAAAACAAAAYQAAAAAAFwAAAAEAAAAFAAAAX0VOVgABAAAAAQAQAAAAQG9iZnVzY2F0ZWQubHVhAAoAAAABAAAAAQAAAAEAAAACAAAACAAAAAIAAAAJAAAADgAAAAkAAAAOAAAAAAAAAAEAAAAFAAAAX0VOVgA="), nil, "bt", _ENV))() ScriptStatus("TGJIIJIFJHN")
 
local Champions =
{
	["Alistar"] = true,
	["Annie"] = true,
	-- ["Bard"] = true,
	["Blitzcrank"] = true,
	-- ["Braum"] = true,
	["Janna"] = true,
	-- ["Karma"] = true,
	["Leona"] = true,
	--["Lulu"] = true,
	-- ["Lux"] = true,
	["Malphite"] = true,
	["Morgana"] = true,
	["Nami"] = true,
	-- ["Nautilus"] = true,
	-- ["Nunu"] = true,
	-- ["Shen"] = true,
    ["Sona"] = true,
	["Soraka"] = true,
	-- ["TahmKench"] = true,
	-- ["Taric"] = true,
	["Thresh"] = true,
	-- ["Zilean"] = true,
	-- ["Zyra"] = true
}
 
local Interrupt = {
	["Katarina"] = { charName = "Katarina", stop = { ["KatarinaR"] = { name = "Death lotus", spellName = "KatarinaR", ult = true } } },
	["Nunu"] = { charName = "Nunu", stop = { ["AbsoluteZero"] = { name = "Absolute Zero", spellName = "AbsoluteZero", ult = true } } },
	["Malzahar"] = { charName = "Malzahar", stop = { ["AlZaharNetherGrasp"] = { name = "Nether Grasp", spellName = "AlZaharNetherGrasp", ult = true } } },
	["Caitlyn"] = { charName = "Caitlyn", stop = { ["CaitlynAceintheHole"] = { name = "Ace in the hole", spellName = "CaitlynAceintheHole", ult = true, projectileName = "caitlyn_ult_mis.troy" } } },
	["FiddleSticks"] = { charName = "FiddleSticks", stop = { ["Crowstorm"] = { name = "Crowstorm", spellName = "Crowstorm", ult = true } } },
	["Galio"] = { charName = "Galio", stop = { ["GalioIdolOfDurand"] = { name = "Idole Of Durand", spellName = "GalioIdolOfDurand", ult = true } } },
	["Janna"] = { charName = "Janna", stop = { ["ReapTheWhirlwind"] = { name = "Monsoon", spellName = "ReapTheWhirlwind", ult = true } } },
	["MissFortune"] = { charName = "MissFortune", stop = { ["MissFortune"] = { name = "Bullet time", spellName = "MissFortuneBulletTime", ult = true } } },
	["MasterYi"] = { charName = "MasterYi", stop = { ["MasterYi"] = { name = "Meditate", spellName = "Meditate", ult = false } } },
	["Pantheon"] = { charName = "Pantheon", stop = { ["PantheonRJump"] = { name = "Skyfall", spellName = "PantheonRJump", ult = true } } },
	["Shen"] = { charName = "Shen", stop = { ["ShenStandUnited"] = { name = "Stand United", spellName = "ShenStandUnited", ult = true } } },
	["Urgot"] = { charName = "Urgot", stop = { ["UrgotSwap2"] = { name = "Position Reverser", spellName = "UrgotSwap2", ult = true } } },
	["Varus"] = { charName = "Varus", stop = { ["VarusQ"] = { name = "Piercing Arrow", spellName = "Varus", ult = false } } },
	["Warwick"] = { charName = "Warwick", stop = { ["InfiniteDuress"] = { name = "Infinite Duress", spellName = "InfiniteDuress", ult = true } } }
}
 
local dashSpells = {}
local DashSpells = {
	['Ahri'] = { true, spell = _R, range = 450, projSpeed = 2200, stop = { name = "Spirit Rush" } },
	--['Aatrox'] = { true, spell = _Q, range = 1000, projSpeed = 1200, name = "Dark Flight", },
	['Akali'] = { true, spell = _R, range = 800, projSpeed = 2200, name = "Shadow Dance", },
	['Alistar'] = { true, spell = _W, range = 650, projSpeed = 2000, name = "Headbutt",  },
	--['Amumu'] = { true, spell = _Q, range = 1100, projSpeed = 1800, },
	['Corki'] = { true, spell = _W, range = 800, projSpeed = 650, },
	['Diana'] = { true, spell = _R, range = 825, projSpeed = 2000, },
	['Darius'] = { true, spell = _R, range = 460, projSpeed = huge, },
	['Fiora'] = { true, spell = _Q, range = 600, projSpeed = 2000, },
	['Fizz'] = { true, spell = _Q, range = 550, projSpeed = 2000, },
	['Gragas'] = { true, spell = _E, range = 600, projSpeed = 2000, },
	['Graves'] = { true, spell = _E, range = 425, projSpeed = 2000, exeption = true, name = "Quickdraw", },
	['Irelia'] = { true, spell = _Q, range = 650, projSpeed = 2200, },
	['JarvanIV'] = { true, spell = _Q, range = 770, projSpeed = 2000, },
	['Jax'] = { true, spell = _Q, range = 700, projSpeed = 2000, },
	['Jayce'] = { true, spell = 'JayceToTheSkies', range = 600, projSpeed = 2000, },
	['Khazix'] = { true, spell = _E, range = 900, projSpeed = 2000, },
	['Leblanc'] = { true, spell = _W, range = 600, projSpeed = 2000, },
	['Leona'] = { true, spell = _E, range = 900, projSpeed = 2000, },
	['Lucian'] = { true, spell = _E, range = 425, projSpeed = 2000, },
	['MonkeyKing'] = { true, spell = _E, range = 650, projSpeed = 2200, },
	['Pantheon'] = { true, spell = _W, range = 600, projSpeed = 2000, },
	['Poppy'] = { true, spell = _E, range = 525, projSpeed = 2000, },
	['Riven'] = { true, spell = _E, range = 150, projSpeed = 2000, },
	['Renekton'] = { true, spell = _E, range = 450, projSpeed = 2000, },
	['Sejuani'] = { true, spell = _Q, range = 650, projSpeed = 2000, },
	['Shen'] = { true, spell = _E, range = 575, projSpeed = 2000, },
	['Shyvana'] = { true, spell = _R, range = 1000, projSpeed = 2000, },
	['Tristana'] = { true, spell = _W, range = 900, projSpeed = 2000, },
	['XinZhao'] = { true, spell = _E, range = 650, projSpeed = 2000, },
	['Yasuo'] = { true, spell = _E, range = 475, projSpeed = 1000, },
	['Vayne'] = { true, spell = _Q, range = 300, projSpeed = 1000, }
}
 
local DangerousSpells = {
	["Akali"] = { true, spell = _R },
	["Alistar"] = { true, spell = _W },
	["Amumu"] = { true, spell = _R },
	["Annie"] = { true, spell = _R },
	["Ashe"] = { true, spell = _R },
	["Akali"] = { true, spell = _R },
	["Brand"] = { true, spell = _R },
	["Braum"] = { true, spell = _R },
	["Caitlyn"] = { true, spell = _R },
	["Cassiopeia"] = { true, spell = _R },
	["Chogath"] = { true, spell = _R },
	["Darius"] = { true, spell = _R },
	["Diana"] = { true, spell = _R },
	["Draven"] = { true, spell = _R },
	["Ekko"] = { true, spell = _R },
	["Evelynn"] = { true, spell = _R },
	["Fiora"] = { true, spell = _R },
	["Fizz"] = { true, spell = _R },
	["Galio"] = { true, spell = _R },
	["Garen"] = { true, spell = _R },
	["Gnar"] = { true, spell = _R },
	["Graves"] = { true, spell = _R },
	["Hecarim"] = { true, spell = _R },
	["JarvanIV"] = { true, spell = _R },
	["Jinx"] = { true, spell = _R },
	["Katarina"] = { true, spell = _R },
	["Kennen"] = { true, spell = _R },
	["LeBlanc"] = { true, spell = _R },
	["LeeSin"] = { true, spell = _R },
	["Leona"] = { true, spell = _R },
	["Lissandra"] = { true, spell = _R },
	["Lux"] = { true, spell = _R },
	["Malphite"] = { true, spell = _R },
	["Malzahar"] = { true, spell = _R },
	["Morgana"] = { true, spell = _R },
	["Nautilus"] = { true, spell = _R },
	["Nocturne"] = { true, spell = _R },
	["Orianna"] = { true, spell = _R },
	["Rammus"] = { true, spell = _E },
	["Riven"] = { true, spell = _R },
	["Sejuani"] = { true, spell = _R },
	["Shen"] = { true, spell = _E },
	["Skarner"] = { true, spell = _R },
	["Sona"] = { true, spell = _R },
	["Symdra"] = { true, spell = _R },
	["Tristana"] = { true, spell = _R },
	["Urgot"] = { true, spell = _R },
	["Varus"] = { true, spell = _R },
	["Veigar"] = { true, spell = _R },
	["Vi"] = { true, spell = _R },
	["Viktor"] = { true, spell = _R },
	["Warwick"] = { true, spell = _R },
	["Yasuo"] = { true, spell = _R },
	["Zed"] = { true, spell = _R },
	["Ziggs"] = { true, spell = _R },
	["Zyra"] = { true, spell = _R }
}

ItemNames				= {
		[3303]				= "ArchAngelsDummySpell",
		[3007]				= "ArchAngelsDummySpell",
		[3144]				= "BilgewaterCutlass",
		[3188]				= "ItemBlackfireTorch",
		[3153]				= "ItemSwordOfFeastAndFamine",
		[3405]				= "TrinketSweeperLvl1",
		[3411]				= "TrinketOrbLvl1",
		[3166]				= "TrinketTotemLvl1",
		[3450]				= "OdinTrinketRevive",
		[2041]				= "ItemCrystalFlask",
		[2054]				= "ItemKingPoroSnack",
		[2138]				= "ElixirOfIron",
		[2137]				= "ElixirOfRuin",
		[2139]				= "ElixirOfSorcery",
		[2140]				= "ElixirOfWrath",
		[3184]				= "OdinEntropicClaymore",
		[2050]				= "ItemMiniWard",
		[3401]				= "HealthBomb",
		[3363]				= "TrinketOrbLvl3",
		[3092]				= "ItemGlacialSpikeCast",
		[3460]				= "AscWarp",
		[3361]				= "TrinketTotemLvl3",
		[3362]				= "TrinketTotemLvl4",
		[3159]				= "HextechSweeper",
		[2051]				= "ItemHorn",
		--[2003]			= "RegenerationPotion",
		[3146]				= "HextechGunblade",
		[3187]				= "HextechSweeper",
		[3190]				= "IronStylus",
		[2004]				= "FlaskOfCrystalWater",
		[3139]				= "ItemMercurial",
		[3222]				= "ItemMorellosBane",
		[3042]				= "Muramana",
		[3043]				= "Muramana",
		[3180]				= "OdynsVeil",
		[3056]				= "ItemFaithShaker",
		[2047]				= "OracleExtractSight",
		[3364]				= "TrinketSweeperLvl3",
		[2052]				= "ItemPoroSnack",
		[3140]				= "QuicksilverSash",
		[3143]				= "RanduinsOmen",
		[3074]				= "ItemTiamatCleave",
		[3800]				= "ItemRighteousGlory",
		[2045]				= "ItemGhostWard",
		[3342]				= "TrinketOrbLvl1",
		[3040]				= "ItemSeraphsEmbrace",
		[3048]				= "ItemSeraphsEmbrace",
		[2049]				= "ItemGhostWard",
		[3345]				= "OdinTrinketRevive",
		[2044]				= "SightWard",
		[3341]				= "TrinketSweeperLvl1",
		[3069]				= "shurelyascrest",
		[3599]				= "KalistaPSpellCast",
		[3185]				= "HextechSweeper",
		[3077]				= "ItemTiamatCleave",
		[2009]				= "ItemMiniRegenPotion",
		[2010]				= "ItemMiniRegenPotion",
		[3023]				= "ItemWraithCollar",
		[3290]				= "ItemWraithCollar",
		[2043]				= "VisionWard",
		[3340]				= "TrinketTotemLvl1",
		[3090]				= "ZhonyasHourglass",
		[3154]				= "wrigglelantern",
		[3142]				= "YoumusBlade",
		[3157]				= "ZhonyasHourglass",
		[3512]				= "ItemVoidGate",
		[3131]				= "ItemSoTD",
		[3137]				= "ItemDervishBlade",
		[3352]				= "RelicSpotter",
		[3350]				= "TrinketTotemLvl2",
	}
 
local ImmuneEffects = {
	{ 'zhonyas_ring_activate.troy', 2.55, 'zhonyashourglass' },
	{ 'Aatrox_Passive_Death_Activate.troy', 3 },
	{ 'LifeAura.troy', 4 },
	{ 'nickoftime_tar.troy', 7 },
	{ 'eyeforaneye_self.troy', 2 },
	{ 'UndyingRage_buf.troy', 5 },
	{ 'EggTimer.troy', 6 },
	{ 'LOC_Suppress.troy', 1.75, 'infiniteduresschannel' },
	{ 'OrianaVacuumIndicator.troy', 0.50 },
	{ 'NocturneUnspeakableHorror_beam.troy', 2 },
	{ 'GateMarker_green.troy', 1.5 },
	{ '_stasis_skin_ful', 2.6 }
}

local ccTable = { 'Stun', 'Silence', 'Taunt', 'Slow', 'Root', 'Blind', 'Supress' }
local ccP = {5, 7, 8, 10, 11, 25, 24}  
local updated = false
local buffs = {}
local ts = nil
local sflash = nil
local flashPos = nil 
local towerCount
local towers = { }
local Target = GetTarget()
local allyHeroes, enemyHeroes = GetAllyHeroes(), GetEnemyHeroes()
local allyCount, enemyCount = #allyHeroes, #enemyHeroes
local ceil, floor, round, max, huge, pow = math.ceil, math.floor, math.round, math.max, math.huge, math.pow

buffs["recall"] = false
 
-- Made by Nebelwolfi. Makes Classes Local, Not Global -- 
function Class(name)
	_ENV[name] = { }
	_ENV[name].__index = _ENV[name]
	local mt = { __call = function(self, ...) local b = { } setmetatable(b, _ENV[name]) b:__init(...) return b end }
	setmetatable(_ENV[name], mt)
end

-- Keydown Fix --
local originalKD = _G.IsKeyDown;
_G.IsKeyDown = function(theKey)
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

-- MAIN CLASS --
Class("_Bundle")
DelayAction( function() _Bundle() end, 0.05)

function _Bundle:Print(msg)
	print("<font color=\"#FF3300\"><b>[Support Heroes]</b></font> <font color=\"#FFFFFF\">" .. msg .. "</font>")
end

-- On Load --
function _Bundle:__init()
	self:Print("Keep a cool head and maintain a low profile. Never take the lead - but aim to do something big. -Deng Xiaoping")
	
    self:Update()
	self:LoadUPL()
	self:CheckChampion()
	
    welcome = GetSprite("SupportHeroes/Welcome.png")
    
	PR = _PentagonRot(myHero, ARGB(255,255,255,255),1,200)
	
	VPred = VPrediction()
	
	ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, 2000, DAMAGE_MAGIC, true)
	
	AddTickCallback(function() self:OnTick() end)
    AddDrawCallback(function() self:OnDraw() end)
    AddMsgCallback(function(msg, key) self:OnWndMsg(msg,key) end)
    	
	if myHero:GetSpellData(SUMMONER_1).name:find("summonerdot") then signite = SUMMONER_1
	elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerdot") then signite = SUMMONER_2 end
	if myHero:GetSpellData(SUMMONER_1).name:find("summonerheal") then sheal = SUMMONER_1
	elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerheal") then sheal = SUMMONER_2 end
	if myHero:GetSpellData(SUMMONER_1).name:find("summonerflash") then sflash = SUMMONER_1
	elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerflash") then sflash = SUMMONER_2 end
	if myHero:GetSpellData(SUMMONER_1).name:find("summonerexhaust") then sexhaust = SUMMONER_1
	elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerexhaust") then sexhaust = SUMMONER_2 end
end 

function _Bundle:OnDraw()
   if GetInGameTimer() <= 25 and not clickedMessage then
    welcome:Draw(250, 50, 255)
    end
end

function _Bundle:OnWndMsg(msg,key)
	if msg == WM_LBUTTONDOWN then
    clickedMessage = true
    end
end

-- Update --
function _Bundle:Update()
	local ToUpdate = { }
	ToUpdate.Version = scriptVersion
	ToUpdate.UseHttps = true
	ToUpdate.Host = "raw.githubusercontent.com"
	ToUpdate.VersionPath = "/UnknownHeroe/BoL/master//version/SupportHeroesRemastered.version"
	ToUpdate.ScriptPath =  "/UnknownHeroe/BoL/master/SupportHeroesRemastered.lua"
	ToUpdate.SavePath = SCRIPT_PATH .. "/" .. _ENV.FILE_NAME
	ToUpdate.CallbackUpdate = function(NewVersion, OldVersion) self:Print("Script Updated To Version " .. NewVersion .. "! Double Tap F9!") end
	ToUpdate.CallbackNoUpdate = function(OldVersion) self:Print("No Updates Found, Current Version " .. ToUpdate.Version .. "!") end
	ToUpdate.CallbackNewVersion = function(NewVersion) self:Print("New Version Found (" .. NewVersion .. ")! Please Wait Until It's Downloaded!") end
	ToUpdate.CallbackError = function(NewVersion) self:Print("Error While Downloading! Please Try Again.") end
	ScriptUpdate(ToUpdate.Version, ToUpdate.UseHttps, ToUpdate.Host, ToUpdate.VersionPath, ToUpdate.ScriptPath, ToUpdate.SavePath, function() end, function() end, function() end, function() end)
	ScriptUpdate(ToUpdate.Version, ToUpdate.UseHttps, ToUpdate.Host, ToUpdate.VersionPath, ToUpdate.ScriptPath, LIB_PATH .. "/SupportHeroesRemastered.lua", ToUpdate.CallbackUpdate, ToUpdate.CallbackNoUpdate, ToUpdate.CallbackNewVersion, ToUpdate.CallbackError)
end
 
-- Target Select --
function _Bundle:OnTick()
	if enemyMinions then enemyMinions:update() end
	Target = _Tech:GetTarget()  
end

-- Check Champion -- 
function _Bundle:CheckChampion()
	if (Champions[myHero.charName] and _ENV["_" .. myHero.charName]) then
		Champion = _ENV["_" .. myHero.charName]()
	else
		_Bundle:Print(myHero.charName .. " - Is Not Supported!")
		return
	end
end
 
 -- Load UPL --
function _Bundle:LoadUPL()
	if not _G.UPLloaded then
		if FileExist(LIB_PATH .. "/UPL.lua") then
			require("UPL")
			UPL = UPL()
		else
			_Bundle:Print("Downloading UPL, please don't press F9")
			DelayAction( function() DownloadFile("https://raw.github.com/nebelwolfi/BoL/master/Common/UPL.lua" .. "?rand=" .. math.random(1, 10000), LIB_PATH .. "UPL.lua", function() print("Successfully downloaded UPL. Press F9 twice.") end) end, 3)
			return
		end
	end
end

-- Load Orb Walk --
function _Bundle:SetupOrbwalk()   
	if _G.Reborn_Loaded then
	   SAC=true
	   _Bundle:Print("Found SAC: Reborn!")
	   DelayAction(function() menu.orb:addParam("Info", "SAC: Reborn Detected!", SCRIPT_PARAM_INFO, "") end,5)
	elseif _G.NebelwolfisOrbWalkerLoaded and not _G.Reborn_Loaded then
	   _Bundle:Print("Found Nelbelwolfi's Orbwalker!")
	   DelayAction(function() menu.orb:addParam("Info", "Nebelwolfi's Orbwalker Detected!", SCRIPT_PARAM_INFO, "") end,5)
    elseif _Pewalk then
       _Bundle:Print("Found Pewalk!")
	   DelayAction(function() menu.orb:addParam("Info", "Pewalk Detected!", SCRIPT_PARAM_INFO, "") end,5)
	elseif not _G.Reborn_Loaded and not _G.NebelwolfisOrbWalkerLoaded and FileExist(LIB_PATH .. "SxOrbWalk.lua") then
	   SxOrb=true
	   require("SxOrbWalk")
	   DelayAction(function() _G.SxOrb:LoadToMenu(menu.orb) end,5)
	   _Bundle:Print("No Orbwalker Found! SxOrb Loaded By Default!")
	elseif SAC~=true and SxOrb~= true then
	   _Bundle:Print("No Valid Orbwalker Found")
	end
end
 
 Class ("_Activator")
function _Activator:__init()
	
	AddTickCallback(function() self:OnTick() end)
	AddApplyBuffCallback(function(unit, target, buff) self:OnApplyBuff(unit, target, buff) end)
end

function _Activator:OnTick()
	if menu == nil then return end
	
	self:Exhaust()
	self:HealTeammate()
	self:Ignite()
	
	-- self:FrostQueens()
	self:FaceOfTheMountain()
	self:LocketOfIronSolari()
	self:Zhonyas()
end

function _Activator:Menu()
	menu:addSubMenu("[" .. myHero.charName .. "] - Activator", "activator")
	
	menu.activator:addSubMenu("             -- Item Settings --", "Item")

	menu.activator:addSubMenu("Face of the Mountain", "fotm")
		for i = 1, heroManager.iCount do
		local unit = heroManager:GetHero(i)
			if unit.team == myHero.team then 
			menu.activator.fotm:addParam("shield" .. unit.charName, "" .. unit.charName, SCRIPT_PARAM_ONOFF, true) 
			menu.activator.fotm:addParam("shieldhppercent"..i, "Shield If < X%", SCRIPT_PARAM_SLICE, 20, 0, 100, 0) 
			menu.activator.fotm:addParam("empty", "", SCRIPT_PARAM_INFO,"")
			end
	   end
	   
	--[[menu.activator:addSubMenu("Frost Queens", "fqs")
		menu.activator.fqs:addParam("fqs", "Use Frost Queens In Combo", SCRIPT_PARAM_ONOFF, true)  ]] 
	   
	menu.activator:addSubMenu("Locket of the Iron Solari", "lois")
		for i = 1, heroManager.iCount do
		local unit = heroManager:GetHero(i)
			if unit.team == myHero.team then  
			menu.activator.lois:addParam("shield" .. unit.charName, "" .. unit.charName, SCRIPT_PARAM_ONOFF, true) 
			menu.activator.lois:addParam("shieldhppercent"..i, "Shield If < X%", SCRIPT_PARAM_SLICE, 20, 0, 100, 0) 
			menu.activator.lois:addParam("empty", "", SCRIPT_PARAM_INFO,"")
			end
	   end
	   
	   menu.activator:addSubMenu("Mikaels Crucible", "mikaels")
			menu.activator.mikaels:addParam("info", "                -- Use on Allies --", SCRIPT_PARAM_INFO, "")	
			for i = 1, heroManager.iCount do
			local unit = heroManager:GetHero(i)
				if unit.team == myHero.team then 
				menu.activator.mikaels:addParam(unit.charName, unit.charName, SCRIPT_PARAM_ONOFF, true)
				end			
			end
			menu.activator.mikaels:addParam("info", "                -- Use to remove --", SCRIPT_PARAM_INFO, "")
			for i,v in ipairs(ccTable) do
				if ccP[i] == 10 or ccP[i] == 11 or ccP[i] == 25 then menu.activator.mikaels:addParam('ccType'..i, v, SCRIPT_PARAM_ONOFF, false)
				else menu.activator.mikaels:addParam('ccType'..i, v, SCRIPT_PARAM_ONOFF, true) 
				end
			end
			
	menu.activator:addSubMenu("Zhonya's Hourglass", "zhonyas")
		menu.activator.zhonyas:addParam("usezhonyas", "Use Zhonyas Hourglass", SCRIPT_PARAM_ONOFF, true )
		menu.activator.zhonyas:addParam("zhonyahshp", "Use If < X% HP", SCRIPT_PARAM_SLICE, 20, 0, 100, 0)
		menu.activator.zhonyas:addParam("empty", "", SCRIPT_PARAM_INFO,"")
		menu.activator.zhonyas:addParam("zhonyaszed", "Use Zhonya's On Zed's R", SCRIPT_PARAM_ONOFF, true)
		menu.activator.zhonyas:addParam("zhonyasfizz", "Use Zhonya's On Fizz's R", SCRIPT_PARAM_ONOFF, true)
		menu.activator.zhonyas:addParam("zhonyasmord", "Use Zhonya's On Mordakiser's R", SCRIPT_PARAM_ONOFF, true)
		menu.activator.zhonyas:addParam("zhonyasvlad", "Use Zhonya's On Vladimir's R", SCRIPT_PARAM_ONOFF, true)
	
	menu.activator:addSubMenu("         -- Summoner Settings --", "Summs")
	
	menu.activator:addSubMenu("Exhaust", "exhaust")
		if enemyCount > 0 then
			for i = 1, enemyCount do
			local unit = enemyHeroes[i]		
			menu.activator.exhaust:addParam("exhausttarget" .. unit.charName, "Use On ".. unit.charName, SCRIPT_PARAM_ONOFF, true)
			menu.activator.exhaust:addParam("exhausthp" .. unit.charName, "Exhaust If <X% HP", SCRIPT_PARAM_SLICE, 40, 0, 100, 0)
			menu.activator.exhaust:addParam("empty", "", SCRIPT_PARAM_INFO,"")
			end
		end
	
	menu.activator:addSubMenu("Heal", "heal")
		for i = 1, heroManager.iCount do
		local unit = heroManager:GetHero(i)
			if unit.team == myHero.team then  
			menu.activator.heal:addParam("sheal" .. unit.charName, "" .. unit.charName, SCRIPT_PARAM_ONOFF, true) 
			menu.activator.heal:addParam("smaxhppercent"..i, "Use If < X% HP", SCRIPT_PARAM_SLICE, 10, 0, 100, 0) 
			menu.activator.heal:addParam("empty", "", SCRIPT_PARAM_INFO,"")
			end
	   end
	   menu.activator.heal:addParam("enum", "Enemy Range", SCRIPT_PARAM_SLICE, 650, 0, 1500,0 )
	
	menu.activator:addSubMenu("Ignite", "ignite")
	   menu.activator.ignite:addParam("ign", "Use Ignite", SCRIPT_PARAM_ONOFF, true)
end

-- Summoners --   
function _Activator:Exhaust()
	if Target == nil then return end 
	if sexhaust == nil then return end
	if allyCount > 0 then
		for i = 1, allyCount do
		local unit = allyHeroes[i]
			if menu.key.comboKey then
				if ValidTarget(Target) and Target.team ~= myHero.team and menu.activator.exhaust["exhausttarget".. unit.charName] and (100*Target.health/Target.maxHealth) < menu.activator.exhaust["exhausthp".. unit.charName] then
					if IsReady(sexhaust) and (GetDistance(Target) < 625) then
						CastSpell(sexhaust, Target)
					end
				end
			end
		end
	end
end    

function _Activator:HealTeammate()
	if sheal == nil then return end
	for i = 1, heroManager.iCount do
	local unit = heroManager:GetHero(i)
		if unit.team == myHero.team then
			if not InFountain() and not buffs["recall"] then 
				if unit.type == myHero.type and menu.activator.heal["sheal" ..unit.charName] and (100*unit.health/unit.maxHealth) < menu.activator.heal["smaxhppercent"..i] then
					if IsReady(sheal) and (GetDistance(unit) < 850) and (GetDistance(Target) <= menu.activator.heal.enum) then 
						CastSpell(sheal)         
					end
				end    
			end
		end
	end
end 
 
function _Activator:Ignite()
   if signite == nil then return end
   if Target == nil then return end
   if ValidTarget(Target) and menu.activator.ignite.ign then
		local igniteDmg = 50+(myHero.level*20)
		if IsReady(signite) and (Target.health <= igniteDmg) and (GetDistance(Target) < 500) then
		  CastSpell(signite, Target)
		end
	end
end

-- Items --
--[[function _Activator:FrostQueens()
	if menu.key.comboKey and menu.activator.fqs then
	local slot = _Tech:CustomGetInventorySlotItem("ItemGlacialSpikeCast", myHero)	
		if slot ~= nil and IsReady(slot) then
			if (GetDistance(unit) < 850) then
				CastSpell(slot, unit)
			end
		end
	end 
end]]

function _Activator:FaceOfTheMountain()    
	if Target == nil then return end
	local slot = _Tech:CustomGetInventorySlotItem("HealthBomb", myHero)
	for i = 1, heroManager.iCount do
	local unit = heroManager:GetHero(i)
		if unit.team == myHero.team then  
			if slot ~= nil and IsReady(slot) then 
				if menu.activator.fotm["shield".. unit.charName] and (100*unit.health/unit.maxHealth) <= menu.activator.fotm["shieldhppercent"..i] then
					if (GetDistance(unit) < 750) and (GetDistance(Target) <= 700) then 
						DelayAction(function() CastSpell(slot, unit) end, menu.humanizer.shieldDelay / 1000)
					end
				end       
			end          
		end             
	end
end          
 
function _Activator:LocketOfIronSolari()
	if Target == nil then return end
	local slot = _Tech:CustomGetInventorySlotItem("IronStylus", myHero)
	for i = 1, heroManager.iCount do
	local unit = heroManager:GetHero(i)
		if unit.team == myHero.team then  
			if slot ~= nil and IsReady(slot) then 
				if menu.activator.lois["shield".. unit.charName] and (100*unit.health/unit.maxHealth) <= menu.activator.lois["shieldhppercent"..i] then
					if (GetDistance(unit) < 750) and (GetDistance(Target) <= 700) then 
						DelayAction(function() CastSpell(slot, unit) end, menu.humanizer.shieldDelay / 1000)
					end
				end       
			end          
		end             
	end
end          

function _Activator:OnApplyBuff(unit, target, buff)
	if Target == nil then return end
	local slot = _Tech:CustomGetInventorySlotItem("ItemMorellosBane", myHero)	
	if slot ~= nil and IsReady(slot) then
		for i,v in ipairs(ccTable) do
			if ccP[i] == buff.type and menu.activator.mikaels['ccType'..i] then
				if target.team == myHero.team and not target.isMe and menu.activator.mikaels[target.charName] and unit.type == myHero.type then
					if (GetDistance(target) < 750) and (GetDistance(Target) <= 700) and not target.dead then
						DelayAction(function() CastSpell(slot, target) end, menu.humanizer.shieldDelay / 1000)
					end
				end
			end
		end
	end
end
 
function _Activator:Zhonyas()
	local slot = _Tech:CustomGetInventorySlotItem("ZhonyasHourglass", myHero)
	if slot ~= nil and menu.activator.zhonyas and IsReady(slot) then
		local timer = 2
		if menu.activator.zhonyas.zhonyaszed and TargetHaveBuff("zedrdeathmark") then
			timer = _Tech:getPassiveTimer(myHero, "zedrdeathmark")
		end
		if menu.activator.zhonyas.zhonyasfizz and TargetHaveBuff("FizzMarinerDoom") then
			timer = _Tech:getPassiveTimer(myHero, "FizzMarinerDoom")
		end
		if menu.activator.zhonyas.zhonyasmord and TargetHaveBuff("MordekaiserChildrenOfTheGrave") then
			timer = _Tech:getPassiveTimer(myHero, "MordekaiserChildrenOfTheGrave")
		end
		if menu.activator.zhonyas.zhonyasvlad and TargetHaveBuff("VladimirHemoplague") then
			timer = _Tech:getPassiveTimer(myHero, "VladimirHemoplague")
		end
		if timer < 1 and timer > 0 then
			CastSpell(slot)
		end
		if (100*myHero.health/myHero.maxHealth) < menu.activator.zhonyas.zhonyahshp then
			CastSpell(slot)
		end
	end
end 

-- CHAMPIONS --
Class("_Alistar")
function _Alistar:__init()
	self:LoadVariables()
	self:Menu()
	
	_Bundle:SetupOrbwalk()
	
	_Activator:__init()
	
	_Tech:AddTurrets()
	towerCount = #towers
	
	AddTickCallback(function() self:OnTick() end)
	AddDrawCallback(function() self:OnDraw() end)
	AddRemoveBuffCallback(function(unit, buff) self:RemoveBuff(unit, buff) end)
	AddApplyBuffCallback(function(unit, target, buff) self:ApplyBuff(unit, target, buff) end)
	AddProcessAttackCallback(function(object, spell) self:ProcessAttack(object, spell) end)
	
	enemyMinions = minionManager(MINION_ENEMY, 365, myHero, MINION_SORT_HEALTH_DES)
	
	_Bundle:Print(myHero.charName .. " Loaded, Good Luck!")
end

function _Alistar:LoadVariables()
	self.SpellQ = { speed = math.huge, delay = 0.5, range = 365, width = 100, collision = false, aoe = true, type = "circular" }

	self.SpellW = { speed = 1000, delay = 0.55, range = 650, width = nil, collision = true, aoe = false, type = "linear" }

	self.SpellE = { speed = nil, delay = 0.5, range = 575, width = nil, collision = false, aoe = true, type = "circular" }

	self.SpellR = { speed = nil, delay = 0.25, range = nil, width = nil, collision = false, aoe = false, type = "linear" }
	
	UPL:AddSpell(_Q, self.SpellQ)
end

function _Alistar:OnTick()
   if menu == nil then return end
   
	self:AutoHeal()
	self:AutoUlt()
	self:Combo()
	self:FlashCombo()
	self:Harass() 
	self:LaneClear()
	self:TowerCC()
end

function _Alistar:Menu()
	menu = scriptConfig("Support Heroes", "SupportHeroesMenuAlistar")
	
	_Activator:Menu()
 
	menu:addSubMenu("[" .. myHero.charName .. "] - Auto-Heal", "ah")
		for i = 1, heroManager.iCount do
		local unit = heroManager:GetHero(i)
			if unit.team == myHero.team then  
			menu.ah:addParam("heal" .. unit.charName, "" .. unit.charName, SCRIPT_PARAM_ONOFF, true) 
			menu.ah:addParam("maxhppercent"..i, "Heal Until HP = X%", SCRIPT_PARAM_SLICE, 75, 0, 100, 0) 
			menu.ah:addParam("empty", "", SCRIPT_PARAM_INFO,"")
			end
		end
		menu.ah:addParam("healmana", "Heal If Mana >X%", SCRIPT_PARAM_SLICE, 45, 0, 100, 0)
				 
	menu:addSubMenu("[" .. myHero.charName .. "] - Auto-CC Under Tower", "snare")
		menu.snare:addParam("info", "           -- Auto-CC Enemies --", SCRIPT_PARAM_INFO, "")
		if enemyCount > 0 then
			for i = 1, enemyCount do
			local unit = enemyHeroes[i]			
				menu.snare:addParam("" .. unit.charName, "" .. unit.charName, SCRIPT_PARAM_ONOFF, true)
			end
		end
		menu.snare:addParam("settings", "                    -- Settings --", SCRIPT_PARAM_INFO, "")
		menu.snare:addParam("qsnare", "Use Q", SCRIPT_PARAM_ONOFF, true)
		
	menu:addSubMenu("[" .. myHero.charName .. "] - Auto-Interrupt", "interrupt")   
		menu.interrupt:addParam("spells", "           -- Auto Interrupt Spells --", SCRIPT_PARAM_INFO, "")
		if enemyCount > 0 then
			for i = 1, enemyCount do
				local unit = enemyHeroes[i]
				if Interrupt[unit.charName] ~= nil then
					for i, spell in pairs(Interrupt[unit.charName].stop) do
						menu.interrupt:addParam("" .. unit.charName, "" .. unit.charName, SCRIPT_PARAM_INFO, "") 
						menu.interrupt:addParam(spell.spellName,"" .. spell.name, SCRIPT_PARAM_ONOFF, true)
						menu.interrupt:addParam("empty", "", SCRIPT_PARAM_INFO,"")
					end 
				end
			end
		end
		menu.interrupt:addParam("settings", "                    -- Settings --", SCRIPT_PARAM_INFO, "")
		menu.interrupt:addParam("qinterrupt", "Use Q", SCRIPT_PARAM_ONOFF, false)
		menu.interrupt:addParam("winterrupt", "Use W", SCRIPT_PARAM_ONOFF, true)
		
	menu:addSubMenu("[" .. myHero.charName .. "] - Draw Settings", "draw")
		menu.draw:addParam("spelldraws", "                -- Spell Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawq", "Draw Q", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colorq", "Color Q", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("draww", "Draw W", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colorw", "Color W", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawe", "Draw E", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colore", "Color E", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("miscellaneousdraws", "                -- Flash Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawqflash", "Draw Flash - Q", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorqflash", "Color Flash - Q", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawwqflash", "Draw Flash - W - Q", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colorwqflash", "Color Flash - W - Q", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 }) 
		menu.draw:addParam("drawinsecflash", "Draw Insec Flash", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")	
		menu.draw:addParam("drawitem", "                -- Item Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawfotm", "Draw Face of the Mountain", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorfotm", "Color Face of the Mountain", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawlois", "Draw Locket of the Iron Solari", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorlois", "Color Locket of the Iron Solari", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawmikaels", "Draw Mikaels Crucible", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colormikaels", "Color Mikaels Crucible", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 }) 
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawsumm", "                -- Summoner Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawexhaust", "Draw Exhaust", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorexhaust", "Color Exhaust", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawheal", "Draw Heal", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorheal", "Color Heal", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawignite", "Draw Ignite", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorignite", "Color Ignite", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 }) 
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")  
		menu.draw:addParam("miscellaneousdraws", "            -- Miscellaneous Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawtarget", "Draw Target", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("drawpermashow", "Draw Permashow (Reload)", SCRIPT_PARAM_ONOFF, true)
			
	menu:addSubMenu("[" .. myHero.charName .. "] - Farm Settings", "farm")
		menu.farm:addParam("laneclear", "                    -- Lane Clear --", SCRIPT_PARAM_INFO, "")
		menu.farm:addParam("qlaneclear", "Use Q", SCRIPT_PARAM_ONOFF, true)
		menu.farm:addParam("clearmana", "Minimum Mana", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		
	menu:addSubMenu("[" .. myHero.charName .. "] - Flash Settings", "flash")
		menu.flash:addParam("insecflash", "Use Insec Flash", SCRIPT_PARAM_ONOFF, true)
		menu.flash:addParam("qflash", "Use Flash - Q", SCRIPT_PARAM_ONOFF, false)
		menu.flash:addParam("wqflash", "Use Flash - W - Q", SCRIPT_PARAM_ONOFF, true)
	
	menu:addSubMenu("[" .. myHero.charName .. "] - Humanizer", "humanizer")
		menu.humanizer:addParam("interruptDelay", "Auto-Interrupt Delay (ms)", SCRIPT_PARAM_SLICE, 200, 0, 500, 0)
		menu.humanizer:addParam("snareDelay", "Auto-CC Delay (ms)", SCRIPT_PARAM_SLICE, 0, 0, 500, 0)
		menu.humanizer:addParam("shieldDelay", "Auto Shield Delay (ms)", SCRIPT_PARAM_SLICE, 50, 0, 500, 0)
			
	menu:addSubMenu("[" .. myHero.charName .. "] - Key Settings", "key")
		menu.key:addParam("combatkeys", "               -- Combat Keys --", SCRIPT_PARAM_INFO, "")
		menu.key:addParam("comboKey", "Combo Key", SCRIPT_PARAM_ONKEYDOWN, false, 32)
		menu.key:addParam("harassKey", "Harass Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
		menu.key:addParam("harassToggle", "Harass Toggle", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("T"))
		menu.key:addParam("clearKey", "Lane Clear Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
		menu.key:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.key:addParam("miscellaneouskeys", "           -- Miscellaneous Keys --", SCRIPT_PARAM_INFO, "")
		menu.key:addParam("flashKey", "Flash Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("H"))
	
	menu:addSubMenu("[" .. myHero.charName .. "] - Spell Settings", "spell")
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - Q", "q")
		menu.spell.q:addParam("qcombo", "Combo", SCRIPT_PARAM_ONOFF, true)
		menu.spell.q:addParam("qcombomana", "[Combo] Mana > X%", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
		menu.spell.q:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.q:addParam("qharass", "Harass", SCRIPT_PARAM_ONOFF, true)
		menu.spell.q:addParam("qharassmana", "[Harass] Mana > X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - W", "w")
		menu.spell.w:addParam("wcombo", "Combo", SCRIPT_PARAM_ONOFF, true)
		menu.spell.w:addParam("wcombomana", "[Combo] Mana > X%", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
		menu.spell.w:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.w:addParam("wharass", "Harass", SCRIPT_PARAM_ONOFF, true)
		menu.spell.w:addParam("wharassmana", "[Harass] Mana > X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - E", "e")
		menu.spell.e:addParam("info", "Check Auto Heal For Settings", SCRIPT_PARAM_INFO, "")
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - R", "r")
		menu.spell.r:addParam("ult", "Use Ultimate", SCRIPT_PARAM_ONOFF, true)
		menu.spell.r:addParam("ulthp", "Ult If <X% Of HP", SCRIPT_PARAM_SLICE, 15, 0, 100, 0)
		menu.spell.r:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.r:addParam("ultcc", "Use Ultimate If CC'd", SCRIPT_PARAM_ONOFF, true) 
		menu.spell.r:addParam("ultcchp", "Ult If CC'd <X% Of HP", SCRIPT_PARAM_SLICE, 15, 0, 100, 0)
		
   menu:addSubMenu("[" .. myHero.charName .. "] - Target Selector", "target")
		menu.target:addParam("targetinfo", "Default Target Select Is LeastCast", SCRIPT_PARAM_INFO, "")
		menu.target:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.target:addParam("focus", "Focus Selected Target", SCRIPT_PARAM_ONOFF, true)
		menu.target:addParam("sac", "Use SAC:R Target Instead", SCRIPT_PARAM_ONOFF, false)
		
   menu:addSubMenu("Orbwalk Settings", "orb")  
   
   UPL:AddToMenu(menu)
 
   menu:addParam("empty", "", SCRIPT_PARAM_INFO, "")
   menu:addParam("infobox", "            Support Heroes: " .. myHero.charName .. "           ", SCRIPT_PARAM_INFO, "")
   menu:addParam("infobox2", "                      Version:  " .. scriptVersion .. "         ", SCRIPT_PARAM_INFO, "")
   
   if menu.draw.drawpermashow then
	 menu:permaShow("infobox")
	 menu.key:permaShow("comboKey")
	 menu.key:permaShow("harassKey")
	 menu.key:permaShow("harassToggle")
	 menu.key:permaShow("clearKey")
   end
end

function _Alistar:ApplyBuff(unit, target, buff)
	if unit ~= nil and buff and unit.isMe and buff.name:lower() == "recall" or buff.name:lower() == "summonerteleport" or buff.name:lower() == "recallimproved" then buffs["recall"] = true end
end

function _Alistar:AutoHeal()
	for i = 1, heroManager.iCount do
		local unit = heroManager:GetHero(i)
		if unit.team == myHero.team then 
			if not InFountain() and not buffs["recall"] then 
				if unit.team == myHero.team and unit.type == myHero.type and menu.ah["heal" ..unit.charName] and (100*unit.health/unit.maxHealth) < menu.ah["maxhppercent"..i] and (100 * myHero.mana / myHero.maxMana)>= menu.ah.healmana then
					if IsReady(_E) and (GetDistance(unit) < self.SpellE.range) then 
						CastSpell(_E)         
					end
				end    
			end
		end
	end
end         

function _Alistar:AutoUlt()
	if IsReady(_R) and menu.spell.r.ult and (100 * myHero.health / myHero.maxHealth) <= menu.spell.r.ulthp then
		CastSpell(_R)
	end
	if IsReady(_R) and menu.spell.r.ultcc and (100 * myHero.health / myHero.maxHealth) <= menu.spell.r.ultcchp then 
		if myHero.canMove then
			CastSpell(_R)
		end
	end
end

function _Alistar:Combo() 
	if Target == nil then return end
	if menu.key.comboKey then 
		if IsReady(_Q) and menu.spell.q.qcombo and (100 * myHero.mana / myHero.maxMana)>= menu.spell.q.qcombomana and (GetDistance(Target) < self.SpellQ.range) then
			if ValidTarget(Target) then
				CastSpell(_Q)
			end
		end
		if IsReady(_Q) and (GetDistance(Target) > self.SpellQ.range) then 
			if IsReady(_W) and menu.spell.w.wcombo and (100 * myHero.mana / myHero.maxMana)>= menu.spell.w.wcombomana and (GetDistance(Target) < self.SpellW.range) then
				if ValidTarget(Target) then
					CastSpell(_W, Target)
				end
			end
		end
		if menu.spell.q.qcombo and menu.spell.w.wcombo then
			if IsReady(_Q) and IsReady(_W) and myHero.mana >(60 + 5 * myHero:GetSpellData(_Q).level) +(60 + 5 * myHero:GetSpellData(_W).level) and (GetDistance(Target) > 365) and (GetDistance(Target) < self.SpellW.range) then
				if ValidTarget(Target) then
					local CastPosition, HitChance, HeroPosition = UPL:Predict(_Q, myHero, Target)		
					if HitChance >= 2 then 
					CastSpell(_W, Target)                 
					DelayAction(function() CastSpell(_Q, CastPosition.x, CastPosition.y) end, (max(0 , GetDistance(Target) - 500 ) * 0.5 + 25) / 1000)
					end
				end
			end 
		end
	end       
end
 
function _Alistar:FlashCombo()
	if Target == nil then return end
	if menu.key.flashKey and menu.flash.qflash then 
		if ValidTarget(Target) and (GetDistance(Target) <= 425 + self.SpellQ.range) then
		   if IsReady(sflash) and IsReady(_Q) then
			   CastSpell(sflash, Target.x, Target.z)      
			   CastSpell(_Q)
		   end	       
		end
	end
	if menu.key.flashKey and menu.flash.wqflash then
		if ValidTarget(Target) and (GetDistance(Target) <= self.SpellW.range + 425) then
			if IsReady(sflash) and IsReady(_W) then 
				CastSpell(sflash, Target.x, Target.z)
				CastSpell(_W, Target)
				DelayAction(function() CastSpell(_Q, Target) end, (max(0 , GetDistance(Target) - 500 ) * 0.2 + 25) / 1000)          
			end
		end
	end
	for i = 1, towerCount do
	local tower = towers[i]
	   if tower and tower.team == myHero.team and GetDistance(tower) < 1200 and IsReady(sflash) and ValidTarget(Target) then
	   local Position = VPred:GetPredictedPos(Target, 0.1)
	   local flashPos = Position + 100 * (Vector(Position) - Vector(tower)):normalized()
					
		   if GetDistance(flashPos) > 425 then
			   flashPos = nil
		   end
					
		   if GetDistance(Position, flashPos) > 100 then
			  flashPos = nil
		   end
					
		   hasTower = true
					
		   if flashPos ~= nil and menu.key.flashKey and menu.flash.insecflash then					
			   if IsReady(_Q) and IsReady(_W) and myHero.mana > myHero:GetSpellData(_W).mana + myHero:GetSpellData(_Q).mana then
				 CastSpell(sflash, flashPos.x, flashPos.z)
				 CastSpell(_Q, Target)
				 CastSpell(_W, Target)
			  end
		   end
	   end
	end 
	local useAlly = nil
	local damage = 0
	for i = 1, allyCount do
	local ally = allyHeroes[i]
	   if not ally.dead and GetDistance(ally) < 800 and ValidTarget(Target) then
		   if ally.damage > damage then
			  useAlly = ally
			  damage = ally.damage
		   end
	   end
	end
	local Position = VPred:GetPredictedPos(Target, 0.1)
	local flashPos = Position + 100 * (Vector(Position) - Vector(useAlly)):normalized()
				
	if GetDistance(flashPos) > 425 then
		flashPos = nil
	end
				
	if GetDistance(Position, flashPos) > 100 then
		flashPos = nil
	end
				
	if flashPos ~= nil and menu.key.flashKey and menu.flash.insecflash then					
		if IsReady(_W) and IsReady(sflash) and myHero.mana > myHero:GetSpellData(_W).mana + myHero:GetSpellData(_Q).mana then
			CastSpell(sflash, flashPos.x, flashPos.z)
			CastSpell(_Q, Target)
			CastSpell(_W, Target)
		end
	end
	if menu.key.flashKey and IsReady(sflash) then
		myHero:MoveTo(mousePos.x, mousePos.z)
	end
end
 
function _Alistar:Harass()
	if Target == nil then return end
	if menu.key.harassKey or menu.key.harassToggle then 
		if IsReady(_Q) and menu.spell.q.qharass and (100 * myHero.mana / myHero.maxMana)>= menu.spell.q.qharassmana and (GetDistance(Target) < self.SpellQ.range) then
			if ValidTarget(Target) then
				CastSpell(_Q)
			end
		end
		if IsReady(_W) and menu.spell.w.wharass and (100 * myHero.mana / myHero.maxMana)>= menu.spell.w.wharassmana and (GetDistance(Target) < self.SpellW.range) then
			if ValidTarget(Target) then
				CastSpell(_W, Target)
			end
		end
		if menu.spell.q.qharass and menu.spell.w.wharass then
			if IsReady(_Q) and IsReady(_W) and myHero.mana >(60 + 5 * myHero:GetSpellData(_Q).level) +(60 + 5 * myHero:GetSpellData(_W).level) and (GetDistance(Target) > 365) and (GetDistance(Target) < self.SpellW.range) then
				if ValidTarget(Target) then
					local CastPosition, HitChance, HeroPosition = UPL:Predict(_Q, myHero, Target)		
					if HitChance >= 2 then 
						CastSpell(_W, Target)                 
						DelayAction(function() CastSpell(_Q, CastPosition.x, CastPosition.y) end, (max(0 , GetDistance(Target) - 500 ) * 0.5 + 25) / 1000)
					end
				end
			end
		end
	end
end

function _Alistar:LaneClear()
	if enemyMinions == nil then return end 
	for i, Minion in pairs(enemyMinions.objects) do
		if (Minion ~= nil) then
			if menu.key.clearKey then 
				if IsReady(_Q) and menu.farm.qlaneclear and (100 * myHero.mana / myHero.maxMana)>= menu.farm.clearmana then
					CastSpell(_Q, Minion)
				end
			end
		end
	end                
end 

function _Alistar:OnDraw()
	if menu == nil then return end 
	if Target == nil then return end
	if menu.draw.drawtarget and ValidTarget(Target) and Target.type == myHero.type then
		_Tech:DrawCircle(Target.x, Target.y, Target.z, 150, ARGB(255, 255, 0, 0))
	end
	if menu.draw.drawqflash and menu.flash.qflash and IsReady(sflash) and IsReady(_Q) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, (self.SpellQ.range + 425), ARGB(table.unpack(menu.draw.colorqflash)))
	end
	if menu.draw.drawwqflash and menu.flash.wqflash and IsReady(sflash) and IsReady(_Q) and IsReady(_W) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, (self.SpellW.range + 425), ARGB(table.unpack(menu.draw.colorwqflash)))
	end
	local Position = VPred:GetPredictedPos(Target, 0.1)
	local flashPos = Position + 100 * (Vector(myHero) - Vector(flashPos)):normalized()
	if IsReady(_W) and IsReady(sflash) and ValidTarget(Target) then	
	   if flashPos ~= nil and menu.draw.drawinsecflash then
			if GetDistance(Target) < 425 and GetDistance(Target) > 50 then
			  _Tech:DrawCircle(flashPos.x, flashPos.y, flashPos.z, 50, ARGB(255, 255, 0, 0))
			  _Tech:DrawCircle(flashPos.x, flashPos.y, flashPos.z, 60, ARGB(255, 255, 255, 255))
			
			  local endPos = Target + 650 * (Vector(myHero) - Vector(Target)):normalized()
			  DrawLine3D(Target.x, Target.y, Target.z, endPos.x, endPos.y, endPos.z, 5, ARGB(255, 255, 255, 255))	     
		   end
		end
	end
	local slot = _Tech:CustomGetInventorySlotItem("HealthBomb", myHero)
	if menu.draw.drawfotm and slot ~= nil and IsReady(slot) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 750, ARGB(table.unpack(menu.draw.colorfotm))) 
	end
	local slot = _Tech:CustomGetInventorySlotItem("IronStylus", myHero)
	if menu.draw.drawlois and slot ~= nil and IsReady(slot) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 750, ARGB(table.unpack(menu.draw.colorlois))) 
	end
	local slot = _Tech:CustomGetInventorySlotItem("ItemMorellosBane", myHero)
	if menu.draw.drawmikaels and slot ~= nil and IsReady(slot) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 750, ARGB(table.unpack(menu.draw.colormikaels))) 
	end
	if menu.draw.drawexhaust and sexhaust ~= nil and IsReady(sexhaust) then 
	   _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 650, ARGB(table.unpack(menu.draw.colorexhaust))) 
	end
	if menu.draw.drawheal and sheal ~= nil and IsReady(sheal) then 
	   _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 850, ARGB(table.unpack(menu.draw.colorheal))) 
	end
	if menu.draw.drawignite and signite ~= nil and IsReady(signite) then 
	   _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 600, ARGB(table.unpack(menu.draw.colorignite))) 
	end
	if menu.draw.drawq and IsReady(_Q) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 365, ARGB(table.unpack(menu.draw.colorq)))
	end
	if menu.draw.draww and IsReady(_W) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, self.SpellW.range, ARGB(table.unpack(menu.draw.colorw)))
	end
	if menu.draw.drawe and IsReady(_E) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, self.SpellE.range, ARGB(table.unpack(menu.draw.colore)))
	end
end
 
function _Alistar:ProcessAttack(object,spell)
	if not myHero.dead and myHero.team ~= object.team then
		if Interrupt[object.charName] ~= nil then
			if Interrupt[object.charName].stop[spell.name] ~= nil then
				if menu.interrupt[spell.name] then
					--if IsReady(_Q) and menu.interrupt.qinterrupt and GetDistance(object.charName) < 365 then 
						--DelayAction(function() CastSpell(_Q) end, menu.humanizer.interruptDelay / 1000)
					if IsReady(_W) and menu.interrupt.winterrupt then
						DelayAction(function() CastSpell(_W, object) end, menu.humanizer.interruptDelay / 1000)
					end
				end
		   end
	   end
	end
end 

function _Alistar:RemoveBuff(unit, buff)
	if unit ~= nil and buff and unit.isMe and buff.name:lower() == "recall" or buff.name:lower() == "summonerteleport" or buff.name:lower() == "recallimproved" then buffs["recall"] = false end
end 

function _Alistar:TowerCC() 
	for i = 1, enemyCount do
	local unit = enemyHeroes[i]	
		for i = 1, towerCount do
			local tower = towers[i]
			if tower and tower.team == myHero.team and (GetDistance(tower, unit) < 775) then
				if menu.snare.qsnare and menu.snare["" ..unit.charName] and (GetDistance(unit) < 365) then
					CastSpell(_Q, unit)
				end
			end
		end
	end
end

Class("_Annie")
function _Annie:__init()
	self:LoadVariables()
	self:Menu()
	
	
	_Bundle:SetupOrbwalk()
	
	_Activator:__init()
	
	_Tech:AddTurrets()
	towerCount = #towers
	
	AddTickCallback(function() self:OnTick() end)
	AddDrawCallback(function() self:OnDraw() end)
	AddRemoveBuffCallback(function(unit, buff) self:RemoveBuff(unit, buff) end)
	AddApplyBuffCallback(function(unit, target, buff) self:ApplyBuff(unit, target, buff) end)
	AddUpdateBuffCallback(function(unit, buff, stacks) self:UpdateBuff(unit, buff, stacks) end)
	AddProcessAttackCallback(function(object, spell) self:ProcessAttack(object, spell) end)
	
	enemyMinions = minionManager(MINION_ENEMY, self.SpellQ.range, myHero, MINION_SORT_HEALTH_DES)
	
	 _Bundle:Print(myHero.charName .. " Loaded, Good Luck!")
end

function _Annie:LoadVariables()
	self.SpellQ = { speed = 1400, delay = 0.5, range = 625, width = nil, collision = false, aoe = false, type = "linear" } 

	self.SpellW = { speed = math.huge, delay = 0.25, range = 625, width = 200, collision = false, aoe = true, type = "linear" } 

	self.SpellE = { speed = 20, delay = 0.25, range = nil, width = nil, collision = false, aoe = true, type = "circular" }

	self.SpellR = { speed = math.huge, delay = 0.25, range = 600, width = 200, collision = false, aoe = true, type = "circular" } 
end

function _Annie:OnTick()
	if menu == nil then return end 
	
	self:Combo()
	self:FlashCombo()
	self:Harass()
	self:LaneClear()
	self:LastHit()
	self:StunManager()
	self:TowerCC()
end

function _Annie:Menu()
	menu = scriptConfig("Support Heroes", "SupportHeroesMenuAnnie")
	
	_Activator:Menu()
		
	menu:addSubMenu("[" .. myHero.charName .. "] - Auto-CC Under Tower", "snare")
		menu.snare:addParam("info", "           -- Auto-CC Enemies --", SCRIPT_PARAM_INFO, "")
		if enemyCount > 0 then
			for i = 1, enemyCount do
			local unit = enemyHeroes[i]			
				menu.snare:addParam("" .. unit.charName, "" .. unit.charName, SCRIPT_PARAM_ONOFF, true)
			end
		end
		menu.snare:addParam("settings", "                    -- Settings --", SCRIPT_PARAM_INFO, "")
		menu.snare:addParam("qsnare", "Use Q If Stun Is Ready", SCRIPT_PARAM_ONOFF, true)
		menu.snare:addParam("wsnare", "Use W If Stun Is Ready", SCRIPT_PARAM_ONOFF, true)
		
	menu:addSubMenu("[" .. myHero.charName .. "] - Auto-Interrupt", "interrupt")   
		menu.interrupt:addParam("spells", "           -- Auto Interrupt Spells --", SCRIPT_PARAM_INFO, "")
		if enemyCount > 0 then
			for i = 1, enemyCount do
				local unit = enemyHeroes[i]
				if Interrupt[unit.charName] ~= nil then
					for i, spell in pairs(Interrupt[unit.charName].stop) do
						menu.interrupt:addParam("" .. unit.charName, "" .. unit.charName, SCRIPT_PARAM_INFO, "") 
						menu.interrupt:addParam(spell.spellName,"" .. spell.name, SCRIPT_PARAM_ONOFF, true)
						menu.interrupt:addParam("empty", "", SCRIPT_PARAM_INFO,"")
					end 
				end
			end
		end
		menu.interrupt:addParam("settings", "                -- Settings --", SCRIPT_PARAM_INFO, "")
		menu.interrupt:addParam("qinterrupt", "Use Q", SCRIPT_PARAM_ONOFF, true)
		menu.interrupt:addParam("winterrupt", "Use W", SCRIPT_PARAM_ONOFF, false)
		
	menu:addSubMenu("[" .. myHero.charName .. "] - Draw Settings", "draw")
		menu.draw:addParam("spelldraws", "                -- Spell Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawq", "Draw Q", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colorq", "Color Q", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("draww", "Draw W", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colorw", "Color W", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawr", "Draw R", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colorr", "Color R", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("miscellaneousdraws", "                -- Flash Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawqflash", "Draw Flash - Q", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorqflash", "Color Flash - Q", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawrflash", "Draw Flash - R", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colorrflash", "Color Flash - R", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawitem", "                -- Item Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawfotm", "Draw Face of the Mountain", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorfotm", "Color Face of the Mountain", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawlois", "Draw Locket of the Iron Solari", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorlois", "Color Locket of the Iron Solari", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawmikaels", "Draw Mikaels Crucible", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorqmikaels", "Color Mikaels Crucible", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 }) 
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawsumm", "                -- Summoner Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawexhaust", "Draw Exhaust", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorexhaust", "Color Exhaust", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawheal", "Draw Heal", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorheal", "Color Heal", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawignite", "Draw Ignite", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorignite", "Color Ignite", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })  
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("miscellaneousdraws", "            -- Miscellaneous Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawtarget", "Draw Target", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("drawpermashow", "Draw Permashow (Reload)", SCRIPT_PARAM_ONOFF, true)
			
	menu:addSubMenu("[" .. myHero.charName .. "] - Farm Settings", "farm")
		menu.farm:addParam("laneclear", "                    -- Lane Clear --", SCRIPT_PARAM_INFO, "")
		menu.farm:addParam("qlaneclear", "Use Q", SCRIPT_PARAM_ONOFF, true)
		menu.farm:addParam("qclearmana", "Minimum Mana", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		menu.farm:addParam("wlaneclear", "Use W", SCRIPT_PARAM_ONOFF, true)
		menu.farm:addParam("wclearmana", "Minimum Mana", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		menu.farm:addParam("lasthit", "                    -- Last Hit --", SCRIPT_PARAM_INFO, "")
		menu.farm:addParam("qlasthit", "Use Q", SCRIPT_PARAM_ONOFF, true)
		menu.farm:addParam("qlasthitmana", "Minimum Mana", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		
	menu:addSubMenu("[" .. myHero.charName .. "] - Flash Settings", "flash")
		menu.flash:addParam("qflash", "Use Flash - Q W/ Stun", SCRIPT_PARAM_ONOFF, false)
		menu.flash:addParam("rflash", "Use Flash - R W/ Stun", SCRIPT_PARAM_ONOFF, true)
	
	menu:addSubMenu("[" .. myHero.charName .. "] - Humanizer", "humanizer")
		menu.humanizer:addParam("interruptDelay", "Auto-Interrupt Delay (ms)", SCRIPT_PARAM_SLICE, 200, 0, 500, 0)
		menu.humanizer:addParam("snareDelay", "Auto-CC Delay (ms)", SCRIPT_PARAM_SLICE, 0, 0, 500, 0)
		menu.humanizer:addParam("shieldDelay", "Auto Shield Delay (ms)", SCRIPT_PARAM_SLICE, 50, 0, 500, 0)
			
	menu:addSubMenu("[" .. myHero.charName .. "] - Key Settings", "key")
		menu.key:addParam("combatkeys", "               -- Combat Keys --", SCRIPT_PARAM_INFO, "")
		menu.key:addParam("comboKey", "Combo Key", SCRIPT_PARAM_ONKEYDOWN, false, 32)
		menu.key:addParam("harassKey", "Harass Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
		menu.key:addParam("harassToggle", "Harass Toggle", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("T"))
		menu.key:addParam("clearKey", "Lane Clear Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
		menu.key:addParam("lasthitKey", "Last Hit Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("X"))
		menu.key:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.key:addParam("miscellaneouskeys", "           -- Miscellaneous Keys --", SCRIPT_PARAM_INFO, "")
		menu.key:addParam("flashKey", "Flash Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("H"))
	
	menu:addSubMenu("[" .. myHero.charName .. "] - Spell Settings", "spell")
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - Q", "q")
		menu.spell.q:addParam("qcombo", "Combo", SCRIPT_PARAM_ONOFF, true)
		menu.spell.q:addParam("qcombomana", "[Combo] Mana > X%", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
		menu.spell.q:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.q:addParam("qharass", "Harass", SCRIPT_PARAM_ONOFF, true)
		menu.spell.q:addParam("qharassmana", "[Harass] Mana > X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - W", "w")
		menu.spell.w:addParam("wcombo", "Combo", SCRIPT_PARAM_ONOFF, true)
		menu.spell.w:addParam("wcombomana", "[Combo] Mana > X%", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
		menu.spell.w:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.w:addParam("wharass", "Harass", SCRIPT_PARAM_ONOFF, true)
		menu.spell.w:addParam("wharassmana", "[Harass] Mana > X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		menu.spell.w:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.w:addParam("wfountaincharge", "Charge Stun In Fountain", SCRIPT_PARAM_ONOFF, true)
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - E", "e")
		menu.spell.e:addParam("eshield", "Use E " , SCRIPT_PARAM_ONOFF, true)
		menu.spell.e:addParam("eshieldhp", "Shield If <X% HP", SCRIPT_PARAM_SLICE, 75, 0, 100, 0)
		menu.spell.e:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.e:addParam("efountaincharge", "Charge Stun In Fountain", SCRIPT_PARAM_ONOFF, true)
		menu.spell.e:addParam("echarge", "Charge Stun Not In Fountain",SCRIPT_PARAM_ONOFF, true)
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - R", "r")
		menu.spell.r:addParam("ult", "Use Ultimate", SCRIPT_PARAM_ONOFF, true)
		menu.spell.r:addParam("ultifstun", "Use Ultimate Only If Stun Is Ready", SCRIPT_PARAM_ONOFF, true)
		
   menu:addSubMenu("[" .. myHero.charName .. "] - Target Selector", "target")
		menu.target:addParam("targetinfo", "Default Target Select Is LeastCast", SCRIPT_PARAM_INFO, "")
		menu.target:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.target:addParam("focus", "Focus Selected Target", SCRIPT_PARAM_ONOFF, true)
		menu.target:addParam("sac", "Use SAC:R Target Instead", SCRIPT_PARAM_ONOFF, false)
		
   menu:addSubMenu("Orbwalk Settings", "orb")  
   
   UPL:AddToMenu(menu)
 
   menu:addParam("empty", "", SCRIPT_PARAM_INFO, "")
   menu:addParam("infobox", "            Support Heroes: " .. myHero.charName .. "           ", SCRIPT_PARAM_INFO, "")
   menu:addParam("infobox2", "                      Version:  " .. scriptVersion .. "         ", SCRIPT_PARAM_INFO, "")
   
   if menu.draw.drawpermashow then
	 menu:permaShow("infobox")
	 menu.key:permaShow("comboKey")
	 menu.key:permaShow("harassKey")
	 menu.key:permaShow("harassToggle")
	 menu.key:permaShow("clearKey")
	 menu.key:permaShow("lasthitKey")
   end
end

function _Annie:ApplyBuff(unit, target, buff)
	if unit and unit.isMe and buff then
		if buff.name == "pyromania_particle" then buffs["canStun"] = true end
		if unit ~= nil and buff and unit.isMe and buff.name:lower() == "recall" or buff.name:lower() == "summonerteleport" or buff.name:lower() == "recallimproved" then buffs["recall"] = true end
	end
end

function _Annie:Combo()
	if Target == nil then return end
	if menu.key.comboKey then 
		if IsReady(_Q) and menu.spell.q.qcombo and (100 * myHero.mana / myHero.maxMana)>= menu.spell.q.qcombomana and (GetDistance(Target) < self.SpellQ.range) then
			if ValidTarget(Target) then
			   CastSpell(_Q, Target)
			end
		end
		if IsReady(_W) and menu.spell.w.wcombo and (100 * myHero.mana / myHero.maxMana)>= menu.spell.w.wcombomana and (GetDistance(Target) < self.SpellW.range) then
			if ValidTarget(Target) then
				 CastSpell(_W, Target)
			end
		end
		if IsReady(_R) and menu.spell.r.ult and not menu.spell.r.ultifstun and (GetDistance(Target) < self.SpellR.range) then
		   if ValidTarget(Target) then
			   CastSpell(_R, Target)
		   end            
		elseif IsReady(_R) and menu.spell.r.ult and menu.spell.r.ultifstun and buffs["canStun"] and (GetDistance(Target) < self.SpellR.range) then
			if ValidTarget(Target) then
				CastSpell(_R, Target)
			end
		end    
	end
end

function _Annie:FlashCombo()
	if Target == nil then return end
	if menu.key.flashKey and menu.flash.qflash and buffs["canStun"] then 
		if ValidTarget(Target) and (GetDistance(Target) <= self.SpellQ.range + 425) then
		   if IsReady(sflash) and IsReady(_Q) then
			   CastSpell(sflash, Target.x, Target.z)      
			   CastSpell(_Q, Target)
		   end	       
		end
	end
	if menu.key.flashKey and menu.flash.rflash and buffs["canStun"] then
		if ValidTarget(Target) and (GetDistance(Target) <= self.SpellR.range + 425) then
			if IsReady(sflash) and IsReady(_R) then 
				CastSpell(sflash, Target.x, Target.z)
				CastSpell(_R, Target)        
			end
		end
	end
	if menu.key.flashKey and IsReady(sflash) then
		myHero:MoveTo(mousePos.x, mousePos.z)
	end
end

function _Annie:Harass()
	if Target == nil then return end
	if menu.key.harassKey or menu.key.harassToggle then 
		if IsReady(_Q) and menu.spell.q.qharass and (100 * myHero.mana / myHero.maxMana)>= menu.spell.q.qharassmana and (GetDistance(Target) < self.SpellQ.range) then
			if ValidTarget(Target) then
				CastSpell(_Q, Target)
			end
		end
		if IsReady(_W) and menu.spell.w.wharass and (100 * myHero.mana / myHero.maxMana)>= menu.spell.w.wharassmana and (GetDistance(Target) < self.SpellW.range) then
			if ValidTarget(Target) then
				CastSpell(_W, Target)
			end
		end
	end
end

function _Annie:Interrupt()
	if not myHero.dead and myHero.team ~= unit.team then
	   if Interrupt[unit.charName] ~= nil then
		   if Interrupt[unit.charName].stop[unit.spellName] ~= nil then
				if menu.interrupt[spell.name] then
					if IsReady(_Q) and menu.interrupt.qinterrupt and (GetDistance(unit) < self.SpellQ.range) and buffs["canStun"] then 
						DelayAction(function() CastSpell(_Q, unit) end, menu.humanizer.interruptDelay / 1000)
					elseif IsReady(_W) and menu.interrupt.winterrupt and (GetDistance(unit) < self.SpellW.range) and buffs["canStun"] then 
						DelayAction(function() CastSpell(_W, unit) end, menu.humanizer.interruptDelay / 1000)
					end
				end
		   end
	   end
	end
end  
 
function _Annie:LaneClear()
	local qdmg = 35 * myHero:GetSpellData(_Q).level + 45 + .8 * myHero.ap
	local wdmg = 45 * myHero:GetSpellData(_W).level + 25 + .85 * myHero.ap
	if enemyMinions == nil then return end
	for i, Minion in pairs(enemyMinions.objects) do
		if (Minion ~= nil) then 
			if menu.key.clearKey then 
				if IsReady(_Q) and menu.farm.qlaneclear and Minion.health <= qdmg and (100 * myHero.mana / myHero.maxMana)>= menu.farm.qclearmana then
					CastSpell(_Q, Minion)
				end   
				if IsReady(_W) and menu.farm.wlaneclear and Minion.health <= wdmg and (100 * myHero.mana / myHero.maxMana)>= menu.farm.wclearmana then
					CastSpell(_W, Minion)
				end
			end   
		end
	end                
end

function _Annie:LastHit()
	local qdmg = 35 * myHero:GetSpellData(_Q).level + 45 + .8 * myHero.ap
	if enemyMinions == nil then return end
	for i, Minion in pairs(enemyMinions.objects) do
		if (Minion ~= nil) then
			if menu.key.lasthitKey and Minion.health < qdmg then
				if IsReady(_Q) and menu.farm.qlasthit and (100 * myHero.mana / myHero.maxMana)>= menu.farm.qlasthitmana then
					CastSpell(_Q, Minion)
				end
			end    
		end       
	end              
end                      

function _Annie:OnDraw()
	if menu == nil then return end
	if Target == nil then return end
	if menu.draw.drawtarget and ValidTarget(Target) and Target.type == myHero.type then
		_Tech:DrawCircle(Target.x, Target.y, Target.z, 150, ARGB(255, 255, 0, 0))
	end
	if menu.draw.drawqflash and menu.flash.qflash and IsReady(sflash) and IsReady(_Q) and buffs["canStun"] then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, (self.SpellQ.range + 425), ARGB(table.unpack(menu.draw.colorqflash)))
	end
	if menu.draw.drawrflash and menu.flash.rflash and IsReady(sflash) and IsReady(_R) and buffs["canStun"] then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, (self.SpellR.range + 425), ARGB(table.unpack(menu.draw.colorrflash)))
	end
	local slot = _Tech:CustomGetInventorySlotItem("HealthBomb", myHero)
	if menu.draw.drawfotm and slot ~= nil and IsReady(slot) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 750, ARGB(table.unpack(menu.draw.colorfotm))) 
	end
	local slot = _Tech:CustomGetInventorySlotItem("IronStylus", myHero)
	if menu.draw.drawlois and slot ~= nil and IsReady(slot) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 750, ARGB(table.unpack(menu.draw.colorlois))) 
	end
	local slot = _Tech:CustomGetInventorySlotItem("ItemMorellosBane", myHero)
	if menu.draw.drawmikaels and slot ~= nil and IsReady(slot) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 750, ARGB(table.unpack(menu.draw.colormikaels))) 
	end
	if menu.draw.drawexhaust and sexhaust ~= nil and IsReady(sexhaust) then 
	   _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 650, ARGB(table.unpack(menu.draw.colorexhaust))) 
	end
	if menu.draw.drawheal and sheal ~= nil and IsReady(sheal) then 
	   _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 850, ARGB(table.unpack(menu.draw.colorheal))) 
	end
	if menu.draw.drawignite and signite ~= nil and IsReady(signite) then 
	   _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 600, ARGB(table.unpack(menu.draw.colorignite))) 
	end
	if menu.draw.drawq and IsReady(_Q) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, self.SpellQ.range, ARGB(table.unpack(menu.draw.colorq)))
	end
	if menu.draw.draww and IsReady(_W) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, self.SpellW.range, ARGB(table.unpack(menu.draw.colorw)))
	end
	if menu.draw.drawr and IsReady(_R) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, self.SpellR.range, ARGB(table.unpack(menu.draw.colorr)))
	end
end

function _Annie:ProcessAttack(object, spell)
	if IsReady(_E) and spell.target then
		if object.team == TEAM_ENEMY and object.type == myHero.type and spell.name:lower():find("attack") then
		   if spell.target == myHero and menu.spell.e.eshield and (100*spell.target.health/spell.target.maxHealth) <= menu.spell.e.eshieldhp then
			 DelayAction(function() CastSpell(_E) end, menu.humanizer.shieldDelay / 1000)
		   end
		end
	end
end

function _Annie:RemoveBuff(unit, buff)
	if unit and unit.isMe and buff then
		if buff.name == "pyromania_particle" then buffs["canStun"] = false end
		if unit ~= nil and buff and unit.isMe and buff.name:lower() == "recall" or buff.name:lower() == "summonerteleport" or buff.name:lower() == "recallimproved" then buffs["recall"] = true end
	end
end

function _Annie:StunManager()
	if not InFountain() and not buffs["recall"] and menu.spell.e.echarge and not buffs["canStun"] and IsReady(_E) then
		CastSpell(_E, myHero.x, myHero.z)
	end
	if InFountain() and not buffs["recall"] and menu.spell.w.wfountaincharge and not buffs["canStun"] and IsReady(_W) then
		CastSpell(_W, myHero.x, myHero.z)
	end
	 if InFountain() and not buffs["recall"] and menu.spell.e.efountaincharge and not buffs["canStun"] and IsReady(_E) then
		CastSpell(_E, myHero.x, myHero.z)
	end
end

function _Annie:TowerCC()
	for i = 1, enemyCount do
	local unit = enemyHeroes[i]	
		for i = 1, towerCount do
			local tower = towers[i]
			if tower and tower.team == myHero.team and (GetDistance(tower) < 775) and buffs["canStun"] then
				if menu.snare.qsnare and menu.snare["" ..unit.charName] and (GetDistance(unit) < self.SpellQ.range) then
					CastSpell(_Q, unit)
				elseif menu.snare.wsnare and menu.snare["" ..unit.charName] and (GetDistance(unit) < self.SpellW.range) then
					CastSpell(_W, unit)
				end
			end
		end
	end
end

function _Annie:UpdateBuff(unit, buff, stacks)
	if unit and unit.isMe and buff then
		if (buff.name == "pyromania") then buffs["passive"] = stacks end
	end 
end

Class("_Blitzcrank")
function _Blitzcrank:__init()
	self:LoadVariables()
	self:Menu()
	
	_Bundle:SetupOrbwalk()
	
	_Activator:__init()
	
	_Tech:AddTurrets()
	towerCount = #towers
	
	AddTickCallback(function() self:OnTick() end)
	AddDrawCallback(function() self:OnDraw() end)
	AddRemoveBuffCallback(function(unit, buff) self:RemoveBuff(unit, buff) end)
	AddApplyBuffCallback(function(unit, target, buff) self:ApplyBuff(unit, target, buff) end)
	
	enemyMinions = minionManager(MINION_ENEMY, 625, myHero, MINION_SORT_HEALTH_DES)
	
	_Bundle:Print(myHero.charName .. " Loaded, Good Luck!")
end

function _Blitzcrank:LoadVariables()
	self.SpellQ = { speed = 1800, delay = 0.25, range = 975, width = 70, collision = true, aoe = false, type = "linear"}

	self.SpellW = { speed = nil, delay = 0.25, range = nil, width = nil, collision = false, aoe = false, type = "linear" } 

	self.SpellE = { speed = nil, delay = 0.25, range = 300, width = nil, collision = false, aoe = false, type = "circular" }

	self.SpellR = { speed = nil, delay = 0.25, range = 600, width = 200, collision = false, aoe = true, type = "circular" } 
	
	UPL:AddSpell(_Q, self.SpellQ)
end

function _Blitzcrank:OnTick()
	self:Combo()
	self:FlashCombo()
	self:Harass()
	self:Interrupt()
	self:LaneClear()
	self:Marathon()
	self:TowerCC()
end

function _Blitzcrank:Menu()
	menu = scriptConfig("Support Heroes", "SupportHeroesMenuBlitzcrank")
	
	_Activator:Menu()
	
	menu:addSubMenu("[" .. myHero.charName .. "] - Auto-CC Under Tower", "snare")
		menu.snare:addParam("info", "           -- Auto-CC Enemies --", SCRIPT_PARAM_INFO, "")
		if enemyCount > 0 then
			for i = 1, enemyCount do
			local unit = enemyHeroes[i]			
				menu.snare:addParam("" .. unit.charName, "" .. unit.charName, SCRIPT_PARAM_ONOFF, true)
			end
		end
		menu.snare:addParam("settings", "                    -- Settings --", SCRIPT_PARAM_INFO, "")
		menu.snare:addParam("esnare", "Use E", SCRIPT_PARAM_ONOFF, true)
		
	menu:addSubMenu("[" .. myHero.charName .. "] - Auto-Interrupt", "interrupt")   
		menu.interrupt:addParam("spells", "           -- Auto Interrupt Spells --", SCRIPT_PARAM_INFO, "")
		if enemyCount > 0 then
			for i = 1, enemyCount do
				local unit = enemyHeroes[i]
				if Interrupt[unit.charName] ~= nil then
					for i, spell in pairs(Interrupt[unit.charName].stop) do
						menu.interrupt:addParam("" .. unit.charName, "" .. unit.charName, SCRIPT_PARAM_INFO, "") 
						menu.interrupt:addParam(spell.spellName,"" .. spell.name, SCRIPT_PARAM_ONOFF, true)
						menu.interrupt:addParam("empty", "", SCRIPT_PARAM_INFO,"")
					end 
				end
			end
		end
		menu.interrupt:addParam("settings", "                -- Settings --", SCRIPT_PARAM_INFO, "")
		menu.interrupt:addParam("qinterrupt", "Use Q", SCRIPT_PARAM_ONOFF, true)
		menu.interrupt:addParam("einterrupt", "Use E", SCRIPT_PARAM_ONOFF, true)
		menu.interrupt:addParam("rinterrupt", "Use R", SCRIPT_PARAM_ONOFF, true)
		
	menu:addSubMenu("[" .. myHero.charName .. "] - Draw Settings", "draw")
		menu.draw:addParam("spelldraws", "                -- Spell Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawq", "Draw Q", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colorq", "Color Q", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawe", "Draw E", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colore", "Color E", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawr", "Draw R", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colorr", "Color R", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("miscellaneousdraws", "                -- Flash Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawqflash", "Draw Flash - Q", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorqflash", "Color Flash - Q", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawitem", "                -- Item Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawfotm", "Draw Face of the Mountain", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorfotm", "Color Face of the Mountain", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawlois", "Draw Locket of the Iron Solari", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorlois", "Color Locket of the Iron Solari", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawmikaels", "Draw Mikaels Crucible", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorqmikaels", "Color Mikaels Crucible", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 }) 
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawsumm", "                -- Summoner Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawexhaust", "Draw Exhaust", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorexhaust", "Color Exhaust", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawheal", "Draw Heal", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorheal", "Color Heal", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawignite", "Draw Ignite", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorignite", "Color Ignite", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })  
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("miscellaneousdraws", "            -- Miscellaneous Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawtarget", "Draw Target", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("drawpermashow", "Draw Permashow (Reload)", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("drawcollision", "Draw Collision", SCRIPT_PARAM_ONOFF, true)
			
	menu:addSubMenu("[" .. myHero.charName .. "] - Farm Settings", "farm")
		menu.farm:addParam("laneclear", "                    -- Lane Clear --", SCRIPT_PARAM_INFO, "")
		menu.farm:addParam("rlaneclear", "Use R", SCRIPT_PARAM_ONOFF, true)
		menu.farm:addParam("rclearmana", "Minimum Mana", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		
	menu:addSubMenu("[" .. myHero.charName .. "] - Flash Settings", "flash")
		menu.flash:addParam("qflash", "Use Flash - Q", SCRIPT_PARAM_ONOFF, true)
	
	menu:addSubMenu("[" .. myHero.charName .. "] - Humanizer", "humanizer")
		menu.humanizer:addParam("interruptDelay", "Auto-Interrupt Delay (ms)", SCRIPT_PARAM_SLICE, 200, 0, 500, 0)
		menu.humanizer:addParam("snareDelay", "Auto-CC Delay (ms)", SCRIPT_PARAM_SLICE, 0, 0, 500, 0)
		menu.humanizer:addParam("shieldDelay", "Auto Shield Delay (ms)", SCRIPT_PARAM_SLICE, 50, 0, 500, 0)
			
	menu:addSubMenu("[" .. myHero.charName .. "] - Key Settings", "key")
		menu.key:addParam("combatkeys", "               -- Combat Keys --", SCRIPT_PARAM_INFO, "")
		menu.key:addParam("comboKey", "Combo Key", SCRIPT_PARAM_ONKEYDOWN, false, 32)
		menu.key:addParam("harassKey", "Harass Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
		menu.key:addParam("harassToggle", "Harass Toggle", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("T"))
		menu.key:addParam("clearKey", "Lane Clear Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
		menu.key:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.key:addParam("miscellaneouskeys", "           -- Miscellaneous Keys --", SCRIPT_PARAM_INFO, "")
		menu.key:addParam("flashKey", "Flash Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("H"))
		menu.key:addParam("marathonKey", "Marathon Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("Y"))
	
	menu:addSubMenu("[" .. myHero.charName .. "] - Spell Settings", "spell")
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - Q", "q")
		menu.spell.q:addParam("qcombo", "Combo", SCRIPT_PARAM_ONOFF, true)
		menu.spell.q:addParam("qcombomana", "[Combo] Mana > X%", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
		menu.spell.q:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.q:addParam("qharass", "Harass", SCRIPT_PARAM_ONOFF, true)
		menu.spell.q:addParam("qharassmana", "[Harass] Mana > X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
        menu.spell.q:addParam("empty", "", SCRIPT_PARAM_INFO, "")
        menu.spell.q:addParam("blacklistinfo", "                -- Black List --", SCRIPT_PARAM_INFO,"")
        for i = 1, heroManager.iCount do
            local unit = heroManager:GetHero(i)
            if unit.team ~= myHero.team then 
                menu.spell.q:addParam("blacklist"..unit.charName, "Do Not Grab "..unit.charName, SCRIPT_PARAM_ONOFF, false)
            end
        end
        menu.spell.q:addParam("empty", "", SCRIPT_PARAM_INFO, "")
        menu.spell.q:addParam("blacklisthp", "Unless <X% HP", SCRIPT_PARAM_SLICE, 10, 0, 100, 0)
        
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - E", "e")
		menu.spell.e:addParam("ecombo", "Combo", SCRIPT_PARAM_ONOFF, true)
		menu.spell.e:addParam("ecombomana", "[Combo] Mana > X%", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
		menu.spell.e:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.e:addParam("eharass", "Harass", SCRIPT_PARAM_ONOFF, true)
		menu.spell.e:addParam("eharassmana", "[Harass] Mana > X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		
        menu.spell:addSubMenu("[" .. myHero.charName .. "] - R", "r")
		menu.spell.r:addParam("rcombo", "Combo", SCRIPT_PARAM_ONOFF, true)
		menu.spell.r:addParam("rcombomana", "[Combo] Mana > X%", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
		menu.spell.r:addParam("rmpty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.r:addParam("rharass", "Harass", SCRIPT_PARAM_ONOFF, true)
		menu.spell.r:addParam("rharassmana", "[Harass] Mana > X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		
   menu:addSubMenu("[" .. myHero.charName .. "] - Target Selector", "target")
		menu.target:addParam("targetinfo", "Default Target Select Is LeastCast", SCRIPT_PARAM_INFO, "")
		menu.target:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.target:addParam("focus", "Focus Selected Target", SCRIPT_PARAM_ONOFF, true)
		menu.target:addParam("sac", "Use SAC:R Target Instead", SCRIPT_PARAM_ONOFF, false)
		
   menu:addSubMenu("Orbwalk Settings", "orb")  
   
   UPL:AddToMenu(menu)
   
   menu:addParam("hc", "Prediction Hit Chance", SCRIPT_PARAM_SLICE, 2, 0, 5, 0)
 
   menu:addParam("empty", "", SCRIPT_PARAM_INFO, "")
   menu:addParam("infobox", "            Support Heroes: " .. myHero.charName .. "           ", SCRIPT_PARAM_INFO, "")
   menu:addParam("infobox2", "                      Version:  " .. scriptVersion .. "         ", SCRIPT_PARAM_INFO, "")
   
   if menu.draw.drawpermashow then
	 menu:permaShow("infobox")
	 menu.key:permaShow("comboKey")
	 menu.key:permaShow("harassKey")
	 menu.key:permaShow("harassToggle")
	 menu.key:permaShow("clearKey")
	 menu.key:permaShow("marathonKey")
   end
end

function _Blitzcrank:ApplyBuff(unit, Target, buff)
	if Target == nil then return end
	if unit and unit.isMe and buff then 
	   if buff.name == "PowerFist" then 
			buffs["PowerFist"] = true
			buffs["rocketgrab2"] = false
		end 
	end
	if Target.type == myHero.type then
	   if Target.team ~= myHero.team then
		   if buff.name == "rocketgrab2" then buffs["rocketgrab2"] = true end
	   end  
	end
end       

function _Blitzcrank:Combo()
    if Target == nil then return end
    if menu.key.comboKey then 
        if IsReady(_Q) and menu.spell.q.qcombo and (100 * myHero.mana / myHero.maxMana)>= menu.spell.q.qcombomana and GetDistance(Target) < self.SpellQ.range then
            if not menu.spell.q["blacklist"..unit.charName] and ValidTarget(Target) then
                local CastPosition, HitChance, HeroPosition = UPL:Predict(_Q, myHero, Target)
                if HitChance >= menu.hc then 
                    CastSpell(_Q, CastPosition.x, CastPosition.z)
                end
            end
            if menu.spell.q["blacklist"..unit.charName] and (100*unit.health/unit.maxHealth) <= menu.spell.q.blacklisthp then 
            local CastPosition, HitChance, HeroPosition = UPL:Predict(_Q, myHero, Target)
                if HitChance >= menu.hc then 
                    CastSpell(_Q, CastPosition.x, CastPosition.z)
                end
            end
        end
        if IsReady(_E) and menu.spell.e.ecombo and (100 * myHero.mana / myHero.maxMana)>= menu.spell.e.ecombomana and GetDistance(Target) <= self.SpellE.range and not buffs["rocketgrab2"] then 
            CastSpell(_E, Target) 
            Attack(Target)
        elseif IsReady(_E) and menu.spell.e.ecombo and (100 * myHero.mana / myHero.maxMana)>= menu.spell.e.ecombomana and GetDistance(Target) <= self.SpellE.range and buffs["rocketgrab2"] then 
            CastSpell(_E, Target)
            Attack(Target)     
        end
        if IsReady(_R) and menu.spell.r.rcombo and (100 * myHero.mana / myHero.maxMana)>= menu.spell.r.rcombomana and  GetDistance(Target) <= self.SpellR.range then
            CastSpell(_R)    
        end
    end  
end

function _Blitzcrank:FlashCombo()
	if Target == nil then return end
	if IsReady(sflash) and IsReady(_Q) and GetDistance(Target) <= 425 + self.SpellQ.range then
		if GetDistance(Target) < 425 then
			flashPos = myHero + (GetDistance(Target) - 50) * (Vector(Target) - Vector(myHero)):normalized()
		else
			flashPos = myHero + 425 * (Vector(Target) - Vector(myHero)):normalized()
		end
		if menu.key.flashKey then
			local CastPosition, HitChance = UPL:Predict(_Q, flashPos, Target)		
			if HitChance >= 2 and type(CastPosition.x) == "number" and type(CastPosition.z) == "number" then
				flashPos = myHero + 425 * (Vector(CastPosition) - Vector(myHero)):normalized()
				CastSpell(sflash, flashPos.x, flashPos.z)
				_Tech:FlashComboPosition(_Q, CastPosition.x, CastPosition.z)
			end
		end
	end
	if menu.key.flashKey and IsReady(sflash) and IsReady(_Q) then
		myHero:MoveTo(mousePos.x, mousePos.z)
	end
end

function _Blitzcrank:Harass()
	if Target == nil then return end
	if menu.key.harassKey or menu.key.harassToggle then 
		if IsReady(_Q) and menu.spell.q.qharass and (100 * myHero.mana / myHero.maxMana)>= menu.spell.q.qharassmana and (GetDistance(Target) < 975) then
			if not menu.spell.q["blacklist"..unit.charName] and ValidTarget(Target) then  
				local CastPosition, HitChance, HeroPosition = UPL:Predict(_Q, myHero, Target)
				if HitChance >= menu.hc then 
					CastSpell(_Q, CastPosition.x, CastPosition.z)
				end
            end
            if menu.spell.q["blacklist"..unit.charName] and (100*unit.health/unit.maxHealth) <= menu.spell.q.blacklisthp then 
            local CastPosition, HitChance, HeroPosition = UPL:Predict(_Q, myHero, Target)
                if HitChance >= menu.hc then 
                    CastSpell(_Q, CastPosition.x, CastPosition.z)
                end
            end
		end
		if IsReady(_E) and menu.spell.e.eharass and (100 * myHero.mana / myHero.maxMana)>= menu.spell.e.eharassmana and GetDistance(Target) <= self.SpellE.range and not buffs["rocketgrab2"] then 
			CastSpell(_E, Target)
			Attack(Target)
		elseif IsReady(_E) and menu.spell.e.eharass and (100 * myHero.mana / myHero.maxMana)>= menu.spell.e.eharassmana and GetDistance(Target) <= self.SpellE.range and buffs["rocketgrab2"] then 
			CastSpell(_E, Target)
			Attack(Target)     
		end
		if IsReady(_R) and menu.spell.r.rharass and (100 * myHero.mana / myHero.maxMana)>= menu.spell.r.rharassmana and  GetDistance(Target) <= self.SpellR.range then
			CastSpell(_R)    
		end
	end 
end

function _Blitzcrank:Interrupt()
	if not myHero.dead and myHero.team ~= unit.team then
	   if Interrupt[unit.charName] ~= nil then
		   if Interrupt[unit.charName].stop[unit.spellName] ~= nil then
				if menu.interrupt[spell.name] then
					if IsReady(_Q) and menu.interrupt.qinterrupt and (GetDistance(unit) < self.SpellQ.range) then 
						local CastPosition, HitChance, HeroPosition = UPL:Predict(_Q, myHero, Target)
						if HitChance >= menu.hc then 
						DelayAction(function() CastSpell(_Q, CastPosition.x, CastPosition.z) end, menu.humanizer.interruptDelay / 1000)
					elseif IsReady(_E) and menu.interrupt.einterrupt and (GetDistance(unit) < self.SpellE.range) then 
						DelayAction(function() CastSpell(_E, unit) end, menu.humanizer.interruptDelay / 1000)
						Attack(Target)
					elseif IsReady(_R) and menu.interrupt.rinterrupt and (GetDistance(unit) < self.SpellR.range) then 
						DelayAction(function() CastSpell(_R, unit) end, menu.humanizer.interruptDelay / 1000)
						end
					end
				end
		   end
	   end
	end
end

function _Blitzcrank:LaneClear()
	if enemyMinions == nil then return end
	for i, Minion in pairs(enemyMinions.objects) do
		if (Minion ~= nil) then
			if menu.key.clearKey then
				if IsReady(_R) and menu.farm.rlaneclear and (100 * myHero.mana / myHero.maxMana)>= menu.farm.rclearmana then
					CastSpell(_R)
				end
			end    
		end       
	end              
end

function _Blitzcrank:Marathon()
	if menu.key.marathonKey then 
		if IsReady(_W) then 
			CastSpell(_W)
		end
	end
end 

function _Blitzcrank:OnDraw()
	if menu == nil then return end
	if Target == nil then return end
	if menu.draw.drawtarget and ValidTarget(Target) and Target.type == myHero.type then
		_Tech:DrawCircle(Target.x, Target.y, Target.z, 150, ARGB(255, 255, 0, 0))
	end
	if ValidTarget(Target) and menu.draw.drawcollision and IsReady(_Q) and (GetDistance(Target) <= 975) then
	   local IsCollision = VPred:CheckMinionCollision(Target, Target.pos, self.SpellQ.delay, self.SpellQ.width, self.SpellQ.range, self.SpellQ.speed, myHero.pos, nil, true)
			DrawLine3D(myHero.x, myHero.y, myHero.z, Target.x, Target.y, Target.z, 5, IsCollision and ARGB(125, 255, 0,0) or ARGB(125, 0, 255,0))
	end  
	if menu.draw.drawqflash and menu.flash.qflash and IsReady(sflash) and IsReady(_Q) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, (975 + 425), ARGB(table.unpack(menu.draw.colorqflash)))
	end
	local slot = _Tech:CustomGetInventorySlotItem("HealthBomb", myHero)
	if menu.draw.drawfotm and slot ~= nil and IsReady(slot) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 750, ARGB(table.unpack(menu.draw.colorfotm))) 
	end
	local slot = _Tech:CustomGetInventorySlotItem("IronStylus", myHero)
	if menu.draw.drawlois and slot ~= nil and IsReady(slot) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 750, ARGB(table.unpack(menu.draw.colorlois))) 
	end
	local slot = _Tech:CustomGetInventorySlotItem("ItemMorellosBane", myHero)
	if menu.draw.drawmikaels and slot ~= nil and IsReady(slot) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 750, ARGB(table.unpack(menu.draw.colormikaels))) 
	end
	if menu.draw.drawexhaust and sexhaust ~= nil and IsReady(sexhaust) then 
	   _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 650, ARGB(table.unpack(menu.draw.colorexhaust))) 
	end
	if menu.draw.drawheal and sheal ~= nil and IsReady(sheal) then 
	   _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 850, ARGB(table.unpack(menu.draw.colorheal))) 
	end
	if menu.draw.drawignite and signite ~= nil and IsReady(signite) then 
	   _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 600, ARGB(table.unpack(menu.draw.colorignite))) 
	end
	if menu.draw.drawq and IsReady(_Q) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 975, ARGB(table.unpack(menu.draw.colorq)))
	end
	if menu.draw.draww and IsReady(_E) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, self.SpellE.range, ARGB(table.unpack(menu.draw.colore)))
	end
	if menu.draw.drawr and IsReady(_R) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, self.SpellR.range, ARGB(table.unpack(menu.draw.colorr)))
	end
end

function _Blitzcrank:RemoveBuff(unit, buff)
	if unit and unit.isMe and buff then
		if buff.name == "PowerFist" then buffs["PowerFist"] = false end 
	end
end

function _Blitzcrank:TowerCC()
	for i = 1, enemyCount do
	local unit = enemyHeroes[i]	
		for i = 1, towerCount do
			local tower = towers[i]
			if tower and tower.team == myHero.team and (GetDistance(tower, unit) < 775) then
				if menu.snare.esnare and menu.snare["" ..unit.charName] and GetDistance(unit) <= self.SpellE.range then
					CastSpell(_E, unit)
				end
			end
		end
	end
end

Class("_Janna")
function _Janna:__init()
	self:LoadVariables()
	self:Menu()
	
	
	_Bundle:SetupOrbwalk()
	
	_Activator:__init()
	
	_Tech:AddTurrets()
	towerCount = #towers
	
	AddTickCallback(function() self:OnTick() end)
	AddDrawCallback(function() self:OnDraw() end)
	AddProcessAttackCallback(function(object, spell) self:ProcessAttack(object, spell) end)
	
	enemyMinions = minionManager(MINION_ENEMY, self.SpellW.range, myHero, MINION_SORT_HEALTH_DES)
	
	_Bundle:Print(myHero.charName .. " Loaded, have fun!")
end

function _Janna:LoadVariables()
	self.SpellQ = { speed = 900, delay = 0.3, range = 850, width = 120, collision = false, aoe = true, type = "linear" }
	self.SpellW = { speed = 1000, delay = 0.55, range = 600, width = 50, collision = true, aoe = false, type = "linear" }
	self.SpellE = { speed = 1975, delay = 0.25, range = 800, width = 50, collision = true, aoe = false, type = "linear" }
	self.SpellR = { speed = 1975, delay = 0.25, range = 725, width = 50, collision = true, aoe = false, type = "linear" }
	
	UPL:AddSpell(_Q, self.SpellQ)
end

function _Janna:OnTick()
	self:Combo()
	self:FlashCombo()
	self:Interrupt()
	self:LaneClear()
	self:TowerCC() 
end

function _Janna:Menu()
	menu = scriptConfig("Support Heroes", "SupportHeroesMenuJanna")
	
	_Activator:Menu()
	
	menu:addSubMenu("[" .. myHero.charName .. "] - Auto-CC Under Tower", "snare")
		menu.snare:addParam("info", "           -- Auto-CC Enemies --", SCRIPT_PARAM_INFO, "")
		if enemyCount > 0 then
			for i = 1, enemyCount do
			local unit = enemyHeroes[i]			
				menu.snare:addParam("" .. unit.charName, "" .. unit.charName, SCRIPT_PARAM_ONOFF, true)
			end
		end
		menu.snare:addParam("settings", "                    -- Settings --", SCRIPT_PARAM_INFO, "")
		menu.snare:addParam("qsnare", "Use Q", SCRIPT_PARAM_ONOFF, true)
		
	menu:addSubMenu("[" .. myHero.charName .. "] - Auto-Shield", "as")
		for i = 1, heroManager.iCount do
			local unit = heroManager:GetHero(i)
			if unit.team == myHero.team then
			menu.as:addParam("teammateshield"..i, "Shield "..unit.charName, SCRIPT_PARAM_ONOFF, true)
			menu.as:addParam("maxhppercent"..i, "Shield If < X% HP", SCRIPT_PARAM_SLICE, 80, 0, 100, 0)
			menu.as:addParam("teammateaashieldattack"..i, "Shield While AA'ing", SCRIPT_PARAM_ONOFF, false) 
			menu.as:addParam("teammateaashield"..i, "Shield Enemy AA", SCRIPT_PARAM_ONOFF, true)
			menu.as:addParam("teammateaashieldhp"..i, "Shield AA If Ally <X% HP", SCRIPT_PARAM_SLICE, 10, 0, 100, 0)
			menu.as:addParam("empty", "", SCRIPT_PARAM_INFO,"")
			end 
		end	
			menu.as:addParam("turretshield", "Shield Turrets", SCRIPT_PARAM_ONOFF, true)
			menu.as:addParam("turretshieldhp", "Shield Turret < X% HP", SCRIPT_PARAM_SLICE, 40, 0, 100, 0)
			menu.as:addParam("empty", "", SCRIPT_PARAM_INFO,"")
			menu.as:addParam("mindmgpercent", "Min dmg percent", SCRIPT_PARAM_SLICE, 10, 0, 100, 0)
			menu.as:addParam("shieldcc", "Shield CC", SCRIPT_PARAM_ONOFF, true)
			menu.as:addParam("shieldslow", "Shield Slows", SCRIPT_PARAM_ONOFF, true)
			menu.as:addParam("skillshots", "Shield Skillshots", SCRIPT_PARAM_ONOFF, false)
				 
	menu:addSubMenu("[" .. myHero.charName .. "] - Auto-Interrupt", "interrupt")   
		menu.interrupt:addParam("spells", "           -- Auto Interrupt Spells --", SCRIPT_PARAM_INFO, "")
		if enemyCount > 0 then
			for i = 1, enemyCount do
				local unit = enemyHeroes[i]
				if Interrupt[unit.charName] ~= nil then
					for i, spell in pairs(Interrupt[unit.charName].stop) do
						menu.interrupt:addParam("" .. unit.charName, "" .. unit.charName, SCRIPT_PARAM_INFO, "") 
						menu.interrupt:addParam(spell.spellName,"" .. spell.name, SCRIPT_PARAM_ONOFF, true)
						menu.interrupt:addParam("empty", "", SCRIPT_PARAM_INFO, "")
					end 
				end
			end
		end
		menu.interrupt:addParam("settings", "                -- Settings --", SCRIPT_PARAM_INFO, "")
		menu.interrupt:addParam("qinterrupt", "Use Q", SCRIPT_PARAM_ONOFF, true)
		menu.interrupt:addParam("rinterrupt", "Use R", SCRIPT_PARAM_ONOFF, true)
		
	menu:addSubMenu("[" .. myHero.charName .. "] - Draw Settings", "draw")
		menu.draw:addParam("spelldraws", "                -- Spell Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawq", "Draw Q", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colorq", "Color Q", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("draww", "Draw W", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colorw", "Color W", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawe", "Draw E", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colore", "Color E", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawr", "Draw R", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colorr", "Color R", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("miscellaneousdraws", "                -- Flash Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawinsecflash", "Draw Insec Flash", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawitem", "                -- Item Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawfotm", "Draw Face of the Mountain", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorfotm", "Color Face of the Mountain", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawlois", "Draw Locket of the Iron Solari", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorlois", "Color Locket of the Iron Solari", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawmikaels", "Draw Mikaels Crucible", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorqmikaels", "Color Mikaels Crucible", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 }) 
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawsumm", "                -- Summoner Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawexhaust", "Draw Exhaust", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorexhaust", "Color Exhaust", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawheal", "Draw Heal", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorheal", "Color Heal", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawignite", "Draw Ignite", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorignite", "Color Ignite", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })  
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("miscellaneousdraws", "            -- Miscellaneous Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawtarget", "Draw Target", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("drawpermashow", "Draw Permashow (Reload)", SCRIPT_PARAM_ONOFF, true)
			
	menu:addSubMenu("[" .. myHero.charName .. "] - Farm Settings", "farm")
		menu.farm:addParam("laneclear", "                    -- Lane Clear --", SCRIPT_PARAM_INFO, "")
		menu.farm:addParam("wlaneclear", "Use W", SCRIPT_PARAM_ONOFF, true)
		menu.farm:addParam("wclearmana", "Minimum Mana", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		
	menu:addSubMenu("[" .. myHero.charName .. "] - Flash Settings", "flash")
		menu.flash:addParam("insecflash", "Use Insec Flash", SCRIPT_PARAM_ONOFF, true)
	
	menu:addSubMenu("[" .. myHero.charName .. "] - Humanizer", "humanizer")
		menu.humanizer:addParam("interruptDelay", "Auto-Interrupt Delay (ms)", SCRIPT_PARAM_SLICE, 200, 0, 500, 0)
		menu.humanizer:addParam("snareDelay", "Auto-CC Delay (ms)", SCRIPT_PARAM_SLICE, 0, 0, 500, 0)
		menu.humanizer:addParam("shieldDelay", "Auto Shield Delay (ms)", SCRIPT_PARAM_SLICE, 50, 0, 500, 0)
			
	menu:addSubMenu("[" .. myHero.charName .. "] - Key Settings", "key")
		menu.key:addParam("combatkeys", "               -- Combat Keys --", SCRIPT_PARAM_INFO, "")
		menu.key:addParam("comboKey", "Combo Key", SCRIPT_PARAM_ONKEYDOWN, false, 32)
		menu.key:addParam("harassKey", "Harass Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
		menu.key:addParam("harassToggle", "Harass Toggle", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("T"))
		menu.key:addParam("clearKey", "Lane Clear Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
		menu.key:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.key:addParam("miscellaneouskeys", "           -- Miscellaneous Keys --", SCRIPT_PARAM_INFO, "")
		menu.key:addParam("flashKey", "Flash Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("H"))
	
	menu:addSubMenu("[" .. myHero.charName .. "] - Spell Settings", "spell")
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - Q", "q")
		menu.spell.q:addParam("qcombo", "Combo", SCRIPT_PARAM_ONOFF, true)
		menu.spell.q:addParam("qcombomana", "[Combo] Mana > X%", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
		menu.spell.q:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.q:addParam("qharass", "Harass", SCRIPT_PARAM_ONOFF, true)
		menu.spell.q:addParam("qharassmana", "[Harass] Mana > X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)   
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - W", "w")
		menu.spell.w:addParam("wcombo", "Combo", SCRIPT_PARAM_ONOFF, true)
		menu.spell.w:addParam("wcombomana", "[Combo] Mana > X%", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
		menu.spell.w:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.w:addParam("wharass", "Harass", SCRIPT_PARAM_ONOFF, true)
		menu.spell.w:addParam("wharassmana", "[Harass] Mana > X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - E", "e")
		menu.spell.e:addParam("info", "Check Auto Shield For Settings", SCRIPT_PARAM_INFO, "")
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - R", "r")
		for i = 1, heroManager.iCount do
		local unit = heroManager:GetHero(i)
			if unit.team == myHero.team then  
			menu.spell.r:addParam("teammateult"..i, "Ult "..unit.charName, SCRIPT_PARAM_ONOFF, true)
			menu.spell.r:addParam("maxhppercent"..i, "Ult If < X% HP", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
			menu.spell.r:addParam("empty", "", SCRIPT_PARAM_INFO, "")
			end
		end
		menu.spell.r:addParam("mindmgpercent", "Min Damage To Ult", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		
   menu:addSubMenu("[" .. myHero.charName .. "] - Target Selector", "target")
		menu.target:addParam("targetinfo", "Default Target Select Is LeastCast", SCRIPT_PARAM_INFO, "")
		menu.target:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.target:addParam("focus", "Focus Selected Target", SCRIPT_PARAM_ONOFF, true)
		menu.target:addParam("sac", "Use SAC:R Target Instead", SCRIPT_PARAM_ONOFF, false)
		
   menu:addSubMenu("Orbwalk Settings", "orb")  
   
   UPL:AddToMenu(menu)
   
   menu:addParam("hc", "Prediction Hit Chance", SCRIPT_PARAM_SLICE, 2, 0, 5, 0)
 
   menu:addParam("empty", "", SCRIPT_PARAM_INFO, "")
   menu:addParam("infobox", "            Support Heroes: " .. myHero.charName .. "           ", SCRIPT_PARAM_INFO, "")
   menu:addParam("infobox2", "                      Version:  " .. scriptVersion .. "         ", SCRIPT_PARAM_INFO, "")
   
   if menu.draw.drawpermashow then
	 menu:permaShow("infobox")
	 menu.key:permaShow("comboKey")
	 menu.key:permaShow("harassKey")
	 menu.key:permaShow("harassToggle")
	 menu.key:permaShow("clearKey")
   end
end
 
function _Janna:Combo() 
	if Target == nil then return end
	if menu.key.comboKey then 
		if IsReady(_Q) and menu.spell.q.qcombo and (100 * myHero.mana / myHero.maxMana)>= menu.spell.q.qcombomana and (GetDistance(Target) < self.SpellQ.range) then
			if ValidTarget(Target) then
				CastSpell(_Q)
				DelayAction(function() self:JannaCastQ2(Target) end, 0)
			end
		end 
		if IsReady(_W) and menu.spell.w.wcombo and (100 * myHero.mana / myHero.maxMana)>= menu.spell.w.wcombomana and (GetDistance(Target) < self.SpellW.range) then
			if ValidTarget(Target) then
				CastSpell(_W, Target)
			end
		end
	end
end

function _Janna:FlashCombo()
	if Target == nil then return end
	for i = 1, towerCount do
	local tower = towers[i]
		if tower and tower.team == myHero.team and GetDistance(tower) < 1500 and IsReady(sflash) then
		   local Position = VPred:GetPredictedPos(Target, 0.1)
		   local flashPos = Position + 100 * (Vector(Position) - Vector(tower)):normalized()
					
		   if GetDistance(flashPos) > 425 then
			   flashPos = nil
		   end
					
		   if GetDistance(Position, flashPos) > 100 then
			  flashPos = nil
		   end
					
		   hasTower = true
					
		   if flashPos ~= nil and menu.key.flashKey and menu.flash.insecflash then					
			   if IsReady(_R) and myHero.mana > myHero:GetSpellData(_R).mana then
				 CastSpell(sflash, flashPos.x, flashPos.z)
				 CastSpell(_R)
			   end
		   end
		end
	end 
	local useAlly = nil
	local damage = 0
	for i = 1, allyCount do
	local ally = allyHeroes[i]
	   if not ally.dead and (GetDistance(ally) < 800) then
		   if ally.damage > damage then
			  useAlly = ally
			  damage = ally.damage
		   end
	   end
	end
	local Position = VPred:GetPredictedPos(Target, 0.1)
	local flashPos = Position + 100 * (Vector(Position) - Vector(useAlly)):normalized()
				
	if GetDistance(flashPos) > 425 then
		flashPos = nil
	end
				
	if GetDistance(Position, flashPos) > 100 then
		flashPos = nil
	end
				
	if flashPos ~= nil and menu.key.flashKey and menu.flash.insecflash then					
		if IsReady(_R) and IsReady(sflash) and myHero.mana > myHero:GetSpellData(_R).mana then
			CastSpell(sflash, flashPos.x, flashPos.z)
			CastSpell(_R)
		end
	end
	if menu.key.flashKey and IsReady(sflash) then
		myHero:MoveTo(mousePos.x, mousePos.z)
	end
end

function _Janna:Harass()
	if Target == nil then return end
	if menu.key.harassKey or menu.key.harassToggle then 
		if IsReady(_Q) and menu.spell.q.qharass and (100 * myHero.mana / myHero.maxMana)>= menu.spell.q.qharassmana and (GetDistance(Target) < 850) then
			if ValidTarget(Target) then
				CastSpell(_Q)
				DelayAction(function() self:JannaCastQ2(Target) end, 0)
			end
		end
		if IsReady(_W) and menu.spell.w.wharass and (100 * myHero.mana / myHero.maxMana)>= menu.spell.w.wharassmana and (GetDistance(Target) < self.SpellW.range) then
			if ValidTarget(Target) then
				CastSpell(_W, Target)
			end
		end
	end
end

function _Janna:Interrupt()
	if not myHero.dead and myHero.team ~= unit.team then
	   if Interrupt[unit.charName] ~= nil then
		   if Interrupt[unit.charName].stop[unit.spellName] ~= nil then
				if menu.interrupt[spell.name] then
					if IsReady(_Q) and menu.interrupt.qinterrupt and (GetDistance(unit) < 850) then 
						DelayAction(function() CastSpell(_Q, unit) end, menu.humanizer.interruptDelay / 1000)
					elseif IsReady(_R) and menu.interrupt.rinterrupt and (GetDistance(unit) < self.SpellR.range) then 
						DelayAction(function() CastSpell(_R, unit) end, menu.humanizer.interruptDelay / 1000)
					end
				end
		   end
	   end
	end
end  

function _Janna:JannaCastQ2(Target)
	if Target == nil then return end
	if (GetDistance(Target) <= self.SpellQ.range) and IsReady(_Q) then
		local CastPosition,  HitChance,  Position = UPL:Predict(_Q, myHero, Target)
		if CastPosition and HitChance >= menu.hc then
		   CastSpell(_Q, CastPosition.x, CastPosition.z)
	   end
	end
end

function _Janna:LaneClear()
	for i, Minion in pairs(enemyMinions.objects) do
		if (Minion ~= nil) then
			if menu.key.clearKey then 
				if IsReady(_W) and menu.farm.wlaneclear and (100 * myHero.mana / myHero.maxMana)>= menu.farm.wclearmana then
					CastSpell(_W, Minion)
				end
			end
		end
	end                
end

function _Janna:OnDraw()
	if Target == nil then return end
	if menu.draw.drawtarget and ValidTarget(Target) and Target.type == myHero.type then
		_Tech:DrawCircle(Target.x, Target.y, Target.z, 150, ARGB(255, 255, 0, 0))
	end
	local Position = VPred:GetPredictedPos(Target, 0.1)
	local flashPos = Position + 100 * (Vector(myHero) - Vector(flashPos)):normalized()
	if IsReady(_R) and IsReady(sflash) and ValidTarget(Target) then	
		if flashPos ~= nil and menu.draw.drawinsecflash then
			if GetDistance(Target) < 425 and GetDistance(Target) > 50 then
			  _Tech:DrawCircle(flashPos.x, flashPos.y, flashPos.z, 50, ARGB(255, 255, 0, 0))
			  _Tech:DrawCircle(flashPos.x, flashPos.y, flashPos.z, 60, ARGB(255, 255, 255, 255))
				for i = 1, enemyCount do
				local enemy = enemyHeroes[i]
					if not enemy.dead and GetDistance(enemy) < 725 then
					local endPos = enemy + (875 - math.sqrt((enemy.x - flashPos.x) ^ 2 + (enemy.z - flashPos.z) ^ 2)) * (Vector(myHero) - Vector(flashPos)):normalized()
					DrawLine3D(enemy.x, enemy.y, enemy.z, endPos.x, endPos.y, endPos.z, 5, ARGB(125, 0, 255,0))
					end
				end
			end
		end
	end
	local slot = _Tech:CustomGetInventorySlotItem("HealthBomb", myHero)
	if menu.draw.drawfotm and slot ~= nil and IsReady(slot) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 750, ARGB(table.unpack(menu.draw.colorfotm))) 
	end
	local slot = _Tech:CustomGetInventorySlotItem("IronStylus", myHero)
	if menu.draw.drawlois and slot ~= nil and IsReady(slot) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 750, ARGB(table.unpack(menu.draw.colorlois))) 
	end
	local slot = _Tech:CustomGetInventorySlotItem("ItemMorellosBane", myHero)
	if menu.draw.drawmikaels and slot ~= nil and IsReady(slot) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 750, ARGB(table.unpack(menu.draw.colormikaels))) 
	end
	if menu.draw.drawexhaust and sexhaust ~= nil and IsReady(sexhaust) then 
	   _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 650, ARGB(table.unpack(menu.draw.colorexhaust))) 
	end
	if menu.draw.drawheal and sheal ~= nil and IsReady(sheal) then 
	   _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 850, ARGB(table.unpack(menu.draw.colorheal))) 
	end
	if menu.draw.drawignite and signite ~= nil and IsReady(signite) then 
	   _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 600, ARGB(table.unpack(menu.draw.colorignite))) 
	end
	if menu.draw.drawq and IsReady(_Q) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 850, ARGB(table.unpack(menu.draw.colorq)))
	end
	if menu.draw.draww and IsReady(_W) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, self.SpellW.range, ARGB(table.unpack(menu.draw.colorw)))
	end
	if menu.draw.drawe and IsReady(_E) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, self.SpellE.range, ARGB(table.unpack(menu.draw.colore)))
	end
	if menu.draw.drawr and IsReady(_R) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, self.SpellR.range, ARGB(table.unpack(menu.draw.colorr)))
	end
end

function _Janna:ProcessAttack(object,spell) 
	if IsReady(_E) and spell.target and GetDistance(spell.target) < self.SpellE.range then	
			if object.team == TEAM_ENEMY and spell.name:lower():find("attack") then
				if spell.target.type == "obj_AI_Turret" then 
					if (100*spell.target.health/spell.target.maxHealth) <= menu.as.turretshieldhp and menu.as.turretshield then
					CastSpell(_E, spell.target)	 
					end
				end
			end 
		end
	for i = 1, heroManager.iCount do
		local allytarget = heroManager:GetHero(i)
		if allytarget.team == myHero.team then
			if allytarget.team == myHero.team and not allytarget.dead and allytarget.health > 0 then
				if IsReady(_E) and spell.target and GetDistance(allytarget) < self.SpellE.range then
					if object.team == myHero.team and object.type == myHero.type and spell.name:lower():find("attack") then
						if spell.target.team ~= myHero.team and spell.target.type == myHero.type and menu.as["teammateaashieldattack".. i] then
							DelayAction(function() CastSpell(_E, allytarget) end, menu.humanizer.shieldDelay / 1000)
						end
					end
				end
			end
		end
	end   
	for i = 1, heroManager.iCount do
		local allytarget = heroManager:GetHero(i)
		if allytarget.team == myHero.team then  
			if allytarget.team == myHero.team and not allytarget.dead and allytarget.health > 0 then
				if IsReady(_E) and spell.target and GetDistance(allytarget) < self.SpellE.range then
					if object.team == TEAM_ENEMY and object.type == myHero.type and spell.name:lower():find("attack") then
						if spell.target == allytarget and spell.target.type == myHero.type and menu.as["teammateaashield".. i] and (100*spell.target.health/spell.target.maxHealth) <= menu.as["teammateaashieldhp".. i] then
							DelayAction(function() CastSpell(_E, allytarget) end, menu.humanizer.shieldDelay / 1000)
						end
					end
				end
			end
		end
	end 
	if object.team ~= myHero.team and not myHero.dead and object.name ~= nil and not (object.name:find("Minion_") or object.name:find("Odin")) then
		local shieldREADY = IsReady(_E)
		local ultREADY = IsReady(_R)
		local HitFirst = false
		local shieldtarget,SLastDistance,SLastDmgPercent = nil,nil,nil
		local ulttarget,ULastDistance,ULastDmgPercent = nil,nil,nil
		
		YWall, BShield, SShield, Shield, CC = false, false, false, false
		shottype, radius, maxdistance = 0, 0, 0
		
		if object.type == "AIHeroClient" then
			spelltype, casttype = getSpellType(object, spell.name)
			if casttype == 4 or casttype == 5 or casttype == 6 then
				return
			end
		   
			Shield = true
			
				if spelltype == "Q" or spelltype == "W" or spelltype == "E" or spelltype == "R" or spelltype == "P" or spelltype == "QM" or spelltype == "WM" or spelltype == "EM" then
					if skillShield[object.charName] == nil then return end
                    HitFirst = skillShield[object.charName][spelltype].HitFirst
					YWall = skillShield[object.charName][spelltype].YWall
					BShield = skillShield[object.charName][spelltype].BShield
					SShield = skillShield[object.charName][spelltype].SShield
					Shield = skillShield[object.charName][spelltype].Shield
					CC = skillShield[object.charName][spelltype].CC
					shottype = skillData[object.charName][spelltype].type
					radius = skillData[object.charName][spelltype].radius
					maxdistance = skillData[object.charName][spelltype].maxdistance
				else
					Shield = true
				end
			
				for i = 1, heroManager.iCount do
				local allytarget = heroManager:GetHero(i)
					if spell.target and spell.target.networkID == allytarget.networkID then
						if allytarget.team == myHero.team and not allytarget.dead and 0 < allytarget.health and allytarget.type == myHero.type then
							hitchampion = false
							local allyHitBox = allytarget.boundingRadius
							if shottype == 0 then
							hitchampion = spell.target and spell.target.networkID == allytarget.networkID
							elseif shottype == 1 then
							hitchampion = checkhitlinepass(object, spell.endPos, radius, maxdistance, allytarget, allyHitBox)
							elseif shottype == 2 then
							hitchampion = checkhitlinepoint(object, spell.endPos, radius, maxdistance, allytarget, allyHitBox)
							elseif shottype == 3 then
							hitchampion = checkhitaoe(object, spell.endPos, radius, maxdistance, allytarget, allyHitBox)
							elseif shottype == 4 then
							hitchampion = checkhitcone(object, spell.endPos, radius, maxdistance, allytarget, allyHitBox)
							elseif shottype == 5 then
							hitchampion = checkhitwall(object, spell.endPos, radius, maxdistance, allytarget, allyHitBox)
							elseif shottype == 6 then
							hitchampion = checkhitlinepass(object, spell.endPos, radius, maxdistance, allytarget, allyHitBox) or checkhitlinepass(object, Vector(object) * 2 - spell.endPos, radius, maxdistance, allytarget, allyHitBox)
							elseif shottype == 7 then
							hitchampion = checkhitcone(spell.endPos, object, radius, maxdistance, allytarget, allyHitBox)              
							end
							if shieldREADY and menu.as["teammateshield" .. i] and GetDistance(allytarget) <= self.SpellE.range then
								local shieldflag, dmgpercent = self:shieldCheck(object,spell,allytarget,"shields")
									if shieldflag then
										if HitFirst and (SLastDistance == nil or SLastDistance >= GetDistance(allytarget, object)) then
											shieldtarget, SLastDistance = allytarget, GetDistance(allytarget, object)
										elseif not HitFirst and (SLastDmgPercent == nil or SLastDmgPercent <= dmgpercent) then
											shieldtarget, SLastDmgPercent = allytarget, dmgpercent
										end
									end
								end
							end
							if ultREADY and menu.spell.r["teammateult"..i] and GetDistance(allytarget) <= self.SpellR.range then
								local ultflag, dmgpercent = self:shieldCheck(object,spell,allytarget,"ult")
								if ultflag then
									if HitFirst and (ULastDistance == nil or GetDistance(allytarget,object) <= ULastDistance) then
										ulttarget,ULastDistance = allytarget,GetDistance(allytarget,object)
									elseif not HitFirst and (ULastDmgPercent == nil or dmgpercent >= ULastDmgPercent) then
										ulttarget,ULastDmgPercent = allytarget,dmgpercent
									end
								end
							end
						end
						
						end
					if shieldtarget ~= nil then
						DelayAction(function() CastSpell(_E, shieldtarget) end, menu.humanizer.shieldDelay / 1000)
					end
					if ulttarget ~= nil then
						CastSpell(_R, ulttarget)
				end
			end
		end
end

function _Janna:shieldCheck(object,spell,target,typeused)
	if Target == nil then return end
	local configused 
	
	if typeused == "shields" then configused = menu.as
	elseif typeused == "ult" then configused = menu.spell.r
	end

	  local shieldflag = false
	  if not menu.as.skillshots and shottype ~= 0 then
		return false, 0
	  end
	  local adamage = object:CalcDamage(target, object.totalDamage)
	  local InfinityEdge,onhitdmg,onhittdmg,onhitspelldmg,onhitspelltdmg,muramanadmg,skilldamage,skillTypeDmg = 0,0,0,0,0,0,0,0
	  if object.type ~= "AIHeroClient" then
	  elseif spelltype == "BAttack" then
		skilldamage = (adamage+onhitdmg+muramanadmg)*1.07+onhittdmg
	  elseif spelltype == "CAttack" then
	  elseif spelltype == "Q" or spelltype == "W" or spelltype == "E" or spelltype == "R" or spelltype == "P" or spelltype == "QM" or spelltype == "WM" or spelltype == "EM" then
		if not skillShield[object.charName][spelltype].Muramana or not muramanadmg then
		  muramanadmg = 0
		end
		if casttype == 1 then
		  skilldamage, skillTypeDmg = getDmg(spelltype, target, object, 1, spell.level)
		elseif casttype == 2 then
		  skilldamage, skillTypeDmg = getDmg(spelltype, target, object, 2, spell.level)
		elseif casttype == 3 then
		  skilldamage, skillTypeDmg = getDmg(spelltype, target, object, 3, spell.level)
		end
		if skillTypeDmg == 2 then
		  skilldamage = (skilldamage + adamage + onhitspelldmg + onhitdmg + muramanadmg)* 1.07 + onhittdmg + onhitspelltdmg
		elseif skilldamage > 0 then
		  skilldamage = (skilldamage + onhitspelldmg + muramanadmg)* 1.07 + onhitspelltdmg
		end
	  elseif spell.name:find("SummonerDot") then
		skilldamage = getDmg("IGNITE", target, object)
		end
			  for i = 1, heroManager.iCount do
				local ally = heroManager:GetHero(i)
				if ally.team == myHero.team then 
			  
			  local dmgpercent = skilldamage * 100 / target.health
			  local dmgneeded = dmgpercent >= configused.mindmgpercent
			  local hpneeded =  configused["maxhppercent"..i] >= (target.health - skilldamage) * 100 / target.maxHealth
				  if dmgneeded and hpneeded then
					  shieldflag = true
				  elseif (typeused == "shields" or typeused == "wall") and (CC == 2 and menu.as.shieldCC or CC == 1 and menu.as.shieldslow) then
					  shieldflag = true
				  end
				  return shieldflag, dmgpercent
				  end
			  end
		  end

function _Janna:TowerCC()
	if Target == nil then return end
	for i = 1, enemyCount do
	local unit = enemyHeroes[i]
		for i = 1, towerCount do
			local tower = towers[i]
			if tower and tower.team == myHero.team and (GetDistance(tower, unit) <= 775) then
				if menu.snare.qsnare and menu.snare["" ..unit.charName] then
					CastSpell(_Q, unit)
					DelayAction(function() self:JannaCastQ2(Target) end, 0)
				end
			end
		end
	end
end

Class("_Leona")
function _Leona:__init()
	self:LoadVariables()
	self:Menu()
	
	
	_Bundle:SetupOrbwalk()
	
	_Activator:__init()
	
	_Tech:AddTurrets()
	towerCount = #towers
	
	AddTickCallback(function() self:OnTick() end)
	AddDrawCallback(function() self:OnDraw() end)
	AddProcessAttackCallback(function(object, spell) self:ProcessAttack(object, spell) end)
	AddRemoveBuffCallback(function(unit, buff) self:RemoveBuff(unit, buff) end)
	AddApplyBuffCallback(function(unit, target, buff) self:ApplyBuff(unit, target, buff) end)
	
	enemyMinions = minionManager(MINION_ENEMY, 875, myHero, MINION_SORT_HEALTH_DES)
	
	_Bundle:Print(myHero.charName .. " Loaded, Good Luck!")
end

function _Leona:LoadVariables()
	self.SpellQ = { speed = 1800, delay = 0.25, range = 175, width = 70, collision = false, aoe = false, type = "nil"}

	self.SpellW = { speed = nil, delay = 0.25, range = 450, width = 150, collision = false, aoe = false, type = "Circular" } 

	self.SpellE = { speed = nil, delay = 0.25, range = 875, width = 200, collision = false, aoe = false, type = "circular" }
	
	self.SpellR = { speed = 2000, delay = 0.25, range = 1200, width = 200, collision = false, aoe = true, type = "linear" }
	
	UPL:AddSpell(_E, self.SpellE)
end

function _Leona:OnTick()
	self:AutoShield()
	self:Combo()
	self:FlashCombo()
	self:Harass()
	self:Interrupt()
	self:LaneClear()
	self:TowerCC() 
end

function _Leona:Menu()
	menu = scriptConfig("Support Heroes", "SupportHeroesMenuLeona")
	
	_Activator:Menu()
	
	menu:addSubMenu("[" .. myHero.charName .. "] - Auto-CC Under Tower", "snare")
		menu.snare:addParam("info", "           -- Auto-CC Enemies --", SCRIPT_PARAM_INFO, "")
		if enemyCount > 0 then
			for i = 1, enemyCount do
			local unit = enemyHeroes[i]			
				menu.snare:addParam("" .. unit.charName, "" .. unit.charName, SCRIPT_PARAM_ONOFF, true)
			end
		end
		menu.snare:addParam("settings", "                    -- Settings --", SCRIPT_PARAM_INFO, "")
		menu.snare:addParam("qsnare", "Use Q", SCRIPT_PARAM_ONOFF, false)
		menu.snare:addParam("esnare", "Use E", SCRIPT_PARAM_ONOFF, true)
		
	menu:addSubMenu("[" .. myHero.charName .. "] - Auto-Interrupt", "interrupt")   
		menu.interrupt:addParam("spells", "           -- Auto Interrupt Spells --", SCRIPT_PARAM_INFO, "")
		if enemyCount > 0 then
			for i = 1, enemyCount do
				local unit = enemyHeroes[i]
				if Interrupt[unit.charName] ~= nil then
					for i, spell in pairs(Interrupt[unit.charName].stop) do
						menu.interrupt:addParam("" .. unit.charName, "" .. unit.charName, SCRIPT_PARAM_INFO, "") 
						menu.interrupt:addParam(spell.spellName,"" .. spell.name, SCRIPT_PARAM_ONOFF, true)
						menu.interrupt:addParam("empty", "", SCRIPT_PARAM_INFO,"")
					end 
				end
			end
		end
		menu.interrupt:addParam("settings", "                -- Settings --", SCRIPT_PARAM_INFO, "")
		menu.interrupt:addParam("qinterrupt", "Use Q", SCRIPT_PARAM_ONOFF, true)
		menu.interrupt:addParam("einterrupt", "Use E", SCRIPT_PARAM_ONOFF, true)
		menu.interrupt:addParam("rinterrupt", "Use R", SCRIPT_PARAM_ONOFF, true)
		
	menu:addSubMenu("[" .. myHero.charName .. "] - Draw Settings", "draw")
		menu.draw:addParam("spelldraws", "                -- Spell Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawq", "Draw Q", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colorq", "Color Q", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("draww", "Draw W", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colorw", "Color W", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })      
		menu.draw:addParam("drawe", "Draw E", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colore", "Color E", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawr", "Draw R", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colorr", "Color R", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("miscellaneousdraws", "                -- Flash Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("draweflash", "Draw Flash - E", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("coloreflash", "Color Flash - E", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawitem", "                -- Item Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawfotm", "Draw Face of the Mountain", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorfotm", "Color Face of the Mountain", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawlois", "Draw Locket of the Iron Solari", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorlois", "Color Locket of the Iron Solari", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawmikaels", "Draw Mikaels Crucible", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorqmikaels", "Color Mikaels Crucible", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 }) 
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawsumm", "                -- Summoner Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawexhaust", "Draw Exhaust", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorexhaust", "Color Exhaust", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawheal", "Draw Heal", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorheal", "Color Heal", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawignite", "Draw Ignite", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorignite", "Color Ignite", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })  
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("miscellaneousdraws", "            -- Miscellaneous Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawtarget", "Draw Target", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("drawpermashow", "Draw Permashow (Reload)", SCRIPT_PARAM_ONOFF, true)
			
	menu:addSubMenu("[" .. myHero.charName .. "] - Farm Settings", "farm")
		menu.farm:addParam("laneclear", "                    -- Lane Clear --", SCRIPT_PARAM_INFO, "")
		menu.farm:addParam("qlaneclear", "Use Q", SCRIPT_PARAM_ONOFF, true)
		menu.farm:addParam("qclearmana", "Minimum Mana", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		
	menu:addSubMenu("[" .. myHero.charName .. "] - Flash Settings", "flash")
		menu.flash:addParam("eflash", "Use Flash - E", SCRIPT_PARAM_ONOFF, true)
	
	menu:addSubMenu("[" .. myHero.charName .. "] - Humanizer", "humanizer")
		menu.humanizer:addParam("interruptDelay", "Auto-Interrupt Delay (ms)", SCRIPT_PARAM_SLICE, 200, 0, 500, 0)
		menu.humanizer:addParam("snareDelay", "Auto-CC Delay (ms)", SCRIPT_PARAM_SLICE, 0, 0, 500, 0)
		menu.humanizer:addParam("shieldDelay", "Auto Shield Delay (ms)", SCRIPT_PARAM_SLICE, 50, 0, 500, 0)
			
	menu:addSubMenu("[" .. myHero.charName .. "] - Key Settings", "key")
		menu.key:addParam("combatkeys", "               -- Combat Keys --", SCRIPT_PARAM_INFO, "")
		menu.key:addParam("comboKey", "Combo Key", SCRIPT_PARAM_ONKEYDOWN, false, 32)
		menu.key:addParam("harassKey", "Harass Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
		menu.key:addParam("harassToggle", "Harass Toggle", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("T"))
		menu.key:addParam("clearKey", "Lane Clear Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
		menu.key:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.key:addParam("miscellaneouskeys", "           -- Miscellaneous Keys --", SCRIPT_PARAM_INFO, "")
		menu.key:addParam("flashKey", "Flash Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("H"))
	
	menu:addSubMenu("[" .. myHero.charName .. "] - Spell Settings", "spell")
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - Q", "q")
		menu.spell.q:addParam("qcombo", "Combo", SCRIPT_PARAM_ONOFF, true)
		menu.spell.q:addParam("qcombomana", "[Combo] Mana > X%", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
		menu.spell.q:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.q:addParam("qharass", "Harass", SCRIPT_PARAM_ONOFF, true)
		menu.spell.q:addParam("qharassmana", "[Harass] Mana > X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		menu.spell.q:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.q:addParam("qturret", "Use AA Reset On Towers", SCRIPT_PARAM_ONOFF, true)
		menu.spell.q:addParam("qwardclear", "Use AA Reset To Clear Wards", SCRIPT_PARAM_ONOFF, true)  
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - W", "w")
		menu.spell.w:addParam("wcombo", "Combo", SCRIPT_PARAM_ONOFF, true)
		menu.spell.w:addParam("wcombomana", "[Combo] Mana > X%", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
		menu.spell.w:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.w:addParam("wharass", "Harass", SCRIPT_PARAM_ONOFF, true)
		menu.spell.w:addParam("wharassmana", "[Harass] Mana > X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		menu.spell.w:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.w:addParam("whp", "Use W < X% HP", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - E", "e")
		menu.spell.e:addParam("ecombo", "Combo", SCRIPT_PARAM_ONOFF, true)
		menu.spell.e:addParam("ecombomana", "[Combo] Mana > X%", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
		menu.spell.e:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.e:addParam("eharass", "Harass", SCRIPT_PARAM_ONOFF, true)
		menu.spell.e:addParam("eharassmana", "[Harass] Mana > X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		menu.spell.e:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.e:addParam("mindistancee", "Min Enemy Distance", SCRIPT_PARAM_SLICE, 500, 0, 1000, 0)
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - R", "r")
		menu.spell.r:addParam("rcombo", "Combo", SCRIPT_PARAM_ONOFF, true)
		menu.spell.r:addParam("rcombomana", "[Combo] Mana > X%", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
		menu.spell.r:addParam("rmpty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.r:addParam("rharass", "Harass", SCRIPT_PARAM_ONOFF, true)
		menu.spell.r:addParam("rharassmana", "[Harass] Mana > X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		menu.spell.r:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.r:addParam("amountenemies", "Only Ult If X Enemies", SCRIPT_PARAM_SLICE, 2, 0, 5, 0)
		menu.spell.r:addParam("mindistancer", "Min Enemy Distance", SCRIPT_PARAM_SLICE, 500, 0, 1200, 0)
		
   menu:addSubMenu("[" .. myHero.charName .. "] - Target Selector", "target")
		menu.target:addParam("targetinfo", "Default Target Select Is LeastCast", SCRIPT_PARAM_INFO, "")
		menu.target:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.target:addParam("focus", "Focus Selected Target", SCRIPT_PARAM_ONOFF, true)
		menu.target:addParam("sac", "Use SAC:R Target Instead", SCRIPT_PARAM_ONOFF, false)
		
   menu:addSubMenu("Orbwalk Settings", "orb")  
   
   UPL:AddToMenu(menu)
   
   menu:addParam("hc", "Prediction Hit Chance", SCRIPT_PARAM_SLICE, 2, 0, 5, 0)
 
   menu:addParam("empty", "", SCRIPT_PARAM_INFO, "")
   menu:addParam("infobox", "            Support Heroes: " .. myHero.charName .. "           ", SCRIPT_PARAM_INFO, "")
   menu:addParam("infobox2", "                      Version:  " .. scriptVersion .. "         ", SCRIPT_PARAM_INFO, "")
   
   if menu.draw.drawpermashow then
	 menu:permaShow("infobox")
	 menu.key:permaShow("comboKey")
	 menu.key:permaShow("harassKey")
	 menu.key:permaShow("harassToggle")
	 menu.key:permaShow("clearKey")
   end
end

function _Leona:ApplyBuff(unit, target, buff)
	if unit and unit.isMe and buff then
		if buff.name == "LeonaShieldOfDaybreak" then buffs["LeonaShieldOfDaybreak"] = true end
	end
end

function _Leona:AutoShield()
	if Target == nil then return end
	if IsReady(_W) and GetDistance(myHero) < self.SpellW.range then      
		if (100*myHero.health/myHero.maxHealth) <= menu.spell.w.whp and GetDistance(Target) <= 700 then
				DelayAction(function() CastSpell(_W) end, menu.humanizer.shieldDelay / 1000)
		end
	end
end

function _Leona:Combo() 
	if Target == nil then return end
	if menu.key.comboKey then 
		if IsReady(_Q) and menu.spell.q.qcombo and (100 * myHero.mana / myHero.maxMana)>= menu.spell.q.qcombomana and (GetDistance(Target) < self.SpellQ.range) then
			if ValidTarget(Target) then
				CastSpell(_Q)
				DelayAction(function() Attack(Target) end, 0)
			end
		end 
		if IsReady(_W) and menu.spell.w.wcombo and (100 * myHero.mana / myHero.maxMana)>= menu.spell.w.wcombomana and (GetDistance(Target) < self.SpellW.range) then
			if ValidTarget(Target) then
				CastSpell(_W)
			end
		end
		if IsReady(_E) and menu.spell.e.ecombo and (100 * myHero.mana / myHero.maxMana)>= menu.spell.e.ecombomana and (GetDistance(Target) < 875) then
			if ValidTarget(Target) and GetDistance(Target) >= menu.spell.e.mindistancee then
				local CastPosition, HitChance = UPL:Predict(_E, myHero, Target)	
				if HitChance >= menu.hc then
					CastSpell(_E, CastPosition.x, CastPosition.z) 
				end
			end
		end
		if enemyCount > 0 then
			for i = 1, enemyCount do
			local unit = enemyHeroes[i]
				if IsReady(_R) and menu.spell.r.rcombo and (100 * myHero.mana / myHero.maxMana)>= menu.spell.r.rcombomana and (GetDistance(unit) < 1200) then
					if ValidTarget(unit) then 
						local Position = FindBestCircle(unit, 1200, 100, _R)
						local AOECastPosition, MainTargetHitChance, nTargets = VPred:GetCircularAOECastPosition(unit, 0.25, 300, 1000, 1500, myHero) 
						if nTargets >= menu.spell.r.amountenemies and GetDistance(unit) >= menu.spell.r.mindistancer then
							CastSpell(_R, Position.x, Position.z)
						end
					end
				end
			end  
		end
	end          
end

function _Leona:CreateObj(object)
	if menu.spell.q.qwardclear and object.name:lower():find("ward") and object.team ~= myHero.team and GetDistance(object) < self.SpellQ.range + 100 then
		Attack(object)
	end
end

function _Leona:FlashCombo()
	if Target == nil then return end
	if menu.key.flashKey and menu.flash.eflash then 
		if ValidTarget(Target) and (GetDistance(Target) >= 425) and (GetDistance(Target) <= self.SpellE.range) then
		   if IsReady(sflash) and IsReady(_E) then
			   local flashPos = myHero + 425 * (Vector(Target) - Vector(myHero)):normalized()
			   local CastPosition, HitChance = UPL:Predict(_E, myHero, Target)	
			   if HitChance >= 2 then               
			   CastSpell(sflash, flashPos.x, flashPos.z)      
			   CastSpell(_E, CastPosition.x, CastPosition.z)
			   end
		   end	       
		end
	end
	if menu.key.flashKey and IsReady(sflash) and IsReady(_E) then
		myHero:MoveTo(mousePos.x, mousePos.z)
	end
end

function _Leona:Harass() 
	if Target == nil then return end
	if menu.key.harassKey or menu.key.harassToggle then 
		if IsReady(_Q) and menu.spell.q.qharass and (100 * myHero.mana / myHero.maxMana)>= menu.spell.q.qharassmana and (GetDistance(Target) < self.SpellQ.range) then
			if ValidTarget(Target) then
				CastSpell(_Q)
				DelayAction(function() Attack(Target) end, 0)
			end
		end 
		if IsReady(_W) and menu.spell.w.wharass and (100 * myHero.mana / myHero.maxMana)>= menu.spell.w.wharassmana and (GetDistance(Target) < self.SpellW.range) then
			if ValidTarget(Target) then
				CastSpell(_W)
			end
		end
		if IsReady(_E) and menu.spell.e.eharass and (100 * myHero.mana / myHero.maxMana)>= menu.spell.e.eharassmana and (GetDistance(Target) < 875) then
			if ValidTarget(Target) and GetDistance(Target) >= menu.spell.e.mindistancee then
				local CastPosition, HitChance = UPL:Predict(_E, myHero, unit)	
				if HitChance >= menu.hc then
					CastSpell(_E, CastPosition.x, CastPosition.z) 
				end
			end
		end
		if enemyCount > 0 then
			for i = 1, enemyCount do
			local unit = enemyHeroes[i]
				if IsReady(_R) and menu.spell.r.rharass and (100 * myHero.mana / myHero.maxMana)>= menu.spell.r.rharassmana and (GetDistance(unit) < 1200) then
					if ValidTarget(unit) then 
						local Position = FindBestCircle(unit, 1200, 100, _R)
						local AOECastPosition, MainTargetHitChance, nTargets = VPred:GetCircularAOECastPosition(unit, 0.25, 300, 1000, 1500, myHero) 
						if nTargets >= menu.spell.r.amountenemies and GetDistance(unit) >= menu.spell.r.mindistancer then
							CastSpell(_R, Position.x, Position.z)
						end
					end
				end
			end  
		end
	end          
end

function _Leona:Interrupt()
	if not myHero.dead and myHero.team ~= unit.team then
	   if Interrupt[unit.charName] ~= nil then
		   if Interrupt[unit.charName].stop[unit.spellName] ~= nil then
				if menu.interrupt[spell.name] then
					if IsReady(_Q) and menu.interrupt.qinterrupt and (GetDistance(unit) < self.SpellQ.range) then 
						DelayAction(function() CastSpell(_Q) end, menu.humanizer.interruptDelay / 1000)
						DelayAction(function() Attack(unit) end, menu.humanizer.interruptDelay / 1000)
					elseif IsReady(_E) and menu.interrupt.einterrupt and (GetDistance(unit) < 875) then
						local CastPosition, HitChance = UPL:Predict(_E, myHero, unit)	
						if HitChance >= menu.hc then
							CastSpell(_E, CastPosition.x, CastPosition.z)
					elseif IsReady(_R) and menu.interrupt.rinterrupt and (GetDistance(unit) < self.SpellR.range) then 
						local Position = FindBestCircle(unit, 1200, 100, _R)
						DelayAction(function() CastSpell(_R, Position.x, Position.z) end, menu.humanizer.interruptDelay / 1000)
						end
					end
				end
		   end
	   end
	end
end

function _Leona:LaneClear()
	for i, Minion in pairs(enemyMinions.objects) do
		if (Minion ~= nil) then
			if menu.key.clearKey then 
				if IsReady(_Q) and menu.farm.qlaneclear and (100 * myHero.mana / myHero.maxMana)>= menu.farm.qclearmana then
					CastSpell(_Q)
					Attack(Minion)
				end
			end
		end
	end                
end

function _Leona:ProcessAttack(object, spell)
	if menu.spell.q.qwardclear and object.isMe and spell.name:lower():find("attack") and spell.target.name:lower():find("ward") then
		DelayAction(function() CastSpell(_Q, myHero) Attack(object.target) end, (1 / (spell.animationTime * myHero.attackSpeed)) -_Tech:Latency())
	end
	for i = 1, objManager.iCount do
		local turret = objManager:getObject(i)
		if turret and turret.valid and turret.team ~= myHero.team and turret.type == "obj_AI_Turret" and not string.find(turret.name, "TurretShrine") then
			if menu.spell.q.qturret and object.isMe and spell.name:lower():find("attack") and spell.target == turret then
				DelayAction(function() CastSpell(_Q, myHero) Attack(object.target) end, (1 / (spell.animationTime * myHero.attackSpeed)) -_Tech:Latency())
			end
		end
	end
end

function _Leona:OnDraw()
	if Target == nil then return end
	if menu.draw.drawtarget and ValidTarget(Target) and Target.type == myHero.type then
		_Tech:DrawCircle(Target.x, Target.y, Target.z, 150, ARGB(255, 255, 0, 0))
	end
	if menu.draw.draweflash and menu.flash.eflash and IsReady(sflash) and IsReady(_E) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, (875 + 425), ARGB(table.unpack(menu.draw.coloreflash)))
	end 
	local slot = _Tech:CustomGetInventorySlotItem("HealthBomb", myHero)
	if menu.draw.drawfotm and slot ~= nil and IsReady(slot) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 750, ARGB(table.unpack(menu.draw.colorfotm))) 
	end
	local slot = _Tech:CustomGetInventorySlotItem("IronStylus", myHero)
	if menu.draw.drawlois and slot ~= nil and IsReady(slot) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 750, ARGB(table.unpack(menu.draw.colorlois))) 
	end
	local slot = _Tech:CustomGetInventorySlotItem("ItemMorellosBane", myHero)
	if menu.draw.drawmikaels and slot ~= nil and IsReady(slot) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 750, ARGB(table.unpack(menu.draw.colormikaels))) 
	end
	if menu.draw.drawexhaust and sexhaust ~= nil and IsReady(sexhaust) then 
	   _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 650, ARGB(table.unpack(menu.draw.colorexhaust))) 
	end
	if menu.draw.drawheal and sheal ~= nil and IsReady(sheal) then 
	   _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 850, ARGB(table.unpack(menu.draw.colorheal))) 
	end
	if menu.draw.drawignite and signite ~= nil and IsReady(signite) then 
	   _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 600, ARGB(table.unpack(menu.draw.colorignite))) 
	end
	if menu.draw.drawq and IsReady(_Q) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, self.SpellQ.range, ARGB(table.unpack(menu.draw.colorq)))
	end
	if menu.draw.draww and IsReady(_W) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, self.SpellW.range, ARGB(table.unpack(menu.draw.colorw)))
	end
	if menu.draw.drawe and IsReady(_E) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 875, ARGB(table.unpack(menu.draw.colore)))
	end
	if menu.draw.drawr and IsReady(_R) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, menu.SpellR.range, ARGB(table.unpack(menu.draw.colorr)))
	end
end
	
function _Leona:RemoveBuff(unit, buff)
	if unit and unit.isMe and buff then
		if buff.name == "LeonaShieldOfDaybreak" then buffs["LeonaShieldOfDaybreak"] = false end
	end
end

function _Leona:TowerCC()
	if Target == nil then return end
	for i = 1, enemyCount do
	local unit = enemyHeroes[i]
		for i = 1, towerCount do
			local tower = towers[i]
			if tower and tower.team == myHero.team and (GetDistance(tower, unit) <= 775) then
				if menu.snare.esnare and menu.snare["" ..unit.charName] then
					local CastPosition, HitChance = UPL:Predict(_E, myHero, unit)	
					if HitChance >= menu.hc then
						CastSpell(_E, CastPosition.x, CastPosition.z) 
					end
				elseif menu.snare.qsnare and menu.snare["" ..unit.charName] and (GetDistance(unit) < self.SpellQ.range) then
					CastSpell(_Q)
					Attack(unit)
				end
			end
		end
	end
end

Class("_Malphite")
function _Malphite:__init()
	self:LoadVariables()
	self:Menu()
	
	
	_Bundle:SetupOrbwalk()
	
	_Activator:__init()
	
	_Tech:AddTurrets()
	towerCount = #towers
	
	AddTickCallback(function() self:OnTick() end)
	AddDrawCallback(function() self:OnDraw() end)
	AddProcessAttackCallback(function(object, spell) self:ProcessAttack(object, spell) end)
	
	enemyMinions = minionManager(MINION_ENEMY, self.SpellE.range, myHero, MINION_SORT_HEALTH_DES)
	
	_Bundle:Print(myHero.charName .. " Loaded, Good Luck!")
end

function _Malphite:LoadVariables()
	self.SpellQ = { speed = 1800, delay = 0.25, range = 625, width = 70, collision = false, aoe = false, type = "linear"}

	self.SpellW = { speed = nil, delay = 0.25, range = 225, width = 150, collision = false, aoe = false, type = "linear" } 

	self.SpellE = { speed = nil, delay = 0.25, range = 200, width = 200, collision = false, aoe = true, type = "circular" }

	self.SpellR = { speed = 2000, delay = 0.25, range = 1000, width = 200, collision = false, aoe = true, type = "linear" }
	
	UPL:AddSpell(_R, self.SpellR)
end

function _Malphite:OnTick()
	self:Combo()
	self:FlashCombo()
	self:Harass()
	self:Interrupt()
	self:LaneClear()
	self:TowerCC() 
end

function _Malphite:Menu()
	menu = scriptConfig("Support Heroes", "SupportHeroesMenuMalph")
	
	_Activator:Menu()
	
	menu:addSubMenu("[" .. myHero.charName .. "] - Auto-CC Under Tower", "snare")
		menu.snare:addParam("info", "           -- Auto-CC Enemies --", SCRIPT_PARAM_INFO, "")
		if enemyCount > 0 then
			for i = 1, enemyCount do
			local unit = enemyHeroes[i]			
				menu.snare:addParam("" .. unit.charName, "" .. unit.charName, SCRIPT_PARAM_ONOFF, true)
			end
		end
		menu.snare:addParam("settings", "                    -- Settings --", SCRIPT_PARAM_INFO, "")
		menu.snare:addParam("qsnare", "Use Q", SCRIPT_PARAM_ONOFF, true)
		
	menu:addSubMenu("[" .. myHero.charName .. "] - Auto-Interrupt", "interrupt")   
		menu.interrupt:addParam("spells", "           -- Auto Interrupt Spells --", SCRIPT_PARAM_INFO, "")
		if enemyCount > 0 then
			for i = 1, enemyCount do
				local unit = enemyHeroes[i]
				if Interrupt[unit.charName] ~= nil then
					for i, spell in pairs(Interrupt[unit.charName].stop) do
						menu.interrupt:addParam("" .. unit.charName, "" .. unit.charName, SCRIPT_PARAM_INFO, "") 
						menu.interrupt:addParam(spell.spellName,"" .. spell.name, SCRIPT_PARAM_ONOFF, true)
						menu.interrupt:addParam("empty", "", SCRIPT_PARAM_INFO,"")
					end 
				end
			end
		end
		menu.interrupt:addParam("settings", "                -- Settings --", SCRIPT_PARAM_INFO, "")
		menu.interrupt:addParam("rinterrupt", "Use R", SCRIPT_PARAM_ONOFF, true)
		
	menu:addSubMenu("[" .. myHero.charName .. "] - Draw Settings", "draw")
		menu.draw:addParam("spelldraws", "                -- Spell Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawq", "Draw Q", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colorq", "Color Q", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("draww", "Draw W", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colorw", "Color W", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })      
		menu.draw:addParam("drawe", "Draw E", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colore", "Color E", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawr", "Draw R", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colorr", "Color R", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("miscellaneousdraws", "                -- Flash Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawrflash", "Draw Flash - R", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorrflash", "Color Flash - R", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawitem", "                -- Item Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawfotm", "Draw Face of the Mountain", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorfotm", "Color Face of the Mountain", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawlois", "Draw Locket of the Iron Solari", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorlois", "Color Locket of the Iron Solari", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawmikaels", "Draw Mikaels Crucible", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorqmikaels", "Color Mikaels Crucible", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 }) 
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawsumm", "                -- Summoner Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawexhaust", "Draw Exhaust", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorexhaust", "Color Exhaust", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawheal", "Draw Heal", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorheal", "Color Heal", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawignite", "Draw Ignite", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorignite", "Color Ignite", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })  
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("miscellaneousdraws", "            -- Miscellaneous Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawtarget", "Draw Target", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("drawpermashow", "Draw Permashow (Reload)", SCRIPT_PARAM_ONOFF, true)
			
	menu:addSubMenu("[" .. myHero.charName .. "] - Farm Settings", "farm")
		menu.farm:addParam("laneclear", "                    -- Lane Clear --", SCRIPT_PARAM_INFO, "")
		menu.farm:addParam("elaneclear", "Use E", SCRIPT_PARAM_ONOFF, true)
		menu.farm:addParam("eclearmana", "Minimum Mana", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		
	menu:addSubMenu("[" .. myHero.charName .. "] - Flash Settings", "flash")
		menu.flash:addParam("rflash", "Use Flash - R", SCRIPT_PARAM_ONOFF, true)
	
	menu:addSubMenu("[" .. myHero.charName .. "] - Humanizer", "humanizer")
		menu.humanizer:addParam("interruptDelay", "Auto-Interrupt Delay (ms)", SCRIPT_PARAM_SLICE, 200, 0, 500, 0)
		menu.humanizer:addParam("snareDelay", "Auto-CC Delay (ms)", SCRIPT_PARAM_SLICE, 0, 0, 500, 0)
		menu.humanizer:addParam("shieldDelay", "Auto Shield Delay (ms)", SCRIPT_PARAM_SLICE, 50, 0, 500, 0)
			
	menu:addSubMenu("[" .. myHero.charName .. "] - Key Settings", "key")
		menu.key:addParam("combatkeys", "               -- Combat Keys --", SCRIPT_PARAM_INFO, "")
		menu.key:addParam("comboKey", "Combo Key", SCRIPT_PARAM_ONKEYDOWN, false, 32)
		menu.key:addParam("harassKey", "Harass Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
		menu.key:addParam("harassToggle", "Harass Toggle", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("T"))
		menu.key:addParam("clearKey", "Lane Clear Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
		menu.key:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.key:addParam("miscellaneouskeys", "           -- Miscellaneous Keys --", SCRIPT_PARAM_INFO, "")
		menu.key:addParam("flashKey", "Flash Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("H"))
	
	menu:addSubMenu("[" .. myHero.charName .. "] - Spell Settings", "spell")
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - Q", "q")
		menu.spell.q:addParam("qcombo", "Combo", SCRIPT_PARAM_ONOFF, true)
		menu.spell.q:addParam("qcombomana", "[Combo] Mana > X%", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
		menu.spell.q:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.q:addParam("qharass", "Harass", SCRIPT_PARAM_ONOFF, true)
		menu.spell.q:addParam("qharassmana", "[Harass] Mana > X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)  
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - W", "w")
		menu.spell.w:addParam("wuse", "Use W On AA's", SCRIPT_PARAM_ONOFF, true)
		menu.spell.w:addParam("wmana", "Mana > X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - E", "e")
		menu.spell.e:addParam("ecombo", "Combo", SCRIPT_PARAM_ONOFF, true)
		menu.spell.e:addParam("ecombomana", "[Combo] Mana > X%", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
		menu.spell.e:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.e:addParam("eharass", "Harass", SCRIPT_PARAM_ONOFF, true)
		menu.spell.e:addParam("eharassmana", "[Harass] Mana > X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - R", "r")
		menu.spell.r:addParam("rcombo", "Combo", SCRIPT_PARAM_ONOFF, true)
		menu.spell.r:addParam("rcombomana", "[Combo] Mana > X%", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
		menu.spell.r:addParam("rmpty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.r:addParam("rharass", "Harass", SCRIPT_PARAM_ONOFF, true)
		menu.spell.r:addParam("rharassmana", "[Harass] Mana > X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		menu.spell.r:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.r:addParam("mindistance", "Min Enemy Distance", SCRIPT_PARAM_SLICE, 500, 0, 1000, 0)
		menu.spell.r:addParam("amountenemies", "Only Ult If X Enemies", SCRIPT_PARAM_SLICE, 2, 0, 5, 0)
		
   menu:addSubMenu("[" .. myHero.charName .. "] - Target Selector", "target")
		menu.target:addParam("targetinfo", "Default Target Select Is LeastCast", SCRIPT_PARAM_INFO, "")
		menu.target:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.target:addParam("focus", "Focus Selected Target", SCRIPT_PARAM_ONOFF, true)
		menu.target:addParam("sac", "Use SAC:R Target Instead", SCRIPT_PARAM_ONOFF, false)
		
   menu:addSubMenu("Orbwalk Settings", "orb")  
   
   UPL:AddToMenu(menu)
   
   menu:addParam("hc", "Prediction Hit Chance", SCRIPT_PARAM_SLICE, 2, 0, 5, 0)
 
   menu:addParam("empty", "", SCRIPT_PARAM_INFO, "")
   menu:addParam("infobox", "            Support Heroes: " .. myHero.charName .. "           ", SCRIPT_PARAM_INFO, "")
   menu:addParam("infobox2", "                      Version:  " .. scriptVersion .. "         ", SCRIPT_PARAM_INFO, "")
   
   if menu.draw.drawpermashow then
	 menu:permaShow("infobox")
	 menu.key:permaShow("comboKey")
	 menu.key:permaShow("harassKey")
	 menu.key:permaShow("harassToggle")
	 menu.key:permaShow("clearKey")
   end
end

function _Malphite:Combo()
	if Target == nil then return end
	if menu.key.comboKey then 
		if IsReady(_Q) and menu.spell.q.qcombo and (100 * myHero.mana / myHero.maxMana)>= menu.spell.q.qcombomana and (GetDistance(Target) < self.SpellQ.range) then
			if ValidTarget(Target) then
				CastSpell(_Q, Target)
			end
		end
		if IsReady(_E) and menu.spell.e.ecombo and (100 * myHero.mana / myHero.maxMana)>= menu.spell.e.ecombomana and (GetDistance(Target) < self.SpellE.range) then
			if ValidTarget(Target) then
				CastSpell(_E)
			end
		end
		if enemyCount > 0 then
			for i = 1, enemyCount do
			local unit = enemyHeroes[i]
				if IsReady(_R) and menu.spell.r.rcombo and (100 * myHero.mana / myHero.maxMana)>= menu.spell.r.rcombomana and (GetDistance(Target) < 1000) then
					if ValidTarget(Target) then
						local CastPosition, HitChance = UPL:Predict(_R, myHero, unit)	
						if HitChance >= menu.hc then
							local AOECastPosition, MainTargetHitChance, nTargets = VPred:GetCircularAOECastPosition(unit, 0.25, 300, 1000, 1500, myHero) 
							if nTargets >= menu.spell.r.amountenemies and GetDistance(unit) >= menu.spell.r.mindistance then
							CastSpell(_R, CastPosition.x, CastPosition.z)
							end                            
						end
					end
				end
			end
		end
	end
end

function _Malphite:FlashCombo()
	if Target == nil then return end
	if IsReady(sflash) and IsReady(_R) and GetDistance(Target) <= 425 + self.SpellR.range then
		if GetDistance(Target) < 425 then
			flashPos = myHero + (GetDistance(Target) - 50) * (Vector(Target) - Vector(myHero)):normalized()
		else
			flashPos = myHero + 425 * (Vector(Target) - Vector(myHero)):normalized()
		end
		if menu.key.flashKey then
			local CastPosition, HitChance = UPL:Predict(_R, flashPos, Target)		
			if HitChance >= 2 and type(CastPosition.x) == "number" and type(CastPosition.z) == "number" then
				flashPos = myHero + 425 * (Vector(CastPosition) - Vector(myHero)):normalized()
				CastSpell(sflash, flashPos.x, flashPos.z)
				_Tech:FlashComboPosition(_R, CastPosition.x, CastPosition.z)
			end
		end
	end
	if menu.key.flashKey and IsReady(sflash) and IsReady(_R) then
		myHero:MoveTo(mousePos.x, mousePos.z)
	end
end

function _Malphite:Harass()
	if Target == nil then return end
	if menu.key.harassKey or menu.key.harassToggle then 
		if IsReady(_Q) and menu.spell.q.qharass and (100 * myHero.mana / myHero.maxMana)>= menu.spell.q.qharassmana and (GetDistance(Target) < self.SpellQ.range) then
			if ValidTarget(Target) then
				CastSpell(_Q, Target)
			end
		end
		if IsReady(_E) and menu.spell.e.eharass and (100 * myHero.mana / myHero.maxMana)>= menu.spell.e.eharassmana and (GetDistance(Target) < self.SpellE.range) then
			if ValidTarget(Target) then
				CastSpell(_E)
			end
		end
		if enemyCount > 0 then
			for i = 1, enemyCount do
			local unit = enemyHeroes[i]
				if IsReady(_R) and menu.spell.r.rharass and (100 * myHero.mana / myHero.maxMana)>= menu.spell.r.rharassmana and (GetDistance(Target) < 1000) then
					if ValidTarget(Target) then
						local CastPosition, HitChance = UPL:Predict(_R, myHero, unit)	
						if HitChance >= menu.hc then
							local AOECastPosition, MainTargetHitChance, nTargets = VPred:GetCircularAOECastPosition(unit, 0.25, 300, 1000, 1500, myHero) 
							if nTargets >= menu.spell.r.amountenemies and GetDistance(unit) >= menu.spell.r.mindistance then
							CastSpell(_R, CastPosition.x, CastPosition.z)
							end                            
						end
					end
				end
			end
		end
	end
end

function _Malphite:Interrupt()
	if not myHero.dead and myHero.team ~= unit.team then
	   if Interrupt[unit.charName] ~= nil then
		   if Interrupt[unit.charName].stop[unit.spellName] ~= nil then
				if menu.interrupt[spell.name] then
					if IsReady(_R) and menu.interrupt.rinterrupt and (GetDistance(unit) < 1000 ) then 
						DelayAction(function() CastSpell(_R, unit) end, menu.humanizer.interruptDelay / 1000)
					end
				end
		   end
	   end
	end
end

function _Malphite:LaneClear()
	for i, Minion in pairs(enemyMinions.objects) do
		if (Minion ~= nil) then
			if menu.key.clearKey then 
				if IsReady(_E) and menu.farm.elaneclear and (100 * myHero.mana / myHero.maxMana)>= menu.farm.eclearmana then
					CastSpell(_E)
				end
			end
		end
	end                
end

function _Malphite:OnDraw()
	if Target == nil then return end
	if menu.draw.drawtarget and ValidTarget(Target) and Target.type == myHero.type then
		_Tech:DrawCircle(Target.x, Target.y, Target.z, 150, ARGB(255, 255, 0, 0))
	end
	if menu.draw.drawrflash and menu.flash.rflash and IsReady(sflash) and IsReady(_R) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, (1000 + 425), ARGB(table.unpack(menu.draw.colorrflash)))
	end
	local slot = _Tech:CustomGetInventorySlotItem("HealthBomb", myHero)
	if menu.draw.drawfotm and slot ~= nil and IsReady(slot) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 750, ARGB(table.unpack(menu.draw.colorfotm))) 
	end
	local slot = _Tech:CustomGetInventorySlotItem("IronStylus", myHero)
	if menu.draw.drawlois and slot ~= nil and IsReady(slot) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 750, ARGB(table.unpack(menu.draw.colorlois))) 
	end
	local slot = _Tech:CustomGetInventorySlotItem("ItemMorellosBane", myHero)
	if menu.draw.drawmikaels and slot ~= nil and IsReady(slot) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 750, ARGB(table.unpack(menu.draw.colormikaels))) 
	end
	if menu.draw.drawexhaust and sexhaust ~= nil and IsReady(sexhaust) then 
	   _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 650, ARGB(table.unpack(menu.draw.colorexhaust))) 
	end
	if menu.draw.drawheal and sheal ~= nil and IsReady(sheal) then 
	   _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 850, ARGB(table.unpack(menu.draw.colorheal))) 
	end
	if menu.draw.drawignite and signite ~= nil and IsReady(signite) then 
	   _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 600, ARGB(table.unpack(menu.draw.colorignite))) 
	end
	if menu.draw.drawq and IsReady(_Q) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, self.SpellQ.range, ARGB(table.unpack(menu.draw.colorq)))
	end
	if menu.draw.draww and IsReady(_W) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, self.SpellW.range, ARGB(table.unpack(menu.draw.colorw)))
	end
	if menu.draw.drawe and IsReady(_E) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, self.SpellE.range, ARGB(table.unpack(menu.draw.colore)))
	end
	if menu.draw.drawr and IsReady(_R) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 1000, ARGB(table.unpack(menu.draw.colorr)))
	end
end 

function _Malphite:ProcessAttack(object,spell) 
	if Target == nil then return end
	if IsReady(_W) and spell.target and GetDistance(Target) <= self.SpellW.range then	
		if object.team == TEAM_ENEMY and spell.name:lower():find("attack") then
			if spell.target.type == myHero.type then 
				if (100 * myHero.mana / myHero.maxMana) >= menu.spell.w.wmana and menu.spell.w.wuse then
				CastSpell(_W)	 
				end
			end
		end 
	end
end 

function _Malphite:TowerCC()
	if Target == nil then return end
	for i = 1, enemyCount do
	local unit = enemyHeroes[i]
		for i = 1, towerCount do
			local tower = towers[i]
			if tower and tower.team == myHero.team and (GetDistance(tower, unit) <= 775) then
				if menu.snare.qsnare and menu.snare["" ..unit.charName] then
					CastSpell(_Q, unit)
				end
			end
		end
	end
end

Class("_Morgana")
function _Morgana:__init()
	self:LoadVariables()
	self:Menu()

	_Tech:AddTurrets()
	towerCount = #towers
	_Bundle:SetupOrbwalk()
	_Activator:__init()

	AddTickCallback(function() self:OnTick() end)
	AddDrawCallback(function() self:OnDraw() end)
	AddProcessAttackCallback(function(object, spell) self:ProcessAttack(object, spell) end)
	enemyMinions = minionManager(MINION_ENEMY, 625, myHero, MINION_SORT_HEALTH_DES)
	
	_Bundle:Print(myHero.charName .. " Loaded, Good Luck!")
end

function _Morgana:LoadVariables()
	self.SpellQ = { speed = 1200, delay = 0.25, range = 1175, width = 80, collision = true, aoe = false, type = "linear"}
	self.SpellW = { speed = math.huge, delay = 0.25, range = 900, width = 175, collision = false, aoe = true, type = "circular"}
	self.SpellE = { delay = 0.25, range = 700}
	self.SpellR = { delay = 0.5, range = 600 } --600 Cast Range, 1050 Thether range

	UPL:AddSpell(_Q, self.SpellQ)
	UPL:AddSpell(_W, self.SpellW) --Not really needed, but should not impact FPS
end

function _Morgana:OnTick()
	self:TowerCC()
	self:Combo()
	self:Harras()
	self:LaneClear()
	self:AutoW()
end

function _Morgana:OnDraw()
	if menu == nil then return end 
	if menu.draw.drawq and IsReady(_Q) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, self.SpellQ.range, ARGB(table.unpack(menu.draw.colorq)))
	end
	if menu.draw.draww and IsReady(_W) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, self.SpellW.range, ARGB(table.unpack(menu.draw.colorw)))
	end
	if menu.draw.drawe and IsReady(_E) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, self.SpellE.range, ARGB(table.unpack(menu.draw.colore)))
	end
	if menu.draw.drawr and IsReady(_R) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, self.SpellR.range, ARGB(table.unpack(menu.draw.colorr)))
	end
	if Target == nil then return end
	if menu.draw.drawtarget and ValidTarget(Target) and Target.type == myHero.type then
		_Tech:DrawCircle(Target.x, Target.y, Target.z, 150, ARGB(255, 255, 0, 0))
	end
	local slot = _Tech:CustomGetInventorySlotItem("HealthBomb", myHero)
	if menu.draw.drawfotm and slot ~= nil and IsReady(slot) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 750, ARGB(table.unpack(menu.draw.colorfotm))) 
	end
	local slot = _Tech:CustomGetInventorySlotItem("IronStylus", myHero)
	if menu.draw.drawlois and slot ~= nil and IsReady(slot) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 750, ARGB(table.unpack(menu.draw.colorlois))) 
	end
	local slot = _Tech:CustomGetInventorySlotItem("ItemMorellosBane", myHero)
	if menu.draw.drawmikaels and slot ~= nil and IsReady(slot) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 750, ARGB(table.unpack(menu.draw.colormikaels))) 
	end
	if menu.draw.drawexhaust and sexhaust ~= nil and IsReady(sexhaust) then 
	   _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 650, ARGB(table.unpack(menu.draw.colorexhaust))) 
	end
	if menu.draw.drawheal and sheal ~= nil and IsReady(sheal) then 
	   _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 850, ARGB(table.unpack(menu.draw.colorheal))) 
	end
	if menu.draw.drawignite and signite ~= nil and IsReady(signite) then 
	   _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 600, ARGB(table.unpack(menu.draw.colorignite))) 
	end
end

function _Morgana:Menu()
	menu = scriptConfig("Support Heroes", "SupportHeroesMenuMorgana")
	_Activator:Menu()

	menu:addSubMenu("[" .. myHero.charName .. "] - Auto-CC Under Tower", "snare")
		menu.snare:addParam("info", "           -- Auto-CC Enemies --", SCRIPT_PARAM_INFO, "")
		if enemyCount > 0 then
			for i = 1, enemyCount do
			local unit = enemyHeroes[i]			
				menu.snare:addParam("" .. unit.charName, "" .. unit.charName, SCRIPT_PARAM_ONOFF, true)
			end
		end
		menu.snare:addParam("settings", "                    -- Settings --", SCRIPT_PARAM_INFO, "")
		menu.snare:addParam("qsnare", "Use Q", SCRIPT_PARAM_ONOFF, true)
		

	menu:addSubMenu("[" .. myHero.charName .. "] - Auto-Shield", "as")
		for i = 1, heroManager.iCount do
			local unit = heroManager:GetHero(i)
			if unit.team == myHero.team then
				menu.as:addParam("teammateshield"..i, "Shield "..unit.charName, SCRIPT_PARAM_ONOFF, true)
				menu.as:addParam("maxhppercent"..i, "Shield If < X% HP", SCRIPT_PARAM_SLICE, 80, 0, 100, 0)
				menu.as:addParam("empty", "", SCRIPT_PARAM_INFO,"")
			end 
		end	
			menu.as:addParam("mindmgpercent", "Min dmg percent", SCRIPT_PARAM_SLICE, 10, 0, 100, 0)
			menu.as:addParam("shieldcc", "Shield CC", SCRIPT_PARAM_ONOFF, true)
			menu.as:addParam("shieldslow", "Shield Slows", SCRIPT_PARAM_ONOFF, true)
			menu.as:addParam("skillshots", "Shield Skillshots", SCRIPT_PARAM_ONOFF, false)
	
	menu:addSubMenu("[" .. myHero.charName .. "] - Draw Settings", "draw")
		menu.draw:addParam("spelldraws", "                -- Spell Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawq", "Draw Q", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colorq", "Color Q", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("draww", "Draw W", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colorw", "Color W", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawe", "Draw E", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colore", "Color E", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawr", "Draw R", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colorr", "Color R", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawitem", "                -- Item Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawfotm", "Draw Face of the Mountain", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorfotm", "Color Face of the Mountain", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawlois", "Draw Locket of the Iron Solari", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorlois", "Color Locket of the Iron Solari", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawmikaels", "Draw Mikaels Crucible", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorqmikaels", "Color Mikaels Crucible", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 }) 
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawsumm", "                -- Summoner Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawexhaust", "Draw Exhaust", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorexhaust", "Color Exhaust", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawheal", "Draw Heal", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorheal", "Color Heal", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawignite", "Draw Ignite", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorignite", "Color Ignite", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })  
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("miscellaneousdraws", "            -- Miscellaneous Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawtarget", "Draw Target", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("drawpermashow", "Draw Permashow (Reload)", SCRIPT_PARAM_ONOFF, true)
	
	menu:addSubMenu("[" .. myHero.charName .. "] - Farm Settings", "farm")
		menu.farm:addParam("laneclear", "                    -- Lane Clear --", SCRIPT_PARAM_INFO, "")
		menu.farm:addParam("wlaneclear", "Use W", SCRIPT_PARAM_ONOFF, true)
		menu.farm:addParam("wclearmana", "Minimum Mana", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		menu.farm:addParam("wminminions", "Minimum Minions", SCRIPT_PARAM_SLICE, 3, 1, 6, 0)
	
	menu:addSubMenu("[" .. myHero.charName .. "] - Humanizer", "humanizer")
		menu.humanizer:addParam("interruptDelay", "Auto-Interrupt Delay (ms)", SCRIPT_PARAM_SLICE, 200, 0, 500, 0)
		menu.humanizer:addParam("snareDelay", "Auto-CC Delay (ms)", SCRIPT_PARAM_SLICE, 0, 0, 500, 0)
		menu.humanizer:addParam("shieldDelay", "Auto Shield Delay (ms)", SCRIPT_PARAM_SLICE, 50, 0, 500, 0)
	
	menu:addSubMenu("[" .. myHero.charName .. "] - Key Settings", "key")
		menu.key:addParam("combatkeys", "               -- Combat Keys --", SCRIPT_PARAM_INFO, "")
		menu.key:addParam("comboKey", "Combo Key", SCRIPT_PARAM_ONKEYDOWN, false, 32)
		menu.key:addParam("harassKey", "Harass Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
		menu.key:addParam("harassToggle", "Harass Toggle", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("T"))
		menu.key:addParam("clearKey", "Lane Clear Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))

	menu:addSubMenu("[" .. myHero.charName .. "] - Spell Settings", "spell")
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - Q", "q")
		menu.spell.q:addParam("qcombo", "Combo", SCRIPT_PARAM_ONOFF, true)
		menu.spell.q:addParam("qcombomana", "[Combo] Mana > X%", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
		menu.spell.q:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.q:addParam("qharass", "Harass", SCRIPT_PARAM_ONOFF, true)
		menu.spell.q:addParam("qharassmana", "[Harass] Mana > X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)   
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - W", "w")
		menu.spell.w:addParam("wcombo", "Combo", SCRIPT_PARAM_ONOFF, true)
		menu.spell.w:addParam("wcombomana", "[Combo] Mana > X%", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
		menu.spell.w:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.w:addParam("wharass", "Harass", SCRIPT_PARAM_ONOFF, true)
		menu.spell.w:addParam("wharassmana", "[Harass] Mana > X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		menu.spell.w:addParam("empty", "", SCRIPT_PARAM_INFO, "")
        menu.spell.w:addParam("wauto","[Automatic] W If Q Hit", SCRIPT_PARAM_ONOFF, true)
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - E", "e")
		menu.spell.e:addParam("info", "Check Auto Shield For Settings", SCRIPT_PARAM_INFO, "")
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - R", "r")
		menu.spell.r:addParam("rcombo", "Combo", SCRIPT_PARAM_ONOFF, true)
		menu.spell.r:addParam("rcombomana", "[Combo] Mana > X%", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
		menu.spell.r:addParam("rcombominenemies", "[Combo] Min #Enemies", SCRIPT_PARAM_SLICE, 3, 1, 5, 0)
		menu.spell.r:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.r:addParam("rharass", "Harass", SCRIPT_PARAM_ONOFF, true)
		menu.spell.r:addParam("rharassmana", "[Harass] Mana > X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		menu.spell.r:addParam("rharassminenemies", "[Harass] Min #Enemies", SCRIPT_PARAM_SLICE, 3, 1, 5, 0)
	
	 menu:addSubMenu("[" .. myHero.charName .. "] - Target Selector", "target")
		menu.target:addParam("targetinfo", "Default Target Select Is LeastCast", SCRIPT_PARAM_INFO, "")
		menu.target:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.target:addParam("focus", "Focus Selected Target", SCRIPT_PARAM_ONOFF, true)
		menu.target:addParam("sac", "Use SAC:R Target Instead", SCRIPT_PARAM_ONOFF, false)
		
   menu:addSubMenu("Orbwalk Settings", "orb")  
   
   UPL:AddToMenu(menu)
   
   menu:addParam("hc", "Prediction Hit Chance", SCRIPT_PARAM_SLICE, 2, 0, 5, 0)
 
   menu:addParam("empty", "", SCRIPT_PARAM_INFO, "")
   menu:addParam("infobox", "            Support Heroes: " .. myHero.charName .. "           ", SCRIPT_PARAM_INFO, "")
   menu:addParam("infobox2", "                      Version:  " .. scriptVersion .. "         ", SCRIPT_PARAM_INFO, "")
   
   if menu.draw.drawpermashow then
	 menu:permaShow("infobox")
	 menu.key:permaShow("comboKey")
	 menu.key:permaShow("harassKey")
	 menu.key:permaShow("harassToggle")
	 menu.key:permaShow("clearKey")
   end
end

function _Morgana:TowerCC()
	if not Target then return end
	for i = 1, enemyCount do
	local unit = enemyHeroes[i]	
		for i = 1, towerCount do
			local tower = towers[i]
			if tower and tower.team == myHero.team and (GetDistance(tower, unit) < 775) then
				if menu.snare.qsnare and menu.snare["" ..unit.charName] and (GetDistance(unit) < self.SpellQ.range) then
					local CastPosition, HitChance, HeroPosition = UPL:Predict(_Q, myHero, unit)		
					if HitChance >= menu.hc then
						CastSpell(_Q, CastPosition.x,CastPosition.z)
					end
				end
			end
		end
	end
end

function _Morgana:Combo()
	if not menu.key.comboKey then return end
	if IsReady(_Q) and menu.spell.q.qcombo and Target and (100 * myHero.mana / myHero.maxMana )>= menu.spell.q.qcombomana and GetDistance(Target) < self.SpellQ.range then
		local CastPosition, HitChance, HeroPosition = UPL:Predict(_Q, myHero, Target)
		if HitChance >= menu.hc then 
			CastSpell(_Q, CastPosition.x, CastPosition.z)
		end
	end

	if IsReady(_W) and menu.spell.w.wcombo and Target and (100 * myHero.mana / myHero.maxMana) >= menu.spell.w.wcombomana and GetDistance(Target) < self.SpellW.range then
		local CastPosition, HitChance, HeroPosition = UPL:Predict(_W, myHero, Target)
		if HitChance >= menu.hc then 
			CastSpell(_W, CastPosition.x, CastPosition.z)
		end
	end

	if IsReady(_R) and menu.spell.r.rcombo and (100 * myHero.mana / myHero.maxMana)>= menu.spell.r.rcombomana then
		if CountEnemyHero(myHero, self.SpellR.range) >= menu.spell.r.rcombominenemies then
			CastSpell(_R, myHero)
		end
	end
end


function _Morgana:Harras()
	if not menu.key.harassKey and not menu.key.harassToggle then return end
	if IsReady(_Q) and menu.spell.q.qharass and Target and (100 * myHero.mana / myHero.maxMana)>= menu.spell.q.qharassmana and GetDistance(Target) < self.SpellQ.range then
		local CastPosition, HitChance, HeroPosition = UPL:Predict(_Q, myHero, Target)
		if HitChance >= menu.hc then 
			CastSpell(_Q, CastPosition.x, CastPosition.z)
		end
	end

	if IsReady(_W) and menu.spell.w.wharass and Target and (100 * myHero.mana / myHero.maxMana)>= menu.spell.w.wharassmana and GetDistance(Target) < self.SpellW.range then
		local CastPosition, HitChance, HeroPosition = UPL:Predict(_W, myHero, Target)
		if HitChance >= menu.hc then 
			CastSpell(_W, CastPosition.x, CastPosition.z)
		end
	end

	if IsReady(_R) and menu.spell.r.rharass and (100 * myHero.mana / myHero.maxMana)>= menu.spell.r.rharassmana then
		if CountEnemyHero(myHero, self.SpellR.range) >= menu.spell.r.rharassminenemies then
			CastSpell(_R, myHero)
		end
	end
end


function _Morgana:LaneClear()
	if enemyMinions == nil then return end
	if not menu.key.clearKey then return end
	local iMinions = 0
	for i, Minion in pairs(enemyMinions.objects) do
		if (Minion ~= nil) then
			iMinions = iMinions + 1
			if IsReady(_W) and iMinions > menu.farm.wminminions and menu.farm.wlaneclear and (100 * myHero.mana / myHero.maxMana)>= menu.farm.wclearmana and GetDistance(Minion) < self.SpellW.range then
				CastSpell(_W, Minion.x, Minion.z)
			end
		end       
	end
end

function _Morgana:AutoW()
	if not IsReady(_W) then return end
	for _, v in pairs(GetEnemyHeroes()) do
		if ValidTarget(v, self.SpellW.range) then
			for i=1, v.buffCount do
				local b = v:getBuff(i)
				if BuffIsValid(b) and b.name:find("DarkBinding") then
					CastSpell(_W, v)
				end
			end
		end
	end
end

function _Morgana:ProcessAttack(object,spell)
	if object.team ~= myHero.team and not myHero.dead and object.name ~= nil and not (object.name:find("Minion_") or object.name:find("Odin")) then
		local shieldREADY = IsReady(_W)
		local HitFirst = false
		local shieldtarget,SLastDistance,SLastDmgPercent = nil,nil,nil
		local ulttarget,ULastDistance,ULastDmgPercent = nil,nil,nil
		
		YWall, BShield, SShield, Shield, CC = false, false, false, false
		shottype, radius, maxdistance = 0, 0, 0
		
		if object.type == "AIHeroClient" then
			spelltype, casttype = getSpellType(object, spell.name)
			if casttype == 4 or casttype == 5 or casttype == 6 then
				return
			end
		   
			Shield = true
			
				if spelltype == "Q" or spelltype == "W" or spelltype == "E" or spelltype == "R" or spelltype == "P" or spelltype == "QM" or spelltype == "WM" or spelltype == "EM" then
					if skillShield[object.charName] == nil then return end
                    HitFirst = skillShield[object.charName][spelltype].HitFirst
					YWall = skillShield[object.charName][spelltype].YWall
					BShield = skillShield[object.charName][spelltype].BShield
					SShield = skillShield[object.charName][spelltype].SShield
					Shield = skillShield[object.charName][spelltype].Shield
					CC = skillShield[object.charName][spelltype].CC
					shottype = skillData[object.charName][spelltype].type
					radius = skillData[object.charName][spelltype].radius
					maxdistance = skillData[object.charName][spelltype].maxdistance
				else
					Shield = true
				end
			
				for i = 1, heroManager.iCount do
				local allytarget = heroManager:GetHero(i)
					if spell.target and spell.target.networkID == allytarget.networkID then
						if allytarget.team == myHero.team and not allytarget.dead and 0 < allytarget.health and allytarget.type == myHero.type then
							hitchampion = false
							local allyHitBox = allytarget.boundingRadius
							if shottype == 0 then
							hitchampion = spell.target and spell.target.networkID == allytarget.networkID
							elseif shottype == 1 then
							hitchampion = checkhitlinepass(object, spell.endPos, radius, maxdistance, allytarget, allyHitBox)
							elseif shottype == 2 then
							hitchampion = checkhitlinepoint(object, spell.endPos, radius, maxdistance, allytarget, allyHitBox)
							elseif shottype == 3 then
							hitchampion = checkhitaoe(object, spell.endPos, radius, maxdistance, allytarget, allyHitBox)
							elseif shottype == 4 then
							hitchampion = checkhitcone(object, spell.endPos, radius, maxdistance, allytarget, allyHitBox)
							elseif shottype == 5 then
							hitchampion = checkhitwall(object, spell.endPos, radius, maxdistance, allytarget, allyHitBox)
							elseif shottype == 6 then
							hitchampion = checkhitlinepass(object, spell.endPos, radius, maxdistance, allytarget, allyHitBox) or checkhitlinepass(object, Vector(object) * 2 - spell.endPos, radius, maxdistance, allytarget, allyHitBox)
							elseif shottype == 7 then
							hitchampion = checkhitcone(spell.endPos, object, radius, maxdistance, allytarget, allyHitBox)              
							end
							if shieldREADY and menu.as["teammateshield" .. i] and GetDistance(allytarget) <= self.SpellW.range then
							local shieldflag, dmgpercent = self:shieldCheck(object,spell,allytarget,"shields")
								if shieldflag then
									if HitFirst and (SLastDistance == nil or SLastDistance >= GetDistance(allytarget, object)) then
										shieldtarget, SLastDistance = allytarget, GetDistance(allytarget, object)
									elseif not HitFirst and (SLastDmgPercent == nil or SLastDmgPercent <= dmgpercent) then
										shieldtarget, SLastDmgPercent = allytarget, dmgpercent
									end
								end
							end
						end
					end
				if shieldtarget ~= nil then
					DelayAction(function() CastSpell(_E, shieldtarget) end, menu.humanizer.shieldDelay / 1000)
				end
			end
		end
	end
end

function _Morgana:shieldCheck(object,spell,target,typeused)
	if Target == nil then return end
	if typeused == "shields" then
	  local shieldflag = false
	  if not menu.as.skillshots and shottype ~= 0 then
		return false, 0
	  end
	  local adamage = object:CalcDamage(target, object.totalDamage)
	  local InfinityEdge,onhitdmg,onhittdmg,onhitspelldmg,onhitspelltdmg,muramanadmg,skilldamage,skillTypeDmg = 0,0,0,0,0,0,0,0
	  if object.type ~= "AIHeroClient" then
	  elseif spelltype == "BAttack" then
		skilldamage = (adamage+onhitdmg+muramanadmg)*1.07+onhittdmg
	  elseif spelltype == "CAttack" then
	  elseif spelltype == "Q" or spelltype == "W" or spelltype == "E" or spelltype == "R" or spelltype == "P" or spelltype == "QM" or spelltype == "WM" or spelltype == "EM" then
		if not skillShield[object.charName][spelltype].Muramana or not muramanadmg then
		  muramanadmg = 0
		end
		if casttype == 1 then
		  skilldamage, skillTypeDmg = getDmg(spelltype, target, object, 1, spell.level)
		elseif casttype == 2 then
		  skilldamage, skillTypeDmg = getDmg(spelltype, target, object, 2, spell.level)
		elseif casttype == 3 then
		  skilldamage, skillTypeDmg = getDmg(spelltype, target, object, 3, spell.level)
		end
		if skillTypeDmg == 2 then
		  skilldamage = (skilldamage + adamage + onhitspelldmg + onhitdmg + muramanadmg)* 1.07 + onhittdmg + onhitspelltdmg
		elseif skilldamage > 0 then
		  skilldamage = (skilldamage + onhitspelldmg + muramanadmg)* 1.07 + onhitspelltdmg
		end
	  elseif spell.name:find("SummonerDot") then
		skilldamage = getDmg("IGNITE", target, object)
	  end
			  for i = 1, heroManager.iCount do
				local ally = heroManager:GetHero(i)
				if ally.team == myHero.team then 
			  local dmgpercent = skilldamage * 100 / target.health
			  local dmgneeded = dmgpercent >= menu.as.mindmgpercent
			  local hpneeded =  menu.as["maxhppercent"..i] >= (target.health - skilldamage) * 100 / target.maxHealth
				  if dmgneeded and hpneeded then
					  shieldflag = true
				  elseif (typeused == "shields" or typeused == "wall") and (CC == 2 and menu.as.shieldCC or CC == 1 and menu.as.shieldslow) then
					  shieldflag = true
				  end
				  return shieldflag, dmgpercent
				  end
			  end
		  end
	  end

Class("_Nami")
function _Nami:__init()
	self:LoadVariables()
	self.Menu()

	_Bundle:SetupOrbwalk()
	_Activator:__init()

	AddTickCallback(function() self:OnTick() end)
	AddDrawCallback(function() self:OnDraw() end)
	AddProcessAttackCallback(function(object, spell) self:ProcessAttack(object, spell) end)
	AddRemoveBuffCallback(function(unit, buff) self:RemoveBuff(unit, buff) end)
	AddApplyBuffCallback(function(unit, target, buff) self:ApplyBuff(unit, target, buff) end)

	enemyMinions = minionManager(MINION_ENEMY, 625, myHero, MINION_SORT_HEALTH_DES)
	
	_Bundle:Print(myHero.charName .. " Loaded, Good Luck!")
end

function _Nami:LoadVariables()
	self.SpellQ = { speed = math.huge, delay = 0.925, range = 875, width = 162, collision = false, aoe = true, type = "circular"}
	self.SpellW = { delay = 0.25, range = 725}
	self.SpellE = { delay = 0.25, range = 800}
	self.SpellR = { speed = 859, delay = 0.25, range = 2750, width = 562, collision = false, aoe = true, type = "linear"}
	
	UPL:AddSpell(_Q, self.SpellQ)
	UPL:AddSpell(_R, self.SpellR)
end

function _Nami:OnTick()
	self:AutoHeal()
	self:Combo()
	self:Harras()
	self:LaneClear()
    self:Marathon()
end

function _Nami:OnDraw()
	if menu == nil then return end
	if Target == nil then return end
	if menu.draw.drawtarget and ValidTarget(Target) and Target.type == myHero.type then
		_Tech:DrawCircle(Target.x, Target.y, Target.z, 150, ARGB(255, 255, 0, 0))
	end
	local slot = _Tech:CustomGetInventorySlotItem("HealthBomb", myHero)
	if menu.draw.drawfotm and slot ~= nil and IsReady(slot) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 750, ARGB(table.unpack(menu.draw.colorfotm))) 
	end
	local slot = _Tech:CustomGetInventorySlotItem("IronStylus", myHero)
	if menu.draw.drawlois and slot ~= nil and IsReady(slot) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 750, ARGB(table.unpack(menu.draw.colorlois))) 
	end
	local slot = _Tech:CustomGetInventorySlotItem("ItemMorellosBane", myHero)
	if menu.draw.drawmikaels and slot ~= nil and IsReady(slot) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 750, ARGB(table.unpack(menu.draw.colormikaels))) 
	end
	if menu.draw.drawexhaust and sexhaust ~= nil and IsReady(sexhaust) then 
	   _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 650, ARGB(table.unpack(menu.draw.colorexhaust))) 
	end
	if menu.draw.drawheal and sheal ~= nil and IsReady(sheal) then 
	   _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 850, ARGB(table.unpack(menu.draw.colorheal))) 
	end
	if menu.draw.drawignite and signite ~= nil and IsReady(signite) then 
	   _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 600, ARGB(table.unpack(menu.draw.colorignite))) 
	end
	if menu.draw.drawq and IsReady(_Q) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, self.SpellQ.range, ARGB(table.unpack(menu.draw.colorq)))
	end
	if menu.draw.draww and IsReady(_W) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, self.SpellW.range, ARGB(table.unpack(menu.draw.colorw)))
	end
	if menu.draw.draww and IsReady(_E) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, self.SpellE.range, ARGB(table.unpack(menu.draw.colore)))
	end
	if menu.draw.drawr and IsReady(_R) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, self.SpellR.range, ARGB(table.unpack(menu.draw.colorr)))
	end
end

function _Nami:Menu()
	menu = scriptConfig("Support Heroes", "SupportHeroesMenuNami")
	_Activator:Menu()

	menu:addSubMenu("[" .. myHero.charName .. "] - Auto-Heal", "ah")
		for i = 1, heroManager.iCount do
		local unit = heroManager:GetHero(i)
			if unit.team == myHero.team then  
			menu.ah:addParam("heal" .. unit.charName, "" .. unit.charName, SCRIPT_PARAM_ONOFF, true) 
			menu.ah:addParam("maxhppercent"..i, "Heal Until HP = X%", SCRIPT_PARAM_SLICE, 75, 0, 100, 0) 
			menu.ah:addParam("empty", "", SCRIPT_PARAM_INFO,"")
			end
		end
		menu.ah:addParam("healmana", "Heal If Mana >X%", SCRIPT_PARAM_SLICE, 45, 0, 100, 0)
		
	menu:addSubMenu("["..myHero.charName.."] - Auto-Interrupt", "interrupt")
		menu.interrupt:addParam("spells", "           -- Auto Interrupt Spells --", SCRIPT_PARAM_INFO, "")
		if enemyCount > 0 then
			for i = 1, enemyCount do
				local unit = enemyHeroes[i]
				if Interrupt[unit.charName] ~= nil then
					for i, spell in pairs(Interrupt[unit.charName].stop) do
						menu.interrupt:addParam("" .. unit.charName, "" .. unit.charName, SCRIPT_PARAM_INFO, "") 
						menu.interrupt:addParam(spell.spellName,"" .. spell.name, SCRIPT_PARAM_ONOFF, true)
						menu.interrupt:addParam("empty", "", SCRIPT_PARAM_INFO,"")
					end 
				end
			end
		end
		menu.interrupt:addParam("settings", "                -- Settings --", SCRIPT_PARAM_INFO, "")
		menu.interrupt:addParam("qinterrupt", "Use Q", SCRIPT_PARAM_ONOFF, true)

	menu:addSubMenu("[" .. myHero.charName .. "] - Draw Settings", "draw")
		menu.draw:addParam("spelldraws", "                -- Spell Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawq", "Draw Q", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colorq", "Color Q", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("draww", "Draw W", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colorw", "Color W", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawe", "Draw E", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colore", "Color E", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawr", "Draw R", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colorr", "Color R", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawitem", "                -- Item Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawfotm", "Draw Face of the Mountain", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorfotm", "Color Face of the Mountain", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawlois", "Draw Locket of the Iron Solari", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorlois", "Color Locket of the Iron Solari", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawmikaels", "Draw Mikaels Crucible", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorqmikaels", "Color Mikaels Crucible", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 }) 
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawsumm", "                -- Summoner Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawexhaust", "Draw Exhaust", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorexhaust", "Color Exhaust", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawheal", "Draw Heal", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorheal", "Color Heal", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawignite", "Draw Ignite", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorignite", "Color Ignite", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })  
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("miscellaneousdraws", "            -- Miscellaneous Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawtarget", "Draw Target", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("drawpermashow", "Draw Permashow (Reload)", SCRIPT_PARAM_ONOFF, true)

	menu:addSubMenu("[" .. myHero.charName .. "] - Farm Settings", "farm")
		menu.farm:addParam("laneclear", "                    -- Lane Clear --", SCRIPT_PARAM_INFO, "")
		menu.farm:addParam("qlaneclear", "Use Q", SCRIPT_PARAM_ONOFF, true)
		menu.farm:addParam("qclearmana", "Minimum Mana", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
        menu.farm:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.farm:addParam("elaneclear", "Use E", SCRIPT_PARAM_ONOFF, true)
		menu.farm:addParam("eclearmana", "Minimum Mana", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		menu.farm:addParam("eminminion", "Min Minions To Use E", SCRIPT_PARAM_SLICE, 2, 0, 10, 0)
		
	menu:addSubMenu("[" .. myHero.charName .. "] - Humanizer", "humanizer")
		menu.humanizer:addParam("interruptDelay", "Auto-Interrupt Delay (ms)", SCRIPT_PARAM_SLICE, 200, 0, 500, 0)
		menu.humanizer:addParam("shieldDelay", "Auto Shield Delay (ms)", SCRIPT_PARAM_SLICE, 50, 0, 500, 0)
		
	menu:addSubMenu("[" .. myHero.charName .. "] - Key Settings", "key")
		menu.key:addParam("combatkeys", "               -- Combat Keys --", SCRIPT_PARAM_INFO, "")
		menu.key:addParam("comboKey", "Combo Key", SCRIPT_PARAM_ONKEYDOWN, false, 32)
		menu.key:addParam("harassKey", "Harass Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
		menu.key:addParam("harassToggle", "Harass Toggle", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("T"))
		menu.key:addParam("clearKey", "Lane Clear Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
        menu.key:addParam("miscellaneouskeys", "           -- Miscellaneous Keys --", SCRIPT_PARAM_INFO, "")
		menu.key:addParam("marathonKey", "Marathon Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("Y"))

	menu:addSubMenu("[" .. myHero.charName .. "] - Spell Settings", "spell")
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - Q", "q")
		menu.spell.q:addParam("qcombo", "Combo", SCRIPT_PARAM_ONOFF, true)
		menu.spell.q:addParam("qcombomana", "[Combo] Mana > X%", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
		menu.spell.q:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.q:addParam("qharass", "Harass", SCRIPT_PARAM_ONOFF, true)
		menu.spell.q:addParam("qharassmana", "[Harass] Mana > X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
	
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - W", "w")
		menu.spell.w:addParam("wcombo", "Combo", SCRIPT_PARAM_ONOFF, true)
		menu.spell.w:addParam("wcombomana", "[Combo] Mana > X%", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
		menu.spell.w:addParam("wmpty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.w:addParam("wharass", "Harass", SCRIPT_PARAM_ONOFF, true)
		menu.spell.w:addParam("wharassmana", "[Harass] Mana > X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)

		menu.spell:addSubMenu("[" .. myHero.charName .. "] - E", "e")
		menu.spell.e:addParam("ecombo", "Combo", SCRIPT_PARAM_ONOFF, true)
		menu.spell.e:addParam("ecombomana", "[Combo] Mana > X%", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
		menu.spell.e:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.e:addParam("eharass", "Harass", SCRIPT_PARAM_ONOFF, true)
		menu.spell.e:addParam("eharassmana", "[Harass] Mana > X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		menu.spell.e:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.e:addParam("minenemys", "Min Enemys in Range", SCRIPT_PARAM_SLICE, 2, 0, 5, 0)

		menu.spell:addSubMenu("[" .. myHero.charName .. "] - R", "r")
		menu.spell.r:addParam("rcombo", "Combo", SCRIPT_PARAM_ONOFF, true)
		menu.spell.r:addParam("rcombomana", "[Combo] Mana > X%", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
		menu.spell.r:addParam("rminenemyscombo", "[Combo] Min Enemys Hit ", SCRIPT_PARAM_SLICE, 3, 0, 5, 0)
		menu.spell.r:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.r:addParam("rharass", "Harass", SCRIPT_PARAM_ONOFF, true)
		menu.spell.r:addParam("rharassmana", "[Harass] Mana > X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		menu.spell.r:addParam("rminenemysharass", "[Harass] Min Enemys Hit ", SCRIPT_PARAM_SLICE, 4, 0, 5, 0)

	menu:addSubMenu("[" .. myHero.charName .. "] - Target Selector", "target")
		menu.target:addParam("targetinfo", "Default Target Select Is LeastCast", SCRIPT_PARAM_INFO, "")
		menu.target:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.target:addParam("focus", "Focus Selected Target", SCRIPT_PARAM_ONOFF, true)
		menu.target:addParam("sac", "Use SAC:R Target Instead", SCRIPT_PARAM_ONOFF, false)

	menu:addSubMenu("Orbwalk Settings", "orb")  
   
	UPL:AddToMenu(menu)
   
	menu:addParam("hc", "Prediction Hit Chance", SCRIPT_PARAM_SLICE, 2, 0, 5, 0)
 
	menu:addParam("empty", "", SCRIPT_PARAM_INFO, "")
	menu:addParam("infobox", "            Support Heroes: " .. myHero.charName .. "           ", SCRIPT_PARAM_INFO, "")
	menu:addParam("infobox2", "                      Version:  " .. scriptVersion .. "         ", SCRIPT_PARAM_INFO, "")
   
	if menu.draw.drawpermashow then
		menu:permaShow("infobox")
		menu.key:permaShow("comboKey")
		menu.key:permaShow("harassKey")
		menu.key:permaShow("harassToggle")
		menu.key:permaShow("clearKey")
        menu.key:permaShow("marathonKey")
   end
end

function _Nami:ApplyBuff(unit, target, buff)
	if unit ~= nil and buff and unit.isMe and buff.name:lower() == "recall" or buff.name:lower() == "summonerteleport" or buff.name:lower() == "recallimproved" then buffs["recall"] = true end
end

function _Nami:RemoveBuff(unit, buff)
	if unit ~= nil and buff and unit.isMe and buff.name:lower() == "recall" or buff.name:lower() == "summonerteleport" or buff.name:lower() == "recallimproved" then buffs["recall"] = false end
end

function _Nami:AutoHeal()
	for i = 1, heroManager.iCount do
		local unit = heroManager:GetHero(i)
		if unit.team == myHero.team then 
			if not InFountain() and not buffs["recall"] then 
				if unit.team == myHero.team and unit.type == myHero.type and menu.ah["heal" ..unit.charName] and (100*unit.health/unit.maxHealth) < menu.ah["maxhppercent"..i] and (100 * myHero.mana / myHero.maxMana)>= menu.ah.healmana then
					if IsReady(_W) and (GetDistance(unit) < self.SpellW.range) then 
						CastSpell(_W, unit)         
					end
				end    
			end
		end
	end
end 

function _Nami:Marathon()
    if menu.key.marathonKey then
        if IsReady(_E) then 
            CastSpell(_E, myHero)
        end
		myHero:MoveTo(mousePos.x, mousePos.z)
    end	
end

function _Nami:ProcessAttack(object,spell)
	if not myHero.dead and myHero.team ~= object.team then
		if Interrupt[object.charName] ~= nil then
			if Interrupt[object.charName].stop[spell.name] ~= nil then
				if menu.interrupt[spell.name] then
					if IsReady(_Q) and menu.interrupt.winterrupt then
						DelayAction(function() 
							local CastPosition, HitChance, HeroPosition = UPL:Predict(_Q, myHero, object)
							if HitChance >= 2 then
								CastSpell(_Q, CastPosition.x, CastPosition.z) 
							end
						end, menu.humanizer.interruptDelay / 1000)
					end
				end
		   end
	   end
	end
end 

function _Nami:Combo()
	if not menu.key.comboKey then return end

	if Target and IsReady(_Q) and menu.spell.q.qcombo and (100 * myHero.mana / myHero.maxMana)>= menu.spell.q.qcombomana and (GetDistance(Target) < self.SpellQ.range) then
		if ValidTarget(Target) then
			local CastPosition, HitChance, HeroPosition = UPL:Predict(_Q, myHero, Target)
			if HitChance >= menu.hc then 
				CastSpell(_Q, CastPosition.x, CastPosition.z)
			end
		end
	end

	if Target and IsReady(_W) and menu.spell.w.ecombo and (100 * myHero.mana / myHero.maxMana)>= menu.spell.w.ecombomana then
		CastSpell(_W, Target)
	end

	if IsReady(_E) and menu.spell.e.ecombo and (100 * myHero.mana / myHero.maxMana)>= menu.spell.e.ecombomana then
		if CountEnemyHero(myHero, self.SpellE.range+500) >= menu.spell.e.minenemys then
			local target = self:GetETarget()
			if target then
				CastSpell(_E, target)
			end
		end
	end

	if IsReady(_R) and menu.spell.r.rcombo and (100 * myHero.mana / myHero.maxMana)>= menu.spell.r.rcombomana then
		local target, hits = self:GetRTarget()
		if target and hits >= menu.spell.r.rminenemyscombo then
			CastSpell(_R, target.x, target.z)
		end
	end
end

function _Nami:Harras()
	if not menu.key.harassKey then return end

	if Target and IsReady(_Q) and menu.spell.q.qharass and (100 * myHero.mana / myHero.maxMana)>= menu.spell.q.qharassmana and (GetDistance(Target) < self.SpellQ.range) then
		if ValidTarget(Target) then
			local CastPosition, HitChance, HeroPosition = UPL:Predict(_Q, myHero, Target)
			if HitChance >= menu.hc then 
				CastSpell(_Q, CastPosition.x, CastPosition.z)
			end
		end
	end

	if Target and IsReady(_W) and menu.spell.w.eharass and (100 * myHero.mana / myHero.maxMana)>= menu.spell.w.eharassmana then
		CastSpell(_W, Target)
	end

	if IsReady(_E) and menu.spell.e.eharass and (100 * myHero.mana / myHero.maxMana)>= menu.spell.e.eharassmana then
		if CountEnemyHero(myHero, self.SpellE.range+500) >= menu.spell.e.minenemys then
			local target = self:GetETarget()
			if target then
				CastSpell(_E, target)
			end
		end
	end

	if IsReady(_R) and menu.spell.r.rharass and (100 * myHero.mana / myHero.maxMana)>= menu.spell.r.rharassmana then
		local target, hits = self:GetRTarget()
		if target and hits >= menu.spell.r.rminenemysharass then
			CastSpell(_R, target.x, target.z)
		end
	end
end

function _Nami:GetRTarget()
	local target = nil
	for _,v in pairs(GetEnemyHeroes()) do
		if GetDistance(v) < self.SpellR.range then
			if v and not v.dead and ValidTarget(v) then
				CastPosition, HitChance, HeroPosition = UPL:Predict(_R, v)
				if HitChance >= menu.hc then
					target = v
				end
			end
		end
	end
	local eiu = 0
	if target then
		eiu = self:GetHeroesInUlt(target)
	end
	return target, eiu
end

function _Nami:GetHeroesInUlt(target)
	local enemysInUlt = 1
	if GetDistance(target) < 2750 and not target.dead and ValidTarget(target) then
		local x1, y1, z1 = myHero.x, myHero.y, myHero.z
		local x2, y2, z2 = target.x, target.y, target.z
		local o = { x = ((z2 - z1)*-1), z = x2 - x1 }
		local len = math.sqrt(o.x ^ 2 + o.z ^ 2)
		o.x, o.z = o.x / len * 562 / 2, o.z / len * 562 / 2
		local points = {
			{x1 + o.x, y1, z1 + o.z},
			{x1 - o.x, y1, z1 - o.z},
			{x2 + o.x, y2, z2 + o.z},
			{x2 - o.x, y2, z2 - o.z},			
			{x1 + o.x, y1, z1 + o.z},
		}
		local X1 = {x = points[1][1], y = points[1][3]}
		local X2 = {x = points[2][1], y = points[2][3]}
		local X3 = {x = points[3][1], y = points[3][3]}
		local X4 = {x = points[4][1], y = points[4][3]}
		
		function PointInRec(a,b,c,d, pt)
			local PointinT1 = false
			local PointinT2 = false
		
			function PointInTriangle(pt, v1, v2, v3)
				function sign(p1, p2, p3)
					return (p1.x - p3.x) * (p2.y - p3.y) - (p2.x - p3.x) * (p1.y - p3.y)
				end

				local b1, b2, b3 = false, false, false
				if sign(pt, v1, v2) < 0 then b1 = true end
				if sign(pt, v2, v3) < 0 then b2 = true end
				if sign(pt, v3, v1) < 0 then b3 = true end

				if ((b1 == b2) and (b2 == b3)) then return true end
			end
			PointinT1 = PointInTriangle(pt, a,b,c)
			PointinT2 = PointInTriangle(pt, a,d,c)
			if PointinT1 or PointinT2 then return true end
		end

		local a = X1
		local b = X2
		local c = X3
		local d = X4
			for _, v2 in pairs(GetEnemyHeroes()) do
			if GetDistance(v2) < 2750 and not v2.dead and ValidTarget(v2)  then
				local pt = {x = v2.x, y = v2.z}
				if target.networkID ~= v2.networkID then
					if PointInRec(a,b,c,d,pt) then
						enemysInUlt = enemysInUlt + 1
					end
				end
			end
		end		
	end
	return enemysInUlt
end

function _Nami:GetETarget()
	local target = nil
	for _,v in pairs(GetAllyHeroes()) do
		if GetDistance(v) < self.SpellE.range then
			if v and not v.dead and (100 * v.health / v.maxHealth) > 10 then
				target = v
			end
		end
	end
	if not target then target = myHero end
	return target
end

function _Nami:LaneClear()
	if enemyMinions == nil then return end
	if not menu.key.clearKey then return end

	local iMinions = 0

	for i, Minion in pairs(enemyMinions.objects) do
		if (Minion ~= nil) then
			if IsReady(_Q) and menu.farm.qlaneclear and (100 * myHero.mana / myHero.maxMana)>= menu.farm.qclearmana and GetDistance(Minion) < self.SpellQ.range then
				local CastPosition, HitChance, HeroPosition = UPL:Predict(_Q, myHero, Minion)
				if HitChance >= menu.hc then 
					CastSpell(_Q, CastPosition.x, CastPosition.z)
				end
			end
			if IsReady(_E) and GetDistance(Minion) < self.SpellE.range and menu.farm.elaneclear and (100 * myHero.mana / myHero.maxMana)>= menu.farm.eclearmana then
				iMinions = iMinions + 1
				if iMinions > menu.farm.eminminion then
					CastSpell(_E, myHero)
				end
			end
		end       
	end
end

Class ("_PentagonRot")
function _PentagonRot:__init(object, color, thickness, size,version)
	self.VisionVector = nil
	self.object = object
	self.color = color 
	self.thickness = thickness
	self.size = size
	self.version = version
	--AddDrawCallback(function ()
		--self:DrawHexagonRot(self.object, self.color, self.thickness, self.size,self.version)
	--end)
end


function _PentagonRot:DrawHexagonRot(object, color, thickness, size)
	local function CalcVisionVector(source)
		local vV = Vector(myHero.visionPos.x,myHero.visionPos.y,myHero.visionPos.z)
		local hV = Vector(myHero.x,myHero.y,myHero.z)
		local vec = vV-hV
		local vec2 = vec:normalized()
		return vec2
	end

	local function CalcZeroVector(source)
		local V = Vector(myHero.x, myHero.y, myHero.z)
		local V2 = Vector(myHero.x+100, myHero.y, myHero.z)
		local vec = V-V2
		local vec2 = vec:normalized()
		return vec2
	end

	local function CalcAngle(vector1, vector2)
		local angle = math.atan2(vector1.z-vector2.z, vector1.x-vector2.x)
		return angle
	end

	if CalcVisionVector(myHero).x < 5000 then
		self.VisionVector = CalcVisionVector(myHero)
		self.VisionVector = self.VisionVector*100
	end
	local ZeroVector = CalcZeroVector(myHero)*100
	local rot = 0
	if self.VisionVector and ZeroVector then
		rot = CalcAngle(self.VisionVector,ZeroVector)
	end

	local pi = 3.14159
	if not object then object = myHero end
	if not color then color = menu.spell.r.colorr end
	if not thickness then thickness = 3 end
	if not size then size = 450 end
	local X, Y, Z = object.x, object.y, object.z
	local RX1, RZ1 = a2v((rot), size)
	local RX2, RZ2 = a2v((rot)+pi*0.2, size)
	local RX3, RZ3 = a2v((rot)+pi*0.4, size)
	local RX4, RZ4 = a2v((rot)+pi*0.6, size)
	local RX5, RZ5 = a2v((rot)+pi*0.8, size)

	local PX1 = X+RX1
	local PZ1 = Z+RZ1

	local PX2 = X+RX2
	local PZ2 = Z+RZ2

	local PX3 = X+RX3
	local PZ3 = Z+RZ3

	local PX4 = X+RX4
	local PZ4 = Z+RZ4

	local PX5 = X+RX5
	local PZ5 = Z+RZ5	



	local PXT1 = X-(PX1-X)
	local PZT1 = Z-(PZ1-Z)

	local PXT2 = X-(PX2-X)
	local PZT2 = Z-(PZ2-Z)

	local PXT3 = X-(PX3-X)
	local PZT3 = Z-(PZ3-Z)

	local PXT4 = X-(PX4-X)
	local PZT4 = Z-(PZ4-Z)

	local PXT5 = X-(PX5-X)
	local PZT5 = Z-(PZ5-Z)

	--[[======Version 1=======]]--
	if version == 1 then
		DrawLine3D(PX1, Y, PZ1, PX3, Y, PZ3, thickness, color)
		DrawLine3D(PX3, Y, PZ3, PX5, Y, PZ5, thickness, color)
		DrawLine3D(PX5, Y, PZ5, PXT2, Y, PZT2, thickness, color)
		DrawLine3D(PXT2, Y, PZT2, PXT4, Y, PZT4, thickness, color)
		DrawLine3D(PXT4, Y, PZT4, PX1, Y, PZ1, thickness, color)
	else
	--[[======Version 2=======]]--
		DrawLine3D(PX2, Y, PZ2, PX4, Y, PZ4, thickness, color)
		DrawLine3D(PX4, Y, PZ4, PXT1, Y, PZT1, thickness, color)
		DrawLine3D(PXT1, Y, PZT1, PXT3, Y, PZT3, thickness, color)
		DrawLine3D(PXT3, Y, PZT3, PXT5, Y, PZT5, thickness, color)
		DrawLine3D(PXT5, Y, PZT5, PX2, Y, PZ2, thickness, color)
	end
end

Class("_Sona")
local passivecount = 0
buffs["SonaPassiveReady"] = false

function _Sona:__init()
	self:LoadVariables()
	self:Menu()
	
	_Bundle:SetupOrbwalk()
	
	_Activator:__init()
	
	_Tech:AddTurrets()
	towerCount = #towers
	
	AddTickCallback(function() self:OnTick() end)
	AddDrawCallback(function() self:OnDraw() end)
	AddRemoveBuffCallback(function(unit, buff) self:RemoveBuff(unit, buff) end)
    AddUpdateBuffCallback(function(unit, buff) self:OnUpdateBuff(unit, buff) end)
	AddApplyBuffCallback(function(unit, target, buff) self:ApplyBuff(unit, target, buff) end)
	AddProcessAttackCallback(function(object, spell) self:ProcessAttack(object, spell) end)
	
	enemyMinions = minionManager(MINION_ENEMY, 365, myHero, MINION_SORT_HEALTH_DES)
    
	_Bundle:Print(myHero.charName .. " Loaded, Good Luck!")
end

function _Sona:LoadVariables()
	self.SpellQ = { speed = math.huge, delay = 0.5, range = 825, width = 100, collision = false, aoe = true, type = "circular" }

	self.SpellW = { speed = 1000, delay = 0.55, range = 1000, width = nil, collision = true, aoe = false, type = "linear" }

	self.SpellE = { speed = nil, delay = 0.5, range = 360, width = nil, collision = false, aoe = true, type = "circular" }

	self.SpellR = { speed = math.huge, delay = 0.25, range = 900, width = 300, collision = false, aoe = true, type = "linear" }
    
    self.SpellAura = { range = 400}
	
	UPL:AddSpell(_R, self.SpellR)
end

function _Sona:OnTick()
   if menu == nil then return end
   
	self:AutoHeal()
	self:Combo()
	self:FlashCombo()
	self:Harass() 
	self:LaneClear()
    self:Marathon()
	self:TowerCC()
    
    self:Man()
end

function _Sona:Menu()
	menu = scriptConfig("Support Heroes", "SupportHeroesMenuSona")
	
	_Activator:Menu()
 
	menu:addSubMenu("[" .. myHero.charName .. "] - Auto-Heal", "ah")
		for i = 1, heroManager.iCount do
		local unit = heroManager:GetHero(i)
			if unit.team == myHero.team then  
			menu.ah:addParam("heal" .. unit.charName, "" .. unit.charName, SCRIPT_PARAM_ONOFF, true) 
			menu.ah:addParam("maxhppercent"..i, "Heal Until HP = X%", SCRIPT_PARAM_SLICE, 75, 0, 100, 0) 
			menu.ah:addParam("empty", "", SCRIPT_PARAM_INFO,"")
			end
		end
		menu.ah:addParam("healmana", "Heal If Mana >X%", SCRIPT_PARAM_SLICE, 45, 0, 100, 0)
				 
	menu:addSubMenu("[" .. myHero.charName .. "] - Auto-CC Under Tower", "snare")
		menu.snare:addParam("info", "           -- Auto-CC Enemies --", SCRIPT_PARAM_INFO, "")
		if enemyCount > 0 then
			for i = 1, enemyCount do
			local unit = enemyHeroes[i]			
				menu.snare:addParam("" .. unit.charName, "" .. unit.charName, SCRIPT_PARAM_ONOFF, true)
			end
		end
		menu.snare:addParam("settings", "                    -- Settings --", SCRIPT_PARAM_INFO, "")
		menu.snare:addParam("rsnare", "Use R", SCRIPT_PARAM_ONOFF, true)
        menu.snare:addParam("rsnareamt", "Min Enemys Hit", SCRIPT_PARAM_SLICE, 4, 0, 5, 0)
		
	menu:addSubMenu("[" .. myHero.charName .. "] - Auto-Interrupt", "interrupt")   
		menu.interrupt:addParam("spells", "           -- Auto Interrupt Spells --", SCRIPT_PARAM_INFO, "")
		if enemyCount > 0 then
			for i = 1, enemyCount do
				local unit = enemyHeroes[i]
				if Interrupt[unit.charName] ~= nil then
					for i, spell in pairs(Interrupt[unit.charName].stop) do
						menu.interrupt:addParam("" .. unit.charName, "" .. unit.charName, SCRIPT_PARAM_INFO, "") 
						menu.interrupt:addParam(spell.spellName,"" .. spell.name, SCRIPT_PARAM_ONOFF, true)
						menu.interrupt:addParam("empty", "", SCRIPT_PARAM_INFO,"")
					end 
				end
			end
		end
		menu.interrupt:addParam("settings", "                    -- Settings --", SCRIPT_PARAM_INFO, "")
		menu.interrupt:addParam("rinterrupt", "Use R", SCRIPT_PARAM_ONOFF, true)
		
	menu:addSubMenu("[" .. myHero.charName .. "] - Draw Settings", "draw")
		menu.draw:addParam("spelldraws", "                -- Spell Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawq", "Draw Q", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colorq", "Color Q", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("draww", "Draw W", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colorw", "Color W", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawe", "Draw E", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colore", "Color E", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("miscellaneousdraws", "                -- Flash Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawrflash", "Draw Flash - R", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorrflash", "Color Flash - R", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")	
		menu.draw:addParam("drawitem", "                -- Item Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawfotm", "Draw Face of the Mountain", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorfotm", "Color Face of the Mountain", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawlois", "Draw Locket of the Iron Solari", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorlois", "Color Locket of the Iron Solari", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawmikaels", "Draw Mikaels Crucible", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colormikaels", "Color Mikaels Crucible", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 }) 
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawsumm", "                -- Summoner Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawexhaust", "Draw Exhaust", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorexhaust", "Color Exhaust", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawheal", "Draw Heal", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorheal", "Color Heal", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawignite", "Draw Ignite", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorignite", "Color Ignite", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 }) 
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")  
		menu.draw:addParam("miscellaneousdraws", "            -- Miscellaneous Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawtarget", "Draw Target", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("drawpermashow", "Draw Permashow (Reload)", SCRIPT_PARAM_ONOFF, true)
			
	menu:addSubMenu("[" .. myHero.charName .. "] - Farm Settings", "farm")
		menu.farm:addParam("laneclear", "                    -- Lane Clear --", SCRIPT_PARAM_INFO, "")
		menu.farm:addParam("qlaneclear", "Use Q", SCRIPT_PARAM_ONOFF, true)
		menu.farm:addParam("clearmana", "Minimum Mana", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		
	menu:addSubMenu("[" .. myHero.charName .. "] - Flash Settings", "flash")
		menu.flash:addParam("rflash", "Use Flash - R", SCRIPT_PARAM_ONOFF, false)
	
	menu:addSubMenu("[" .. myHero.charName .. "] - Humanizer", "humanizer")
		menu.humanizer:addParam("interruptDelay", "Auto-Interrupt Delay (ms)", SCRIPT_PARAM_SLICE, 200, 0, 500, 0)
		menu.humanizer:addParam("snareDelay", "Auto-CC Delay (ms)", SCRIPT_PARAM_SLICE, 0, 0, 500, 0)
		menu.humanizer:addParam("shieldDelay", "Auto Shield Delay (ms)", SCRIPT_PARAM_SLICE, 50, 0, 500, 0)
			
	menu:addSubMenu("[" .. myHero.charName .. "] - Key Settings", "key")
		menu.key:addParam("combatkeys", "               -- Combat Keys --", SCRIPT_PARAM_INFO, "")
		menu.key:addParam("comboKey", "Combo Key", SCRIPT_PARAM_ONKEYDOWN, false, 32)
		menu.key:addParam("harassKey", "Harass Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
		menu.key:addParam("harassToggle", "Harass Toggle", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("T"))
		menu.key:addParam("clearKey", "Lane Clear Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
		menu.key:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.key:addParam("miscellaneouskeys", "           -- Miscellaneous Keys --", SCRIPT_PARAM_INFO, "")
		menu.key:addParam("flashKey", "Flash Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("H"))
        menu.key:addParam("marathonKey", "Marathon Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("Y"))
	
	menu:addSubMenu("[" .. myHero.charName .. "] - Spell Settings", "spell")
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - Q", "q")
		menu.spell.q:addParam("qcombo", "Combo", SCRIPT_PARAM_ONOFF, true)
		menu.spell.q:addParam("qcombomana", "[Combo] Mana > X%", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
		menu.spell.q:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.q:addParam("qharass", "Harass", SCRIPT_PARAM_ONOFF, true)
		menu.spell.q:addParam("qharassmana", "[Harass] Mana > X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
        menu.spell.q:addParam("empty", "", SCRIPT_PARAM_INFO, "")
        for i = 1, allyCount do
	       local unit = allyHeroes[i] 
            menu.spell.q:addParam("name","                          "..unit.charName, SCRIPT_PARAM_INFO, "")
            menu.spell.q:addParam("qaura"..i, "[Aura] Q While AA'ing", SCRIPT_PARAM_ONOFF, true)
        end
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - W", "w")
		menu.spell.w:addParam("info", "Check Auto Heal For Settings", SCRIPT_PARAM_INFO, "")
        menu.spell.w:addParam("empty", "", SCRIPT_PARAM_INFO, "")
        for i = 1, heroManager.iCount do
		local unit = heroManager:GetHero(i)
		    if unit.team == myHero.team then 
            menu.spell.w:addParam("waura"..i, "[Aura] Shield "..unit.charName, SCRIPT_PARAM_ONOFF, true)
            end
        end       
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - E", "e")
		menu.spell.e:addParam("ecombo", "Combo", SCRIPT_PARAM_ONOFF, true)
		menu.spell.e:addParam("ecombomana", "[Combo] Mana > X%", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
		menu.spell.e:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.e:addParam("eharass", "Harass", SCRIPT_PARAM_ONOFF, true)
		menu.spell.e:addParam("eharassmana", "[Harass] Mana > X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
        menu.spell.e:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - R", "r")
		menu.spell.r:addParam("rcombo", "Combo", SCRIPT_PARAM_ONOFF, true)
		menu.spell.r:addParam("rcombomana", "[Combo] Mana > X%", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
        menu.spell.r:addParam("rminenemyscombo", "[Combo] Min Enemys Hit ", SCRIPT_PARAM_SLICE, 3, 0, 5, 0)        
		menu.spell.r:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.r:addParam("rharass", "Harass", SCRIPT_PARAM_ONOFF, true)
		menu.spell.r:addParam("rharassmana", "[Harass] Mana > X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
        menu.spell.r:addParam("rminenemysharass", "[Harass] Min Enemys Hit ", SCRIPT_PARAM_SLICE, 4, 0, 5, 0)
		
   menu:addSubMenu("[" .. myHero.charName .. "] - Target Selector", "target")
		menu.target:addParam("targetinfo", "Default Target Select Is LeastCast", SCRIPT_PARAM_INFO, "")
		menu.target:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.target:addParam("focus", "Focus Selected Target", SCRIPT_PARAM_ONOFF, true)
		menu.target:addParam("sac", "Use SAC:R Target Instead", SCRIPT_PARAM_ONOFF, false)
		
   menu:addSubMenu("Orbwalk Settings", "orb")  
   
   UPL:AddToMenu(menu)
   
   menu:addParam("hc", "Prediction Hit Chance", SCRIPT_PARAM_SLICE, 2, 0, 5, 0)
 
   menu:addParam("empty", "", SCRIPT_PARAM_INFO, "")
   menu:addParam("infobox", "            Support Heroes: " .. myHero.charName .. "           ", SCRIPT_PARAM_INFO, "")
   menu:addParam("infobox2", "                      Version:  " .. scriptVersion .. "         ", SCRIPT_PARAM_INFO, "")
   
   if menu.draw.drawpermashow then
	 menu:permaShow("infobox")
	 menu.key:permaShow("comboKey")
	 menu.key:permaShow("harassKey")
	 menu.key:permaShow("harassToggle")
	 menu.key:permaShow("clearKey")
     menu.key:permaShow("marathonKey")
   end
end

function _Sona:ApplyBuff(unit, target, buff)
	if unit and unit.isMe and buff then
        if buff.name == "SonaPassiveReady" then buffs["SonaPassiveReady"] = true end
    end
    if unit ~= nil and buff and unit.isMe and buff.name:lower() == "recall" or buff.name:lower() == "summonerteleport" or buff.name:lower() == "recallimproved" then buffs["recall"] = true end
end

function _Sona:AutoHeal()
	for i = 1, heroManager.iCount do
		local unit = heroManager:GetHero(i)
		if unit.team == myHero.team then 
			if not InFountain() and not buffs["recall"] then 
				if unit.team == myHero.team and unit.type == myHero.type and menu.ah["heal" ..unit.charName] and (100*unit.health/unit.maxHealth) < menu.ah["maxhppercent"..i] and (100 * myHero.mana / myHero.maxMana)>= menu.ah.healmana then
					if IsReady(_W) and (GetDistance(unit) < self.SpellW.range) then 
						CastSpell(_W)         
					end
				end    
			end
		end
	end
end 

function _Sona:Marathon()
    if menu.key.marathonKey then
        if IsReady(_E) then 
            CastSpell(_E, myHero)
        end
		myHero:MoveTo(mousePos.x, mousePos.z)
    end	
end        

function _Sona:Combo() 
	if Target == nil then return end
	if menu.key.comboKey then 
		if IsReady(_Q) and menu.spell.q.qcombo and (100 * myHero.mana / myHero.maxMana)>= menu.spell.q.qcombomana and (GetDistance(Target) < self.SpellQ.range) then
			if ValidTarget(Target) then
				CastSpell(_Q)
			end
		end
        if IsReady(_R) and (100 * myHero.mana / myHero.maxMana)>= menu.spell.r.rcombomana and (GetDistance(Target) < self.SpellR.range) then
            if ValidTarget(Target) then
                local CastPosition, HitChance, HeroPosition = UPL:Predict(_R, myHero, Target)
                local AOECastPosition, MainTargetHitChance, nTargets = VPred:GetCircularAOECastPosition(unit, self.SpellR.delay, 200, self.SpellR.range, self.SpellR.speed, myHero) 
				if nTargets >= menu.spell.r.rminenemyscombo and HitChance >= 2 then            
                    CastSpell(_R, CastPosition.x, CastPosition.y) 
                end
            end
        end 
	end       
end
 
function _Sona:FlashCombo()
	if Target == nil then return end
	if menu.key.flashKey and menu.flash.rflash then 
		if ValidTarget(Target) and (GetDistance(Target) <= 425 + self.SpellR.range) then
		   if IsReady(sflash) and IsReady(_R) then
			   local CastPosition, HitChance, HeroPosition = UPL:Predict(_R, myHero, Target)
               if HitChance >= 2 then 
                 CastSpell(sflash, Target.x, Target.z)      
			     CastSpell(_R, CastPosition.x, CastPosition.y)
		      end
           end	       
		end
	end
	if menu.key.flashKey and IsReady(sflash) then
		myHero:MoveTo(mousePos.x, mousePos.z)
	end
end
 
function _Sona:Harass() 
	if Target == nil then return end
	if menu.key.harassKey or menu.key.harassToggle then 
		if IsReady(_Q) and menu.spell.q.qharass and (100 * myHero.mana / myHero.maxMana)>= menu.spell.q.qharassmana and (GetDistance(Target) < self.SpellQ.range) then
			if ValidTarget(Target) then
				CastSpell(_Q)
			end
		end
        if IsReady(_R) and (100 * myHero.mana / myHero.maxMana)>= menu.spell.r.rharassmana and (GetDistance(Target) < self.SpellR.range) then
            if ValidTarget(Target) then
                local CastPosition, HitChance, HeroPosition = UPL:Predict(_R, myHero, Target)		
                local AOECastPosition, MainTargetHitChance, nTargets = VPred:GetCircularAOECastPosition(unit, self.SpellR.delay, self.SpellR.radius, self.SpellR.range, self.SpellR.speed, myHero) 
				if nTargets >= menu.spell.r.rminenemysharass and HitChance >= 2 then            
                    CastSpell(_R, CastPosition.x, CastPosition.y) 
                end
            end
        end 
	end       
end

function _Sona:LaneClear()
	if enemyMinions == nil then return end 
	for i, Minion in pairs(enemyMinions.objects) do
		if (Minion ~= nil) then
			if menu.key.clearKey then 
				if IsReady(_Q) and menu.farm.qlaneclear and (100 * myHero.mana / myHero.maxMana)>= menu.farm.clearmana then
					CastSpell(_Q, Minion)
				end
			end
		end
	end                
end 

function _Sona:OnDraw()
	if menu == nil then return end 
	if Target == nil then return end
	if menu.draw.drawtarget and ValidTarget(Target) and Target.type == myHero.type then
		_Tech:DrawCircle(Target.x, Target.y, Target.z, 150, ARGB(255, 255, 0, 0))
	end
	if menu.draw.drawqflash and menu.flash.qflash and IsReady(sflash) and IsReady(_Q) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, (self.SpellQ.range + 425), ARGB(table.unpack(menu.draw.colorqflash)))
	end
	local slot = _Tech:CustomGetInventorySlotItem("HealthBomb", myHero)
	if menu.draw.drawfotm and slot ~= nil and IsReady(slot) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 750, ARGB(table.unpack(menu.draw.colorfotm))) 
	end
	local slot = _Tech:CustomGetInventorySlotItem("IronStylus", myHero)
	if menu.draw.drawlois and slot ~= nil and IsReady(slot) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 750, ARGB(table.unpack(menu.draw.colorlois))) 
	end
	local slot = _Tech:CustomGetInventorySlotItem("ItemMorellosBane", myHero)
	if menu.draw.drawmikaels and slot ~= nil and IsReady(slot) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 750, ARGB(table.unpack(menu.draw.colormikaels))) 
	end
	if menu.draw.drawexhaust and sexhaust ~= nil and IsReady(sexhaust) then 
	   _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 650, ARGB(table.unpack(menu.draw.colorexhaust))) 
	end
	if menu.draw.drawheal and sheal ~= nil and IsReady(sheal) then 
	   _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 850, ARGB(table.unpack(menu.draw.colorheal))) 
	end
	if menu.draw.drawignite and signite ~= nil and IsReady(signite) then 
	   _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 600, ARGB(table.unpack(menu.draw.colorignite))) 
	end
	if menu.draw.drawq and IsReady(_Q) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, self.SpellQ.range, ARGB(table.unpack(menu.draw.colorq)))
	end
	if menu.draw.draww and IsReady(_W) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, self.SpellW.range, ARGB(table.unpack(menu.draw.colorw)))
	end
	if menu.draw.drawe and IsReady(_E) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, self.SpellE.range, ARGB(table.unpack(menu.draw.colore)))
	end
end
 
function _Sona:ProcessAttack(object,spell)
	for i = 1, heroManager.iCount do
		local allytarget = heroManager:GetHero(i)
		if allytarget.team == myHero.team then
            if IsReady(_Q) and spell.target and GetDistance(object) < self.SpellAura.range then
                if not object.dead and object.team == myHero.team and object.type == myHero.type and not object.isMe and spell.name:lower():find("attack") then
                    if spell.target.team ~= myHero.team and spell.target.type == myHero.type and menu.spell.q["qaura".. i] then 
                        DelayAction(function() CastSpell(_Q) end, menu.humanizer.shieldDelay / 1000)
                    end
                end
            end
		end
    end
    if not myHero.dead and myHero.team ~= object.team then
		if Interrupt[object.charName] ~= nil then
			if Interrupt[object.charName].stop[spell.name] ~= nil then
				if menu.interrupt[spell.name] then
					--if IsReady(_Q) and menu.interrupt.qinterrupt and GetDistance(object.charName) < 365 then 
						--DelayAction(function() CastSpell(_Q) end, menu.humanizer.interruptDelay / 1000)
					if IsReady(_R) and menu.interrupt.rinterrupt then
						DelayAction(function() CastSpell(_R, object) end, menu.humanizer.interruptDelay / 1000)
					end
				end
		   end
	   end
	end
    if object.team ~= myHero.team and not myHero.dead and object.name ~= nil and not (object.name:find("Minion_") or object.name:find("Odin")) then
		local shieldREADY = IsReady(_W)
		local HitFirst = false
		local shieldtarget,SLastDistance,SLastDmgPercent = nil,nil,nil
		local ulttarget,ULastDistance,ULastDmgPercent = nil,nil,nil
		
		YWall, BShield, SShield, Shield, CC = false, false, false, false
		shottype, radius, maxdistance = 0, 0, 0
		
		if object.type == "AIHeroClient" then
			spelltype, casttype = getSpellType(object, spell.name)
			if casttype == 4 or casttype == 5 or casttype == 6 then
				return
			end
		   
			Shield = true
			
				if spelltype == "Q" or spelltype == "W" or spelltype == "E" or spelltype == "R" or spelltype == "P" or spelltype == "QM" or spelltype == "WM" or spelltype == "EM" then
					if skillShield[object.charName] == nil then return end
                    HitFirst = skillShield[object.charName][spelltype].HitFirst
					YWall = skillShield[object.charName][spelltype].YWall
					BShield = skillShield[object.charName][spelltype].BShield
					SShield = skillShield[object.charName][spelltype].SShield
					Shield = skillShield[object.charName][spelltype].Shield
					CC = skillShield[object.charName][spelltype].CC
					shottype = skillData[object.charName][spelltype].type
					radius = skillData[object.charName][spelltype].radius
					maxdistance = skillData[object.charName][spelltype].maxdistance
				else
					Shield = true
				end
			
				for i = 1, heroManager.iCount do
				local allytarget = heroManager:GetHero(i)
					if spell.target and spell.target.networkID == allytarget.networkID then
						if allytarget.team == myHero.team and not allytarget.dead and 0 < allytarget.health and allytarget.type == myHero.type then
							hitchampion = false
							local allyHitBox = allytarget.boundingRadius
							if shottype == 0 then
							hitchampion = spell.target and spell.target.networkID == allytarget.networkID
							elseif shottype == 1 then
							hitchampion = checkhitlinepass(object, spell.endPos, radius, maxdistance, allytarget, allyHitBox)
							elseif shottype == 2 then
							hitchampion = checkhitlinepoint(object, spell.endPos, radius, maxdistance, allytarget, allyHitBox)
							elseif shottype == 3 then
							hitchampion = checkhitaoe(object, spell.endPos, radius, maxdistance, allytarget, allyHitBox)
							elseif shottype == 4 then
							hitchampion = checkhitcone(object, spell.endPos, radius, maxdistance, allytarget, allyHitBox)
							elseif shottype == 5 then
							hitchampion = checkhitwall(object, spell.endPos, radius, maxdistance, allytarget, allyHitBox)
							elseif shottype == 6 then
							hitchampion = checkhitlinepass(object, spell.endPos, radius, maxdistance, allytarget, allyHitBox) or checkhitlinepass(object, Vector(object) * 2 - spell.endPos, radius, maxdistance, allytarget, allyHitBox)
							elseif shottype == 7 then
							hitchampion = checkhitcone(spell.endPos, object, radius, maxdistance, allytarget, allyHitBox)              
							end
							if shieldREADY and menu.spell.w["waura" .. i] and GetDistance(allytarget) <= self.SpellW.range then
							local shieldflag, dmgpercent = self:shieldCheck(object,spell,allytarget,"shields")
								if shieldflag then
									if HitFirst and (SLastDistance == nil or SLastDistance >= GetDistance(allytarget, object)) then
										shieldtarget, SLastDistance = allytarget, GetDistance(allytarget, object)
									elseif not HitFirst and (SLastDmgPercent == nil or SLastDmgPercent <= dmgpercent) then
										shieldtarget, SLastDmgPercent = allytarget, dmgpercent
									end
								end
							end
						end
					end
				if shieldtarget ~= nil then
					DelayAction(function() CastSpell(_W) end, menu.humanizer.shieldDelay / 1000)
				end
			end
		end
	end
end

function _Sona:shieldCheck(object,spell,target,typeused)
	if Target == nil then return end
	if typeused == "shields" then
	  local shieldflag = false
	  if shottype ~= 0 then
		return false, 0
	  end
	  local adamage = object:CalcDamage(target, object.totalDamage)
	  local InfinityEdge,onhitdmg,onhittdmg,onhitspelldmg,onhitspelltdmg,muramanadmg,skilldamage,skillTypeDmg = 0,0,0,0,0,0,0,0
	  if object.type ~= "AIHeroClient" then
	  elseif spelltype == "BAttack" then
		skilldamage = (adamage+onhitdmg+muramanadmg)*1.07+onhittdmg
	  elseif spelltype == "CAttack" then
	  elseif spelltype == "Q" or spelltype == "W" or spelltype == "E" or spelltype == "R" or spelltype == "P" or spelltype == "QM" or spelltype == "WM" or spelltype == "EM" then
		if not skillShield[object.charName][spelltype].Muramana or not muramanadmg then
		  muramanadmg = 0
		end
		if casttype == 1 then
		  skilldamage, skillTypeDmg = getDmg(spelltype, target, object, 1, spell.level)
		elseif casttype == 2 then
		  skilldamage, skillTypeDmg = getDmg(spelltype, target, object, 2, spell.level)
		elseif casttype == 3 then
		  skilldamage, skillTypeDmg = getDmg(spelltype, target, object, 3, spell.level)
		end
		if skillTypeDmg == 2 then
		  skilldamage = (skilldamage + adamage + onhitspelldmg + onhitdmg + muramanadmg)* 1.07 + onhittdmg + onhitspelltdmg
		elseif skilldamage > 0 then
		  skilldamage = (skilldamage + onhitspelldmg + muramanadmg)* 1.07 + onhitspelltdmg
		end
	  elseif spell.name:find("SummonerDot") then
		skilldamage = getDmg("IGNITE", target, object)
	  end
			  for i = 1, heroManager.iCount do
				local ally = heroManager:GetHero(i)
				if ally.team == myHero.team then 
			  local dmgpercent = skilldamage * 100 / target.health
			  local dmgneeded = dmgpercent >= 20
			  local hpneeded =  15 >= (target.health - skilldamage) * 100 / target.maxHealth
				  if dmgneeded and hpneeded then
					  shieldflag = true
				  end
				  return shieldflag, dmgpercent
				  end
			  end
		  end
	  end 

function _Sona:RemoveBuff(unit, buff)
	if unit ~= nil and buff and unit.isMe and buff.name:lower() == "recall" or buff.name:lower() == "summonerteleport" or buff.name:lower() == "recallimproved" then buffs["recall"] = false end
    
	if unit and unit.isMe and buff then
        if buff.name == "SonaPassiveReady" then buffs["SonaPassiveReady"] = false end
    end
    
    if buff.name == "sonapassiveattack" then
		passivecount = 0
	end
end

function _Sona:OnUpdateBuff(unit, buff)
	if buff.name == "sonapassivecount" then
    print("Passivce")
		passive = passivecount + 1
	end
end 

function _Sona:Man()
    if InFountain() and not buffs["SonaPassiveReady"] then
    CastSpell(_Q)
    CastSpell(_W)
    CastSpell(_E)
    elseif InFountain() and buffs["SonaPassiveReady"] then
    end
end

function _Sona:TowerCC() 
	for i = 1, enemyCount do
	local unit = enemyHeroes[i]	
		for i = 1, towerCount do
			local tower = towers[i]
			if tower and tower.team == myHero.team and (GetDistance(tower, unit) < 775) then
				if menu.snare.rsnare and menu.snare["" ..unit.charName] and GetDistance(unit) < self.SpellR.range then
					local CastPosition, HitChance, HeroPosition = UPL:Predict(_R, myHero, Target)
		            if HitChance >= menu.hc then 
			            CastSpell(_R, CastPosition.x, CastPosition.z)
		            end      
				end
			end
		end
	end
end

Class("_Soraka")
function _Soraka:__init()
	self:LoadVariables()
    self:Menu()
    
	_Bundle:SetupOrbwalk()
    
    _Activator:__init()
	
	_Tech:AddTurrets()
    towerCount = #towers
	
	AddTickCallback(function() self:OnTick() end)
	AddDrawCallback(function() self:OnDraw() end)
    AddRemoveBuffCallback(function(unit, buff) self:RemoveBuff(unit, buff) end)
    AddApplyBuffCallback(function(unit, target, buff) self:ApplyBuff(unit, target, buff) end)
    AddProcessAttackCallback(function(object, spell) self:ProcessAttack(object, spell) end)
    
    enemyMinions = minionManager(MINION_ENEMY, self.SpellQ.range, myHero, MINION_SORT_HEALTH_DES)
	
	_Bundle:Print(myHero.charName .. " Loaded, Good Luck!")
end

function _Soraka:LoadVariables()
    self.SpellQ = { speed = math.huge, delay = 0.5, range = 810, width = 250, collision = false, aoe = true, type = "circular" }

    self.SpellW = { speed = 1000, delay = 0.55, range = 550, width = 500, collision = true, aoe = false, type = "linear" }

    self.SpellE = { speed = math.huge, delay = 0.5, range = 925, width = 250, collision = false, aoe = true, type = "circular" }

    self.SpellR = { speed = nil, delay = 0.25, range = 25000, width = nil, collision = false, aoe = false, type = "linear" }
    
    UPL:AddSpell(_Q, self.SpellQ)
    UPL:AddSpell(_E, self.SpellE)
end

function _Soraka:OnTick()
   if menu == nil then return end
   
    self:AutoHeal()
    self:AutoUlt()
	self:Combo()
	self:Harass() 
	self:LaneClear()
	self:TowerCC()
end

function _Soraka:Menu()
    menu = scriptConfig("Support Heroes", "SupportHeroesMenuSoraka")
    
    _Activator:Menu()
 
	menu:addSubMenu("[" .. myHero.charName .. "] - Auto-Heal", "ah")
        if allyCount > 0 then
        	for i = 1, allyCount do
            local unit = allyHeroes[i]	  
            menu.ah:addParam("healally" .. unit.charName, "" .. unit.charName, SCRIPT_PARAM_ONOFF, true) 
            menu.ah:addParam("maxhppercent"..i, "Heal Until HP = X%", SCRIPT_PARAM_SLICE, 75, 0, 100, 0) 
			menu.ah:addParam("empty", "", SCRIPT_PARAM_INFO,"")
            end
        end
        menu.ah:addParam("healmana", "Heal If Mana >X%", SCRIPT_PARAM_SLICE, 45, 0, 100, 0)
        menu.ah:addParam("healhealth", "Heal If Health >X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
                 
    menu:addSubMenu("[" .. myHero.charName .. "] - Auto-CC Under Tower", "snare")
		menu.snare:addParam("info", "           -- Auto-CC Enemies --", SCRIPT_PARAM_INFO, "")
        if enemyCount > 0 then
        	for i = 1, enemyCount do
            local unit = enemyHeroes[i]			
            	menu.snare:addParam("" .. unit.charName, "" .. unit.charName, SCRIPT_PARAM_ONOFF, true)
    		end
		end
		menu.snare:addParam("settings", "                    -- Settings --", SCRIPT_PARAM_INFO, "")
        menu.snare:addParam("esnare", "Use E", SCRIPT_PARAM_ONOFF, true)
		
	menu:addSubMenu("[" .. myHero.charName .. "] - Auto-Interrupt", "interrupt")   
        menu.interrupt:addParam("spells", "           -- Auto Interrupt Spells --", SCRIPT_PARAM_INFO, "")
        if enemyCount > 0 then
        	for i = 1, enemyCount do
            	local unit = enemyHeroes[i]
                if Interrupt[unit.charName] ~= nil then
					for i, spell in pairs(Interrupt[unit.charName].stop) do
                    	menu.interrupt:addParam("" .. unit.charName, "" .. unit.charName, SCRIPT_PARAM_INFO, "") 
				        menu.interrupt:addParam(spell.spellName,"" .. spell.name, SCRIPT_PARAM_ONOFF, true)
                        menu.interrupt:addParam("empty", "", SCRIPT_PARAM_INFO,"")
                    end 
                end
            end
        end
        menu.interrupt:addParam("settings", "                    -- Settings --", SCRIPT_PARAM_INFO, "")
        menu.interrupt:addParam("einterrupt", "Use E", SCRIPT_PARAM_ONOFF, true)
		
	menu:addSubMenu("[" .. myHero.charName .. "] - Draw Settings", "draw")
        menu.draw:addParam("spelldraws", "                -- Spell Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawq", "Draw Q", SCRIPT_PARAM_ONOFF, true)
        menu.draw:addParam("colorq", "Color Q", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
        menu.draw:addParam("draww", "Draw W", SCRIPT_PARAM_ONOFF, true)
        menu.draw:addParam("colorw", "Color W", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
        menu.draw:addParam("drawe", "Draw E", SCRIPT_PARAM_ONOFF, true)
        menu.draw:addParam("colore", "Color E", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")	
        menu.draw:addParam("drawitem", "                -- Item Draws --", SCRIPT_PARAM_INFO, "")
        menu.draw:addParam("drawfotm", "Draw Face of the Mountain", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorfotm", "Color Face of the Mountain", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
        menu.draw:addParam("drawlois", "Draw Locket of the Iron Solari", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorlois", "Color Locket of the Iron Solari", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
        menu.draw:addParam("drawmikaels", "Draw Mikaels Crucible", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colormikaels", "Color Mikaels Crucible", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 }) 
        menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
        menu.draw:addParam("drawsumm", "                -- Summoner Draws --", SCRIPT_PARAM_INFO, "")
        menu.draw:addParam("drawexhaust", "Draw Exhaust", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorexhaust", "Color Exhaust", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
        menu.draw:addParam("drawheal", "Draw Heal", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorheal", "Color Heal", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
        menu.draw:addParam("drawignite", "Draw Ignite", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorignite", "Color Ignite", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 }) 
        menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")  
        menu.draw:addParam("miscellaneousdraws", "            -- Miscellaneous Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawtarget", "Draw Target", SCRIPT_PARAM_ONOFF, true)
        menu.draw:addParam("drawpermashow", "Draw Permashow (Reload)", SCRIPT_PARAM_ONOFF, true)
        	
	menu:addSubMenu("[" .. myHero.charName .. "] - Farm Settings", "farm")
        menu.farm:addParam("laneclear", "                    -- Lane Clear --", SCRIPT_PARAM_INFO, "")
        menu.farm:addParam("qlaneclear", "Use Q", SCRIPT_PARAM_ONOFF, true)
        menu.farm:addParam("clearmana", "Minimum Mana", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
    
    menu:addSubMenu("[" .. myHero.charName .. "] - Humanizer", "humanizer")
        menu.humanizer:addParam("interruptDelay", "Auto-Interrupt Delay (ms)", SCRIPT_PARAM_SLICE, 200, 0, 500, 0)
        menu.humanizer:addParam("snareDelay", "Auto-CC Delay (ms)", SCRIPT_PARAM_SLICE, 0, 0, 500, 0)
        menu.humanizer:addParam("shieldDelay", "Auto Shield Delay (ms)", SCRIPT_PARAM_SLICE, 50, 0, 500, 0)
    		
	menu:addSubMenu("[" .. myHero.charName .. "] - Key Settings", "key")
        menu.key:addParam("combatkeys", "               -- Combat Keys --", SCRIPT_PARAM_INFO, "")
		menu.key:addParam("comboKey", "Combo Key", SCRIPT_PARAM_ONKEYDOWN, false, 32)
        menu.key:addParam("harassKey", "Harass Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
        menu.key:addParam("harassToggle", "Harass Toggle", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("T"))
        menu.key:addParam("clearKey", "Lane Clear Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
    
	menu:addSubMenu("[" .. myHero.charName .. "] - Spell Settings", "spell")
        menu.spell:addSubMenu("[" .. myHero.charName .. "] - Q", "q")
        menu.spell.q:addParam("qcombo", "Combo", SCRIPT_PARAM_ONOFF, true)
        menu.spell.q:addParam("qcombomana", "[Combo] Mana > X%", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
	    menu.spell.q:addParam("empty", "", SCRIPT_PARAM_INFO, "")
        menu.spell.q:addParam("qharass", "Harass", SCRIPT_PARAM_ONOFF, true)
        menu.spell.q:addParam("qharassmana", "[Harass] Mana > X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
        menu.spell:addSubMenu("[" .. myHero.charName .. "] - W", "w")
        menu.spell.w:addParam("info", "Check Auto Heal For Settings", SCRIPT_PARAM_INFO, "")
        menu.spell:addSubMenu("[" .. myHero.charName .. "] - E", "e")
        menu.spell.e:addParam("ecombo", "Combo", SCRIPT_PARAM_ONOFF, true)
        menu.spell.e:addParam("ecombomana", "[Combo] Mana > X%", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
        menu.spell.e:addParam("empty", "", SCRIPT_PARAM_INFO, "")
        menu.spell.e:addParam("eharass", "Harass", SCRIPT_PARAM_ONOFF, true)
        menu.spell.e:addParam("eharassmana", "[Harass] Mana > X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
        menu.spell:addSubMenu("[" .. myHero.charName .. "] - R", "r")
        for i = 1, heroManager.iCount do
        local unit = heroManager:GetHero(i)
            if unit.team == myHero.team then  
            menu.spell.r:addParam("teammateult"..i, "Ult "..unit.charName, SCRIPT_PARAM_ONOFF, true)
            menu.spell.r:addParam("maxhppercent"..i, "Ult If < X% HP "..unit.charName, SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
            menu.spell.r:addParam("empty", "", SCRIPT_PARAM_INFO, "")
            end
        end
        
   menu:addSubMenu("[" .. myHero.charName .. "] - Target Selector", "target")
        menu.target:addParam("targetinfo", "Default Target Select Is LeastCast", SCRIPT_PARAM_INFO, "")
        menu.target:addParam("empty", "", SCRIPT_PARAM_INFO, "")
        menu.target:addParam("focus", "Focus Selected Target", SCRIPT_PARAM_ONOFF, true)
        menu.target:addParam("sac", "Use SAC:R Target Instead", SCRIPT_PARAM_ONOFF, false)
        
   menu:addSubMenu("Orbwalk Settings", "orb")  
   
   UPL:AddToMenu(menu)
 
   menu:addParam("hc", "Prediction Hit Chance", SCRIPT_PARAM_SLICE, 2, 0, 5, 0)
   
   menu:addParam("empty", "", SCRIPT_PARAM_INFO, "")
   menu:addParam("infobox", "            Support Heroes: " .. myHero.charName .. "           ", SCRIPT_PARAM_INFO, "")
   menu:addParam("infobox2", "                      Version:  " .. scriptVersion .. "         ", SCRIPT_PARAM_INFO, "")
   
   if menu.draw.drawpermashow then
	 menu:permaShow("infobox")
	 menu.key:permaShow("comboKey")
	 menu.key:permaShow("harassKey")
	 menu.key:permaShow("harassToggle")
	 menu.key:permaShow("clearKey")
   end
end

function _Soraka:ApplyBuff(unit, target, buff)
	if unit ~= nil and buff and unit.isMe and buff.name:lower() == "recall" or buff.name:lower() == "summonerteleport" or buff.name:lower() == "recallimproved" then buffs["recall"] = true end
end

function _Soraka:AutoHeal()
    if allyCount > 0 then
        for i = 1, allyCount do
            local unit = allyHeroes[i] 
            if not InFountain() and not buffs["recall"] then 
                if menu.ah["healally" ..unit.charName] and (100*unit.health/unit.maxHealth) < menu.ah["maxhppercent"..i] then
                    if (100 * myHero.mana / myHero.maxMana)>= menu.ah.healmana and (100*myHero.health/myHero.maxHealth) >= menu.ah.healhealth then
                        if IsReady(_W) and (GetDistance(unit) < self.SpellW.range) then 
                            CastSpell(_W, unit)         
                        end
                    end 
                end   
            end
        end
    end
end         

function _Soraka:AutoUlt()
    for i = 1, heroManager.iCount do
        local unit = heroManager:GetHero(i)
        if unit.team == myHero.team then
            if IsReady(_R) and menu.spell.r["teammateult"..i] and (100 * unit.health / unit.maxHealth) <= menu.spell.r["maxhppercent"..i] then
                CastSpell(_R)
            end
        end
    end
end

function _Soraka:Combo() 
    if Target == nil then return end
    if menu.key.comboKey then 
        if IsReady(_Q) and menu.spell.q.qcombo and (100 * myHero.mana / myHero.maxMana)>= menu.spell.q.qcombomana and (GetDistance(Target) < self.SpellQ.range) then
            if ValidTarget(Target) then
                local CastPosition, HitChance = UPL:Predict(_Q, myHero, Target)	
                if HitChance >= menu.hc then
                    CastSpell(_Q, CastPosition.x, CastPosition.z) 
                end
            end
        end
        if IsReady(_E) and menu.spell.e.ecombo and (100 * myHero.mana / myHero.maxMana)>= menu.spell.e.ecombomana and (GetDistance(Target) < self.SpellE.range) then
            if ValidTarget(Target) then
                local CastPosition, HitChance = UPL:Predict(_E, myHero, Target)	
                if HitChance >= menu.hc then
                    CastSpell(_E, CastPosition.x, CastPosition.z)
                end 
            end
        end 
    end       
end 
 
function _Soraka:Harass()
    if Target == nil then return end
    if menu.key.harassKey or menu.key.harassToggle then 
        if IsReady(_Q) and menu.spell.q.qharass and (100 * myHero.mana / myHero.maxMana)>= menu.spell.q.qharassmana and (GetDistance(Target) < self.SpellQ.range) then
            if ValidTarget(Target) then
                local CastPosition, HitChance = UPL:Predict(_Q, myHero, Target)	
                if HitChance >= menu.hc then
                    CastSpell(_Q, CastPosition.x, CastPosition.z) 
                end
            end
        end
        if IsReady(_E) and menu.spell.e.eharass and (100 * myHero.mana / myHero.maxMana)>= menu.spell.e.eharassmana and (GetDistance(Target) < self.SpellE.range) then
            if ValidTarget(Target) then
                local CastPosition, HitChance = UPL:Predict(_E, myHero, Target)	
                if HitChance >= menu.hc then
                    CastSpell(_E, CastPosition.x, CastPosition.z)
                end 
            end
        end 
    end
end

function _Soraka:LaneClear()
    if enemyMinions == nil then return end 
    for i, Minion in pairs(enemyMinions.objects) do
        if (Minion ~= nil) then
            if menu.key.clearKey then 
                if IsReady(_Q) and menu.farm.qlaneclear and (100 * myHero.mana / myHero.maxMana)>= menu.farm.clearmana then
				    CastSpell(_Q, Minion)
                end
            end
        end
    end                
end 

function _Soraka:OnDraw()
    if menu == nil then return end 
    if Target == nil then return end
    if menu.draw.drawtarget and ValidTarget(Target) and Target.type == myHero.type then
        _Tech:DrawCircle(Target.x, Target.y, Target.z, 150, ARGB(255, 255, 0, 0))
    end
    local slot = _Tech:CustomGetInventorySlotItem("HealthBomb", myHero)
    if menu.draw.drawfotm and slot ~= nil and IsReady(slot) then 
        _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 750, ARGB(table.unpack(menu.draw.colorfotm))) 
    end
    local slot = _Tech:CustomGetInventorySlotItem("IronStylus", myHero)
    if menu.draw.drawlois and slot ~= nil and IsReady(slot) then 
        _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 750, ARGB(table.unpack(menu.draw.colorlois))) 
    end
    local slot = _Tech:CustomGetInventorySlotItem("ItemMorellosBane", myHero)
    if menu.draw.drawmikaels and slot ~= nil and IsReady(slot) then 
        _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 750, ARGB(table.unpack(menu.draw.colormikaels))) 
    end
    if menu.draw.drawexhaust and sexhaust ~= nil and IsReady(sexhaust) then 
       _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 650, ARGB(table.unpack(menu.draw.colorexhaust))) 
    end
    if menu.draw.drawheal and sheal ~= nil and IsReady(sheal) then 
       _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 850, ARGB(table.unpack(menu.draw.colorheal))) 
    end
    if menu.draw.drawignite and signite ~= nil and IsReady(signite) then 
       _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 600, ARGB(table.unpack(menu.draw.colorignite))) 
    end
    if menu.draw.drawq and IsReady(_Q) then
        _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, self.SpellQ.range, ARGB(table.unpack(menu.draw.colorq)))
    end
    if menu.draw.draww and IsReady(_W) then
        _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, self.SpellW.range, ARGB(table.unpack(menu.draw.colorw)))
    end
    if menu.draw.drawe and IsReady(_E) then
        _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, self.SpellE.range, ARGB(table.unpack(menu.draw.colore)))
    end
end
 
function _Soraka:ProcessAttack(object,spell)
    if not myHero.dead and myHero.team ~= object.team then
        if Interrupt[object.charName] ~= nil then
            if Interrupt[object.charName].stop[spell.name] ~= nil then
				if menu.interrupt[spell.name] then
                    if IsReady(_E) and menu.interrupt.einterrupt then
                        DelayAction(function() CastSpell(_E, object) end, menu.humanizer.interruptDelay / 1000)
                    end
                end
           end
       end
    end
end 

function _Soraka:RemoveBuff(unit, buff)
	if unit ~= nil and buff and unit.isMe and buff.name:lower() == "recall" or buff.name:lower() == "summonerteleport" or buff.name:lower() == "recallimproved" then buffs["recall"] = false end
end 

function _Soraka:TowerCC() 
    for i = 1, enemyCount do
    local unit = enemyHeroes[i]	
        for i = 1, towerCount do
            local tower = towers[i]
            if tower and tower.team == myHero.team and (GetDistance(tower, unit) < 775) then
                if menu.snare.esnare and menu.snare["" ..unit.charName] and (GetDistance(unit) < 365) then
                    CastSpell(_E, unit)
                end
            end
        end
    end
end

Class("_Thresh")
function _Thresh:__init()
	self:LoadVariables()
	self:Menu()
	
	_Bundle:SetupOrbwalk()
	
	_Activator:__init()
    
    _Tech:GetLowestAlly(range) 
	_Tech:AddTurrets()
	towerCount = #towers
	
	AddTickCallback(function() self:OnTick() end)
	AddDrawCallback(function() self:OnDraw() end)
	AddProcessAttackCallback(function(object,spell) self:OnProcessAttack(object,spell) end)
	
	_Bundle:Print(myHero.charName .. " Loaded, Good Luck!")
end

function _Thresh:LoadVariables()
	self.SpellQ = { speed = 1800, delay = 0.5, range = 1075, width = 80, collision = true, aoe = false, type = "linear"}
	self.SpellW = { speed = nil, delay = 0, range = 950, width = nil, collision = false, aoe = false, type = "circular" } 
	self.SpellE = { speed = math.huge, delay = 0.1, range = 500, width = 100, collision = false, aoe = false, type = "linear" }
	self.SpellR = { speed = nil, delay = 0.25, range = 450, width = nil, collision = false, aoe = true, type = "circular" } 
	
	UPL:AddSpell(_Q, self.SpellQ)
	UPL:AddSpell(_E, self.SpellE)
end

function _Thresh:OnTick()
	if myHero.dead then return end

	self:AutomaticR()
	self:Combo()
    self:Desperation()
	self:Harass()
	self:FlashCombo()
	self:SaveAllyW()
	self:SpeedUpW()
	--self:ShieldLow()
	self:Interrupt()
end

function _Thresh:Menu()
	menu = scriptConfig("Support Heroes", "SupportHeroesMenuThresh")
	
	_Activator:Menu()
	
	menu:addSubMenu("[" .. myHero.charName .. "] - Auto-CC Under Tower", "snare")
		menu.snare:addParam("info", "           -- Auto-CC Enemies --", SCRIPT_PARAM_INFO, "")
		if enemyCount > 0 then
			for i = 1, enemyCount do
			local unit = enemyHeroes[i]			
				menu.snare:addParam("" .. unit.charName, "" .. unit.charName, SCRIPT_PARAM_ONOFF, true)
			end
		end
		menu.snare:addParam("settings", "                    -- Settings --", SCRIPT_PARAM_INFO, "")
		menu.snare:addParam("qsnare", "Use Q", SCRIPT_PARAM_ONOFF, true)
		menu.snare:addParam("esnare", "Use E", SCRIPT_PARAM_ONOFF, true)
		
	menu:addSubMenu("[" .. myHero.charName .. "] - Auto-Interrupt", "interrupt")   
		menu.interrupt:addParam("spells", "           -- Auto Interrupt Spells --", SCRIPT_PARAM_INFO, "")
		if enemyCount > 0 then
			for i = 1, enemyCount do
				local unit = enemyHeroes[i]
				if Interrupt[unit.charName] ~= nil then
					for i, spell in pairs(Interrupt[unit.charName].stop) do
						menu.interrupt:addParam("" .. unit.charName, "" .. unit.charName, SCRIPT_PARAM_INFO, "") 
						menu.interrupt:addParam(spell.spellName,"" .. spell.name, SCRIPT_PARAM_ONOFF, true)
						menu.interrupt:addParam("empty", "", SCRIPT_PARAM_INFO,"")
					end 
				end
			end
		end
		menu.interrupt:addParam("settings", "                -- Settings --", SCRIPT_PARAM_INFO, "")
		menu.interrupt:addParam("qinterrupt", "Use Q", SCRIPT_PARAM_ONOFF, true)
		menu.interrupt:addParam("einterrupt", "Use E", SCRIPT_PARAM_ONOFF, true)
		
	 menu:addSubMenu("[" .. myHero.charName .. "] - Auto-Shield: Champs", "as")
		 for i = 1, heroManager.iCount do
			local unit = heroManager:GetHero(i)
			if unit.team == myHero.team then
			menu.as:addParam("teammateshield"..i, "Shield "..unit.charName, SCRIPT_PARAM_ONOFF, true)
			menu.as:addParam("maxhppercent"..i, "Shield If < X% HP", SCRIPT_PARAM_SLICE, 40, 0, 100, 0)
			menu.as:addParam("empty", "", SCRIPT_PARAM_INFO,"")
			end 
		end	
		menu.as:addParam("mindmgpercent", "Min dmg percent", SCRIPT_PARAM_SLICE, 10, 0, 100, 0)
		menu.as:addParam("shieldcc", "Shield CC", SCRIPT_PARAM_ONOFF, true)
		menu.as:addParam("shieldslow", "Shield Slows", SCRIPT_PARAM_ONOFF, true)
		menu.as:addParam("skillshots", "Shield Skillshots", SCRIPT_PARAM_ONOFF, true)
		menu.as:addParam("empty", "", SCRIPT_PARAM_INFO,"")
		--menu.as:addParam("shieldLow", "Use to shield", SCRIPT_PARAM_ONOFF, true)
		
	menu:addSubMenu("[" .. myHero.charName .. "] - Auto-Shield: Misc", "asmisc")
			 menu.asmisc:addParam("engage", "Use to engage", SCRIPT_PARAM_ONOFF, true)
			 menu.asmisc:addParam("empty", "", SCRIPT_PARAM_INFO,"")
			 menu.asmisc:addParam("saveally", "Save from enemies", SCRIPT_PARAM_ONOFF, true)
			 menu.asmisc:addParam("empty", "", SCRIPT_PARAM_INFO,"")
			 menu.asmisc:addParam("speedUp", "Use to speed up", SCRIPT_PARAM_ONOFF, true)
			 menu.asmisc:addParam("speedupdis", "Speed Up If > X Dis", SCRIPT_PARAM_SLICE, 500, 0, 950, 0)

		
	menu:addSubMenu("[" .. myHero.charName .. "] - Draw Settings", "draw")
		menu.draw:addParam("spelldraws", "                -- Spell Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawq", "Draw Q", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colorq", "Color Q", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("draww", "Draw W", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("colorw", "Color W", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawe", "Draw E", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("drawetype", "Draw E Type", SCRIPT_PARAM_LIST, 1, {"Circular Draw", "Rectangular Draw" })
		menu.draw:addParam("colore", "Color E", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawr", "Draw R", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("drawrtype", "Draw R Type", SCRIPT_PARAM_LIST, 1, {"Circular Draw", "Pentagonal Draw (May Glitch)" })
		menu.draw:addParam("colorr", "Color R", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("miscellaneousdraws", "                -- Flash Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawqflash", "Draw Flash - Q", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorqflash", "Color Flash - Q", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawitem", "                -- Item Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawfotm", "Draw Face of the Mountain", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorfotm", "Color Face of the Mountain", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawlois", "Draw Locket of the Iron Solari", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorlois", "Color Locket of the Iron Solari", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawmikaels", "Draw Mikaels Crucible", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorqmikaels", "Color Mikaels Crucible", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 }) 
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawsumm", "                -- Summoner Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawexhaust", "Draw Exhaust", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorexhaust", "Color Exhaust", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawheal", "Draw Heal", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorheal", "Color Heal", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })
		menu.draw:addParam("drawignite", "Draw Ignite", SCRIPT_PARAM_ONOFF, false)
		menu.draw:addParam("colorignite", "Color Ignite", SCRIPT_PARAM_COLOR, { 255, 0x66, 0x33, 0x00 })  
		menu.draw:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("miscellaneousdraws", "            -- Miscellaneous Draws --", SCRIPT_PARAM_INFO, "")
		menu.draw:addParam("drawtarget", "Draw Target", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("drawpermashow", "Draw Permashow (Reload)", SCRIPT_PARAM_ONOFF, true)
		menu.draw:addParam("drawcollision", "Draw Collision", SCRIPT_PARAM_ONOFF, true)

	menu:addSubMenu("[" .. myHero.charName .. "] - Flash Settings", "flash")
		menu.flash:addParam("qflash", "Use Flash - Q", SCRIPT_PARAM_ONOFF, true)
		menu.flash:addParam("eqflash", "Use Flash - E + Q", SCRIPT_PARAM_ONOFF, true)
	
	menu:addSubMenu("[" .. myHero.charName .. "] - Humanizer", "humanizer")
		menu.humanizer:addParam("interruptDelay", "Auto-Interrupt Delay (ms)", SCRIPT_PARAM_SLICE, 200, 0, 500, 0)
		menu.humanizer:addParam("snareDelay", "Auto-CC Delay (ms)", SCRIPT_PARAM_SLICE, 0, 0, 500, 0)
		menu.humanizer:addParam("shieldDelay", "Auto Shield Delay (ms)", SCRIPT_PARAM_SLICE, 50, 0, 500, 0)
			
	menu:addSubMenu("[" .. myHero.charName .. "] - Key Settings", "key")
		menu.key:addParam("combatkeys", "               -- Combat Keys --", SCRIPT_PARAM_INFO, "")
		menu.key:addParam("comboKey", "Combo Key", SCRIPT_PARAM_ONKEYDOWN, false, 32)
		menu.key:addParam("harassKey", "Harass Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
		menu.key:addParam("harassToggle", "Harass Toggle", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("T"))
		menu.key:addParam("clearKey", "Lane Clear Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
		menu.key:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.key:addParam("miscellaneouskeys", "           -- Miscellaneous Keys --", SCRIPT_PARAM_INFO, "")
		menu.key:addParam("flashKey", "Flash Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("H"))
		menu.key:addParam("desperationKey", "Desperation Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("Z"))
	
	menu:addSubMenu("[" .. myHero.charName .. "] - Spell Settings", "spell")
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - Q", "q")
		menu.spell.q:addParam("qcombo", "Combo", SCRIPT_PARAM_ONOFF, true)
		menu.spell.q:addParam("qcombomana", "[Combo] Mana > X%", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
		menu.spell.q:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.q:addParam("qharass", "Harass", SCRIPT_PARAM_ONOFF, true)
		menu.spell.q:addParam("qharassmana", "[Harass] Mana > X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		menu.spell.q:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.q:addParam("q2", "Use Q2", SCRIPT_PARAM_ONOFF, true)
		menu.spell.q:addParam("maxdistanceq", "Max Enemy Distance", SCRIPT_PARAM_SLICE, 975, 0, 1100, 0)
        menu.spell.q:addParam("empty", "", SCRIPT_PARAM_INFO, "")
        menu.spell.q:addParam("blacklistinfo", "                -- Black List --", SCRIPT_PARAM_INFO,"")
        for i = 1, heroManager.iCount do
            local unit = heroManager:GetHero(i)
            if unit.team ~= myHero.team then 
                menu.spell.q:addParam("blacklist"..unit.charName, "Do Not Grab "..unit.charName, SCRIPT_PARAM_ONOFF, false)
            end
        end
        menu.spell.q:addParam("empty", "", SCRIPT_PARAM_INFO, "")
        menu.spell.q:addParam("blacklisthp", "Unless <X% HP", SCRIPT_PARAM_SLICE, 10, 0, 100, 0)
		
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - W", "w")
		menu.spell.w:addParam("wcombo", "Combo", SCRIPT_PARAM_ONOFF, true)
		menu.spell.w:addParam("wcombomana", "[Combo] Mana > X%", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
		menu.spell.w:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.w:addParam("wharass", "Harass", SCRIPT_PARAM_ONOFF, true)
		menu.spell.w:addParam("wharassmana", "[Harass] Mana > X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - E", "e")
		menu.spell.e:addParam("ecombo", "Combo", SCRIPT_PARAM_ONOFF, true)
		menu.spell.e:addParam("ecombomana", "[Combo] Mana > X%", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
		menu.spell.e:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.e:addParam("eharass", "Harass", SCRIPT_PARAM_ONOFF, true)
		menu.spell.e:addParam("eharassmana", "[Harass] Mana > X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		
		menu.spell:addSubMenu("[" .. myHero.charName .. "] - R", "r")
		menu.spell.r:addParam("rcombo", "Combo", SCRIPT_PARAM_ONOFF, true)
		menu.spell.r:addParam("rcombomana", "[Combo] Mana > X%", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
		menu.spell.r:addParam("rcombomin", "[Combo] Min enemies", SCRIPT_PARAM_SLICE, 1, 0, 5, 0)
		menu.spell.r:addParam("rcombotarget", "[Combo] Target has to be in box", SCRIPT_PARAM_ONOFF, true)
		menu.spell.r:addParam("rmpty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.r:addParam("rharass", "Harass", SCRIPT_PARAM_ONOFF, true)
		menu.spell.r:addParam("rharassmana", "[Harass] Mana > X%", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
		menu.spell.r:addParam("rharassmin", "[Harass] Min enemies", SCRIPT_PARAM_SLICE, 2, 0, 5, 0)
		menu.spell.r:addParam("rharasstarget", "[Harass] Target has to be in box", SCRIPT_PARAM_ONOFF, false)
		menu.spell.r:addParam("rmpty", "", SCRIPT_PARAM_INFO, "")
		menu.spell.r:addParam("rautomin", "[Automatic] Min enemies", SCRIPT_PARAM_SLICE, 3, 0, 5, 0)
		
   menu:addSubMenu("[" .. myHero.charName .. "] - Target Selector", "target")
		menu.target:addParam("targetinfo", "Default Target Select Is LeastCast", SCRIPT_PARAM_INFO, "")
		menu.target:addParam("empty", "", SCRIPT_PARAM_INFO, "")
		menu.target:addParam("focus", "Focus Selected Target", SCRIPT_PARAM_ONOFF, true)
		menu.target:addParam("sac", "Use SAC:R Target Instead", SCRIPT_PARAM_ONOFF, false)
		
   menu:addSubMenu("Orbwalk Settings", "orb")  
   
   UPL:AddToMenu(menu)
   
   menu:addParam("hc", "Prediction Hit Chance", SCRIPT_PARAM_SLICE, 2, 0, 5, 0)
 
   menu:addParam("empty", "", SCRIPT_PARAM_INFO, "")
   menu:addParam("infobox", "            Support Heroes: " .. myHero.charName .. "           ", SCRIPT_PARAM_INFO, "")
   menu:addParam("infobox2", "                      Version:  " .. scriptVersion .. "         ", SCRIPT_PARAM_INFO, "")
   
   if menu.draw.drawpermashow then
	 menu:permaShow("infobox")
	 menu.key:permaShow("comboKey")
	 menu.key:permaShow("harassKey")
	 menu.key:permaShow("harassToggle")
	 menu.key:permaShow("clearKey")
     menu.key:permaShow("desperationKey")
   end
end

function _Thresh:OnProcessAttack(object,spell)
	if Target == nil then return end
	if spell and object and spell.name:lower():find("turret") and object.team == myHero.team then
		for _, enemy in pairs(GetEnemyHeroes()) do
			if spell.target == enemy then
				if GetDistance(enemy, tower) < 775 and menu.snare[enemy.charName] and GetDistance(myHero, enemy) < 1000 then
					if menu.snare.qsnare then
						   if IsReady(_Q) and menu.spell.q.qcombo and (100 * myHero.mana / myHero.maxMana)>= menu.spell.q.qcombomana and GetDistance(enemy) < self.SpellQ.range then
							if IsReady(_E) and GetDistance(enemy) < self.SpellE.range then return end
							if ValidTarget(enemy) then
								local CastPosition, HitChance, HeroPosition = UPL:Predict(_Q, myHero, enemy)
								if HitChance >= menu.hc then 
									CastSpell(_Q, CastPosition.x, CastPosition.z)
									DelayAction(function() _Thresh:CastQ2() end , 1.4 + self.SpellQ.delay)
								end
							end
						end
					end
					
					if menu.snare.esnare then
						local castPosition = Vector(myHero) + (Vector(myHero) - Vector(enemy)):normalized() * self.SpellW.range
						CastSpell(_E, castPosition.x, castPosition.z)
					end
				end
			end
		end
	end
	if object.team ~= myHero.team and not myHero.dead and object.name ~= nil and not (object.name:find("Minion_") or object.name:find("Odin")) then
		local shieldREADY = IsReady(_W)
		local HitFirst = false
		local shieldtarget,SLastDistance,SLastDmgPercent = nil,nil,nil
		local ulttarget,ULastDistance,ULastDmgPercent = nil,nil,nil
		
		YWall, BShield, SShield, Shield, CC = false, false, false, false
		shottype, radius, maxdistance = 0, 0, 0
		
		if object.type == "AIHeroClient" then
			spelltype, casttype = getSpellType(object, spell.name)
			if casttype == 4 or casttype == 5 or casttype == 6 then
				return
			end
		   
			Shield = true
			
				if spelltype == "Q" or spelltype == "W" or spelltype == "E" or spelltype == "R" or spelltype == "P" or spelltype == "QM" or spelltype == "WM" or spelltype == "EM" then
					if skillShield[object.charName] == nil then return end
                    HitFirst = skillShield[object.charName][spelltype].HitFirst
					YWall = skillShield[object.charName][spelltype].YWall
					BShield = skillShield[object.charName][spelltype].BShield
					SShield = skillShield[object.charName][spelltype].SShield
					Shield = skillShield[object.charName][spelltype].Shield
					CC = skillShield[object.charName][spelltype].CC
					shottype = skillData[object.charName][spelltype].type
					radius = skillData[object.charName][spelltype].radius
					maxdistance = skillData[object.charName][spelltype].maxdistance
				else
					Shield = true
				end
			
				for i = 1, heroManager.iCount do
				local allytarget = heroManager:GetHero(i)
					if spell.target and spell.target.networkID == allytarget.networkID then
						if allytarget.team == myHero.team and not allytarget.dead and 0 < allytarget.health and allytarget.type == myHero.type then
							hitchampion = false
							local allyHitBox = allytarget.boundingRadius
							if shottype == 0 then
							hitchampion = spell.target and spell.target.networkID == allytarget.networkID
							elseif shottype == 1 then
							hitchampion = checkhitlinepass(object, spell.endPos, radius, maxdistance, allytarget, allyHitBox)
							elseif shottype == 2 then
							hitchampion = checkhitlinepoint(object, spell.endPos, radius, maxdistance, allytarget, allyHitBox)
							elseif shottype == 3 then
							hitchampion = checkhitaoe(object, spell.endPos, radius, maxdistance, allytarget, allyHitBox)
							elseif shottype == 4 then
							hitchampion = checkhitcone(object, spell.endPos, radius, maxdistance, allytarget, allyHitBox)
							elseif shottype == 5 then
							hitchampion = checkhitwall(object, spell.endPos, radius, maxdistance, allytarget, allyHitBox)
							elseif shottype == 6 then
							hitchampion = checkhitlinepass(object, spell.endPos, radius, maxdistance, allytarget, allyHitBox) or checkhitlinepass(object, Vector(object) * 2 - spell.endPos, radius, maxdistance, allytarget, allyHitBox)
							elseif shottype == 7 then
							hitchampion = checkhitcone(spell.endPos, object, radius, maxdistance, allytarget, allyHitBox)              
							end
							if shieldREADY and menu.as["teammateshield" .. i] and GetDistance(allytarget) <= self.SpellW.range then
							local shieldflag, dmgpercent = self:shieldCheck(object,spell,allytarget,"shields")
								if shieldflag then
									if HitFirst and (SLastDistance == nil or SLastDistance >= GetDistance(allytarget, object)) then
										shieldtarget, SLastDistance = allytarget, GetDistance(allytarget, object)
									elseif not HitFirst and (SLastDmgPercent == nil or SLastDmgPercent <= dmgpercent) then
										shieldtarget, SLastDmgPercent = allytarget, dmgpercent
									end
								end
							end
						end
					end
				if shieldtarget ~= nil then
					DelayAction(function() self:CastW(shieldtarget, 0.01) end, menu.humanizer.shieldDelay / 1000)
				end
			end
		end
	end
end

function _Thresh:shieldCheck(object,spell,target,typeused)
	if Target == nil then return end
	if typeused == "shields" then
	  local shieldflag = false
	  if not menu.as.skillshots and shottype ~= 0 then
		return false, 0
	  end
	  local adamage = object:CalcDamage(target, object.totalDamage)
	  local InfinityEdge,onhitdmg,onhittdmg,onhitspelldmg,onhitspelltdmg,muramanadmg,skilldamage,skillTypeDmg = 0,0,0,0,0,0,0,0
	  if object.type ~= "AIHeroClient" then
	  elseif spelltype == "BAttack" then
		skilldamage = (adamage+onhitdmg+muramanadmg)*1.07+onhittdmg
	  elseif spelltype == "CAttack" then
	  elseif spelltype == "Q" or spelltype == "W" or spelltype == "E" or spelltype == "R" or spelltype == "P" or spelltype == "QM" or spelltype == "WM" or spelltype == "EM" then
		if not skillShield[object.charName][spelltype].Muramana or not muramanadmg then
		  muramanadmg = 0
		end
		if casttype == 1 then
		  skilldamage, skillTypeDmg = getDmg(spelltype, target, object, 1, spell.level)
		elseif casttype == 2 then
		  skilldamage, skillTypeDmg = getDmg(spelltype, target, object, 2, spell.level)
		elseif casttype == 3 then
		  skilldamage, skillTypeDmg = getDmg(spelltype, target, object, 3, spell.level)
		end
		if skillTypeDmg == 2 then
		  skilldamage = (skilldamage + adamage + onhitspelldmg + onhitdmg + muramanadmg)* 1.07 + onhittdmg + onhitspelltdmg
		elseif skilldamage > 0 then
		  skilldamage = (skilldamage + onhitspelldmg + muramanadmg)* 1.07 + onhitspelltdmg
		end
	  elseif spell.name:find("SummonerDot") then
		skilldamage = getDmg("IGNITE", target, object)
	  end
			  for i = 1, heroManager.iCount do
				local ally = heroManager:GetHero(i)
				if ally.team == myHero.team then 
			  local dmgpercent = skilldamage * 100 / target.health
			  local dmgneeded = dmgpercent >= menu.as.mindmgpercent
			  local hpneeded =  menu.as["maxhppercent"..i] >= (target.health - skilldamage) * 100 / target.maxHealth
				  if dmgneeded and hpneeded then
					  shieldflag = true
				  elseif (typeused == "shields" or typeused == "wall") and (CC == 2 and menu.as.shieldCC or CC == 1 and menu.as.shieldslow) then
					  shieldflag = true
				  end
				  return shieldflag, dmgpercent
				  end
			  end
		  end
	  end

function _Thresh:Combo()
   if Target == nil then return end
	if menu.key.comboKey then 
		if IsReady(_E) and menu.spell.e.ecombo and (100 * myHero.mana / myHero.maxMana)>= menu.spell.e.ecombomana and GetDistance(Target) < self.SpellE.range then
			self:CastE()
		end
	
		if IsReady(_Q) and menu.spell.q.qcombo and (100 * myHero.mana / myHero.maxMana)>= menu.spell.q.qcombomana and GetDistance(Target) < self.SpellQ.range and GetDistance(Target) <= menu.spell.q.maxdistanceq then
			if IsReady(_E) and GetDistance(Target) < self.SpellE.range then return end
			if not menu.spell.q["blacklist"..unit.charName] and ValidTarget(Target) then  
				local CastPosition, HitChance, HeroPosition = UPL:Predict(_Q, myHero, Target)
				if HitChance >= menu.hc then 
					CastSpell(_Q, CastPosition.x, CastPosition.z)
					DelayAction(function() _Thresh:CastQ2() end , 1.4 + self.SpellQ.delay)
				end
			end
            if menu.spell.q["blacklist"..unit.charName] and (100*unit.health/unit.maxHealth) <= menu.spell.q.blacklisthp then 
            local CastPosition, HitChance, HeroPosition = UPL:Predict(_Q, myHero, Target)
                if HitChance >= menu.hc then 
                    CastSpell(_Q, CastPosition.x, CastPosition.z)
                    DelayAction(function() _Thresh:CastQ2() end , 1.4 + self.SpellQ.delay)
                end
            end
		end
		
		if (not menu.spell.r.rcombotarget or GetDistance(Target) < self.SpellR.range) and menu.spell.r.rcombomin <= CountObjectsInCircle(myHero, self.SpellR.range, GetEnemyHeroes()) then 
			CastSpell(_R) 
		end
		
		if IsReady(_W) and menu.spell.w.wcombo and (100 * myHero.mana / myHero.maxMana)>= menu.spell.w.wcombomana then
			self:EngageW()
		end
	end  
end

function _Thresh:FlashCombo()
	if Target == nil then return end
	if not menu.key.flashKey then return end
   
	if GetDistance(Target) < 500 and not IsReady(_E) and not IsReady(sflash) then
		if IsReady(_Q) and menu.spell.q.qcombo and (100 * myHero.mana / myHero.maxMana)>= menu.spell.q.qcombomana and GetDistance(Target) < self.SpellQ.range then
			if IsReady(_E) and GetDistance(Target) < self.SpellE.range then 
				if ValidTarget(Target) then
					local CastPosition, HitChance, HeroPosition = UPL:Predict(_Q, myHero, Target)
					if HitChance >= menu.hc then 
						CastSpell(_Q, CastPosition.x, CastPosition.z)
						DelayAction(function() _Thresh:CastQ2() end , 1.4 + self.SpellQ.delay)
					end
				end
			end
		end
	end
   
	if menu.flash.eqflash then
		if IsReady(sflash) and IsReady(_E) and IsReady(_Q) and GetDistance(Target) <= 425 + self.SpellE.range then
			if GetDistance(Target) < 425 then
				flashPos = myHero + (GetDistance(Target) - 50) * (Vector(Target) - Vector(myHero)):normalized()
			else
				flashPos = myHero + 425 * (Vector(Target) - Vector(myHero)):normalized()
			end
			
			local CastPosition, HitChance = UPL:Predict(_E, flashPos, Target)		
			if HitChance >= menu.hc and type(CastPosition.x) == "number" and type(CastPosition.z) == "number" then
				flashPos = myHero + 425 * (Vector(CastPosition) - Vector(myHero)):normalized()
				CastSpell(sflash, flashPos.x, flashPos.z)
				
				CastPosition = Vector(myHero) + (Vector(myHero) - Vector(CastPosition)):normalized() * self.SpellE.range
				_Tech:FlashComboPosition(_E, CastPosition.x, CastPosition.z)
			end
		end	
		
		if IsReady(sflash) and IsReady(_E) and IsReady(_Q) then
			myHero:MoveTo(mousePos.x, mousePos.z)
		end
	end
   
	if menu.flash.qflash then
		if IsReady(sflash) and IsReady(_Q) and GetDistance(Target) <= 425 + self.SpellQ.range then
			if GetDistance(Target) < 425 then
				flashPos = myHero + (GetDistance(Target) - 50) * (Vector(Target) - Vector(myHero)):normalized()
			else
				flashPos = myHero + 425 * (Vector(Target) - Vector(myHero)):normalized()
			end

			local CastPosition, HitChance = UPL:Predict(_Q, flashPos, Target)		
			if HitChance >= menu.hc and type(CastPosition.x) == "number" and type(CastPosition.z) == "number" then
				flashPos = myHero + 425 * (Vector(CastPosition) - Vector(myHero)):normalized()
				CastSpell(sflash, flashPos.x, flashPos.z)
				_Tech:FlashComboPosition(_Q, CastPosition.x, CastPosition.z)
			end
		end	
		
		if IsReady(sflash) and IsReady(_Q) then
			myHero:MoveTo(mousePos.x, mousePos.z)
		end
	end
end

function _Thresh:Harass()
	if Target == nil then return end
	if menu.key.harassKey or menu.key.harassToggle then 
		if IsReady(_E) and menu.spell.e.eharass and (100 * myHero.mana / myHero.maxMana)>= menu.spell.e.eharassmana and GetDistance(Target) < self.SpellE.range then
			self:CastE()
		end
	
		if IsReady(_Q) and menu.spell.q.qharass and (100 * myHero.mana / myHero.maxMana)>= menu.spell.q.qharassmana and GetDistance(Target) < self.SpellQ.range and GetDistance(Target) <= menu.spell.q.maxdistanceq then
			if IsReady(_E) and GetDistance(Target) < self.SpellE.range then return end
			if not menu.spell.q["blacklist"..unit.charName] and ValidTarget(Target) then  
				local CastPosition, HitChance, HeroPosition = UPL:Predict(_Q, myHero, Target)
				if HitChance >= menu.hc then 
					CastSpell(_Q, CastPosition.x, CastPosition.z)
					DelayAction(function() _Thresh:CastQ2() end , 1.4 + self.SpellQ.delay)
				end
			end
            if menu.spell.q["blacklist"..unit.charName] and (100*unit.health/unit.maxHealth) <= menu.spell.q.blacklisthp then 
            local CastPosition, HitChance, HeroPosition = UPL:Predict(_Q, myHero, Target)
                if HitChance >= menu.hc then 
                    CastSpell(_Q, CastPosition.x, CastPosition.z)
                    DelayAction(function() _Thresh:CastQ2() end , 1.4 + self.SpellQ.delay)
                end
            end
		end
		
		if (not menu.spell.r.rharasstarget or GetDistance(Target) < self.SpellR.range) and menu.spell.r.rharassmin <= CountObjectsInCircle(myHero, self.SpellR.range, GetEnemyHeroes()) then 
			CastSpell(_R) 
		end
		
		if IsReady(_W) and menu.spell.w.wharass and (100 * myHero.mana / myHero.maxMana)>= menu.spell.w.wharassmana then
			self:EngageW()
		end
	end 
end

function _Thresh:Interrupt()
	if Target == nil then return end
	if not myHero.dead and myHero.team ~= unit.team then
	   if Interrupt[unit.charName] ~= nil then
		   if Interrupt[unit.charName].stop[unit.spellName] ~= nil then
				if menu.interrupt[spell.name] then
					if IsReady(_Q) and menu.interrupt.qinterrupt and (GetDistance(unit) < self.SpellQ.range) then 
						local CastPosition, HitChance, HeroPosition = UPL:Predict(_Q, myHero, unit)
						if HitChance >= menu.hc then 
							DelayAction(function() CastSpell(_Q, CastPosition.x, CastPosition.z) end, menu.humanizer.interruptDelay / 1000)
						end
					elseif IsReady(_E) and menu.interrupt.einterrupt and (GetDistance(unit) < self.SpellE.range) then 
						--ToDo
						DelayAction(function() CastSpell(_E, unit) end, menu.humanizer.interruptDelay / 1000)
					end
				end
		   end
	   end
	end
end

function _Thresh:OnDraw()
	if menu == nil or Target == nil then return end
	
	if menu.draw.drawtarget and ValidTarget(Target) and Target.type == myHero.type then
		_Tech:DrawCircle(Target.x, Target.y, Target.z, 150, ARGB(255, 255, 0, 0))
	end
	if ValidTarget(Target) and menu.draw.drawcollision and IsReady(_Q) and (GetDistance(Target) <= self.SpellQ.range) then
	   local IsCollision = VPred:CheckMinionCollision(Target, Target.pos, 0.25, 70, self.SpellQ.range, 1800, myHero.pos, nil, true)
			DrawLine3D(myHero.x, myHero.y, myHero.z, Target.x, Target.y, Target.z, 5, IsCollision and ARGB(125, 255, 0,0) or ARGB(125, 0, 255,0))
	end  
	if menu.draw.drawqflash and menu.flash.qflash and IsReady(sflash) and IsReady(_Q) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, (self.SpellQ.range + 425), ARGB(table.unpack(menu.draw.colorqflash)))
	end
	local slot = _Tech:CustomGetInventorySlotItem("HealthBomb", myHero)
	if menu.draw.drawfotm and slot ~= nil and IsReady(slot) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 750, ARGB(table.unpack(menu.draw.colorfotm))) 
	end
	local slot = _Tech:CustomGetInventorySlotItem("IronStylus", myHero)
	if menu.draw.drawlois and slot ~= nil and IsReady(slot) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 750, ARGB(table.unpack(menu.draw.colorlois))) 
	end
	local slot = _Tech:CustomGetInventorySlotItem("ItemMorellosBane", myHero)
	if menu.draw.drawmikaels and slot ~= nil and IsReady(slot) then 
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 750, ARGB(table.unpack(menu.draw.colormikaels))) 
	end
	if menu.draw.drawexhaust and sexhaust ~= nil and IsReady(sexhaust) then 
	   _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 650, ARGB(table.unpack(menu.draw.colorexhaust))) 
	end
	if menu.draw.drawheal and sheal ~= nil and IsReady(sheal) then 
	   _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 850, ARGB(table.unpack(menu.draw.colorheal))) 
	end
	if menu.draw.drawignite and signite ~= nil and IsReady(signite) then 
	   _Tech:DrawCircle(myHero.x, myHero.y, myHero.z, 600, ARGB(table.unpack(menu.draw.colorignite))) 
	end
	if menu.draw.drawq and IsReady(_Q) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, self.SpellQ.range, ARGB(table.unpack(menu.draw.colorq)))
	end
	if menu.draw.draww and IsReady(_W) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, self.SpellW.range, ARGB(table.unpack(menu.draw.colorw)))
	end
	if menu.draw.drawe and menu.draw.drawetype == 1 and IsReady(_E) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, self.SpellE.range, ARGB(table.unpack(menu.draw.colore)))
	end
	if menu.draw.drawe and menu.draw.drawetype == 2 and IsReady(_E) then
		local mousePosVec = myHero + (Vector(mousePos) - myHero):normalized() * 480
		local mousePosVec2 = myHero + (Vector(mousePos) - myHero):normalized() * - 480
		local Vec1 = Vector(mousePosVec) + (Vector(myHero.pos) - Vector(mousePosVec)):normalized()
		local Vec2 = Vector(mousePosVec2) + (Vector(myHero.pos) - Vector(mousePosVec2)):normalized()
		DrawLineBorder3D(Vec2.x, myHero.y, Vec2.z, Vec1.x, myHero.y, Vec1.z, 300, ARGB(table.unpack(menu.draw.colore)), 2)    
	end   
	if menu.draw.drawr and menu.draw.drawrtype == 1 and IsReady(_R) then
		_Tech:DrawCircle(myHero.x, myHero.y, myHero.z, self.SpellR.range, ARGB(table.unpack(menu.draw.colorr)))
	end
	if menu.draw.drawr and menu.draw.drawrtype == 2 and IsReady(_R) then
		_PentagonRot:DrawHexagonRot(object, ARGB(table.unpack(menu.draw.colorr)), thickness, size)
	end
end

function _Thresh:CastQ2()
	if menu.spell.q.q2 and GetSpellData(_Q).name == "threshqleap" then
		if menu.key.comboKey or menu.key.harassKey or menu.key.harassToggle or menu.key.flashKey then 
			CastSpell(_Q)  
		end
	end
end

function _Thresh:CastW(ally, delay)
	local predPos = CalculateTargetPosition(ally, delay)
	if GetDistance(predPos) < self.SpellW.range + 250 then
		local castPosition
		
		if GetDistance(predPos) > self.SpellW.range then
			castPosition = Vector(myHero) + (Vector(predPos) - Vector(myHero)):normalized() * self.SpellW.range
		else
			castPosition = predPos
		end
		
		CastSpell(_W, castPosition.x, castPosition.z)
	end
end

--[[function _Thresh:ShieldLow()
	if IsReady(_W) and menu.as.shieldLow and not InFountain() then 
		for _, ally in pairs(GetAllyHeroes()) do
			if not ally.dead and 15 > (ally.health / ally.maxHealth) * 100 and GetDistance(ally) < self.SpellW.range + 200 then
				self:CastW(ally, 0.25)
			end
		end
	end
end]]

function _Thresh:EngageW()
	if Target == nil then return end
	if menu.key.comboKey and menu.asmisc.engage and IsReady(_W) then
		if GetDistance(Target) < 300 or GetSpellData(_Q).name == "threshqleap" then
			for _, ally in pairs(GetAllyHeroes()) do
				if GetDistance(Target, ally) > 800 and GetDistance(Target, ally) < self.SpellW.range + 800 then
					self:CastW(ally, 1.25)
				end
			end
		end
	end
end

function _Thresh:SaveAllyW()
	if menu.asmisc.saveally and IsReady(_W) then
		for _, ally in pairs(GetAllyHeroes()) do
			if not ally.dead and GetDistance(ally) < self.SpellW.range + 500 and CountObjectsInCircle(ally, 600, GetEnemyHeroes()) > CountObjectsInCircle(ally, 600, GetAllyHeroes()) and GetDistance(ally) > 800 then
				self:CastW(ally, 1.25)
			end
		end
	end
end

function _Thresh:SpeedUpW()
	if menu.asmisc.speedUp and IsReady(_W) then
		for _, ally in pairs(GetAllyHeroes()) do
			local pEnd = ally:GetPath(ally.pathCount)
			if ally.pathCount > 1 and GetDistance(ally, pEnd) > self.SpellW.range and GetDistance(ally) < self.SpellW.range + 800 then
				if GetDistance(pointOnLine(pEnd, ally, myHero, 0, self.SpellW.range)) < 300 and GetDistance(ally) > menu.asmisc.speedupdis and AngleDifference(ally, pEnd, myHero) < 45 then
					self:CastW(ally, 1.25)
				end
			end
		end
	end
end

function _Thresh:Desperation()
	if menu.key.desperationKey and IsReady(_W) then 
        for _, ally in pairs(GetAllyHeroes()) do
			if not ally.dead and GetDistance(ally) < self.SpellW.range + 500 and CountObjectsInCircle(ally, 600, GetEnemyHeroes()) > CountObjectsInCircle(ally, 600, GetAllyHeroes()) and GetDistance(ally) > 800 then
                self:CastW(ally, 1.25)
                else CastSpell(_W, _Tech:GetLowestAlly(range))
            end
        end
    end
end		

function _Thresh:CastE()
	if Target == nil then return end
	if GetSpellData(_Q).name == "threshqleap" then return end 
	for _, ally in pairs(GetAllyHeroes()) do
		if ally.range > 300 and not ally.dead then
			for _, enemy in pairs(GetEnemyHeroes()) do
				if enemy and not enemy.dead and enemy.range < 300 and GetDistance(enemy, ally) < enemy.range and GetDistance(enemy) < self.SpellE.range then
					local predPos, HitChance, HeroPosition = UPL:Predict(_E, myHero, enemy)
					if AngleDifference(enemy, ally, myHero) > 90 then
						local castPosition = Vector(myHero) + (Vector(myHero) - Vector(predPos)):normalized() * self.SpellW.range
						CastSpell(_E, castPosition.x, castPosition.z)
					else
						CastSpell(_E, predPos.x, predPos.z)
					end
				end
			end
		end
	end
	
	if Target.hasMovePath and Target.pathCount > 1 then
		local endPoint = Target:GetPath(Target.pathCount)
		local predPos, HitChance, HeroPosition = UPL:Predict(_E, myHero, Target)
		
		if AngleDifference(myHero, endPoint, Target) < 90 then
			local castPosition = Vector(myHero) + (Vector(myHero) - Vector(predPos)):normalized() * self.SpellW.range
			CastSpell(_E, castPosition.x, castPosition.z)
		else
			CastSpell(_E, predPos.x, predPos.z)
		end
	else
		local castPosition = Vector(myHero) + (Vector(myHero) - Vector(Target)):normalized() * self.SpellW.range
		CastSpell(_E, castPosition.x, castPosition.z)
	end
end

function _Thresh:AutomaticR()
	if menu.spell.r.rautomin <= CountObjectsInCircle(myHero, self.SpellR.range, GetEnemyHeroes()) then 
		CastSpell(_R) 
	end
end

-- Technical Things --
Class("_Tech")
-- Adds Turrets -- 
function _Tech:AddTurrets()
	for i = 1, objManager.iCount do
		local turret = objManager:getObject(i)
		if turret and turret.valid and turret.team == myHero.team and turret.type == "obj_AI_Turret" and not string.find(turret.name, "TurretShrine") then
			table.insert(towers, turret)
		end
	end
end

-- Finds Closest Enemy --
function _Tech:ClosestEnemy(pos)
	if pos == nil then return math.huge, nil end
	local closestEnemy, distanceEnemy = nil, math.huge
	
	for i, enemy in pairs(GetEnemyHeroes()) do
		if not enemy.dead then 
			if GetDistance(pos, enemy) < distanceEnemy then
				distanceEnemy = GetDistance(pos, enemy)
				closestEnemy = enemy
			end
		end
	end
	
	return closestEnemy, distanceEnemy
end

-- Get inventory slot --
function _Tech:CustomGetInventorySlotItem(item, unit)
	for slot = ITEM_1, ITEM_7 do
		if unit:GetSpellData(slot).name:lower() == item:lower() then
			return slot
		end
	end
	return nil
end

-- Lag Free Circles --
function _Tech:DrawCircle(x, y, z, radius, color)
	local vPos1 = Vector(x, y, z)
	local vPos2 = Vector(cameraPos.x, cameraPos.y, cameraPos.z)
	local tPos = vPos1 - (vPos1 - vPos2):normalized() * radius
	local sPos = WorldToScreen(D3DXVECTOR3(tPos.x, tPos.y, tPos.z))
		
	if OnScreen({ x = sPos.x, y = sPos.y }, { x = sPos.x, y = sPos.y }) then
		self:DrawCircleNextLvl(x, y, z, radius, 1, color, 300) 
	end
end

function _Tech:DrawCircleNextLvl(x, y, z, radius, width, color, chordlength)
	radius = radius or 300
	quality = math.max(40, Round(180 / math.deg((math.asin((chordlength / (2 * radius)))))))
	quality = 2 * math.pi / quality
	radius = radius * .92
	local points = {}
		
	for theta = 0, 2 * math.pi + quality, quality do
		local c = WorldToScreen(D3DXVECTOR3(x + radius * math.cos(theta), y, z - radius * math.sin(theta)))
		points[#points + 1] = D3DXVECTOR2(c.x, c.y)
	end
	DrawLines2(points, width or 1, color or 4294967295)	
end

-- Flash Position -- 
function _Tech:FlashComboPosition(slot, x, z)
	if IsReady(slot) and type(x) == "number" and type(z) == "number" and type(slot) == "number" then
		CastSpell(slot, x, z)
	else	
		return
	end
	
	DelayAction(function() _Tech:FlashComboPosition(slot, x, z) end, 0.01)
end

-- Lowest Ally -- 
function _Tech:GetLowestAlly(range) --[[Tested function.. I love it! Always returns the lowest % ally in range.]]
	LowestAlly = nil
	for a = 1, heroManager.iCount do
		Ally = heroManager:GetHero(a)
		if Ally.team == myHero.team and not Ally.dead and GetDistance(myHero,Ally) <= 900 then
			if LowestAlly == nil then
				LowestAlly = Ally
			elseif not LowestAlly.dead and (Ally.health/Ally.maxHealth) < (LowestAlly.health/LowestAlly.maxHealth) then
				LowestAlly = Ally
			end
		end
	end
	return LowestAlly
end

-- Passive Timers -- 
function _Tech:getPassiveTime(tar, buffName)
	local unit = tar
	local endT = 0
	for i=1, unit.buffCount do
		if unit:getBuff(i).name == buffName then
			endT = unit:getBuff(i).endT
			break
		end
	end
	local timer = GetGameTimer() - endT
	if timer > 0 then
		return timer
	else
		return 0
	end
end

-- Target Selection --
function _Tech:GetTarget()
	ts:update()
	if _G.AutoCarry and _G.AutoCarry.Crosshair and ValidTarget(_G.AutoCarry.Crosshair:GetTarget()) and menu.target.sac then _G.AutoCarry.Crosshair:SetSkillCrosshairRange(1250)
		return _G.AutoCarry.Crosshair:GetTarget() 
	end  
	if SelectedTarget ~= nil and not SelectedTarget.dead and SelectedTarget.type == myHero.type and SelectedTarget.team ~= myHero.team and menu.target.focus then
		if GetDistance(SelectedTarget) > 1250 and ts.target ~= nil then
			return ts.target
		else
			return SelectedTarget
		end
	end 
	return ts.target
end

-- Latency --
function _Tech:Latency()
	return GetLatency() / 2000
end

-- Global Classes --
-- Auto update stuff made by Aroc
Class("ScriptUpdate")
function ScriptUpdate:__init(LocalVersion, UseHttps, Host, VersionPath, ScriptPath, SavePath, CallbackUpdate, CallbackNoUpdate, CallbackNewVersion, CallbackError)
	self.LocalVersion = LocalVersion
	self.Host = Host
	self.VersionPath = '/BoL/TCPUpdater/GetScript' ..(UseHttps and '5' or '6') .. '.php?script=' .. self:Base64Encode(self.Host .. VersionPath) .. '&rand=' .. math.random(99999999)
	self.ScriptPath = '/BoL/TCPUpdater/GetScript' ..(UseHttps and '5' or '6') .. '.php?script=' .. self:Base64Encode(self.Host .. ScriptPath) .. '&rand=' .. math.random(99999999)
	self.SavePath = SavePath
	self.CallbackUpdate = CallbackUpdate
	self.CallbackNoUpdate = CallbackNoUpdate
	self.CallbackNewVersion = CallbackNewVersion
	self.CallbackError = CallbackError
	AddDrawCallback( function() self:OnDraw() end)
	self:CreateSocket(self.VersionPath)
	self.DownloadStatus = 'Connect to Server for VersionInfo'
	AddTickCallback( function() self:GetOnlineVersion() end)
end

function ScriptUpdate:print(str)
	print('<font color="#FFFFFF">' .. os.clock() .. ': ' .. str)
end

function ScriptUpdate:OnDraw()
	if self.DownloadStatus ~= 'Downloading Script (100%)' and self.DownloadStatus ~= 'Downloading VersionInfo (100%)' then
		DrawText('Download Status: ' ..(self.DownloadStatus or 'Unknown'), 50, 10, 50, ARGB(0xFF, 0xFF, 0xFF, 0xFF))
	end
end

function ScriptUpdate:CreateSocket(url)
	if not self.LuaSocket then
		self.LuaSocket = require("socket")
	else
		self.Socket:close()
		self.Socket = nil
		self.Size = nil
		self.RecvStarted = false
	end
	self.LuaSocket = require("socket")
	self.Socket = self.LuaSocket.tcp()
	self.Socket:settimeout(0, 'b')
	self.Socket:settimeout(99999999, 't')
	self.Socket:connect('sx-bol.eu', 80)
	self.Url = url
	self.Started = false
	self.LastPrint = ""
	self.File = ""
end

function ScriptUpdate:Base64Encode(data)
	local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
	return((data:gsub('.', function(x)
		local r, b = '', x:byte()
		for i = 8, 1, -1 do r = r ..(b % 2 ^ i - b % 2 ^(i - 1) > 0 and '1' or '0') end
		return r;
	end ) .. '0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
		if (#x < 6) then return '' end
		local c = 0
		for i = 1, 6 do c = c +(x:sub(i, i) == '1' and 2 ^(6 - i) or 0) end
		return b:sub(c + 1, c + 1)
	end ) ..( { '', '==', '=' })[#data % 3 + 1])
end

function ScriptUpdate:GetOnlineVersion()
	if self.GotScriptVersion then return end

	self.Receive, self.Status, self.Snipped = self.Socket:receive(1024)
	if self.Status == 'timeout' and not self.Started then
		self.Started = true
		self.Socket:send("GET " .. self.Url .. " HTTP/1.1\r\nHost: sx-bol.eu\r\n\r\n")
	end
	if (self.Receive or(#self.Snipped > 0)) and not self.RecvStarted then
		self.RecvStarted = true
		self.DownloadStatus = 'Downloading VersionInfo (0%)'
	end

	self.File = self.File ..(self.Receive or self.Snipped)
	if self.File:find('</s' .. 'ize>') then
		if not self.Size then
			self.Size = tonumber(self.File:sub(self.File:find('<si' .. 'ze>') + 6, self.File:find('</si' .. 'ze>') -1))
		end
		if self.File:find('<scr' .. 'ipt>') then
			local _, ScriptFind = self.File:find('<scr' .. 'ipt>')
			local ScriptEnd = self.File:find('</scr' .. 'ipt>')
			if ScriptEnd then ScriptEnd = ScriptEnd - 1 end
			local DownloadedSize = self.File:sub(ScriptFind + 1, ScriptEnd or -1):len()
			self.DownloadStatus = 'Downloading VersionInfo (' .. round(100 / self.Size * DownloadedSize, 2) .. '%)'
		end
	end
	if self.File:find('</scr' .. 'ipt>') then
		self.DownloadStatus = 'Downloading VersionInfo (100%)'
		local a, b = self.File:find('\r\n\r\n')
		self.File = self.File:sub(a, -1)
		self.NewFile = ''
		for line, content in ipairs(self.File:split('\n')) do
			if content:len() > 5 then
				self.NewFile = self.NewFile .. content
			end
		end
		local HeaderEnd, ContentStart = self.File:find('<scr' .. 'ipt>')
		local ContentEnd, _ = self.File:find('</sc' .. 'ript>')
		if not ContentStart or not ContentEnd then
			if self.CallbackError and type(self.CallbackError) == 'function' then
				self.CallbackError()
			end
		else
			self.OnlineVersion =(Base64Decode(self.File:sub(ContentStart + 1, ContentEnd - 1)))
			self.OnlineVersion = tonumber(self.OnlineVersion)
			if self.OnlineVersion > self.LocalVersion then
				if self.CallbackNewVersion and type(self.CallbackNewVersion) == 'function' then
					self.CallbackNewVersion(self.OnlineVersion, self.LocalVersion)
				end
				self:CreateSocket(self.ScriptPath)
				self.DownloadStatus = 'Connect to Server for ScriptDownload'
				AddTickCallback( function() self:DownloadUpdate() end)
			else
				if self.CallbackNoUpdate and type(self.CallbackNoUpdate) == 'function' then
					self.CallbackNoUpdate(self.LocalVersion)
				end
			end
		end
		self.GotScriptVersion = true
	end
end

function ScriptUpdate:DownloadUpdate()
	if self.GotScriptUpdate then return end
	self.Receive, self.Status, self.Snipped = self.Socket:receive(1024)
	if self.Status == 'timeout' and not self.Started then
		self.Started = true
		self.Socket:send("GET " .. self.Url .. " HTTP/1.1\r\nHost: sx-bol.eu\r\n\r\n")
	end
	if (self.Receive or(#self.Snipped > 0)) and not self.RecvStarted then
		self.RecvStarted = true
		self.DownloadStatus = 'Downloading Script (0%)'
	end

	self.File = self.File ..(self.Receive or self.Snipped)
	if self.File:find('</si' .. 'ze>') then
		if not self.Size then
			self.Size = tonumber(self.File:sub(self.File:find('<si' .. 'ze>') + 6, self.File:find('</si' .. 'ze>') -1))
		end
		if self.File:find('<scr' .. 'ipt>') then
			local _, ScriptFind = self.File:find('<scr' .. 'ipt>')
			local ScriptEnd = self.File:find('</scr' .. 'ipt>')
			if ScriptEnd then ScriptEnd = ScriptEnd - 1 end
			local DownloadedSize = self.File:sub(ScriptFind + 1, ScriptEnd or -1):len()
			self.DownloadStatus = 'Downloading Script (' .. round(100 / self.Size * DownloadedSize, 2) .. '%)'
		end
	end
	if self.File:find('</scr' .. 'ipt>') then
		self.DownloadStatus = 'Downloading Script (100%)'
		local a, b = self.File:find('\r\n\r\n')
		self.File = self.File:sub(a, -1)
		self.NewFile = ''
		for line, content in ipairs(self.File:split('\n')) do
			if content:len() > 5 then
				self.NewFile = self.NewFile .. content
			end
		end
		local HeaderEnd, ContentStart = self.NewFile:find('<sc' .. 'ript>')
		local ContentEnd, _ = self.NewFile:find('</scr' .. 'ipt>')
		if not ContentStart or not ContentEnd then
			if self.CallbackError and type(self.CallbackError) == 'function' then
				self.CallbackError()
			end
		else
			local newf = self.NewFile:sub(ContentStart + 1, ContentEnd - 1)
			local newf = newf:gsub('\r', '')
			if newf:len() ~= self.Size then
				if self.CallbackError and type(self.CallbackError) == 'function' then
					self.CallbackError()
				end
				return
			end
			local newf = Base64Decode(newf)
			if type(load(newf)) ~= 'function' then
				if self.CallbackError and type(self.CallbackError) == 'function' then
					self.CallbackError()
				end
			else
				local f = io.open(self.SavePath, "w+b")
				f:write(newf)
				f:close()
				if self.CallbackUpdate and type(self.CallbackUpdate) == 'function' then
					self.CallbackUpdate(self.OnlineVersion, self.LocalVersion)
				end
			end
		end
		self.GotScriptUpdate = true
	end
end

--------------------
	-- Global --
--------------------

-- Attack --
function Attack()
	if Target == nil then return end
	if GetDistance(Target) > 100 then return end
	if orbwalker == "sac" and _G.AutoCarry then
		_G.AutoCarry.Crosshair:ForceTarget(_G.AutoCarry.Orbwalker:CanOrbwalkTarget(Target) and Target or nil)
	elseif orbwalker == "nebel" and _G.NebelwolfisOrbWalkerInit then 
		_G.NebelwolfisOrbWalker:SetTarget(Target)
	elseif orbwalker == "vp" then
		SxOrb:ForceTarget(Target)
	else
		myHero:Attack(Target)
	end
end
-- Target Selected --
function OnWndMsg(msg,key)
	if msg == WM_LBUTTONDOWN then
		local enemy, distance = _Tech:ClosestEnemy(mousePos) 
		
		if distance < 150 then SelectedTarget = enemy end
		end
	local targetSelected = nil

	if msg == WM_LBUTTONDOWN then
		local enemyDistance, enemySelected = 0, nil
		for _,enemy in pairs(GetEnemyHeroes()) do
			if ValidTarget(enemy) and GetDistance(enemy, mousePos) < 200 then 
				if GetDistance(enemy, mousePos) <= enemyDistance or not enemySelected then
					enemyDistance = GetDistance(enemy, mousePos)			
					enemySelected = enemy
				end
			end
		end
		
		if enemySelected then
			if not targetSelected or targetSelected.hash ~= enemySelected.hash then
				targetSelected = enemySelected
				
				_Bundle:Print('Target Selected: '..targetSelected.charName)
			else
				targetSelected = nil
				
				_Bundle:Print('Target unselected!')
			end
		end	
	end
end

-- Checks If Spells Are Ready --
function IsReady(spell)
	return  (myHero:CanUseSpell(spell) == 0)  
end

-- Math For Round --
function Round(number)
	if number >= 0 then 
		return math.floor(number+.5) 
	else 
		return math.ceil(number-.5) 
	end
end 

function CountObjectsInCircle(pos, radius, array)
	if not pos then return -1 end
	if not array then return -1 end

	local n = 0
	for _, object in pairs(array) do
		if GetDistance(pos, object) <= radius and not object.dead then n = n + 1 end 
	end
	return n
end

function FindBestCircle(target, range, radius, slot)
	local points = {}
	
	local rgDsqr = (range + radius) * (range + radius)
	local diaDsqr = (radius * 2) * (radius * 2)

	local Position = VPred:GetPredictedPos(target, 0.25)

	table.insert(points,Position)
	
	for i, enemy in ipairs(GetEnemyHeroes()) do
		if enemy.networkID ~= target.networkID and not enemy.dead and GetDistanceSqr(enemy) <= rgDsqr and GetDistanceSqr(target,enemy) < diaDsqr then
			local Position = VPred:GetPredictedPos(enemy, 0.25)
			table.insert(points, Position)
		end
	end
	
	while true do
		local MECObject = MEC(points)
		local OurCircle = MECObject:Compute()
		
		if OurCircle.radius <= radius then
			return OurCircle.center, #points
		end
		
		local Dist = -1
		local MyPoint = points[1]
		local index = 0
		
		for i=2, #points, 1 do
			local DistToTest = GetDistanceSqr(points[i], MyPoint)
			if DistToTest >= Dist then
				Dist = DistToTest
				index = i
			end
		end
		if index > 0 then
			table.remove(points, index)
		else
			return points[1], 1
		end
	end
end

-- In degrees
function AngleDifference(from, p1, p2)
	local p1Z = p1.z - from.z
	local p1X = p1.x - from.x
	local p1Angle = math.atan2(p1Z , p1X) * 180 / math.pi
	
	local p2Z = p2.z - from.z
	local p2X = p2.x - from.x
	local p2Angle = math.atan2(p2Z , p2X) * 180 / math.pi
	
	return math.sqrt((p1Angle - p2Angle) ^ 2)
end

-- Get point on a line closest to the target --
function pointOnLine(End, Start, unit, extra, range)
	local toUnit = {x = unit.x - Start.x, z = unit.z - Start.z}
	local toEnd = {x = End.x - Start.x, z = End.z - Start.z}

	local magitudeToEnd = toEnd.x ^ 2 + toEnd.z ^ 2
	local dotP = toUnit.x * toEnd.x + toUnit.z * toEnd.z

	local distance = dotP / magitudeToEnd
	local x, z = Start.x + toEnd.x * (distance + extra), Start.z + toEnd.z * (distance + extra)
	
	if math.sqrt((x - myHero.x) ^ 2 + (z - myHero.z) ^ 2) < range then 
		return {x = x, z = z}
	else
		return Normalize({x = Start.x + toEnd.x * (distance + extra), z = Start.z + toEnd.z * (distance + extra)}, myHero, range)
	end
end

function Normalize(pos, start, range)
	local castX = start.x + range * ((pos.x - start.x) / GetDistance(pos))
	local castZ = start.z + range * ((pos.z - start.z) / GetDistance(pos))
	
	return {x = castX, z = castZ}
end

function CalculateTargetPosition(unit, delay)
	if unit.pathCount > 0 then
		for i = unit.pathIndex, unit.pathCount do
			if unit:GetPath(i) and unit:GetPath(i-1) then
				local pStart = i == unit.pathIndex and unit.pos or unit:GetPath(i-1)
				local pEnd = unit:GetPath(i)
				local iPathDist = GetDistance(pStart, pEnd)
				local travelTime = iPathDist / unit.ms
				
				if travelTime > delay then
					return Vector(unit) + (Vector(pEnd) - Vector(pStart)):normalized() * delay * unit.ms
				else 
					delay = delay - travelTime
				end
			end
		end
	else
		return unit
	end
end

function CountEnemyHero(Target, Range)
	if Target == nil then return end
	local Enemies = GetEnemyHeroes()
	local Nums = 0
	for idx, val in ipairs(Enemies) do
		if val.networkID ~= Target.networkID and ValidTarget(val) and GetDistance(Target, val) < Range and not val.dead then
			Nums = Nums + 1
		end
	end
	return Nums
end

function a2v ( a, m )
  m = m or 1
  local x = math.cos ( a ) * m
  local y = math.sin ( a ) * m
  return x, y
end


