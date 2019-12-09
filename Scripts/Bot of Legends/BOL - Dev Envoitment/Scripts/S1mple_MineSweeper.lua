--[[
    _____ __                 _        __  __ _               _____                                    _              _____ __                 _         _____           _       _       
  / ____/_ |               | |      |  \/  (_)             / ____|                                  | |            / ____/_ |               | |       / ____|         (_)     | |      
 | (___  | |_ __ ___  _ __ | | ___  | \  / |_ _ __   ___  | (_____      _____  ___ _ __   ___ _ __  | |__  _   _  | (___  | |_ __ ___  _ __ | | ___  | (___   ___ _ __ _ _ __ | |_ ___ 
  \___ \ | | '_ ` _ \| '_ \| |/ _ \ | |\/| | | '_ \ / _ \  \___ \ \ /\ / / _ \/ _ \ '_ \ / _ \ '__| | '_ \| | | |  \___ \ | | '_ ` _ \| '_ \| |/ _ \  \___ \ / __| '__| | '_ \| __/ __|
  ____) || | | | | | | |_) | |  __/ | |  | | | | | |  __/  ____) \ V  V /  __/  __/ |_) |  __/ |    | |_) | |_| |  ____) || | | | | | | |_) | |  __/  ____) | (__| |  | | |_) | |_\__ \
 |_____/ |_|_| |_| |_| .__/|_|\___| |_|  |_|_|_| |_|\___| |_____/ \_/\_/ \___|\___| .__/ \___|_|    |_.__/ \__, | |_____/ |_|_| |_| |_| .__/|_|\___| |_____/ \___|_|  |_| .__/ \__|___/
                     | |                                                          | |                       __/ |                     | |                               | |            
                     |_|                                                          |_|                      |___/                      |_|                               |_|            
 ]]--
local version = 0.5

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

function menu()
	menu = scriptConfig("S1mple_MineSweeper", "MS")
		menu:addParam("alive", "Enable while beeing alive", SCRIPT_PARAM_ONOFF, false)
		menu:addSubMenu("Game Settings", "game")
			menu.game:addParam("row", "Rows", SCRIPT_PARAM_SLICE, 9, 2, 24)
			menu.game:addParam("columns", "Columns", SCRIPT_PARAM_SLICE, 9, 2, 24)
			menu.game:addParam("mines", "Max Mines", SCRIPT_PARAM_SLICE, 2, 1, math.round(menu.game.row*menu.game.columns*0.8))
			menu.game:setCallback("row", changemaxmines)
			menu.game:setCallback("columns", changemaxmines)
		menu:addSubMenu("Key Settings", "key")
			menu.key:addParam("flag", "Flag as Mine", SCRIPT_PARAM_INFO, "Right Mouse")
			menu.key:addParam("reveal", "Reveal", SCRIPT_PARAM_INFO, "Left Mouse")
			menu.key:addParam("newgame", "New Game", SCRIPT_PARAM_ONKEYDOWN, false, 78)
end

function changemaxmines()
	menu.game:removeParam("mines")
	menu.game:addParam("mines", "Mines", SCRIPT_PARAM_SLICE, 2, 1, math.round(menu.game.row*menu.game.columns*0.8))
	menu.game.mines = 1
end

function init()
	lost = false
	won = false
	PBoard = Board(menu.game.row, menu.game.columns, menu.game.mines)
end

local lastcommand = 0
function OnTick()
	if menu.key.newgame and lastcommand + 2 < os.clock() then
		lastcommand = os.clock()
		PBoard.hide = true
		PBoard = nil
		lost = false
		won = false
		PBoard = Board(menu.game.row, menu.game.columns, menu.game.mines)
	end
	if myHero.dead == false and menu.alive == false then
		PBoard.paused = true
	elseif myHero.dead == true then
		PBoard.paused = false
	elseif myHero.dead == false and menu.alive == true then
		PBoard.paused = false
	end
end

function OnDraw()
	if won == true then
		DrawTextA("You have won", 35, WINDOW_W/2-100, 200)
	end
	if lost == true then
		DrawTextA("You have lost", 35, WINDOW_W/2-100, 200)
	end
end


class("Board")
function Board:__init(rows,cols,mines)
	--[[
		"" = empty
		"m" = mine
		"f" = flag
		"fm" = flag on mine
		"r" = revealed

	]]--
	self.paused = false
	self.board = {}
	self.rows = rows
	self.cols = cols
	self.mines = mines
	self.size = 25
	self.hide = false

	self:initboard()

	AddDrawCallback(function () 
		self:draw()
	end)
	AddMsgCallback(function(msg, wParam)
		self:keyhandler(msg, wParam)
	end)
end

function Board:draw()
	if self.hide == true or self.paused then return end
	local startx = WINDOW_W/2-self.cols*12.5
	local starty = WINDOW_H/2-self.rows*12.5
	local row = 0
	local col = 0
	for v, k in pairs(self.board) do
		if col >= self.cols then
			row = row + 1
			col = 1
		else
			col = col + 1
		end
		x = row * 25 + startx
		y = col * 25 + starty

		local color = nil
		local _type = ""
		if k == "rm" then
			color = ARGB(255,255,0,0)
			_type = "X"
		elseif k == "f" or k == "fm" then
			color = ARGB(255,0,255,0)
			_type = "O"
		elseif k == "r" then
			color = ARGB(255,255,255,255)
			_type = "X"
		elseif k == "fms" then
			color = ARGB(255,0,255,0)
			_type = "X"
		--elseif k == "m" then
			--color = ARGB(255,0,0,00) --Debug
			--_type = "X"		
		else
			color = ARGB(255,255,255,255)
			_type = "O"
		end

		if _type == "O" then
			DrawRectangleOutline(x-self.size/2, y-self.size/2, self.size, self.size, color, 2)
		else
			DrawRectangle(x-self.size/2, y-self.size/2, 25.5, 25, color)
		end

		if k == "r" then
			DrawTextA(tostring(self:getMinesNearby(row,col)), 18 , x-self.size/2+6.25, y-self.size/2, ARGB(255,0,255,0))
		end
		--DrawTextA(tostring(v), 18 , x-self.size/2+6.25, y-self.size/2+150)
	end
end


function Board:initboard()
	if self.hide == true  or self.paused then return end	
	--[[
		"" = empty
		"m" = mine
		"f" = flag
		"fm" = flag on mine
		"r" = revealed
		"rm" = revealed mine
	]]--

	for i=1,self.rows,1 do
		for i2=1,self.cols,1 do
			self.board[#self.board+1] = ""
		end
	end

	for i=1,self.mines do
		local rand = math.random(1,#self.board)
		self.board[rand] = "m"

	end
end

function Board:keyhandler(msg, wParam)
	if self.hide == true or self.paused  then return end
	--[[
	513:1 == Key Left Down
	514:0 == Key Left Up

	516:2 == Key Right Down
	517:0 == Key Right Up)
	]]--
	if msg == 513 and wParam == 1 then
		self:reveal()
	end	
	if msg == 516 and wParam == 2 then
		self:flag()
	end
end

function Board:reveal()
	if self.hide == true  or self.paused then return end
	local col, row, value, key = self:getPiecefrom2D()
	if col == nil or row == nil then return end
	--print("Row: "..row.." : Column: "..col.." : Value: "..value)
	if value == "" then
		self.board[key] = "r"
		self:revealnearby(col, row)
	elseif value == "m" or value == "fm" then
		self.board[key] = "rm"
		lost = true
		self:revealall()
	elseif value == "f" then
		self.board[key] = "r"
	end
	self:checkifwon()
end

function Board:flag()
	if self.hide == true  or self.paused then return end
	local col, row, value, key = self:getPiecefrom2D()
	if col == nil or row == nil then return end
	--print("Row: "..row.." : Column: "..col.." : Value: "..value)
	if value == "" then
		self.board[key] = "f"
	elseif value == "m" then
		self.board[key] = "fm"
	elseif value == "f" then
		self.board[key] = ""
	end
	self:checkifwon()
end

function Board:revealall()
	if self.hide == true  or self.paused then return end
	for k, v in pairs(self.board) do
		if v == "m" then
			self.board[k] = "rm"
		elseif v == "fm" then
			self.board[k] = "fms"
		end
	end
end

function Board:checkifwon()
	if lost == true then return end
	if self.hide == true or self.paused  then return end

	local w = true
	for k, v in pairs(self.board) do
		if v == "m" or v == "rm" or v == "f" then
			w = false
		end
	end

	if w == true then
		won = true
		self:revealall()
	end

	w = true
	for k, v in pairs(self.board) do
		if v == "f" or v == "rm" or v == "" then
			w = false
		end
	end
	if w == true then
		won = true
		self:revealall()
	end
end

function Board:getPiecefrom2D()
	if self.hide == true  or self.paused then return end
	local mouse = WorldToScreen(D3DXVECTOR3(mousePos.x, mousePos.y, mousePos.z))
	self.mouseX = math.round(mouse.x)
	self.mouseY = math.round(mouse.y)

	local startx = WINDOW_W/2-self.cols*12.5
	local starty = WINDOW_H/2-self.rows*12.5
	local row = 0
	local col = 0
	for v, k in pairs(self.board) do
		if col >= self.cols then
			row = row + 1
			col = 1
		else
			col = col + 1
		end
		x = row * 25 + startx
		y = col * 25 + starty

		if x+12.5 > self.mouseX then --Left Boarder
			if x-12.5 < self.mouseX then --Right Boarder
				if y+12.5 > self.mouseY then --Left Boarder
					if y-12.5 < self.mouseY then --Right Boarder
						return row, col, k, v
					end
				end
			end
		end
	end	
end

function Board:getMinesNearby(row,col)
	local m = 0
	--DrawTextA(row.." : "..col, 18 , 20+40*row ,20+40*col)
	if self:IsMine(row+1,col) then m = m + 1 end
	if self:IsMine(row-1,col) then m = m + 1 end

	if self:IsMine(row,col+1) then m = m + 1 end
	if self:IsMine(row,col-1) then m = m + 1 end

	if self:IsMine(row-1,col-1) then m = m + 1 end
	if self:IsMine(row-1,col+1) then m = m + 1 end

	if self:IsMine(row+1,col+1) then m = m + 1 end
	if self:IsMine(row+1,col-1) then m = m + 1 end
	return m
end

function Board:IsMine(row, col)
	if row < 0 then return false end
	if col < 1 then return false end
	if col > self.cols then return false end
	if row > self.rows then return false end
	local m = col + self.cols*row


	if self.board[m] == "m" or self.board[m] == "fm" or self.board[m] == "rm" or self.board[m] == "fms" then
		return true
	end
end

function Board:revealnearby(col, row)
	if self:getMinesNearby(col, row) == 0 then
		self:revealbycolrow(col+1, row+1)
		self:revealbycolrow(col+1, row)
		self:revealbycolrow(col+1, row-1)

		self:revealbycolrow(col, row+1)
		self:revealbycolrow(col, row-1)

		self:revealbycolrow(col-1, row+1)
		self:revealbycolrow(col-1, row)
		self:revealbycolrow(col-1, row-1)
	end
end

function Board:revealbycolrow(row, col)
	if row < 0 then return end
	if col < 1 then return end
	if col > self.cols then return end
	if row >= self.rows then return end
	local m = col + self.cols*row

	if self.board[m] == "" then
		self.board[m] = "r"
	end
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
	local serveradress = "scarjit.de"
	local scriptadress = "/S1mpleScripts/Scripts/BolStudio/Other"
	local ServerVersionDATA = GetWebResult(serveradress , scriptadress.."/S1mple_MineSweeper.version")
	if ServerVersionDATA then
		local ServerVersion = tonumber(ServerVersionDATA)
		if ServerVersion then
			if ServerVersion > tonumber(version) then
				print("Updating, don't press F9")
				DownloadFile("http://"..serveradress..scriptadress.."/S1mple_MineSweeper.lua",SCRIPT_PATH.."S1mple_MineSweeper.lua", function ()
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
		DrawTextA("[S1mple_MineSweeper] Updating", 25, 10,h*0.05,ARGB(255,255,255,255), "left", "center")
	end
	if updated then
		DrawTextA("[S1mple_MineSweeper] Updated, press 2xF9", 25, 10,h*0.05,ARGB(255,255,255,255), "left", "center")
	end
end