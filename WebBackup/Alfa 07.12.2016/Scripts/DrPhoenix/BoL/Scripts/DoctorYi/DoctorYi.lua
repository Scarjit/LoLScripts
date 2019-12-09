--[[


             Doctor Yi
        SCRIPT BY DrPhoenix


Changelog :

	Alpha / Beta :
	
		0.01 : First release
		0.02 : Add ScriptStatus Tracker
		0.03 : - Add an auto-updater (S1mple class)
               - Dodge targeted spells
               - Combo with items usage
		0.04 : Little bug fixing
		0.05 : Bug fixing
		0.06 : Add Q dive option
		0.07 : Remove the W dodge
		0.08 : Some fixes on the combo & chat functions
		0.09 : - Total rework of the combo. No more problem with it, free pentakills :)
               - Add some options to the menu
               - Bug fixing
		0.1 : Added QSS support
		0.11 : Removed a function
		0.12 : - Following all dash + flash
               - Dodging the ~kick~ of dragon
		0.13 : After 4 hours of testing (and 3 with S1mple on skype ♥) I've finaly fixed the combo !
		0.14 : Change the range of the targetselector from 2000 to 1000.
		0.15 : Tiamat and Ravenous Hydra added to the item database
		0.16 : Jungle Clear is here !
	
	Official release :
	
		1.01 : - All the main features of the script are here so I consider it's not anymore an alpha / beta phase !
               - Added the Mastery Emote On Kill feature !
		1.02 : Fixed a bug in the follow part
		1.03 : Update the updater ^^
		1.04 : Fix a bugsplat
		1.05 : Fix an other one xD
		1.06 : Maybe one more :(
		1.07 : ^
		1.08 : Fully updated thanks to Izsha
		1.09 : Removed the basic orbwalker
		
		
		2.01 : Doctor Yi 2.0 is here boys !
                  - Rework the whole script
                  - Support all orbwalkers
                  - Fixed bugsplats issues
                  - More FPS
	
	More Soon !
	

]]--


local version = "2.01"

if myHero.charName ~= "MasterYi" then return end

assert(load(Base64Decode("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"), nil, "bt", _ENV))()
TrackerLoad("RM6rUV5ifrGr3MQE")

local function PrintMsg(msg)
	PrintChat("<font color=\"#6eed00\"><b>[</b></font><font color=\"#a2ed00\"><b>Doctor Yi 2.0</b></font><font color=\"#6eed00\"><b>]</b></font> <font color=\"#fce700\">"..msg.."</font>")
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

local function GetWebFile(server, path, data, localfilename, port, b64)
	local r,s,t = TCPGetRequest(server, path, data, port)
	file = io.open(localfilename,"w+b")
	file:write(r)
	file:close()
end

local function Update()
	if GetUser() ~= "DrPhoenix" and version ~= TCPGetRequest("s1mplescripts.de", "/DrPhoenix/BoL/Scripts/DoctorYi/DoctorYi.version", {}, 80) then
		PrintMsg("Updating don't press F9 !")
		GetWebFile("s1mplescripts.de","/DrPhoenix/BoL/Scripts/DoctorYi/DoctorYi.lua", {}, SCRIPT_PATH..debug.getinfo(1,'S').source, 80, false)
		PrintMsg("Updated to version "..TCPGetRequest("s1mplescripts.de", "/DrPhoenix/BoL/Scripts/DoctorYi/DoctorYi.version", {}, 80).." !")
		PrintMsg("Press 2xF9 to reload !")
	end
end

local Menu
local ts

local enemies = GetEnemyHeroes()
local minions = minionManager(MINION_ENEMY, 600, myHero, MINION_SORT_MINHEALTH_ASC)
local jungleMinions = minionManager(MINION_JUNGLE, 560, myHero, MINION_SORT_MINHEALTH_DEC)

local OffensiveItemsList = {
	TMT = { id = 3077, range = 189, reqTarget = false, slot = nil }, -- Tiamat
	THD = { id = 3074, range = 189, reqTarget = false, slot = nil }, -- Ravenous Hydra
	THD = { id = 3748, range = 189, reqTarget = false, slot = nil }, -- Titanic Hydra
	BWC = { id = 3144, range = 400, reqTarget = true, slot = nil }, -- Bilgewater Cutlass
	BRK = { id = 3153, range = 450, reqTarget = true, slot = nil }, --Blade of the ruined king
	SR = { id = 3715, range = 560, reqTarget = true, slot = nil }, -- Red Smite
	SB = { id = 3706, range = 560, reqTarget = true, slot = nil }, -- Blue Smite
	SRD = { id = 1419, range = 560, reqTarget = true, slot = nil }, -- Red Smite Bloodrazor
	SBD = { id = 1416, range = 560, reqTarget = true, slot = nil }, -- Blue Smite Bloodrazor
	YGB = { id = 3142, range = 1000, reqTarget = false, slot = nil } -- Youmuu Ghostblade
}

local DefensiveItemsList = {
	QSS = { id = 3140, slot = nil }, -- Quicksilver Sash
	MCS = { id = 3139, slot = nil } -- Mercurial Scimitar
}

local Dash = {
	"AatroxQ", -- Aatrox Q
	"AhriTumble", -- Ahri R
	"AkaliShadowDance", -- Akali R
	"Arcane Shift", -- Ezreal E
	"BandageToss", -- Amumu Q
	"blindmonkqtwo", -- Lee Sin Q
	"CarpetBomb", -- Corki W
	"Crowstorm", -- Fiddlestick R
	"Cutthroat", -- Talon E
	"Death Mark", --Zed R
	"DianaTeleport", -- Diana R
	"Distortion", -- Leblanc W
	"EliseSpiderQCast", -- Elise Q
	"FioraQ", -- Fiora Q
	"FizzPiercingStrike", -- Fizz Q
	"Glacial Path", -- Lissandra E
	"GragasE", -- Gragas E
	"GravesMove", -- Graves E
	"Headbutt", -- Alistar W
	"HecarimUlt", -- Hecarim R
	"IreliaGatotsu", -- Irelia Q
	"jarvanAddition", -- Jarvan Dash
	"jarvanivcataclysmattack", -- Jarvan R
	"JarvanIVCataclysmAttack", -- Jarvan R
	"JaxLeapStrike", -- Jax Q
	"JayceToTheSkies", -- Jayce Q
	"KhazixE", -- Kha'Zix E
	"khazixeevo", -- Kha'Zix E evolved
	"khazixelong", -- Kha'Zix E evolved
	"Last Breath", -- Yasuo R
	"LeblancSlide", -- Leblanc W
	"LeblancSlideM", -- Leblanc R
	"LeonaZenithBlade", -- Leona E
	"Living Shadow", --Zed W
	"LucianE", -- Lucian E
	"MaokaiTrunkLine", -- Maokai W
	"MonkeyKingNimbus", -- Wukong E
	"Mimic: Distortion", -- Leblanc R
	"NautilusAnchorDrag", -- Nautilus Q
	"PantheonW", -- Pantheon W
	"PoppyHeroicCharge", -- Poppy E
	"Pounce", -- Nidalee W
	"RenektonSliceAndDice", -- Renekton E
	"Riftwalk", -- Kassadin R
	"RivenFeint", -- Riven E
	"RivenTriCleave", -- Riven E
	"RocketJump", -- Tristana W
	"SejuaniArcticAssault", -- Sejuani Q
	"ShadowStep", -- Katarina E
	"ShenShadowDash", -- Shen E
	"Shunpo", -- Katarina E
	"ShyvanaTransformCast", -- Shyvana R
	"Slash", -- Tryndamere E
	"UFSlash", -- Malphite R
	"ViQ", -- Vi Q
	"XenZhaoSweep", -- Xin Zhao E
	"YasuoDashWrapper" -- Yasuo E
}

local SmitePos = nil
if myHero:GetSpellData(SUMMONER_1).name:find("Smite") then SmitePos = SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("Smite") then SmitePos = SUMMONER_2 end

local abilityLevel = 0

local OrbWalker = ""
local Mode = "None"
local target
local function OrbManager()
	if _G.AutoCarry and _G.AutoCarry.Keys and _G.Reborn_Loaded ~= nil then
		if OrbWalker ~= "SAC" then
			OrbWalker = "SAC"
		end
		target = _G.AutoCarry.SkillsCrosshair.target
		if _G.AutoCarry.Keys.AutoCarry then 
			if Mode ~= "Combo" then
				Mode = "Combo"
			end
		elseif _G.AutoCarry.Keys.LaneClear then 
			if Mode ~= "Clear" then
				Mode = "Clear"
			end
		else
			if Mode ~= "None" then
				Mode = "None"
			end
		end
	elseif _G.MMA_IsLoaded then
		if OrbWalker ~= "MMA" then
			OrbWalker = "MMA"
		end
		target = _G.MMA_GetTarget()
		if _G.MMA_IsOrbwalking then 
			if Mode ~= "Combo" then
				Mode = "Combo"
			end
		elseif _G.MMA_IsLaneClearing then 
			if Mode ~= "Clear" then
				Mode = "Clear"
			end
		else
			if Mode ~= "None" then
				Mode = "None"
			end
		end
	elseif _Pewalk then
		if OrbWalker ~= "PeWalk" then
			OrbWalker = "PeWalk"
		end
		target = _Pewalk.GetTarget()
		if _G._Pewalk.GetActiveMode().Carry then 
			if Mode ~= "Combo" then
				Mode = "Combo"
			end
		elseif _G._Pewalk.GetActiveMode().LaneClear then
			if Mode ~= "Clear" then
				Mode = "Clear"
			end
		else
			if Mode ~= "None" then
				Mode = "None"
			end
		end
	elseif _G["BigFatOrb_Loaded"] == true then
		if OrbWalker ~= "BFW" then
			OrbWalker = "BFW"
		end
		target = _G["BigFatOrb_Target"]
		if _G["BigFatOrb_Mode"] == 'Combo' then 
			if Mode ~= "Combo" then
				Mode = "Combo"
			end
		elseif _G["BigFatOrb_Mode"] == 'LaneClear' then
			if Mode ~= "Clear" then
				Mode = "Clear"
			end
		else
			if Mode ~= "None" then
				Mode = "None"
			end
		end
	elseif _G.S1OrbLoading or _G.S1mpleOrbLoaded then
		if OrbWalker ~= "SOW" then
			OrbWalker = "SOW"
		end
		target = _G.S1:GetTarget()
		if _G.S1.aamode == "sbtw" then 
			if Mode ~= "Combo" then
				Mode = "Combo"
			end
		elseif _G.S1.aamode == "laneclear" then
			if Mode ~= "Clear" then
				Mode = "Clear"
			end
		else
			if Mode ~= "None" then
				Mode = "None"
			end
		end
	elseif _G.NebelwolfisOrbWalkerLoaded then
		if OrbWalker ~= "NOW" then
			OrbWalker = "NOW"
		end
		target = _G.NebelwolfisOrbWalker:GetTarget()
		if _G.NebelwolfisOrbWalker.Config.k.Combo then
			if Mode ~= "Combo" then
				Mode = "Combo"
			end
		elseif _G.NebelwolfisOrbWalker.Config.k.LaneClear then
			if Mode ~= "Clear" then
				Mode = "Clear"
			end
		else
			if Mode ~= "None" then
				Mode = "None"
			end
		end
	else
		if ts then
			ts:update()
			target = ts.target
		end
	end
end

local function DrawMenu()
	Menu = scriptConfig("Doctor Yi 2.0", "DoctorYi")

	Menu:addSubMenu("General Settings", "GeneralSettings")
		Menu.GeneralSettings:addParam("diveQON", "Use Alpha Strike under towers", SCRIPT_PARAM_ONOFF, true)
		Menu.GeneralSettings:addParam("followON", "Follow dash and flash", SCRIPT_PARAM_ONOFF, true)
		Menu.GeneralSettings:addParam("UseSmite", "Smite Dragon, Rift Herald and Baron", SCRIPT_PARAM_ONOFF, true)
		Menu.GeneralSettings:addParam("DodgeDragonON", "Dodge Dragon ~kick~", SCRIPT_PARAM_ONOFF, true)

	Menu:addSubMenu("Combo", "Combo")
		Menu.Combo:addParam("UseQCombo", "Use Alpha Strike (Q) in combo", SCRIPT_PARAM_ONOFF, true)
		Menu.Combo:addParam("UseECombo", "Use Wuju Style (E) in combo", SCRIPT_PARAM_ONOFF, true)
		Menu.Combo:addParam("UseRCombo", "Use Highlander (R) in combo", SCRIPT_PARAM_ONOFF, true)
		Menu.Combo:addParam("UseSCombo", "Use Smite in combo", SCRIPT_PARAM_ONOFF, true)

	Menu:addSubMenu("OrbWalker", "OrbWalker")
		DelayAction(function()
			if OrbWalker == "" then
				Menu.OrbWalker:addParam("Combo", "Combo", SCRIPT_PARAM_ONKEYDOWN, false, string.byte(" "))
					Menu.OrbWalker:setCallback("Combo", function(value) if value == true then Mode = "Combo" else Mode = "None" end end)
				Menu.OrbWalker:addParam("JungleClear", "Jungle Clear", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
					Menu.OrbWalker:setCallback("JungleClear", function(value) if value == true then Mode = "Clear" else Mode = "None" end end)
				PrintMsg("No orbwalker detected, please download one or reload !")
			else
				Menu.OrbWalker:addParam("OrbInfos1", OrbWalker.." detected !", 5, "")
				Menu.OrbWalker:addParam("OrbInfos2", "Doctor Yi will use the key settings of it.", 5, "")
				PrintMsg(OrbWalker.." loaded !")
			end
		end, 6)
		
	Menu:addSubMenu("Items", "ItemsSettings")
		Menu.ItemsSettings:addParam("SmiteChampON", "Use smite on champion", SCRIPT_PARAM_ONOFF, true)
		Menu.ItemsSettings:addParam("YoumuuON", "Use Youmuu", SCRIPT_PARAM_ONOFF, true)
		Menu.ItemsSettings:addParam("BotkrON", "Use BOTRK", SCRIPT_PARAM_ONOFF, true)
		Menu.ItemsSettings:addParam("TitanicON", "Use Titanic Hydra", SCRIPT_PARAM_ONOFF, true)
		Menu.ItemsSettings:addSubMenu("QSS","QSS")
			Menu.ItemsSettings.QSS:addParam("Stun", "Remove stun", SCRIPT_PARAM_ONOFF, true)
			Menu.ItemsSettings.QSS:addParam("Silence", "Remove silence", SCRIPT_PARAM_ONOFF, true)
			Menu.ItemsSettings.QSS:addParam("Taunt", "Remove taunt", SCRIPT_PARAM_ONOFF, true)
			Menu.ItemsSettings.QSS:addParam("Root", "Remove root", SCRIPT_PARAM_ONOFF, true)
			Menu.ItemsSettings.QSS:addParam("Fear", "Remove fear", SCRIPT_PARAM_ONOFF, true)
			Menu.ItemsSettings.QSS:addParam("Charm", "Remove charm", SCRIPT_PARAM_ONOFF, true)
			Menu.ItemsSettings.QSS:addParam("Suppression", "Remove suppression", SCRIPT_PARAM_ONOFF, true)
			Menu.ItemsSettings.QSS:addParam("Blind", "Remove blind", SCRIPT_PARAM_ONOFF, true)
			Menu.ItemsSettings.QSS:addParam("KnockUp", "Remove knock up", SCRIPT_PARAM_ONOFF, true)
			Menu.ItemsSettings.QSS:addParam("Exhaust", "Remove exhaust", SCRIPT_PARAM_ONOFF, true)
	
	Menu:addSubMenu("Dodge", "DodgeSettings")
		Menu.DodgeSettings:addParam("DodgeON", "Dodge dangerous spells with Q", SCRIPT_PARAM_ONOFF, true)
	
	Menu:addSubMenu("Draw", "DrawSettings")
		Menu.DrawSettings:addParam("DrawAaON", "Draw AA range", SCRIPT_PARAM_ONOFF, false)
		Menu.DrawSettings:addParam("DrawTargetON", "Draw current target", SCRIPT_PARAM_ONOFF, true)
		Menu.DrawSettings:addParam("DrawSmiteON", "Draw Smite range", SCRIPT_PARAM_ONOFF, true)
		Menu.DrawSettings:addParam("DrawQON", "Draw Alpha Strike range", SCRIPT_PARAM_ONOFF, true)

	Menu:addSubMenu("Miscellaneous", "MiscSettings")
		Menu.MiscSettings:addParam("SetSkin", "Select Skin", SCRIPT_PARAM_LIST, 9, {"Assassin", "Chosen", "Ionia", "Samurai Yi", "Headhunter", "Chroma Pack: Gold", "Chroma Pack: Aqua", "Chroma Pack: Crimson", "PROJECT","Classic"})
		Menu.MiscSettings:addParam("AutoLevelON", "Auto level spells (Q>E>W)", SCRIPT_PARAM_ONOFF, true)
	
	DelayAction(function()
		if OrbWalker == "" then
			ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, 1000, DAMAGE_PHYSICAL, true)
			ts.name = "DoctorYi"
			Menu:addTS(ts)
		end
	end, 6)
	
	Menu:addParam("space2", "", 5, "")
	Menu:addParam("signature0", "            Doctor Yi v"..version, 5, "")
	Menu:addParam("signature1", "          Let the Doctor carry", 5, "")
	Menu:addParam("signature2", "              by DrPhoenix    ", 5, "")
end

local function AutoLevel()
	if Menu.MiscSettings.AutoLevelON then
		local abilitySequence = {SPELL_1,SPELL_2,SPELL_3,SPELL_1,SPELL_1,SPELL_4,SPELL_1,SPELL_3,SPELL_1,SPELL_3,SPELL_4,SPELL_3,SPELL_3,SPELL_2,SPELL_2,SPELL_4,SPELL_2,SPELL_2}
		if myHero.level > abilityLevel then
			abilityLevel = abilityLevel + 1
			LevelSpell(abilitySequence[abilityLevel])
		end
	end
end

local function GetSmiteDamage()
	if myHero.level <= 4 then
		SmiteDamage = 370 + (myHero.level*20)
	end
	if myHero.level > 4 and myHero.level <= 9 then
		SmiteDamage = 330 + (myHero.level*30)
	end
	if myHero.level > 9 and myHero.level <= 14 then
		SmiteDamage = 240 + (myHero.level*40)
	end
	if myHero.level > 14 then
		SmiteDamage = 100 + (myHero.level*50)
	end
	return SmiteDamage
end

local function CheckJungle()
	if Menu.GeneralSettings.UseSmite then
		for i, mob in pairs(jungleMinions.objects) do
			if mob and mob.valid and mob.visible and not mob.dead and SmitePos and myHero:CanUseSpell(SmitePos) == READY and GetDistance(mob) <= 560 and mob.health <= GetSmiteDamage() then
				if mob.charName == "SRU_Baron" or mob.charName == "SRU_Dragon_Water" or mob.charName == "SRU_Dragon_Fire" or mob.charName == "SRU_Dragon_Earth" or mob.charName == "SRU_Dragon_Air" or mob.charName == "SRU_Dragon_Elder" or mob.charName == "SRU_RiftHerald" then
					CastSpell(SmitePos, mob)
				end
			end
		end
	end	 
end

local function OffensiveItems()
	if target and target.visible and target.valid and not target.dead then
		for _, item in pairs(OffensiveItemsList) do
			item.slot = GetInventorySlotItem(item.id)
			if item.slot then
				if item.id == 3715 or item.id == 3706 or item.id == 1416 or item.id == 1419 then
					if GetDistance(target, myHero) < item.range and Menu.Combo.UseSCombo then
						DelayAction(function() CastSpell(SmitePos, target) end, ComboHumanizer)
					end
				end
				if item.reqTarget and GetDistance(target, myHero) < item.range then
					DelayAction(function() CastSpell(item.slot, target) end, ComboHumanizer)
				elseif not item.reqTarget and GetDistance(target, myHero) < item.range then
					DelayAction(function() CastSpell(item.slot) end, ComboHumanizer)
				end
			end
		end
	end
end

local function Combo()
	if target and target.visible and target.valid and not target.dead then
		if myHero:CanUseSpell(_R) == READY and GetDistance(target) <= 1000 and Menu.Combo.UseRCombo then
			CastSpell(_R)
		end
		if GetDistance(target) > myHero.range + myHero.boundingRadius then
			if myHero:CanUseSpell(_Q) == READY then
				if Menu.Combo.UseQCombo then
					CastSpell(_Q, target)
				end
			end
		else
			if myHero:CanUseSpell(_E) == READY and Menu.Combo.UseECombo then
				CastSpell(_E)
			end
		end
		OffensiveItems()
	end
end

local function DefensiveItems()
	for _, item in pairs(DefensiveItemsList) do
		item.slot = GetInventorySlotItem(item.id)
		if item.slot then
			CastSpell(item.slot)
		end
	end
end

local function Clear()
	for i, minion in pairs(jungleMinions.objects) do
		if i == 1 and minion and minion.valid and not minion.dead and minion.charName ~= "SRU_CampRespawnMarker" then
			if myHero:CanUseSpell(_E) then
				CastSpell(_E)
			end
			if myHero:CanUseSpell(_Q) then
				CastSpell(_Q, minion)
			end
		end
	end
	for i, minion in pairs(minions.objects) do
		if i == 1 and minion and minion.valid and not minion.dead then
			if myHero:CanUseSpell(_Q) then
				CastSpell(_Q, minion)
			end
		end
	end
end

local function Dodge()
	if myHero:CanUseSpell(_Q) then
		for i, hero in ipairs(enemies) do
			if hero and hero.visible and not hero.dead and hero.valid then
				if GetDistance(hero) <= 600 then
					CastSpell(_Q, hero)
				elseif #minions.objects > 0 and GetDistance(minions.objects[1]) <= 600 then
					CastSpell(_Q, minions.objects[1])
				elseif #jungleMinions.objects > 0 and GetDistance(jungleMinions.objects[1]) <= 600 then
					CastSpell(_Q, jungleMinions.objects[1])	
				end
			end
		end
	end
end

AddLoadCallback(function()
	Update()
	DrawMenu()
	PrintMsg("Loaded !")
end)

AddTickCallback(function()
	OrbManager()
	jungleMinions:update()
	minions:update()
	CheckJungle()
	if Mode == "Combo" then
		Combo()
	end
	if Mode == "Clear" then
		Clear()
	end
	AutoLevel()
	SetSkin(myHero, Menu.MiscSettings.SetSkin)
end)

AddDrawCallback(function()
	if SmitePos and Menu.DrawSettings.DrawSmiteON and myHero:CanUseSpell(SmitePos) and not myHero.dead then
		DrawCircle3D(myHero.x, myHero.y, myHero.z, 560, 1, RGB(255,130,0), Menu.DrawSettings.DrawQuality)
	end
	if Menu.DrawSettings.DrawQON and myHero:CanUseSpell(_Q) and not myHero.dead then
		DrawCircle3D(myHero.x, myHero.y, myHero.z, 600, 1, RGB(178,255,0), Menu.DrawSettings.DrawQuality)
	end
	if Menu.DrawSettings.DrawAaON and not myHero.dead then
		DrawCircle3D(myHero.x, myHero.y, myHero.z, myHero.range + myHero.boundingRadius, 1, RGB(255,100,100), Menu.DrawSettings.DrawQuality)
	end
	if Menu.DrawSettings.DrawTargetON and not myHero.dead and target and target.visible and not target.dead and target.valid then
		DrawCircle3D(target.x, target.y, target.z, 75, 3, RGB(178,0,255), 4)
	end
end)

AddAnimationCallback(function(unit, animation)
	if unit and unit.valid and unit.visible and not unit.dead and unit.charName:find("SRU_Dragon") and animation and animation == "Spell2" and Menu.GeneralSettings.DodgeDragonON then
		DelayAction(function(unit) if unit and unit.visible and not unit.dead and unit.valid then CastSpell(_Q, unit) end end, 0.25, {unit})
	end
end)

AddProcessSpellCallback(function(unit,spell)
	if unit and unit.valid and unit.visible and not unit.dead and unit.team ~= myHero.team and spell and spell.target and spell.target.isMe then
		Dodge()
	end
	
	if unit and unit.valid and unit.visible and not unit.dead and unit.team ~= myHero.team and Menu.GeneralSettings.followON then
		if spell.name == "SummonerFlash" and GetDistance(myHero, spell.endPos) > GetDistance(myHero, spell.startPos) then
			DelayAction(function(unit) if unit and unit.visible and not unit.dead and unit.valid then CastSpell(_Q, unit) end end, FollowHumanizer, {unit})
		else
			for _, dash in pairs(Dash) do
				if spell.name == dash and GetDistance(myHero, spell.endPos) > GetDistance(myHero, spell.startPos) then
					DelayAction(function(unit) if unit and unit.visible and not unit.dead and unit.valid then CastSpell(_Q, unit) end end, 0.2, {unit})
				end
			end
		end
	end
end)

AddApplyBuffCallback(function(unit, source, buff)
	if source and source.isMe and source.valid and not source.dead and not source.charName:lower():find("baron") and not source.charName:lower():find("spiderboss") then
		if buff.name == "SummonerExhaust" and Menu.ItemsSettings.QSS.Exhaust then
			DefensiveItems()
		end
		if buff.type == 5 and Menu.ItemsSettings.QSS.Stun then
			DefensiveItems()
		end
		if buff.type == 7 and Menu.ItemsSettings.QSS.Silence then
			DefensiveItems()
		end
		if buff.type == 8 and Menu.ItemsSettings.QSS.Taunt then
			DefensiveItems()
		end
		if buff.type == 10 and Menu.ItemsSettings.QSS.Fear then
			DefensiveItems()
		end
		if buff.type == 11 and Menu.ItemsSettings.QSS.Root then
			DefensiveItems()
		end
		if buff.type == 21 and Menu.ItemsSettings.QSS.Charm then
			DefensiveItems()
		end
		if buff.type == 24 and Menu.ItemsSettings.QSS.Suppression then
			DefensiveItems()
		end
		if buff.type == 25 and Menu.ItemsSettings.QSS.Blind then
			DefensiveItems()
		end
		if buff.type == 29 and Menu.ItemsSettings.QSS.KnockUp then
			DefensiveItems()
		end
	end
end)

AddUnloadCallback(function ()
	PrintMsg("Unloading")
end)

AddBugsplatCallback(function ()
	local file = io.open(SCRIPT_PATH.."DoctorYi.bugsplat", "a")
	file:write("\n"..tostring(debug.traceback()))
	file:close()
end)