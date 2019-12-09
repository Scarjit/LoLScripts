--[[

Script by spyk for Anivia.

BaguetteAnivia.lua

Github link : https://github.com/spyk1/BoL/blob/master/BaguetteAnivia/BaguetteAnivia.lua

Forum Thread : http://forum.botoflegends.com/topic/87964-beta-baguette-anivia/

]]--

local charNames = {
    
    ['Anivia'] = true,
    ['anivia'] = true
}

local buffs = {
    ["JudicatorIntervention"] = true,
    ["UndyingRage"] = true,
    ["ZacRebirthReady"] = true,
    ["AatroxPassiveDeath"] = true,
    ["FerociousHowl"] = true,
    ["VladimirSanguinePool"] = true,
    ["ChronoRevive"] = true,
    ["ChronoShift"] = true,
    ["KarthusDeathDefiedBuff"] = true,
    ["zhonyasringshield"] = true,
    ["lissandrarself"] = true,
    ["bansheesveil"] = true,
    ["SivirE"] = true,
    ["NocturneW"] = true,
    ["kindredrnodeathbuff"] = true
}

if not charNames[myHero.charName] then return end

function EnvoiMessage(msg)

	PrintChat("<font color=\"#e74c3c\"><b>[BaguetteAnivia]</b></font> <font color=\"#ffffff\">" .. msg .. "</font>")
end

function CurrentTimeInMillis()

	return (os.clock() * 1000)
end

local ts
local QMissile = nil
local RMissile = nil
local Qdmg, Edmg, Rdmg, iDmg, totalDamage, health, mana, maxHealth, maxMana = 0 , 0, 0, 0, 0, 0, 0, 0, 0, 0
local TextList = {"Ignite = Kill", "Q = Kill", "DoubleQ = Kill", "Q + Ignite = Kill", "DoubleQ + Ignite = Kill", "Q + FrozenE = Kill", "DoubleQ + FrozenE = Kill", "Q + FrozenE + Ignite = Kill", "DoubleQ + FrozenE + Ignite = Kill", "Q + FrozenE + R for 1s = Kill", "DoubleQ + FrozenE + R for 1s = Kill", "DoubleQ + FrozenE + R for 3s = Kill", "Q + FrozenE + R + Ignite = Kill", "DoubleQ + FrozenE + R + Ignite = Kill", "DoubleQ + FrozenE + R for 3s + Ignite = Kill", "Not Killable"}
local KillText = {}
local mods = "None"
local damageQ = 30 * myHero:GetSpellData(_Q).level + 30 + .5 * myHero.ap
local damageE = 30 * myHero:GetSpellData(_E).level + 25 + myHero.ap
local damageR = 40 * myHero:GetSpellData(_R).level + 40 + .25 * myHero.ap
local lastPotion = 0
local ActualPotTime = 15
local ActualPotName = "None"
local ActualPotData = "None"
local lastFrostQuennCast = 0
local lastSeraphin = 0
local lastQss = 0
local lastElixir = 0
local lastTP = 0
local ActualTPTime = 0
local upoeuf = 1
local startTime = 0

--- Starting AutoUpdate
local version = "0.691"
local author = "spyk"
local SCRIPT_NAME = "BaguetteAnivia"
local AUTOUPDATE = true
local UPDATE_HOST = "raw.githubusercontent.com"
local UPDATE_PATH = "/spyk1/BoL/master/BaguetteAnivia/BaguetteAnivia.lua".."?rand="..math.random(1,10000)
local UPDATE_FILE_PATH = SCRIPT_PATH..GetCurrentEnv().FILE_NAME
local UPDATE_URL = "https://"..UPDATE_HOST..UPDATE_PATH
local whatsnew = 0

if AUTOUPDATE then
	local ServerData = GetWebResult(UPDATE_HOST, "/spyk1/BoL/master/BaguetteAnivia/BaguetteAnivia.version")
	if ServerData then
		ServerVersion = type(tonumber(ServerData)) == "number" and tonumber(ServerData) or nil
		if ServerVersion then
			if tonumber(version) < ServerVersion then
				EnvoiMessage("New version available "..ServerVersion)
				EnvoiMessage(">>Updating, please don't press F9<<")
				DelayAction(function() DownloadFile(UPDATE_URL, UPDATE_FILE_PATH, function () EnvoiMessage("Successfully updated. ("..version.." => "..ServerVersion.."), press F9 twice to load the updated version.") end) end, 3)
				whatsnew = 1
			else
				DelayAction(function() EnvoiMessage("Hello, "..GetUser()..". You got the latest version! :) ("..ServerVersion..")") end, 3)
			end
		end
		else
			EnvoiMessage("Error downloading version info")
	end
end
 --- End Of AutoUpdate

function OnLoad()
	--
	print("<font color=\"#ffffff\">Loading</font><font color=\"#e74c3c\"><b> [BaguetteAnivia]</b></font> <font color=\"#ffffff\">by spyk</font>")
	--
	if whatsnew == 1 then
		DelayAction(function() EnvoiMessage("What's new : Fixed summoner issues.")end, 0)
		whatsnew = 0
	end
	--
	if myHero:GetSpellData(SUMMONER_1).name:find("SummonerDot") then Ignite = SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("SummonerDot") then Ignite = SUMMONER_2 end
	if myHero:GetSpellData(SUMMONER_1).name:find("SummonerTeleport") then Teleport = SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("SummonerTeleport") then Teleport = SUMMONER_2 end
	--
	Param = scriptConfig("[Baguette] Anivia", "BaguetteAniva")
	--
	Param:addParam("n5", "Current Mode :", SCRIPT_PARAM_LIST, 1, {" None", " Combo", " Harass", " LaneClear", " WaveClear", " JungleClear"})
		Param:permaShow("n5")
	--
	Param:addSubMenu("SBTW!","Combo")
		Param.Combo:addParam("comboKey", "Combo Key :", SCRIPT_PARAM_ONKEYDOWN, false, 32)
		Param.Combo:addParam("UseQ", "Use (Q) Spell in Combo?" , SCRIPT_PARAM_ONOFF, true )
		Param.Combo:addParam("UseE", "Use (E) Spell in Combo?" , SCRIPT_PARAM_ONOFF, true )
		Param.Combo:addParam("UseR", "Use (R) Spell in Combo?" , SCRIPT_PARAM_ONOFF, true )
	--
	Param:addSubMenu("Harass To Win!","Harass")
		Param.Harass:addParam("Harasskey", "Harass Key :", SCRIPT_PARAM_ONKEYDOWN, false, GetKey("C"))
		Param.Harass:addParam("manamanager", "Required Mana to Harass :", SCRIPT_PARAM_SLICE, 50, 0, 100)
		Param.Harass:addParam("UseQ", "Use (Q) Spell in Harass?" , SCRIPT_PARAM_ONOFF, true )
		Param.Harass:addParam("UseE", "Use (E) Spell in Harass?" , SCRIPT_PARAM_ONOFF, true )
		Param.Harass:addParam("UseR", "Use (R) Spell in Harass?" , SCRIPT_PARAM_ONOFF, true )
	--
	Param:addSubMenu("Clear To Win!","Clear")
		Param.Clear:addSubMenu("WaveClear to WIN!", "WaveClear")
			Param.Clear.WaveClear:addParam("waveclearkey", "WaveClear Key :",SCRIPT_PARAM_ONKEYDOWN, false, GetKey("V"))
			Param.Clear.WaveClear:addParam("manamanager", "Required Mana to WaveClear :", SCRIPT_PARAM_SLICE, 50, 0, 100)
			Param.Clear.WaveClear:addParam("UseQ", "Use (Q) Spell in WaveClear?" , SCRIPT_PARAM_ONOFF, true )
			Param.Clear.WaveClear:addParam("UseE", "Use (E) Spell in WaveClear?" , SCRIPT_PARAM_ONOFF, true )
			Param.Clear.WaveClear:addParam("UseR", "Use (R) Spell in WaveClear?" , SCRIPT_PARAM_ONOFF, true )
		--
		Param.Clear:addSubMenu("LaneClear to Farm.", "LaneClear")
			Param.Clear.LaneClear:addParam("laneclearkey", "LaneClear Key :",SCRIPT_PARAM_ONKEYDOWN, false, GetKey("X"))
			Param.Clear.LaneClear:addParam("manamanager", "Required Mana to LaneClear :", SCRIPT_PARAM_SLICE, 50, 0, 100)
			Param.Clear.LaneClear:addParam("UseQ", "Use (Q) Spell in LaneClear?" , SCRIPT_PARAM_ONOFF, false )
			Param.Clear.LaneClear:addParam("UseE", "Use (E) Spell in LaneClear?", SCRIPT_PARAM_ONOFF, true)
			Param.Clear.LaneClear:addParam("UseR", "Use (R) Spell in LaneClear?" , SCRIPT_PARAM_ONOFF, true )
		--
		Param.Clear:addSubMenu("JungleClear", "JungleClear")
			Param.Clear.JungleClear:addParam("jungleclearkey", "JungleClear Key :", SCRIPT_PARAM_ONKEYDOWN, false, GetKey("V"))
			Param.Clear.JungleClear:addParam("manamanager", "Required Mana to JungleClear :", SCRIPT_PARAM_SLICE, 50, 0, 100)
			Param.Clear.JungleClear:addParam("UseQ", "Use (Q) Spell in JungleClear?" , SCRIPT_PARAM_ONOFF, true )
			Param.Clear.JungleClear:addParam("UseE", "Use (E) Spell in JungleClear?", SCRIPT_PARAM_ONOFF, true)
			Param.Clear.JungleClear:addParam("UseR", "Use (R) Spell in JungleClear?" , SCRIPT_PARAM_ONOFF, true )
	--
	Param:addSubMenu("KillSteal To Win!", "KillSteal")
		Param.KillSteal:addParam("KillStealON", "Enable KillSteal to Win?" , SCRIPT_PARAM_ONOFF, true)
		Param.KillSteal:addParam("UseQ", "Use (Q) Spell to KillSteal?", SCRIPT_PARAM_ONOFF, true)
		Param.KillSteal:addParam("UseE", "Use (E) Spell to KillSteal?", SCRIPT_PARAM_ONOFF, true)
		Param.KillSteal:addParam("UseR", "Use (R) Spell to KillSteal?", SCRIPT_PARAM_ONOFF, true)
		if Ignite then Param.KillSteal:addParam("UseIgnite", "Use (Ignite) Summoner Spell to KillSteal?", SCRIPT_PARAM_ONOFF, true) end
	--
	Param:addSubMenu("Miscellaneous because Swag!", "miscellaneous")
		--
		Param.miscellaneous:addSubMenu("Quick Silver Slash", "QuickSS")
			Param.miscellaneous.QuickSS:addParam("qsswithscript", "Use Qss with that Script?", SCRIPT_PARAM_ONOFF, true)
			Param.miscellaneous.QuickSS:addParam("qssoncc", "Use Qss whenever?", SCRIPT_PARAM_ONOFF, false)
			Param.miscellaneous.QuickSS:addParam("qssonlyincombo", "Use Qss on HardCC in ComboMode only", SCRIPT_PARAM_ONOFF, true)
			Param.miscellaneous.QuickSS:addParam("qssdelay", "Humanizer (ms) :", SCRIPT_PARAM_SLICE, 0, 0, 5000, 0)
		--
		Param.miscellaneous:addSubMenu("Seraph's Embrace", "BatonSeraphin")
			Param.miscellaneous.BatonSeraphin:addParam("seraphwithscript", "Use Seraph's Embrace with that Script?", SCRIPT_PARAM_ONOFF, true)
			Param.miscellaneous.BatonSeraphin:addParam("seraphxlife", "Use Seraph's at X > life?", SCRIPT_PARAM_SLICE, 20, 0, 100)
			Param.miscellaneous.BatonSeraphin:addParam("seraphcombo", "Use Only Seraph's in ComboMode?", SCRIPT_PARAM_ONOFF, true)
			Param.miscellaneous.BatonSeraphin:addParam("seraphdelay", "Humanizer (ms) :", SCRIPT_PARAM_SLICE, 0, 0, 5000, 0)
		--
		Param.miscellaneous:addSubMenu("Frost's Quenn Claim", "ItemSuppBleu")
			Param.miscellaneous.ItemSuppBleu:addParam("suppbleuwithscript", "Use Frost's Quenn with that Script?", SCRIPT_PARAM_ONOFF, true)
			Param.miscellaneous.ItemSuppBleu:addParam("suppbleuchase", "Use Frost's Quenn only on a chase?", SCRIPT_PARAM_ONOFF, false)
			Param.miscellaneous.ItemSuppBleu:addParam("suppbleucombo", "Use Frost's Quenn in ComboMode/Teamfight?", SCRIPT_PARAM_ONOFF, true)
		--
		Param.miscellaneous:addSubMenu("Exilir of Sorcery", "ElixirduSorcier")
			Param.miscellaneous.ElixirduSorcier:addParam("elixirwithscript", "Use Exilir of Sorcery with that script?", SCRIPT_PARAM_ONOFF, true)
			Param.miscellaneous.ElixirduSorcier:addParam("elixironlywithcombo", "Use Elixir Only in ComboMode?", SCRIPT_PARAM_ONOFF, true)
			Param.miscellaneous.ElixirduSorcier:addParam("elixirinfight", "Use Exilir of Sorcery in fight?", SCRIPT_PARAM_ONOFF, true)
		--
		Param.miscellaneous:addSubMenu("Potions and Flasks", "Pots")
			Param.miscellaneous.Pots:addParam("potswithscript", "Use potions with this script?", SCRIPT_PARAM_ONOFF, true)
			Param.miscellaneous.Pots:addParam("potatxhp", "At how many %hp", SCRIPT_PARAM_SLICE, 60, 0, 100)
			Param.miscellaneous.Pots:addParam("potonlywithcombo", "Use potions only in ComboMode?", SCRIPT_PARAM_ONOFF, true)
		--
				if VIP_USER then Param.miscellaneous:addSubMenu("Skin Changer", "Skin") end
			if VIP_USER then Param.miscellaneous.Skin:addParam("Enable", "Enable Skin Changer : ", SCRIPT_PARAM_ONOFF, false)
				Param.miscellaneous.Skin:setCallback("Enable", function (nV)
					if nV then
						SetSkin(myHero, Param.miscellaneous.Skin.skins -1)
					else
						SetSkin(myHero, -1)
					end
				end)
			end				
			if VIP_USER then Param.miscellaneous.Skin:addParam("skins", 'Which Skin :', SCRIPT_PARAM_LIST, 2,  {"Classic", "Team Spirit", "Bird of Prey", "Noxus Hunter", "Hextech", "Blackfrost", "Prehistoric"})
				Param.miscellaneous.Skin:setCallback("skins", function (nV)
					if nV then
						if Param.miscellaneous.Skin.Enable then
							SetSkin(myHero, Param.miscellaneous.Skin.skins -1)
						end
					end
				end)
			end
		--
		if VIP_USER then Param.miscellaneous:addSubMenu("Auto LVL Spell :", "LVL") end
			if VIP_USER then Param.miscellaneous.LVL:addParam("Enable", "Enable Auto Level Spell?", SCRIPT_PARAM_ONOFF, true) end
			if VIP_USER then Param.miscellaneous.LVL:addParam("Combo", "LVL Spell Order :", SCRIPT_PARAM_LIST, 2, {"Q > E > W > E (Max E)", "Q > E > E > W (Max E)"}) end
			if VIP_USER then Param.miscellaneous.LVL:setCallback("Combo", function (nV)
				if nV then
					AutoLvlSpellCombo()
				else 
					AutoLvlSpellCombo()
				end
			end)
			end
			if VIP_USER then Last_LevelSpell = 0 end
		--
		if VIP_USER then Param.miscellaneous:addSubMenu("Auto Buy Starter :", "Starter") end
			if VIP_USER then Param.miscellaneous.Starter:addParam("Doran", "Buy a doran blade :", SCRIPT_PARAM_ONOFF, true) end
			if VIP_USER then Param.miscellaneous.Starter:addParam("Pots", "Buy a potion :", SCRIPT_PARAM_ONOFF, true) end
			if VIP_USER then Param.miscellaneous.Starter:addParam("Trinket", "Buy a Green Trinket :", SCRIPT_PARAM_ONOFF, true) end
			if VIP_USER then Param.miscellaneous.Starter:addParam("n1blank", "", SCRIPT_PARAM_INFO, "") end
			if VIP_USER then Param.miscellaneous.Starter:addParam("TrinketBleu", "Buy a Blue Trinket at lvl.9 :", SCRIPT_PARAM_ONOFF, true) end
		--
		Param.miscellaneous:addSubMenu("GapCloser", "GapCloser")
			Param.miscellaneous.GapCloser:addParam("QGapClos", "Use GapCloser (Q)?", SCRIPT_PARAM_ONOFF, true)
			Param.miscellaneous.GapCloser:addParam("EGapClos", "Use (E) in GapCloser?", SCRIPT_PARAM_ONOFF, true)
			Param.miscellaneous.GapCloser:addParam("RGapClos", "Use (R) in GapCloser?", SCRIPT_PARAM_ONOFF, true)
			Param.miscellaneous.GapCloser:addParam("Special", "Enable special GapCloser (ZedR, etc..)?", SCRIPT_PARAM_ONOFF, true)

		Param.miscellaneous:addParam("QError", "Set (Q) Diameter on (Normally = 200) :", SCRIPT_PARAM_LIST, 2,{"200", "195", "190"})
		Param.miscellaneous:addParam("Wstop", "Use (W) Spell to stop spells during casting?", SCRIPT_PARAM_ONOFF, true)
		Param.miscellaneous:addParam("WdansR", "Cast (W) into (R)?", SCRIPT_PARAM_ONOFF, true)
		Param.miscellaneous:addParam("EGel", "Use (E) Spell only if enemy is frozen?", SCRIPT_PARAM_ONOFF, true)
		Param.miscellaneous:addParam("ManualR","Disable R if nothing in :", SCRIPT_PARAM_ONOFF , true)
		Param.miscellaneous:permaShow("ManualR")
		--
		Param:addSubMenu("Exploits", "exploits")
			if Teleport then Param.exploits:addSubMenu("Egg Teleport", "egg") end
			if Teleport then Param.exploits.egg:addParam("eggactive", "Enable Egg Teleport Exploit?", SCRIPT_PARAM_ONKEYTOGGLE, false, GetKey("N")) end
			if Teleport then Param.exploits.egg:addParam("eggatxhp", "At how many %HP it will cast TP?", SCRIPT_PARAM_SLICE, 25, 0, 100) end
			if Teleport then Param.exploits.egg:permaShow("eggactive") end
			if Teleport then Param.exploits.egg:addParam("n0", "", SCRIPT_PARAM_INFO,"") end
			if Teleport then Param.exploits.egg:addParam("n1", "Carefull, it's an bug you can be banned,", SCRIPT_PARAM_INFO,"") end
			if Teleport then Param.exploits.egg:addParam("n2", "if you use it too many times in the same game.", SCRIPT_PARAM_INFO,"") end
			--
			Param.exploits:addParam("EVayne", "Enable E Vayne Wall to stun casting?", SCRIPT_PARAM_ONOFF, false)
			Param.exploits:addParam("RSion", "Enable R Sion block with wall?", SCRIPT_PARAM_ONOFF, false)
			--
	Param:addSubMenu("Drawing", "drawing")
		Param.drawing:addParam("disablealldrawings","Disable all draws?", SCRIPT_PARAM_ONOFF, false)
		Param.drawing:addParam("tText", "Draw Current Target Text?", SCRIPT_PARAM_ONOFF, true)
		Param.drawing:addParam("drawKillable", "Draw Killable Text?", SCRIPT_PARAM_ONOFF, true)
		Param.drawing:addParam("BarH", "Draw Damages on Health Bar?", SCRIPT_PARAM_ONOFF, true)
		Param.drawing:addParam("hitbox", "Draw HitBox?", SCRIPT_PARAM_ONOFF, true)
		--
		Param.drawing:addSubMenu("Charactere Draws","spell")
			Param.drawing.spell:addParam("Qdraw","Display (Q) Spell draw?", SCRIPT_PARAM_ONOFF, true)
			Param.drawing.spell:addParam("Qtravel", "Draw Q travelling?", SCRIPT_PARAM_ONOFF, true)
			Param.drawing.spell:addParam("Wdraw","Display (W) Spell draw?", SCRIPT_PARAM_ONOFF, true)
			Param.drawing.spell:addParam("Edraw","Display (E) Spell draw?", SCRIPT_PARAM_ONOFF, true)
			Param.drawing.spell:addParam("Rdraw","Display (R) Spell draw?", SCRIPT_PARAM_ONOFF, true)
			Param.drawing.spell:addParam("AAdraw", "Display Auto Attack draw?", SCRIPT_PARAM_ONOFF, true)
			Param.drawing.spell:addParam("EggTimer", "Display EggTimer?", SCRIPT_PARAM_ONOFF, true)
		--
		Param.drawing:addSubMenu("About AutoWall", "wallmenu")
			Param.drawing.wallmenu:addParam("active", "WallsCasts is Active?", SCRIPT_PARAM_ONKEYTOGGLE, false, GetKey("G"))
			Param.drawing.wallmenu:permaShow("active")
			Param.drawing.wallmenu:addParam("radius", "Ajust precision of Circle Diameter : ", SCRIPT_PARAM_SLICE, 25, 0, 200, 0)
			Param.drawing.wallmenu:permaShow("radius")
	--end
	Param:addSubMenu("", "nil")
	--
	Param:addSubMenu("OrbWalker", "orbwalker")
		Param.orbwalker:addParam("n1", "OrbWalker :", SCRIPT_PARAM_LIST, 1, {"SxOrbWalk","BigFat OrbWalker", "Nebelwolfi's Orb Walker"})
		Param.orbwalker:addParam("n2", "If you want to change OrbWalker,", SCRIPT_PARAM_INFO, "")
		Param.orbwalker:addParam("n3", "Then, change it and press double F9.", SCRIPT_PARAM_INFO, "")
		Param.orbwalker:addParam("n4", "", SCRIPT_PARAM_INFO, "")
		Param.orbwalker:addParam("n5", "SAC:R is automaticly loaded(enable in BoLStudio)", SCRIPT_PARAM_INFO, "")
	--
	Param:addSubMenu("", "nil")
	
	Param:addSubMenu("Prediction", "prediction")
		Param.prediction:addParam("n1", "Prediction :", SCRIPT_PARAM_LIST, 1, {"VPrediction", "HPrediction", "SPrediction"})
		Param.prediction:addParam("n2", "If you want to change Prediction,", SCRIPT_PARAM_INFO, "")
		Param.prediction:addParam("n3", "Then, change it and press double F9.", SCRIPT_PARAM_INFO, "")
		Param.prediction:addParam("nil", "", SCRIPT_PARAM_INFO, "")
		Param.prediction:addParam("n4", "Basicly, the best way is VPrediction.", SCRIPT_PARAM_INFO, "")
		Param.prediction:addParam("n5", "Only if you like another prediction,", SCRIPT_PARAM_INFO, "")
		Param.prediction:addParam("n6", "then, I agree Keepo", SCRIPT_PARAM_INFO, "")
	
	Param:addSubMenu("", "nil")
	--
	Param:addParam("n4", "Baguette Anivia | Version", SCRIPT_PARAM_INFO, ""..version.."")
	Param:permaShow("n4")

	CustomLoad()

end

function OnUnload()
	EnvoiMessage("Unloaded.")
	EnvoiMessage("There is no bird anymore between us... Ciao!")
	if Param.miscellaneous.Skin.Enable then
		SetSkin(myHero, -1)
	end
end

function CustomLoad()
	local combostatus = 0
	local harasstatus = 0
	local waveclearstatus = 0
	local lanecleartatus = 0
	local jungleclearstatus = 0
	local showLocationsInRange = 0
	local showClose = true
	local showCloseRange = 0
	local drawWallSpots = true
	local MinionNumber = 0

	LoadSpikeLib()

	if VIP_USER then
		AutoLvlSpellCombo()
	end

	DelayAction(function()AutoBuy()end, 3)

	PredictionOrbWalkSwitch()
	Skills()
	GenerateTables()
	enemyMinions = minionManager(MINION_ENEMY, 700, myHero, MINION_SORT_HEALTH_ASC)
	jungleMinions = minionManager(MINION_JUNGLE, 700, myHero, MINION_SORT_MAXHEALTH_DEC)
	ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, 1000, DAMAGE_MAGIC)
	ts.name = "Anivia"
	Param:addTS(ts)
	PriorityOnLoad()

	if Param.miscellaneous.Skin.Enable then
		SetSkin(myHero, Param.miscellaneous.Skin.skins -1)
	end

 end

function PredictionOrbWalkSwitch()
	if Param.prediction.n1 == 1 then
		EnvoiMessage("VPrediction loading..")
		LoadVPred()
	elseif Param.prediction.n1 == 2 then
		EnvoiMessage("HPrediction loading..")
		LoadHPred()
	elseif Param.prediction.n1 == 3 then
		EnvoiMessage("SPrediction loading..")
		LoadSPred()
	else
		EnvoiMessage("No prediction loaded.")
	end

	if Param.prediction.n1 == 1 then Param.Combo:addParam("HitChance", "Set (Q) HitChance" , SCRIPT_PARAM_SLICE, 2, 1, 5) end
	if Param.prediction.n1 == 2 then Param.Combo:addParam("HitChance", "Set (Q) HitChance" , SCRIPT_PARAM_SLICE, 0, 0, 3) end
	if Param.prediction.n1 == 3 then Param.Combo:addParam("HitChance", "Set (Q) HitChance" , SCRIPT_PARAM_SLICE, 1, 0, 3) end

	if Param.prediction.n1 == 1 then Param.Harass:addParam("HitChance", "Set (Q) HitChance" , SCRIPT_PARAM_SLICE, 2, 1, 5) end
	if Param.prediction.n1 == 2 then Param.Harass:addParam("HitChance", "Set (Q) HitChance" , SCRIPT_PARAM_SLICE, 0, 0, 3) end
	if Param.prediction.n1 == 3 then Param.Harass:addParam("HitChance", "Set (Q) HitChance" , SCRIPT_PARAM_SLICE, 1, 0, 3) end

	if _G.Reborn_Loaded ~= nil then
   		LoadSACR()
   	elseif _Pewalk then
   		LoadPewalk()
	elseif Param.orbwalker.n1 == 1 then
		EnvoiMessage("SxOrbWalk loading..")
		LoadSXOrb()
	elseif Param.orbwalker.n1 == 2 then
		EnvoiMessage("BigFat OrbWalker loading..")
		LoadBFOrb()
	elseif Param.orbwalker.n1 == 3 then
		local neo = 1
		EnvoiMessage("Nebelwolfi's Orb Walker loading..")
		NebelOrb()
	end
end
  
function LoadSXOrb()

	if FileExist(LIB_PATH .. "/SxOrbWalk.lua") then
		require("SxOrbWalk")
		EnvoiMessage("Loaded SxOrbWalk")
		Param:addSubMenu("SxOrbWalk", "SXMenu")
		SxOrb:LoadToMenu(Param.SXMenu)
	else
		local ToUpdate = {}
		    ToUpdate.Version = 1
		   	ToUpdate.UseHttps = true
		    ToUpdate.Host = "raw.githubusercontent.com"
		   	ToUpdate.VersionPath = "/Superx321/BoL/master/common/SxOrbWalk.Version"
		   	ToUpdate.ScriptPath =  "/Superx321/BoL/master/common/SxOrbWalk.lua"
		    ToUpdate.SavePath = LIB_PATH.."/SxOrbWalk.lua"
		   	ToUpdate.CallbackUpdate = function(NewVersion,OldVersion) print("<font color=\"#FF794C\"><b>SxOrbWalk: </b></font> <font color=\"#FFDFBF\">Updated to "..NewVersion..". </b></font>") end
		    ToUpdate.CallbackNoUpdate = function(OldVersion) print("<font color=\"#FF794C\"><b>SxOrbWalk: </b></font> <font color=\"#FFDFBF\">No Updates Found</b></font>") end
		    ToUpdate.CallbackNewVersion = function(NewVersion) print("<font color=\"#FF794C\"><b>SxOrbWalk: </b></font> <font color=\"#FFDFBF\">New Version found ("..NewVersion.."). Please wait until its downloaded</b></font>") end
		   	ToUpdate.CallbackError = function(NewVersion) print("<font color=\"#FF794C\"><b>SxOrbWalk: </b></font> <font color=\"#FFDFBF\">Error while Downloading. Please try again.</b></font>") end
		   	ScriptUpdate(ToUpdate.Version,ToUpdate.UseHttps, ToUpdate.Host, ToUpdate.VersionPath, ToUpdate.ScriptPath, ToUpdate.SavePath, ToUpdate.CallbackUpdate,ToUpdate.CallbackNoUpdate, ToUpdate.CallbackNewVersion,ToUpdate.CallbackError)
	end
end

function LoadBFOrb()
	local LibPath = LIB_PATH.."Big Fat Orbwalker.lua"
	local ScriptPath = SCRIPT_PATH.."Big Fat Orbwalker.lua"
		if not (FileExist(ScriptPath) and _G["BigFatOrb_Loaded"] == true) then
			local Host = "raw.github.com"
			local Path = "/BigFatNidalee/BoL-Releases/master/LimitedAccess/Big Fat Orbwalker.lua?rand="..math.random(1,10000)
			DownloadFile("https://"..Host..Path, LibPath, function ()  end)
		require "Big Fat Orbwalker"
	end
end

function LoadSpikeLib()
	local LibPath = LIB_PATH.."SpikeLib.lua"
	if not FileExist(LibPath) then
		local Host = "raw.github.com"
		local Path = "/spyk1/BoL/master/bundle/SpikeLib.lua".."?rand="..math.random(1,10000)
		DownloadFile("https://"..Host..Path, LibPath, function ()  end)
		DelayAction(function () require("SpikeLib") end, 5)
	else
		require("SpikeLib")
		DelayAction(function ()EnvoiMessage("Loaded Libraries with success!") end, 3)
	end
end

function NebelOrb()
	local function LoadOrb()
		if not _G.NebelwolfisOrbWalkerLoaded then
			require "Nebelwolfi's Orb Walker"
			NebelwolfisOrbWalkerClass()
		end
	end
	if not FileExist(LIB_PATH.."Nebelwolfi's Orb Walker.lua") then
		DownloadFile("http://raw.githubusercontent.com/nebelwolfi/BoL/master/Common/Nebelwolfi's Orb Walker.lua", LIB_PATH.."Nebelwolfi's Orb Walker.lua", function()
			LoadOrb()
		end)
	else
		local f = io.open(LIB_PATH.."Nebelwolfi's Orb Walker.lua")
		f = f:read("*all")
		if f:sub(1,4) == "func" then
			DownloadFile("http://raw.githubusercontent.com/nebelwolfi/BoL/master/Common/Nebelwolfi's Orb Walker.lua", LIB_PATH.."Nebelwolfi's Orb Walker.lua", function()
				LoadOrb()
			end)
		else
			LoadOrb()
		end
	end
end

function LoadSACR()
	if _G.Reborn_Initialised then
	elseif _G.Reborn_Loaded then
		EnvoiMessage("Loaded SAC:R")
	else
		DelayAction(function()EnvoiMessage("Failed to Load SAC:R")end, 7)
	end 
end

function LoadPewalk()
	if _Pewalk then
		EnvoiMessage("Loaded Pewalk")
		DelayAction(function ()EnvoiMessage("[Pewalk] Disable every spell usage in Pewalk for better performances with my script.")end, 7)
	elseif not _Pewalk then
		EnvoiMessage("Pewalk loading error")
	end
end

function LoadVPred()
	if FileExist(LIB_PATH .. "/VPrediction.lua") then
		require("VPrediction")
		EnvoiMessage("Succesfully loaded VPred")
		VP = VPrediction()
	else
		local ToUpdate = {}
		ToUpdate.Version = 0.0
		ToUpdate.UseHttps = true
		ToUpdate.Name = "VPrediction"
		ToUpdate.Host = "raw.githubusercontent.com"
		ToUpdate.VersionPath = "/SidaBoL/Scripts/master/Common/VPrediction.version"
		ToUpdate.ScriptPath =  "/SidaBoL/Scripts/master/Common/VPrediction.lua"
		ToUpdate.SavePath = LIB_PATH.."/VPrediction.lua"
		ToUpdate.CallbackUpdate = function(NewVersion,OldVersion) print("<font color=\"#FF794C\"><b>" .. ToUpdate.Name .. ": </b></font> <font color=\"#FFDFBF\">Updated to "..NewVersion..". Please Reload with 2x F9</b></font>") end
		ToUpdate.CallbackNoUpdate = function(OldVersion) print("<font color=\"#FF794C\"><b>" .. ToUpdate.Name .. ": </b></font> <font color=\"#FFDFBF\">No Updates Found</b></font>") end
		ToUpdate.CallbackNewVersion = function(NewVersion) print("<font color=\"#FF794C\"><b>" .. ToUpdate.Name .. ": </b></font> <font color=\"#FFDFBF\">New Version found ("..NewVersion.."). Please wait until its downloaded</b></font>") end
		ToUpdate.CallbackError = function(NewVersion) print("<font color=\"#FF794C\"><b>" .. ToUpdate.Name .. ": </b></font> <font color=\"#FFDFBF\">Error while Downloading. Please try again.</b></font>") end
		ScriptUpdate(ToUpdate.Version,ToUpdate.UseHttps, ToUpdate.Host, ToUpdate.VersionPath, ToUpdate.ScriptPath, ToUpdate.SavePath, ToUpdate.CallbackUpdate,ToUpdate.CallbackNoUpdate, ToUpdate.CallbackNewVersion,ToUpdate.CallbackError)
	end
end

function LoadHPred()
	if FileExist(LIB_PATH .. "/HPrediction.lua") then
		require("HPrediction")
		EnvoiMessage("Succesfully loaded HPred")
		HPred = HPrediction()
		HP_Q = HPSkillshot({type = "DelayLine", delay = 0.250, range = 1075, width = 110, speed = 850})
		HP_W = HPSkillshot({type = "DelayLine", delay = 0.25, range = 1000, width = 100, speed = math.huge})
		HP_R = HPSkillshot({type = "DelayLine", delay = 0.100, range = 625, width = 350, speed = math.huge})
		UseHP = true
	else
		local ToUpdate = {}
		ToUpdate.Version = 3
		ToUpdate.UseHttps = true
		ToUpdate.Name = "HPrediction"
		ToUpdate.Host = "raw.githubusercontent.com"
		ToUpdate.VersionPath = "/BolHTTF/BoL/master/HTTF/Common/HPrediction.version"
		ToUpdate.ScriptPath =  "/BolHTTF/BoL/master/HTTF/Common/HPrediction.lua"
		ToUpdate.SavePath = LIB_PATH.."/HPrediction.lua"
		ToUpdate.CallbackUpdate = function(NewVersion,OldVersion) print("<font color=\"#FF794C\"><b>" .. ToUpdate.Name .. ": </b></font> <font color=\"#FFDFBF\">Updated to "..NewVersion..". Please Reload with 2x F9</b></font>") end
		ToUpdate.CallbackNoUpdate = function(OldVersion) print("<font color=\"#FF794C\"><b>" .. ToUpdate.Name .. ": </b></font> <font color=\"#FFDFBF\">No Updates Found</b></font>") end
		ToUpdate.CallbackNewVersion = function(NewVersion) print("<font color=\"#FF794C\"><b>" .. ToUpdate.Name .. ": </b></font> <font color=\"#FFDFBF\">New Version found ("..NewVersion.."). Please wait until its downloaded</b></font>") end
		ToUpdate.CallbackError = function(NewVersion) print("<font color=\"#FF794C\"><b>" .. ToUpdate.Name .. ": </b></font> <font color=\"#FFDFBF\">Error while Downloading. Please try again.</b></font>") end
		ScriptUpdate(ToUpdate.Version,ToUpdate.UseHttps, ToUpdate.Host, ToUpdate.VersionPath, ToUpdate.ScriptPath, ToUpdate.SavePath, ToUpdate.CallbackUpdate,ToUpdate.CallbackNoUpdate, ToUpdate.CallbackNewVersion,ToUpdate.CallbackError)
	end
end

function LoadSPred()
	if FileExist(LIB_PATH .. "/SPrediction.lua") then
		require("SPrediction")
		EnvoiMessage("Succesfully loaded SPred")
		SP = SPrediction()
	else
		local ToUpdate = {}
		ToUpdate.Version = 3
		ToUpdate.UseHttps = true
		ToUpdate.Name = "SPrediction"
		ToUpdate.Host = "raw.githubusercontent.com"
		ToUpdate.VersionPath = "/nebelwolfi/BoL/master/Common/SPrediction.version"
		ToUpdate.ScriptPath =  "/nebelwolfi/BoL/master/Common/SPrediction.lua"
		ToUpdate.SavePath = LIB_PATH.."/SPrediction.lua"
		ToUpdate.CallbackUpdate = function(NewVersion,OldVersion) print("<font color=\"#FF794C\"><b>" .. ToUpdate.Name .. ": </b></font> <font color=\"#FFDFBF\">Updated to "..NewVersion..". Please Reload with 2x F9</b></font>") end
		ToUpdate.CallbackNoUpdate = function(OldVersion) print("<font color=\"#FF794C\"><b>" .. ToUpdate.Name .. ": </b></font> <font color=\"#FFDFBF\">No Updates Found</b></font>") end
		ToUpdate.CallbackNewVersion = function(NewVersion) print("<font color=\"#FF794C\"><b>" .. ToUpdate.Name .. ": </b></font> <font color=\"#FFDFBF\">New Version found ("..NewVersion.."). Please wait until its downloaded</b></font>") end
		ToUpdate.CallbackError = function(NewVersion) print("<font color=\"#FF794C\"><b>" .. ToUpdate.Name .. ": </b></font> <font color=\"#FFDFBF\">Error while Downloading. Please try again.</b></font>") end
		ScriptUpdate(ToUpdate.Version,ToUpdate.UseHttps, ToUpdate.Host, ToUpdate.VersionPath, ToUpdate.ScriptPath, ToUpdate.SavePath, ToUpdate.CallbackUpdate,ToUpdate.CallbackNoUpdate, ToUpdate.CallbackNewVersion,ToUpdate.CallbackError)
	end
end

function KillSteal()
	for _, unit in pairs(GetEnemyHeroes()) do
		health = unit.health
		Qdmg = ((myHero:CanUseSpell(_Q) == READY and damageQ) or 0)
		Edmg = ((myHero:CanUseSpell(_E) == READY and damageE) or 0)
		Rdmg = ((myHero:CanUseSpell(_R) == READY and damageR) or 0)
		if GetDistance(unit) < 1000 then
			if Param.KillSteal.KillStealON then
				if health <= Qdmg and Param.KillSteal.UseQ and myHero:CanUseSpell(_Q) == READY and ValidTarget(unit) then
					LogicQ(unit)
				end
				if health <= Edmg and Param.KillSteal.UseE and myHero:CanUseSpell(_E) == READY and ValidTarget(unit) then
					CastSpell(_E, unit)
				end
				if health <= Rdmg and Param.KillSteal.UseR and myHero:CanUseSpell(_R) == READY and ValidTarget(unit) then
					LogicR(unit)
				end
				if myHero:GetSpellData(SUMMONER_1).name:find("SummonerDot") or myHero:GetSpellData(SUMMONER_2).name:find("SummonerDot") then
					if health <= 40 + (20 * myHero.level) and Param.KillSteal.UseIgnite and (myHero:CanUseSpell(Ignite) == READY) and ValidTarget(unit) then
						CastSpell(Ignite, unit)
					end
				end
			end
		end
	end
end

function OnTick()
	if myHero.dead then return end
		ts:update()
		Target = GetCustomTarget()
		WdansR(Target)

		KeyPermaShow()

		KillSteal()

		SpellFunc()

		DrawFunc()

		Consommables()
	--
end

function WdansR(unit)
	if Param.miscellaneous.WdansR then
		if unit and unit.type == myHero.type and unit.team ~= myHero.team then
			if unit.hasMovePath and unit.path.count > 1 and RMissile and myHero:CanUseSpell(_W) == READY then
			local path = unit.path:Path(2)
				if GetDistance(path, RMissile) > 210 and GetDistance(unit, RMissile) < 175  then
				local p1 = Vector(unit) + (Vector(path) - Vector(unit)):normalized() * 0.6 * unit.ms
					if GetDistance(p1) < 1000 and GetDistance(RMissile, p1) > 150 and GetDistance(RMissile, p1) < 250 and GetDistance(unit, path) > GetDistance(unit, p1) then
						CastSpell(_W, p1.x, p1.z)
					end
				end
			end
		end
	end
end

function GetCustomTarget()
	ts:update()	
	if ValidTarget(ts.target) and ts.target.type == myHero.type then
		return ts.target
	else
		return nil
	end
end

function Combo(unit)
	if ValidTarget(unit) and unit ~= nil and unit.type == myHero.type and not Immune(unit) then
		if Param.Combo.UseQ then 
			LogicQ(unit)
		end	
		if Param.Combo.UseE then 
			LogicE(unit)
		end	
		if Param.Combo.UseR then 
			LogicR(unit)
		end
	end
end

function Consommables()
	DrawKillable()
	AutoSeraphin()
	AutoFrostQuenn()
	AutoElixirDuSorcier()
	if VIP_USER and Param.miscellaneous.LVL.Enable then
	 	AutoLvlSpell()
	end
	if Param.miscellaneous.Pots.potswithscript and not Param.miscellaneous.Pots.potonlywithcombo then
		AutoPotions()
	elseif Param.miscellaneous.Pots.potswithscript and Param.miscellaneous.Pots.potonlywithcombo and ComboKey then
		AutoPotions() 
	end
end

function SpellFunc()
	if Teleport then
		if Param.exploits.egg.eggactive then 
			AutoEggTp()
		end
	end

	if QMissile ~= nil then
		DetectQ()
	end

	if Param.miscellaneous.ManualR then
		if RMissile ~= nil then
			if not ValidR() then
					CastSpell(_R)
			end
		end
	end

	if Param.exploits.SionR then
		SionUlti()
	end

end

function KeyPermaShow()
	ComboKey = Param.Combo.comboKey
	HarassKey = Param.Harass.Harasskey
	LaneClearKey = Param.Clear.LaneClear.laneclearkey
	JungleClearKey = Param.Clear.JungleClear.jungleclearkey
	WaveClearKey = Param.Clear.WaveClear.waveclearkey

	if ComboKey then 
		Combo(Target)
		Param.n5 = 2
	elseif not ComboKey then
		if HarassKey then
			Harass(Target)
			Param.n5 = 3
		end
		if LaneClearKey then
			LaneClear()
			Param.n5 = 4
		end
		if WaveClearKey then
			WaveClear()
			Param.n5 = 5
		end
		if JungleClearKey then
			JungleClear()
			Param.n5 = 6
		end
	end
	if Param.n5 ~= 1 and not ComboKey and not HarassKey and not LaneClearKey and not JungleClearKey and not WaveClearKey then
		Param.n5 = 1
	end
end

function DrawFunc()
	if Param.drawing.wallmenu.active then
		drawWallSpots = true
	elseif not Param.drawing.wallmenu.active then
	    drawWallSpots = false
	end
end

function Harass(unit)
	ts:update()
	if ValidTarget(unit) and unit ~= nil and unit.type == myHero.type then
		if(myHero:CanUseSpell(_Q) == READY and (myHero.mana / myHero.maxMana > Param.Harass.manamanager /100 ) and ts.target ~= nil and Param.Harass.UseQ ) then 
	  		LogicQ(unit)
		end
		if(myHero:CanUseSpell(_E) == READY and (myHero.mana / myHero.maxMana > Param.Harass.manamanager /100 ) and ts.target ~= nil and Param.Harass.UseE ) then 
	 		LogicE(unit)
		end
		if(myHero:CanUseSpell(_R) == READY and (myHero.mana / myHero.maxMana > Param.Harass.manamanager /100) and ts.target ~= nil and Param.Harass.UseR ) then
			LogicR(unit)
		end
	end
end

function ManaLaneClear()
    if myHero.mana < (myHero.maxMana * ( Param.Clear.LaneClear.manamanager / 100)) then
        return true
    else
        return false
    end
end

function ManaJungleClear()
    if myHero.mana < (myHero.maxMana * ( Param.Clear.JungleClear.manamanager / 100)) then
        return true
    else
        return false
    end
end

function ManaWaveClear()
    if myHero.mana < (myHero.maxMana * ( Param.Clear.JungleClear.manamanager / 100)) then
        return true
    else
        return false
    end
end

function LaneClear()
	enemyMinions:update()
	if not ManaLaneClear() then
		for i, minion in pairs(enemyMinions.objects) do
			if ValidTarget(minion) and minion ~= nil and not minion.dead then
				if Param.Clear.LaneClear.UseQ and GetDistance(minion) <= SkillQ.range and myHero:CanUseSpell(_Q) == READY then
					LogicQ(minion)
				end
				if Param.Clear.LaneClear.UseE and GetDistance(minion) <= SkillE.range and myHero:CanUseSpell(_E) == READY then
					LogicE(minion)
				end
				if Param.Clear.LaneClear.UseR and GetDistance(minion) <= SkillR.range and myHero:CanUseSpell(_R) == READY then
					LogicR(minion)
				end
			end
		end
	end
end

function WaveClear()
	enemyMinions:update()
	local canonheal = ((CurrentTimeInMillis()/6000)+700)
	if not ManaWaveClear() then
		for i, minion in pairs(enemyMinions.objects) do
			if ValidTarget(minion) and minion ~= nil and (minion.maxHealth >= canonheal) and not minion.dead then
				if GetDistance(minion) <= SkillQ.range and myHero:CanUseSpell(_Q) == READY and (minion.maxHealth >= canonheal) then
					LogicQ(minion)
				end
				if GetDistance(minion) <= SkillE.range and myHero:CanUseSpell(_E) == READY and (minion.maxHealth >= canonheal) then
					CastSpell(_E, minion)
				end
				if GetDistance(minion) <= SkillR.range and myHero:CanUseSpell(_R) == READY and (minion.maxHealth >= canonheal) then
					LogicR(minion)
				end 
			end
		end
	end
end

function JungleClear()
	jungleMinions:update()
	if not ManaJungleClear() then
		for i, jungleMinion in pairs(jungleMinions.objects) do
			if jungleMinion ~= nil and not jungleMinion.dead then
				if Param.Clear.JungleClear.UseE and GetDistance(jungleMinion) <= SkillE.range and myHero:CanUseSpell(_E) == READY then
					LogicE(jungleMinion)
				end
				if Param.Clear.JungleClear.UseR and GetDistance(jungleMinion) <= SkillR.range and myHero:CanUseSpell(_R) == READY then 
					LogicR(jungleMinion)
				end
				if Param.Clear.JungleClear.UseQ and GetDistance(jungleMinion) <= SkillQ.range and myHero:CanUseSpell(_Q) == READY then
					LogicQ(jungleMinion)
				end
			end
		end
	end
end

function LogicQ(unit)
	if QMissile ~=nil then return end
	if unit ~= nil and GetDistance(unit) <= SkillQ.range and myHero:CanUseSpell(_Q) == READY and not unit.dead then
		if Param.prediction.n1 == 1 then
			if ComboKey then 
				ChanceHit = Param.Combo.HitChance
			elseif HarassKey then
				ChanceHit = Param.Harass.HitChance
			else 
				ChanceHit = 2
			end
			CastPosition,  HitChance,  Position = VP:GetLineCastPosition(unit, SkillQ.delay, SkillQ.width, SkillQ.range, SkillQ.speed, myHero, false)
			if HitChance >= ChanceHit then
				CastSpell(_Q, CastPosition.x, CastPosition.z)
			end
		elseif Param.prediction.n1 == 2 then
			if ComboKey then 
				ChanceHit = Param.Combo.HitChance
			elseif HarassKey then
				ChanceHit = Param.Harass.HitChance
			else 
				ChanceHit = 0
			end
  			local CastPosition, HitChance = HPred:GetPredict(HP_Q, unit, myHero)
  			if HitChance > ChanceHit then
    			CastSpell(_Q, CastPosition.x, CastPosition.z)
  			end
		elseif Param.prediction.n1 == 3 then
			if ComboKey then 
				ChanceHit = Param.Combo.HitChance
			elseif HarassKey then
				ChanceHit = Param.Harass.HitChance
			else 
				ChanceHit = 1
			end
			CastPosition, HitChance, PredPos = SP:Predict(unit, SkillQ.range, SkillQ.speed, SkillQ.delay, SkillQ.width, false, myHero)
            if HitChance >= ChanceHit then
                CastSpell(_Q, unit)
            end
		end
	end
end

function LogicW(unit)
	if unit ~= nil and GetDistance(unit) <= SkillW.range and myHero:CanUseSpell(_W) == READY and not unit.dead then
		if Param.prediction.n1 == 1 then
			CastPosition,  HitChance,  Position = VP:GetLineCastPosition(unit, SkillW.delay, SkillW.width, SkillW.range, SkillW.speed, myHero, false)
			if HitChance >= 2 then
				CastSpell(_W, CastPosition.x, CastPosition.z)
			end
		elseif Param.prediction.n1 == 2 then
 		local Position, HitChance = HPred:GetPredict(HP_W, unit, myHero)
  		if HitChance > 0 then
    		CastSpell(_W, Position.x, Position.z)
  		end
		elseif Param.prediction.n1 == 3 then
			Position, Chance, PredPos = SP:Predict(SkillW, myHero, unit)
            if Chance >= 1 then
            	CastSpell(_W, Position.x, Position.y)
            end
		end
	end
end

function LogicE(unit)
	if JungleClearKey and not unit.dead then
		if TargetHaveBuff("chilled", unit) then
			if myHero:CanUseSpell(_E) == READY then
				CastSpell(_E, unit)
			end
		elseif myHero:CanUseSpell(_R) == READY then
			CastSpell(_E, unit)
		elseif unit.health < damageE then
			CastSpell(_E, unit)
		end
	end
	if Param.miscellaneous.EGel and not unit.dead then
		if TargetHaveBuff("chilled", unit) then
			if myHero:CanUseSpell(_E) == READY then
				CastSpell(_E, unit)
			end
		end
	elseif not Param.miscellaneous.EGel and not unit.dead then
		if myHero:CanUseSpell(_E) == READY then
			CastSpell(_E, unit)
		end
	end
end

function LogicR(unit)
	if RMissile ~= nil then return end
		if JungleClearKey and RMissile ~= nil then return end
			if unit ~= nil and GetDistance(unit) <= SkillR.range and myHero:CanUseSpell(_R) == READY and not unit.dead then
				if Param.prediction.n1 == 1 then
					CastPosition,  HitChance,  Position = VP:GetLineCastPosition(unit, SkillR.delay, SkillR.width, SkillR.range, SkillR.speed, myHero, false)
					if HitChance >= 2 then
						CastSpell(_R, CastPosition.x, CastPosition.z)
					end
				elseif Param.prediction.n1 == 2 then
  				local CastPosition, HitChance = HPred:GetPredict(HP_R, unit, myHero)
  				if HitChance > 0 then
    				CastSpell(_R, CastPosition.x, CastPosition.z)
  				end
				elseif Param.prediction.n1 == 3 then
					CastPosition, HitChance, PredPos = SP:Predict(unit, SkillR.range, SkillR.speed, SkillR.delay, SkillR.width, false, myHero)
            		if HitChance >= 0 then
                		CastSpell(_R, CastPosition.x, CastPosition.z)
            		end
				end
			end
		--
		if unit ~= nil and Param.prediction.n1 == 1 and not unit.dead then
			if not RMissile and myHero:CanUseSpell(_R) == READY and GetDistance(unit) <= SkillR.range then
				local point = FindBestCircle(unit, SkillR.range, SkillR.width)
				CastSpell(_R, point.x, point.z)
			end
		end
	--
end

function DetectQ()
	local QZone = 0
	if Param.miscellaneous.QError == 1 then
		QZone = 200
	elseif Param.miscellaneous.QError == 2 then
		QZone = 195
	elseif Param.miscellaneous.QError == 3 then
		QZone = 190
	end

	if LaneClearKey then
		for i, minion in ipairs(enemyMinions.objects) do
			if ValidTarget(minion) and minion.visible and QMissile and not minion.dead then
				if GetDistance(minion, QMissile) <= QZone then
					CastSpell(_Q)
				end
			end
		end
	end

	if WaveClearKey then 
		for i, minion in ipairs(enemyMinions.objects) do
			if ValidTarget(minion) and minion.visible and QMissile and not minion.dead then
				if (minion.maxHealth >= ((CurrentTimeInMillis()/6000)+700)) and GetDistance(minion, QMissile) <= QZone then
					CastSpell(_Q)
				elseif GetDistance(minion, QMissile) <= QZone then
					CastSpell(_Q)
				end
			end
		end
	end

	if JungleClearKey then
		for i, jungleMinion in pairs(jungleMinions.objects) do
			if ValidTarget(jungleMinion) and jungleMinion.visible and QMissile and not jungleMinion.dead then
				if GetDistance(jungleMinion, QMissile) <= QZone then
					CastSpell(_Q)
				end
			end
		end
	end

	for i, enemy in ipairs(GetEnemyHeroes()) do
		if ValidTarget(enemy) and enemy.visible and QMissile and not enemy.dead then
			if GetDistance(enemy, QMissile) <= QZone then
				CastSpell(_Q)
			end
		end
	end
end

function ValidR()
	local TargetCount = 0
	for i = 1, heroManager.iCount, 1 do
		local hero = heroManager:GetHero(i)
		if hero.team ~= myHero.team and ValidTarget(hero) then
			if GetDistance(hero, RMissile) < 500 then
				TargetCount = TargetCount + 1
			end
		end
	end
	enemyMinions:update()
	for i, minion in pairs(enemyMinions.objects) do
		if ValidTarget(minion) and minion ~= nil and GetDistance(minion, RMissile) < 500 then
			TargetCount = TargetCount + 1
		end
	end
	jungleMinions:update()
	for i, jungleMinion in pairs(jungleMinions.objects) do
		if jungleMinion ~= nil and GetDistance(jungleMinion, RMissile) < 500 then
			TargetCount = TargetCount + 1
		end
	end
	if TargetCount > 0 then 
		return true 
	else 
		return false 
	end	
end
 
function DrawKillable()
	for i = 1, heroManager.iCount, 1 do
		local enemy = heroManager:getHero(i)
		if enemy and ValidTarget(enemy) then
			if enemy.team ~= myHero.team then 
				if myHero:GetSpellData(SUMMONER_1).name:find("SummonerDot") or myHero:GetSpellData(SUMMONER_2).name:find("SummonerDot") then
					if (myHero:CanUseSpell(Ignite) == READY) then
						iDmg = 40 + (20 * myHero.level)
					elseif (myHero:CanUseSpell(Ignite) ~= READY) then
						iDmg = 0
					end
				end
				Qdmg = ((myHero:CanUseSpell(_Q) == READY and myHero:CalcMagicDamage(enemy,damageQ)) or 0)
				Edmg = ((myHero:CanUseSpell(_E) == READY and myHero:CalcMagicDamage(enemy,damageE)) or 0)
				Rdmg = ((myHero:CanUseSpell(_R) == READY and myHero:CalcMagicDamage(enemy,damageR)) or 0)
				if iDmg > enemy.health then
					KillText[i] = 1
				elseif Qdmg > enemy.health then
					KillText[i] = 2
				elseif Qdmg*2 > enemy.health then
					KillText[i] = 3
				elseif Qdmg + iDmg > enemy.health then
					KillText[i] = 4
				elseif Qdmg*2 + iDmg > enemy.health then
					KillText[i] = 5
				elseif Qdmg + Edmg*2 > enemy.health then
					KillText[i] = 6
				elseif Qdmg*2 + Edmg*2 > enemy.health then
					KillText[i] = 7
				elseif Qdmg + Edmg*2 + iDmg > enemy.health then
					KillText[i] = 9
				elseif Qdmg*2 + Edmg*2 + iDmg > enemy.health then
					KillText[i] = 9
				elseif Qdmg + Edmg*2 + Rdmg > enemy.health then
					KillText[i] = 11
				elseif Qdmg*2 + Edmg*2 + Rdmg > enemy.health then
					KillText[i] = 11
				elseif Qdmg*2 + Edmg*2 + Rdmg*3 > enemy.health then
					KillText[i] = 12
				elseif Qdmg + Edmg*2 + Rdmg + iDmg > enemy.health then
					KillText[i] = 13
				elseif Qdmg*2 + Edmg*2 + Rdmg + iDmg > enemy.health then
					KillText[i] = 14
				elseif Qdmg*2 + Edmg*2 + Rdmg*3 + iDmg > enemy.health then
					KillText[i] = 15
				else
					KillText[i] = 16
				end 
			end 
		end 
	end 
end

function OnCreateObj(object)
	if object.name == "cryo_FlashFrost_Player_mis.troy" then
		QMissile = object
	end
	if object.name == "cryo_storm_green_team.troy" then
		RMissile = object
	end
end

function OnDeleteObj(object)
	if object.name == "cryo_FlashFrost_mis.troy" then
		QMissile = nil
	end
	if object.name == "cryo_storm_green_team.troy" then
		RMissile = nil
	end
end

function OnDraw()
	if not myHero.dead and not Param.drawing.disablealldrawings then
		if myHero:CanUseSpell(_Q) == READY and Param.drawing.spell.Qdraw then 
			DrawCircle3D(myHero.x, myHero.y, myHero.z, SkillQ.range, 1, 0xFFFFFFFF)
		end
		if myHero:CanUseSpell(_W) == READY and Param.drawing.spell.Wdraw then 
			DrawCircle3D(myHero.x, myHero.y, myHero.z, SkillW.range, 1, 0xFFFFFFFF)
		end
		if myHero:CanUseSpell(_E) == READY and Param.drawing.spell.Edraw then 
			DrawCircle3D(myHero.x, myHero.y, myHero.z, SkillE.range, 1, 0xFFFFFFFF)
		end
		if myHero:CanUseSpell(_R) == READY and Param.drawing.spell.Rdraw then
			DrawCircle3D(myHero.x, myHero.y, myHero.z, SkillR.range, 1, 0xFFFFFFFF)
		end
		if Param.drawing.spell.AAdraw then
			DrawCircle3D(myHero.x, myHero.y, myHero.z, myHero.range+myHero.boundingRadius, 1, 0xFFFFFFFF)
		end
		if Param.drawing.hitbox then
			DrawCircle3D(myHero.x, myHero.y, myHero.z, myHero.boundingRadius, 1, 0xFFFFFFFF)
		end
		if Param.drawing.spell.EggTimer and OeufTimerDraw == 1 then
			DrawText3D("REBIRTH :"..math.round(startTime - os.clock(), 2).."s", myHero.x-100, myHero.y-50, myHero.z, 20, 0xFFFFFFFF)
		end
		if Target ~= nil and ValidTarget(Target) then
			if Param.drawing.tText then
				DrawText3D("ACTUAL BITCH",Target.x-100, Target.y-50, Target.z, 20, 0xFFFFFFFF) -- Acknowledgments to http://forum.botoflegends.com/user/25371-big-fat-corki/ and his Mark IV script for giving me the idea of the target name.
			end
		end
		if Param.drawing.spell.Qtravel then
			if QMissile ~= nil then
				local Vec2 = Vector(QMissile.pos) + (Vector(myHero.pos) - Vector(QMissile.pos)):normalized()
				DrawCircle3D(Vec2.x, Vec2.y, Vec2.z, 200, 1, 0xFFFFFFFF)
			end
		end

		if Param.drawing.BarH then
			for _, unit in pairs(GetEnemyHeroes()) do
				if unit ~= nil and GetDistance(unit) < 3000 then
					local Center = GetUnitHPBarPos(unit)
					Qdmg = ((myHero:CanUseSpell(_Q) == READY and myHero:CalcMagicDamage(unit,damageQ)) or 0)
					Edmg = ((myHero:CanUseSpell(_E) == READY and myHero:CalcMagicDamage(unit,damageE)) or 0)
					Rdmg = ((myHero:CanUseSpell(_R) == READY and myHero:CalcMagicDamage(unit,damageR)) or 0)
					local Y3QER = Qdmg*2 + Edmg*2 + Rdmg*2
					if Center.x > -100 and Center.x < WINDOW_W+100 and Center.y > -100 and Center.y < WINDOW_H+100 then
						local off = GetUnitHPBarOffset(unit)
						local y=Center.y + (off.y * 53) + 2
						local xOff = ({['AniviaEgg'] = -0.1,['Darius'] = -0.05,['Renekton'] = -0.05,['Sion'] = -0.05,['Thresh'] = -0.03,})[unit.charName]
						local x = Center.x + ((xOff or 0) * 140) - 66
						if not TargetHaveBuff("SummonerExhaust", myHero) then
							dmg = unit.health - Y3QER
						elseif TargetHaveBuff("SummonerExhaust", myHero) then
							dmg = unit.health - (Y3QER-((Y3QER*40)/100))
						end
						DrawLine(x + ((unit.health /unit.maxHealth) * 104),y, x+(((dmg > 0 and dmg or 0) / unit.maxHealth) * 104),y,9, GetDistance(unit) < 3000 and 0x6699FFFF)
					end
				end
			end
		end

		if Param.drawing.drawKillable then
			for i = 1, heroManager.iCount do
				local enemy = heroManager:getHero(i)
				if enemy and ValidTarget(enemy) then
					local barPos = WorldToScreen(D3DXVECTOR3(enemy.x, enemy.y, enemy.z))
					local PosX = barPos.x - 35
					local PosY = barPos.y - 50  
					DrawText(TextList[KillText[i]], 15, PosX, PosY, ARGB(255,255,204,0))
				end 
			end 
		end 

		if GetGame().map.shortName == "summonerRift" then
			if Param.drawing.wallmenu.active then
				for i,group in pairs(wallSpots) do
					for x, wallSpot in pairs(group.Locations) do
						if GetDistance(wallSpot) < 1500 then
							DrawCircle3D(wallSpot.x, wallSpot.y, wallSpot.z, Param.drawing.wallmenu.radius, 1, 0xFFFFFFFF)
						end
					end
				end
			end
		end
	end
end

function SionUlti()
	if Param.exploits.RSion then
		if UnitHaveBuff("SionR", unit) and GetDistanceSqr(unit) <= 715*715 then
		       CastSpell(_W, unit.x+300, unit.z+300)
		end
	end
end

function OnProcessSpell(unit, spell)

	if Param.exploits.EVayne then
		if spell.name == "VayneCondemn" then
	 		if unit.team == myHero.team and GetDistanceSqr(unit) <= 750*750 then
	 			local Xtarg = myHero.x+spell.target.x+350
	 			local Ztarg = myHero.y+spell.target.z+350
	 			DelayAction(function()
	 				if not unit.dead then
						CastSpell(_W, Xtarg, Ztarg)
					end
				end, 0.10)
			end
		end
	end
	if Param.miscellaneous.Wstop then
		if unit.team ~= myHero.team then
	   	 	if isAChampToInterrupt[spell.name] and GetDistanceSqr(unit) <= 715*715 then
	   	 		if not unit.dead then
	       	 		CastSpell(_W, unit.x, unit.z)
	       	 	end
	    	end
	    end
	end
	if Param.miscellaneous.GapCloser.QGapClos and myHero:CanUseSpell(_Q) == READY then
	    if unit.team ~= myHero.team then

	    	if Param.miscellaneous.GapCloser.Special then
		    	if spell.name == "ZedR" and spell.target and spell.target.networkID == myHero.networkID then
		    		if myHero:CanUseSpell(_R) == READY and myHero.mana > 300 and not RMissile ~= nil and Param.miscellaneous.GapCloser.RGapClos then
		    			CastSpell(_R, myHero.x, myHero.z)
		    		elseif myHero:CanUseSpell(_R) == READY and myHero.mana < 300 and not RMissile ~= nil and Param.miscellaneous.GapCloser.RGapClos then
		    			DelayAction(function()
		    				if not unit.dead then
		    					CastSpell(_R, myHero.x, myHero.z)
		    				end
		    			end, 0.50)
		    		end
		    		if myHero:CanUseSpell(_Q) == READY then
		    			DelayAction(function()
		    				if not unit.dead then
		    					CastSpell(_Q, myHero.x-50, myHero.z-50)
		    				end
		    			end, 0.80)
		    		end
		    		if myHero:CanUseSpell(_E) == READY and Param.miscellaneous.GapCloser.EGapClos then
		    			DelayAction(function()
		    				if not unit.dead then
		    					CastSpell(_E, unit)
		    				end
		    			end, 1)
		    		end
		    	end
		    end

	        if isAGapcloserUnitTarget[spell.name] and spell.name ~= "ZedR" then
	            if spell.target and spell.target.networkID == myHero.networkID then
	            	if Param.miscellaneous.GapCloser.RGapClos and myHero:CanUseSpell(_R) == READY and not RMissile ~= nil then
	            		CastSpell(_R, myHero.x, myHero.z)
	            	end
	            	DelayAction(function()
	            		if not unit.dead then
	            			CastSpell(_Q, unit)
	            		end
	            	end, 0.05)
	            	DelayAction(function()
		            	if Param.miscellaneous.GapCloser.EGapClos and myHero:CanUseSpell(_E) == READY then
		            		if not unit.dead then
		            			CastSpell(_E, unit)
		            		end
		            	end
		            end, 0.25)
	            end
	        end
	        
	        if isAGapcloserUnitNoTarget[spell.name] and GetDistanceSqr(unit) <= 2000*2000 and (spell.target == nil or (spell.target and spell.target.isMe)) and spell.name ~= "ZedR" then
	        	if Param.miscellaneous.GapCloser.RGapClos and myHero:CanUseSpell(_R) == READY and not RMissile ~= nil then
	        		LogicR(unit)
	        	end
	        	DelayAction(function()
	        		LogicQ(unit)
	        	end, 0.05)
	        	DelayAction(function()
	        		if Param.miscellaneous.GapCloser.EGapClos and myHero:CanUseSpell(_E) == READY then
	        			if not unit.dead then
	        				CastSpell(_E, unit)
	        			end
	        		end
	        	end, 0.25)
	       	end
	    end
	end
end

function OnGainBuff (unit, buff)
	local lastQss = 0
	for i = 1, 1 do
		if not Param.miscellaneous.QuickSS.qsswithscript then return end
			if myHero:getBuff(isABuff) then
				if os.clock() - lastQss < 90 then return end
					for SLOT = ITEM_1, ITEM_6 do
						if myHero:GetSpellData(SLOT).name == "QuicksilverSash" or "itemmercurial" then
							if myHero:CanUseSpell(SLOT) == READY then
								DelayAction(function()
									CastSpell(SLOT)
									lastQss = os.clock()
									EnvoiMessage("QSS => Casted.")
								end, Param.miscellaneous.QuickSS.qssdelay/1000)
							end
						end
					end
				--
			end
		--
	end
end

function OnWndMsg(msg, key)
	if key == 1 then
		if not Param.drawing.disablealldrawings and GetGame().map.shortName == "summonerRift" then
			if Param.drawing.wallmenu.active then
				for i,group in pairs(wallSpots) do
	 				for x, wallSpot in pairs(group.Locations) do
	 					if GetDistance(wallSpot, mousePos) <= Param.drawing.wallmenu.radius and GetDistance(wallSpot) <= 1000 then
	              	      CastSpell(_W, wallSpot.x, wallSpot.z)
	             	   end                                    
	     			end
	        	end
	    	end
		end
	end
end

function OnRemoveBuff(unit, buff)
	if unit and unit.valid and unit.isMe and buff and buff.name == "rebirthcooldown" then
		upoeuf = 1
		EnvoiMessage("Rebirth [(Passive)] is now UP")
	end
	if unit and unit.valid and unit.isMe and buff and buff.name == "rebirth" then
		upoeuf = 0
		cooldown = 1
		DrawText3D(""..cooldown.."", myHero.x-100, myHero.y-50, myHero.z, 20, 0xFFFFFFFF)
		EnvoiMessage("Rebirth [(Passive)] is now DOWN")
	end
	if unit and unit.valid and unit.isMe and buff and buff.name == "rebirthready" then
		startTime = os.clock() + 6
		OeufTimerDraw = 1
		DelayAction(function() OeufTimerDraw = 0 end, 6)
	end
	if buff.name == "recall" and unit.isMe then
		if myHero.level >= 9 then
			if Param.miscellaneous.Starter.TrinketBleu then
				BuyItem(3363)
			end
		end
	end
end


function GenerateTables()

	isABuff = {
		[1]=false,
		[2]=false,
		[3]=false,
		[4]=false,
		[5]=true,
		[6]=false,
		[7]=true,
		[8]=true,
		[9]=true,
		[10]=false,
		[11]=false,
		[12]=false,
		[13]=false,
		[14]=false,
		[15]=false,
		[16]=false,
		[17]=false,
		[18]=false,
		[19]=false,
		[20]=true,
		[21]=true,
		[22]=false,
		[23]=true,
		[24]=true,
		[25]=false,
		[26]=false,
		[27]=false,
		[28]=false,
		[29]=true,
		[30]=false,
		[31]=false
	}

    isAGapcloserUnitTarget = {
        ['AkaliShadowDance']	= {true, Champ = 'Akali', 	spellKey = 'R'},
        ['Headbutt']     	= {true, Champ = 'Alistar', 	spellKey = 'W'},
        ['DianaTeleport']       	= {true, Champ = 'Diana', 	spellKey = 'R'},
        ['IreliaGatotsu']     	= {true, Champ = 'Irelia',	spellKey = 'Q'},
        ['JaxLeapStrike']         	= {true, Champ = 'Jax', 	spellKey = 'Q'},
        ['JayceToTheSkies']       	= {true, Champ = 'Jayce',	spellKey = 'Q'},
        ['MaokaiUnstableGrowth']    = {true, Champ = 'Maokai',	spellKey = 'W'},
        ['MonkeyKingNimbus']  	= {true, Champ = 'MonkeyKing',	spellKey = 'E'},
        ['Pantheon_LeapBash']   	= {true, Champ = 'Pantheon',	spellKey = 'W'},
        ['PoppyHeroicCharge']       = {true, Champ = 'Poppy',	spellKey = 'E'},
        ['QuinnE']       	= {true, Champ = 'Quinn',	spellKey = 'E'},
        ['XenZhaoSweep']     	= {true, Champ = 'XinZhao',	spellKey = 'E'},
        ['blindmonkqtwo']	    	= {true, Champ = 'LeeSin',	spellKey = 'Q'},
        ['FizzPiercingStrike']	    = {true, Champ = 'Fizz',	spellKey = 'Q'},
        ['RengarLeap']	    	= {true, Champ = 'Rengar',	spellKey = 'Q/R'},
        ['YasuoDashWrapper']	    = {true, Champ = 'Yasuo',	spellKey = 'E'},
    }

    isAGapcloserUnitNoTarget = {
        ['AatroxQ']	= {true, Champ = 'Aatrox', 	range = 1000,  	projSpeed = 1200, spellKey = 'Q'},
        ['GragasE']	= {true, Champ = 'Gragas', 	range = 600,   	projSpeed = 2000, spellKey = 'E'},
        ['GravesMove']	= {true, Champ = 'Graves', 	range = 425,   	projSpeed = 2000, spellKey = 'E'},
        ['HecarimUlt']	= {true, Champ = 'Hecarim', 	range = 1000,   projSpeed = 1200, spellKey = 'R'},
        ['JarvanIVDragonStrike']	= {true, Champ = 'JarvanIV',	range = 770,   	projSpeed = 2000, spellKey = 'Q'},
        ['JarvanIVCataclysm']	= {true, Champ = 'JarvanIV', 	range = 650,   	projSpeed = 2000, spellKey = 'R'},
        ['KhazixE']	= {true, Champ = 'Khazix', 	range = 900,   	projSpeed = 2000, spellKey = 'E'},
        ['khazixelong']	= {true, Champ = 'Khazix', 	range = 900,   	projSpeed = 2000, spellKey = 'E'},
        ['LeblancSlide']	= {true, Champ = 'Leblanc', 	range = 600,   	projSpeed = 2000, spellKey = 'W'},
        ['LeblancSlideM']	= {true, Champ = 'Leblanc', 	range = 600,   	projSpeed = 2000, spellKey = 'WMimic'},
        ['LeonaZenithBlade']	= {true, Champ = 'Leona', 	range = 900,  	projSpeed = 2000, spellKey = 'E'},
        ['UFSlash']	= {true, Champ = 'Malphite', 	range = 1000,  	projSpeed = 1800, spellKey = 'R'},
        ['RenektonSliceAndDice']	= {true, Champ = 'Renekton', 	range = 450,  	projSpeed = 2000, spellKey = 'E'},
        ['SejuaniArcticAssault']	= {true, Champ = 'Sejuani', 	range = 650,  	projSpeed = 2000, spellKey = 'Q'},
        ['ShenShadowDash']	= {true, Champ = 'Shen', 	range = 575,  	projSpeed = 2000, spellKey = 'E'},
        ['RocketJump']	= {true, Champ = 'Tristana', 	range = 900,  	projSpeed = 2000, spellKey = 'W'},
        ['slashCast']	= {true, Champ = 'Tryndamere', 	range = 650,  	projSpeed = 1450, spellKey = 'E'},
    }

    isAChampToInterrupt = {
        ['KatarinaR']	= {true, Champ = 'Katarina',	spellKey = 'R'},
        ['GalioIdolOfDurand']	= {true, Champ = 'Galio',	spellKey = 'R'},
        ['Crowstorm']	= {true, Champ = 'FiddleSticks',spellKey = 'R'},
        ['Drain']	= {true, Champ = 'FiddleSticks',spellKey = 'W'},
        ['AbsoluteZero']	= {true, Champ = 'Nunu',	spellKey = 'R'},
        ['ShenStandUnited']	= {true, Champ = 'Shen',	spellKey = 'R'},
        ['UrgotSwap2']	= {true, Champ = 'Urgot',	spellKey = 'R'},
        ['AlZaharNetherGrasp']	= {true, Champ = 'Malzahar',	spellKey = 'R'},
        ['FallenOne']	= {true, Champ = 'Karthus',	spellKey = 'R'},
        ['Pantheon_GrandSkyfall_Jump']	= {true, Champ = 'Pantheon',	spellKey = 'R'},
        ['VarusQ']	= {true, Champ = 'Varus',	spellKey = 'Q'},
        ['CaitlynAceintheHole']	= {true, Champ = 'Caitlyn',	spellKey = 'R'},
        ['MissFortuneBulletTime']	= {true, Champ = 'MissFortune',	spellKey = 'R'},
        ['InfiniteDuress']	= {true, Champ = 'Warwick',	spellKey = 'R'},
        ['LucianR']	= {true, Champ = 'Lucian',	spellKey = 'R'}
    }
end

function Skills()
	SkillQ = { name = "Flash Frost", range = 1100, delay = 0.25, speed = 850, width = 110, ready = false }
	SkillW = { name = "Crystallize", range = 1000, delay = 0.25, speed = math.huge, width = 100, ready = false }
	SkillE = { name = "Frostbite", range = 650, delay = 0.25, speed = 850, width = nil, ready = false }
	SkillR = { name = "Glacial Storm", range = 625, delay = 0.100, speed = math.huge, width = 350, ready = false }
end

local priorityTable = {
 
    AP_Carry = {
        "Annie", "Ahri", "Akali", "Anivia", "Annie", "Brand", "Cassiopeia", "Diana", "Evelynn", "FiddleSticks", "Fizz", "Gragas", "Heimerdinger", "Karthus",
        "Kassadin", "Katarina", "Kayle", "Kennen", "Leblanc", "Lissandra", "Lux", "Malzahar", "Mordekaiser", "Morgana", "Nidalee", "Orianna",
        "Rumble", "Ryze", "Sion", "Swain", "Syndra", "Teemo", "TwistedFate", "Veigar", "Viktor", "Vladimir", "Xerath", "Ziggs", "Zyra", "MasterYi", "VelKoz", "Azir", "Ekko",
    },
    Support = {
        "Alistar", "Blitzcrank", "Janna", "Karma", "Leona", "Lulu", "Nami", "Nunu", "Sona", "Soraka", "Taric", "Thresh", "Zilean", "Braum", "Bard", "TahmKench",
    },
 
    Tank = {
        "Amumu", "Chogath", "DrMundo", "Galio", "Hecarim", "Malphite", "Maokai", "Nasus", "Rammus", "Sejuani", "Shen", "Singed", "Skarner", "Volibear",
        "Warwick", "Yorick", "Zac", "Illaoi", "RekSai",
    },
 
    AD_Carry = {
        "Ashe", "Caitlyn", "Corki", "Draven", "Ezreal", "Graves", "Jayce", "KogMaw", "MissFortune", "Pantheon", "Quinn", "Shaco", "Sivir",
        "Talon", "Tristana", "Twitch", "Urgot", "Varus", "Vayne", "Zed", "Lucian", "Jinx",
 
    },
 
    Bruiser = {
        "Aatrox", "Darius", "Elise", "Fiora", "Gangplank", "Garen", "Irelia", "JarvanIV", "Jax", "Khazix", "LeeSin", "Nautilus", "Nocturne", "Olaf", "Poppy",
        "Renekton", "Rengar", "Riven", "Shyvana", "Trundle", "Tryndamere", "Udyr", "Vi", "MonkeyKing", "XinZhao", "Gnar", "Kindred"
    },
 
}
 
function SetPriority(table, hero, priority)
    for i=1, #table, 1 do
    	if hero.charName:find(table[i]) ~= nil then
        	TS_SetHeroPriority(priority, hero.charName)
        end
    end
end
 
function arrangePrioritys()
    for i, enemy in ipairs(GetEnemyHeroes()) do
        SetPriority(priorityTable.AD_Carry, enemy, 1)
        SetPriority(priorityTable.AP_Carry, enemy, 2)
        SetPriority(priorityTable.Support,  enemy, 3)
        SetPriority(priorityTable.Bruiser,  enemy, 4)
        SetPriority(priorityTable.Tank,     enemy, 5)
    end
end
 
function PriorityOnLoad()
        if heroManager.iCount < 10 then
			EnvoiMessage("Impossible to Arrange Priority Table.. There is not enough champions... (less than 10)")	
        else
            arrangePrioritys()
        end
end

function AutoPotions()
	if (Param.miscellaneous.Pots.potswithscript == false) then return end
		if os.clock() - lastPotion < ActualPotTime then return end
			for SLOT = ITEM_1, ITEM_6 do
				if myHero:GetSpellData(SLOT).name == "RegenerationPotion" then
					ActualPotName = "Health Potion"
					ActualPotTime = 15
					ActualPotData = "RegenerationPotion"
					Usepot()
				elseif myHero:GetSpellData(SLOT).name == "ItemMiniRegenPotion" then
					ActualPotName = "Cookie"
					ActualPotTime = 15
					ActualPotData = "ItemMiniRegenPotion"
					Usepot()
				elseif myHero:GetSpellData(SLOT).name == "ItemCrystalFlaskJungle" then
					ActualPotName = "Hunter's Potion"
					ActualPotTime = 8
					ActualPotData = "ItemCrystalFlaskJungle"
					Usepot()
				elseif myHero:GetSpellData(SLOT).name == "ItemCrystalFlask" then
					ActualPotName = "Refillable Potion"
					ActualPotTime = 12
					ActualPotData = "ItemCrystalFlask"
					Usepot()
				elseif myHero:GetSpellData(SLOT).name == "ItemDarkCrystalFlask" then
					ActualPotName = "Corrupting Potion"
					ActualPotTime = 12
					ActualPotData = "ItemDarkCrystalFlask"
					Usepot()
				else 
				end
			end
		--
	--
end

function Usepot()
	for SLOT = ITEM_1, ITEM_6 do
		if myHero:GetSpellData(SLOT).name == ActualPotData then
			if myHero:CanUseSpell(SLOT) == READY and (myHero.health*100)/myHero.maxHealth < Param.miscellaneous.Pots.potatxhp then
				CastSpell(SLOT)
				lastPotion = os.clock()	
				EnvoiMessage("1x "..ActualPotName.." => Used.")
			end
		end
	end
end

function AutoElixirDuSorcier()
	if (Param.miscellaneous.ElixirduSorcier.elixirwithscript == false) then return end
		if(Param.miscellaneous.ElixirduSorcier.elixironlywithcombo == true) and (Param.Combo.comboKey == false) then return end
			if(Param.miscellaneous.ElixirduSorcier.elixirinfight == true) and (myHero.health*100)/myHero.maxHealth > 80 then return end 
				if os.clock() - lastElixir < 180 then return end
					for SLOT = ITEM_1, ITEM_6 do
						if myHero:GetSpellData(SLOT).name == "ElixirOfSorcery" then
							if myHero:CanUseSpell(SLOT) == READY then
								CastSpell(SLOT)
								lastElixir = os.clock()
								EnvoiMessage("1x Elixir Of Sorcery => Used.")
							end
						end
					end
				--
			--
		--
	--
end

function AutoFrostQuenn()
	if (Param.miscellaneous.ItemSuppBleu.suppbleuwithscript == false) then return end
		if(Param.miscellaneous.ItemSuppBleu.suppbleuchase == true) and not unit ~= nil and GetDistance(unit) <= SkillW.range and not ComboKey  then return end
			if(Param.miscellaneous.ItemSuppBleu.suppbleucombo == true) and (myHero.health*100)/myHero.maxHealth > 90 and not ComboKey then return end 
				if os.clock() - lastFrostQuennCast < 60 then return end
					for SLOT = ITEM_1, ITEM_6 do
						if myHero:GetSpellData(SLOT).name == "ItemWraithCollar" then
							if myHero:CanUseSpell(SLOT) == READY then
								CastSpell(SLOT)
								lastFrostQuennCast = os.clock()
								EnvoiMessage("Frost's Quenn Claim => Casted.")
							end
						end
					end
				--
			--
		--
	--
end

function AutoSeraphin()
	if (Param.miscellaneous.BatonSeraphin.seraphwithscript == false) then return end
		if(Param.miscellaneous.BatonSeraphin.seraphcombo == true) and not ComboKey then return end
			if(myHero.health*100)/myHero.maxHealth > Param.miscellaneous.BatonSeraphin.seraphxlife then return end
				if os.clock() - lastSeraphin < 120 then return end
					for SLOT = ITEM_1, ITEM_6 do
						if myHero:GetSpellData(SLOT).name == "ItemSeraphsEmbrace" then
							if myHero:CanUseSpell(SLOT) == READY then
								DelayAction(function()
									CastSpell(SLOT)
									lastSeraphin = os.clock()
									EnvoiMessage("Seraph's Embrace => Casted.")
								end, Param.miscellaneous.BatonSeraphin.seraphdelay/1000)
							end
						end
					end
				--
			--
		--
	--
end

function AutoEggTp()
	if upoeuf == 1 then
		if Param.exploits.egg.eggactive then
			if (myHero.health*100)/myHero.maxHealth < Param.exploits.egg.eggatxhp then
				if os.clock() - lastTP < ActualTPTime then return end
					local turrets = GetTurrets()
					local targetTurret = nil
					for _, turret in pairs(turrets) do
		       	 		if turret ~= nil and turret.team == player.team then
			   	 			if targetTurret == nil then targetTurret = turret.object end
		           				if turret.object.attackSpeed == 9 then
			       					targetTurret = turret.object
			    				end
		        			end
		    			end
					if targetTurret ~= nil then
						ActualTPTime = 300
						lastTP = os.clock()
						CastSpell(Teleport, targetTurret)
		       	 	end 
		       	--
		    end
		end
	end
end

function AutoBuy()
	if VIP_USER and GetGameTimer() < 60 then
		if Param.miscellaneous.Starter.Doran then
			BuyItem(1056)
		end
		if Param.miscellaneous.Starter.Pots then
			BuyItem(2003)
		end
		if Param.miscellaneous.Starter.Pots then
			BuyItem(2003)
		end
		if Param.miscellaneous.Starter.Trinket then
			BuyItem(3340)
		end
	end
end

function AutoLvlSpell()
 	if VIP_USER and os.clock()-Last_LevelSpell > 0.5 then
 		if Param.miscellaneous.LVL.Enable then
	    	autoLevelSetSequence(levelSequence)
	    	Last_LevelSpell = os.clock()
	    elseif not Param.miscellaneous.LVL.Enable then
	    	autoLevelSetSequence(nil)
	    	Last_LevelSpell = os.clock()+10
	    end
  	end
end

function AutoLvlSpellCombo()
	if Param.miscellaneous.LVL.Combo == 1 then
		levelSequence =  { 1,3,2,3,3,4,3,1,3,1,4,1,1,2,2,4,2,2}
	elseif Param.miscellaneous.LVL.Combo == 2 then			
		levelSequence =  { 1,3,3,2,3,4,3,1,3,1,4,1,1,2,2,4,2,2}
	else 
		return 
	end
end

wallSpots = {
	worksWell = {
		Locations = { 
					{ x = 5050.10,y=5,z= 10514.81},
					{ x = 4692,  y = -71,z =10032},
					{ x = 3652,  y = -5, z = 9320},
					{ x = 3116,  y = 50, z = 9268},
					{ x = 2712,  y = 54, z =10044},
					{ x = 2290,  y = 52, z = 9738},
					{ x = 2302,  y = 51, z = 8810},
					{ x = 2650,  y = 51, z = 8220},
					{ x = 2960,  y = 51, z = 7670},
					{ x = 2418,  y = 50, z = 7448},
					{ x = 2692,  y = 52, z = 6962},
					{ x = 2624,  y = 57, z = 6344},
					{ x = 2788,  y = 53, z = 5672},
					{ x = 2398,  y = 52, z = 5284},
					{ x = 1702,  y = 54, z = 5326},
					{ x = 1188,  y = 110, z =4912},
					{ x = 1512,  y = 95, z = 4588},
					{ x = 800,  y = 95, z =  4442},
					{ x = 704,  y = 95, z =  3568},
					{ x = 1202,  y = 95, z = 3962},
					{ x = 1874,  y = 95, z = 3790},
					{ x = 2696,  y = 83, z = 4736},
					{ x = 2806,  y = 95, z = 3660},
					{ x = 3452,  y = 95, z = 3472},
					{ x = 3634,  y = 95, z = 2752},
					{ x = 4866,  y = 63, z = 2820},
					{ x = 4146,  y = 95, z = 2936},
					{ x = 4466,  y = 95, z = 2384},
					{ x = 4366,  y = 95, z = 2058},
					{ x = 4130,  y = 95, z = 1808},
					{ x = 3686,  y = 95, z = 1826},
					{ x = 2754,  y = 95, z = 1520},
					{ x = 1950,  y = 95, z = 2010},
					{ x = 840,  y = 95, z =  1754},
					{ x = 690,  y = 109, z = 1280},
					{ x = 1046,  y = 132, z =1036},
					{ x = 1276,  y = 118, z = 712},
					{ x = 1878,  y = 95, z =  956},
					{ x = 1196,  y = 54, z = 5732},
					{ x = 1094,  y = 52, z = 6638},
					{ x = 1542,  y = 52, z = 6298},
					{ x = 1424,  y = 52, z = 6808},
					{ x = 1292,  y = 52, z = 7382},
					{ x = 1860,  y = 51, z = 7708},
					{ x = 1238,  y = 52, z = 8136},
					{ x = 1236,  y = 52, z = 8980},
					{ x = 1866,  y = 52, z = 9566},
					{ x = 1462,  y = 52, z =10414},
					{ x = 1450,  y = 52, z =10790},
					{ x = 974,  y = 52, z = 10606},
					{ x = 1434,  y = 52, z =11536},
					{ x = 2758,  y = 28, z =11958},
					{ x = 3036,  y = -64, z=11614},
					{ x = 3938,  y = -29, z=11342},
					{ x = 3466,  y = -66, z=10778},
					{ x = 3696,  y = -68, z=10252},
					{ x = 4452,  y = 56, z =11806},
					{ x = 4630, y = 56, z = 12456},
					{ x = 3938,  y = 56, z = 12722},
					{ x = 4362,  y = 52, z =13414},
					{ x = 5630,  y = 52, z =12734},
					{ x = 6130,  y = 54, z =12526},
					{ x = 6474,  y = 56, z =12314},
					{ x = 8042,  y = 50, z = 1830},
					{ x = 6914,  y = 49, z = 1640},
					{ x = 6900,  y = 49, z = 1036},
					{ x = 6142,  y = 50, z = 1822},
					{ x = 5212,  y = 52, z = 1892},
					{ x = 5238,  y = 51, z = 2526},
					{ x = 4588,  y = 95, z = 1494},
					{ x = 3916,  y = 95, z = 1214},
					{ x = 4278,  y = 95, z =  784},
					{ x = 3456,  y = 95, z =  774},
					{ x = 4460,  y = 95, z = 1246},
					{ x = 5556,  y = 51, z = 3556},
					{ x = 6036,  y = 49, z = 4232},
					{ x = 6586,  y = 48, z = 4692},
					{ x = 5916,  y = 50, z = 5070},
					{ x = 6270,  y = 48, z = 4842},
					{ x = 6872,  y = 48, z = 4360},
					{ x = 7128,  y = 51, z = 3798},
					{ x = 7404,  y = 52, z = 3074},
					{ x = 7552,  y = 52, z = 2438},
					{ x = 8508,  y = 54, z = 3448},
					{ x = 8836,  y = 53, z = 4034},
					{ x = 9154,  y = 54, z = 3540},
					{ x = 1494,  y = 95, z = 2884},
					{ x = 1052,  y = 95, z = 2292},
					{ x = 5134,  y = 51, z = 3138},
					{ x = 4974,  y = 50, z = 3654},
					{ x = 4684,  y = 50, z = 4030},
					{ x = 4046,  y = 113, z =4156},
					{ x = 3774,  y = 95, z = 3808},
					{ x = 4044,  y = 95, z = 3566},
					{ x = 3476,  y = 95, z = 4136},
					{ x = 3838,  y = 52, z = 4840},
					{ x = 3050,  y = 53, z = 5134},
					{ x = 3150,  y = 51, z = 7226},
					{ x = 3276,  y = 51, z = 6794},
					{ x = 3778,  y = 52, z = 6336},
					{ x = 3992,  y = 52, z = 5986},
					{ x = 4814,  y = 51, z = 6008},
					{ x = 3936,  y = 50, z = 7260},
					{ x = 4754,  y = 51, z = 7516},
					{ x = 5154,  y = 51, z = 7748},
					{ x = 5748,  y = 51, z = 7448},
					{ x = 6140,  y = 51, z = 7102},
					{ x = 4494,  y = -65, z =9556},
					{ x = 2400,  y = 51, z = 9430},
					{ x = 3544,  y = 51, z = 8636},
					{ x = 976,  y = 52, z = 10288},
					{ x = 3296,  y = 51, z = 8124},
					{ x = 3636,  y = 51, z = 8034},
					{ x = 4898,  y = -13, z =8542},
					{ x = 4694,  y = 50, z = 7966},
					{ x = 4484,  y = 50, z = 7218},
					{ x = 4740,  y = 50, z = 6816},
					{ x = 4652,  y = 50, z = 6406},
					{ x = 5124,  y = 50, z = 4958},
					{ x = 4938,  y = 50, z = 4694},
					{ x = 4668,  y = 50, z = 5100},
					{ x = 6048,  y = 50, z = 3564},
					{ x = 6374,  y = 50, z = 3092},
					{ x = 6328,  y = 52, z = 2582},
					{ x = 6134,  y = 52, z = 2308},
					{ x = 6906,  y = 52, z = 2798},
					{ x = 8420,  y = 50, z = 2496},
					{ x = 8902,  y = 49, z = 2402},
					{ x = 10302,  y = 49, z =2458},
					{ x = 10868,  y = 49, z =1936},
					{ x = 9272,  y = 63, z = 1988},
					{ x = 8554,  y = 49, z = 1230},
					{ x = 9984,  y = 51, z = 1252},
					{ x = 10322,  y = 51, z =1058},
					{ x = 10636,  y = 49, z = 962},
					{ x = 12076,  y = 33, z =3016},
					{ x = 13332,  y = 51, z =3158},
					{ x = 13364,  y = 52, z =4466},
					{ x = 12892,  y = 51, z =5266},
					{ x = 12408,  y = 51, z =4938},
					{ x = 11916,  y = 52, z =5080},
					{ x = 11560,  y = 49, z =5878},
					{ x = 11298,  y = 50, z =6170},
					{ x = 9902,  y = -19, z =6264},
					{ x = 8618,  y = -56, z =5584},
					{ x = 7594,  y = 48, z = 4994},
					{ x = 7018,  y = 48, z = 5190},
					{ x = 7104,  y = 52, z = 6286},
					{ x = 6162,  y = 51, z = 6080},
					{ x = 5974,  y = 51, z = 6458},
					{ x = 5748,  y = 51, z = 6288},
					{ x = 6928,  y = 31, z = 7868},
					{ x = 7208,  y = 25, z = 8088},
					{ x = 6574,  y = 24, z = 7606},
					{ x = 6526,  y = -71, z =8318},
					{ x = 6032,  y = -71, z =8690},
					{ x = 6214,  y = -10, z =9272},
					{ x = 6238,  y = 53, z = 9960},
					{ x = 6058,  y = 55, z =10456},
					{ x = 6194,  y = 56, z =11256},
					{ x = 708,  y = 183, z = 644},
					{ x = 5580,  y = 50, z = 1210},
					{ x = 6456,  y = 49, z = 1168},
					{ x = 7708,  y = 49, z = 1196},
					{ x = 9550,  y = 49, z = 2258},
					{ x = 10736,  y = 49, z = 2332},
					{ x = 10426,  y = 49, z = 2912},
					{ x = 10014,  y = 52, z = 3152},
					{ x = 10624,  y = 31, z = 3390},
					{ x = 10988,  y = -48, z = 3514},
					{ x = 11554,  y = -69, z = 3528},
					{ x = 11530,  y = 50, z = 1448},
					{ x = 10378,  y = 50, z = 1492},
					{ x = 10162,  y = -71, z = 4822},
					{ x = 9818,  y = -71, z = 4350},
					{ x = 10164,  y = -62, z = 5396},
					{ x = 8632,  y = 52, z = 4864},
					{ x = 7944,  y = 52, z = 5652},
					{ x = 8450,  y = -71, z = 6478},
					{ x = 7660,  y = -12, z = 6456},
					{ x = 8074,  y = -46, z = 6734},
					{ x = 8372,  y = -37, z = 7008},
					{ x = 8834,  y = 51, z = 7620},
					{ x = 9286,  y = 53, z = 7260},
					{ x = 9768,  y = 51, z = 7136},
					{ x = 10168,  y = 51, z = 6818},
					{ x = 10134,  y = 50, z = 6530},
					{ x = 10092,  y = 51, z = 7402},
					{ x = 10580,  y = 51, z = 7582},
					{ x = 10228,  y = 57, z = 8546},
					{ x = 9944,  y = 50, z = 8923},
					{ x = 10742,  y = 63, z = 8924},
					{ x = 11046,  y = 64, z = 8786},
					{ x = 11046,  y = 60, z = 8450},
					{ x = 11758,  y = 52, z = 7570},
					{ x = 12176,  y = 52, z = 7776},
					{ x = 11562,  y = 52, z = 7978},
					{ x = 12380,  y = 51, z = 7386},
					{ x = 12210,  y = 52, z = 8510},
					{ x = 12018,  y = 51, z = 9206},
					{ x = 11744,  y = 52, z = 9760},
					{ x = 12436,  y = 52, z = 9612},
					{ x = 13036,  y = 52, z = 9566},
					{ x = 12936,  y = 51, z = 7126},
					{ x = 11286,  y = 52, z = 7660},
					{ x = 11876,  y = 51, z = 7172},
					{ x = 11610,  y = 51, z = 6770},
					{ x = 12522,  y = 51, z = 5380},
					{ x = 12582,  y = 54, z = 5936},
					{ x = 12290,  y = 51, z = 6540},
					{ x = 12526,  y = 51, z = 5218},
					{ x = 13858,  y = 53, z = 4354},
					{ x = 13872,  y = 52, z = 4685},
					{ x = 11030,  y = 51, z = 6936},
					{ x = 6880,  y = 52, z = 6958},
					{ x = 6596,  y = 51, z = 6690},
					{ x = 7862,  y = 53, z = 7772},
					{ x = 7368,  y = 54, z = 7286},
					{ x = 7674,  y = 52, z = 8560},
					{ x = 6888,  y = 52, z = 9184},
					{ x = 7186,  y = 53, z = 9852},
					{ x = 7834,  y = 51, z = 9728},
					{ x = 8270,  y = 49, z = 10226},
					{ x = 8906,  y = 50, z = 9800},
					{ x = 8894,  y = 50, z = 11012},
					{ x = 7436,  y = 49, z = 11668},
					{ x = 7100,  y = 54, z = 11528},
					{ x = 7138,  y = 56, z = 10906},
					{ x = 8754,  y = 54, z = 12906},
					{ x = 9596,  y = 52, z = 13000},
					{ x = 9624,  y = 52, z = 12348},
					{ x = 9650,  y = 52, z = 11730},
					{ x = 3102,  y = 52, z = 13282},
					{ x = 4162,  y = 52, z = 13858},
					{ x = 4452,  y = 52, z = 13882},
					{ x = 5960,  y = 52, z = 13620},
					{ x = 6982,  y = 52, z = 13612},
					{ x = 7782,  y = 52, z = 13388},
					{ x = 8082,  y = 52, z = 13396},
					{ x = 7904,  y = 52, z = 13846},
					{ x = 1224,  y = 95, z = 4458},
					{ x = 2162,  y = 95, z = 4376},
					{ x = 2864,  y = 95, z = 4258},
					{ x = 5172,  y = 52, z = 13576},
					{ x = 6776,  y = 55, z = 12978},
					{ x = 6992,  y = 56, z = 12672},
					{ x = 7420,  y = 56, z = 12310},
					{ x = 7810,  y = 56, z = 12078},
					{ x = 8248,  y = 56, z = 12068},
					{ x = 8606,  y = 56, z = 12360},
					{ x = 8510,  y = 55, z = 11780},
					{ x = 8760,  y = 53, z = 11340},
					{ x = 9254,  y = 51, z = 11236},
					{ x = 7952,  y = 50, z = 10488},
					{ x = 7870,  y = 50, z = 10182},
					{ x = 7678,  y = 53, z = 11116},
					{ x = 9068,  y = 54, z = 8618},
					{ x = 8880,  y = 54, z = 8408},
					{ x = 8798,  y = -71, z = 6214},
					{ x = 8182,  y = 52, z = 5176},
					{ x = 11330,  y = -71, z = 4222},
					{ x = 10912,  y = -65, z = 4820},
					{ x = 11222,  y = -2, z = 5594},
					{ x = 11432,  y = 58, z = 8484},
					{ x = 10150,  y = 51, z = 7948},
					{ x = 6624,  y = 53, z = 9566},
					{ x = 7066,  y = 49, z = 1466},
					{ x = 6774,  y = 49, z = 1462},
					{ x = 7834,  y = 52, z = 3372},
					{ x = 7694,  y = 54, z = 3914},
					{ x = 7012,  y = 48, z = 4774},
					{ x = 7530,  y = 52, z = 5936},
					{ x = 5368,  y = -71, z = 8766},
					{ x = 5208,  y = -71, z = 9160},
					{ x = 5358,  y = -71, z = 9472},
					{ x = 5992,  y = 55, z = 10880},
					{ x = 5712,  y = 56, z = 11284},
					{ x = 5064,  y = 56, z = 11562},
					{ x = 3316,  y = -70, z = 11290},
					{ x = 2094,  y = 52, z = 12502},
					{ x = 8712,  y = 50, z = 10450},
					{ x = 8576,  y = 50, z = 9940},
					{ x = 9358,  y = 53, z = 9296},
					{ x = 12558,  y = 51, z = 2446},
					{ x = 12010,  y = 50, z = 1772},
					{ x = 13500,  y = 51, z = 3672},
					{ x = 11774,  y = -70, z = 4092},
					{ x = 13560,  y = 54, z = 6216},
					{ x = 13558,  y = 52, z = 5608},
					{ x = 11784,  y = 52, z = 5630},
					{ x = 10965,  y = 52, z = 10046},
					{ x = 13556,  y = 52, z = 6914},
					{ x = 13604,  y = 52, z = 7480},
					{ x = 13318,  y = 52, z = 8078},
					{ x = 13310,  y = 52, z = 8374},
					{ x = 13856,  y = 52, z = 8158},
					{ x = 13638,  y = 52, z = 9122},
					{ x = 13618,  y = 108, z = 9996},
					{ x = 12092,  y = 82, z = 10142},
					{ x = 13572,  y = 91, z = 10406},
					{ x = 14022,  y = 91, z = 10532},
					{ x = 13614,  y = 91, z = 10934},
					{ x = 13242,  y = 91, z = 10378},
					{ x = 12960,  y = 91, z = 11150},
					{ x = 12542,  y = 91, z = 10534},
					{ x = 12750,  y =91 , z = 12824},
					{ x = 13738,  y = 91, z = 12582},
					{ x = 12526,  y = 91, z = 13834},
					{ x = 13502,  y = 123, z = 14032},
					{ x = 13724,  y = 118, z = 13762},
					{ x = 14016,  y = 119, z = 13534},
					{ x = 14032,  y = 165, z = 14076},
					{ x = 11020,  y = 91, z = 11104},
					{ x = 10734,  y = 97, z = 10780},
					{ x = 9928,  y = 52, z = 11126},
					{ x = 10030,  y = 81, z = 12146},
					{ x = 10320,  y = 96, z = 13642},
					{ x = 9850,  y = 109, z = 13642},
					{ x = 8914,  y = 52, z = 13600},
					{ x = 10834,  y = 91, z = 13644},
					{ x = 12012,  y = 91, z = 11254},
					{ x = 11140,  y = 91, z = 12066},
					{ x = 11046,  y = 91, z = 13026},
					{ x = 11202,  y = 91, z = 14120},
					{ x = 14080,  y = 91, z = 11286},
					{ x = 8222,  y = 52, z = 8092},
					{ x = 9654,  y = 51, z = 9994},
					{ x = 9878,  y = 52, z = 10210},
					{ x = 10138,  y = 52, z = 9800},
					{ x = 11934,  y = 91, z = 10648},
					{ x = 10604,  y = 91, z = 12018},
					{ x = 10402,  y = 91, z = 12716},
					{ x = 10482,  y = 91, z = 14050},
					{ x = 10100,  y = 101, z = 13958},
					{ x = 10132,  y = 100, z = 13388},
					{ x = 10722,  y = 91, z = 11298},
					{ x = 11200,  y = 91, z = 10808},
					},
 	},
}

function OnNewPath(unit,startPos,endPos,isDash,dashSpeed,dashGravity,dashDistance)
	if isDash and myHero:CanUseSpell(_W) == READY and Param.miscellaneous.WdansR then
		if GetDistance(startPos, endPos) < 0.55 * dashSpeed then
			castPos = Vector(startPos) + (Vector(endPos) - Vector(startPos)):normalized() * 0.55 * dashSpeed
		else
			castPos = Vector(startPos) + (Vector(endPos) - Vector(startPos)):normalized() * (dashDistance + 50)
		end
			
		if AngleDifference(myHero, startPos, castPos) < 45 and GetDistance(castPos) > 50 and GetDistance(castPos) < 500 then
			CastSpell(_W, castPos.x, castPos.z)
		end
	end
end

function AngleDifference(from, p1, p2)
	local p1Z = p1.z - from.z
	local p1X = p1.x - from.x
	local p1Angle = math.atan2(p1Z , p1X) * 180 / math.pi
	
	local p2Z = p2.z - from.z
	local p2X = p2.x - from.x
	local p2Angle = math.atan2(p2Z , p2X) * 180 / math.pi
	
	return math.sqrt((p1Angle - p2Angle) ^ 2)
end

function FindBestCircle(target, range, radius)
	if Param.prediction.n1 == 1 then
		local points = {}
		
		local rgDsqr = (range + radius) * (range + radius)
		local diaDsqr = (radius * 2) * (radius * 2)

		local Position = VP:GetPredictedPos(target, 0.25)

		table.insert(points,Position)
		
		for i, enemy in ipairs(GetEnemyHeroes()) do
			if enemy.networkID ~= target.networkID and not enemy.dead and GetDistanceSqr(enemy) <= rgDsqr and GetDistanceSqr(target,enemy) < diaDsqr then
				local Position = VP:GetPredictedPos(enemy, 0.25)
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
end

function PointsOfIntersection(A, B, C, R)
	local D, E, F, G = {}, {}, {}, {}

	LAB = math.sqrt((B.x-A.x)^ 2+(B.y-A.y)^ 2)
	D.x = (B.x-A.x)/LAB
	D.y = (B.y-A.y)/LAB
	t = D.x*(C.x-A.x) + D.y*(C.y-A.y)
	E.x = t*D.x+A.x
	E.y = t*D.y+A.y
	LEC = math.sqrt( (E.x-C.x)^ 2+(E.y-C.y)^ 2 )
	if LEC < R then
		dt = math.sqrt( R^ 2 - LEC^ 2)
		F.x = (t-dt)*D.x + A.x
		F.y = (t-dt)*D.y + A.y
		G.x = (t+dt)*D.x + A.x
		G.y = (t+dt)*D.y + A.y
	end
	
	return F, G
end

DelayAction(function() EnvoiMessage("You have to rightclick on the circles now to cast a Wall.") end, 10)

function Immune(unit)
    for i = 1, unit.buffCount do
        local tBuff = unit:getBuff(i)
        if BuffIsValid(tBuff) then
            if buffs[tBuff.name] then
                return true
            end
        end
    end
    return false
end
