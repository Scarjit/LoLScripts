--[[
   _____ __                 _        _   _                 _   _              _____ __                 _       _____           _       _       
  / ____/_ |               | |      | \ | |               (_) | |            / ____/_ |               | |     / ____|         (_)     | |      
 | (___  | |_ __ ___  _ __ | | ___  |  \| | __ _ _ __ ___  _  | |__  _   _  | (___  | |_ __ ___  _ __ | | ___| (___   ___ _ __ _ _ __ | |_ ___ 
  \___ \ | | '_ ` _ \| '_ \| |/ _ \ | . ` |/ _` | '_ ` _ \| | | '_ \| | | |  \___ \ | | '_ ` _ \| '_ \| |/ _ \\___ \ / __| '__| | '_ \| __/ __|
  ____) || | | | | | | |_) | |  __/ | |\  | (_| | | | | | | | | |_) | |_| |  ____) || | | | | | | |_) | |  __/____) | (__| |  | | |_) | |_\__ \
 |_____/ |_|_| |_| |_| .__/|_|\___| |_| \_|\__,_|_| |_| |_|_| |_.__/ \__, | |_____/ |_|_| |_| |_| .__/|_|\___|_____/ \___|_|  |_| .__/ \__|___/
                     | |                                              __/ |                     | |                             | |            
                     |_|                                             |___/                      |_|                             |_|            
Credits:
	Xivia for being Awesome
	Nebelwolfi for the local class function & UPL
	Jorj for the HP Bar Offsets
	Aera_UNK for giving me the Idea of making this Script
	Furry for the hours of Skype chating :)
	GNAAAAR for being so supportive, and also giving me access to the Scriptstatus Scripter Panel
	JaiKor for beeing an awesome Support Ninja :)

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

--
if not myHero then
	myHero = GetmyHero()
end
if myHero.charName ~= "Nami" then return end


-- http://bol-tools.com/ tracker
assert(load(Base64Decode("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"), nil, "bt", _ENV))()
TrackerLoad("vvwDV1KZVjMwq8jx")


--[[Auto Updater Warning]]
if _ENV.FILE_NAME ~= "S1mple_Nami.lua" then
	print("[S1mple_Nami] <font color=\"#570BB2\">Please rename ".._ENV.FILE_NAME.." to: S1mple_Nami.lua</font>")
	return
end
--[[End Auto Updater Warning]]


--[[Get UPL and S1mple Libary]]
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

if not _G.S1mple_Libaryloaded then
  if FileExist(LIB_PATH .. "/S1mple_Libary.lua") then
    require("S1mple_Libary")
    SL = S1mpleLibary()
  else 
    print("Downloading S1mple_Libary, please don't press F9")
    DelayAction(function() DownloadFile("http://s1mplescripts.de/S1mple/Scripts/BolStudio/Libary/S1mpleLibary/S1mple_Libary.lua", LIB_PATH.."S1mple_Libary.lua", function () print("Successfully downloaded S1mple_Libary. Press F9 twice.") end) end, 3) 
    return
  end
end

--[[END Get UPL and S1mple Libary]]

function p(arg)
	if arg ~= nil then
		print("[S1mple_Nami] <font color=\"#570BB2\">"..arg.."</font>")
	end
end

--Math
local sqrt, max, deg, asin, cos, pi, floor, ceil, sin, huge, random, round = math.sqrt, math.max, math.deg, math.asin, math.cos, math.pi, math.floor, math.ceil, math.sin, math.huge, math.random, math.round

--Vars
local version = "2.1"
local updated = false
local CuTarget = nil
--local VPred = VPrediction()
local spells = {
	--["Q"] = {delay = 0.875, radius = 162, range = 875, speed = huge},
	["Q"] = {delay = 0.925, radius = 162, range = 875, speed = huge},
	["W"] = {delay = 0.25, range = 725},
	["E"] = {delay = 0.25, range = 800},
	["R"] = {delay = 0.25, width = 562, range = 2750, speed = 859}
}

-- Made by Nebelwolfi to make classes local and not global
function Class(name)
    _ENV[name] = { }
    _ENV[name].__index = _ENV[name]
    local mt = { __call = function(self, ...) local b = { } setmetatable(b, _ENV[name]) b:__init(...) return b end }
    setmetatable(_ENV[name], mt)
end

DelayAction( function() if not _G.S1mple_NamiLoaded then CNami() end end, 0.05)

--[[Real Script begins here]]

class "CNami"
function CNami:__init()
	_G.S1mple_NamiLoaded = true
	SUpdate()
	CTarget()
	self.ts = TargetSelector(TARGET_LESS_CAST, 900, DAMAGE_MAGIC, true)
	self.ts.name = "Target Selector"

	self:config()
	self:UPL()
	self:S1mpleLibary()

	AddDrawCallback(function()
		self:draw()
	end)
	AddTickCallback(function()
		self:tick()
	end)

	AddProcessSpellCallback(function(object, spell)
		self:interupt(object, spell)
	end)

	if not _G.Reborn_Loaded and FileExist(LIB_PATH .. "SxOrbWalk.lua") then
		require("SxOrbWalk")
		DelayAction(function() self.cfg:addSubMenu("SxOrbWalk","orbWalk") end,5)
		DelayAction(function() _G.SxOrb:LoadToMenu(self.cfg.orbWalk) end,5)
		p("============================")
		p("For full SxOrbWalk Features, please")
		p("activate it in the BoL Studio Scripts Tab")
		p("============================")
	end

	p("Loaded")
end

function CNami:config()
	if updated then return end
	self.cfg = scriptConfig("S1mple_Nami", "s1mple_nami")
	self.cfg:addSubMenu("Spell Settings", "spell")
		self.cfg.spell:addSubMenu("Aqua Prison", "q")
			self.cfg.spell.q:addParam("inf1", "------Combo Mode Settings------", SCRIPT_PARAM_INFO, "")
			self.cfg.spell.q:addParam("combo", "Use", SCRIPT_PARAM_ONOFF, true)
			self.cfg.spell.q:addParam("combominmana", "Min Mana (Percentage)",SCRIPT_PARAM_SLICE,30,0,100)

			self.cfg.spell.q:addParam("inf2", "------Harras Mode Settings------", SCRIPT_PARAM_INFO, "")
			self.cfg.spell.q:addParam("harras", "Use", SCRIPT_PARAM_ONOFF, true)
			self.cfg.spell.q:addParam("harrasminmana", "Min Mana (Percentage)",SCRIPT_PARAM_SLICE,30,0,100)

			self.cfg.spell.q:addParam("inf3", "------Laneclear Mode Settings------", SCRIPT_PARAM_INFO, "")
			self.cfg.spell.q:addParam("laneclear", "Use against Champions", SCRIPT_PARAM_ONOFF, false)
			self.cfg.spell.q:addParam("laneclearminmana", "Min Mana (Percentage)",SCRIPT_PARAM_SLICE,30,0,100)

		self.cfg.spell:addSubMenu("Ebb and Flow", "w")
			self.cfg.spell.w:addParam("inf1", "------Combo Mode Settings------", SCRIPT_PARAM_INFO, "")
			self.cfg.spell.w:addParam("combo", "Use", SCRIPT_PARAM_ONOFF, true)
			self.cfg.spell.w:addParam("combominmana", "Min Mana (Percentage)",SCRIPT_PARAM_SLICE,30,0,100)

			self.cfg.spell.w:addParam("inf2", "------Harras Mode Settings------", SCRIPT_PARAM_INFO, "")
			self.cfg.spell.w:addParam("harras", "Use", SCRIPT_PARAM_ONOFF, true)
			self.cfg.spell.w:addParam("harrasminmana", "Min Mana (Percentage)",SCRIPT_PARAM_SLICE,30,0,100)


		self.cfg.spell:addSubMenu("Tidecaller's Blessing", "e")
			self.cfg.spell.e:addParam("inf1", "------Combo Mode Settings------", SCRIPT_PARAM_INFO, "")
			self.cfg.spell.e:addParam("combo", "Use", SCRIPT_PARAM_ONOFF, true)
			self.cfg.spell.e:addParam("combominmana", "Min Mana (Percentage)",SCRIPT_PARAM_SLICE,30,0,100)
			self.cfg.spell.e:addParam("combominenemys", "Min Enemys around", SCRIPT_PARAM_SLICE, 2, 1, 6)

			self.cfg.spell.e:addParam("inf2", "------Harras Mode Settings------", SCRIPT_PARAM_INFO, "")
			self.cfg.spell.e:addParam("harras", "Use", SCRIPT_PARAM_ONOFF, true)
			self.cfg.spell.e:addParam("harrasminmana", "Min Mana (Percentage)",SCRIPT_PARAM_SLICE,30,0,100)
			self.cfg.spell.e:addParam("harrasminenemys", "Min Enemys around", SCRIPT_PARAM_SLICE, 2, 1, 6)
			
		self.cfg.spell:addSubMenu("Tidal Wave", "r")
			self.cfg.spell.r:addParam("inf1", "------Combo Mode Settings------", SCRIPT_PARAM_INFO, "")
			self.cfg.spell.r:addParam("combo", "Use", SCRIPT_PARAM_ONOFF, true)
			self.cfg.spell.r:addParam("combominmana", "Min Mana (Percentage)",SCRIPT_PARAM_SLICE,30,0,100)
			self.cfg.spell.r:addParam("combominhits", "Minium Enemys Hit", SCRIPT_PARAM_SLICE, 3, 1, 5)

			self.cfg.spell.r:addParam("inf2", "------Harras Mode Settings------", SCRIPT_PARAM_INFO, "")
			self.cfg.spell.r:addParam("harras", "Use", SCRIPT_PARAM_ONOFF, true)
			self.cfg.spell.r:addParam("harrasminmana", "Min Mana (Percentage)",SCRIPT_PARAM_SLICE,30,0,100)
			self.cfg.spell.r:addParam("harrasminhits", "Minium Enemys Hit", SCRIPT_PARAM_SLICE, 3, 1, 5)

			
	self.cfg:addSubMenu("Heal Settings (Ebb and Flow)", "heal")
		self.cfg.heal:addParam("comboheal", "Use W to heal in Combo Mode", SCRIPT_PARAM_ONOFF, true)
		self.cfg.heal:addParam("harrasheal", "Use W to heal in Harras Mode", SCRIPT_PARAM_ONOFF, true)
		self.cfg.heal:addParam("laneclearheal", "Use W to heal in Laneclear Mode", SCRIPT_PARAM_ONOFF, true)
		self.cfg.heal:addParam("alwaysheal", "Always use W to heal Ally's", SCRIPT_PARAM_ONOFF, true)
		self.cfg.heal:addParam("healrecall", "Heal while recalling ?",SCRIPT_PARAM_ONOFF ,false)

		self.cfg.heal:addParam("minheal", "Minimum Heal % (Ally's)", SCRIPT_PARAM_SLICE ,60, 0, 100)
		self.cfg.heal:addParam("selfheal", "Cast on yourself", SCRIPT_PARAM_ONOFF, true)
		self.cfg.heal:addParam("minselfheal", "Minimum Heal % (Self)", SCRIPT_PARAM_SLICE, 60, 0, 100)
		self.cfg.heal:addParam("minmana", "Minimum Mana to Heal %", SCRIPT_PARAM_SLICE, 20, 0, 100)

	self.cfg:addSubMenu("Auto Interrupt", "air")
		for _,v in pairs(GetEnemyHeros()) do
			self.cfg.air:addSubMenu(v.charName, v.charName)
				self.cfg.air[v.charName]:addParam("inf", "Don't try to cancle Spells with less then", SCRIPT_PARAM_INFO, "")
				self.cfg.air[v.charName]:addParam("inf1", tostring(spells["Q"]["delay"]).." windup time", SCRIPT_PARAM_INFO, "")
				self.cfg.air[v.charName]:addParam(v:GetSpellData(_Q).name, "Cancle Q ("..v:GetSpellData(_Q).name..")", SCRIPT_PARAM_ONOFF, false)
				self.cfg.air[v.charName]:addParam(v:GetSpellData(_W).name, "Cancle W ("..v:GetSpellData(_W).name..")", SCRIPT_PARAM_ONOFF, false)
				self.cfg.air[v.charName]:addParam(v:GetSpellData(_E).name, "Cancle E ("..v:GetSpellData(_E).name..")", SCRIPT_PARAM_ONOFF, false)
				self.cfg.air[v.charName]:addParam(v:GetSpellData(_R).name, "Cancle R ("..v:GetSpellData(_R).name..")", SCRIPT_PARAM_ONOFF, false)

		end

	self.cfg:addSubMenu("Humanizer", "human")
		self.cfg.human:addParam("qhuman", "Humanize Q", SCRIPT_PARAM_ONOFF, true)
		self.cfg.human:addParam("whuman", "Humanize W", SCRIPT_PARAM_ONOFF, true)
		self.cfg.human:addParam("ehuman", "Humanize E", SCRIPT_PARAM_ONOFF, true)
		self.cfg.human:addParam("rhuman", "Humanize R", SCRIPT_PARAM_ONOFF, true)
		self.cfg.human:addSubMenu("Adv Combo Humanizer", "ahuman")
			self.cfg.human.ahuman:addParam("qdelay", "Q Delay", SCRIPT_PARAM_SLICE, 250, 0, 700)
			self.cfg.human.ahuman:addParam("wdelay", "W Delay", SCRIPT_PARAM_SLICE, 250, 0, 700)
			self.cfg.human.ahuman:addParam("edelay", "E Delay", SCRIPT_PARAM_SLICE, 250, 0, 700)
			self.cfg.human.ahuman:addParam("rdelay", "R Delay", SCRIPT_PARAM_SLICE, 250, 0, 700)
			self.cfg.human.ahuman:addParam("inf1", "-------------------------------------------------------",SCRIPT_PARAM_INFO, "")
			self.cfg.human.ahuman:addParam("qjitter", "Randomize Q Placement", SCRIPT_PARAM_ONOFF, true)
			self.cfg.human.ahuman:addParam("rjitter", "Randomize R Placement", SCRIPT_PARAM_ONOFF, true)

	self.cfg:addSubMenu("Key Settings" , "keys")
		self.cfg.keys:addParam("combo", "Combo Key", SCRIPT_PARAM_ONKEYDOWN, false, 32)
		self.cfg.keys:addParam("harras", "Harras Key", SCRIPT_PARAM_ONKEYDOWN, false, 67)
		self.cfg.keys:addParam("laneclear", "Laneclear Key", SCRIPT_PARAM_ONKEYDOWN, false, 86)
		--self.cfg.keys:addParam("ultimte", "Force Ultimate Key", SCRIPT_PARAM_ONKEYDOWN, false, 84)
	self.cfg:addSubMenu("Drawings", "draws")
		self.cfg.draws:addParam("drawq", "Draw Q Range", SCRIPT_PARAM_ONOFF, true)
		self.cfg.draws:addParam("qcolor", "Q Color", SCRIPT_PARAM_COLOR, {255,0,255,0})
		self.cfg.draws:addParam("draww", "Draw W Range", SCRIPT_PARAM_ONOFF, true)
		self.cfg.draws:addParam("wcolor", "W Color", SCRIPT_PARAM_COLOR, {255,255,255,0})
		self.cfg.draws:addParam("drawe", "Draw E Range", SCRIPT_PARAM_ONOFF, true)
		self.cfg.draws:addParam("ecolor", "E Color", SCRIPT_PARAM_COLOR, {255,0,255,255})
		self.cfg.draws:addParam("rdraw", "Draws R to enemys", SCRIPT_PARAM_ONOFF, true)
		self.cfg.draws:addParam("rcolor", "R Color (to enemy)", SCRIPT_PARAM_COLOR, {255,0,255,255})
		self.cfg.draws:addParam("rdrawpred", "Draws Predicted R Cast", SCRIPT_PARAM_ONOFF, true)
		self.cfg.draws:addParam("rcolorpred", "R Color (Predicted)", SCRIPT_PARAM_COLOR, {255,0,255,255})
		self.cfg.draws:addParam("rdrawmini", "Draw R Range (Minimap)", SCRIPT_PARAM_ONOFF, true)
		self.cfg.draws:addParam("rcolormini", "R Color (Minimap)", SCRIPT_PARAM_COLOR, {255,0,255,255})
		self.cfg.draws:addParam("rhitchance", "Draw R Hit Chance", SCRIPT_PARAM_ONOFF, true)

		self.cfg.draws:addParam("lfcquality", "Circle Quality", SCRIPT_PARAM_SLICE, 10, 4, 40)
		self.cfg.draws:addParam("lfcthickness", "Circle Thickness", SCRIPT_PARAM_SLICE, 1, 1, 5)

		self.cfg.draws:addParam("lfcqualitymini", "Circle Quality (Minimap)", SCRIPT_PARAM_SLICE, 10, 8, 40)
		self.cfg.draws:addParam("lfcthicknessmini", "Circle Thickness (Minimap)", SCRIPT_PARAM_SLICE, 1, 1, 5)

		self.cfg.draws:addParam("onlyifup", "Draw only if Spell is Ready", SCRIPT_PARAM_ONOFF, true)

	self.cfg:addParam("gameversion", "League of Legends Version", SCRIPT_PARAM_INFO, tostring(GetGameVersion():sub(1,10)))
	self.cfg:addParam("scriptversion", "Script Version", SCRIPT_PARAM_INFO, version)

	self.cfg:addTS(self.ts)

end

function CNami:draw()
	if updated or myHero.dead then return end
	--Target Marker
	local target = self:getTarget()
	if target then
		local barPos = GetUnitHPBarPos(target) --THANKS Jori
		local barOffset = GetUnitHPBarOffset(target)
		do -- For some reason the x offset never exists
			local t = {
				["Darius"] = -0.05,
				["Renekton"] = -0.05,
				["Sion"] = -0.05,
				["Thresh"] = 0.03,
			}
			barOffset.x = t[target.charName] or 0
		end
		local baseX = barPos.x - 69 + barOffset.x * 150
		local baseY = barPos.y + barOffset.y * 50 + 12.5
		DrawTextA("-->>", 25, baseX-30, baseY-35, ARGB(255,255,0,0))
		DrawTextA("<<--", 25, baseX+130, baseY-35, ARGB(255,255,0,0))
	end

	--Range Drawings
	if (self.cfg.draws.drawq and not self.cfg.draws.onlyifup) or (myHero:CanUseSpell(_Q) == READY and self.cfg.draws.onlyifup and self.cfg.draws.drawq) then
		DrawCircle3D(myHero.x, myHero.y, myHero.z, 875, self.cfg.draws.lfcthickness, ARGB(self.cfg.draws.qcolor[1],self.cfg.draws.qcolor[2],self.cfg.draws.qcolor[3],self.cfg.draws.qcolor[4]), self.cfg.draws.lfcquality)
	end
	if (self.cfg.draws.draww and not self.cfg.draws.onlyifup) or (myHero:CanUseSpell(_W) == READY and self.cfg.draws.onlyifup and self.cfg.draws.draww) then
		DrawCircle3D(myHero.x, myHero.y, myHero.z, 725, self.cfg.draws.lfcthickness, ARGB(self.cfg.draws.wcolor[1],self.cfg.draws.wcolor[2],self.cfg.draws.wcolor[3],self.cfg.draws.wcolor[4]), self.cfg.draws.lfcquality)
	end
	if (self.cfg.draws.drawe and not self.cfg.draws.onlyifup) or (myHero:CanUseSpell(_E) == READY and self.cfg.draws.onlyifup and self.cfg.draws.drawe)  then
		DrawCircle3D(myHero.x, myHero.y, myHero.z, 800, self.cfg.draws.lfcthickness, ARGB(self.cfg.draws.ecolor[1],self.cfg.draws.ecolor[2],self.cfg.draws.ecolor[3],self.cfg.draws.ecolor[4]), self.cfg.draws.lfcquality)
	end
	if (self.cfg.draws.rdrawmini and not self.cfg.draws.onlyifup) or (myHero:CanUseSpell(_R) == READY and self.cfg.draws.onlyifup and self.cfg.draws.rdrawmini) then
		DrawCircleMinimap(myHero.x, myHero.y, myHero.z, 2750, self.cfg.draws.lfcthicknessmini, ARGB(self.cfg.draws.rcolormini[1],self.cfg.draws.rcolormini[2],self.cfg.draws.rcolormini[3],self.cfg.draws.rcolormini[4]), self.cfg.draws.lfcqualitymini)
	end
	
	local eheroes = GetEnemyHeros()

	--Predicted Ult Draw
	if (self.cfg.draws.rdrawpred and not self.cfg.draws.onlyifup) or (myHero:CanUseSpell(_R) == READY and self.cfg.draws.onlyifup and self.cfg.draws.rdrawpred)  then
		for _, v in pairs(eheroes) do
			if ValidTarget(v, 2750) then
				local mainCastPosition, mainHitChance = UPL:Predict(_R, myHero, v)
				if mainCastPosition then
					DrawLineBorder3D(myHero.x, myHero.y, myHero.z, mainCastPosition.x, mainCastPosition.y, mainCastPosition.z, 562, ARGB(self.cfg.draws.rcolorpred[1],self.cfg.draws.rcolorpred[2],self.cfg.draws.rcolorpred[3],self.cfg.draws.rcolorpred[4]), 3)
				end
			end
		end
	end

	--Unpredicted Ult Draw
	if (self.cfg.draws.rdrawpred and not self.cfg.draws.onlyifup) or (myHero:CanUseSpell(_R) == READY and self.cfg.draws.onlyifup and self.cfg.draws.rdrawpred)  then
		for _, v in pairs(eheroes) do
			if ValidTarget(v, 2750) then		
				local X = v.x - myHero.x
				local Y = v.y - myHero.y
				local Z = v.z - myHero.z
				local nvec = Vector(X,Y,Z)
				nvec = nvec:normalized()
				local lenght = 2750
				local dvec = nvec*lenght
				DrawLineBorder3D(myHero.x, myHero.y, myHero.z, myHero.x+dvec.x, myHero.y+dvec.y, myHero.z+dvec.z, 562, ARGB(self.cfg.draws.rcolor[1],self.cfg.draws.rcolor[2],self.cfg.draws.rcolor[3],self.cfg.draws.rcolor[4]), 1)
			end
		end
	end

	--Draw R HitChance
	if (self.cfg.draws.rhitchance and not self.cfg.draws.onlyifup) or (myHero:CanUseSpell(_R) == READY and self.cfg.draws.onlyifup and self.cfg.draws.rhitchance) then
		for _, v in pairs(eheroes) do
			if ValidTarget(v, 2750) then
				local mainCastPosition, mainHitChance = UPL:Predict(_R, myHero, v)

				if mainHitChance == -1 then
					DrawText3D(tostring(mainHitChance), v.x,v.y,v.z,18, ARGB(255,255,0,0))
				elseif mainHitChance == 0 then
					DrawText3D(tostring(mainHitChance), v.x,v.y,v.z,18, ARGB(255,210,42,0))
				elseif mainHitChance == 1 then
					DrawText3D(tostring(mainHitChance), v.x,v.y,v.z,18, ARGB(255,168,84,0))
				elseif mainHitChance == 2 then
					DrawText3D(tostring(mainHitChance), v.x,v.y,v.z,18, ARGB(255,126,126,0))
				elseif mainHitChance == 3 then
					DrawText3D(tostring(mainHitChance), v.x,v.y,v.z,18, ARGB(255,84,168,0))
				elseif mainHitChance == 4 then
					DrawText3D(tostring(mainHitChance), v.x,v.y,v.z,18, ARGB(255,42,210,0))
				elseif mainHitChance == 5 then
					DrawText3D(tostring(mainHitChance), v.x,v.y,v.z,18, ARGB(255,0,255,0))
				end
			end
		end
	end

	--DEBUG
	local n = 0
	for i = 1, myHero.buffCount do
		local tBuff = myHero:getBuff(i)
        if BuffIsValid(tBuff) then
        	DrawTextA(tBuff.name, 18, 130, 35+(18*n), ARGB(255,255,255,0))
        	n = n + 1
        end
	end
end

function CNami:tick()
	if updated or myHero.dead then return end

	if self.cfg.keys.combo then
		self:combo()
	end
	if self.cfg.keys.harras then
		self:harras()
	end
	if self.cfg.keys.laneclear then
		self:laneclear()
	end

	if self.cfg.heal.alwaysheal and not self:isrecalling() and self.cfg.heal.minmana < self:perc(myHero.mana, myHero.maxMana) then
		self:healW()
	end
end

function CNami:combo()
	if self.cfg.spell.r.combo and self.cfg.spell.r.combominmana <= self:perc(myHero.mana, myHero.maxMana) and CountEnemyHeroInRange(spells["R"]["range"]) >= self.cfg.spell.r.combominhits then
		self:castR()
	end
	if self.cfg.heal.comboheal then
		self:healW()
	end

	local target = self:getTarget()
	if not target then return end
	if self.cfg.spell.q.combo and self.cfg.spell.q.combominmana <= self:perc(myHero.mana, myHero.maxMana) then
		self:castQ(target)
	end
	if self.cfg.spell.w.combo and self.cfg.spell.w.combominmana <= self:perc(myHero.mana, myHero.maxMana) then
		self:castW(target)
	end
	if self.cfg.spell.e.combo and self.cfg.spell.e.combominmana <= self:perc(myHero.mana, myHero.maxMana) and CountEnemyHeroInRange(spells["E"]["range"]) >= self.cfg.spell.e.combominenemys then
		self:castE()
	end
end

function CNami:harras()
	if self.cfg.spell.r.harras and self.cfg.spell.r.harrasminmana <= self:perc(myHero.mana, myHero.maxMana) and CountEnemyHeroInRange(spells["R"]["range"]) >= self.cfg.spell.r.harrasminhits then
		self:castR()
	end
	if self.cfg.heal.harrasheal then
		self:healW()
	end

	local target = self:getTarget()
	if not target then return end
	if self.cfg.spell.q.harras and self.cfg.spell.q.harrasminmana <= self:perc(myHero.mana, myHero.maxMana) then
		self:castQ(target)
	end
	if self.cfg.spell.w.harras and self.cfg.spell.w.harrasminmana <= self:perc(myHero.mana, myHero.maxMana) then
		self:castW(target)
	end
	if self.cfg.spell.e.harras and self.cfg.spell.e.harrasminmana <= self:perc(myHero.mana, myHero.maxMana) and CountEnemyHeroInRange(spells["E"]["range"]) >= self.cfg.spell.e.harrasminenemys then
		self:castE()
	end
end

function CNami:laneclear()
	if self.cfg.heal.laneclearheal then
		self:healW()
	end

	local target = self:getTarget()
	if not target then return end
	if self.cfg.spell.q.laneclear and self.cfg.spell.q.laneclearminmana <= self:perc(myHero.mana, myHero.maxMana) then
		self:castQ(target)
	end
end

function CNami:castQ(target)
	if myHero:CanUseSpell(_Q) ~= 0 then return end
	local mainCastPosition, mainHitChance = UPL:Predict(_Q, myHero, target)
	if mainCastPosition and mainHitChance >= 2 then
		local castPosX = mainCastPosition.x
		local castPosZ = mainCastPosition.z
		local delay = 0

		if self.cfg.human.qhuman then
			if self.cfg.human.ahuman.qjitter then
				castPosX = random(castPosX-10,castPosX+10)
				castPosZ = random(castPosZ-10,castPosZ+10)
			end
			if self.cfg.human.ahuman.qdelay then
				delay = random(self.cfg.human.ahuman.qdelay/2,self.cfg.human.ahuman.qdelay)
			end
		end

		DelayAction(function()
			CastSpell(_Q, castPosX, castPosZ)
		end,delay/1000)

	end
end


function CNami:castW(target)
	if myHero:CanUseSpell(_W) ~= 0 then return end
	local target = nil
	for _, v in pairs(GetEnemyHeros()) do
		if v.valid and GetDistance(v) < spells["W"]["range"] then
			if target == nil then
				target = v
			elseif v.health < target.health then
				target = v
			end
		end
	end
	if target then
		local delay = 0
		if self.cfg.human.ahuman.wdelay then
			delay = random(self.cfg.human.ahuman.wdelay/2,self.cfg.human.ahuman.wdelay)
		end
		DelayAction(function()
			CastSpell(_W, target)
		end,delay/1000)
	end
end

function CNami:castE()
	if myHero:CanUseSpell(_E) ~= 0 then return end
	local allys = GetAllyHeroes()
	local target = nil
	for _, v in pairs(allys) do
		if GetDistance(v) < spells["E"]["range"] and v.valid then
			if target == nil then
				target = v
			elseif v.addDamage > target.addDamage and self:perc(v.health, v.maxHealth) >= 5 then
				target = v
			end
		end
	end

	if not target then
		target = myHero
	end

	if target then
		local delay = 0
		if self.cfg.human.ahuman.edelay then
			delay = random(self.cfg.human.ahuman.edelay/2,self.cfg.human.ahuman.edelay)
		end

		DelayAction(function()
			CastSpell(_E, target)
		end,delay/1000)
	end

end

function CNami:castR()
	if myHero:CanUseSpell(_R) ~= 0 then return end
	local enemys = GetEnemyHeros()

	for _, v in pairs(enemys) do
		if ValidTarget(v, 2750) then
			local mainCastPosition, mainHitChance = UPL:Predict(_R, myHero, v)
			if mainCastPosition and mainHitChance >= 2 then
				local delay = 0
				if self.cfg.human.ahuman.rdelay then
					delay = random(self.cfg.human.ahuman.rdelay/2,self.cfg.human.ahuman.rdelay)
				end

				DelayAction(function()
					CastSpell(_R, mainCastPosition.x, mainCastPosition.z)
				end,delay/1000)
			end
		end
	end

end

function CNami:healW()
	if myHero:CanUseSpell(_W) ~= 0 or InFountain() then return end
	local allys = GetAllyHeroes()
	local target = nil
	for _, v in pairs(allys) do
		if GetDistance(v) < spells["W"]["range"] and v.valid and self:perc(v.health, v.maxHealth) < self.cfg.heal.minheal then
			if target == nil then
				target = v
			elseif v.health > target.health then
				target = v
			end
		end
	end
	if not target and self.cfg.heal.selfheal and self:perc(myHero.health, myHero.maxHealth) < self.cfg.heal.minselfheal then
		target = myHero
	end
	if target then
		local delay = 0
		if self.cfg.human.ahuman.wdelay then
			delay = random(self.cfg.human.ahuman.wdelay/2,self.cfg.human.ahuman.wdelay)
		end
		DelayAction(function()
			CastSpell(_W, target)
		end,delay/1000)
	end

end

function CNami:interupt(obj, spell)
	if myHero.dead == false and obj and spell and obj.team ~= myHero.team and obj.type ~= "obj_AI_Minion" and GetDistance(myHero, obj) < spells["Q"]["range"] and myHero:CanUseSpell(_Q) == READY then
		if self.cfg.air[obj.charName][obj:GetSpellData(_Q).name] then
			CastSpell(_Q, obj)
			p("interupted "..spell.name.." casted by: "..obj.charName)
		end
	end
end

function CNami:perc(current, max)
	if not current or not max then
		error("[CNami] error in func perc(current, max)")
	end
	return ((current/max)*100)
end

function CNami:getTarget()
	self.ts:update()
	return CuTarget or self.ts.target
end


function CNami:GetAp(unit) --by Xivia
    local unit = unit or myHero
    return(unit.ap + (unit.ap * unit.apPercent))
end

function CNami:isrecalling()
	if TargetHaveBuff("Recall", myHero) then return true end
	if TargetHaveBuff("OdinRecall", myHero) then return true end
	if TargetHaveBuff("recall", myHero) then return true end
	return false
end

function CNami:UPL()
	UPL:AddSpell(_Q, {speed = spells["Q"]["speed"], delay = spells["Q"]["delay"], range = spells["Q"]["range"], width = spells["Q"]["radius"], collision = false, aoe = true, type = "circular"})
	UPL:AddSpell(_R, {speed = spells["R"]["speed"], delay = spells["R"]["delay"], range = spells["R"]["range"], width = spells["R"]["width"], collision = false, aoe =  true, type = "linear"})
	UPL:AddToMenu2(self.cfg)
end

function CNami:S1mpleLibary()
	SL:SetLvLOrder({"W>E>Q>W>W>R>W>E>W>E>R>E>E>Q>Q>R>Q>Q", "Q>W>E>W>W>R>W>E>W>E>R>E>E>Q>Q>R>Q>Q"})
	SL:AddMenu(self.cfg)
	SL:setHuman(1,1.2)
end

function GetTarget()
	self.ts:update()
	if CuTarget then
		return CuTarget
	end
	if _G.AutoCarry and Veigar.other.sac and _G.AutoCarry.Crosshair:GetTarget() then
		return _G.AutoCarry.Crosshair:GetTarget()
	end
	return self.ts.target
end


--[[====================================================================]]
--[[====================================================================]]
--[[====================================================================]]
--[[====================================================================]]

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
	time = os.clock()
end

function CTarget:setTarget(msg, wParam)
	if msg == 513 and wParam == 5 then
		for _, v in pairs(GetEnemyHeros()) do
			local distance = sqrt(((v.x-mousePos.x)^2)+((v.z-mousePos.z)^2))
			if distance <= 150 then --Marks the enemy if he is in 150 Range
				if CuTarget ~= v and time < os.clock() then
					p("Selected: "..v.charName)
					CuTarget = v
					time = os.clock()+5
				end
			elseif CuTarget and time < os.clock() then
				p("Unselected Target")
				CuTarget = nil
				time = os.clock()+5
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

--[[====================================================================]]
--[[====================================================================]]
--[[====================================================================]]
--[[====================================================================]]


class('SUpdate')
function SUpdate:__init()
	self.updating = false
	self.updated = false
	AddDrawCallback(function ()
		self:draw()
	end)
	self:download()
end

function SUpdate:download()
	self.updating = true
	local serveradress = "www.s1mplescripts.de"
	local scriptadress = "/S1mple/Scripts/BolStudio/Nami"
	local ServerVersionDATA = GetWebResult(serveradress , scriptadress.."/S1mple_Nami.version")
	if ServerVersionDATA then
		local ServerVersion = tonumber(ServerVersionDATA)
		if ServerVersion then
			if ServerVersion > tonumber(version) then
				p("Updating, don't press F9")
				DownloadFile("http://"..serveradress..scriptadress.."/S1mple_Nami.lua",SCRIPT_PATH.."S1mple_Nami.lua", function ()
					updated = true
				end)
			end
		else
			p("An error occured, while updating, please reload")
		end
	else
		p("Could not connect to update Server")
	end
	self.updating = false
end

function SUpdate:draw()
	local w, h = WINDOW_W, WINDOW_H
	if self.updating then
		DrawTextA("[S1mple_Nami] Updating", 25, 10,h*0.05,ARGB(255,255,255,255), "left", "center")
	end
	if updated then
		DrawTextA("[S1mple_Nami] Updated, press 2xF9", 25, 10,h*0.05,ARGB(255,255,255,255), "left", "center")
	end
end



--[[ScriptStatus]]
assert(load(Base64Decode("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"), nil, "bt", _ENV))() ScriptStatus("SFIINLNEIHG") 
--[[END ScriptStatus]]
