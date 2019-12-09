--[[


 		   Doctor KogMaw
		SCRIPT BY DrPhoenix


Changelog :

	1.01 : First release
	1.02 : Bol-Tools Tracker
	1.03 : Bug fix
	1.04 : Bug fix
	1.05 : Removed structures as it was causing bugsplats
	1.06 : Fix an other bugsplat !
	1.07 : Fix is now fully working thanks to Izsha
	
	More Soon !
	

]]--

version = 1.07

assert(load(Base64Decode("G0x1YVIAAQQEBAgAGZMNChoKAAAAAAAAAAAAAQQfAAAAAwAAAEQAAACGAEAA5QAAAJ1AAAGGQEAA5UAAAJ1AAAGlgAAACIAAgaXAAAAIgICBhgBBAOUAAQCdQAABhkBBAMGAAQCdQAABhoBBAOVAAQCKwICDhoBBAOWAAQCKwACEhoBBAOXAAQCKwICEhoBBAOUAAgCKwACFHwCAAAsAAAAEEgAAAEFkZFVubG9hZENhbGxiYWNrAAQUAAAAQWRkQnVnc3BsYXRDYWxsYmFjawAEDAAAAFRyYWNrZXJMb2FkAAQNAAAAQm9sVG9vbHNUaW1lAAQQAAAAQWRkVGlja0NhbGxiYWNrAAQGAAAAY2xhc3MABA4AAABTY3JpcHRUcmFja2VyAAQHAAAAX19pbml0AAQSAAAAU2VuZFZhbHVlVG9TZXJ2ZXIABAoAAABzZW5kRGF0YXMABAsAAABHZXRXZWJQYWdlAAkAAAACAAAAAwAAAAAAAwkAAAAFAAAAGABAABcAAIAfAIAABQAAAAxAQACBgAAAHUCAAR8AgAADAAAAAAQSAAAAU2VuZFZhbHVlVG9TZXJ2ZXIABAcAAAB1bmxvYWQAAAAAAAEAAAABAQAAAAAAAAAAAAAAAAAAAAAEAAAABQAAAAAAAwkAAAAFAAAAGABAABcAAIAfAIAABQAAAAxAQACBgAAAHUCAAR8AgAADAAAAAAQSAAAAU2VuZFZhbHVlVG9TZXJ2ZXIABAkAAABidWdzcGxhdAAAAAAAAQAAAAEBAAAAAAAAAAAAAAAAAAAAAAUAAAAHAAAAAQAEDQAAAEYAwACAAAAAXYAAAUkAAABFAAAATEDAAMGAAABdQIABRsDAAKUAAADBAAEAXUCAAR8AgAAFAAAABA4AAABTY3JpcHRUcmFja2VyAAQSAAAAU2VuZFZhbHVlVG9TZXJ2ZXIABAUAAABsb2FkAAQMAAAARGVsYXlBY3Rpb24AAwAAAAAAQHpAAQAAAAYAAAAHAAAAAAADBQAAAAUAAAAMAEAAgUAAAB1AgAEfAIAAAgAAAAQSAAAAU2VuZFZhbHVlVG9TZXJ2ZXIABAgAAAB3b3JraW5nAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAEBAAAAAAAAAAAAAAAAAAAAAAAACAAAAA0AAAAAAAYyAAAABgBAAB2AgAAaQEAAF4AAgEGAAABfAAABF0AKgEYAQQBHQMEAgYABAMbAQQDHAMIBEEFCAN0AAAFdgAAACECAgUYAQQBHQMEAgYABAMbAQQDHAMIBEMFCAEbBQABPwcICDkEBAt0AAAFdgAAACEAAhUYAQQBHQMEAgYABAMbAQQDHAMIBBsFAAA9BQgIOAQEARoFCAE/BwgIOQQEC3QAAAV2AAAAIQACGRsBAAIFAAwDGgEIAAUEDAEYBQwBWQIEAXwAAAR8AgAAOAAAABA8AAABHZXRJbkdhbWVUaW1lcgADAAAAAAAAAAAECQAAADAwOjAwOjAwAAQGAAAAaG91cnMABAcAAABzdHJpbmcABAcAAABmb3JtYXQABAYAAAAlMDIuZgAEBQAAAG1hdGgABAYAAABmbG9vcgADAAAAAAAgrEAEBQAAAG1pbnMAAwAAAAAAAE5ABAUAAABzZWNzAAQCAAAAOgAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAA4AAAATAAAAAAAIKAAAAAEAAABGQEAAR4DAAIEAAAAhAAiABkFAAAzBQAKAAYABHYGAAVgAQQIXgAaAR0FBAhiAwQIXwAWAR8FBAhkAwAIXAAWARQGAAFtBAAAXQASARwFCAoZBQgCHAUIDGICBAheAAYBFAQABTIHCAsHBAgBdQYABQwGAAEkBgAAXQAGARQEAAUyBwgLBAQMAXUGAAUMBgABJAYAAIED3fx8AgAANAAAAAwAAAAAAAPA/BAsAAABvYmpNYW5hZ2VyAAQLAAAAbWF4T2JqZWN0cwAECgAAAGdldE9iamVjdAAABAUAAAB0eXBlAAQHAAAAb2JqX0hRAAQHAAAAaGVhbHRoAAQFAAAAdGVhbQAEBwAAAG15SGVybwAEEgAAAFNlbmRWYWx1ZVRvU2VydmVyAAQGAAAAbG9vc2UABAQAAAB3aW4AAAAAAAMAAAAAAAEAAQEAAAAAAAAAAAAAAAAAAAAAFAAAABQAAAACAAICAAAACkAAgB8AgAABAAAABAoAAABzY3JpcHRLZXkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFAAAABUAAAACAAUKAAAAhgBAAMAAgACdgAABGEBAARfAAICFAIAAjIBAAQABgACdQIABHwCAAAMAAAAEBQAAAHR5cGUABAcAAABzdHJpbmcABAoAAABzZW5kRGF0YXMAAAAAAAIAAAAAAAEBAAAAAAAAAAAAAAAAAAAAABYAAAAlAAAAAgATPwAAAApAAICGgEAAnYCAAAqAgICGAEEAxkBBAAaBQQAHwUECQQECAB2BAAFGgUEAR8HBAoFBAgBdgQABhoFBAIfBQQPBgQIAnYEAAcaBQQDHwcEDAcICAN2BAAEGgkEAB8JBBEECAwAdggABFgECAt0AAAGdgAAACoCAgYaAQwCdgIAACoCAhgoAxIeGQEQAmwAAABdAAIAKgMSHFwAAgArAxIeGQEUAh4BFAQqAAIqFAIAAjMBFAQEBBgBBQQYAh4FGAMHBBgAAAoAAQQIHAIcCRQDBQgcAB0NAAEGDBwCHw0AAwcMHAAdEQwBBBAgAh8RDAFaBhAKdQAACHwCAACEAAAAEBwAAAGFjdGlvbgAECQAAAHVzZXJuYW1lAAQIAAAAR2V0VXNlcgAEBQAAAGh3aWQABA0AAABCYXNlNjRFbmNvZGUABAkAAAB0b3N0cmluZwAEAwAAAG9zAAQHAAAAZ2V0ZW52AAQVAAAAUFJPQ0VTU09SX0lERU5USUZJRVIABAkAAABVU0VSTkFNRQAEDQAAAENPTVBVVEVSTkFNRQAEEAAAAFBST0NFU1NPUl9MRVZFTAAEEwAAAFBST0NFU1NPUl9SRVZJU0lPTgAECwAAAGluZ2FtZVRpbWUABA0AAABCb2xUb29sc1RpbWUABAYAAABpc1ZpcAAEAQAAAAAECQAAAFZJUF9VU0VSAAMAAAAAAADwPwMAAAAAAAAAAAQJAAAAY2hhbXBpb24ABAcAAABteUhlcm8ABAkAAABjaGFyTmFtZQAECwAAAEdldFdlYlBhZ2UABA4AAABib2wtdG9vbHMuY29tAAQXAAAAL2FwaS9ldmVudHM/c2NyaXB0S2V5PQAECgAAAHNjcmlwdEtleQAECQAAACZhY3Rpb249AAQLAAAAJmNoYW1waW9uPQAEDgAAACZib2xVc2VybmFtZT0ABAcAAAAmaHdpZD0ABA0AAAAmaW5nYW1lVGltZT0ABAgAAAAmaXNWaXA9AAAAAAACAAAAAAABAQAAAAAAAAAAAAAAAAAAAAAmAAAAKgAAAAMACiEAAADGQEAAAYEAAN2AAAHHwMAB3YCAAArAAIDHAEAAzADBAUABgACBQQEA3UAAAscAQADMgMEBQcEBAIABAAHBAQIAAAKAAEFCAgBWQYIC3UCAAccAQADMgMIBQcECAIEBAwDdQAACxwBAAMyAwgFBQQMAgYEDAN1AAAIKAMSHCgDEiB8AgAASAAAABAcAAABTb2NrZXQABAgAAAByZXF1aXJlAAQHAAAAc29ja2V0AAQEAAAAdGNwAAQIAAAAY29ubmVjdAADAAAAAAAAVEAEBQAAAHNlbmQABAUAAABHRVQgAAQSAAAAIEhUVFAvMS4wDQpIb3N0OiAABAUAAAANCg0KAAQLAAAAc2V0dGltZW91dAADAAAAAAAAAAAEAgAAAGIAAwAAAPyD15dBBAIAAAB0AAQKAAAATGFzdFByaW50AAQBAAAAAAQFAAAARmlsZQAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAABAAAAAAAAAAAAAAAAAAAAAAA="), nil, "bt", _ENV))()
TrackerLoad("1H2viBkEwG3UaIFn")

if myHero.charName ~= "KogMaw" then return end

myRange = myHero.range + myHero.boundingRadius
lastAttack = 0
lastWindUpTime = 0
lastAttackCD = 0
BaseWindUp = 1
BaseAttackSpeed = 1
SmiteRange = 560
SmitePos = nil
kills = 0
assists = 0
rManaCost = 50
passive = false
minions = minionManager(MINION_ENEMY, myRange, myHero, MINION_SORT_MINHEALTH_ASC)
jungleMinions = minionManager(MINION_JUNGLE, SmiteRange, myHero, MINION_SORT_MINHEALTH_ASC)
OffensiveItemsList = {
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

if myHero:GetSpellData(SUMMONER_1).name:find("Smite") then SmitePos = SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("Smite") then SmitePos = SUMMONER_2 end

function OnLoad()
	Update()
	DrawMenu()
	UplUpdate()
	SetSkin(myHero, Menu.MiscSettings.SetSkin - 1)
	PrintMsg("Loaded !")
end

function UplUpdate()
	if not _G.UPLloaded then
		if FileExist(LIB_PATH .. "/UPL.lua") then
			require("UPL")
			_G.UPL = UPL()
		else 
			PrintMsg("Downloading UPL, please don't press F9")
			DelayAction(function() DownloadFile("https://raw.github.com/nebelwolfi/BoL/master/Common/UPL.lua".."?rand="..math.random(1,10000), LIB_PATH.."UPL.lua", function () print("Successfully downloaded UPL. Press F9 twice.") end) end, 3) 
			return
		end
	end
	
	UPL:AddToMenu(Menu)
	UPL:AddSpell(_Q, { speed = 1350, delay = 0.25, range = 1175, width = 120, collision = true, aoe = false, type = "linear" })
	UPL:AddSpell(_E, { speed = 1350, delay = 0.25, range = 1280, width = 160, collision = false, aoe = true, type = "linear" })
end

function PrintMsg(msg)
	PrintChat("<font color=\"#288c62\"><b>[</b></font><font color=\"#28b779\"><b>Doctor KogMaw</b></font><font color=\"#288c62\"><b>]</b></font> <font color=\"#42dd9a\">"..msg.."</font>")
end

function DrawMenu()
	Menu = scriptConfig("Doctor KogMaw", "Menu")

	Menu:addSubMenu("Key Settings", "KeySettings")
		Menu.KeySettings:addParam("comboON", "Combo", SCRIPT_PARAM_ONKEYDOWN, false, string.byte(" "))
		Menu.KeySettings:addParam("LastHitON", "Last Hit", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("X"))
		Menu.KeySettings:addParam("WaveClearON", "Wave Clear", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
		Menu.KeySettings:addParam("JungleClearON", "Jungle Clear", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
	
	Menu:addSubMenu("Combo", "Combo")
		Menu.Combo:addParam("UseQCombo", "Use Caustic Spittle (Q) in combo", SCRIPT_PARAM_ONOFF, true)
		Menu.Combo:addParam("ManaQCombo", "Min mana after Q (%)", SCRIPT_PARAM_SLICE, 10, 0, 100, 0)
		Menu.Combo:addParam("SpaceCombo1","", 5, "")
		Menu.Combo:addParam("UseWCombo", "Use Bio-Arcane Barrage (W) in combo", SCRIPT_PARAM_ONOFF, true)
		Menu.Combo:addParam("ManaWCombo", "Min mana after W (%)", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
		Menu.Combo:addParam("SpaceCombo2","", 5, "")
		Menu.Combo:addParam("UseECombo", "Use Void Ooze (E) in combo", SCRIPT_PARAM_ONOFF, true)
		Menu.Combo:addParam("ManaECombo", "Min mana after E (%)", SCRIPT_PARAM_SLICE, 10, 0, 100, 0)
		Menu.Combo:addParam("SpaceCombo3","", 5, "")
		Menu.Combo:addParam("UseRCombo", "Use Living Artillery (R) in combo", SCRIPT_PARAM_ONOFF, true)
		Menu.Combo:addParam("ManaRCombo", "Min mana after R (%)", SCRIPT_PARAM_SLICE, 20, 0, 100, 0)
		
	Menu:addSubMenu("Items", "ItemsSettings")
		Menu.ItemsSettings:addParam("SmiteChampON", "Use smite on champion", SCRIPT_PARAM_ONOFF, true)
		Menu.ItemsSettings:addParam("OffensiveItemsON", "Use Offensive Items in combo mode", SCRIPT_PARAM_ONOFF, true)
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
	
	Menu:addSubMenu("Wave / Jungle Clear", "Clear")
		Menu.Clear:addParam("UseWClear", "Use Bio-Arcane Barrage (W) in Clear", SCRIPT_PARAM_ONOFF, true)
		Menu.Clear:addParam("ManaWClear", "Min mana after W (%)", SCRIPT_PARAM_SLICE, 30, 0, 100, 0)
		Menu.Clear:addParam("SpaceClear","", 5, "")
		Menu.Clear:addParam("UseEClear", "Use Void Ooze (E) in Clear", SCRIPT_PARAM_ONOFF, true)
		Menu.Clear:addParam("ManaEClear", "Min mana after E (%)", SCRIPT_PARAM_SLICE, 40, 0, 100, 0)
	
	Menu:addSubMenu("Humanizer", "HumanizerSettings")
		Menu.HumanizerSettings:addParam("ComboHumanizerON", "Humanizer for Combo", SCRIPT_PARAM_ONOFF, true)
		Menu.HumanizerSettings:addParam("ComboHumanizerMinValue", "Min Value", SCRIPT_PARAM_SLICE, 100, 0, 1000, 0)
		Menu.HumanizerSettings:addParam("ComboHumanizerMaxValue", "Max Value", SCRIPT_PARAM_SLICE, 200, 0, 1000, 0)
			Menu.HumanizerSettings:setCallback("ComboHumanizerMinValue", function (value) if value < Menu.HumanizerSettings.ComboHumanizerMinValue then Menu.HumanizerSettings.ComboHumanizerMaxValue = Menu.HumanizerSettings.ComboHumanizerMinValue end end)
			Menu.HumanizerSettings:setCallback("ComboHumanizerMaxValue", function (value) if value > Menu.HumanizerSettings.ComboHumanizerMaxValue then Menu.HumanizerSettings.ComboHumanizerMinValue = Menu.HumanizerSettings.ComboHumanizerMaxValue end end)
		Menu.HumanizerSettings:addParam("SpaceHumanizer11","____________________________________________", 5, "")
		Menu.HumanizerSettings:addParam("SpaceHumanizer12","", 5, "")
		Menu.HumanizerSettings:addParam("SmiteHumanizerON", "Humanizer for Smite", SCRIPT_PARAM_ONOFF, true)
		Menu.HumanizerSettings:addParam("SmiteHumanizerMinValue", "Min Value", SCRIPT_PARAM_SLICE, 100, 0, 1000, 0)
		Menu.HumanizerSettings:addParam("SmiteHumanizerMaxValue", "Max Value", SCRIPT_PARAM_SLICE, 200, 0, 1000, 0)
			Menu.HumanizerSettings:setCallback("SmiteHumanizerMinValue", function (value) if value < Menu.HumanizerSettings.SmiteHumanizerMinValue then Menu.HumanizerSettings.SmiteHumanizerMaxValue = Menu.HumanizerSettings.SmiteHumanizerMinValue end end)
			Menu.HumanizerSettings:setCallback("SmiteHumanizerMaxValue", function (value) if value > Menu.HumanizerSettings.SmiteHumanizerMaxValue then Menu.HumanizerSettings.SmiteHumanizerMinValue = Menu.HumanizerSettings.SmiteHumanizerMaxValue end end)
		Menu.HumanizerSettings:addParam("SpaceHumanizer21","____________________________________________", 5, "")
		Menu.HumanizerSettings:addParam("SpaceHumanizer22","", 5, "")
		Menu.HumanizerSettings:addParam("QSSHumanizerON", "Humanizer for QSS", SCRIPT_PARAM_ONOFF, true)
		Menu.HumanizerSettings:addParam("QSSHumanizerMinValue", "Min Value", SCRIPT_PARAM_SLICE, 100, 0, 1000, 0)
		Menu.HumanizerSettings:addParam("QSSHumanizerMaxValue", "Max Value", SCRIPT_PARAM_SLICE, 200, 0, 1000, 0)
			Menu.HumanizerSettings:setCallback("QSSHumanizerMinValue", function (value) if value < Menu.HumanizerSettings.QSSHumanizerMinValue then Menu.HumanizerSettings.QSSHumanizerMaxValue = Menu.HumanizerSettings.QSSHumanizerMinValue end end)
			Menu.HumanizerSettings:setCallback("QSSHumanizerMaxValue", function (value) if value > Menu.HumanizerSettings.QSSHumanizerMaxValue then Menu.HumanizerSettings.QSSHumanizerMinValue = Menu.HumanizerSettings.QSSHumanizerMaxValue end end)
		
	Menu:addSubMenu("Draw", "DrawSettings")
		Menu.DrawSettings:addParam("DrawAaON", "Draw AA range", SCRIPT_PARAM_ONOFF, true)
		Menu.DrawSettings:addParam("DrawTargetON", "Draw current target", SCRIPT_PARAM_ONOFF, true)
		Menu.DrawSettings:addParam("LastHitDrawON", "Draw Last Hit Helper", SCRIPT_PARAM_ONOFF, true)

	Menu:addSubMenu("Miscellaneous", "MiscSettings")
		Menu.MiscSettings:addParam("UseSmite", "Smite Dragon, Rift Herald and Baron", SCRIPT_PARAM_ONOFF, true)
		Menu.MiscSettings:addParam("SetSkin", "Select Skin", SCRIPT_PARAM_LIST, 7, {"Classic", "Caterpillar", "Sonoran", "Monarch", "Reindeer", "Lion Dance", "Deep Sea", "Jurassic", "Battlecast"})
			Menu.MiscSettings:setCallback("SetSkin", function (value) SetSkin(myHero, Menu.MiscSettings.SetSkin - 1) end)
	
	ts = TargetSelector(TARGET_LOW_HP_PRIORITY, 1000, DAMAGE_PHYSICAL, true)
	ts.name = "Target Select"
	Menu:addTS(ts)
	
	Menu:addParam("space2", "", 5, "")
	Menu:addParam("signature0", "               Doctor KogMaw v"..version, 5, "")
	Menu:addParam("signature1", "                Let the Doctor carry", 5, "")
	Menu:addParam("signature2", "                    by DrPhoenix    ", 5, "")
end

function OnTick()
	HumanizerTime()
	jungleMinions:update()
	CheckJungle()
	CheckDeath()
	Combo()
	LastHit()
	WaveClear()
	JungleClear()
	OffensiveItems()
	target = GetCustomTarget()
	ts:update()
	UPL:AddSpell(_R, { speed = 1550, delay = 0.25, range = GetRRange(), width = 100, collision = false, aoe = true, type = "circular" })
end

function GetCustomTarget()
 	ts:update()
	return ts.target
end

function CheckJungle()
	if Menu.MiscSettings.UseSmite then
		for i, jungle in pairs(jungleMinions.objects) do
			if jungle ~= nil then
				SmiteMonster(jungle)
			end
		end
	end	 
end

function OnDraw()
	if Menu.DrawSettings.DrawAaON and not myHero.dead then
		DrawCircle3D(myHero.x, myHero.y, myHero.z, myRange, 1, RGB(255,100,100), 75)
	end
	if Menu.DrawSettings.DrawTargetON and not myHero.dead and target ~= nil and target.valid and not target.dead and target.bTargetable and target.visible then
		DrawCircle3D(target.x, target.y, target.z, 75, 3, RGB(178,0,255), 4)
	end
	
	if Menu.DrawSettings.LastHitDrawON then
		for _, minion in pairs(minionManager(MINION_ENEMY, 1000, myHero, MINION_SORT_MINHEALTH_DEC).objects) do
			if minion.health < myHero.totalDamage then
				DrawCircle3D(minion.x, minion.y, minion.z, 43, 3, ARGB(255,3,229,0), 100)
				DrawCircle3D(minion.x, minion.y, minion.z, 25, 3, ARGB(255,3,229,0), 100)
				DrawLine3D(minion.x + 30, minion.y, minion.z + 30, minion.x - 30, minion.y, minion.z - 30, 3, ARGB(255,3,229,0))
				DrawLine3D(minion.x + 30, minion.y, minion.z - 30, minion.x - 30, minion.y, minion.z + 30, 3, ARGB(255,3,229,0))
			elseif minion.health < myHero.totalDamage * 2 then
				DrawCircle3D(minion.x, minion.y, minion.z, 43, 3, ARGB(255,229,145,0), 100)
				DrawCircle3D(minion.x, minion.y, minion.z, 25, 3, ARGB(255,229,145,0), 100)
				DrawLine3D(minion.x + 30, minion.y, minion.z + 30, minion.x - 30, minion.y, minion.z - 30, 3, ARGB(255,229,145,0))
				DrawLine3D(minion.x + 30, minion.y, minion.z - 30, minion.x - 30, minion.y, minion.z + 30, 3, ARGB(255,229,145,0))
			elseif minion.health < myHero.totalDamage * 3 then
				DrawCircle3D(minion.x, minion.y, minion.z, 43, 3, ARGB(255,229,0,0), 100)
				DrawCircle3D(minion.x, minion.y, minion.z, 25, 3, ARGB(255,229,0,0), 100)
				DrawLine3D(minion.x + 30, minion.y, minion.z + 30, minion.x - 30, minion.y, minion.z - 30, 3, ARGB(255,229,0,0))
				DrawLine3D(minion.x + 30, minion.y, minion.z - 30, minion.x - 30, minion.y, minion.z + 30, 3, ARGB(255,229,0,0))
			end
		end
	end
end

function HumanizerTime()
	if Menu.HumanizerSettings.ComboHumanizerON == true then
		ComboHumanizer = math.random(Menu.HumanizerSettings.ComboHumanizerMinValue, Menu.HumanizerSettings.ComboHumanizerMaxValue)/1000
	else
		ComboHumanizer = 0
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
			DelayAction(function() CastSpell(SmitePos, obj) end, SmiteHumanizer)
		end
	end
end

function OnApplyBuff(unit, source, buff)
	if unit == myHero and buff.name == "KogMawIcathianSurprise" then
		passive = true
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

function CheckDeath()
	if passive == true and not myHero.dead and target ~= nil and target.valid and not target.dead and target.bTargetable and target.visible then
		myHero:MoveTo(target.x,target.z)
	else
		passive = false
	end
end

function OnProcessAttack(unit, spell)
	if unit.isMe and spell and unit.valid and (spell.name:lower():find("attack")) then
		lastAttack = GetTickCount() - GetLatency() * 0.5
		lastWindUpTime = spell.windUpTime + GetLatency()/2000
		lastAttackCD = spell.animationTime
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

function GetWRange()
	if myHero:GetSpellData(_W).level == 0 then
		wRange = myRange
	elseif myHero:GetSpellData(_W).level == 1 then
		wRange = 590
	elseif myHero:GetSpellData(_W).level == 2 then
		wRange = 620
	elseif myHero:GetSpellData(_W).level == 3 then
		wRange = 650
	elseif myHero:GetSpellData(_W).level == 4 then
		wRange = 680
	elseif myHero:GetSpellData(_W).level == 5 then
		wRange = 710
	end
	return wRange
end

function GetEMana()
	if myHero:GetSpellData(_E).level == 0 then
		eMana = 0
	elseif myHero:GetSpellData(_E).level == 1 then
		eMana = 80
	elseif myHero:GetSpellData(_E).level == 2 then
		eMana = 90
	elseif myHero:GetSpellData(_E).level == 3 then
		eMana = 100
	elseif myHero:GetSpellData(_E).level == 4 then
		eMana = 110
	elseif myHero:GetSpellData(_E).level == 5 then
		eMana = 120
	end
	return eMana
end

function GetRRange()
	if myHero:GetSpellData(_R).level == 0 then
		rRange = myRange
	elseif myHero:GetSpellData(_R).level == 1 then
		rRange = 1200
	elseif myHero:GetSpellData(_R).level == 2 then
		rRange = 1500
	elseif myHero:GetSpellData(_R).level == 3 then
		rRange = 1800
	end
	return rRange
end

function OnUpdateBuff(source, buff, stacks)
	if source == myHero and buff.name == "kogmawlivingartillerycost" then
		rManaCost = 50 * (stacks + 1)
	end
end

function OnRemoveBuff(source, buff)
	if source == myHero and buff.name == "kogmawlivingartillerycost" then
		rManaCost = 50
	end
end

function Combo()
	if Menu.KeySettings.comboON then
		GetWRange()
		GetRRange()
		
		if target ~= nil and target.valid and not target.dead and target.bTargetable and target.visible then
			if ComboCanAuto() then
				if GetDistance(target, myHero) < GetRRange() and myHero:CanUseSpell(_R) == READY and Menu.Combo.UseRCombo and myHero.mana - rManaCost > Menu.Combo.ManaRCombo * myHero.maxMana / 100 then
					CastPosition, HitChance, HeroPosition = UPL:Predict(_R, myHero, target)
					if CastPosition and HitChance > 0 then
						CastSpell(_R, CastPosition.x, CastPosition.z)
					end
					myHero:Attack(target)
				end
				
				if GetDistance(target, myHero) < 1280 and myHero:CanUseSpell(_E) == READY and Menu.Combo.UseECombo and myHero.mana - GetEMana() > Menu.Combo.ManaECombo * myHero.maxMana / 100 then
					CastPosition, HitChance, HeroPosition = UPL:Predict(_E, myHero, target)
					if CastPosition and HitChance > 0 then
						CastSpell(_E, CastPosition.x, CastPosition.z)
					end
					myHero:Attack(target)
				end
				
				if GetDistance(target, myHero) < 1175 and myHero:CanUseSpell(_Q) == READY and Menu.Combo.UseQCombo and myHero.mana - 40 > Menu.Combo.ManaQCombo * myHero.maxMana / 100 then
					CastPosition, HitChance, HeroPosition = UPL:Predict(_Q, myHero, target)
					if CastPosition and HitChance > 0 then
						CastSpell(_Q, CastPosition.x, CastPosition.z)
					end
					myHero:Attack(target)
				end
				
				if GetDistance(target, myHero) < GetWRange() then
					if myHero:CanUseSpell(_W) == READY and Menu.Combo.UseWCombo and myHero.mana - 40 > Menu.Combo.ManaWCombo * myHero.maxMana / 100 then
						CastSpell(_W)
						myHero:Attack(target)
					else
						myHero:Attack(target)
					end
				end
			else
				myHero:MoveTo(mousePos.x,mousePos.z)
			end
		else
			myHero:MoveTo(mousePos.x,mousePos.z)
		end
	end
end

function OffensiveItems()
	if Menu.KeySettings.comboON and target ~= nil and target.valid and not target.dead and target.bTargetable and target.visible then
		for _, item in pairs(OffensiveItemsList) do
			item.slot = GetInventorySlotItem(item.id)
			if item.slot ~= nil then
				if item.id == 3715 or item.id == 3706 or item.id == 1416 or item.id == 1419 then
					if GetDistance(target, myHero) < item.range and Menu.ItemsSettings.SmiteChampON then
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

function LastHit()
	if Menu.KeySettings.LastHitON then
		if next(minionManager(MINION_ENEMY, 1500, myHero, MINION_SORT_HEALTH_ASC).objects) == nil then
			myHero:MoveTo(mousePos.x,mousePos.z)
		end
		
		for i, minion in pairs(minionManager(MINION_ENEMY, 2500, myHero, MINION_SORT_HEALTH_ASC).objects) do
			if i == 1 then
				if ComboCanAuto() then
					if minion.health < myHero.totalDamage then
						myHero:Attack(minion)
						break
					else
						myHero:MoveTo(mousePos.x,mousePos.z)
					end
				else
					myHero:MoveTo(mousePos.x,mousePos.z)
				end
			else
				myHero:MoveTo(mousePos.x,mousePos.z)
			end
		end
		
		if not ComboCanAuto() then
			myHero:MoveTo(mousePos.x,mousePos.z)
		end
	end
end

function WaveClear()
	if Menu.KeySettings.WaveClearON then
		GetWRange()
		
		if next(minionManager(MINION_ENEMY, GetWRange(), myHero, MINION_SORT_HEALTH_ASC).objects) == nil then
			myHero:MoveTo(mousePos.x,mousePos.z)
		end
		
		for i, minion in pairs(minionManager(MINION_ENEMY, GetWRange(), myHero, MINION_SORT_HEALTH_ASC).objects) do
			if i == 1 then
				if ComboCanAuto() then
					if GetDistance(minion, myHero) < GetWRange() and myHero:CanUseSpell(_E) == READY and Menu.Clear.UseEClear and myHero.mana - GetEMana() > Menu.Clear.ManaEClear * myHero.maxMana / 100 then
						CastPosition, HitChance, HeroPosition = UPL:Predict(_E, myHero, minion)
						if CastPosition and HitChance > 0 then
							CastSpell(_E, CastPosition.x, CastPosition.z)
							myHero:Attack(minion)
							break
						end
						myHero:Attack(minion)
						break
					end
					
					if GetDistance(minion, myHero) < GetWRange() then
						if myHero:CanUseSpell(_W) == READY and Menu.Clear.UseWClear and myHero.mana - 40 > Menu.Clear.ManaWClear * myHero.maxMana / 100 then
							CastSpell(_W)
							myHero:Attack(minion)
							break
						else
							myHero:Attack(minion)
							break
						end
					end
				else
					myHero:MoveTo(mousePos.x,mousePos.z)
				end
			else
				myHero:MoveTo(mousePos.x,mousePos.z)
			end
		end
	end
end

function JungleClear()
	if Menu.KeySettings.JungleClearON then
		GetWRange()
		
		if next(minionManager(MINION_JUNGLE, GetWRange(), myHero, MINION_SORT_HEALTH_DEC).objects) == nil then
			myHero:MoveTo(mousePos.x,mousePos.z)
		end
		
		for i, minion in pairs(minionManager(MINION_JUNGLE, GetWRange(), myHero, MINION_SORT_HEALTH_DEC).objects) do
			if i == 1 and minion.charName ~= "SRU_CampRespawnMarker" then
				if ComboCanAuto() then
					if GetDistance(minion, myHero) < 1280 and myHero:CanUseSpell(_E) == READY and Menu.Clear.UseEClear and myHero.mana - GetEMana() > Menu.Clear.ManaEClear * myHero.maxMana / 100 then
						CastPosition, HitChance, HeroPosition = UPL:Predict(_E, myHero, minion)
						if CastPosition and HitChance > 0 then
							CastSpell(_E, CastPosition.x, CastPosition.z)
							myHero:Attack(minion)
							break
						end
						myHero:Attack(minion)
						break
					end
					
					if GetDistance(minion, myHero) < GetWRange() then
						if myHero:CanUseSpell(_W) == READY and Menu.Clear.UseWClear and myHero.mana - 40 > Menu.Clear.ManaWClear * myHero.maxMana / 100 then
							CastSpell(_W)
							myHero:Attack(minion)
							break
						else
							myHero:Attack(minion)
							break
						end
					end
				else
					myHero:MoveTo(mousePos.x,mousePos.z)
				end
			else
				myHero:MoveTo(mousePos.x,mousePos.z)
			end
		end
		
		if not ComboCanAuto() then
			myHero:MoveTo(mousePos.x,mousePos.z)
		end
	end
end

function Update()
    local UpdateHost = "www.s1mplescripts.de"
    local ServerPath = "/DrPhoenix/BoL/Scripts/DoctorKogMaw/"
    local ServerFileName = "DoctorKogMaw.lua"
    local ServerVersionFileName = "DoctorKogMaw.version"
 
    DL = Download()
    local ServerVersionDATA = GetWebResult("s1mplescripts.de" , ServerPath..ServerVersionFileName)
    if ServerVersionDATA then
        local ServerVersion = tonumber(ServerVersionDATA)
        if ServerVersion then
            if ServerVersion > tonumber(version) then
                PrintMsg("Updating, don't press F9")
                DL:newDL(UpdateHost, ServerPath..ServerFileName, ServerFileName, SCRIPT_PATH, function ()
                    PrintMsg("Doctor KogMaw updated, please reload")
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