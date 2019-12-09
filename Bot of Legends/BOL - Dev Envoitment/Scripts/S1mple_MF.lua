--[[
   _____ __                 _        __  __ _           ______         _                      _              _____ __                 _         _____           _       _       
  / ____/_ |               | |      |  \/  (_)         |  ____|       | |                    | |            / ____/_ |               | |       / ____|         (_)     | |      
 | (___  | |_ __ ___  _ __ | | ___  | \  / |_ ___ ___  | |__ ___  _ __| |_ _   _ _ __   ___  | |__  _   _  | (___  | |_ __ ___  _ __ | | ___  | (___   ___ _ __ _ _ __ | |_ ___ 
  \___ \ | | '_ ` _ \| '_ \| |/ _ \ | |\/| | / __/ __| |  __/ _ \| '__| __| | | | '_ \ / _ \ | '_ \| | | |  \___ \ | | '_ ` _ \| '_ \| |/ _ \  \___ \ / __| '__| | '_ \| __/ __|
  ____) || | | | | | | |_) | |  __/ | |  | | \__ \__ \ | | | (_) | |  | |_| |_| | | | |  __/ | |_) | |_| |  ____) || | | | | | | |_) | |  __/  ____) | (__| |  | | |_) | |_\__ \
 |_____/ |_|_| |_| |_| .__/|_|\___| |_|  |_|_|___/___/ |_|  \___/|_|   \__|\__,_|_| |_|\___| |_.__/ \__, | |_____/ |_|_| |_| |_| .__/|_|\___| |_____/ \___|_|  |_| .__/ \__|___/
                     | |                                                                             __/ |                     | |                               | |            
                     |_|                                                                            |___/                      |_|                               |_|            


Credits:
	patati157 for giving me an Account with Miss Fortune, and also requesting the Script
	nebelwolfie for the UPL and UOL Libary :)

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

--Using Collisions.lua
--

--[[Basic Stuff]]--
if not myHero then
	myHero = GetmyHero()
end
if myHero.charName ~= "MissFortune" then return end

--[[Script Status]]--




--[[Auto Updater Warning]]--
if _ENV.FILE_NAME ~= "S1mple_MF.lua" then
	print("[S1mple_MF] <font color=\"#570BB2\">Please rename ".._ENV.FILE_NAME.." to: S1mple_MF.lua</font>")
	return
end

--[[Get UPL]]
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
--[[Get UOL]]--
if not _G.UOLloaded then
  if FileExist(LIB_PATH .. "/UOL.lua") then
    require("UOL")
  else 
    print("Downloading UOL, please don't press F9")
    DelayAction(function() DownloadFile("https://raw.github.com/nebelwolfi/BoL/master/Common/UOL.lua".."?rand="..math.random(1,10000), LIB_PATH.."UOL.lua", function () print("Successfully downloaded UOL. Press F9 twice.") end) end, 3) 
    return
  end
end



--[[My p() function :)]]--
function p(arg)
	if arg ~= nil then
		print("[S1mple_MF] <font color=\"#570BB2\">"..arg.."</font>")
	end
end

--[[Localize Math]]--
local sqrt, max, deg, asin, cos, pi, floor, ceil, sin, huge, random, round = math.sqrt, math.max, math.deg, math.asin, math.cos, math.pi, math.floor, math.ceil, math.sin, math.huge, math.random, math.round

--[[Pseudo Global Vars]]--
local version = "0.1"
local updated = false
local CuTarget = nil

--[[Spell Table]]--
local spells = {
	["E"] = {delay = 0.25, range = 1000, witdh = 2000, speed = huge},
	["R"] = {delay = 0.25, range = 1400, witdh = 100, speed = 780}
}

local dmg = {

}

DelayAction( function() if not _G.S1mple_MFloaded then MF() end end, 0.05)

class("MF")
function MF:__init()
	p("loading")
	SUpdate()
	CTarget()

	self.ts = TargetSelector(TARGET_LESS_CAST, 900, DAMAGE_MAGIC, true)
	self.ts.name = "Target Selector"
	self:Config()

	AddTickCallback(function ()
		self:tick()
	end)
	AddDrawCallback(function ()
		self:draw()
	end)
	
	_G.S1mple_MFloaded = true
	p("loaded")
end

function MF:Config()
	if updated then return end
	self.cfg = scriptConfig("S1mple_MF", "s1mple_mf")
	self.cfg:addSubMenu("Spell Settings", "spell")
		self.cfg.spell:addSubMenu("Double Up", "q")
			self.cfg.spell.q:addParam("inf1", "------Combo Mode Settings------", SCRIPT_PARAM_INFO, "")
			self.cfg.spell.q:addParam("combo", "Use", SCRIPT_PARAM_ONOFF, true)
			self.cfg.spell.q:addParam("combominmana", "Min Mana (Percentage)",SCRIPT_PARAM_SLICE,30,0,100)
			self.cfg.spell.q:addParam("combofocus", "Focus Champions", SCRIPT_PARAM_ONOFF, true)

			self.cfg.spell.q:addParam("inf2", "------Harras Mode Settings------", SCRIPT_PARAM_INFO, "")
			self.cfg.spell.q:addParam("harras", "Use", SCRIPT_PARAM_ONOFF, true)
			self.cfg.spell.q:addParam("harrasminmana", "Min Mana (Percentage)",SCRIPT_PARAM_SLICE,30,0,100)
			self.cfg.spell.q:addParam("combofocus", "Focus Champions", SCRIPT_PARAM_ONOFF, true)

			self.cfg.spell.q:addParam("inf3", "------Laneclear Mode Settings------", SCRIPT_PARAM_INFO, "")
			self.cfg.spell.q:addParam("laneclear", "Use against Champions", SCRIPT_PARAM_ONOFF, false)
			self.cfg.spell.q:addParam("laneclearminmana", "Min Mana (Percentage)",SCRIPT_PARAM_SLICE,30,0,100)
			self.cfg.spell.q:addParam("combofocus", "Focus Champions", SCRIPT_PARAM_ONOFF, true)





	--Adding UPL & UOL
	self.cfg:addSubMenu("Orb Walker","orb")
		UOL:AddToMenu(self.cfg.orb)


	UPL:AddSpell(_E, {speed = spells["E"]["speed"], delay = spells["E"]["delay"], range = spells["E"]["range"], width = spells["E"]["witdh"], collision = false, aoe = true, type = "circular"})
	UPL:AddSpell(_R, {speed = spells["R"]["speed"], delay = spells["R"]["delay"], range = spells["R"]["range"], width = spells["R"]["witdh"], collision = false, aoe = true, type = "cone"})
	UPL:AddToMenu2(self.cfg)
end




function MF:draw()
	if updated then return end
	for i = 1, objManager.maxObjects do
        local object = objManager:GetObject(i)
        if ValidTarget(object, 650) then
        	DrawText3D("Valid Target", object.x, object.y, object.z,12, ARGB(255,255,255,255))
        end
    end
end

function MF:tick()
	if updated then return end
	--soon
end


function MF:get2ndQTarget(firsttarget)
	

	local prio = huge
	local target = nil
	for _, v in pairs(objects) do
		if GetTriangle(firsttarget, 40, v) and TargetHaveBuff("missfortunepassivestack", v) and v.type == myHero.type then
			if prio > 1 then
				target = v
				prio = 1
			end
		elseif GetTriangle(firsttarget, 20, v) and v.type ~= myHero.type then
			if prio > 2 then
				target = v
				prio = 2
			end
		elseif GetTriangle(firsttarget, 20, v) and v.type == myHero.type then
			if prio > 3 then
				target = v
				prio = 3
			end
		elseif GetTriangle(firsttarget, 40, v) and v.type ~= myHero.type then
			if prio > 4 then
				target = v
				prio = 4
			end
		elseif GetTriangle(firsttarget, 40, v) and v.type == myHero.type then
			if prio > 5 then
				target = v
				prio = 5
			end
		elseif GetTriangle(firsttarget, 110, v) and v.type ~= myHero.type then
			if prio > 6 then
				target = v
				prio = 6
			end
		elseif GetTriangle(firsttarget, 160, v) and v.type ~= myHero.type and GetDistance(v, myHero) <= 150 then
			if prio > 7 then
				target = v
				prio = 7
			end
		end
	end
	return target
end




function GetTriangle(triangle_target, angle, unit)
	if triangle_target == nil or unit == nil or GetDistanceSqr(unit, triangle_target) > 500 * 500 or GetDistanceSqr(myHero, triangle_target) > 650 * 650 then return end

	v1 = (Vector(triangle_target) - Vector(myHero)):rotated(0, angle / (180 * math.pi), 0):normalized()
	v2 = (Vector(triangle_target) - Vector(myHero)):rotated(0, -(angle / (180 * math.pi)), 0):normalized()
	triangle = Polygon(Point(triangle_target.x, triangle_target.z), Point(triangle_target.x + 300 * v1.x, triangle_target.z + 300 * v1.z), Point(triangle_target.x + 300 * v2.x, triangle_target.z + 300 * v2.z))

	if triangle:contains(Point(unit.x, unit.z)) then
		return true
	else
		return false
	end
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

function SUpdate:download( ... )
	self.updating = true
	local serveradress = "scarjit.de"
	local scriptadress = "/S1mpleScripts/Scripts/BolStudio/MF"
	local ServerVersionDATA = GetWebResult(serveradress , scriptadress.."/S1mple_MF.version")
	if ServerVersionDATA then
		local ServerVersion = tonumber(ServerVersionDATA)
		if ServerVersion then
			if ServerVersion > tonumber(version) then
				p("Updating, don't press F9")
				DownloadFile("http://"..serveradress..scriptadress.."/S1mple_MF.lua",SCRIPT_PATH.."S1mple_MF.lua", function ()
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
		DrawTextA("[S1mple_MF] Updating", 25, 10,h*0.05,ARGB(255,255,255,255), "left", "center")
	end
	if updated then
		DrawTextA("[S1mple_MF] Updated, press 2xF9", 25, 10,h*0.05,ARGB(255,255,255,255), "left", "center")
	end
end