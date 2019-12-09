--[[
   _____ __                 _        __  __                                     _              _____      _                      _           _ 
  / ____/_ |               | |      |  \/  |                                   | |            |  __ \    (_)                    | |         | |
 | (___  | |_ __ ___  _ __ | | ___  | \  / | _____   _____ _ __ ___   ___ _ __ | |_           | |__) |___ _ _ ____   _____ _ __ | |_ ___  __| |
  \___ \ | | '_ ` _ \| '_ \| |/ _ \ | |\/| |/ _ \ \ / / _ \ '_ ` _ \ / _ \ '_ \| __|          |  _  // _ \ | '_ \ \ / / _ \ '_ \| __/ _ \/ _` |
  ____) || | | | | | | |_) | |  __/ | |  | | (_) \ V /  __/ | | | | |  __/ | | | |_           | | \ \  __/ | | | \ V /  __/ | | | ||  __/ (_| |
 |_____/ |_|_| |_| |_| .__/|_|\___| |_|  |_|\___/ \_/ \___|_| |_| |_|\___|_| |_|\__|          |_|  \_\___|_|_| |_|\_/ \___|_| |_|\__\___|\__,_|
                     | |                                                              ______                                                   
                     |_|                                                             |______|                                                  
]]--

assert(load(Base64Decode("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"), nil, "bt", _ENV))() ScriptStatus("TGJKHLGLLLI") 

if not _G.NebelwolfisOrbWalkerInit then
  if FileExist(LIB_PATH .. "/Nebelwolfi's Orb Walker.lua") then
    require "Nebelwolfi's Orb Walker"
  else 
    print("Downloading Nebelwolfi's Orb Walker, please don't press F9")
    DelayAction(function() DownloadFile("https://raw.githubusercontent.com/nebelwolfi/BoL/master/Common/Nebelwolfi%27s%20Orb%20Walker.lua".."?rand="..math.random(1,10000), LIB_PATH.."Nebelwolfi's Orb Walker.lua.lua", function () print("Successfully downloaded Nebelwolfi's Orb Walker. Press F9 twice.") end) end, 3) 
    return
  end
end


function OnLoad()
	version = 0.5
	range = myHero.range+GetDistance(myHero.minBBox,myHero)-50
	enemyHeros = GetEnemyHeroes()
	enemyMinions = minionManager(MINION_ENEMY, range+50, player, MINION_SORT_HEALTH_ASC)
	jungleMinions = minionManager(MINION_JUNGLE, range+50, player, MINION_SORT_HEALTH_ASC)
	waypoint = {
		x = myHero.x,
		z = myHero.z
	}
	aamodes = {"None", "Minions", "Minions+Jungle", "Minions+Jungle+Buildings"}
	orbmodes = {"None", "Harras", "Laneclear", "Lasthit", "SBTW"}
	windUpTime = 0
	iswindingUP = false

	Menu()

	--Init Classes
	LoadClasses()
	print("Movement Reinvented Loaded")
end

function LoadClasses()
	if not _G.NebelwolfisOrbWalkerLoaded then
		DelayAction(function ()
			LoadClasses()
		end,0.25)
	end
	M = Move()
	O = Orb()
	Mouse()
	Tower()
end


function OnDraw()
	DrawHitBox(myHero, 1, ARGB(255,255,255,255))
	DrawCircle3D(myHero.x,myHero.y,myHero.z,range)
	if menu.draw.movePos then
		DrawLine3D(myHero.x,myHero.y,myHero.z,waypoint.x,myHero.y,waypoint.z,1,ARGB(255,255,255,255))
	end
	DrawTextA(iswindingUP)
	DrawTextA(aamodes[menu.aamode], 25,50,50)
	DrawTextA(orbmodes[menu.orbmode], 25,50,100)

end

function Menu()
	menu = scriptConfig("Movement Reinvented", "S1mple_MR")
		menu:addSubMenu("Key Settings", "key")
			menu.key:addParam("up", "UP", SCRIPT_PARAM_ONKEYDOWN, false, 104)
			menu.key:addParam("left", "LEFT", SCRIPT_PARAM_ONKEYDOWN, false, 100)
			menu.key:addParam("down", "DOWN", SCRIPT_PARAM_ONKEYDOWN, false, 98)
			menu.key:addParam("right", "RIGHT", SCRIPT_PARAM_ONKEYDOWN, false, 102)

			menu.key:addParam("upleft", "UPLEFT", SCRIPT_PARAM_ONKEYDOWN, false, 103)
			menu.key:addParam("upright", "UPRIGHT", SCRIPT_PARAM_ONKEYDOWN, false, 105)
			menu.key:addParam("downleft", "DOWNLEFT", SCRIPT_PARAM_ONKEYDOWN, false, 97)
			menu.key:addParam("downright", "DOWNRIGHT", SCRIPT_PARAM_ONKEYDOWN, false, 99)

			menu.key:addParam("inf1", "<><><><><><><><><><>", SCRIPT_PARAM_INFO, "")
			menu.key:addParam("orbkey", "Change OrbMode", SCRIPT_PARAM_ONKEYDOWN, false, 101)

	menu:addSubMenu("Draws", "draw")
		menu.draw:addParam("movePos", "Draw Move Pos", SCRIPT_PARAM_ONOFF, true)


	menu:addParam("chkwall", "Check for Walls", SCRIPT_PARAM_ONOFF,true)
	menu:addParam("mouseMovement", "Allow Mouse Movement", SCRIPT_PARAM_ONOFF, true)
	menu:addParam("aamode", "AA Target Selector", SCRIPT_PARAM_LIST, 2, aamodes)
	menu:addParam("orbmode", "OrbWalker Mode", SCRIPT_PARAM_LIST, 1, orbmodes)

	local down = true
	menu.key:setCallback("orbkey", function ()
		if down == true then
			down = false
			if menu.orbmode ~= 5 then
				menu.orbmode = menu.orbmode + 1
			else
				menu.orbmode = 1
			end
		else
			down = true
		end
	end)

	menu:addSubMenu("Orbwalker", "orb")
		NebelwolfisOrbWalkerClass(menu.orb)
end

class("Move")
function Move:__init()
	self.movedir = ""
	self.movementallowed = true
	AddTickCallback(function ()
		self:GetMoveDir()
		self:SetMovePoint()
	end)
end

function Move:GetMoveDir()
	if iswindingUP then return end
	movedir = ""
	if menu.key.up then
		if menu.key.left then
			movedir = "ul"
		elseif menu.key.right then
			movedir = "ur"
		elseif menu.key.upright then
			movedir = "uur"
		elseif menu.key.upleft then
			movedir = "uul"
		else
			movedir = "u"
		end
	end

	if menu.key.down then
		if menu.key.left then
			movedir = "dl"
		elseif menu.key.right then
			movedir = "dr"
		elseif menu.key.downright then
			movedir = "ddr"
		elseif menu.key.downleft then
			movedir = "ddl"
		else
			movedir = "d"
		end
	end

	if not menu.key.up and not menu.key.down then
		if menu.key.left then
			if menu.key.upleft then
				movedir = "llu"
			elseif menu.key.downleft then
				movedir = "lld"
			else
				movedir = "l"
			end
		elseif menu.key.right then
			if menu.key.upright then
				movedir = "rru"
			elseif menu.key.downright then
				movedir = "rrd"
			else
				movedir = "r"
			end
		end
	end
	if movedir == "" then
		if menu.key.upleft then
			movedir = "llu"
		elseif menu.key.downleft then
			movedir = "lld"
		elseif menu.key.upright then
			movedir = "rru"
		elseif menu.key.downright then
			movedir = "rrd"
		end
	end
end

function Move:SetMovePoint(m)
	if iswindingUP then return end
	if not _G.NebelwolfisOrbWalkerLoaded then return end
	local movelenght = m or 250
	if movedir == "u" then
		self:DoMove(myHero.x, myHero.z+movelenght,movelenght)

		waypoint.x = myHero.x
		waypoint.z = myHero.z+movelenght
	elseif movedir == "d" then
		self:DoMove(myHero.x, myHero.z-movelenght,movelenght)

		waypoint.x = myHero.x
		waypoint.z = myHero.z-movelenght
	elseif movedir == "l" then
		self:DoMove(myHero.x-movelenght, myHero.z,movelenght)

		waypoint.x = myHero.x-movelenght
		waypoint.z = myHero.z
	elseif movedir == "r" then
		self:DoMove(myHero.x+movelenght, myHero.z,movelenght)

		waypoint.x = myHero.x+movelenght
		waypoint.z = myHero.z
	elseif movedir == "ul" then
		self:DoMove(myHero.x-movelenght, myHero.z+movelenght,movelenght)

		waypoint.x = myHero.x-movelenght
		waypoint.z = myHero.z+movelenght
	elseif movedir == "ur" then
		self:DoMove(myHero.x+movelenght, myHero.z+movelenght,movelenght)

		waypoint.x = myHero.x+movelenght
		waypoint.z = myHero.z+movelenght
	elseif movedir == "dl" then
		self:DoMove(myHero.x-movelenght, myHero.z-movelenght,movelenght)

		waypoint.x = myHero.x-movelenght
		waypoint.z = myHero.z-movelenght
	elseif movedir == "dr" then
		self:DoMove(myHero.x+movelenght, myHero.z-movelenght,movelenght)

		waypoint.x = myHero.x+movelenght
		waypoint.z = myHero.z-movelenght

	elseif movedir == "uur" then
		self:DoMove(myHero.x+movelenght/2, myHero.z+movelenght,movelenght)
		waypoint.x = myHero.x+movelenght/2
		waypoint.z = myHero.z+movelenght
	elseif movedir == "uul" then
		self:DoMove(myHero.x-movelenght/2, myHero.z+movelenght,movelenght)
		waypoint.x = myHero.x-movelenght/2
		waypoint.z = myHero.z+movelenght

	elseif movedir == "ddr" then
		self:DoMove(myHero.x+movelenght/2, myHero.z-movelenght,movelenght)
		waypoint.x = myHero.x+movelenght/2
		waypoint.z = myHero.z-movelenght
	elseif movedir == "ddl" then
		self:DoMove(myHero.x-movelenght/2, myHero.z-movelenght,movelenght)
		waypoint.x = myHero.x-movelenght/2
		waypoint.z = myHero.z-movelenght

	elseif movedir == "llu" then
		self:DoMove(myHero.x-movelenght, myHero.z+movelenght/2,movelenght)
		waypoint.x = myHero.x-movelenght
		waypoint.z = myHero.z+movelenght/2

	elseif movedir == "lld" then
		self:DoMove(myHero.x-movelenght, myHero.z-movelenght/2,movelenght)
		waypoint.x = myHero.x-movelenght
		waypoint.z = myHero.z-movelenght/2

	elseif movedir == "rru" then
		self:DoMove(myHero.x+movelenght, myHero.z+movelenght/2,movelenght)
		waypoint.x = myHero.x+movelenght
		waypoint.z = myHero.z+movelenght/2

	elseif movedir == "rrd" then
		self:DoMove(myHero.x+movelenght, myHero.z-movelenght/2,movelenght)
		waypoint.x = myHero.x+movelenght
		waypoint.z = myHero.z-movelenght/2

	elseif self.movementallowed and not iswindingUP then
		--Extend to check for mouse
		myHero:HoldPosition()
		waypoint.x = myHero.x
		waypoint.z = myHero.z
	end
end


function Move:DoMove(x,y,m)

	local d3vec = D3DXVECTOR3(x, myHero.y, y)
	if IsWall(d3vec) and menu.chkwall and m > 125 then
		Move:SetMovePoint(m/2)
	elseif not iswindingUP then
		myHero:MoveTo(x+math.round(-1,1),y+math.round(-1,1))
	end
	self.movementallowed = true
end

class("Mouse")
function Mouse:__init()
	AddMsgCallback(function(msg, wParam)
		self:GetMouseClick(msg, wParam)
	end)
end

function Mouse:GetMouseClick(msg, wParam)
	if not _G.NebelwolfisOrbWalkerLoaded then return end
	if not menu.mouseMovement then
		myHero:HoldPosition()
		return
	end

	if msg == 516 and wParam == 2 then
		M.movementallowed = false
		myHero:MoveTo(mousePos.x, mousePos.z)
		waypoint.x = mousePos.x
		waypoint.z = mousePos.z
	elseif msg == 513 and wParam == 1 then
		local mpX = mousePos.x
		local mpZ = mousePos.z
		if self:findAttackCursor(mpX, mpZ) then
			M.movementallowed = false
			--myHero:MoveTo(mpX, mpZ)
			local pos = {mpX, myHero.y, mpZ}
			_G.NebelwolfisOrbWalker:ForcePos(pos)
			waypoint.x = mpX
			waypoint.z = mpZ
		else
			DelayAction(function ()
				if self:findAttackCursor(mpX, mpZ) then
					M.movementallowed = false
					--myHero:MoveTo(mpX, mpZ)
					local pos = {mpX, myHero.y, mpZ}
					_G.NebelwolfisOrbWalker:ForcePos(pos)
					waypoint.x = mpX
					waypoint.z = mpZ
				end
			end, 0.2)
		end
	end
end

function Mouse:findAttackCursor(x,y)
	for i = 1, objManager.maxObjects do
		local obj = objManager:GetObject(i)
		if obj and GetDistance(mousePos, obj) <= 500 and obj.name and obj.name == "Cursor_MoveTo_Red.troy" then
			return true
		end
	end
end


local target = nil
local nextAA = 0
class("Orb")
function Orb:__init()
	AddTickCallback(function ()
		Orb:GetTarget()
		Orb:AA()
	end)
	AddDrawCallback(function ()
		Orb:Draw()
	end)
	_G.NebelwolfisOrbWalker:AddCallback(AFTER_ATTACK, function() self:setAACD() end)
end

local stop = false
function Orb:Setwindfalse()
	if isWindingUp and stop == false then
		stop = true
		DelayAction(function ()
			isWindingUp = false
			stop = false
		end,0.25+windUpTime)
	end
end

function Orb:Draw()
	if target then
		DrawCircle3D(target.x,target.y,target.z,50,1)
	end
end

function Orb:AA()
	if not _G.NebelwolfisOrbWalkerLoaded then return end
	if target and _G.NebelwolfisOrbWalker:CanOrbTarget(target) and os.clock() >= nextAA and not isWindingUp then
		if menu.orbmode == 3 then --Laneclear
			iswindingUP = true
			myHero:Attack(target)
			DelayAction(function ()
       	 		iswindingUP = false
        	end, 0.25+windUpTime)
        elseif menu.orbmode == 2 then --Harras
        	if target.type == myHero.type then
        		iswindingUP = true
				myHero:Attack(target)
				DelayAction(function ()
       	 			iswindingUP = false
        		end, 0.25+windUpTime)
        	elseif target.health <= myHero.addDamage*1.3 then
        		iswindingUP = true
				myHero:Attack(target)
				DelayAction(function ()
       	 			iswindingUP = false
        		end, 0.25+windUpTime)
        	end
        elseif menu.orbmode == 4 then --Lasthit
        	if target.health <= myHero.addDamage*1.3 then
        		iswindingUP = true
				myHero:Attack(target)
				DelayAction(function ()
       	 			iswindingUP = false
        		end, 0.25+windUpTime)
        	end
        elseif menu.orbmode == 5 then --SBTW
        	iswindingUP = true
			myHero:Attack(target)
			DelayAction(function ()
       	 		iswindingUP = false
        	end, 0.25+windUpTime)
        end
	end
end

--aamodes = {"None", "Minions", "Minions+Jungle", "Minions+Jungle+Turrets"}
--orbmodes = {"None", "Harras", "Laneclear", "Lasthit", "SBTW"}

function Orb:GetTarget()
	if not _G.NebelwolfisOrbWalkerLoaded then return end
	if menu.orbmode == 1 then return end
	if (menu.orbmode == 3 or menu.orbmode == 4) and menu.aamode == 1 then return end

	target = nil
	if _G.NebelwolfisOrbWalker:GetTarget() and (menu.orbmode == 2 or menu.orbmode == 5) then
		target = _G.NebelwolfisOrbWalker:GetTarget()
	end
	if GetDistance(target) > range then target = nil end

	if menu.orbmode == 3 or menu.orbmode == 4 or menu.orbmode == 2 then
		if target == nil then
			enemyMinions:update()
			for index, minion in pairs(enemyMinions.objects) do
				if _G.NebelwolfisOrbWalker:PredictHealth(minion, 0.25) > 0 then
					if not target then
						target = minion
					elseif minion.health < target.health then
						target = minion
					end
				end
			end
		end
		if not target and menu.aamode >= 3 then
			jungleMinions:update()
			for index, minion in pairs(jungleMinions.objects) do
				if _G.NebelwolfisOrbWalker:PredictHealth(minion, 0.25) > 0 then
					if not target then
						target = minion
					elseif minion.health < target.health then
						target = minion
					end
				end
			end
		end
	end

	if not target and menu.aamode == 4 then
		Tower:update()
		for index, minion in pairs(turrets) do
			if _G.NebelwolfisOrbWalker:PredictHealth(minion, 0.25) > 0 then
				if not target then
					target = minion
				elseif minion.health < target.health then
					target = minion
				end
			end
		end
	end
end

function Orb:setAACD()
	local aas = 1/_G.NebelwolfisOrbWalker:GetAttackSpeed()
	nextAA = os.clock()+aas
end

function OnAnimation(unit, animation)
    if unit.isMe and animation:find("Attack") then
        local spellProc = unit.spell
        
        windUpTime = spellProc.windUpTime
        iswindingUP = true
        DelayAction(function ()
        	iswindingUP = false
        end, 0.25+windUpTime)
    end
end

turrets = {}
class('Tower')
function Tower:__init()
	for i = 1, objManager.iCount do
        local turret = objManager:getObject(i)
        if turret and turret.valid and turret.team == TEAM_ENEMY and (turret.type == "obj_AI_Turret" or turret.type == "obj_BarracksDampener" or turret.type == "obj_HQ") and not string.find(turret.name, "TurretShrine") then
            table.insert(turrets, turret)
        end
    end
end

function Tower:update()
	local temptower = {}
	for _, v in pairs(turrets) do
		if v and v.valid and not v.dead then
			temptower[#temptower+1] = v
		end
	end
	turrets = temptower
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
	local scriptadress = "/S1mple/Scripts/BolStudio/MovementReinvented"
	local ServerVersionDATA = GetWebResult(serveradress , scriptadress.."/Movement_Reinvented.version")
	if ServerVersionDATA then
		local ServerVersion = tonumber(ServerVersionDATA)
		if ServerVersion then
			if ServerVersion > tonumber(version) then
				print("Updating, don't press F9")
				DownloadFile("http://"..serveradress..scriptadress.."/Movement_Reinvented.lua",SCRIPT_PATH.."Movement_Reinvented.lua", function ()
					updated = true
				end)
			end
		else
			print("An error occured, while updating, please reload")
		end
	else
		print("Could not connect to update Server")
	end
	self.updating = false
end

function SUpdate:draw()
	local w, h = WINDOW_W, WINDOW_H
	if self.updating then
		DrawTextA("[Movement_Reinvented] Updating", 25, 10,h*0.05,ARGB(255,255,255,255), "left", "center")
	end
	if updated then
		DrawTextA("[Movement_Reinvented] Updated, press 2xF9", 25, 10,h*0.05,ARGB(255,255,255,255), "left", "center")
	end
end


