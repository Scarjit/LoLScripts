-- Developers: 
    --Divine (http://forum.botoflegends.com/user/86308-divine/)
    --PvPSuite (http://forum.botoflegends.com/user/76516-pvpsuite/)

local sVersion = '2.1';
local rVersion = GetWebResult('raw.githubusercontent.com','/Nader-Sl/BoLStudio/master/Versions/p_movementHumanizer.version?no-cache=' .. math.random(1, 25000));

if ((rVersion) and (tonumber(rVersion) ~= nil)) then
	if (tonumber(sVersion) < tonumber(rVersion)) then
		print('<font color="#FF1493"><b>[p_movementHumanizer]</b> </font><font color="#FFFF00">An update has been found and it is now downloading!</font>');
		DownloadFile('https://raw.githubusercontent.com/Nader-Sl/BoLStudio/master/Scripts/p_movementHumanizer.lua?no-cache=' .. math.random(1, 25000), (SCRIPT_PATH.. GetCurrentEnv().FILE_NAME), function()
			print('<font color="#FF1493"><b>[p_movementHumanizer]</b> </font><font color="#00FF00">Script has been updated, please reload!</font>');
		end);
		return;
	end;
else
	print('<font color="#FF1493"><b>[p_movementHumanizer]</b> </font><font color="#FF0000">Update Error</font>');
end;

if (not VIP_USER) then
	print('<font color="#FF1493"><b>[p_movementHumanizer]</b> </font><font color="#FF0000">Non-VIP Not Supported</font>');
	return;
elseif ((string.find(GetGameVersion(), 'Releases/5.23') == nil) and (string.find(GetGameVersion(), 'Releases/5.24') == nil)) then
	print('<font color="#FF1493"><b>[p_movementHumanizer]</b> </font><font color="#FF0000">Game Version Not Supported</font>');
	return;
end;

local theMenu = nil;
local moveHeader = nil;
local orbwalkerOK = false;
local theOrbwalker = 0;
local lastSecondMillis = 0;
local humanizerMS = 0;
local myLastPassedMovementMillis = 0;
local myBlockedMovements = 0;
local myPassedMovements = 0;
local myTotalMovements = 0;
local myHamsterLastPassedMovementMillis = 0;


if (string.find(GetGameVersion(), 'Releases/5.23') ~= nil) then
	moveHeader = 0xD8;
elseif (string.find(GetGameVersion(), 'Releases/5.24') ~= nil) then
		moveHeader = 0xC5;
end;

DelayAction(function()
	if ((_G.Reborn_Loaded) or (_G.AutoCarry)) then
			theOrbwalker = 2;
			print('<font color="#FF1493"><b>[p_movementHumanizer]</b> </font><font color="#00EE00">Sida\'s Auto Carry: Reborn Found</font>');
			orbwalkerOK = true;
	elseif ((_G.MMA_Loaded) or (_G.MMA_Version)) then
			theOrbwalker = 3;
			print('<font color="#FF1493"><b>[p_movementHumanizer]</b> </font><font color="#00EE00">Marksman\'s Mighty Assistant Found</font>');
			orbwalkerOK = true;
	elseif ((_G.NebelwolfisOrbWalkerInit) or (_G.NebelwolfisOrbWalkerLoaded)) then
			theOrbwalker = 4;
			print('<font color="#FF1493"><b>[p_movementHumanizer]</b> </font><font color="#00EE00">Nebelwolfi\'s Orbwalker Found</font>');
			orbwalkerOK = true;
	elseif (_G.BigFatOrb_Loaded) then
			theOrbwalker = 5;
			print('<font color="#FF1493"><b>[p_movementHumanizer]</b> </font><font color="#00EE00">Big Fat Walk Found</font>');
			orbwalkerOK = true;
	elseif (FileExist(LIB_PATH .. '/SxOrbWalk.lua')) then
			if (not _G.SxOrb) then
				require('SxOrbWalk');
			end;
			theOrbwalker = 1;
			print('<font color="#FF1493"><b>[p_movementHumanizer]</b> </font><font color="#00EE00">SxOrbWalk Found</font>');
			orbwalkerOK = true;
	else
		orbwalkerOK = false;
	end;

	if (orbwalkerOK) then
		InitMenu();
		humanizerMS = (1000 / (theMenu.maximum + math.random(-1, 2)));
		orbwalkerOK = true;
		print('<font color="#FF1493"><b>[p_movementHumanizer]</b> </font><font color="#00EE00">Loaded Successfully</font>');
	else
		print('<font color="#FF1493"><b>[p_movementHumanizer]</b> </font><font color="#FF0000">No Supported Orbwalker Found</font>');
	end;
end, 0.25);

function OnSendPacket(thePacket)
	if (orbwalkerOK) then
		if (thePacket.header == moveHeader) then
			local netID = thePacket:DecodeF();
			if (IsOrbwalking()) then
				if (netID == myHero.networkID) then
					if (theMenu.enabled) then
						if ((not IsEvading()) or (theMenu.block)) then
							if ((CurrentTimeInMillis() - myLastPassedMovementMillis) <= humanizerMS) then
								thePacket:Block();
								myBlockedMovements = myBlockedMovements + 1;
							else
								myLastPassedMovementMillis = CurrentTimeInMillis();
								myPassedMovements = myPassedMovements + 1;
							end;
						end;
					end;
					myTotalMovements = myTotalMovements + 1;
				else
					if (theMenu.enabled) then
						if ((not IsEvading()) or (theMenu.block)) then
							if ((CurrentTimeInMillis() - myHamsterLastPassedMovementMillis) <= humanizerMS) then
								thePacket:Block();
							else
								myHamsterLastPassedMovementMillis = CurrentTimeInMillis();
							end;
						end;
					end;
				end;
			end;
		end;
	end;
end;

function OnTick()
	if (orbwalkerOK) then
		if ((CurrentTimeInMillis() - lastSecondMillis) >= 1000) then
			lastSecondMillis = CurrentTimeInMillis();
			if (IsOrbwalking()) then
				if (theMenu.print) then
					if (theMenu.enabled) then
						print('<font color="#FF1493"><b>[p_movementHumanizer]</b> </font><font color="#FFFF00">' .. myPassedMovements .. ' passed ' .. ((myPassedMovements == 1) and 'command' or 'commands') .. ' - ' .. myBlockedMovements .. ' blocked ' .. ((myBlockedMovements == 1) and 'command' or 'commands') .. '</font>');
					else
						print('<font color="#FF1493"><b>[p_movementHumanizer]</b> </font><font color="#FFFF00">' .. myTotalMovements .. ' total ' .. ((myTotalMovements == 1) and 'command' or 'commands') .. '</font>');
					end;
				end;
			end;
			humanizerMS = (1000 / (theMenu.maximum + math.random(-1, 2)));
			myPassedMovements = 0;
			myBlockedMovements = 0;
			myTotalMovements = 0;
		end;
	end;
end;

function InitMenu()
	theMenu = scriptConfig('p_movementHumanizer', 'p_movementHumanizer');
	theMenu:addParam('print', 'Print Movements', SCRIPT_PARAM_ONOFF, false);
	theMenu:addParam('enabled', 'Enable Movement Humanizer', SCRIPT_PARAM_ONOFF, true);
	theMenu:addParam('block', 'Block Evading Scripts', SCRIPT_PARAM_ONOFF, false);
	theMenu:addParam('maximum', 'Maximum Movements / Second', SCRIPT_PARAM_SLICE, 7, 4, 10, 0);
	theMenu:setCallback('maximum', function(nV)
		humanizerMS = (1000 / (nV + math.random(-1, 2)));
	end);
end;

function IsOrbwalking()
	if (theOrbwalker == 1) then
		return ((_G.SxOrb) and ((_G.SxOrb.isFight) or (_G.SxOrb.isHarass) or (_G.SxOrb.isLaneClear) or (_G.SxOrb.isLastHit)));
	elseif (theOrbwalker == 2) then
			return ((_G.AutoCarry) and ((_G.AutoCarry.Keys.AutoCarry) or (_G.AutoCarry.Keys.MixedMode) or (_G.AutoCarry.Keys.LaneClear) or (_G.AutoCarry.Keys.LastHit)));
	elseif (theOrbwalker == 3) then
			return (((_G.MMA_IsOrbwalking) and (_G.MMA_IsOrbwalking())) or ((_G.MMA_IsDualCarrying) and (_G.MMA_IsDualCarrying())) or ((_G.MMA_IsClearing) and (_G.MMA_IsClearing())) or ((_G.MMA_IsLasthitting) and (_G.MMA_IsLasthitting())));
	elseif (theOrbwalker == 4) then
			return ((_G.NebelwolfisOrbWalker) and ((_G.NebelwolfisOrbWalker.Config.k.Combo) or (_G.NebelwolfisOrbWalker.Config.k.Harass) or (_G.NebelwolfisOrbWalker.Config.k.LastHit) or (_G.NebelwolfisOrbWalker.Config.k.LaneClear)));
	elseif (theOrbwalker == 5) then
			return ((_G.BigFatOrb_Mode) and ((_G.BigFatOrb_Mode == 'Combo') or (_G.BigFatOrb_Mode == 'Harass') or (_G.BigFatOrb_Mode == 'LastHit') or (_G.BigFatOrb_Mode == 'LaneClear')));
	end;
	
	return false;
end;

function IsEvading()
	return ((_G.Evading) or (_G.NeoEvading) or (_G.Evade));
end;

function CurrentTimeInMillis()
	return (os.clock() * 1000);
end;