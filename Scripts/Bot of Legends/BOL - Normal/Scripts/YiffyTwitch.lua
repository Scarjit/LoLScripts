-- Yiffy Twitch by Furry
-- Encrypted by burn [Kappa^Bilbao]
-- Version 3.21 [Yiffy Twitch re-release]


_AUTO_UPDATE = true -- Set this to false to prevent automatic updates

--			[ ChangeLog ]
--  Check forum:
--  http://forum.botoflegends.com/topic/84420-vipfreesxorbsacr-yiffy-twitch-patch-521/
--			[ ChangeLog ]

if myHero.charName ~= 'Twitch' then return end
_SCRIPT_VERSION = 3.21
_SCRIPT_VERSION_MENU = "3.21"
_FILE_PATH = SCRIPT_PATH .. GetCurrentEnv().FILE_NAME
_PATCH = "5.22"

class("Twitch")
function Twitch:__init()
	self.items = {}
	self.skills = {	-- fight me, some of these aren't even used, it's just easier to scroll up here and get the information I need.
		SkillQ = {
			ready = false,
		},
		SkillW = {
			range = 950,
			--width = 300,
			--speed = 1750,
			--delay = 0.25,
			ready = false,
		},
		SkillE = {
			range = 1200,
			ready = false,
		},
		SkillR = {
			range = 850,
			ready = false,
		}
	}
	self.summonerSpells = {
		ignite = {},
		flash = {},
		heal = {},
		barrier = {}
	}
	self.igniteFound = false
	self.flashFound = false
	_G.myHero.SaveMove = _G.myHero.MoveTo
	_G.myHero.SaveAttack = _G.myHero.Attack
end

function findorbwalker()
	if _G.Reborn_Loaded then
		SAC = print("<font color='#00FF00'>[Yiffy Twitch] </font><font color='#FF00FF'>-</font><font color='#FF8B22'> SAC</font><font color='#FF00FF'>:</font><font color='#FF8B22'>Reborn</font><font color='#FFFFFF'> Loading... Please wait! </font>")
		DelayAction(function()
		settings:addSubMenu("Orbwalker", "orbWalk")
		settings.orbWalk:addParam("SACLoaded", "SAC:R integration supported!", SCRIPT_PARAM_INFO, "")
		end, 5)
	elseif not _G.Reborn_Loaded and FileExist(LIB_PATH .. "SxOrbWalk.lua") then
		print("<font color='#00FF00'>[Yiff Twitch] </font><font color='#FF00FF'>-</font><font color='#FF8B22'>SxOrbWalk</font><font color='#FFFFFF'> Loading... Please wait! </font>")
		SxOrb = true
		require("SxOrbWalk")
		DelayAction(function()
		settings:addSubMenu("SxOrbWalk", "orbWalk")
		end, 5)
		DelayAction(function()
		_G.SxOrb:LoadToMenu(settings.orbWalk)
		end, 5)
	elseif SAC ~= true and SxOrb ~= true then
		print("<font color='#00FF00'>[Yiffy Twitch] </font><font color='#FF00FF'>-</font><font color='#FF8B22'> SAC</font><font color='#FF00FF'>:</font><font color='#FF8B22'>Reborn</font><font color='#FFFFFF'> or </font><font color='#FF8B22'>SxOrbWalk</font><font color='#FFFFFF'> is required.</font>")
	end
end

local Qwind = 0
local Wwind = 0
local Ewind = 0
local Rwind = 0

local readytextQ = false
local channelingQ = false
local stealthQ = false
local readytextW = false
local readytextE = false
local etext = false
local readytextR = false

local DeadlyVenom = {}
local VP
local VisibleSelf = true
local stealthLocation = 0
local cfgpath = LIB_PATH.."Saves\\Yiffy_Twitch_2.cfg"
local skinsPB = {}
local skinObjectPos = nil
local skinHeader = nil
local dispellHeader = nil
local skinH = nil
local skinHPos = nil
local level, tolevel, point, leveltick, levelvariable, spellLevel, latency
local enable = false
local drawlevelup = false
local leveltext = ""

function CurrentTimeInMillis()
	return (os.clock() * 1000);
end
local lastTimeTickCalled = 0

function Twitch:OnTick()
	settings.target = self:GetTarget()
	self:checks()
	AntiAFKSystem()
	if settings.target then
		if settings.comboactive then
			self:Combo(settings.target)
		elseif settings.harassKey then
			self:harass(settings.target)
		end
	end
	if settings.killsteal.killstealE and self.skills.SkillE.ready then
		self:KillSteal()
	end
	if settings.killsteal.ignite and self.igniteFound ~= nil then
		self:AutoIgnite()
	end
	if settings.instruct then
		settings.instruct = false
		PopUp1 = true
	end
	if settings.Wsettings.safeWKey then
		if GetDistance(mousePos) > 950 then
			Wcast = myHero + (Vector(mousePos) - myHero):normalized() * 950
			CastSpell(_W, Wcast.x, Wcast.z)
		end
	end
	if self.skills.SkillQ.ready and settings.Qsettings.UseQLowHp and myHero.health / myHero.maxHealth <= settings.Qsettings.QLowHp / 100 then
		self:Cast("Q", target)
	end
	if settings.draws.DrawW and self.skills.SkillW.ready then
		Wup = true
	else
		Wup = false
	end
	if settings.draws.DrawW2 and self.skills.SkillW.ready then
		W2up = true
	else
		W2up = false
	end
	if settings.draws.DrawE and self.skills.SkillE.ready then
		Eup = true
	else
		Eup = false
	end
	if StealthProcess then
		if myHero.health < StealthProcess.hp then
			if os.clock() > StealthProcess.started + 4.5 then
				StealthProcess = {
					started = StealthProcess.started,
					last = StealthProcess.started + 4.5,
					hp = myHero.health
				}
			else
				StealthProcess = {
					started = StealthProcess.started,
					last = os.clock(),
					hp = myHero.health
				}
			end
		else
			StealthProcess.hp = myHero.health
		end
	end
	if ((CurrentTimeInMillis() - lastTimeTickCalled) > 200) then
		lastTimeTickCalled = CurrentTimeInMillis()
		if settings.selectedTwitchSkin ~= lastSkin then
			lastSkin = settings.selectedTwitchSkin
			SendSkinPacket(myHero.charName, skinsPB[settings.selectedTwitchSkin], myHero.networkID)
		end
	end
	if not settings.AutoLevelOn or not enable then
		return
	end
	if myHero.level ~= level then
		if point then
			if myHero:GetSpellData(levelvariable).level ~= spellLevel then
				showLeveledSpell(levelvariable)
				Levelend()
			elseif GetTickCount() > leveltick + latency * 2 then
				Levelstart()
			end
		else
			if not Config() then
				Error()
			return
			end
			Levelstart()
		end
	end
end

function OnLoad()
	require("VPrediction")
	VP = VPrediction()
	settings = scriptConfig("> > > Yiffy Twitch < < <", "twitchreborn")
			settings.ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, 1200, DAMAGE_PHYSICAL, true)
			settings.ts.name = 'Twitch'
			settings:addTS(settings.ts)
		settings:addSubMenu("Q Settings", "Qsettings")
			settings.Qsettings:addParam("UseQ", "Use Q if number of enemies", SCRIPT_PARAM_ONOFF, true)
			settings.Qsettings:addParam("QEnemies", "    Set number of enemies to Q", SCRIPT_PARAM_SLICE, 3, 0, 5, 0)
			settings.Qsettings:addParam("UseQLowHp", "Use Q On Low Health", SCRIPT_PARAM_ONOFF, true)
			settings.Qsettings:addParam("QLowHp", "    Set Low Health %", SCRIPT_PARAM_SLICE, 30, 0, 100, 0)
			settings.Qsettings:addParam("space", "", SCRIPT_PARAM_INFO, "")
			settings.Qsettings:addParam("AlwaysQB", "Use Q on Recall", SCRIPT_PARAM_ONOFF, true)
		settings:addSubMenu("W Settings", "Wsettings")
			settings.Wsettings:addParam("ComboW", "Use W in Combo", SCRIPT_PARAM_ONOFF, true)
			settings.Wsettings:addParam("WEnemies", "    Use W - number of enemies", SCRIPT_PARAM_SLICE, 1, 0, 5, 0)
			settings.Wsettings:addParam("safeWKey", "Max Range Secure Key", SCRIPT_PARAM_ONKEYDOWN, false, GetKey("W"))
			settings.Wsettings:addParam("safeinfo", "    Please make sure this is bound", SCRIPT_PARAM_INFO, "")
			settings.Wsettings:addParam("safeinfo2", "    to your Vendom Clask key.", SCRIPT_PARAM_INFO, "")
		settings:addSubMenu("E Settings", "Esettings")
			settings.Esettings:addParam("UseE", "Use E On number of stacks", SCRIPT_PARAM_ONOFF, true)
			settings.Esettings:addParam("EStacks", "    Set number of E stacks:", SCRIPT_PARAM_SLICE, 6, 1, 6, 0)
			settings.Esettings:addParam("OutOfRange", "Use E if target is leaving range", SCRIPT_PARAM_ONOFF, false)
		settings:addSubMenu("R Settings", "Rsettings")
			settings.Rsettings:addParam("UseR", "Use R on grouped enemies", SCRIPT_PARAM_ONOFF, true)
			settings.Rsettings:addParam("REnemies", "    Set number of grouped enemies", SCRIPT_PARAM_SLICE, 3, 1, 5, 0)
			settings.Rsettings:addParam("space", "", SCRIPT_PARAM_INFO, "")
			settings.Rsettings:addParam("useItems", "Use items in Combo(not tested!)", SCRIPT_PARAM_ONOFF, true)
	if VIP_USER then
		settings:addSubMenu("Misc", "misc")
			settings.misc:addParam("Debug", "Debugger", SCRIPT_PARAM_ONOFF, true)
			settings.misc:addParam("ChatDebug", "Add Chat Debug", SCRIPT_PARAM_ONOFF, false)
			settings.misc:addParam("Mode","Prediction Mode",SCRIPT_PARAM_LIST,1,{"VPrediction"})
			settings.misc:addParam("VPHitChance","VPrediction HitChance",SCRIPT_PARAM_LIST,3,{"[0]Target Position","[1]Low Hitchance","[2]High Hitchance","[3]Target slowed/close","[4]Target immobile","[5]Target Dashing"})
			settings.misc:addParam("VIPHitChance","VIP HitChance: ",SCRIPT_PARAM_SLICE,0.7,0.1,1,2)
	else
		settings:addSubMenu("Misc", "misc")
			settings.misc:addParam("G","[General Prediction Settings]",SCRIPT_PARAM_INFO,"")
			settings.misc:addParam("Mode","Prediction Mode",SCRIPT_PARAM_LIST,1,{"VPrediction"})
			settings.misc:addParam("D","[Detail Prediction Settings]",SCRIPT_PARAM_INFO,"")
			settings.misc:addParam("VPHitChance","VPrediction HitChance",SCRIPT_PARAM_LIST,3,{"[0]Target Position","[1]Low Hitchance","[2]High Hitchance","[3]Target slowed/close","[4]Target immobile","[5]Target Dashing"})
	end
		settings:addSubMenu("Harass", "harass")
			settings.harass:addParam("harassw", "Use W in Harass", SCRIPT_PARAM_ONOFF, true)
			settings.harass:addParam("space", "", SCRIPT_PARAM_INFO, "")
			settings.harass:addParam("harasse", "Use E On number of stacks", SCRIPT_PARAM_ONOFF, true)
			settings.harass:addParam("EStacks", "     Set number of E stacks:", SCRIPT_PARAM_SLICE, 3, 0, 6, 0)
		settings:addSubMenu("Kill Steal", "killsteal")
			settings.killsteal:addParam("killstealE", "Killsteal with E", SCRIPT_PARAM_ONOFF, true)
		settings:addSubMenu("Auto Level", "autolvl")
			if VIP_USER then
				settings.autolvl:addParam("getAllAtLevel", "Have Q, W and E by level:", SCRIPT_PARAM_SLICE, 3, 3, 4, 0)
				settings.autolvl:addParam("info", "Level priority:", SCRIPT_PARAM_INFO, "")
				settings.autolvl:addParam("maxQ", "Level (Q) priority", SCRIPT_PARAM_SLICE, 3, 1, 4, 0)
				settings.autolvl:addParam("maxW", "Level (W) priority", SCRIPT_PARAM_SLICE, 4, 1, 4, 0)
				settings.autolvl:addParam("maxE", "Level (E) priority", SCRIPT_PARAM_SLICE, 2, 1, 4, 0)
				settings.autolvl:addParam("maxR", "Level (R) priority", SCRIPT_PARAM_SLICE, 1, 1, 4, 0)
				settings.autolvl:addParam("info", "1 = Highest priority", SCRIPT_PARAM_INFO, "")
				settings.autolvl:addParam("info", "4 = Lowest priority", SCRIPT_PARAM_INFO, "")
				settings.autolvl:addParam("space", "", SCRIPT_PARAM_INFO, "")
				settings.autolvl:addParam("DrawText", "Draw Levelup Text (On Champion)", SCRIPT_PARAM_ONOFF, true)
				settings.autolvl:addParam("DrawTextSlider", "Time of text (Seconds)", SCRIPT_PARAM_SLICE, 3, 1, 5, 0)
				level = 0
				point = false
				enable = true
			end
		settings:addSubMenu("Drawing", "draws")
			settings.draws:addParam("DrawQ", "Draw Invisibility", SCRIPT_PARAM_ONOFF, true)
			settings.draws:addParam("stealthTimer", "Draw Stealth Countdown", SCRIPT_PARAM_ONOFF, true)
			settings.draws:addParam("stealthDistance", "Draw Stealth Distance", SCRIPT_PARAM_ONOFF, true)
			settings.draws:addParam("DrawW", "Draw W Range", SCRIPT_PARAM_ONOFF, true)
			settings.draws:addParam("DrawW2", "Draw W Radius", SCRIPT_PARAM_ONOFF, true)
			settings.draws:addParam("DrawWtext", "Draw W Text", SCRIPT_PARAM_ONOFF, true)
			settings.draws:addParam("DrawE", "Draw E Range", SCRIPT_PARAM_ONOFF, true)
			settings.draws:addParam("Estack", "Draw E Stacks", SCRIPT_PARAM_ONOFF, true)
			settings.draws:addParam("poisonTimer", "Draw Poison Time", SCRIPT_PARAM_ONOFF, true)
			settings.draws:addParam("executeIndicator", "Draw E Damage Indicator", SCRIPT_PARAM_ONOFF, true)
			-- Might be working on an Akali script next, but that's just a rumor~ ~ ~
			settings.draws:addParam("DrawHitBox", "Draw Hit Box", SCRIPT_PARAM_ONOFF, true)
			settings.draws:addParam("LFCwidth", "LFC - Width", 4, 2, 1, 5, 0)
			settings.draws:addParam("LFCsnap", "LFC - Length Before Snapping", 4, 100, 50, 510, 0)
			settings.draws:addParam("space", "", SCRIPT_PARAM_INFO, "")
			settings.draws:addParam("particles", "Draw Particles", SCRIPT_PARAM_ONOFF, true)
			settings.draws:addParam("SizeE", "Size of E Stack Text", SCRIPT_PARAM_SLICE, 25, 10, 50, 0)
			settings.draws:addParam("drawkillable", "Draw Damage Text on Enemy", SCRIPT_PARAM_ONOFF, true)
			settings.draws:addParam("nameenable", "Do You Have InGame Names Enabled?", SCRIPT_PARAM_ONOFF, true)
			settings.draws:addParam("lineoffset", "Draw Bar Offset (moves down)", SCRIPT_PARAM_ONOFF, false)
				settings.draws:addSubMenu("Colors:", "color")
					settings.draws.color:addParam("stealthDistancecolor", "Stealth Distance Color", SCRIPT_PARAM_COLOR, {
						255,
						255,
						0,
						0
					})
					settings.draws.color:addParam("Wcolor", "W Range Color", SCRIPT_PARAM_COLOR, {
						100,
						 32,
						178,
						170
					})
					settings.draws.color:addParam("Wcolor2", "W Radius Color", SCRIPT_PARAM_COLOR, {
						100,
						255,
						255,
						0
					})
					settings.draws.color:addParam("Ecolor", "E Range Color", SCRIPT_PARAM_COLOR, {
						255,
						128,
						0,
						128
					})
					settings.draws.color:addParam("stacksE", "E Stacks Color", SCRIPT_PARAM_COLOR, {
						255,
						0,
						255,
						255
					})
					settings.draws.color:addParam("space", "", SCRIPT_PARAM_INFO, "")
					settings.draws.color:addParam("HitBoxcolor", "Hit Box Color", SCRIPT_PARAM_COLOR, {
						200,
						255,
						180,
						0
					})
					settings.draws.color:addParam("particlescolor", "Particles Color", SCRIPT_PARAM_COLOR, {
						255,
						255,
						0,
						255
					})
		findorbwalker()
		settings:addParam("comboactive", "Combo Key", SCRIPT_PARAM_ONKEYDOWN, false, 32)
		settings:addParam("harassKey", "Harass Key", SCRIPT_PARAM_ONKEYDOWN, false, GetKey("C"))
		settings:addParam("space", "", SCRIPT_PARAM_INFO, "")
		settings:addParam("instruct", "Click For Instructions", SCRIPT_PARAM_ONOFF, false)
		Clock = os.clock()
		settings:addParam("antiAFK", "Anti AFK", SCRIPT_PARAM_ONOFF, true)
		if VIP_USER then
			settings:addParam("AutoLevelOn", "Auto level", SCRIPT_PARAM_ONOFF, true)
			settings.AutoLevelOn = true
		end
		settings:addParam("theversion", "Version: ", SCRIPT_PARAM_INFO, tostring(_SCRIPT_VERSION_MENU))
		print("<font color='#00FF00'>[Yiffy Twitch] <font color='#FF00FF'>-</font></font><font color='#FFFFFF'> by </font><font color='#FF8B22'>Furry</font> <font color='#FFFFFF'>Version </font><font color='#00FFFF'>" .. _SCRIPT_VERSION_MENU .. "</font><font color='#FFFFFF'> Patch: </font><font color='#00FFFF'>" .. _PATCH .. "</font>")
		if _AUTO_UPDATE then
			GetAsyncWebResult("raw.github.com", "/FurryBoL/master/master/YiffyTwitch.version", function(result)
				local latest = tonumber(result)
				if latest > _SCRIPT_VERSION then
					print("<font color='#00FF00'>[Yiffy Twitch] </font><font color='#FF00FF'>-</font><font color='#FFFFFF'> A update has been found and it is now downloading!</font>")
					DelayAction(DownloadFile, 0, {
						"https://raw.githubusercontent.com/FurryBoL/master/master/YiffyTwitch.lua",
						_FILE_PATH,
						function()
							print("<font color='#00FF00'>[Yiffy Twitch] </font><font color='#FF00FF'>-</font><font color='#FFFFFF'> Script has been updated, please reload! (2xF9)</font>")
						end
					})
				end
			end)
		end
		settings:addParam("thepatch", "Patch:", SCRIPT_PARAM_INFO, _PATCH)
		settings:addParam("furry", "Yiffy Twitch By:", SCRIPT_PARAM_INFO, "Furry")
				settings:permaShow("comboactive")
				settings:permaShow("harassKey")
				settings:permaShow("AutoLevelOn")
		if VIP_USER then
			settings:addParam("selectedTwitchSkin", "Skin Changer", SCRIPT_PARAM_LIST, 1, {
				[1] = 'Off',
				[2] = 'Original',
				[3] = 'Kingpin',
				[4] = 'Whistler Village',
				[5] = 'Medieval',
				[6] = 'Gangster',
				[7] = 'Vandal',
				[8] = 'Pickpocket',
				[9] = 'SSW',
			})
		end
	if FileExist(cfgpath) == false then
		settings.instruct = true
		WriteFile("Delete this file if you want to run instructions on first load.", cfgpath)
	else
		settings.instruct = false
	end
	for _, target in ipairs(GetEnemyHeroes()) do
		DeadlyVenom[target.networkID] = {
			stack = 0
		}
	end
	db = DrawBar()
end

function OnUnload()
	print("<font color='#00FF00'>[Yiffy Twitch] </font><font color='#FF00FF'>-</font><font color='#FFFFFF'> Unloaded! </font>")
	if VIP_USER then
		SendSkinPacket(myHero.charName, nil, myHero.networkID)
	end
end

function Twitch:checks()
	self.skills.SkillQ.ready = myHero:CanUseSpell(_Q) == READY
	self.skills.SkillW.ready = myHero:CanUseSpell(_W) == READY
	self.skills.SkillE.ready = myHero:CanUseSpell(_E) == READY
	self.skills.SkillR.ready = myHero:CanUseSpell(_R) == READY
	if not self.igniteFound then
		if myHero:GetSpellData(SUMMONER_1).name:find("summonerdot") then
			self.igniteFound = true
			self.summonerSpells.ignite = SUMMONER_1
			settings.killsteal:addParam("ignite", "Auto Ignite", SCRIPT_PARAM_ONOFF, true)
		elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerdot") then
			self.igniteFound = true
			self.summonerSpells.ignite = SUMMONER_2
			settings.killsteal:addParam("ignite", "Auto Ignite", SCRIPT_PARAM_ONOFF, true)
		end
	end
	if not self.flashFound then
		if myHero:GetSpellData(SUMMONER_1).name:find("summonerflash") then
			self.flashFound = true
			self.summonerSpells.flash = SUMMONER_1
		elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerflash") then
			self.flashFound = true
			self.summonerSpells.flash = SUMMONER_2
		end
	end
	self.items = {
		BLACKFIRE = {id = 3188, range = 750},
		BRK = {id = 3153, range = 500},
		BWC = {id = 3144, range = 450},
		HXG = {id = 3146, range = 700},
		ODYNVEIL = {id = 3180, range = 525},
		DVN = {id = 3131, range = 200},
		ENT = {id = 3184, range = 350},
		HYDRA = {id = 3074, range = 350},
		TIAMAT = {id = 3077, range = 350},
		YGB = {id = 3142, range = 350}
	}
end

function CountEnemyNearPerson(a, target)
	count = 0
	for i = 1, heroManager.iCount do
		currentEnemy = heroManager:GetHero(i)
		if currentEnemy.team ~= myHero.team and target >= GetDistance(currentEnemy, a) and not currentEnemy.dead then
			count = count + 1
		end
	end
return count
end

function Twitch:KillSteal()
	local target = false
	for _, target in pairs(GetEnemyHeroes()) do
		if ValidTarget(target) and GetDistance(myHero, target) <= 1200 then
			if DeadlyVenom[target.networkID] ~= nil then
				if self:GetEDmg(target) > target.health then
					if settings.misc.Debug and settings.misc.ChatDebug then
						print("<font color='#00FF00'>[Yiffy Twitch] </font><font color='#FF00FF'>-</font><font color='#FFFFFF'> Predicting E KillSteal " .. math.round(self:GetEDmg(target)) .. "</font>")
					end
					CastSpell(_E)
					return
				elseif self:GetEDmg(target) < target.maxHealth * 0.3 and 1200 then
					target = true
				end
			end
		end
	end
end

function Twitch:GetDrawText(target)
-- [chucka, chucka, chucka]
end

function Twitch:Combo(target)
	if settings.Rsettings.useItems then
		self:UseItems(target)
	end
	if  settings.Qsettings.UseQ and self.skills.SkillQ.ready and CountEnemyHeroInRange(1000) >= settings.Qsettings.QEnemies then
		self:Cast("Q", target)
	end
	if settings.Esettings.UseE and self.skills.SkillE.ready and DeadlyVenom[target.networkID] ~= nil then
		if GetDistance(target) <= self.skills.SkillE.range and DeadlyVenom[target.networkID].stack == settings.Esettings.EStacks then
			self:Cast("E", target)
		end
		if settings.Esettings.OutOfRange then
			for _, target in pairs(GetEnemyHeroes()) do 
				if DeadlyVenom[target.networkID].stack >= 4 and ValidTarget(target, 1100) then
					CastSpell(_E)
				end
			end
		end
	end
	if settings.Wsettings.ComboW and GetDistanceSqr(myHero, target) <= self.skills.SkillW.range * self.skills.SkillW.range then
		WCircularCast(target)
	end
	if settings.Rsettings.UseR and self.skills.SkillR.ready and GetDistance(myHero, target) <= self.skills.SkillR.range and CountEnemyNearPerson(target, 350) >= settings.Rsettings.REnemies then
		self:Cast("R", target)
	end
end

function Twitch:harass(target)
	if settings.harass.harassw and GetDistanceSqr(myHero, target) <= 950 * 950 then
		WCircularCast(target)
	end
	if settings.harass.harasse and self.skills.SkillE.ready and DeadlyVenom[target.networkID] ~= nil then
		if GetDistance(target) <= self.skills.SkillE.range and DeadlyVenom[target.networkID].stack >= settings.harass.EStacks then
			self:Cast("E", target)
		end
	end
end

function WCircularCast(target)
	if VIP_USER then
		local mainCastPosition, mainHitChance, points, mainPosition = VP:GetCircularAOECastPosition(target, 0.25, 300, 950, 1750, myHero)
		if mainCastPosition ~= nil and mainHitChance > 2 and points > 1 then
			SpellCast(_W, mainCastPosition)
		else
			if settings.misc.Mode == 1 then
				local CastPosition, HitChance, points = VP:GetCircularCastPosition(target, 0.25, 300, 950, 1750, myHero)
				if CastPosition ~= nil and HitChance >= (settings.misc.VPHitChance - 1) then
					SpellCast(_W, CastPosition)
				end
			end
		end
	else
		if settings.misc.Mode == 1 then
			local mainCastPosition, mainHitChance, points, mainPosition = VP:GetCircularAOECastPosition(target, 0.25, 300, 950, 1750, myHero)
			if mainCastPosition ~= nil and mainHitChance > 2 and points > 1 then
				SpellCast(_W, CastPosition)
			else
				local CastPosition,HitChance,points = VP:GetCircularCastPosition(target, 0.25, 300, 950, 1750, myHero)
				if CastPosition ~= nil and HitChance >= (settings.misc.VPHitChance - 1) then
					SpellCast(_W, CastPosition)
				end
			end
		end
	end
end

function SpellCast(spellSlot, castPosition)
	CastSpell(spellSlot, castPosition.x, castPosition.z)
end

function Twitch:GetTarget()
	settings.ts:update()
	if _G.AutoCarry and  _G.AutoCarry.Attack_Crosshair and _G.AutoCarry.Attack_Crosshair.target and _G.AutoCarry.Attack_Crosshair.target.type == myHero.type then 
		return _G.AutoCarry.Attack_Crosshair.target 
	elseif settings.ts.target and ValidTarget(settings.ts.target) then
		return settings.ts.target
	end
end

function Twitch:UseItems(a)
	for b, c in pairs(self.items) do
		local d = self.items[b]
		if GetInventoryItemIsCastable(d.id) and GetDistanceSqr(a) <= d.range * d.range then
			CastItem(d.id, a)
		end
	end
end

function Twitch:AutoIgnite()
	if self.igniteFound then
		if myHero:CanUseSpell(self.summonerSpells.ignite) == READY then
			for i, target in ipairs(GetEnemyHeroes()) do
				if ValidTarget(target, 600) and target.health <= getDmg('IGNITE', target, myHero) then
					CastSpell(self.summonerSpells.ignite, target)
				end
			end
		end
	end
end

function Twitch:Cast(spell, target)
	if spell == "Q" and target ~= nil and self.skills.SkillQ.ready then
		CastSpell(_Q, target)
	end
	if spell == "W" and target ~= nil and self.skills.SkillW.ready and GetDistance(myHero, target) < self.skills.SkillW.range then
		CastSpell(_W)
	end
	if spell == "E" and target ~= nil and self.skills.SkillE.ready then
		CastSpell(_E, target)
	end
	if spell == "R" and target ~= nil and self.skills.SkillR.ready then
		CastSpell(_R, target)
	end
end

function OnCreateObj(obj)
	if obj.name:lower():find("twitch_poison_counter_01") then
		PoisonStacker(obj, 1)
	elseif obj.name:lower():find("twitch_poison_counter_02") then
		PoisonStacker(obj, 2)
	elseif obj.name:lower():find("twitch_poison_counter_03") then
		PoisonStacker(obj, 3)
	elseif obj.name:lower():find("twitch_poison_counter_04") then
		PoisonStacker(obj, 4)
	elseif obj.name:lower():find("twitch_poison_counter_05") then
		PoisonStacker(obj, 5)
	elseif obj.name:lower():find("twitch_poison_counter_06") then
		PoisonStacker(obj, 6)
	end
	if obj.spellOwner == myHero and obj.name:find("missile") then
		Gobj = obj
	end
end

function PoisonStacker(obj, number)
	for _, target in pairs(GetEnemyHeroes()) do
		if ValidTarget(target) and target.visible and not target.dead and GetDistance(target, obj) < 50 then
			DeadlyVenom[target.networkID].stack = number
		end
	end
end


function OnProcessSpell(unit, buff)
	if unit and buff and unit.isMe and buff.name == myHero:GetSpellData(_Q).name then
		if settings.misc.Debug then
			channelingQ = true
			if settings.misc.ChatDebug then
				print("<font color='#00FF00'>[Yiffy Twitch] </font><font color='#FF00FF'>-</font><font color='#FFFFFF'> Channeling Stealth!</font>")
			end
		end
		StealthProcess = {
			started = os.clock(),
			last = os.clock(),
			hp = myHero.health
		}
	end
	if buff.name == myHero:GetSpellData(_Q).name then
		Qwind = buff.windUpTime
	elseif buff.name == myHero:GetSpellData(_W).name then
		Wwind = buff.windUpTime
	elseif buff.name == myHero:GetSpellData(_E).name then
		Ewind = buff.windUpTime
	elseif buff.name == myHero:GetSpellData(_R).name then
		Rwind = buff.windUpTime
	elseif GetDistance(unit) < 50 then
		AAwind = buff.windUpTime
	end
end

function OnUpdateBuff(target, buff, stacks)
	if target and buff and stacks then
		if buff.name == "TwitchHideInShadows" then
			VisibleSelf = false
			stealthLocation = os.clock()
			StealthProcess = nil
			if settings.misc.Debug then
				channelingQ = false
				stealthQ = true
				if settings.misc.Debug and settings.misc.ChatDebug then
					print("<font color='#00FF00'>[Yiffy Twitch] </font><font color='#FF00FF'>-</font><font color='#FFFFFF'> Twitch is Stealth!</font>")
				end
			end
		end
	end
	if buff.name == "twitchdeadlyvenom" then
		DeadlyVenom[target.networkID] = {
			stack = 6,
			time = os.clock(),
			hp = target.health
		}
	end
end

function OnRemoveBuff(target, buff)
	if target and buff then
		if buff.name == "twitchdeadlyvenom" then
			DeadlyVenom[target.networkID] = nil
			if settings.misc.Debug then
				if settings.misc.Debug and settings.misc.ChatDebug then
					print("<font color='#00FF00'>[Yiffy Twitch] </font><font color='#FF00FF'>-</font><font color='#FFFFFF'> Passive Stacks Removed!</font>")
				end
			end
		end
		if target.isMe and buff.name == "TwitchHideInShadows" then
			if settings.misc.Debug then
				stealthQ = false
				if settings.misc.Debug and settings.misc.ChatDebug then
					print("<font color='#00FF00'>[Yiffy Twitch] </font><font color='#FF00FF'>-</font><font color='#FFFFFF'> Twitch is no longer Stealth!</font>")
				end
			end
			VisibleSelf = true
			stealthLocation = 0
		end
	db:delete(target)
	end
end

function StealthTime()
	return myHero:GetSpellData(_Q).level > 0 and 3 + myHero:GetSpellData(_Q).level or 0
end

function Twitch:GetEDmg(target)
	if myHero:GetSpellData(_E).level < 1 then
		return 0
	end
	local BaseDamage = { 20, 35, 50, 65, 80}
	local StackDamage = { 15, 20, 25, 30, 35}
	local trueDmg = BaseDamage[myHero:GetSpellData(_E).level] + (((StackDamage[myHero:GetSpellData(_E).level]) + ((myHero.ap * (1 + myHero.apPercent)) * 0.2) + (myHero.damage * 0.25)) * DeadlyVenom[target.networkID].stack)
	return trueDmg * (100 / (100 + target.armor))
end

class("VisualManager")
function VisualManager:__init()
end
function VisualManager:OnDraw()
	local stealthTime = StealthTime()
	if os.clock() < stealthLocation + stealthTime then
		if settings.draws.stealthTimer then
			db:addLine(myHero, stealthLocation, stealthLocation + stealthTime, 255, 0, 255, 0, 255, 255, 0, 0, false)
		end
		if settings.draws.stealthDistance then
			self:DrawCircle(myHero.x, myHero.y, myHero.z, myHero.ms * (stealthLocation + StealthTime() - os.clock()) + myHero.boundingRadius, ARGB(table.unpack(settings.draws.color.stealthDistancecolor)))
			DelayAction(function ()
				db:delete(myHero)
			end,0.5)
		end
	elseif StealthProcess and os.clock() <= StealthProcess.last + 1.5 and settings.draws.stealthTimer then
		db:addLine(myHero, StealthProcess.last, StealthProcess.last + 1.5 + GetLatency() / 1000, 255, 255, 0, 0, 255, 0, 255, 0, false)
		DelayAction(function ()
			db:delete(myHero)
		end,0.5)
	end
	if settings.draws.Estack then
		for _, target in pairs(GetEnemyHeroes()) do
			if target.visible and not target.dead and DeadlyVenom[target.networkID] ~= nil and DeadlyVenom[target.networkID].stack >= 1 then
				local feetdraw = WorldToScreen(D3DXVECTOR3(target.x, target.y, target.z))
				DrawText(tostring(DeadlyVenom[target.networkID].stack .." Stacks"), settings.draws.SizeE, feetdraw.x, feetdraw.y, ARGB(table.unpack(settings.draws.color.stacksE)))
			end
		end
	end
	for _, target in pairs(GetEnemyHeroes()) do 
		if target.visible and not target.dead and DeadlyVenom[target.networkID] ~= nil and DeadlyVenom[target.networkID].stack >= 1 then
			if settings.draws.poisonTimer then
				db:addLine(target, DeadlyVenom[target.networkID].time, DeadlyVenom[target.networkID].time + 6, 255, 255, 0,255, 255,255, 0, 255, false)
				DelayAction(function ()
					db:delete(myHero)
				end,0.5)
			end
			if settings.draws.executeIndicator and myHero:CanUseSpell(_E) == READY and myHero:GetSpellData(_E).level > 0 then
				if DeadlyVenom[target.networkID] ~= nil then
					currLine = 1		
					DrawLineHPBar(Twitch:GetEDmg(target), currLine, "E Damage " .. math.round(Twitch:GetEDmg(target)), target)
					currLine = currLine + 1
				end
			end
		end
	end
	if settings.draws.drawkillable then
		for i, target in ipairs(GetEnemyHeroes()) do
			if ValidTarget(target) then
				if settings.draws.drawkillable then
					local pos = WorldToScreen(D3DXVECTOR3(target.x, target.y, target.z))
					local target_Text, color = Twitch:GetDrawText(target)
					if target_Text ~= nil then
						DrawText(target_Text, 18, pos.x - 40, pos.y - 10, color)
						self:DrawCircle(target.x, target.y, target.z, 100, ARGB(255, 255, 255, 255))
					end
				end
			end
		end
	end
	if settings.draws.DrawHitBox and not myHero.dead then
		self:DrawCircle(myHero.x, myHero.y, myHero.z, myHero.boundingRadius, ARGB(table.unpack(settings.draws.color.HitBoxcolor)))
	end
	if Wup then
		self:DrawCircle(myHero.x, myHero.y, myHero.z, 950, ARGB(table.unpack(settings.draws.color.Wcolor)))
	end
	if W2up then
		myPosV = Vector(myHero.x, myHero.z)
		mousePosV = Vector(mousePos.x, mousePos.z)
		if GetDistance(myPosV, mousePosV) < 950 - 60 then
			self:DrawCircle(mousePos.x, mousePos.y, mousePos.z, 330, ARGB(table.unpack(settings.draws.color.Wcolor)))	
		else
			finalV = myPosV+(mousePosV-myPosV):normalized()* (950 - 60)
			self:DrawCircle(finalV.x, myHero.y, finalV.y, 330, ARGB(table.unpack(settings.draws.color.Wcolor2)))
			if settings.draws.DrawWtext then
				DrawText3D("Cast W Here", finalV.x - 150, myHero.y, finalV.y + 50, 45, ARGB(table.unpack(settings.draws.color.Wcolor2)))
			end
		end
	end
	if Eup then
		self:DrawCircle(myHero.x, myHero.y, myHero.z, 1200, ARGB(table.unpack(settings.draws.color.Ecolor)))
	end
	if settings.draws.particles and not myHero.dead then
		if Gobj then
			self:DrawCircle(Gobj.x, Gobj.y, Gobj.z, 30, ARGB(table.unpack(settings.draws.color.particlescolor)))
		end
	end
	if settings.draws.DrawQ then
		local VisibleSelfvec = WorldToScreen(D3DXVECTOR3(myHero.x, myHero.y, myHero.z))
		if not myHero.dead then
			if not VisibleSelf then
				DrawText("STEALTH", 30, VisibleSelfvec.x - 55, VisibleSelfvec.y + 35, ARGB(255, 0, 255, 0))
			elseif VisibleSelf then
				DrawText("VISIBLE", 20, VisibleSelfvec.x - 32, VisibleSelfvec.y, ARGB(255, 255, 0, 0))
			end
		end
	end
	if PopUp1 then	-- Draw instructions Box and Text
		local w, h1, h2 = (WINDOW_W*0.50), (WINDOW_H*.15), (WINDOW_H*.9)
		DrawLine(w, h1/1.05, w, h2/1.97, w/1.75, ARGB(120, 63,236, 0 ))
		DrawLine(w, h1, w, h2/2, w/1.8, ARGB(120, 50, 0 , 0 ))
		DrawTextA(tostring("Welcome to Yiffy Twitch!"), WINDOW_H*.028, (WINDOW_W/2), (WINDOW_H*.18), ARGB(255, 0 , 255, 255),"center","center")
		DrawTextA(tostring("This is the Revamped Version of Yiffy Twitch!  It uses"), WINDOW_H*.015, (WINDOW_W/2.65), (WINDOW_H*.210), ARGB(255, 255, 255, 255))
		DrawTextA(tostring("drawings and calculations inspiried Challenger Series."), WINDOW_H*.015, (WINDOW_W/2.65), (WINDOW_H*.225), ARGB(255, 255, 255, 255))
		DrawTextA(tostring("Hold Spacebar to cast standard W + AA Combo."), WINDOW_H*.015, (WINDOW_W/2.65), (WINDOW_H*.240), ARGB(255, 255, 255, 255))
		DrawTextA(tostring("Script will Auto Detect Ignite(?) and will add it to KillSteal setting"), WINDOW_H*.015, (WINDOW_W/2.65), (WINDOW_H*.255), ARGB(255, 255, 255, 255))
		DrawTextA(tostring("When you Recall if you have Q available script will recal invisible"), WINDOW_H*.015, (WINDOW_W/2.65), (WINDOW_H*.270), ARGB(255, 255, 255, 255))
		DrawTextA(tostring("Please make setting adjustments in the Drawings menu to your liking! :)"), WINDOW_H*.015, (WINDOW_W/2.65), (WINDOW_H*.285), ARGB(255, 255, 255, 255))
		DrawTextA(tostring(""), WINDOW_H*.015, (WINDOW_W/2.65), (WINDOW_H*.300), ARGB(255, 255, 255, 255))
		DrawTextA(tostring("Script should Auto E when killable"), WINDOW_H*.015, (WINDOW_W/2.65), (WINDOW_H*.315), ARGB(255, 255, 255, 255))
		DrawTextA(tostring(""), WINDOW_H*.015, (WINDOW_W/2.65), (WINDOW_H*.330), ARGB(255, 255, 255, 255))
		DrawTextA(tostring("VIP Users unlock:"), WINDOW_H*.015, (WINDOW_W/2.65), (WINDOW_H*.345), ARGB(225, 225, 140, 0))
		DrawTextA(tostring("  Auto Leveler (updated 5.22)"), WINDOW_H*.015, (WINDOW_W/2.65), (WINDOW_H*.360), ARGB(255, 255, 255, 255))
		DrawTextA(tostring("  Skin Changer (updated 5.22)"), WINDOW_H*.015, (WINDOW_W/2.65), (WINDOW_H*.375), ARGB(255, 255, 255, 255))
		local w, h1, h2 = (WINDOW_W*0.49), (WINDOW_H*.70), (WINDOW_H*.75)
		DrawLine(w, h1/1.775, w, h2/1.68, w*.11, ARGB(255, 0 ,255,255))
		--DrawLine(w*.98, h1*.98, w*.98, h2*.98, w*.1*.98, ARGB(205,255,255,255))
		DrawRectangleButton(WINDOW_W*0.467, WINDOW_H/2.375, WINDOW_W*.047, WINDOW_H*.041, ARGB(255,150,255, 0 ))
		DrawTextA(tostring("OK"), WINDOW_H*.02, (WINDOW_W/2)*.98, (WINDOW_H/2.375), ARGB(255,0, 0, 0),"center","center")
	end
	if settings.autolvl.DrawText and SpellText ~= nil and drawlevelup then
		local spelldraw = WorldToScreen(D3DXVECTOR3(myHero.x, myHero.y, myHero.z))
		local spelldraw2 = spelldraw.x - 0
		local spelldraw3 = spelldraw.y - 0
		DrawText("Leveled:", 20, spelldraw2 - 30, spelldraw3 + 50, ARGB(255, 255, 255, 255))
		DrawText("" .. SpellText .. "", 30, spelldraw2 - 10, spelldraw3 + 65, ARGB(255, 0, 255, 255))
	end
end

function VisualManager:DrawCircle(x, y, z, radius, color)
	local vPos1 = Vector(x, y, z)
	local vPos2 = Vector(cameraPos.x, cameraPos.y, cameraPos.z)
	local tPos = vPos1 - (vPos1 - vPos2):normalized() * radius
	local sPos = WorldToScreen(D3DXVECTOR3(tPos.x, tPos.y, tPos.z))
	if OnScreen({x = sPos.x, y = sPos.y}, {x = sPos.x, y = sPos.y}) then
		self:DrawCircleNextLvl(x, y, z, radius, settings.draws.LFCwidth, color, settings.draws.LFCsnap)
	end
end

function VisualManager:DrawCircleNextLvl(x, y, z, radius, width, color, chordlength)
	radius = radius or 300
	quality = math.max(8, self:Round(180 / math.deg((math.asin(chordlength / (2 * radius))))))
	quality = 2 * math.pi / quality
	radius = radius * 0.92
	local points = {}
	for theta = 0, 2 * math.pi + quality, quality do
		local c = WorldToScreen(D3DXVECTOR3(x + radius * math.cos(theta), y, z - radius * math.sin(theta)))
		points[#points + 1] = D3DXVECTOR2(c.x, c.y)
	end
	DrawLines2(points, width or 1, color or 4294967295)
end

function VisualManager:Round(number)
	if number >= 0 then
		return math.floor(number + 0.5)
	else
		return math.ceil(number - 0.5)
	end
end

local floor = math.floor
function DrawRectangleButton(x, y, w, h, color)
    local points = {}
    points[1] = D3DXVECTOR2(floor(x), floor(y))
    points[2] = D3DXVECTOR2(floor(x + w), floor(y))
	local points2 = {}
	points2[1] = D3DXVECTOR2(floor(x), floor(y - h/2))
	points2[2] = D3DXVECTOR2(floor(x + w), floor(y - h/2))
	points2[3] = D3DXVECTOR2(floor(x + w), floor(y + h/2))
	points2[4] = D3DXVECTOR2(floor(x), floor(y + h/2))
	local t = GetCursorPos()
	polygon = Polygon(Point(points2[1].x, points2[1].y), Point(points2[2].x, points2[2].y), Point(points2[3].x, points2[3].y), Point(points2[4].x, points2[4].y))
	if polygon:contains(Point(t.x, t.y)) then
		DrawLines2(points, floor(h), color)
	else
		DrawLines2(points, floor(h), ARGB(255, 63,236, 0 ))
	end
end

class("DrawBar")
function DrawBar:__init()
	self.bars = {}
end

-- Thanks S1mple
function DrawBar:addLine(target, starttime, endtime, alpha, red, green, blue, alphafade, redfade, greenfade, bluefade, inc)
	if not target then target = myHero end
	if not starttime then error("starttime required") end
	if not endtime then error("endtime required") end
	if not alpha then alpha = 255 end
	if not red then red = 255 end
	if not green then green = 255 end
	if not blue then blue = 255 end
	if not inc then inc = false end

	if not alphafade then alphafade = alpha end
	if not redfade then redfade = red end
	if not greenfade then greenfade = green end
	if not bluefade then bluefade = blue end

	local nb = {}
	table.insert(nb,target.networkID)
	table.insert(nb,starttime)
	table.insert(nb,endtime)
	table.insert(nb,alpha)
	table.insert(nb,red)
	table.insert(nb,green)
	table.insert(nb,blue)
	table.insert(nb,alphafade)
	table.insert(nb,redfade)
	table.insert(nb,greenfade)
	table.insert(nb,bluefade)
	table.insert(nb,inc)
	table.insert(self.bars, nb)
end

function DrawBar:draw()
	for _,bar in pairs(self.bars) do
		local starttime = 0
		local endtime = 0
		local target = nil
		local inc = false
		local alpha, red, green, blue, alphafade, redfade, greenfade, bluefade = 255
		for v,k in pairs(bar) do
			if v == 1 then 
				target = objManager:GetObjectByNetworkId(k)
			elseif v == 2 then
				starttime = k
			elseif v == 3 then
				endtime = k
			elseif v == 4 then
				alpha = k
			elseif v == 5 then
				red = k
			elseif v == 6 then
				green = k
			elseif v == 7 then
				blue = k
			elseif v == 8 then
				alphafade = k
			elseif v == 9 then
				redfade = k
			elseif v == 10 then
				greenfade = k
			elseif v == 11 then
				bluefade = k
			elseif v == 12 then
				inc = k
			end
		end
		if starttime < endtime and starttime < os.clock() and endtime > os.clock() then
			local lenght = 130
			local deltat = endtime - starttime
			local mult = endtime - os.clock()
			local multiplier = mult/deltat
			multiplier = multiplier
			if not inc then
				lenght = lenght * multiplier
			else
				lenght = 130 - lenght * multiplier
			end
			alphaN = (alpha * multiplier) + (alphafade - (alphafade * multiplier))
			redN = (red * multiplier) + (redfade - (redfade * multiplier))
			greenN = (green * multiplier) + (greenfade - (greenfade * multiplier))
			blueN = (blue * multiplier) + (bluefade - (bluefade * multiplier))
			if multiplier >= 0 then
				local barPos = GetUnitHPBarPos(target)
				local barOffset = GetUnitHPBarOffset(target)
				local baseX = barPos.x - 69 + barOffset.x * 150
				local baseY = barPos.y + barOffset.y * 50 + 12.5
				local yoffset = 10
				if settings.draws.lineoffset then
					yoffset = 20
				end
				local px = baseX
				local py = baseY+yoffset
				local cx = baseX+lenght
				local cy = baseY+yoffset
				DrawLine(px, py, cx, cy, 10, ARGB(alphaN, redN, greenN, blueN))
			end
		end
	end
end

function DrawBar:update()
	for _,bar in pairs(self.bars) do
		local endtime = 0
		for k,v in pairs(bar) do
			if v == 3 then endtime = k end
		end
		if endtime > os.clock() then
			for k,v in pairs(bar) do
				v = nil
			end
		end
	end
end

function DrawBar:delete(target)
	for _,bar in pairs(self.bars) do
		local delete = false
		for k,v in pairs(bar) do
			if k == 1 then
				if v == target.networkID then
					delete = true
				end
			end
		end
		if delete == true then
			table.clear(bar)
		end
	end
end

-- Thanks Ziikah
function GetHPBarPos(enemy)
	enemy.barData = {PercentageOffset = {x = -0.05, y = 0}}
	local barPos = GetUnitHPBarPos(enemy)
	local barPosOffset = GetUnitHPBarOffset(enemy)
	local barOffset = { x = enemy.barData.PercentageOffset.x, y = enemy.barData.PercentageOffset.y }
	local barPosPercentageOffset = { x = enemy.barData.PercentageOffset.x, y = enemy.barData.PercentageOffset.y }
	local BarPosOffsetX = -50
	local BarPosOffsetY = 46
	local CorrectionY = 39
	local StartHpPos = 31
	barPos.x = math.floor(barPos.x + (barPosOffset.x - 0.5 + barPosPercentageOffset.x) * BarPosOffsetX + StartHpPos)
	barPos.y = math.floor(barPos.y + (barPosOffset.y - 0.5 + barPosPercentageOffset.y) * BarPosOffsetY + CorrectionY)
	local StartPos = Vector(barPos.x , barPos.y, 0)
	local EndPos = Vector(barPos.x + 108 , barPos.y , 0)
	return Vector(StartPos.x, StartPos.y, 0), Vector(EndPos.x, EndPos.y, 0)
end

function DrawLineHPBar(damage, line, text, unit)
	local thedmg = 0
	if damage >= unit.maxHealth then
		thedmg = unit.maxHealth-1
	else
		thedmg=damage
	end
	local StartPos, EndPos = GetHPBarPos(unit)
	local Real_X = StartPos.x+24
	local Offs_X = (Real_X + ((unit.health-thedmg)/unit.maxHealth) * (EndPos.x - StartPos.x - 2))
	if Offs_X < Real_X then Offs_X = Real_X end	
	local mytrans = 350 - math.round(255*((unit.health-thedmg)/unit.maxHealth))
	if mytrans >= 255 then mytrans=254 end
	local my_redpart = math.round(400*((unit.health-thedmg)/unit.maxHealth))
	if my_redpart >= 255 then my_redpart=254 end
	if settings.draws.nameenable then
		DrawLine(Offs_X-150, StartPos.y-(42+(line*15)), Offs_X-150, StartPos.y-2, 2, ARGB(mytrans, my_redpart,255,0))
		DrawText(tostring(text),15,Offs_X-148,StartPos.y-(42+(line*15)), ARGB(mytrans, my_redpart,255,0))
	else
		DrawLine(Offs_X-150, StartPos.y-(30+(line*15)), Offs_X-150, StartPos.y-2, 2, ARGB(mytrans, my_redpart,255,0))
		DrawText(tostring(text),15,Offs_X-148,StartPos.y-(30+(line*15)), ARGB(mytrans, my_redpart,255,0))
	end
end

class("Minions")
function Minions:__init()
	self.enemyMinions = minionManager(MINION_ENEMY, 670, player, MINION_SORT_HEALTH_ASC)
	self.allyMinions = minionManager(MINION_ALLY, 670, player, MINION_SORT_HEALTH_ASC)
	self.jungleMinions = minionManager(MINION_JUNGLE, 670, myHero, MINION_SORT_HEALTH_ASC)
	return self
end

function Minions:update()
	self.enemyMinions:update()
	self.jungleMinions:update()
	self.allyMinions:update()
end

function Minions:OnTick()
	self:update()
end

drawing = VisualManager()
minions = Minions()
twitch = Twitch()

AddCreateObjCallback(function(obj)
	OnCreateObj(obj)
end)

AddTickCallback(function()
	minions:OnTick()
	twitch:OnTick()
end)

AddDrawCallback(function()
	drawing:OnDraw()
end)

AddTickCallback(function()
	db:update()
end)

AddDrawCallback(function()
	db:draw()
end)

function OnWndMsg(a, b)
	if a == KEY_DOWN and settings.Qsettings.AlwaysQB and myHero:CanUseSpell(_Q) == READY and b == GetKey("B") then
		if settings.misc.Debug and settings.misc.ChatDebug then
			print("<font color='#00FF00'>[Yiffy Twitch] </font><font color='#FF00FF'>-</font><font color='#FFFFFF'> Attempting to Recall invisible!</font>")
		end
		CastSpell(_Q)
	end
	if a == WM_LBUTTONDOWN then
		if PopUp1 then
			PopUp1 = false
		end
	end
end

function AntiAFKSystem()
	if os.clock() < Clock or not settings.antiAFK then return end
	Clock = os.clock() + math.random(60,120)
	myHero:MoveTo(myHero.x, myHero.z)
end

if (string.find(GetGameVersion(), 'Releases/5.22') ~= nil) then
	skinsPB = {

	[1] = nil,
	[2] = 0xCA,
	[3] = 0xB4,
	[4] = 0x75,
	[5] = 0xF9,
	[6] = 0x20,
	[7] = nil,
	[8] = 0xDD,
	[9] = 0x7B,					
	-- Skin Order:
		--|>  Original
		--|>  Kingpin
		--|>  Whistler Village
		--|>  Medieval
		--|>  Gangster
		--|>  Vandal
		--|>  Pickpocket
		--|>  SSW
	}
	skinObjectPos = 11
	skinHeader = 0x10E
	dispellHeader = 0x83
	skinH = 0xCA
	skinHPos = 7
end

function SendSkinPacket(mObject, skinPB, networkID)
	if (string.find(GetGameVersion(), 'Releases/5.22') ~= nil) then
		local mP = CLoLPacket(0x10E)

		mP.vTable = 0xFD17D0

		mP:EncodeF(networkID)
		
		mP:Encode1(0x00)
		
		if (skinPB == nil) then
			mP:Encode4(0xE4E4E4E4)
		else
			mP:Encode1(skinPB)
			for I = 1, 3 do
				mP:Encode1(skinH)
			end
		end

		for I = 1, string.len(mObject) do
			mP:Encode1(string.byte(string.sub(mObject, I, I)))
		end

		for I = 1, (16 - string.len(mObject)) do
			mP:Encode1(0x00)
		end

		mP:Encode4(0x0000000E)
		mP:Encode4(0x0000000F)
		mP:Encode4(0x00000000)
		mP:Encode4(0x00000000)
		mP:Encode2(0x0000)
		
		mP:Hide()
		RecvPacket(mP)
	end
end

if (string.find(GetGameVersion(), 'Releases/5.22') ~= nil) then
	_G.LevelSpell = function(id)
		local offsets = {
			[_Q] = 0xB8,
			[_W] = 0xBA,
			[_E] = 0x79,
			[_R] = 0x7B,
		}
		local p
		p = CLoLPacket(0x0050)
		p.vTable = 0xF38DAC
		p:EncodeF(myHero.networkID)
		p:Encode1(offsets[id])
		p:Encode1(0x3C)
		for i = 1, 4 do p:Encode1(0xF6) end
		for i = 1, 4 do p:Encode1(0x5E) end
		for i = 1, 4 do p:Encode1(0xE0) end
		p:Encode1(0x24)
		p:Encode1(0xF1)
		p:Encode1(0x27)
		p:Encode1(0x00)
		SendPacket(p)
	end
end

function Levelstart()
	if countTable(tolevel) == 0 then
		Levelend()
		return
	end
	levelvariable = table.remove(tolevel, 1)
	spellLevel = myHero:GetSpellData(levelvariable).level
	leveltick = GetTickCount()
	point = true
	latency = GetLatency()
	LevelSpell(levelvariable)
end

function Levelend()
	point = false
	level = level + 1
end

function showLeveledSpell(spelldraw)
	drawlevelup = true
	if myHero:GetSpellData(spelldraw).level == 1 then
		leveltext = "available!"
	else
		leveltext = "at level " .. myHero:GetSpellData(spelldraw).level .. "!"
	end
	if levelvariable == 0 then
		SpellText = "Q"
	elseif levelvariable == 1 then
		SpellText = "W"
	elseif levelvariable == 2 then
		SpellText = "E"
	elseif levelvariable == 3 then
		SpellText = "R"
	end
	local spelldraw2 = " Spell " .. "<font color='#00FFFF'>(" .. SpellText .. ") <font color='#FF00FF'>-</font></font> is now " .. leveltext
	print("<font color='#00FF00'>[Yiffy Twitch] <font color='#FF00FF'>-</font><font color='#FFFFFF'>" .. spelldraw2 .. "</font>")
	DelayAction(function()
		drawlevelup = false
	end, settings.autolvl.DrawTextSlider)
end

function Config()
	SkillOrder()
	return countTable(tolevel) == 4 or myHero.level == settings.autolvl.getAllAtLevel
end

function SkillOrder()
	tolevel = {}
	if myHero.level == settings.autolvl.getAllAtLevel then
		local spelldraw = {
			SPELL_1,
			SPELL_2,
			SPELL_3
		}
		local spelldraw2 = false
		for i = 1, 3 do
			if myHero:GetSpellData(spelldraw[i]).level == 0 then
				spelldraw2 = spelldraw[i]
			end
		end
	if spelldraw2 ~= false then
		tolevel[1] = spelldraw2
	end
	else
		tolevel[settings.autolvl.maxQ] = SPELL_1
		tolevel[settings.autolvl.maxW] = SPELL_2
		tolevel[settings.autolvl.maxE] = SPELL_3
		tolevel[settings.autolvl.maxR] = SPELL_4
	end
end

function Error()
	print("<font color='#00FF00'>[Yiffy Twitch] </font><font color='#FF00FF'>-</font><font color='#FFFFFF'> There's something wrong with the AutoLeveler! Please configure and check your settings!</font>")
	settings.AutoLevelOn = false
end

function countTable(spelldraw)
	local spelldraw2 = 0
	for spelldraw3, spelldraw4 in pairs(spelldraw) do
		spelldraw2 = spelldraw2 + 1
	end
	return spelldraw2
end

--Debug
function OnTick()
	if settings.misc.Debug then
		if myHero:CanUseSpell(_Q) == READY then
			readytextQ = true
		else
			readytextQ = false
		end
		if myHero:CanUseSpell(_W) == READY then
			readytextW = true
		else
			readytextW = false
		end
		if myHero:CanUseSpell(_E) == READY then
			readytextE = true
		else
			readytextE = false
		end
		if myHero:CanUseSpell(_R) == READY then
			readytextR = true
		else
			readytextR = false
		end
	end
end

function OnDraw()
	if settings.misc.Debug then
		local totalAP = myHero.ap * (1 + myHero.apPercent)
		local World_x1 = 150
		local World_x2 = 330
		local World_x3 = 510
		local World_x4 = 690
		local World_y1 = 150
		DrawText("" .. myHero.charName .. "", 35, World_x1 - 20, World_y1 - 50, ARGB(255, 0, 255, 255))
		DrawText("Level: " .. myHero.level, 18, World_x1 + 85, World_y1 - 30, ARGB(255, 255, 255, 255))
		DrawText("Attack Damage: (       +       ) = ", 15, World_x1 - 20, World_y1 - 10, ARGB(255, 255, 255, 255))
		DrawText("" .. math.round(myHero.addDamage), 15, World_x1 + 77, World_y1 - 10, ARGB(255, 0,255, 255))
		DrawText("" .. math.round(myHero.damage), 15, World_x1 + 108, World_y1 - 10, ARGB(255, 0, 255, 0))
		DrawText("" .. math.round(myHero.totalDamage), 15, World_x1 + 144, World_y1 - 10, ARGB(255, 255, 0, 255))
		DrawText("Ability Power: (   +       ) = ", 15, World_x1 - 20, World_y1 + 5, ARGB(255, 255, 255, 255))
		DrawText("0", 15, World_x1 + 65, World_y1 + 5, ARGB(255, 0,255, 255))
		DrawText("" .. math.round(totalAP), 15, World_x1 + 82, World_y1 + 5, ARGB(255, 0, 255, 0))
		DrawText("" .. math.round(totalAP), 15, World_x1 + 118, World_y1 + 5, ARGB(255, 255, 0, 255))

		-- [Q Debug]
		DrawText("Q Debug", 15, World_x1, World_y1 + 20, ARGB(255, 0, 255, 255))
		DrawText("Name:", 15, World_x1, World_y1 + 35, ARGB(255, 255, 255, 255))
		DrawText("" .. myHero:GetSpellData(_Q).name, 15, World_x1 + 40, World_y1 + 35, ARGB(255, 255, 255, 0))
		DrawText("Ready:", 15, World_x1, World_y1 + 50, ARGB(255, 255, 255, 255))
		if readytextQ then
			DrawText("true", 15, World_x1 + 43, World_y1 + 50, ARGB(255, 0, 255, 0))
		elseif channelingQ then
			DrawText("Channeling", 15, World_x1 + 43, World_y1 + 50, ARGB(255, 255, 255, 0))
		elseif stealthQ then
			DrawText("Stealth", 15, World_x1 + 43, World_y1 + 50, ARGB(255, 255, 175, 0))
		elseif readytextQ == false then
			DrawText("false", 15, World_x1 + 43, World_y1 + 50, ARGB(255, 255, 0, 0))
		end
		DrawText("Level:", 15, World_x1, World_y1 + 65, ARGB(255, 255, 255, 255))
		if myHero:GetSpellData(_Q).level < 5 then
			DrawText("" .. myHero:GetSpellData(_Q).level, 15, World_x1 + 38, World_y1 + 65, ARGB(255, 255, 175, 0))
		elseif myHero:GetSpellData(_Q).level >= 5 then
			DrawText("MAX", 15, World_x1 + 38, World_y1 + 65, ARGB(255, 0, 255, 0))
		end
		DrawText("Delay:", 15, World_x1, World_y1 + 80, ARGB(255, 255, 255, 255))
		DrawText("" .. Qwind, 15, World_x1 + 38, World_y1 + 80, ARGB(255, 255, 175, 0))

		-- [W Debug]
		DrawText("W Debug", 15, World_x2, World_y1 + 20, ARGB(255, 0, 255, 255))
		DrawText("Name:", 15, World_x2, World_y1 + 35, ARGB(255, 255, 255, 255))
		DrawText("" .. myHero:GetSpellData(_W).name, 15, World_x2 + 40, World_y1 + 35, ARGB(255, 255, 255, 0))
		DrawText("Ready:", 15, World_x2, World_y1 + 50, ARGB(255, 255, 255, 255))
		if readytextW then
			DrawText("true", 15, World_x2 + 43, World_y1 + 50, ARGB(255, 0, 255, 0))
		elseif readytextW == false then
			DrawText("false", 15, World_x2 + 43, World_y1 + 50, ARGB(255, 255, 0, 0))
		end
		DrawText("Level:", 15, World_x2, World_y1 + 65, ARGB(255, 255, 255, 255))
		if myHero:GetSpellData(_W).level < 5 then
			DrawText("" .. myHero:GetSpellData(_W).level, 15, World_x2 + 38, World_y1 + 65, ARGB(255, 255, 175, 0))
		elseif myHero:GetSpellData(_W).level >= 5 then
			DrawText("MAX", 15, World_x2 + 38, World_y1 + 65, ARGB(255, 0, 255, 0))
		end
		DrawText("Delay:", 15, World_x2, World_y1 + 80, ARGB(255, 255, 255, 255))
		DrawText("" .. Wwind, 15, World_x2 + 38, World_y1 + 80, ARGB(255, 255, 175, 0))

		-- [E Debug]
		DrawText("E Debug", 15, World_x3, World_y1 + 20, ARGB(255, 0, 255, 255))
		DrawText("Name:", 15, World_x3, World_y1 + 35, ARGB(255, 255, 255, 255))
		DrawText("" .. myHero:GetSpellData(_E).name, 15, World_x3 + 40, World_y1 + 35, ARGB(255, 255, 255, 0))
		DrawText("Ready:", 15, World_x3, World_y1 + 50, ARGB(255, 255, 255, 255))
		if readytextE then
			DrawText("true", 15, World_x3 + 43, World_y1 + 50, ARGB(255, 0, 255, 0))
		elseif readytextE == false then
			DrawText("false", 15, World_x3 + 43, World_y1 + 50, ARGB(255, 255, 0, 0))
		end
		DrawText("Level:", 15, World_x3, World_y1 + 65, ARGB(255, 255, 255, 255))
		if myHero:GetSpellData(_E).level < 5 then
			DrawText("" .. myHero:GetSpellData(_E).level, 15, World_x3 + 38, World_y1 + 65, ARGB(255, 255, 175, 0))
		elseif myHero:GetSpellData(_E).level >= 5 then
			DrawText("MAX", 15, World_x3 + 38, World_y1 + 65, ARGB(255, 0, 255, 0))
		end
		DrawText("Delay:", 15, World_x3, World_y1 + 80, ARGB(255, 255, 255, 255))
		DrawText("" .. Ewind, 15, World_x3 + 38, World_y1 + 80, ARGB(255, 255, 175, 0))
		DrawText("Bonus AP:", 15, World_x3, World_y1 + 95, ARGB(255, 255, 255, 255))
		DrawText("" .. math.round(totalAP * 0.2), 15, World_x3 + 61, World_y1 + 95, ARGB(255, 0, 255, 0))
		DrawText("Bonus AD:", 15, World_x3, World_y1 + 110, ARGB(255, 255, 255, 255))
		DrawText("" .. math.round(myHero.damage * 0.25), 15, World_x3 + 61, World_y1 + 110, ARGB(255, 0, 255, 0))
		DrawText("Stack Count:", 15, World_x3, World_y1 + 125, ARGB(255, 255, 255, 255))
		if not etext then
			DrawText("nil", 15, World_x3 + 78, World_y1 + 125, ARGB(255, 255, 0, 255))
		end
		local i = 0
		local flag = false
		for _, target in pairs(GetEnemyHeroes()) do
			if target.visible and not target.dead and DeadlyVenom[target.networkID] ~= nil and DeadlyVenom[target.networkID].stack >= 1 then
				DrawText(tostring(DeadlyVenom[target.networkID].stack .. ""), 15, World_x3 + 78, World_y1 + 125 + (i*15), ARGB(255, 255, 0, 255))
				DrawText("on " .. target.charName, 15, World_x3 + 88, World_y1 + 125 + (i*15), ARGB(255, 255, 255, 255))
				DrawText("Damage:" , 15, World_x3 + 78, World_y1 + 140 + (i*15), ARGB(255, 255, 255, 255))
				DrawText("" .. math.round(Twitch:GetEDmg(target)), 15, World_x3 + 131, World_y1 + 140 + (i*15), ARGB(255, 0, 255, 0))
				etext = true
				flag = true
				i = i + 2
			end
		end
		if flag == false then
			etext = false
		end

		-- [R Debug]
		DrawText("R Debug", 15, World_x4, World_y1 + 20, ARGB(255, 0, 255, 255))
		DrawText("Name:", 15, World_x4, World_y1 + 35, ARGB(255, 255, 255, 255))
		DrawText("" .. myHero:GetSpellData(_R).name, 15, World_x4 + 40, World_y1 + 35, ARGB(255, 255, 255, 0))
		DrawText("Ready:", 15, World_x4, World_y1 + 50, ARGB(255, 255, 255, 255))
		if readytextR then
			DrawText("true", 15, World_x4 + 43, World_y1 + 50, ARGB(255, 0, 255, 0))
		elseif readytextR == false then
			DrawText("false", 15, World_x4 + 43, World_y1 + 50, ARGB(255, 255, 0, 0))
		end
		DrawText("Level:", 15, World_x4, World_y1 + 65, ARGB(255, 255, 255, 255))
		if myHero:GetSpellData(_R).level < 3 then
			DrawText("" .. myHero:GetSpellData(_R).level, 15, World_x4 + 38, World_y1 + 65, ARGB(255, 255, 175, 0))
		elseif myHero:GetSpellData(_R).level >= 3 then
			DrawText("MAX", 15, World_x4 + 38, World_y1 + 65, ARGB(255, 0, 255, 0))
		end
		DrawText("Delay:", 15, World_x4, World_y1 + 80, ARGB(255, 255, 255, 255))
		DrawText("" .. Rwind, 15, World_x4 + 38, World_y1 + 80, ARGB(255, 255, 175, 0))
	end
end
