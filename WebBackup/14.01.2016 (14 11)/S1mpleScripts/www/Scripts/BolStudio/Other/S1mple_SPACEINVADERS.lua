--[[
   _____ __                 _         _____ _____        _____ ______   _____ _   ___      __     _____  ______ _____   _____   _              _____ __                 _       _____           _       _       
  / ____/_ |               | |       / ____|  __ \ /\   / ____|  ____| |_   _| \ | \ \    / /\   |  __ \|  ____|  __ \ / ____| | |            / ____/_ |               | |     / ____|         (_)     | |      
 | (___  | |_ __ ___  _ __ | | ___  | (___ | |__) /  \ | |    | |__      | | |  \| |\ \  / /  \  | |  | | |__  | |__) | (___   | |__  _   _  | (___  | |_ __ ___  _ __ | | ___| (___   ___ _ __ _ _ __ | |_ ___ 
  \___ \ | | '_ ` _ \| '_ \| |/ _ \  \___ \|  ___/ /\ \| |    |  __|     | | | . ` | \ \/ / /\ \ | |  | |  __| |  _  / \___ \  | '_ \| | | |  \___ \ | | '_ ` _ \| '_ \| |/ _ \\___ \ / __| '__| | '_ \| __/ __|
  ____) || | | | | | | |_) | |  __/  ____) | |  / ____ \ |____| |____   _| |_| |\  |  \  / ____ \| |__| | |____| | \ \ ____) | | |_) | |_| |  ____) || | | | | | | |_) | |  __/____) | (__| |  | | |_) | |_\__ \
 |_____/ |_|_| |_| |_| .__/|_|\___| |_____/|_| /_/    \_\_____|______| |_____|_| \_|   \/_/    \_\_____/|______|_|  \_\_____/  |_.__/ \__, | |_____/ |_|_| |_| |_| .__/|_|\___|_____/ \___|_|  |_| .__/ \__|___/
                     | |                                                                                                               __/ |                     | |                             | |            
                     |_|                                                                                                              |___/                      |_|                             |_|            
]]--
local version = 0.7

--ScriptStatus
assert(load(Base64Decode("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"), nil, "bt", _ENV))() ScriptStatus("QDGHDIKDLCJ") 
--End ScriptStatus

-- http://bol-tools.com/ tracker
assert(load(Base64Decode("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"), nil, "bt", _ENV))()
TrackerLoad("cIh8Aqf33Fh5GtKO")

function OnLoad()
	menu()
	init()
	DelayAction(function ()
		SUpdate()
	end,1)
end

function init()
	paused = true
	score = 0 --On Kill: self.score = self.score + self.difficulty/5
	time = 0
	difficulty = 5 --Increase Metroid Spawn Rate based on this (Min 1, Max Unlimited)
	kills = 0
	MisslesFired = 0

	Missles = {}
	Astroids = {}

	PShip = Ship()
end

function menu()
	menu = scriptConfig("SpaceInvader", "SI")
		menu:addParam("alive", "Enable when alive", SCRIPT_PARAM_ONOFF, false)

		menu:addSubMenu("Key Settings", "key")

		menu.key:addParam("info0", "----Control Keys----", SCRIPT_PARAM_INFO, "")
			menu.key:addParam("newgame", "New Game Key", SCRIPT_PARAM_ONKEYDOWN, false, 78)
			menu.key:addParam("updifficulty", "Increase Difficulty", SCRIPT_PARAM_ONKEYDOWN, false, 107)
			menu.key:addParam("lowerdifficulty", "Decrease Difficulty", SCRIPT_PARAM_ONKEYDOWN, false, 109)

		menu.key:addParam("sep", "", SCRIPT_PARAM_INFO, "")

		menu.key:addParam("info0", "----InGame Keys----", SCRIPT_PARAM_INFO, "")
			menu.key:addParam("shoot", "Shoot", SCRIPT_PARAM_LIST, 1, {"Mouse Left", "Mouse Right", "SPACE"})

			menu.key:addParam("up", "UP", SCRIPT_PARAM_ONKEYDOWN, false, 38)
			menu.key:addParam("left", "LEFT", SCRIPT_PARAM_ONKEYDOWN, false, 37)
			menu.key:addParam("right", "RIGHT", SCRIPT_PARAM_ONKEYDOWN, false, 39)
			menu.key:addParam("down", "DOWN", SCRIPT_PARAM_ONKEYDOWN, false, 40)

		menu.key:addParam("sep", "", SCRIPT_PARAM_INFO, "")

		menu.key:addParam("info1", "----Default Keys----", SCRIPT_PARAM_INFO, "")
			menu.key:addParam("info2", "New Game:  N", SCRIPT_PARAM_INFO, "(78)")
			menu.key:addParam("info3", "Increase Difficulty:  + (Numpad)", SCRIPT_PARAM_INFO, "(107)")
			menu.key:addParam("info4", "Decrease Difficulty:  - (Numpad)", SCRIPT_PARAM_INFO, "(109)")

			menu.key:addParam("info5", "UP:  Arrow UP", SCRIPT_PARAM_INFO, "(38)")
			menu.key:addParam("info6", "LEFT:  Arrow LEFT", SCRIPT_PARAM_INFO, "(37)")
			menu.key:addParam("info7", "RIGHT:  Arrow RIGHT", SCRIPT_PARAM_INFO, "(39)")
			menu.key:addParam("info8", "DOWN:  Arrow DOWN", SCRIPT_PARAM_INFO, "(40)")

		menu:addSubMenu("Game Settings", "game")
			menu.game:addParam("maxast", "Max Astroids on the Field", SCRIPT_PARAM_SLICE, 15, 1, 99)
			menu.game:addParam("ownSpeed", "Own Speed", SCRIPT_PARAM_SLICE, 0.5, 1, 20)
			menu.game:addParam("rof", "Recharge Delay", SCRIPT_PARAM_SLICE , 50, 1, 100)
			menu.game:addParam("hyper", "HYPER SPEED", SCRIPT_PARAM_ONOFF, false)
			menu.game:addParam("missileSpeed", "Missle Speed", SCRIPT_PARAM_SLICE, 0.5, 1, 20)
			menu.game:addParam("astroidSpeed", "Max Astroid Speed", SCRIPT_PARAM_SLICE, 0.5, 1, 20)
end

local lastcommand = 0
function OnTick()
	pause()
	if paused then return end

	if menu.key.updifficulty then
		if lastcommand + 0.25 < os.clock() then
			lastcommand = os.clock()
			if difficulty <= 9 then
				difficulty = difficulty + 1
			end
		end
	end

	if menu.key.lowerdifficulty then
		if lastcommand + 0.25 < os.clock() then
			lastcommand = os.clock()
			if difficulty >= 1 then
				difficulty = difficulty - 1
			end
		end
	end

	if menu.key.newgame then
		if lastcommand + 0.25 < os.clock() then
			lastcommand = os.clock()
			newgame()
		end
	end

	if not PShip.hascollided then
		time = time + 1
		createastroid()
		cleararrays()
		checkcollision()
	end
end

function OnDraw()
	if paused then return end
	--[[
	DrawTextA("paused: "..tostring(paused), 18, 20 ,20)
	DrawTextA("score: "..score, 18, 20 ,40)
	DrawTextA("time: "..time, 18, 20 ,60)
	DrawTextA("difficulty: "..difficulty, 18, 20 ,80)
	DrawTextA("kills: "..kills, 18, 20 ,100)
	DrawTextA("MisslesFired: "..MisslesFired, 18, 20 ,120)
	DrawTextA("#Missles "..#Missles, 18, 20 ,140)
	DrawTextA("#Astroids "..#Astroids, 18, 20 ,160)
	]]--
	
	DrawTextA("Difficulty: "..difficulty, 18, 20 ,80)
	DrawTextA("Score: "..score, 18, 20 ,100)

	if PShip.hascollided then
		DrawTextA("GAME OVER", 35, WINDOW_W/2-90, 200)
		DrawTextA("SCORE: "..score,35, WINDOW_W/2-90, 230)

		DrawTextA("You have killed "..kills.." Astroids", 25, WINDOW_W/2-90, 275)
		DrawTextA("Missles Fired: "..MisslesFired, 25, WINDOW_W/2-90, 2300)
		DrawTextA("You have survived: "..time.." Cycles", 25, WINDOW_W/2-90, 325)

	else
		score = math.round(kills*(difficulty/3)+(time/10000))
	end
end

function pause()
	if myHero.dead == false and menu.alive == false then
		paused = true
	elseif myHero.dead == false and menu.alive == true then
		paused = false
	elseif myHero.dead == true then
		paused = false
	end
end

function newgame()
	print("New Game Started")
	for _, v in pairs(Missles) do
		v.hascollided = true
		v = nil
	end
	for _, v in pairs(Astroids) do
		v.hascollided = true
		v = nil
	end
	Missles = {}
	Astroids = {}
	PShip.x = WINDOW_W/2
	PShip.y = WINDOW_H/2
	PShip.hascollided = false
	score = 0
	MisslesFired = 0
	time = 0
end


local lastastroid = 0
function createastroid()
	if paused then return end
	if lastastroid + (10/difficulty) < os.clock() and #Astroids <= menu.game.maxast then
			lastastroid = os.clock()
			local startX = 0
			local startY = 0
			local endX = WINDOW_W
			local endY = WINDOW_H
			--[[
			Top, Bottom, Left, Right
			0,0 top left
			WINDOW_W, WINDOW_H bot right
			]]--

			local startPos = math.round(math.random(0,3))

			if startPos == 0 then --Top
				startX = math.random(0,WINDOW_W)
				startY = 0
			elseif startPos == 1 then --Bot
				startX = math.random(0,WINDOW_W)
				startY = WINDOW_H
			elseif startPos == 2 then --Left
				startX = 0
				startY = math.random(0, WINDOW_H)
			elseif startPos == 3 then --Right
				startX = WINDOW_W
				startY = math.random(0, WINDOW_H)
			end

			local endPos = math.round(math.random(0,3))
			while endPos == startPos do
				endPos = math.round(math.random(0,3))
			end
			if endPos == 0 then --Top
				endX = math.random(0,WINDOW_W)
				endY = 0
			elseif endPos == 1 then --Bot
				endX = math.random(0,WINDOW_W)
				endY = WINDOW_H
			elseif endPos == 2 then --Left
				endX = 0
				endY = math.random(0, WINDOW_H)
			elseif endPos == 3 then --Right
				endX = WINDOW_W
				endY = math.random(0, WINDOW_H)
			end

			local speed = math.random(0.5, menu.game.astroidSpeed)
			local size = math.random(10,70)/speed
			local a = Astroid(startX,startY,endX,endY,size, speed)
			Astroids[#Astroids+1] = a
	end
end

function cleararrays()
	if paused then return end
	local temp = {}
	for v, k in pairs(Missles) do
		if OnScreen(k.x, k.y) then
			temp[#temp+1] = k
		else
			k.hascollided = true
			k = nil
		end
	end
	Missles = {}
	Missles = temp

	temp = {}
	for v, k in pairs(Astroids) do
		if OnScreen(k.x, k.y) then
			temp[#temp+1] = k
		else
			k.hascollided = true
			k = nil
		end
	end
	Astroids = {}
	Astroids = temp
end

function checkcollision()
	if paused or PShip.hascollided then return end
	for k, v in pairs(Missles) do
		for k2, v2 in pairs(Astroids) do
			if v then
				local distance = math.sqrt((v.x-v2.x)^2+(v.y-v2.y)^2)
				if distance < v2.size+6 and not v.hascollided and not v2.hascollided then
					v.hascollided = true
					v2.hascollided = true
					kills = kills + 1
					if v2.size > 10 then

						local endPos = math.round(math.random(0,3))
						if endPos == 0 then --Top
							endX = math.random(0,WINDOW_W)
							endY = 0
						elseif endPos == 1 then --Bot
							endX = math.random(0,WINDOW_W)
							endY = WINDOW_H
						elseif endPos == 2 then --Left
							endX = 0
							endY = math.random(0, WINDOW_H)
						elseif endPos == 3 then --Right
							endX = WINDOW_W
							endY = math.random(0, WINDOW_H)
						end

						local a = Astroid(v2.x, v2.y, endX, endY, v2.size/2, v2.speed*2)
						Astroids[#Astroids+1] = a

						endPos = math.round(math.random(0,3))
						if endPos == 0 then --Top
							endX = math.random(0,WINDOW_W)
							endY = 0
						elseif endPos == 1 then --Bot
							endX = math.random(0,WINDOW_W)
							endY = WINDOW_H
						elseif endPos == 2 then --Left
							endX = 0
							endY = math.random(0, WINDOW_H)
						elseif endPos == 3 then --Right
						endX = WINDOW_W
								endY = math.random(0, WINDOW_H)
						end
						local b = Astroid(v2.x, v2.y, endX, endY, v2.size/2, v2.speed*1.3)
						Astroids[#Astroids+1] = b
					end

					v = nil
					v2 = nil
				end
			end
		end
	end

	for k3, v3 in pairs(Astroids) do
		local distance = math.sqrt((PShip.x-v3.x)^2+(PShip.y-v3.y)^2)
		if distance < v3.size and not v3.hascollided then
			PShip.hascollided = true
		end
	end
end


class("Ship")
function Ship:__init()
	self.size = 25
	self.hascollided = false
	self.x = WINDOW_W/2
	self.y = WINDOW_H/2
	self.shooting = false
	self.movedir = nil
	self.mouseX = 0
	self.mouseY = 0
	self.lastshoot = 0

	--Add Callbacks
	AddTickCallback(function () 
		self:tick()
	end)
	AddDrawCallback(function () 
		self:draw()
	end)
	AddMsgCallback(function(msg, wParam)
		self:keyhandler(msg, wParam)
	end)
end

function Ship:tick()
	if paused or PShip.hascollided then return end
	local mouse = WorldToScreen(D3DXVECTOR3(mousePos.x, mousePos.y, mousePos.z))
	self.mouseX = math.round(mouse.x)
	self.mouseY = math.round(mouse.y)
	self:GetMoveDir()
	self:MoveShip()
	self:shoot()
end

function Ship:draw()
	if paused or PShip.hascollided then return end
	--Draw self Vars
	--[[
	DrawTextA("self.x: "..self.x, 18, 300 ,20)
	DrawTextA("self.y: "..self.y, 18, 300 ,40)
	DrawTextA("self.shooting: "..tostring(self.shooting), 18, 300 ,60)
	DrawTextA("self.movedir: "..tostring(self.movedir), 18, 300 ,80)
	DrawTextA("mousePos.x: "..self.mouseX, 18, 300 ,100)
	DrawTextA("mousePos.y: "..self.mouseY, 18, 300 ,120)
	]]--

	self:drawShip()	

	--Test Draws
	--DrawLine(self.x, self.y, self.mouseX, self.mouseY, 2, ARGB(255,0,255,255)) --Line to mouse
end

function Ship:keyhandler(msg, wParam)
	if paused or PShip.hascollided then return end
	--[[
	513:1 == Key Left Down
	514:0 == Key Left Up

	516:2 == Key Right Down
	517:0 == Key Right Up

	256:32 == SPACE Down
	257:32 == SPACE Up
	]]--
	if msg == 512 then return end

	if (msg == 513 and wParam == 1 and menu.key.shoot == 1) or (msg == 516 and wParam == 2 and menu.key.shoot == 2) or (msg == 256 and wParam == 32 and menu.key.shoot == 3) then
		self.shooting = true
	end

	if (msg == 514 and wParam == 0 and menu.key.shoot == 1) or (msg == 517 and wParam == 0 and menu.key.shoot == 2) or (msg == 257 and wParam == 32 and menu.key.shoot == 3) then
		self.shooting = false
	end
end

function Ship:GetMoveDir()
	if paused or PShip.hascollided then return end
	self.movedir = nil
	if menu.key.up then
		if menu.key.left then
			self.movedir = "ul"
		elseif menu.key.right then
			self.movedir = "ur"
		else
			self.movedir = "u"
		end
	end

	if menu.key.down then
		if menu.key.left then
			self.movedir = "dl"
		elseif menu.key.right then
			self.movedir = "dr"
		else
			self.movedir = "d"
		end
	end

	if not menu.key.up and not menu.key.down then
		if menu.key.left then
			self.movedir = "l"
		elseif menu.key.right then
			self.movedir = "r"
		end
	end
end

function Ship:MoveShip()
	if paused or PShip.hascollided then return end
	local function ValidMove(x, y)
		local x = x or 0
		local y = y or 0
		if x > 0 and self.x + x > WINDOW_W then
			return false
		end
		if x < 0 and self.x + x < 0 then
			return false
		end
		if y > 0 and self.y + y > WINDOW_H then
			return false
		end
		if y < 0 and self.y + y < 0 then
			return false
		end
		return true
	end

	if self.movedir == "u" then
		if ValidMove(0,menu.game.ownSpeed) then
			self.y = self.y - menu.game.ownSpeed
		end
	elseif self.movedir == "d" then
		if ValidMove(0,-menu.game.ownSpeed) then
			self.y = self.y + menu.game.ownSpeed
		end
	elseif self.movedir == "r" then
		if ValidMove(menu.game.ownSpeed,0) then
			self.x = self.x + menu.game.ownSpeed
		end
	elseif self.movedir == "l" then
		if ValidMove(-menu.game.ownSpeed,0) then
			self.x = self.x - menu.game.ownSpeed
		end
	elseif self.movedir == "ul" then
		if ValidMove(-menu.game.ownSpeed,menu.game.ownSpeed) then
			self.x = self.x - menu.game.ownSpeed
			self.y = self.y - menu.game.ownSpeed
		end
	elseif self.movedir == "ur" then
		if ValidMove(menu.game.ownSpeed,menu.game.ownSpeed) then
			self.x = self.x + menu.game.ownSpeed
			self.y = self.y - menu.game.ownSpeed
		end
	elseif self.movedir == "dl" then
		if ValidMove(-menu.game.ownSpeed,-menu.game.ownSpeed) then
			self.x = self.x - menu.game.ownSpeed
			self.y = self.y + menu.game.ownSpeed
		end
	elseif self.movedir == "dr" then
		if ValidMove(menu.game.ownSpeed,-menu.game.ownSpeed) then
			self.x = self.x + menu.game.ownSpeed
			self.y = self.y + menu.game.ownSpeed
		end
	end
end

function Ship:drawShip()
	if paused or PShip.hascollided then return end
	DrawRectangleOutline(self.x-self.size/2, self.y-self.size/2, self.size, self.size, ARGB(255,255,255,255), 2)
end

function Ship:shoot()
	if paused or PShip.hascollided then return end
	if not self.shooting then return end
	if menu.game.hyper then
		MisslesFired = MisslesFired + 1
		local m = Missle(self.x,self.y,self.mouseX,self.mouseY) --Imma Firin Mah Lazer!
		Missles[#Missles+1] = m 
	end
	if self.lastshoot + menu.game.rof > time then return end
	self.lastshoot = time
	MisslesFired = MisslesFired + 1
	local m = Missle(self.x,self.y,self.mouseX,self.mouseY) --Imma Firin Mah Lazer!
	Missles[#Missles+1] = m 
end



class("Missle")
function Missle:__init(x,y,mouseX,mouseY)
	self.size = 12
	self.hascollided = false
	self.speed = menu.game.missileSpeed
	self.x = x
	self.y = y
	self.vector = Vector(mouseX-x, mouseY-y):normalized()
	AddDrawCallback(function () 
		self:draw()
	end)
	AddTickCallback(function () 
		self:tick()
	end)
end

function Missle:draw()
	if paused then return end
	if not self.hascollided then
		DrawRectangleOutline(self.x-self.size/2, self.y-self.size/2, self.size, self.size, ARGB(255,255,255,0), 2)
	end
	--DrawTextA(self.age*self.speed, 15, self.x, self.y)
end

function Missle:tick()
	if paused then return end
	self.x = self.x + (self.vector.x*self.speed)
	self.y = self.y + (self.vector.y*self.speed)
end



class("Astroid")
function Astroid:__init(x,y,endX,endY,size,speed)
	self.color = ARGB(255,math.random(0,255),math.random(0,255),math.random(0,255))
	self.drawres = math.round(size)
	self.speed = speed
	self.x = x
	self.y = y
	self.size = size
	self.vector = Vector(endX-x, endY-y):normalized()
	self.hascollided = false
	AddDrawCallback(function () 
		self:draw()
	end)
	AddTickCallback(function () 
		self:tick()
	end)
end

function Astroid:draw()
	if paused then return end
	if not self.hascollided then
		DrawCircle2D(self.x, self.y, self.size, 6, self.color, self.drawres)
	end
	--DrawTextA(self.x-self.lastx, 15, self.x, self.y)
end

function Astroid:tick()
	if paused then return end
	self.x = self.x + (self.vector.x*(self.speed))
	self.y = self.y + (self.vector.y*(self.speed))
end











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
	local serveradress = "www.s1mplescripts.de"
	local scriptadress = "/S1mple/Scripts/BolStudio/Other"
	local ServerVersionDATA = GetWebResult(serveradress , scriptadress.."/S1mple_SPACEINVADERS.version")
	if ServerVersionDATA then
		local ServerVersion = tonumber(ServerVersionDATA)
		if ServerVersion then
			if ServerVersion > tonumber(version) then
				print("Updating, don't press F9")
				DownloadFile("http://"..serveradress..scriptadress.."/S1mple_SPACEINVADERS.lua",SCRIPT_PATH.."S1mple_SPACEINVADERS.lua", function ()
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
		DrawTextA("[S1mple_SPACEINVADERS] Updating", 25, 10,h*0.05,ARGB(255,255,255,255), "left", "center")
	end
	if updated then
		DrawTextA("[S1mple_SPACEINVADERS] Updated, press 2xF9", 25, 10,h*0.05,ARGB(255,255,255,255), "left", "center")
	end
end