--[[
	Console Version 1.0
	
	@author frd
	@author Husky
	
	This script is to help seperate script errors from chat and provide
	a nice interface for viewing errors and script notifications.
	
	The other big benefit of this script is for in-game debugging with ability
	to execute Lua and view environment variables directly in the console.
	
	One of the features we wrote that we weren't sure were going to be used
	is the ability to create binds. This is something we want to get feedback
	on from the community and we can expand it from there.
	
	Examples:
	bind j say going b; recall
	bind k cast q; recall -- Stealth recall for Shaco?
	
	Please use your imagination and give us ideas and extra commands you
	might want to see.
	
	Current Commands:
		clear -- Clear console
		say -- Message team
		say_all -- Message all
		buy -- Buy an item, eg: buy 1001 (buy boots)
		cast -- Cast a spell eg: cast q (options: q, w, e, r, summoner1, summoner2, flash)
		flash -- Flash
		recall -- Recall
		bind -- Bind a key eg: bind k say hello
		unbind -- Unbind a key eg: unbind k
		unbindall -- Unbind all keys
		
	Binds are automatically saved and loaded.
	
	To open the console press the tilt. (`)
	German keyboards can use the (^) under the esc key.
	========================================================================
]]

-- Console Configuration
local console = {
	bgcolor = RGBA( 0, 0, 0, 170 ),
	padding = 10,
	textSize = 16,
	height = WINDOW_H / 2,
	width = WINDOW_W,
	linePadding = 2,
	brand = "Bot of Legends - Console Version 1.0",
	scrolling = {
		width	= 12
	},
	colors = {
		script = { R =	 0, G = 255, B = 0 },
		console = { R = 255, G = 255, B = 0 },
		command = { R = 150, G = 255, B = 0 },
		prompt = { R =	 0, G = 255, B = 0 },
		default = { R =	 0, G = 255, B = 0 }
	},
	keys = {
		220, -- German Tilt
		192 -- English Tilt
	},
	selection = {
		content = "",
		startLine = 1,
		endLine = 1,
		startPosition = 1,
		endPosition = 1
	}
}

-- Notifications Configuration
local notifications = {
	bgcolor = RGBA( 0, 0, 0, 80 ),
	max = 6,
	length = 5000,
	fadeTime = 500,
	slideTime = 200,
	perma = 0
}

-- Binds
local binds = {}

-- Command line structure
local command = {
	bullet = ">",
	history = {},
	offset = 1,
	buffer = "",
	methods = {
		-- DEFINED at end of script to allow access to all methods
	}
}

-- Spell mapping (for cast/level command, etc)
local spells = {
	q = _Q,
	w = _W,
	e = _E,
	r = _R,
	recall = RECALL,
	summoner1 = SUMMONER_1,
	summoner2 = SUMMONER_2,
	flash = function()
		if myHero:GetSpellData(SUMMONER_1).name:find("SummonerFlash") then return SUMMONER_1
		elseif myHero:GetSpellData(SUMMONER_2).name:find("SummonerFlash") then return SUMMONER_2
		else return nil end
	end
}

-- Cursor structure
local cursor = {
	blinkSpeed = 1200,
	offset = 0,
}

-- Is the console active or not
local active = false

-- The stack of console messages
local stack	= {}
local offset = 1

-- Last notification time
local closeTick = 0

-- Unorganized variables
local stayAtBottom = true

-- Calculated max console messages to display on a single screen
local maxMessages = math.floor((console.height - 2 * console.padding - 2 * console.textSize) / (console.textSize + console.linePadding)) + 1

-- Code ------------------------------------------------
local function LoadBinds()
	pcall(function() lines = io.lines(SCRIPT_PATH .. "binds.cfg") end)
	if lines ~= nil then
		for line in lines do
			local parts = string.split(line, " ", 3)
			binds[parts[2]] = parts[3]
		end
	end
end

local function SaveBinds()
	local file = assert(io.open(SCRIPT_PATH .. "binds.cfg", "w+"))
	if file then
		for key, cmd in pairs(binds) do
			file:write("bind " .. key .. " " .. cmd .. "\n")
		end
		file:close()
	end
end

local function IsConsoleKey(key)
	for i, k in ipairs(console.keys) do
		if k == key then
			return true
		end
	end

	return false
end

local function GetTextColor(type, opacity)
	local c = console.colors.default

	if console.colors[type] then
		c = console.colors[type]
	end

	return RGBA(c.R, c.G, c.B, (opacity or 1) * 255)
end

local function AddMessage(msg, type, insertionOffset)
	if insertionOffset then
		table.insert(stack, insertionOffset, {
			msg = tostring(msg),
			ticks = GetTickCount(),
			gameTime = GetInGameTimer(),
			type = type
		})
	else
		table.insert(stack, {
			msg = tostring(msg),
			ticks = GetTickCount(),
			gameTime = GetInGameTimer(),
			type = type
		})
	end

	if #stack - offset >= maxMessages and stayAtBottom then
		offset = offset + 1
	end

	if notifications.perma > 0 then
		for i = 1, notifications.perma do
			if #stack - i >= 1 then
				local item = stack[#stack - i]

				if item.ticks < GetTickCount() - notifications.length + notifications.fadeTime then
					item.ticks = GetTickCount() - notifications.length + notifications.fadeTime
					closeTick = GetTickCount() - notifications.length + notifications.fadeTime - 1
				end
			end
		end
	end
end

local function LazyProcess(cmd)
	local preExecutionStackCount = #stack
	local successful, result = ExecuteLUA('return ' .. cmd)

	if successful then
		successfull, result = pcall(function() return cmd .. " = " .. tostring(result) end)
		if successfull then
			table.remove(stack, preExecutionStackCount)
			AddMessage(result, "command", preExecutionStackCount)
		else
			table.remove(stack, preExecutionStackCount)
			AddMessage(cmd .. " = <unknown>", "command", preExecutionStackCount)
		end		
	else
		AddMessage("Lua Error: " .. result:gsub("%[string \"\"%]:1: ", ""), "console")
	end
end

function ExecuteLUA(cmd)
	local func, err = load(cmd, "", "t", _ENV)

	if func then
		return pcall(func)
	else
		return false, err
	end
end

local function ProcessCommand(cmd)
	local parts = string.split(cmd, " ", 2)
	if command.methods[parts[1]] == nil then return end
	return command.methods[parts[1]](#parts == 2 and parts[2] or nil)
end

local function ExecuteCommand(cmd)
	if cmd ~= "" then
		AddMessage(cmd, "command")

		if string.len(cmd) == 0 then return end

		-- Display command in console, and add to history stack
		table.insert(command.history, cmd)

		-- Parse the command
		local process = ProcessCommand(cmd)

		-- If no command was found, we will attempt to execute the command as LUA code
		if not process then
			LazyProcess(cmd)
		end
	end
end

local function GetTextWidth(text, textSize)
	return GetTextArea("_" .. text .. "_", textSize or console.textSize).x - 2 * GetTextArea("_", textSize or console.textSize).x
end

local function DrawRectangle(x, y, width, height, color)
	DrawLine(x, y + (height/2), x + width, y + (height/2), height, color)
end

function Console__WriteConsole(msg)
	AddMessage(msg, "script")
end

function Console__OnLoad()
	AddMessage("Game started", "console")
	AddMessage("Champion: " .. myHero.charName, "console")
	LoadBinds()
end

function Console__OnDraw()
	local messageBoxHeight = 2 * console.padding + (maxMessages - 1) * (console.textSize + console.linePadding) + console.textSize
	local promptHeight		 = 2 * console.padding + console.textSize
	local consoleHeight		= messageBoxHeight + promptHeight
	local scrollbarHeight	= math.ceil(messageBoxHeight / math.max(#stack / maxMessages, 1))

	if active == true then
		local showRatio = math.min((GetTickCount() - closeTick) / notifications.slideTime, 1)
		local slideOffset = (1 - showRatio) * consoleHeight

		-- Draw console background
		DrawRectangle(0, 0 - slideOffset, console.width, consoleHeight, RGBA(0, 0, 0, showRatio * 170))
		DrawLine(0, messageBoxHeight - slideOffset, console.width, messageBoxHeight - slideOffset, 1, GetTextColor("prompt", showRatio * 0.16))
		DrawLine(0, consoleHeight - slideOffset, console.width, consoleHeight - slideOffset, 1, GetTextColor("prompt", showRatio * 0.58))
		
		-- Display stack of messages
		console.selection.content = ""
		if #stack > 0 then
			for i = offset, offset + maxMessages - 1 do
				if i > #stack then break end

				local message = stack[i]

				local selectionStartLine, selectionEndLine, selectionStartPosition, selectionEndPosition
				if console.selection.startLine < console.selection.endLine or (console.selection.startLine == console.selection.endLine and console.selection.startPosition < console.selection.endPosition) then
					selectionStartLine = console.selection.startLine
					selectionEndLine = console.selection.endLine
					selectionStartPosition = console.selection.startPosition
					selectionEndPosition = console.selection.endPosition
				else
					selectionStartLine = console.selection.endLine
					selectionEndLine = console.selection.startLine
					selectionStartPosition = console.selection.endPosition
					selectionEndPosition = console.selection.startPosition
				end

				if i >= selectionStartLine and i <= selectionEndLine then
					local rightOffset
					
					local leftOffset = (i == selectionStartLine) and (GetTextArea("_" .. ("[" .. TimerText(message.gameTime) .. "] " .. message.msg):sub(1, selectionStartPosition - 1) .. "_", console.textSize).x - 2 * GetTextArea("_", console.textSize).x) or 0

					if i == selectionEndLine then
						local selectedText = ("[" .. TimerText(message.gameTime) .. "] " .. message.msg):sub(selectionStartLine == selectionEndLine and selectionStartPosition or 1, selectionEndPosition - 1)
						rightOffset = GetTextWidth(selectedText)

						console.selection.content = console.selection.content .. (console.selection.content ~= "" and "\r\n" or "") .. selectedText
					else
						local selectedText = ("[" .. TimerText(message.gameTime) .. "] " .. message.msg):sub(selectionStartLine == i and selectionStartPosition or 1)
						rightOffset = WINDOW_W - 2 * console.padding - leftOffset - (scrollbarHeight == messageBoxHeight and 0 or console.scrolling.width)

						console.selection.content = console.selection.content .. (console.selection.content ~= "" and "\r\n" or "") .. selectedText
					end

					DrawRectangle(console.padding + leftOffset, console.padding + (i - offset) * (console.textSize + console.linePadding) - slideOffset - console.linePadding / 2, rightOffset, console.textSize + console.linePadding, 1157627903)
				end

				if message ~= nil then
					DrawText("[" .. TimerText(message.gameTime) .. "] " .. message.msg, console.textSize, console.padding, console.padding + (i - offset) * (console.textSize + console.linePadding) - slideOffset, GetTextColor(message.type, showRatio))
				end
			end
		end

		-- Show what user is currently typing
		DrawText(command.bullet .. " " .. command.buffer, console.textSize, console.padding, messageBoxHeight + console.padding - slideOffset, GetTextColor("prompt", showRatio))
		if GetTickCount() % cursor.blinkSpeed > cursor.blinkSpeed / 2 then
			DrawText("_", console.textSize, console.padding + GetTextArea(command.bullet .. " " .. command.buffer:sub(1, cursor.offset) .. "_", console.textSize).x - GetTextArea("_", console.textSize).x, messageBoxHeight + console.padding - slideOffset, GetTextColor("prompt", showRatio))
		end

		DrawText(console.brand, console.textSize, console.width - GetTextArea(console.brand, console.textSize).x - console.padding, messageBoxHeight + console.padding - slideOffset, GetTextColor("prompt", showRatio * 0.58))

		if scrollbarHeight ~= messageBoxHeight then
			DrawRectangle(console.width - console.scrolling.width, 0 - slideOffset + (offset - 1) / (#stack - maxMessages) * (messageBoxHeight - scrollbarHeight), console.scrolling.width, scrollbarHeight, GetTextColor("prompt", showRatio * 0.4))
		end
	elseif #stack > 0 then
		local filteredStack = {}

		for i = #stack, math.max(#stack - notifications.max + 1, 1), - 1 do
			if (GetTickCount() - stack[i].ticks > notifications.length or stack[i].ticks < closeTick) and (#stack - i) >= notifications.perma then break end
			table.insert(filteredStack, stack[i])
		end

		if #filteredStack > 0 then
			local slideOffset = 0
			for i = 1, #filteredStack do
				slideOffset = slideOffset - (console.textSize + (i == #filteredStack and console.padding * 2 or console.linePadding)) * ((#filteredStack - i < notifications.perma) and 0 or math.max((GetTickCount() - filteredStack[#filteredStack - i + 1].ticks - notifications.length + notifications.fadeTime) / notifications.fadeTime, 0))
			end

			DrawRectangle(0, 0, console.width, (console.textSize * #filteredStack) + (console.padding * 2) + (#filteredStack - 1) * console.linePadding + slideOffset, notifications.bgcolor)
			DrawLine(0, (console.textSize * #filteredStack) + (console.padding * 2) + slideOffset + (#filteredStack - 1) * console.linePadding, console.width, (console.textSize * #filteredStack) + (console.padding * 2) + slideOffset + (#filteredStack - 1) * console.linePadding, 1, GetTextColor("prompt", 0.27))

			for i = 1, #filteredStack do
				local item = filteredStack[#filteredStack + 1 - i]

				DrawText("[" .. TimerText(item.gameTime) .. "] " .. item.msg, console.textSize, console.padding, console.padding + (i - 1) * (console.linePadding + console.textSize) + slideOffset, GetTextColor(item.type, 1 - ((#filteredStack - i < notifications.perma) and 0 or math.max((GetTickCount() - item.ticks - notifications.length + notifications.fadeTime) / notifications.fadeTime, 0))) )
			end
		end
	end
end

function getLineCoordinates(referencePoint)
	local yValue = math.max(math.ceil((referencePoint.y - console.padding - console.textSize) / (console.textSize + console.linePadding)) + 1, 1) + offset - 1
	local xValue = referencePoint.x - console.padding

	if yValue > #stack then
		return #stack + 1, math.huge
	else
		local stringValue = "[" .. TimerText(stack[yValue].gameTime) .. "] " .. stack[yValue].msg
		local stringWidth = 0
		local charNumber = 0
		for i = 1, #stringValue do
			newStringWidth = stringWidth + GetTextArea("_" .. stringValue:sub(i,i) .. "_", console.textSize).x - 2 * GetTextArea("_", console.textSize).x
			if newStringWidth > xValue then break end
			stringWidth = newStringWidth
			charNumber = i
		end

		return yValue, charNumber + 1
	end
end

local disabled = false

function OnTick()
	if active then
		if not disabled then
			BlockMsg();
			AllowKeyInput(false);
			AllowCameraInput(false);
			disabled = true
		end
	else
		if disabled then
			AllowKeyInput(true);
			AllowCameraInput(true);
			disabled = false
		end
	end
end

function Console__OnMsg(msg, key)
	local messageBoxHeight = 2 * console.padding + (maxMessages - 1) * (console.textSize + console.linePadding) + console.textSize
	local promptHeight		 = 2 * console.padding + console.textSize
	local consoleHeight		= messageBoxHeight + promptHeight
	local scrollbarHeight	= math.ceil(messageBoxHeight / math.max(#stack / maxMessages, 1))

	if active and msg == WM_RBUTTONUP then
		SetClipboardText(console.selection.content)
		console.selection = {
			content = "",
			startLine = 1,
			endLine = 1,
			startPosition = 1,
			endPosition = 1
		}
	elseif active and msg == WM_LBUTTONDOWN then
		if GetCursorPos().x >= console.width - console.scrolling.width then
			dragConsole = true
			dragStart = {x = GetCursorPos().x, y = GetCursorPos().y}
			startOffset = offset
		else
			local line, char = getLineCoordinates(GetCursorPos())

			if line then
				console.selection.startLine = line
				console.selection.endLine = line
				console.selection.startPosition = char
				console.selection.endPosition = char

				selecting = true
			end
		end
	elseif active and msg == WM_LBUTTONUP then
		if selecting then
			local line, char = getLineCoordinates(GetCursorPos())

			if line then
				console.selection.endLine = line
				console.selection.endPosition = char
			end
		end

		dragConsole = false
		selecting = false
	elseif active and msg == WM_MOUSEMOVE then
		if selecting then
			local line, char = getLineCoordinates(GetCursorPos())

			if line then
				console.selection.endLine = line
				console.selection.endPosition = char
			end
		end

		if dragConsole then
			if #stack > maxMessages then
				stayAtBottom = false

				offset = startOffset + math.round(((GetCursorPos().y - dragStart.y) * (#stack - maxMessages) / (messageBoxHeight - scrollbarHeight)) + 1)
				if offset < 1 then
					offset = 1
				elseif offset >= #stack - maxMessages + 1 then
					offset = #stack - maxMessages + 1
					stayAtBottom = true
				end
			end
		end
	end

	if active and msg == KEY_DOWN then
		local oldCommandBuffer = command.buffer
	
		if key == 13 then --enter
			ExecuteCommand(command.buffer)
			if #stack > maxMessages then
				offset = #stack - maxMessages + 1
			end
			command.buffer = ""
			cursor.offset = 0
			stayAtBottom = true
		elseif key == 8 then --backspace
			if cursor.offset > 0 then
				command.buffer = command.buffer:sub(1, cursor.offset - 1) .. oldCommandBuffer:sub(cursor.offset + 1)
				cursor.offset = cursor.offset - 1
			end
		elseif key == 46 then -- delete
			command.buffer = command.buffer:sub(1, cursor.offset) .. oldCommandBuffer:sub(cursor.offset + 2)
		elseif key == 33 then --pgup
			offset = math.max(offset - maxMessages, 1)
			stayAtBottom = false
		elseif key == 34 then --pgdn
			offset = math.max(math.min(offset + maxMessages, #stack - maxMessages + 1), 1)
			if offset == #stack - maxMessages + 1 then
				stayAtBottom = true
			end
		elseif key == 38 and #command.history > 0 then --up arrow
			if command.offset < #command.history then
				command.offset = command.offset + 1
			end
			command.buffer = command.history[command.offset]
			cursor.offset = #command.buffer
		elseif key == 40 and #command.history > 0 then --down arrow
			if command.offset > 1 then
				command.offset = command.offset - 1
			end
			command.buffer = command.history[command.offset]
			cursor.offset = #command.buffer
		elseif key == 37 then --left arrow
			cursor.offset = math.max(cursor.offset - 1, 0)
		elseif key == 39 then --right arrow
			cursor.offset = math.min(cursor.offset + 1, #command.buffer)
		elseif key == 35 then
			cursor.offset = #command.buffer
		elseif key == 36 then
			cursor.offset = 0
		elseif ToAscii(key) == string.char(3) then
			SetClipboardText(console.selection.content)
			console.selection = {
				content = "",
				startLine = 1,
				endLine = 1,
				startPosition = 1,
				endPosition = 1
			}
		elseif ToAscii(key) == string.char(22) then
			local textToAdd = GetClipboardText():gsub("\r", ""):gsub("\n", " ")
			command.buffer = oldCommandBuffer:sub(1, cursor.offset) .. textToAdd .. oldCommandBuffer:sub(cursor.offset + 1)
			cursor.offset = cursor.offset + #textToAdd
		elseif key == 9 then
			for k,v in pairs(_G) do
				if k:sub(1, #command.buffer) == command.buffer then
					command.buffer = k
					cursor.offset = #k
					break
				end
			end
		else
			local asciiChar = ToAscii(key)
			if asciiChar ~= nil then
				command.buffer = oldCommandBuffer:sub(1, cursor.offset) .. asciiChar .. oldCommandBuffer:sub(cursor.offset + 1)
				cursor.offset = cursor.offset + 1
			end
		end
	end
	
	if msg == KEY_DOWN and IsConsoleKey(key) then
		active = not active
		command.buffer = ""
		closeTick = GetTickCount()

   
	end
	
	if msg == KEY_DOWN and binds[ToAscii(key)] and not active then
		local parts = string.split(binds[ToAscii(key)], ";")
		for p, cmd in ipairs(parts) do
			ProcessCommand(cmd)
		end
	end
end

-- Console Commands ---------------------------------
command.methods = {
	clear = function()
		stack = {}
		offset = 1
	end,
	
	say = function(query)
		SendChat(query)
		return true
	end,
	
	say_all = function(query)
		SendChat("/all " .. query)
		return true
	end,
	
	buy = function(query)
		BuyItem(tonumber(query))
		return true
	end,

	cast = function(query)		
		local s = type(spells[query]) == "function" and spells[query]() or spells[query]
		if s then
			local target = GetTarget()
			if target ~= nil then
				CastSpell(s, target)
			else
				CastSpell(s, mousePos.x, mousePos.z)
			end
		else
			AddMessage("Attempted to cast invalid spell: \"" .. query .. "\"", "console")
		end
		
		return true
	end,
	
	flash = function() return command.methods.cast("flash") end,
	recall = function() return command.methods.cast("recall") end,
	
	level = function(query)
		local s = type(spells[query]) == "function" and spells[query]() or spells[query]
		if s then
			LevelSpell(s)
		end
		
		return true
	end,
	
	bind = function(query)
		local parts = string.split(query, " ", 2)
		binds[parts[1]] = parts[2]
		SaveBinds()
		return true
	end,
	
	unbind = function(query)
		binds[query] = nil
		SaveBinds()
		return true
	end,
	
	unbindall = function()
		binds = {}
		SaveBinds()
		return true
	end,
	
	reload = function()
		LoadBinds()
		return true
	end,

	pcast = function(spell, param1, param2)
		if spell ~= nil then
			if param1 ~= nil and param2 ~= nil then
				CastSpell(spell, param1, param2)
			elseif param1 ~= nil and param2 == nil then
				CastSpell(spell, param1)
			elseif param1 == nil and param2 == nil then
				CastSpell(spell)
			end
		end
end
}

AddLoadCallback(Console__OnLoad)
AddDrawCallback(Console__OnDraw)
AddMsgCallback(Console__OnMsg)
_G.WriteConsole = Console__WriteConsole
_G.PrintChat = _G.WriteConsole
_G.Console__IsOpen = active