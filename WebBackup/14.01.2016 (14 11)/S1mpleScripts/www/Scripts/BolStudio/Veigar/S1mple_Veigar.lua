--[[
   _____ __                 _       __      __  _                    _              _____ __                 _       _____           _       _       
  / ____/_ |               | |      \ \    / / (_)                  | |            / ____/_ |               | |     / ____|         (_)     | |      
 | (___  | |_ __ ___  _ __ | | ___   \ \  / /__ _  __ _  __ _ _ __  | |__  _   _  | (___  | |_ __ ___  _ __ | | ___| (___   ___ _ __ _ _ __ | |_ ___ 
  \___ \ | | '_ ` _ \| '_ \| |/ _ \   \ \/ / _ \ |/ _` |/ _` | '__| | '_ \| | | |  \___ \ | | '_ ` _ \| '_ \| |/ _ \\___ \ / __| '__| | '_ \| __/ __|
  ____) || | | | | | | |_) | |  __/    \  /  __/ | (_| | (_| | |    | |_) | |_| |  ____) || | | | | | | |_) | |  __/____) | (__| |  | | |_) | |_\__ \
 |_____/ |_|_| |_| |_| .__/|_|\___|     \/ \___|_|\__, |\__,_|_|    |_.__/ \__, | |_____/ |_|_| |_| |_| .__/|_|\___|_____/ \___|_|  |_| .__/ \__|___/
                     | |                           __/ |                    __/ |                     | |                             | |            
                     |_|                          |___/                    |___/                      |_|                             |_|            
	
	Credits:
		michelangelo for the Banner (http://forum.botoflegends.com/user/681446-)

License Disclaimer:
	This Script is licensed under:
		Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
		Read the License here:
		http://creativecommons.org/licenses/by-nc-sa/4.0/

		TL;DR:
		You may:
			Copy and redistribute the Script
			Modify the Script as you like
		You have to:
			Give credit to the Original Owner (S1mpleScripts)
		You may not:
			Use this Script for Commercial Purpoeses
			Change the License of any Part of this Script
]]--

myHero = GetmyHero
if myHero.charName ~= "Veigar" then return end

-- http://bol-tools.com/ tracker
assert(load(Base64Decode("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"), nil, "bt", _ENV))()
TrackerLoad("IGubXhWNeqO2wr6o")


if _ENV.FILE_NAME ~= "S1mple_Veigar.lua" then
	print("[S1mple_Veigar] <font color=\"#570BB2\">Please rename S1mple_Veigar's .lua File</font>")
	print("[S1mple_Veigar] <font color=\"#570BB2\">too: S1mple_Veigar.lua</font>")
	return
end

if not _G.UPLloaded then
  if FileExist(LIB_PATH .. "/UPL.lua") then
    require("UPL")
    _G.UPL = UPL()
  else 
    print("Downloading UPL, please don't press F9")
    DelayAction(function() DownloadFile("https://raw.github.com/nebelwolfi/BoL/master/Common/UPL.lua".."?rand="..math.random(1,10000), LIB_PATH.."UPL.lua", function () print("Successfully downloaded UPL. Press F9 twice.") end) end, 3) 
    return
  end
end
--Localize LUA Core functions
local sqrt, max, deg, asin, cos, pi, floor, ceil, sin, huge, random, round = math.sqrt, math.max, math.deg, math.asin, math.cos, math.pi, math.floor, math.ceil, math.sin, math.huge, math.random, math.round

--Initialize Global Vars
	local autoupdate = true --Change to false if you don't wan't autoupdates
	local LocalVersion = "3.5"
	local name = "S1mple_Veigar"
	local VeigarQ =  { speed = 2000, delay = .25, range = 950, width = 50, collision = false, aoe = false, type = "linear" }
	local VeigarW =  { speed = huge, delay = 1.25, range = 900, width = 112.5, collision = false, aoe = true, type = "circular" }
	local VeigarE =  { speed = huge, delay = .5, range = 700, width = 375, collision = false, aoe = true, type = "circular" }
	local VeigarR =  { speed = huge, delay = .25, range = 650, width = 0, collision = false, aoe = false, type = "NOT A SKILLSHOT" }
	local ts = TargetSelector(TARGET_LESS_CAST, 2000, DAMAGE_MAGIC, true)
	local c_red = ARGB(255, 255,0,0)
	local c_green = ARGB(255,9,255,0)
	local c_blue = ARGB(255,51,51,255)
	local Veigar = scriptConfig("S1mple_Veigar", "s1mple_veigar")
	local updated = false
	local CuTarget = nil

--END INI VARS

--Keydown Fix
-- Developer: PvPSuite (http://forum.botoflegends.com/user/76516-pvpsuite/)
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
--End Keydown Fix

function OnLoad()
	findupdates()
	if updated == true then return end
	Config()
	findorbwalker()
	CTarget()
	registerUPL()

	p("Loaded "..name)
end

local lesstick = os.clock()
function OnTick()
	if not Veigar then return end
	if updated == true then return end
	
	if os.clock() >= lesstick + 10 then
		ChkConfig()
		lesstick = os.clock()
	end
	
	Harras()
	Combo()
	Laneclear()

end


function OnDraw()
	if not Veigar then return end
	if updated == true then
		DrawText("S1mple_Veigar has updated, please reload (2xF9)", 30,50,50,4294967295)
	end
	if updated == false then
		if Veigar.draws.qrange then
			DrawCircle3D(myHero.x, myHero.y, myHero.z, VeigarQ.range, Veigar.draws.lfcthickness, ARGB(Veigar.draws.qcolor[1],Veigar.draws.qcolor[2],Veigar.draws.qcolor[3],Veigar.draws.qcolor[4]), Veigar.draws.lfcresolution)
		end
		if Veigar.draws.erange then
			DrawCircle3D(myHero.x, myHero.y, myHero.z, VeigarW.range, Veigar.draws.lfcthickness, ARGB(Veigar.draws.wcolor[1],Veigar.draws.wcolor[2],Veigar.draws.wcolor[3],Veigar.draws.wcolor[4]), Veigar.draws.lfcresolution)
		end
		if Veigar.draws.wrange then
			DrawCircle3D(myHero.x, myHero.y, myHero.z, VeigarE.range, Veigar.draws.lfcthickness, ARGB(Veigar.draws.ecolor[1],Veigar.draws.ecolor[2],Veigar.draws.ecolor[3],Veigar.draws.ecolor[4]), Veigar.draws.lfcresolution)
		end
		if Veigar.draws.rrange then
			DrawCircle3D(myHero.x, myHero.y, myHero.z, VeigarR.range, Veigar.draws.lfcthickness, ARGB(Veigar.draws.rcolor[1],Veigar.draws.rcolor[2],Veigar.draws.rcolor[3],Veigar.draws.rcolor[4]), Veigar.draws.lfcresolution)
		end
		if Veigar.draws.rdmg and myHero:CanUseSpell(_R) == 0 then
			local enemys = GetEnemyHeroes()
			for _,v in pairs(enemys) do
				if GetDistance(v, myHero) <= VeigarR.range+300 and v.visible and v.dead == false then
					local lvl = myHero:GetSpellData(_R).level
					local ap = GetAp(myHero)
					local eap = GetAp(v)
					local dmg = 125 + lvl*125 + ap + (eap * 0.8)
					local dmgp = dmg * (100/(100+v.magicArmor))
					dmgp = dmgp - (dmgp * (Veigar.adv.r.buffer/100))
					local barPos = GetUnitHPBarPos(v) --THANKS Jori
					local barOffset = GetUnitHPBarOffset(v)
					do -- For some reason the x offset never exists
						local t = {
							["Darius"] = -0.05,
							["Renekton"] = -0.05,
							["Sion"] = -0.05,
							["Thresh"] = 0.03,
						}
						barOffset.x = t[v.charName] or 0
					end
					local baseX = barPos.x - 69 + barOffset.x * 150 + Veigar.draws.rdmgoffX
					local baseY = barPos.y + barOffset.y * 50 + 12.5 + Veigar.draws.rdmgoffY
					if dmgp <= v.health then
						DrawTextA(round(dmgp).."",18,baseX,baseY,ARGB(255,0,255,0))
					else
						DrawTextA("Killable",18,baseX,baseY,ARGB(255,255,0,0))
					end
				end
			end
		end
		if Veigar.other.debug then
			local target = GetTarget()
			if target then
				local lvl = myHero:GetSpellData(_R).level
				local ap = GetAp(myHero)
				local eap = GetAp(target)
				local dmg = 125 + lvl*125 + ap + (eap * 0.8)
				local dmgp = dmg * (100/(100+target.magicArmor))
				dmgpwb = dmgp - (dmgp * (Veigar.adv.r.buffer/100))
				local overkillperc = round(perc(dmgpwb, target.health))-100

				DrawTextA("Damage wo Mres: "..dmg, 15, 200,200,ARGB(255,255,255,255))
				DrawTextA("Damage w Mres: "..dmgp, 15, 200,220,ARGB(255,255,255,255))
				DrawTextA("Enemy Life: "..target.health, 15, 200,240,ARGB(255,255,255,255))
				DrawTextA("My AP: "..ap, 15, 200,260,ARGB(255,255,255,255))
				DrawTextA("Target AP: "..eap, 15, 200,280,ARGB(255,255,255,255))
				DrawTextA("Ult lvl: "..myHero:GetSpellData(_R).level, 15, 200,300,ARGB(255,255,255,255))
				DrawTextA("M res: "..100/(100+target.magicArmor)*100, 15, 200,320,ARGB(255,255,255,255))
				DrawTextA("Damage w Mres+Buffer: "..dmgpwb, 15, 200,340,ARGB(255,255,255,255))
				DrawTextA("Target Health: "..target.health, 15, 200,360,ARGB(255,255,255,255))
				DrawTextA("Overkill by "..overkillperc.." Percentage", 15, 200,380,ARGB(255,255,255,255))
				--

				DrawTextA("=========== Buffs ===========", 15, 200,420,ARGB(255,255,255,255))
				local n = 1
				for i = 1, target.buffCount do
					local tBuff = target:getBuff(i)
					if BuffIsValid(tBuff) then
						DrawTextA(tBuff.name, 15, 200,420+(n*20),ARGB(255,255,255,255))
						n = n+1
					end
				end
				local offset = n*20+440
				DrawTextA("=========== Target Data ===========", 15, 200,offset,ARGB(255,255,255,255))

				DrawTextA("CanAttack: ", 15, 200,offset+20,ARGB(255,255,255,255))
				DrawTextA(target.canAttack, 15, 290,offset+20,ARGB(255,255,255,255))
				--

			end

			if myHero:CanUseSpell(_Q) ~= 0 then return end
			local casted = false
			for i = 1, objManager.maxObjects do
				if casted == false then
        			local object = objManager:GetObject(i)
        			if object and object.valid and object.type == "obj_AI_Minion" and object.team ~= myHero.team then
        				local dst = GetDistance(object, myHero)
        				if dst < VeigarQ.range then
        					--local t = dst / VeigarQ.speed
        					--print(t)
							--local health = VPred:GetPredictedHealth(object, t, VeigarQ.delay)
							local health = object.health
							local dmg = 30+(myHero:GetSpellData(_Q).level*40)+(GetAp(myHero)*0.6)
							if dmg > health then
								DrawText3D(dmg.." : "..health, object.x, object.y, object.z, 18, ARGB(255,255,0,0))
							end
						end
					end
				end
			end
		end
	end
end
--[[
SCRIPT_PARAM_ONOFF = 1
SCRIPT_PARAM_ONKEYDOWN = 2
SCRIPT_PARAM_ONKEYTOGGLE = 3
SCRIPT_PARAM_SLICE = 4
SCRIPT_PARAM_INFO = 5
SCRIPT_PARAM_COLOR = 6
SCRIPT_PARAM_LIST = 7
]]

--[[==============================Start Config==============================]]--

function Config()
	
	Veigar:addSubMenu("Spell Settings", "adv")
		Veigar.adv:addSubMenu("Q Settings", "q")

			Veigar.adv.q:addParam("sec1", "Combo Mode Settings", SCRIPT_PARAM_INFO, "")
			Veigar.adv.q:addParam("combocast", "Cast in Combo Mode",SCRIPT_PARAM_ONOFF, true)
			Veigar.adv.q:addParam("combominmana", "Minimum Mana to Cast in Combo Mode %",SCRIPT_PARAM_SLICE, 0, 0, 100, 1)
			Veigar.adv.q:addParam("combohs", "Hitchance",SCRIPT_PARAM_SLICE, 2, 0, 5, 1)

			Veigar.adv.q:addParam("sec2", "Harras Mode Settings", SCRIPT_PARAM_INFO, "")
			Veigar.adv.q:addParam("harrascast", "Cast in Harras Mode",SCRIPT_PARAM_ONOFF, true)
			Veigar.adv.q:addParam("harrasminmana", "Minimum Mana to Cast in Harras Mode %",SCRIPT_PARAM_SLICE, 0, 0, 100, 1)
			Veigar.adv.q:addParam("harrashs", "Hitchance",SCRIPT_PARAM_SLICE, 2, 0, 5, 1)

			Veigar.adv.q:addParam("sec3", "Laneclear Mode Settings", SCRIPT_PARAM_INFO, "")
			Veigar.adv.q:addParam("laneclearcast", "Cast in Laneclear Mode",SCRIPT_PARAM_ONOFF, true)
			Veigar.adv.q:addParam("laneclearminmana", "Minimum Mana to Cast in Laneclear Mode %",SCRIPT_PARAM_SLICE, 0, 0, 100, 1)
			Veigar.adv.q:addParam("laneclearhs", "Hitchance",SCRIPT_PARAM_SLICE, 2, 0, 5, 1)

			Veigar.adv.q:addParam("sec4", "Other Settings", SCRIPT_PARAM_INFO, "")
			Veigar.adv.q:addParam("qallowhit", "Only Cast if clear View to Enemy",SCRIPT_PARAM_ONOFF, false)


		Veigar.adv:addSubMenu("W Settings", "w")
			Veigar.adv.w:addParam("sec1", "Combo Mode Settings", SCRIPT_PARAM_INFO, "")
			Veigar.adv.w:addParam("combocast", "Cast in Combo Mode",SCRIPT_PARAM_ONOFF, true)
			Veigar.adv.w:addParam("combominmana", "Minimum Mana to Cast in Combo Mode %",SCRIPT_PARAM_SLICE, 0, 0, 100, 1)
			Veigar.adv.w:addParam("combohs", "Hitchance",SCRIPT_PARAM_SLICE, 2, 0, 5, 1)

			Veigar.adv.w:addParam("sec2", "Harras Mode Settings", SCRIPT_PARAM_INFO, "")
			Veigar.adv.w:addParam("harrascast", "Cast in Harras Mode",SCRIPT_PARAM_ONOFF, true)
			Veigar.adv.w:addParam("harrasminmana", "Minimum Mana to Cast in Harras Mode %",SCRIPT_PARAM_SLICE, 0, 0, 100, 1)
			Veigar.adv.w:addParam("harrashs", "Hitchance",SCRIPT_PARAM_SLICE, 2, 0, 5, 1)

			Veigar.adv.w:addParam("sec3", "Laneclear Mode Settings", SCRIPT_PARAM_INFO, "")
			Veigar.adv.w:addParam("laneclearcast", "Cast in Laneclear Mode",SCRIPT_PARAM_ONOFF, true)
			Veigar.adv.w:addParam("laneclearminmana", "Minimum Mana to Cast in Laneclear Mode %",SCRIPT_PARAM_SLICE, 0, 0, 100, 1)
			Veigar.adv.w:addParam("laneclearhs", "Hitchance",SCRIPT_PARAM_SLICE, 2, 0, 5, 1)

		Veigar.adv:addSubMenu("E Settings", "e")
			Veigar.adv.e:addParam("sec1", "Combo Mode Settings", SCRIPT_PARAM_INFO, "")
			Veigar.adv.e:addParam("combocast", "Cast in Combo Mode",SCRIPT_PARAM_ONOFF, true)
			Veigar.adv.e:addParam("combominmana", "Minimum Mana to Cast in Combo Mode %",SCRIPT_PARAM_SLICE, 0, 0, 100, 1)
			Veigar.adv.e:addParam("combohs", "Hitchance",SCRIPT_PARAM_SLICE, 2, 0, 5, 1)

			Veigar.adv.e:addParam("sec2", "Harras Mode Settings", SCRIPT_PARAM_INFO, "")
			Veigar.adv.e:addParam("harrascast", "Cast in Harras Mode",SCRIPT_PARAM_ONOFF, true)
			Veigar.adv.e:addParam("harrasminmana", "Minimum Mana to Cast in Harras Mode %",SCRIPT_PARAM_SLICE, 0, 0, 100, 1)
			Veigar.adv.e:addParam("harrashs", "Hitchance",SCRIPT_PARAM_SLICE, 2, 0, 5, 1)

			Veigar.adv.e:addParam("sec3", "Laneclear Mode Settings", SCRIPT_PARAM_INFO, "")
			Veigar.adv.e:addParam("laneclearcast", "Cast in Laneclear Mode",SCRIPT_PARAM_ONOFF, false)
			Veigar.adv.e:addParam("laneclearminmana", "Minimum Mana to Cast in Laneclear Mode %",SCRIPT_PARAM_SLICE, 0, 0, 100, 1)
			Veigar.adv.e:addParam("laneclearhs", "Hitchance",SCRIPT_PARAM_SLICE, 2, 0, 5, 1)

			Veigar.adv.e:addParam("sec4", "Other Settings", SCRIPT_PARAM_INFO, "")
			Veigar.adv.e:addParam("champonly","Only cast on Champions", SCRIPT_PARAM_ONOFF, true)
			Veigar.adv.e:addParam("keepstunned", "Keep's CCed Target Stunned", SCRIPT_PARAM_ONOFF, true)

		Veigar.adv:addSubMenu("R Settings", "r")
			Veigar.adv.r:addParam("sec1", "Combo Mode Settings", SCRIPT_PARAM_INFO, "")
			Veigar.adv.r:addParam("combocast", "Cast in Combo Mode",SCRIPT_PARAM_ONOFF, true)
			Veigar.adv.r:addParam("combominmana", "Minimum Mana to Cast in Combo Mode %",SCRIPT_PARAM_SLICE, 0, 0, 100, 1)

			Veigar.adv.r:addParam("sec4", "Other Settings", SCRIPT_PARAM_INFO, "")
			Veigar.adv.r:addParam("kill", "Only Cast if target is Killable",SCRIPT_PARAM_ONOFF, true)
			Veigar.adv.r:addParam("buffer", "Buffer",SCRIPT_PARAM_SLICE, 5, 0, 25, 1)
			Veigar.adv.r:addParam("overkill", "Don't overkill target", SCRIPT_PARAM_ONOFF, true)
			Veigar.adv.r:addParam("overkillbuffer", "Don't overkill by X Percentag", SCRIPT_PARAM_SLICE, 50, 0, 200, 1)
			Veigar.adv.r:addParam("inf1", "Overkill Setting, will prevent R cast if", SCRIPT_PARAM_INFO, "")
			Veigar.adv.r:addParam("inf2", "the Ultimate, would do X Percent more", SCRIPT_PARAM_INFO, "")
			Veigar.adv.r:addParam("inf3", "Damage, then the Target's Life", SCRIPT_PARAM_INFO, "")

		Veigar:addSubMenu("Other", "other")
			Veigar.other:addParam("debug", "Debug Mode", SCRIPT_PARAM_ONOFF, false)
			Veigar.other:addTS(ts)
			if _G.AutoCarry then
				Veigar.other:addParam("sac", "Use SAC:R Targets", SCRIPT_PARAM_ONOFF, false)
			end
			Veigar.other:addSubMenu("Humanizer", "human")
				Veigar.other.human:addParam("sec1", "Jitter", SCRIPT_PARAM_INFO, "")
				Veigar.other.human:addParam("qjitter", "Q Jitter",SCRIPT_PARAM_SLICE, 0, 0, 50, 1)
				Veigar.other.human:addParam("wjitter", "W Jitter",SCRIPT_PARAM_SLICE, 0, 0, 50, 1)
				Veigar.other.human:addParam("ejitter", "E Jitter",SCRIPT_PARAM_SLICE, 0, 0, 50, 1)
				Veigar.other.human:addParam("sec2", "Delay Time (In Secounds)", SCRIPT_PARAM_INFO, "")
				Veigar.other.human:addParam("qdelay", "Q Delay",SCRIPT_PARAM_SLICE, 0, 0, 10, 0.1)
				Veigar.other.human:addParam("wdelay", "W Delay",SCRIPT_PARAM_SLICE, 0, 0, 10, 0.1)
				Veigar.other.human:addParam("edelay", "E Delay",SCRIPT_PARAM_SLICE, 0, 0, 10, 0.1)
				Veigar.other.human:addParam("rdelay", "R Delay",SCRIPT_PARAM_SLICE, 0, 0, 10, 0.1)
			Veigar.other:addParam("logicchk", "LogicCheck", SCRIPT_PARAM_SLICE, 500,0,1500,1)
		Veigar:addSubMenu("Key Bindings", "key")
			Veigar.key:addParam("combokey", "Combo Key", SCRIPT_PARAM_ONKEYDOWN,false, 32)
			Veigar.key:addParam("harraskey", "Harras Key", SCRIPT_PARAM_ONKEYDOWN,false, 67)
			Veigar.key:addParam("laneclearkey", "Laneclear Key", SCRIPT_PARAM_ONKEYDOWN,false, 86)
		Veigar:addSubMenu("Draws", "draws")
			Veigar.draws:addParam("qrange", "Draw Q", SCRIPT_PARAM_ONOFF, true)
			Veigar.draws:addParam("wrange", "Draw W", SCRIPT_PARAM_ONOFF, true)
			Veigar.draws:addParam("erange", "Draw E", SCRIPT_PARAM_ONOFF, true)
			Veigar.draws:addParam("rrange", "Draw R", SCRIPT_PARAM_ONOFF, true)
			Veigar.draws:addParam("qcolor", "Q Color", SCRIPT_PARAM_COLOR, {255,0,255,0})
			Veigar.draws:addParam("wcolor", "W Color", SCRIPT_PARAM_COLOR, {255,0,0,0255})
			Veigar.draws:addParam("ecolor", "E Color", SCRIPT_PARAM_COLOR, {255,255,0,0})
			Veigar.draws:addParam("rcolor", "R Color", SCRIPT_PARAM_COLOR, {255,0,255,255})
			Veigar.draws:addParam("rdmg", "Draw R Damage", SCRIPT_PARAM_ONOFF, true)
			Veigar.draws:addParam("rdmgoffX", "Draw R Damage X Offset", SCRIPT_PARAM_SLICE, 0, -200, 200, 1)
			Veigar.draws:addParam("rdmgoffY", "Draw R Damage Y Offset", SCRIPT_PARAM_SLICE, 0, -200, 200, 1)
			Veigar.draws:addParam("lfcresolution", "Circle Quality", SCRIPT_PARAM_SLICE, 10, 4, 50, 1)
			Veigar.draws:addParam("lfcthickness", "Circle Thickness", SCRIPT_PARAM_SLICE,1,1,5,1)
	

end

function ChkConfig()

	if Veigar.other.human.qdelay ~= round(Veigar.other.human.qdelay) then
		Veigar.other.human.qdelay = (round(Veigar.other.human.qdelay))
	end
	if Veigar.other.human.wdelay ~= round(Veigar.other.human.wdelay) then
		Veigar.other.human.wdelay = (round(Veigar.other.human.wdelay))
	end
	if Veigar.other.human.edelay ~= round(Veigar.other.human.edelay) then
		Veigar.other.human.edelay = (round(Veigar.other.human.edelay))
	end
	if Veigar.other.human.rdelay ~= round(Veigar.other.human.rdelay) then
		Veigar.other.human.rdelay = (round(Veigar.other.human.rdelay))
	end

	if Veigar.draws.lfcresolution ~= round(Veigar.draws.lfcresolution) then
		Veigar.draws.lfcresolution = (round(Veigar.draws.lfcresolution))
	end
	if Veigar.draws.lfcthickness ~= round(Veigar.draws.lfcthickness) then
		Veigar.draws.lfcthickness = (round(Veigar.draws.lfcthickness))
	end
end


--[[==============================End Config==============================]]--
--[[==============================Start Scriptlogic==============================]]--

function Harras()
	if not Veigar.key.harraskey then return end
	AutoLH()
	AutoCC()
	local target = GetTarget()
	if not target then return end
	local dst = GetDistance(target, myHero)

	if Veigar.adv.q.harrascast and Veigar.adv.q.harrasminmana <= perc(myHero.mana, myHero.maxMana) then
		if dst <= VeigarQ.range then
			CastQ(target, "Harras")
		end
	end

	if Veigar.adv.w.harrascast and Veigar.adv.w.harrasminmana <= perc(myHero.mana, myHero.maxMana) then
		if dst <= VeigarW.range then
			CastW(target, "Harras")
		end
	end

	if Veigar.adv.e.harrascast and Veigar.adv.e.harrasminmana <= perc(myHero.mana, myHero.maxMana) then
		if dst <= VeigarE.range then
			CastE(target, "Harras")
		end
	end

end

function Combo()
	if not Veigar.key.combokey then return end
	AutoCC()
	local target = GetTarget()
	if not target then return end
	local dst = GetDistance(target, myHero)

	if Veigar.adv.q.combocast and Veigar.adv.q.combominmana <= perc(myHero.mana, myHero.maxMana) then
		if dst <= VeigarQ.range then
			CastQ(target, "Combo")
		end
	end

	if Veigar.adv.w.combocast and Veigar.adv.w.combominmana <= perc(myHero.mana, myHero.maxMana) then
		if dst <= VeigarW.range then
			CastW(target, "Combo")
		end
	end

	if Veigar.adv.e.combocast and Veigar.adv.e.combominmana <= perc(myHero.mana, myHero.maxMana) then
		if dst <= VeigarE.range then
			CastE(target, "Combo")
		end
	end

	if Veigar.adv.r.combocast and Veigar.adv.r.combominmana <= perc(myHero.mana, myHero.maxMana) then
		if dst <= VeigarR.range then
			CastR(target, "Combo")
		end
	end
end

function Laneclear()
	if not Veigar.key.laneclearkey then return end
	AutoLH()
	AutoCC()
	local SXtarget = sxtarget()
	local target = nil
	if Veigar.adv.q.laneclearcast and Veigar.adv.q.laneclearminmana <= perc(myHero.mana, myHero.maxMana) then
		if _G.AutoCarry and Veigar.other.sac then
			target = _G.AutoCarry.Minions:GetLowestHealthMinion()
		end
		if _G.SxOrb and target == nil then
			target = SXtarget
		end
		if not target then
			target = GetTarget()
		end
		if target and GetDistance(target, myHero) <= VeigarQ.range then
			CastQ(target, "Laneclear")
		end
	end
	target = nil

	if Veigar.adv.w.laneclearcast and Veigar.adv.w.laneclearminmana <= perc(myHero.mana, myHero.maxMana) then
		if _G.AutoCarry and Veigar.other.sac then
			target = _G.AutoCarry.Minions:GetLowestHealthMinion()
		end
		if _G.SxOrb and target == nil then
			target = SXtarget
		end
		if not target then
			target = GetTarget()
		end
		if target and GetDistance(target, myHero) <= VeigarW.range then
			CastW(target, "Laneclear")
		end
	end
	target = nil

	if Veigar.adv.e.laneclearcast and Veigar.adv.e.laneclearminmana <= perc(myHero.mana, myHero.maxMana) then
		if _G.AutoCarry and Veigar.other.sac then
			target = _G.AutoCarry.Minions:GetLowestHealthMinion()
		end
		if _G.SxOrb and target == nil then
			target = SXtarget
		end
		if not target then
			target = GetTarget()
		end
		if target and GetDistance(target, myHero) <= VeigarE.range then
			CastE(target, "Laneclear")
		end
	end
	target = nil
end

function CastQ(target, mode)
	if not target or target.dead or myHero.dead or myHero:CanUseSpell(_Q) ~= 0 then return end
	local hs = huge

	if mode == "Combo" then
		hs = Veigar.adv.q.combohs
	elseif mode == "Harras" then
		hs = Veigar.adv.q.harrashs
	elseif mode == "Laneclear" then
		hs = Veigar.adv.q.laneclearhs
	end


	CastPosition, Chance, HeroPosition = UPL:Predict(_Q, myHero, target)

	if not Chance or not CastPosition then return end
	if Chance >= hs then
		local hx = CastPosition.x+random(Veigar.other.human.qjitter*-1,Veigar.other.human.qjitter)
		local hz = CastPosition.z+random(Veigar.other.human.qjitter*-1,Veigar.other.human.qjitter)
		if LogicCheck(target,hx,hz) == true then
			local delay = 0
			if Veigar.other.human.qdelay > 1 then
				delay = random(Veigar.other.human.qdelay-1,Veigar.other.human.qdelay-2)
			else
				delay = 0
			end
			DelayAction(function ()
				CastSpell(_Q,hx,hz)
			end, delay/1000)
		end
	end
end

function CastW(target, mode)
	if not target or target.dead or myHero.dead or myHero:CanUseSpell(_W) ~= 0 then return end
	local hs = huge

	if mode == "Combo" then
		hs = Veigar.adv.w.combohs
	elseif mode == "Harras" then
		hs = Veigar.adv.w.harrashs
	elseif mode == "Laneclear" then
		hs = Veigar.adv.w.laneclearhs
	end

	CastPosition, Chance, HeroPosition = UPL:Predict(_W, myHero, target)

	if not Chance or not CastPosition then return end

	if Chance >= hs then
		local hx = CastPosition.x+random(Veigar.other.human.wjitter*-1,Veigar.other.human.wjitter)
		local hz = CastPosition.z+random(Veigar.other.human.wjitter*-1,Veigar.other.human.wjitter)
		if LogicCheck(target,hx,hz) == true then
			local delay = 0
			if Veigar.other.human.wdelay > 1 then
				delay = random(Veigar.other.human.wdelay-1,Veigar.other.human.wdelay-2)
			else
				delay = 0
			end
			DelayAction(function ()
				if target.dead == false then
					CastSpell(_W,hx,hz)
				end
			end, delay/1000)
		end
	end
end

function CastE(target, mode)
	if not target or target.dead or myHero.dead or myHero:CanUseSpell(_E) ~= 0 then return end
	local hs = huge

	if mode == "Combo" then
		hs = Veigar.adv.e.combohs
	elseif mode == "Harras" then
		hs = Veigar.adv.e.harrashs
	elseif mode == "Laneclear" then
		hs = Veigar.adv.e.laneclearhs
	end

	CastPosition, Chance, HeroPosition = UPL:Predict(_E, myHero, target)
	
	if not Chance or not CastPosition then return end

	if Chance >= hs then
		local hx = CastPosition.x+random(Veigar.other.human.ejitter*-1,Veigar.other.human.ejitter)
		local hz = CastPosition.z+random(Veigar.other.human.ejitter*-1,Veigar.other.human.ejitter)
		if LogicCheck(target,hx,hz) == true then
			local delay = 0
			if Veigar.other.human.edelay > 1 then
				delay = random(Veigar.other.human.edelay-1,Veigar.other.human.edelay-2)
			else
				delay = 0
			end
			DelayAction(function ()
				if target.dead == false then
					CastSpell(_E,hx,hz)
				end
			end, delay/1000)
		end
	end
end

function CastR(target)
	if not target or target.dead or myHero.dead or myHero:CanUseSpell(_R) ~= 0 then return end
	if Veigar.adv.r.kill then
		local lvl = myHero:GetSpellData(_R).level
		local ap = GetAp(myHero)
		local eap = GetAp(target)
		local dmg = 125 + lvl*125 + ap + (eap * 0.8)
		local dmgp = dmg * (100/(100+target.magicArmor))
		dmgp = dmgp - (dmgp * (Veigar.adv.r.buffer/100))

		if target.health <= dmgp then
			local delay = 0
			if Veigar.other.human.rdelay > 1 then
				delay = random(Veigar.other.human.edelay-1,Veigar.other.human.rdelay-2)
			else
				delay = 0
			end
			local overkillperc = math.round(perc(dmgp, target.health)-100)
			if not Veigar.adv.r.overkill or (overkillperc <= Veigar.adv.r.overkillbuffer) then
				DelayAction(function ()
					if target.dead == false then
						CastSpell(_R,target)
					end
				end, delay/1000)
			end
		end


	else
		local delay = 0
		if Veigar.other.human.rdelay > 1 then
			delay = random(Veigar.other.human.edelay-1,Veigar.other.human.rdelay-2)
		else
			delay = 0
		end
		DelayAction(function () CastSpell(_R, target) end,delay/1000)
	end
end

function AutoCC()
	if myHero:CanUseSpell(_E) ~= 0 then return end
	if Veigar.adv.e.keepstunned == false then return end
	for _, v in pairs(GetEnemyHeroes()) do
		if ValidTarget(v, VeigarE.range+VeigarE.range/2) then
			if not v.canAttack then

				local X = v.x - myHero.x
				local Y = v.y - myHero.y
				local Z = v.z - myHero.z
				local nvec = Vector(X,Y,Z)
				nvec = nvec:normalized()
				local lenght = 350
				local dvec = nvec*lenght

				local CPosX = v.x-dvec.x
				local CPosY = v.y-dvec.y
				local CPosZ = v.z-dvec.z

				local hx = CPosX+random(Veigar.other.human.ejitter*-1,Veigar.other.human.ejitter)
				local hz = CPosZ+random(Veigar.other.human.ejitter*-1,Veigar.other.human.ejitter)
				local delay = 0
				if Veigar.other.human.edelay > 1 then
					delay = random(Veigar.other.human.edelay-1,Veigar.other.human.edelay-2)
				else
					delay = 0
				end
				
				

				
				DelayAction(function ()
					if v.dead == false then
						CastSpell(_E,hx,hz)
					end
				end, delay/1000)
			end
		end
	end
end


function AutoLH()
	if myHero:CanUseSpell(_Q) ~= 0 then return end
	local casted = false
	for i = 1, objManager.maxObjects do
		if casted == false then
        	local object = objManager:GetObject(i)
        	if object and object.valid and object.type == "obj_AI_Minion" and object.team ~= myHero.team then
        		local dst = GetDistance(object, myHero)
        		if dst < VeigarQ.range then
					local health = object.health
					local dmg = 30+(myHero:GetSpellData(_Q).level*40)+(GetAp(myHero)*0.6)
					if dmg > health then
						CastSpell(_Q, object.x,object.z)
					end
				end
			end
		end
	end
end


function LogicCheck(target,hx,hz)
	local chk = true
	if getDistanceC(target.x,target.z,hx,hz) >= Veigar.other.logicchk then
		chk = false
	end
	return chk
end

function sxtarget()
	if not SxOrb then return end
	local eminions = _G.SxOrb.enemyMinions
	local target = nil
	for _,k in pairs(eminions) do
		if target == nil then
			target = k
		else
		if target.health <= k.health then
			target = k
		end
		end
	end
	return target
end
--[[==============================End Script Logic==============================]]--
--[[==============================Start Libary==============================]]--

function p(arg)
	if arg ~= nil then
		print("[S1mple_Veigar] <font color=\"#570BB2\">"..arg.."</font>")
	end
end
function findorbwalker() --Thanks to http://forum.botoflegends.com/user/431842-orianna/ for this Simple solution
	if _G.Reborn_Loaded then
		SAC=true
		p("Sida's Auto Carry found")
		p("Using SAC:R targets")
		Veigar.other:addParam("sac", "Use SAC:R targets", SCRIPT_PARAM_ONOFF, true)
	elseif not _G.Reborn_Loaded and FileExist(LIB_PATH .. "SxOrbWalk.lua") then
		SxOrb=true
		require("SxOrbWalk")
		DelayAction(function() Veigar:addSubMenu("SxOrbWalk","orbWalk") end,5)
		DelayAction(function() _G.SxOrb:LoadToMenu(Veigar.orbWalk) end,5)
		p("SxOrbWalk found")
	elseif SAC==false and SxOrb==false then
		p("No Orbwalker found")
		p("If you use MMA or Nebelwolfies, laneclear wont work")
	end
end

function perc(current, max)
	if not current or not max then
		p("[ERROR] perc() current or max missing")
		return 100
	end
	return ((current/max)*100)
end

function GetAp(unit) --by Xivia
    local unit = unit or myHero
    return(unit.ap + (unit.ap * unit.apPercent))
end

function GetTarget()
	ts:update()
	if CuTarget then
		return CuTarget
	end
	if _G.AutoCarry and Veigar.other.sac and _G.AutoCarry.Crosshair:GetTarget() then
		return _G.AutoCarry.Crosshair:GetTarget()
	end
	return ts.target
end

function getDistanceC(X,Y,X1,Y1)
	--(X-X1)^2+(Z-Z1)^2 <= R^2 if in range
	return sqrt(((X-X1)^2)+((Y-Y1)^2))
end

function replace_char(pos, str, r)
    return str:sub(1, pos-1) .. r .. str:sub(pos+1)
end

function registerUPL()
	UPL:AddToMenu(Veigar)
	UPL:AddSpell(_Q, VeigarQ)
	UPL:AddSpell(_W, VeigarW)
	UPL:AddSpell(_E, VeigarE)

	UPL:AddToMenu2(Veigar)
end

--[[==============================Start Libary==============================]]--
--[[==============================Start Updater==============================]]--


local serveradress = "www.s1mplescripts.de"
local scriptadress = "/S1mpleScripts/Scripts/BolStudio/Veigar"

function findupdates()
	if not autoupdate then return end
	local ServerVersionDATA = GetWebResult(serveradress , scriptadress.."/S1mple_Veigar.version")
	if ServerVersionDATA then
		local ServerVersion = tonumber(ServerVersionDATA)
		if ServerVersion then
			if ServerVersion > tonumber(LocalVersion) then
				p("Updating S1mple_Veigar, don't press F9")
				update()
			end
		else
			p("An error occured, while updating, please reload")
		end
	else
		p("Could not connect to update Server")
	end
end

function update()
	DownloadFile("http://"..serveradress..scriptadress.."/S1mple_Veigar.lua",SCRIPT_PATH.."S1mple_Veigar.lua", function ()
		p("Updated, press 2xF9")
		updated = true
	end)
end

--[[==============================End Config==============================]]--




class('CTarget')
function CTarget:__init()
	AddMsgCallback(function(msg, wParam)
		self:setTarget(msg, wParam)
	end)
	AddDrawCallback(function()
		self:draw()
	end)
	AddTickCallback(function()
		self:tick()
	end)
end

function CTarget:setTarget(msg, wParam)
	if msg == 513 then
		for _, v in pairs(GetEnemyHeros()) do
			local distance = sqrt(((v.x-mousePos.x)^2)+((v.z-mousePos.z)^2))
			if distance <= 150 then --Marks the enemy if he is in 150 Range
				if CuTarget ~= v then
					p("Selected: "..v.charName)
					CuTarget = v
				end
			elseif CuTarget then
				p("Unselected Target")
				CuTarget = nil
			end
		end
	end
end

function CTarget:draw()
	if CuTarget and CuTarget.visible and not CuTarget.dead then
		DrawCircle3D(CuTarget.x, CuTarget.y, CuTarget.z, 50, 2, ARGB(255,0,255,255), 10)
	end
end

function CTarget:tick()
	if CuTarget then
		if CuTarget.dead or GetDistance(CuTarget, myHero) >= 2000 then
			CuTarget = nil
			p("Auto-Unselected Target")
		end
	end
end



--ScriptStatus Link
assert(load(Base64Decode("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"), nil, "bt", _ENV))() ScriptStatus("TGJJONMJOMG") 
--