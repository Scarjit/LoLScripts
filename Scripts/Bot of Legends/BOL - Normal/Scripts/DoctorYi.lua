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
	
	More Soon !
	

]]--

version = 1.05

assert(load(Base64Decode("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"), nil, "bt", _ENV))()
TrackerLoad("RM6rUV5ifrGr3MQE")

if myHero.charName ~= "MasterYi" then return end

AARange = 189
lastAttack = 0
lastWindUpTime = 0
lastAttackCD = 0
BaseWindUp = 1
BaseAttackSpeed = 1
QRange = 600
EActive = false
RActive = false
SmiteRange = 560
SmitePos = nil
abilityLevel = 0
kills = 0
assists = 0
minions = minionManager(MINION_ENEMY, QRange, myHero, MINION_SORT_MINHEALTH_DEC)
jungleMinions = minionManager(MINION_JUNGLE, SmiteRange, myHero, MINION_SORT_MINHEALTH_DEC)
DragonSprite = GetSprite("\\DoctorYi\\Dragon.png") 
BaronSprite = GetSprite("\\DoctorYi\\Baron.png") 
TimeDragonDown = 0
TimeDragonSpawn = 0
TimeBaronDown = 0
TimeBaronSpawn = 0
OffensiveItemsList = {
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
DefensiveItemsList = {
	QSS = { id = 3140, slot = nil }, -- Quicksilver Sash
	MCS = { id = 3139, slot = nil } -- Mercurial Scimitar
}
Dash = {
	-- Lee Sin W
	-- Thresh Q second activation
	-- Thresh W
	-- Caitlyn E
	-- Vayne Q
	-- Ekko E
	-- Gnar E
	-- Zac E
	-- Azir E
	-- Braum W
	-- Quinn E
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

if myHero:GetSpellData(SUMMONER_1).name:find("Smite") then SmitePos = SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("Smite") then SmitePos = SUMMONER_2 end

function OnLoad()
	Update()
	CheckSprites()
	DrawMenu()
	GetTowers()
end

function DrawMenu()
	Menu = scriptConfig("Doctor Yi", "MasterYi")

	Menu:addSubMenu("General Settings", "GeneralSettings")
		Menu.GeneralSettings:addParam("diveQON", "Use Alpha Strike under towers", SCRIPT_PARAM_ONOFF, true)
		Menu.GeneralSettings:addParam("followON", "Follow dash and flash", SCRIPT_PARAM_ONOFF, true)
		Menu.GeneralSettings:addParam("UseSmite", "Smite Dragon, Rift Herald and Baron", SCRIPT_PARAM_ONOFF, true)
		Menu.GeneralSettings:addParam("DodgeDragonON", "Dodge Dragon ~kick~", SCRIPT_PARAM_ONOFF, true)

	Menu:addSubMenu("Key Settings", "KeySettings")
		Menu.KeySettings:addParam("comboON", "Combo", SCRIPT_PARAM_ONKEYDOWN, false, string.byte(" "))
		Menu.KeySettings:addParam("JungleClearON", "Jungle Clear", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
	
	Menu:addSubMenu("Humanizer", "HumanizerSettings")
		Menu.HumanizerSettings:addParam("ComboHumanizerON", "Humanizer for combo", SCRIPT_PARAM_ONOFF, true)
		Menu.HumanizerSettings:addParam("ComboHumanizerMinValue", "Min Value", SCRIPT_PARAM_SLICE, 100, 0, 1000, 0)
		Menu.HumanizerSettings:addParam("ComboHumanizerMaxValue", "Max Value", SCRIPT_PARAM_SLICE, 200, 0, 1000, 0)
			Menu.HumanizerSettings:setCallback("ComboHumanizerMinValue", function (value) if value < Menu.HumanizerSettings.ComboHumanizerMinValue then Menu.HumanizerSettings.ComboHumanizerMaxValue = Menu.HumanizerSettings.ComboHumanizerMinValue end end)
			Menu.HumanizerSettings:setCallback("ComboHumanizerMaxValue", function (value) if value > Menu.HumanizerSettings.ComboHumanizerMaxValue then Menu.HumanizerSettings.ComboHumanizerMinValue = Menu.HumanizerSettings.ComboHumanizerMaxValue end end)
		Menu.HumanizerSettings:addParam("SpaceHumanizer11","____________________________________________", 5, "")
		Menu.HumanizerSettings:addParam("SpaceHumanizer12","", 5, "")
		Menu.HumanizerSettings:addParam("DodgeHumanizerON", "Humanizer for dodge", SCRIPT_PARAM_ONOFF, true)
		Menu.HumanizerSettings:addParam("DodgeHumanizerMinValue", "Min Value", SCRIPT_PARAM_SLICE, 150, 0, 1000, 0)
		Menu.HumanizerSettings:addParam("DodgeHumanizerMaxValue", "Max Value", SCRIPT_PARAM_SLICE, 300, 0, 1000, 0)
			Menu.HumanizerSettings:setCallback("DodgeHumanizerMinValue", function (value) if value < Menu.HumanizerSettings.DodgeHumanizerMinValue then Menu.HumanizerSettings.DodgeHumanizerMaxValue = Menu.HumanizerSettings.DodgeHumanizerMinValue end end)
			Menu.HumanizerSettings:setCallback("DodgeHumanizerMaxValue", function (value) if value > Menu.HumanizerSettings.DodgeHumanizerMaxValue then Menu.HumanizerSettings.DodgeHumanizerMinValue = Menu.HumanizerSettings.DodgeHumanizerMaxValue end end)
		Menu.HumanizerSettings:addParam("SpaceHumanizer21","____________________________________________", 5, "")
		Menu.HumanizerSettings:addParam("SpaceHumanizer22","", 5, "")
		Menu.HumanizerSettings:addParam("FollowHumanizerON", "Humanizer for Follow", SCRIPT_PARAM_ONOFF, true)
		Menu.HumanizerSettings:addParam("FollowHumanizerMinValue", "Min Value", SCRIPT_PARAM_SLICE, 150, 0, 1000, 0)
		Menu.HumanizerSettings:addParam("FollowHumanizerMaxValue", "Max Value", SCRIPT_PARAM_SLICE, 300, 0, 1000, 0)
			Menu.HumanizerSettings:setCallback("FollowHumanizerMinValue", function (value) if value < Menu.HumanizerSettings.FollowHumanizerMinValue then Menu.HumanizerSettings.FollowHumanizerMaxValue = Menu.HumanizerSettings.FollowHumanizerMinValue end end)
			Menu.HumanizerSettings:setCallback("FollowHumanizerMaxValue", function (value) if value > Menu.HumanizerSettings.FollowHumanizerMaxValue then Menu.HumanizerSettings.FollowHumanizerMinValue = Menu.HumanizerSettings.FollowHumanizerMaxValue end end)
		Menu.HumanizerSettings:addParam("SpaceHumanizer31","____________________________________________", 5, "")
		Menu.HumanizerSettings:addParam("SpaceHumanizer32","", 5, "")
		Menu.HumanizerSettings:addParam("SmiteHumanizerON", "Humanizer for smite", SCRIPT_PARAM_ONOFF, true)
		Menu.HumanizerSettings:addParam("SmiteHumanizerMinValue", "Min Value", SCRIPT_PARAM_SLICE, 100, 0, 1000, 0)
		Menu.HumanizerSettings:addParam("SmiteHumanizerMaxValue", "Max Value", SCRIPT_PARAM_SLICE, 200, 0, 1000, 0)
			Menu.HumanizerSettings:setCallback("SmiteHumanizerMinValue", function (value) if value < Menu.HumanizerSettings.SmiteHumanizerMinValue then Menu.HumanizerSettings.SmiteHumanizerMaxValue = Menu.HumanizerSettings.SmiteHumanizerMinValue end end)
			Menu.HumanizerSettings:setCallback("SmiteHumanizerMaxValue", function (value) if value > Menu.HumanizerSettings.SmiteHumanizerMaxValue then Menu.HumanizerSettings.SmiteHumanizerMinValue = Menu.HumanizerSettings.SmiteHumanizerMaxValue end end)
		Menu.HumanizerSettings:addParam("SpaceHumanizer41","____________________________________________", 5, "")
		Menu.HumanizerSettings:addParam("SpaceHumanizer42","", 5, "")
		Menu.HumanizerSettings:addParam("QSSHumanizerON", "Humanizer for QSS", SCRIPT_PARAM_ONOFF, true)
		Menu.HumanizerSettings:addParam("QSSHumanizerMinValue", "Min Value", SCRIPT_PARAM_SLICE, 100, 0, 1000, 0)
		Menu.HumanizerSettings:addParam("QSSHumanizerMaxValue", "Max Value", SCRIPT_PARAM_SLICE, 200, 0, 1000, 0)
			Menu.HumanizerSettings:setCallback("QSSHumanizerMinValue", function (value) if value < Menu.HumanizerSettings.QSSHumanizerMinValue then Menu.HumanizerSettings.QSSHumanizerMaxValue = Menu.HumanizerSettings.QSSHumanizerMinValue end end)
			Menu.HumanizerSettings:setCallback("QSSHumanizerMaxValue", function (value) if value > Menu.HumanizerSettings.QSSHumanizerMaxValue then Menu.HumanizerSettings.QSSHumanizerMinValue = Menu.HumanizerSettings.QSSHumanizerMaxValue end end)
		-- Menu.HumanizerSettings:addParam("SpaceHumanizer51","____________________________________________", 5, "")
		-- Menu.HumanizerSettings:addParam("SpaceHumanizer52","", 5, "")
		-- Menu.HumanizerSettings:addParam("EmoteHumanizerON", "Humanizer for emote", SCRIPT_PARAM_ONOFF, true)
		-- Menu.HumanizerSettings:addParam("EmoteHumanizerMinValue", "Min Value", SCRIPT_PARAM_SLICE, 200, 0, 1000, 0)
		-- Menu.HumanizerSettings:addParam("EmoteHumanizerMaxValue", "Max Value", SCRIPT_PARAM_SLICE, 300, 0, 1000, 0)
			-- Menu.HumanizerSettings:setCallback("EmoteHumanizerMinValue", function (value) if value < Menu.HumanizerSettings.EmoteHumanizerMinValue then Menu.HumanizerSettings.EmoteHumanizerMaxValue = Menu.HumanizerSettings.EmoteHumanizerMinValue end end)
			-- Menu.HumanizerSettings:setCallback("EmoteHumanizerMaxValue", function (value) if value > Menu.HumanizerSettings.EmoteHumanizerMaxValue then Menu.HumanizerSettings.EmoteHumanizerMinValue = Menu.HumanizerSettings.EmoteHumanizerMaxValue end end)
		
	Menu:addSubMenu("Combo", "Combo")
		Menu.Combo:addParam("UseQCombo", "Use Alpha Strike (Q) in combo", SCRIPT_PARAM_ONOFF, true)
		Menu.Combo:addParam("UseECombo", "Use Wuju Style (E) in combo", SCRIPT_PARAM_ONOFF, true)
		Menu.Combo:addParam("UseRCombo", "Use Highlander (R) in combo", SCRIPT_PARAM_ONOFF, true)
		Menu.Combo:addParam("UseSCombo", "Use Smite in combo", SCRIPT_PARAM_ONOFF, true)
		
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
		Menu.DodgeSettings:addParam("DodgeON", "Dodge dangerous spells with Q or W", SCRIPT_PARAM_ONOFF, true)
	
	Menu:addSubMenu("Draw", "DrawSettings")
		Menu.DrawSettings:addParam("DrawAaON", "Draw AA range", SCRIPT_PARAM_ONOFF, false)
		Menu.DrawSettings:addParam("DrawTargetON", "Draw current target", SCRIPT_PARAM_ONOFF, true)
		Menu.DrawSettings:addParam("DrawSmiteON", "Draw Smite range", SCRIPT_PARAM_ONOFF, true)
		Menu.DrawSettings:addParam("DrawQON", "Draw Alpha Strike range", SCRIPT_PARAM_ONOFF, true)
		Menu.DrawSettings:addParam("SpaceDraw11","____________________________________________", 5, "")
		Menu.DrawSettings:addParam("SpaceDraw12","", 5, "")
		Menu.DrawSettings:addParam("TimerON", "Draw Timers", SCRIPT_PARAM_ONOFF, true)
		Menu.DrawSettings:addParam("TimerY", "Vertical Position of the Timer", SCRIPT_PARAM_SLICE, 50, 0, WINDOW_H - 120, 0)
		Menu.DrawSettings:addParam("TimerX", "Horizontal Position of the Timer", SCRIPT_PARAM_SLICE, 50, 0, WINDOW_W - 128, 0)
		Menu.DrawSettings:addParam("TimerType", "Display in ", SCRIPT_PARAM_LIST, 1, {"column", "row"})
		Menu.DrawSettings:addParam("SpaceDraw21","____________________________________________", 5, "")
		Menu.DrawSettings:addParam("SpaceDraw22","", 5, "")
		Menu.DrawSettings:addParam("DrawQuality", "Quality of the circle", SCRIPT_PARAM_SLICE, 30, 10, 50, 0)

	Menu:addSubMenu("Miscellaneous", "MiscSettings")
		Menu.MiscSettings:addParam("SetSkin", "Select Skin", SCRIPT_PARAM_LIST, 7, {"Assassin", "Chosen", "Ionia", "Samurai Yi", "Headhunter", "Chroma Pack: Gold", "Chroma Pack: Aqua", "Chroma Pack: Crimson", "PROJECT","Classic"})
		Menu.MiscSettings:addParam("AutoLevelON", "Auto level spells (Q>E>W)", SCRIPT_PARAM_ONOFF, true)
		Menu.MiscSettings:addParam("EmoteON", "Mastery Emote on kill or assist", SCRIPT_PARAM_ONOFF, true)
	
	ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, 1000, DAMAGE_PHYSICAL, true)
	ts.name = "DoctorYi"
	Menu:addTS(ts)
	
	Menu.KeySettings:permaShow("comboON")
	Menu.DodgeSettings:permaShow("DodgeON")
	Menu.GeneralSettings:permaShow("followON")
	Menu.GeneralSettings:permaShow("UseSmite")
	
	Menu:addParam("space2", "", 5, "")
	Menu:addParam("signature0", "            Doctor Yi v"..version, 5, "")
	Menu:addParam("signature1", "          Let the Doctor carry", 5, "")
	Menu:addParam("signature2", "              by DrPhoenix    ", 5, "")
end

function OnTick()
	HumanizerTime()
	AutoLevel()
	SetSkin(myHero, Menu.MiscSettings.SetSkin)
	GetTimers()
	jungleMinions:update()
	CheckJungle()
	Combo()
	JungleClear()
	OffensiveItems()
	CheckTower()
	target = GetCustomTarget()
	ts:update()
end

function GetCustomTarget()
 	ts:update()
	return ts.target
end

function CheckJungle()
	if Menu.GeneralSettings.UseSmite then
		for i, jungle in pairs(jungleMinions.objects) do
			if jungle ~= nil then
				SmiteMonster(jungle)
			end
		end
	end	 
end

function GetTowers()
	towers = {}
	for i=1, objManager.maxObjects do
		obj = objManager:GetObject(i)
		if obj and obj.team ~= myHero.team and obj.health > 0 and obj.type == "obj_AI_Turret" then
			towers[#towers+1] = obj
		end
	end
end
	
function CheckTower()
	outTower = true
	if Menu.GeneralSettings.diveQON == false then
		for _,v in pairs(towers) do
			if ObjectIsValid(target) and GetDistance(v, target) < 775 then
				outTower = false
				break
			elseif ObjectIsValid(target) and GetDistance(v, target) > 775 then
				outTower = true
				break
			end
		end
	end
end

function ObjectIsValid(obj)
	if obj ~= nil and obj.valid and not obj.dead and obj.bTargetable then
		return true
	end
end

function OnDraw()
	if SmitePos ~= nil and Menu.DrawSettings.DrawSmiteON and myHero:CanUseSpell(SmitePos) and not myHero.dead then
		DrawCircle3D(myHero.x, myHero.y, myHero.z, SmiteRange, 1, RGB(255,130,0), Menu.DrawSettings.DrawQuality)
	end
	if Menu.DrawSettings.DrawQON and myHero:CanUseSpell(_Q) and not myHero.dead then
		DrawCircle3D(myHero.x, myHero.y, myHero.z, QRange, 1, RGB(178,255,0), Menu.DrawSettings.DrawQuality)
	end
	if Menu.DrawSettings.DrawAaON and not myHero.dead then
		DrawCircle3D(myHero.x, myHero.y, myHero.z, AARange, 1, RGB(255,100,100), Menu.DrawSettings.DrawQuality)
	end
	if Menu.DrawSettings.DrawTargetON and not myHero.dead and ObjectIsValid(target) then
		DrawCircle3D(target.x, target.y, target.z, 75, 3, RGB(178,0,255), 4)
	end
	if Menu.DrawSettings.TimerType == 1 and Menu.DrawSettings.TimerON then
		DragonSprite:Draw(Menu.DrawSettings.TimerX,Menu.DrawSettings.TimerY, 255)
		DragonSprite:SetScale(0.4, 0.4)
		if DragonTimer == "00:00" then
			DrawText("Live !", 15, Menu.DrawSettings.TimerX + 66, Menu.DrawSettings.TimerY + 23, ARGB(255,187,255,0))
		else
			DrawText(DragonTimer, 15, Menu.DrawSettings.TimerX + 66, Menu.DrawSettings.TimerY + 23, ARGB(255,187,255,0))
		end
		BaronSprite:Draw(Menu.DrawSettings.TimerX, Menu.DrawSettings.TimerY + 60, 255)
		BaronSprite:SetScale(0.4, 0.4)
		if BaronTimer == "00:00" then
			DrawText("Live !", 15, Menu.DrawSettings.TimerX + 66, Menu.DrawSettings.TimerY + 83, ARGB(255,187,255,0))
		else
			DrawText(BaronTimer, 15, Menu.DrawSettings.TimerX + 66, Menu.DrawSettings.TimerY + 83, ARGB(255,187,255,0))
		end
	elseif Menu.DrawSettings.TimerType == 2 and Menu.DrawSettings.TimerON then
		DragonSprite:Draw(Menu.DrawSettings.TimerX,Menu.DrawSettings.TimerY, 255)
		DragonSprite:SetScale(0.4, 0.4)
		if DragonTimer == "00:00" then
			DrawText("Live !", 15, Menu.DrawSettings.TimerX + 66, Menu.DrawSettings.TimerY + 23, ARGB(255,187,255,0))
		else
			DrawText(DragonTimer, 15, Menu.DrawSettings.TimerX + 66, Menu.DrawSettings.TimerY + 23, ARGB(255,187,255,0))
		end
		BaronSprite:Draw(Menu.DrawSettings.TimerX + 128, Menu.DrawSettings.TimerY, 255)
		BaronSprite:SetScale(0.4, 0.4)
		if BaronTimer == "00:00" then
			DrawText("Live !", 15, Menu.DrawSettings.TimerX + 194, Menu.DrawSettings.TimerY + 23, ARGB(255,187,255,0))
		else
			DrawText(BaronTimer, 15, Menu.DrawSettings.TimerX + 194, Menu.DrawSettings.TimerY + 23, ARGB(255,187,255,0))
		end
	end
end

function PrintMsg(msg)
	PrintChat("<font color=\"#6eed00\"><b>[</b></font><font color=\"#a2ed00\"><b>Doctor Yi</b></font><font color=\"#6eed00\"><b>]</b></font> <font color=\"#fce700\">"..msg.."</font>")
end

function HumanizerTime()
	if Menu.HumanizerSettings.ComboHumanizerON == true then
		ComboHumanizer = math.random(Menu.HumanizerSettings.ComboHumanizerMinValue, Menu.HumanizerSettings.ComboHumanizerMaxValue)/1000
	else
		ComboHumanizer = 0
	end
	if Menu.HumanizerSettings.DodgeHumanizerON == true then
		DodgeHumanizer = math.random(Menu.HumanizerSettings.DodgeHumanizerMinValue, Menu.HumanizerSettings.DodgeHumanizerMaxValue)/1000 
	else
		DodgeHumanizer = 0
	end
	if Menu.HumanizerSettings.FollowHumanizerON == true then
		FollowHumanizer = math.random(Menu.HumanizerSettings.FollowHumanizerMinValue, Menu.HumanizerSettings.FollowHumanizerMaxValue)/1000 
	else
		FollowHumanizer = 0
	end
	if Menu.HumanizerSettings.SmiteHumanizerON == true then
		SmiteHumanizer = math.random(Menu.HumanizerSettings.SmiteHumanizerMinValue, Menu.HumanizerSettings.SmiteHumanizerMaxValue)/1000
	else
		SmiteHumanizer = 0
	end
	if Menu.HumanizerSettings.QSSHumanizerON == true then
		QSSHumanizer = math.random(Menu.HumanizerSettings.QSSHumanizerMinValue, Menu.HumanizerSettings.QSSHumanizerMaxValue)/1000
	else
		QSSHumanizer = 0
	end
	if Menu.HumanizerSettings.EmoteHumanizerON == true then
		EmoteHumanizer = math.random(Menu.HumanizerSettings.EmoteHumanizerMinValue, Menu.HumanizerSettings.EmoteHumanizerMaxValue)/1000
	else
		EmoteHumanizer = 0
	end
end

function AutoLevel()
	if Menu.MiscSettings.AutoLevelON then
		abilitySequence = {SPELL_1,SPELL_2,SPELL_3,SPELL_1,SPELL_1,SPELL_4,SPELL_1,SPELL_3,SPELL_1,SPELL_3,SPELL_4,SPELL_3,SPELL_3,SPELL_2,SPELL_2,SPELL_4,SPELL_2,SPELL_2}
		if myHero.level > abilityLevel then
			abilityLevel = abilityLevel + 1
			LevelSpell(abilitySequence[abilityLevel])
		end
	end
end

function GetTimers()
	if ((GetInGameTimer() - TimeDragonDown) < 360 and (GetInGameTimer() - TimeDragonDown) >= 0) then 
		if(GetInGameTimer() < 360) then
			TimeDragonSpawn = 150 - (GetInGameTimer() - TimeDragonDown) + 1
		else
			TimeDragonSpawn = 360 - (GetInGameTimer() - TimeDragonDown) + 1
		end
	end
	
	if TimeDragonSpawn <= 0 then 
		TimeDragonSpawn = 0
	end
	
	if ((GetInGameTimer() - TimeBaronDown) < 1200 and (GetInGameTimer() - TimeBaronDown) >= 0) then 
		if(GetInGameTimer() < 1200) then
			TimeBaronSpawn = 1200 - (GetInGameTimer() - TimeBaronDown) + 1
		else
			TimeBaronSpawn = 420 - (GetInGameTimer() - TimeBaronDown) + 1
		end
	end
	
	if TimeBaronSpawn <= 0 then 
		TimeBaronSpawn = 0
	end
	
	nMins = string.format("%02.f", math.floor(TimeDragonSpawn/60))
	nSecs = string.format("%02.f", math.floor(TimeDragonSpawn - nMins *60))
	DragonTimer = nMins..":" ..nSecs
	
	nMins = string.format("%02.f", math.floor(TimeBaronSpawn/60))
	nSecs = string.format("%02.f", math.floor(TimeBaronSpawn - nMins *60))
	BaronTimer = nMins..":" ..nSecs
end

function GetSmiteDamage()
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

function SmiteMonster(obj)
	if SmitePos ~= nil and myHero:CanUseSpell(SmitePos) == READY and GetDistance(obj) <= SmiteRange and obj.health <= GetSmiteDamage() then
		if obj.charName == "SRU_Baron" or obj.charName == "SRU_Dragon_Water" or obj.charName == "SRU_Dragon_Fire" or obj.charName == "SRU_Dragon_Earth" or obj.charName == "SRU_Dragon_Air" or obj.charName == "SRU_Dragon_Elder" or obj.charName == "SRU_RiftHerald" then
			DelayAction(function(obj) if ObjectIsValid(obj) then CastSpell(SmitePos, obj) end end, SmiteHumanizer, {obj})
		end
	end
end

function OnAnimation(unit, animation)
	if unit.charName:find("SRU_Dragon") and animation == "Spell2" and Menu.GeneralSettings.DodgeDragonON then
		DelayAction(function(unit) if ObjectIsValid(unit) then CastSpell(_Q, unit) end end, 0.25, {unit})
	end
	
	if unit.team ~= myHero.team and unit.type == myHero.type and animation == "Death" and Menu.MiscSettings.EmoteON then
		if kills ~= myHero.kills or assists ~= myHero.assists then
			DelayAction(function() SendChat("/masterybadge") end, EmoteHumanizer)
			kills = myHero.kills
			assists = myHero.assists
		end
    end
end

function OnProcessSpell(unit,spell)
	if unit.team ~= myHero.team and spell and spell.target and spell.target.isMe then
		Dodge(DodgeHumanizer, true, unit.charName, spell.name)
	end
	
	if unit.team ~= myHero.team and Menu.GeneralSettings.followON then
		if spell.name == "SummonerFlash" and GetDistance(myHero, spell.endPos) > GetDistance(myHero, spell.startPos) then
			DelayAction(function(unit) if ObjectIsValid(unit) then CastSpell(_Q, unit) end end, FollowHumanizer, {unit})
		else
			for _, dash in pairs(Dash) do
				if spell.name == dash and GetDistance(myHero, spell.endPos) > GetDistance(myHero, spell.startPos) then
					DelayAction(function(unit) if ObjectIsValid(unit) then CastSpell(_Q, unit) end end, FollowHumanizer, {unit})
				end
			end
		end
	end
end

function OnApplyBuff(unit, source, buff)
	if unit and unit.isMe and source and source.isMe then
		if buff and buff.name:find("supercharged") then
			EActive = true
		end
	end
	
	if source and source.isMe and not source.charName:lower():find("baron") and not source.charName:lower():find("spiderboss") then
		if buff.name == "SummonerExhaust" and Menu.ItemsSettings.QSS.Exhaust then
			DefensiveItems("Exhaust")
		end
		if buff.type == 5 and Menu.ItemsSettings.QSS.Stun then
			DefensiveItems("Stun")
		end
		if buff.type == 7 and Menu.ItemsSettings.QSS.Silence then
			DefensiveItems("Silence")
		end
		if buff.type == 8 and Menu.ItemsSettings.QSS.Taunt then
			DefensiveItems("Taunt")
		end
		if buff.type == 10 and Menu.ItemsSettings.QSS.Fear then
			DefensiveItems("Fear")
		end
		if buff.type == 11 and Menu.ItemsSettings.QSS.Root then
			DefensiveItems("Root")
		end
		if buff.type == 21 and Menu.ItemsSettings.QSS.Charm then
			DefensiveItems("Charm")
		end
		if buff.type == 24 and Menu.ItemsSettings.QSS.Suppression then
			DefensiveItems("Suppression")
		end
		if buff.type == 25 and Menu.ItemsSettings.QSS.Blind then
			DefensiveItems("Blind")
		end
		if buff.type == 29 and Menu.ItemsSettings.QSS.KnockUp then
			DefensiveItems("KnockUp")
		end
	end
end

function OnRemoveBuff(unit, buff)
	if unit and unit.isMe and buff and buff.name:find("supercharged") then
		EActive = false
	end
end

function OnProcessAttack(unit, spell)
	if unit.isMe and (spell.name:lower():find("attack") or spell.name:lower():find("masteryidoublestrike")) then
		lastAttack = GetTickCount() - GetLatency() * 0.5
		lastWindUpTime = spell.windUpTime * 1000
		lastAttackCD = spell.animationTime * 1000
		BaseAttackSpeed = 1 / (spell.animationTime * myHero.attackSpeed)
		BaseWindUp = 1 / (lastWindUpTime * myHero.attackSpeed)
	end
end

function ComboCanMove()
	return (GetTickCount() - 20 + (GetLatency() * 0.5) - lastAttack) >= (1000/(myHero.attackSpeed*BaseWindUp))
end 
 
function ComboCanAuto()
	return (GetTickCount() - 20 + (GetLatency() * 0.5) - lastAttack) >= (1000/(myHero.attackSpeed*BaseAttackSpeed))
end 

function Combo()
	if Menu.KeySettings.comboON and outTower and ObjectIsValid(target) then
		if myHero:CanUseSpell(_R) == READY and GetDistance(target, myHero) <= 1000 and Menu.Combo.UseRCombo then
			CastSpell(_R)
		end
		if GetDistance(target, myHero) > AARange then
			if myHero:CanUseSpell(_Q) == READY then
				if Menu.Combo.UseQCombo then
					CastSpell(_Q,target)
				end
			else
				myHero:MoveTo(target.x,target.z)
			end
		else
			if myHero:CanUseSpell(_E) == READY and Menu.Combo.UseECombo then
				CastSpell(_E)
			elseif ComboCanAuto() then
				myHero:Attack(target)
			end
		end
	end
end

function OffensiveItems()
	if Menu.KeySettings.comboON and ObjectIsValid(target) then
		for _, item in pairs(OffensiveItemsList) do
			item.slot = GetInventorySlotItem(item.id)
			if item.slot ~= nil then
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

function DefensiveItems(BuffType)
	for _, item in pairs(DefensiveItemsList) do
		item.slot = GetInventorySlotItem(item.id)
		if item.slot ~= nil then
			DelayAction(function() CastSpell(item.slot) end, QSSHumanizer)
		end
	end
end

function JungleClear()
	if Menu.KeySettings.JungleClearON then
		for i, minion in pairs(minionManager(MINION_JUNGLE, 500, myHero, MINION_SORT_MAXHEALTH_ASC).objects) do
			if i == 1 and minion.charName ~= "SRU_CampRespawnMarker" and ObjectIsValid(minion) then
				if myHero:CanUseSpell(_E) then
					CastSpell(_E)
				end
				if myHero:CanUseSpell(_Q) then
					myHero:Attack(minion)
					DelayAction(function(minion) if ObjectIsValid(minion) then CastSpell(_Q, minion) end end, 1.2, {minion})
				end
			end
		end
	end
end

function Dodge(delay, useW, champ, name)
	minions = minionManager(MINION_ENEMY, QRange, myHero, MINION_SORT_MINHEALTH_DEC)
	minionManager(MINION_JUNGLE, QRange, myHero, MINION_SORT_MINHEALTH_DEC)
	DelayAction(function()
		if myHero:CanUseSpell(_Q) then
			for i, unit in ipairs(GetEnemyHeroes()) do
				if ObjectIsValid(unit) then
					if GetDistance(unit, myHero) <= QRange and outTower then
						Target = unit
						CastSpell(_Q, Target)
					elseif #minions.objects > 0 then
						CastSpell(_Q, minions.objects[1])
					elseif #jungleMinions.objects > 0 then
						CastSpell(_Q, jungleMinions.objects[1])	
					end
				end
			end
		end
	end, delay)
end

function OnCreateObj(obj)
	if obj.name == "SRU_Dragon_Death.troy" then
		TimeDragonSpawn = 360
		TimeDragonDown = GetInGameTimer()
	end
	if obj.name == "SRU_Baron_Death.troy" then
		TimeBaronSpawn = 420
		TimeBaronDown = GetInGameTimer()
	end
end

function CheckSprites()
	local dir = SPRITE_PATH.."\\DoctorYi\\"
	local url = "http://www.s1mplescripts.de/DrPhoenix/BoL/Scripts/DoctorYi/Sprites/"
	local spriteDragon = "Dragon.png"
	local spriteBaron = "Baron.png"
	
	if not FileExist(dir..spriteDragon) or not FileExist(dir..spriteBaron) then
		PrintMsg("Downloading sprites, don't reload the script.")
		CreateDirectory(dir)
		DownloadFile(url..spriteDragon, dir..spriteDragon, function() end)
		DownloadFile(url..spriteBaron, dir..spriteBaron, function() PrintMsg("Download was successful, please reload the script by pressing F9 twice.") end)
		return
	else
		DragonSprite = GetSprite("\\DoctorYi\\Dragon.png") 
		BaronSprite = GetSprite("\\DoctorYi\\Baron.png") 
		PrintMsg("Loaded !")
	end
end

function Update()
    local UpdateHost = "www.s1mplescripts.de"
    local ServerPath = "/DrPhoenix/BoL/Scripts/DoctorYi/"
    local ServerFileName = "DoctorYi.lua"
    local ServerVersionFileName = "DoctorYi.version"
 
    DL = Download()
    local ServerVersionDATA = GetWebResult("s1mplescripts.de" , ServerPath..ServerVersionFileName)
    if ServerVersionDATA then
        local ServerVersion = tonumber(ServerVersionDATA)
        if ServerVersion then
            if ServerVersion > tonumber(version) then
                PrintMsg("Updating, don't press F9")
                DL:newDL(UpdateHost, ServerPath..ServerFileName, ServerFileName, SCRIPT_PATH, function ()
                    PrintMsg("DoctorYi updated, please reload")
                end)
            end
        else
            PrintMsg("An error occured, while updating, please reload")
        end
    else
        PrintMsg("Could not connect to update Server")
    end
	
	local KDA = nil
end
 
 
class "Download"
function Download:__init()
    socket = require("socket")
    self.aktivedownloads = {}
    self.callbacks = {}
 
    AddTickCallback(function ()
        self:RemoveDone()
    end)
 
    class("Async")
    function Async:__init(host, filepath, localname, drawoffset, localpath)
        self.progress = 0
        self.host = host
        self.filepath = filepath
        self.localname = localname
        self.offset = drawoffset
        self.localpath = localpath
        self.CRLF = '\r\n'
 
        self.headsocket = socket.tcp()
        self.headsocket:settimeout(1)
        self.headsocket:connect(self.host, 80)
        self.headsocket:send('HEAD '..self.filepath..' HTTP/1.1'.. self.CRLF ..'Host: '..self.host.. self.CRLF ..'User-Agent: Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36'.. self.CRLF .. self.CRLF)
 
        self.HEADdata = ""
        self.DLdata = ""
        self.StartedDownload = false
        self.canDL = true
 
        AddTickCallback(function ()
            self:tick()
        end)
        AddDrawCallback(function ()
            self:draw()
        end)
    end
 
    function Async:tick()
        if self.progress == 100 then return end
        if self.HEADcStatus ~= "timeout" and self.HEADcStatus ~= "closed" then
            self.HEADfString, self.HEADcStatus, self.HEADpString = self.headsocket:receive(16);
            if self.HEADfString then
                self.HEADdata = self.HEADdata..self.HEADfString
            elseif self.HEADpString and #self.HEADpString > 0 then
                self.HEADdata = self.HEADdata..self.HEADpString
            end
        elseif self.HEADcStatus == "timeout" then
            self.headsocket:close()
            --Find Lenght
            local begin = string.find(self.HEADdata, "Length: ")
            if begin then
                self.HEADdata = string.sub(self.HEADdata,begin+8)
                local n = 0
                local _break = false
                for i=1, #self.HEADdata do
                    local c = tonumber(string.sub(self.HEADdata,i,i))
                    if c and _break == false then
                        n = n+1
                    else
                        _break = true
                    end
                end
                self.HEADdata = string.sub(self.HEADdata,1,n)
                self.StartedDownload = true
                self.HEADcStatus = "closed"
            end
        end
        if self.HEADcStatus == "closed" and self.StartedDownload == true and self.canDL == true then --Double Check
            self.canDL = false
            self.DLsocket = socket.tcp()
            self.DLsocket:settimeout(1)
            self.DLsocket:connect(self.host, 80)
            --Start Main Download
            self.DLsocket:send('GET '..self.filepath..' HTTP/1.1'.. self.CRLF ..'Host: '..self.host.. self.CRLF ..'User-Agent: Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36'.. self.CRLF .. self.CRLF)
        end
       
        if self.DLsocket and self.DLcStatus ~= "timeout" and self.DLcStatus ~= "closed" then
            self.DLfString, self.DLcStatus, self.DLpString = self.DLsocket:receive(1024);
           
            if ((self.DLfString) or (self.DLpString and #self.DLpString > 0)) then
                self.DLdata = self.DLdata .. (self.DLfString or self.DLpString)
            end
 
        elseif self.DLcStatus and self.DLcStatus == "timeout" then
            self.DLsocket:close()
            self.DLcStatus = "closed"
            self.DLdata = string.sub(self.DLdata,#self.DLdata-tonumber(self.HEADdata)+1)
 
            local file = io.open(self.localpath.."\\"..self.localname, "w+b")
            file:write(self.DLdata)
            file:close()
            self.progress = 100
        end
 
        if self.progress ~= 100 and self.DLdata and #self.DLdata > 0 then
            self.progress = (#self.DLdata/tonumber(self.HEADdata))*100
        end
    end
 
    function Async:draw()
        if self.progress < 100 then
            DrawTextA("Downloading: "..self.localname,15,50,35+self.offset)
            DrawRectangleOutline(49,50+self.offset,250,20, ARGB(255,255,255,255),1)
            if self.progress ~= 100 then
                DrawLine(50,60+self.offset,50+(2.5*self.progress),60+self.offset,18,ARGB(150,255-self.progress*2.5,self.progress*2.5,255-self.progress*2.5))
                DrawTextA(tostring(math.round(self.progress).." %"), 15,150,52+self.offset)
            end
        end
    end
 
end
 
function Download:newDL(host, file, name, path, callback)
    local offset = (#self.aktivedownloads+1)*40
    self.aktivedownloads[#self.aktivedownloads+1] = Async(host, file, name, offset-40, path)
    if not callback then
        callback = (function ()
        end)
    end
 
    self.callbacks[#self.callbacks+1] = callback
 
end
 
function Download:RemoveDone()
    if #self.aktivedownloads == 0 then return end
    local x = {}
    for k, v in pairs(self.aktivedownloads) do
        if math.round(v.progress) < 100 then
            v.offset = k*40-40
            x[#x+1] = v
        else
            self.callbacks[k]()
        end
    end
    self.aktivedownloads = {}
    self.aktivedownloads = x
end