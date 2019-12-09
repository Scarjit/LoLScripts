-- Developer: PvPSuite (http://forum.botoflegends.com/user/76516-pvpsuite/)

local sVersion = '1.2';
local rVersion = GetWebResult('raw.githubusercontent.com', '/pvpsuite/BoL/master/Versions/Scripts/p_Skype.version?no-cache=' .. math.random(1, 25000));

if ((rVersion) and (tonumber(rVersion) ~= nil)) then
	if (tonumber(sVersion) < tonumber(rVersion)) then
		print('<font color="#FF1493"><b>[p_Skype]</b> </font><font color="#FFFF00">An update has been found and it is now downloading!</font>');
		DownloadFile('https://raw.githubusercontent.com/pvpsuite/BoL/master/Scripts/p_Skype.lua?no-cache=' .. math.random(1, 25000), (SCRIPT_PATH.. GetCurrentEnv().FILE_NAME), function()
			print('<font color="#FF1493"><b>[p_Skype]</b> </font><font color="#00FF00">Script has been updated, please reload!</font>');
		end);
		return;
	end;
else
	print('<font color="#FF1493"><b>[p_Skype]</b> </font><font color="#FF0000">Update Error</font>');
end;

if (not FileExist(BOL_PATH .. 'p_SkypeHelper.exe')) then
	print('<font color="#FF1493"><b>[p_Skype]</b> </font><font color="#FF0000">Skype Helper Not Found</font>');
	return;
elseif (not FileExist(BOL_PATH .. 'p_SkypeHelper\\last10Messages.txt')) then
		print('<font color="#FF1493"><b>[p_Skype]</b> </font><font color="#FF0000">Last Messages Not Found</font>');
		return;
elseif (not FileExist(BOL_PATH .. 'p_SkypeHelper\\lastCommand.txt')) then
		print('<font color="#FF1493"><b>[p_Skype]</b> </font><font color="#FF0000">Last Command Not Found</font>');
		return;
end;

local afkMessage = 'I am AFK for a bit, see u later.';
local igMessage = 'I\'m currently in-game, talk to you later!'

local lastMessages = {};
local caretStatus = {false, false, false, false, false, false, false, false, false, false};
local background10Sprite = nil;
local background5Sprite = nil;
local caretSpriteDown = nil;
local caretSpriteUp = nil;
local subMenuSprite = nil;
local hoverSprite = nil;
local theMenu = nil;
local subMenu = nil;
local commandProcessing = false;
local readyToShow = false;
local lastTimeActionCalled = 0;
local lastTimeSkypeReload = 0;
local sleepDelay = 200;
local backgroundW = 280;
local backgroundH = 105;
local subMenuW = 110;
local subMenuH = 78;
local hoverW = 110;
local hoverH = 25;
local textSpacing = 5;
local marginTop = 5;
local subMenuMargin = 18 + marginTop;
local messagesLimit = 5;

function OnLoad()
	background10Sprite = createSprite('p_Skype\\background10.png');
	background5Sprite = createSprite('p_Skype\\background5.png');
	caretSpriteDown = createSprite('p_Skype\\caretdown.png');
	caretSpriteUp = createSprite('p_Skype\\caretup.png');
	subMenuSprite = createSprite('p_Skype\\submenu.png');
	hoverSprite = createSprite('p_Skype\\hover.png');
	
	InitMenu();
	
	messagesLimit = ((theMenu.messagesLimit == 1) and 5 or 10);
	
	sleepDelay = 200;
	lastTimeActionCalled = CurrentTimeInMillis();
	commandProcessing = false;
	readLastMessages();
	
	print('<font color="#FF1493"><b>[p_Skype]</b> </font><font color="#00EE00">Loaded Successfully</font>');
	
	readyToShow = true;
end;

function OnTick()
	if ((CurrentTimeInMillis() - lastTimeActionCalled) > sleepDelay) then
		sleepDelay = 200;
		lastTimeActionCalled = CurrentTimeInMillis();
		commandProcessing = false;
		readLastMessages();
		if (not readyToShow) then
			readyToShow = true;
			print('<font color="#FF1493"><b>[p_Skype]</b> </font><font color="#FFA500">Skype Widget Reloaded</font>');
		end;
	end;
	
	if (theMenu.reloadSkype) then
		if ((CurrentTimeInMillis() - lastTimeSkypeReload) > 1500) then
			lastTimeSkypeReload = CurrentTimeInMillis();
			reloadSkype();
		end;
	end;
	
	messagesLimit = ((theMenu.messagesLimit == 1) and 5 or 10);
	
	if ((backgroundH ~= 105) and (messagesLimit == 5)) then
		backgroundH = 105;
	elseif ((backgroundH ~= 210) and (messagesLimit == 10)) then
		backgroundH = 210;
	end;
end;

function OnDraw()
	if ((theMenu.showSkype) and (readyToShow)) then
		if (messagesLimit == 5) then
			if (background5Sprite ~= nil) then
				background5Sprite:Draw(theMenu.drawW, theMenu.drawH, theMenu.widgetOpacity);
			end;
		elseif (messagesLimit == 10) then
			if (theMenu.drawH > (WINDOW_H - backgroundH)) then
				theMenu.drawH = (WINDOW_H - backgroundH);
			end;
			
			if (background10Sprite ~= nil) then
				background10Sprite:Draw(theMenu.drawW, theMenu.drawH, theMenu.widgetOpacity);
			end;
		end;
		
		if (caretSpriteDown ~= nil) then
			if (#lastMessages ~= 0) then
				for I, mTable in ipairs(lastMessages) do
					local fullMessage = mTable['mSender'] .. ': ' .. mTable['sMessage'];
					if (mTable['mSender']:len() > 20) then
						fullMessage = mTable['sUsername'] .. ': ' .. mTable['sMessage'];
					end;
					
					if (fullMessage:len() >= 52) then
						fullMessage = fullMessage:sub(1, 52);
						fullMessage = replaceChar(fullMessage:len(), fullMessage, '.');
						fullMessage = replaceChar(fullMessage:len() - 1, fullMessage, '.');
						fullMessage = replaceChar(fullMessage:len() - 2, fullMessage, '.');
					end;
					
					local tColor = RGBA(255, 255, 255, theMenu.widgetOpacity);
					if ((subMenu ~= nil) and (subMenu['mK'] == I)) then
						tColor = RGBA(255, 255, 0, theMenu.widgetOpacity);
					end;
					
					DrawText(fullMessage, 14, theMenu.drawW + 18, theMenu.drawH + marginTop + ((I - 1) * 20), tColor);
					
					if (not caretStatus[I]) then
						caretSpriteDown:Draw(theMenu.drawW + 4, theMenu.drawH + marginTop + 5 + ((I - 1) * 20), theMenu.widgetOpacity);
					else
						caretSpriteUp:Draw(theMenu.drawW + 4, theMenu.drawH + marginTop + 4 + ((I - 1) * 20), theMenu.widgetOpacity);
					end;
				end;
			else
				DrawText('No messages found!', 14, theMenu.drawW + (backgroundW / 2) - ((18 * 6) / 2), theMenu.drawH + marginTop + (backgroundH / 4), RGBA(255, 255, 255, theMenu.widgetOpacity));
				DrawText('Made with <3 by PvPSuite', 14, theMenu.drawW + (backgroundW / 2) - ((22 * 6) / 2), theMenu.drawH + marginTop + 20 + (backgroundH / 4), RGBA(255, 255, 255, theMenu.widgetOpacity));
			end;
			
			if (subMenu ~= nil) then
				local sMM = subMenuMargin;
				if (theMenu.drawH + subMenuMargin + ((subMenu['mK'] - 1) * 20) + subMenuH > WINDOW_H) then
					sMM = - subMenuH + 1;
				end;
				
				local sOpac = (theMenu.widgetOpacity + 20);
				if (sOpac >= 256) then
					sOpac = 255;
				end;
				
				subMenuSprite:Draw(theMenu.drawW + 4, theMenu.drawH + sMM + ((subMenu['mK'] - 1) * 20), sOpac);
				if (CursorIsUnder(theMenu.drawW + 4, theMenu.drawH + sMM + ((subMenu['mK'] - 1) * 20) + 2, hoverW, hoverH)) then
					hoverSprite:Draw(theMenu.drawW + 4, theMenu.drawH + sMM + ((subMenu['mK'] - 1) * 20) + 2, sOpac);
				elseif (CursorIsUnder(theMenu.drawW + 4, theMenu.drawH + sMM + ((subMenu['mK'] - 1) * 20) + 2 + hoverH, hoverW, hoverH)) then
						hoverSprite:Draw(theMenu.drawW + 4, theMenu.drawH + sMM + ((subMenu['mK'] - 1) * 20) + 2 + hoverH, sOpac);
				elseif (CursorIsUnder(theMenu.drawW + 4, theMenu.drawH + sMM + ((subMenu['mK'] - 1) * 20) + 2 + (hoverH * 2), hoverW, hoverH)) then
						hoverSprite:Draw(theMenu.drawW + 4,  theMenu.drawH + sMM + ((subMenu['mK'] - 1) * 20) + 2 +(hoverH * 2), sOpac);
				end;
				
				DrawText('Call', 18, theMenu.drawW + 12, theMenu.drawH + sMM + ((subMenu['mK'] - 1) * 20) + textSpacing, RGBA(255, 255, 255, theMenu.widgetOpacity));
				DrawText('Reply AFK', 18, theMenu.drawW + 12, theMenu.drawH + sMM + ((subMenu['mK'] - 1) * 20) + hoverH + textSpacing, RGBA(255, 255, 255, theMenu.widgetOpacity));
				DrawText('Reply IG', 18, theMenu.drawW + 12, theMenu.drawH + sMM + ((subMenu['mK'] - 1) * 20) + (hoverH * 2) + textSpacing, RGBA(255, 255, 255, theMenu.widgetOpacity));
			end;
		end;
	end;
end;

function OnWndMsg(kS, wParam)
	if ((theMenu.showSkype) and (readyToShow)) then
		if ((kS == WM_LBUTTONUP) and (wParam == 0)) then
			if (not commandProcessing) then
				for I, mTable in ipairs(lastMessages) do
					if (subMenu ~= nil) then
						local sMM = subMenuMargin;
						if (theMenu.drawH + subMenuMargin + ((subMenu['mK'] - 1) * 20) + subMenuH > WINDOW_H) then
							sMM = - subMenuH + 1;
						end;
						
						if (CursorIsUnder(theMenu.drawW + 4, theMenu.drawH + sMM + ((subMenu['mK'] - 1) * 20) + 2, hoverW, hoverH)) then
							sendSkypeCommand('call');
							return;
						elseif (CursorIsUnder(theMenu.drawW + 4, theMenu.drawH + sMM + ((subMenu['mK'] - 1) * 20) + 2 + hoverH, hoverW, hoverH)) then
							sendSkypeCommand('afk');
							return;
						elseif (CursorIsUnder(theMenu.drawW + 4, theMenu.drawH + sMM + ((subMenu['mK'] - 1) * 20) + 2 + (hoverH * 2), hoverW, hoverH)) then
							sendSkypeCommand('ig');
							return;
						end;
					end;
					
					if (CursorIsUnder(theMenu.drawW + 4, theMenu.drawH + ((I - 1) * 20), backgroundW, 15)) then
						local cS = (not caretStatus[I]);
						caretStatus = {false, false, false, false, false, false, false, false, false, false};
						caretStatus[I] = cS;
						if (cS) then
							subMenu = lastMessages[I];
							subMenu['mK'] = I;
						else
							subMenu = nil;
						end;
					end;
				end;
			end;
		end;
	end;
end;

function InitMenu()
	theMenu = scriptConfig('p_Skype', 'p_Skype');
	theMenu:addParam('showSkype', 'Show Skype Widget', SCRIPT_PARAM_ONOFF, true);
	theMenu:addParam('reloadSkype', 'Reload Skype Widget', SCRIPT_PARAM_ONKEYDOWN, false, GetKey('T'));
	theMenu:addParam('widgetOpacity', 'Skype Widget Opacity', SCRIPT_PARAM_SLICE, 255, 80, 255, 0);
	theMenu:addParam('drawH', 'Screen H Position', SCRIPT_PARAM_SLICE, ((WINDOW_H - backgroundH) / 2), 0, (WINDOW_H - backgroundH), 0);
	theMenu:addParam('drawW', 'Screen W Position', SCRIPT_PARAM_SLICE, ((WINDOW_W - backgroundW) / 2), 0, (WINDOW_W - backgroundW), 0);
	theMenu:addParam('messagesLimit', 'Messages Limit', SCRIPT_PARAM_LIST, 1, {[1] = '5', [2] = '10'});
	theMenu:addParam('reverseOrder', 'Last Message To Bottom', SCRIPT_PARAM_ONOFF, true);
end;

function reloadSkype()
	readyToShow = false;
	background10Sprite:Release();
	background5Sprite:Release();
	caretSpriteDown:Release();
	caretSpriteUp:Release();
	subMenuSprite:Release();
	hoverSprite:Release();
	background10Sprite = createSprite('p_Skype\\background10.png');
	background5Sprite = createSprite('p_Skype\\background5.png');
	caretSpriteDown = createSprite('p_Skype\\caretdown.png');
	caretSpriteUp = createSprite('p_Skype\\caretup.png');
	subMenuSprite = createSprite('p_Skype\\submenu.png');
	hoverSprite = createSprite('p_Skype\\hover.png');
	
	sleepDelay = 200;
	lastTimeActionCalled = CurrentTimeInMillis();
end;

function readLastMessages()
	local tF = io.open(BOL_PATH .. 'p_SkypeHelper\\last10Messages.txt', 'rb');
	if (tF ~= nil) then
		lastMessages = load('return {' .. tF:read('*a') .. '};')();
		lastMessages = reverseTable(lastMessages);
		lastMessages = limitTable(lastMessages, messagesLimit);
		if (theMenu.reverseOrder) then
			lastMessages = reverseTable(lastMessages);
		end;
		tF:close();
	end;
end;

function sendSkypeCommand(theCommand)
	if (subMenu ~= nil) then
		local cRecipient = subMenu['sUsername'];
		actualCommand = nil;
		
		if (theCommand == 'call') then
			actualCommand = 'call ' .. cRecipient;
		elseif (theCommand == 'afk') then
			actualCommand = 'message ' .. cRecipient .. ' ' .. afkMessage;
		elseif (theCommand == 'ig') then
			actualCommand = 'message ' .. cRecipient .. ' ' .. igMessage;
		end;
		
		if (actualCommand ~= nil) then
			local tF = io.open(BOL_PATH .. 'p_SkypeHelper\\lastCommand.txt', 'w+');
			if (tF ~= nil) then
				tF:write(actualCommand);
				tF:close();
			end;
		end;
	end;
	
	caretStatus = {false, false, false, false, false, false, false, false, false, false};
	subMenu = nil;
end;

function replaceChar(thePos, theStr, theR)
    return (theStr:sub(1, (thePos - 1)) .. theR .. theStr:sub(thePos + 1));
end;

function splitTable(theInput, theSeparator)
	if (theSeparator == nil) then
		theSeparator = "%s";
	end;
	
	local theTable = {};
	local I = 1;
	
	for theString in string.gmatch(theInput, '([^' .. theSeparator .. ']+)') do
		theTable[I] = theString;
		I = I + 1;
	end;
	
	return theTable;
end;

function reverseTable(theInput)
    local reversedTable = {};
    local itemCount = #theInput;
    for tK, tV in ipairs(theInput) do
        reversedTable[itemCount + 1 - tK] = tV;
    end;
    return reversedTable;
end;

function limitTable(theInput, theLimit)
    local limitedTable = {};
    local itemCount = 0;
    for tK, tV in ipairs(theInput) do
		if (itemCount >= theLimit) then
			break;
		end;
        limitedTable[tK] = tV;
		itemCount = itemCount + 1;
    end;
    return limitedTable;
end;

function CurrentTimeInMillis()
	return (os.clock() * 1000);
end;