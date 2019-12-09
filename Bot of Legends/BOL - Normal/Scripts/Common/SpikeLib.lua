function msg(msg)
	
	PrintChat("<b><font color=\"#D2527F\">></font></b> <font color=\"#FEFEE2\"> " .. msg .. "</font>");
end

--- Starting AutoUpdate
local version = "0.100005";
local league = "6.18";
local author = "spyk";
local SCRIPT_NAME = "SpikeLib";
local UPDATE_HOST = "raw.githubusercontent.com";
local UPDATE_PATH = "/spyk1/BoL/master/bundle/SpikeLib.lua".."?rand="..math.random(1,10000);
local UPDATE_FILE_PATH = LIB_PATH .. "SpikeLib.lua";
local UPDATE_URL = "https://"..UPDATE_HOST..UPDATE_PATH;
local ServerData = GetWebResult(UPDATE_HOST, "/spyk1/BoL/master/bundle/SpikeLib.version");
if ServerData then
	ServerVersion = type(tonumber(ServerData)) == "number" and tonumber(ServerData) or nil;
	if ServerVersion then
		if tonumber(version) < ServerVersion then
			DelayAction(function() msg("New version found for SpikeLib "..ServerVersion) end, 3);
			DelayAction(function() msg(">>Updating, please don't press F9<<") end, 4);
			DelayAction(function() DownloadFile(UPDATE_URL, UPDATE_FILE_PATH, function () msg("SpikeLib updated. ("..version.." => "..ServerVersion.."), press F9 twice to load the updated version.") end) end, 5);
		end
	else
		DelayAction(function() msg("SpikeLib, error while downloading version info") end, 1);
	end
end
 --- End Of AutoUpdate
class 'GetPacketsFromLib'

function GetPacketsFromLib:__init()
	self.Var = {}
	self.Var[1] = 257;
	self.Var[2] = 80;
	self.Var[3] = {[0x60] = 0x00,[0xE0] = 0x40,[0xD7] = 0x1F,[0xE7] = 0x1D,[0xDF] = 0x21,[0x11] = 0x1A,[0x0F] = 0x1B,[0xD1] = 0x22,[0xE1] = 0x20,[0xE9] = 0x1C,[0xCF] = 0x23};
	self.Var[4] = 6;
end

function GetPacketsFromLib:Version()
	return league
end

class 'Gold'

	function Gold:Hero(unit)
		return unit.gold;
	end

class 'Stats'

	function Stats:Kills(unit)
		return unit:GetInt("CHAMPIONS_KILLED");
	end

	function Stats:Farm(unit)
		return unit:GetInt("MINIONS_KILLED");
	end

	function Stats:Death(unit)
		return unit:GetInt("NUM_DEATHS");
	end

	function Stats:Assits(unit)
		return unit:GetInt("ASSISTS");
	end

class 'Item'

	function Item:Buy(id)
		BuyItem(id);
	end

	function Item:Sell(SLOT)
		SellItem(SLOT);
	end

	function Item:FullSell()
		SellItem(0);
		SellItem(1)
		SellItem(2);
		SellItem(3);
		SellItem(4);
		SellItem(5);
	end

--{ CustomPermaShow.lua from https://github.com/Superx321/BoL/blob/master/common/CustomPermaShow.lua

--version = 1.09

if not _G.HidePermaShow then
	_G.HidePermaShow = {}
end

if not _G.CPS then
	if GetSave("scriptConfig")["Master"] == nil then return end
	_G.CPS = {}
	_G.CPS.Index = {}
	_G.CPS.NoIndex = {}
	_G.CPS.StartY = GetSave("scriptConfig")["Master"].py
	_G.CPS.LastCheck = 0
	_G._DrawText = DrawText
	DelayAction(function() 	_G.CPS.OldCountDone = true end, 3)
	DelayAction(function() 	AddDrawCallback(_DrawCustomPermaShow) end, 0.1)
end

function CustomPermaShow(TextVar, ValueVar, VisibleVar, PermaColorVar, OnColorVar, OffColorVar, IndexVar)
	if GetSave("scriptConfig")["Master"] == nil then return end
	if IndexVar then
		local ItsNew = true
		for i = 1,#_G.CPS.Index do
			if _G.CPS.Index[i].IndexVar == IndexVar then
				ItsNew = false
				_G.CPS.Index[i].TextVar = TextVar
				_G.CPS.Index[i].ValueVar = ValueVar
				_G.CPS.Index[i].VisibleVar = VisibleVar
				_G.CPS.Index[i].PermaColorVar = PermaColorVar
				_G.CPS.Index[i].OnColorVar = OnColorVar
				_G.CPS.Index[i].OffColorVar = OffColorVar
				break
			end
		end

		if ItsNew then
			table.insert(_G.CPS.Index, {
			["TextVar"] = TextVar,
			["ValueVar"] = ValueVar,
			["VisibleVar"] = VisibleVar,
			["PermaColorVar"] = PermaColorVar,
			["OnColorVar"] = OnColorVar,
			["OffColorVar"] = OffColorVar,
			["IndexVar"] = IndexVar,
			})
		end
	else
		local ItsNew = true
		for i = 1,#_G.CPS.NoIndex do
			if _G.CPS.NoIndex[i].TextVar == TextVar then
				ItsNew = false
				_G.CPS.NoIndex[i].ValueVar = ValueVar
				_G.CPS.NoIndex[i].VisibleVar = VisibleVar
				_G.CPS.NoIndex[i].PermaColorVar = PermaColorVar
				_G.CPS.NoIndex[i].OnColorVar = OnColorVar
				_G.CPS.NoIndex[i].OffColorVar = OffColorVar
				break
			end
		end

		if ItsNew then
			table.insert(_G.CPS.NoIndex, {
			["TextVar"] = TextVar,
			["ValueVar"] = ValueVar,
			["VisibleVar"] = VisibleVar,
			["PermaColorVar"] = PermaColorVar,
			["OnColorVar"] = OnColorVar,
			["OffColorVar"] = OffColorVar,
			})
		end
	end
end

function _GetPermaColor(PermaTable)
	if PermaTable.ValueVar == true then
		if PermaTable.OnColorVar == nil then
			if PermaTable.PermaColorVar == nil then
				ColorVar = _CPS_Master.color.green
			else
				ColorVar = PermaTable.PermaColorVar
			end
		else
			ColorVar = PermaTable.OnColorVar
		end
		TextVar = "      ON"
	elseif PermaTable.ValueVar == false then
		if PermaTable.OffColorVar == nil then
			if PermaTable.PermaColorVar == nil then
				ColorVar = _CPS_Master.color.lgrey
			else
				ColorVar = PermaTable.PermaColorVar
			end
		else
			ColorVar = PermaTable.OffColorVar
		end
		TextVar = "      OFF"
	else
		if PermaTable.PermaColorVar == nil then
			ColorVar = _CPS_Master.color.lgrey
		else
			ColorVar = PermaTable.PermaColorVar
		end
		TextVar = PermaTable.ValueVar
	end
	return TextVar,ColorVar
end

function _DrawCustomPermaShow()
	_CPS_Master = GetSave("scriptConfig")["Master"]
	_CPS_Master.py1 = _CPS_Master.py
	_CPS_Master.py2 = _CPS_Master.py
	_CPS_Master.color = { lgrey = 1413167931, grey = 4290427578, green = 1409321728}
	_CPS_Master.fontSize = WINDOW_H and math.round(WINDOW_H / 72) or 10
	_CPS_Master.midSize = _CPS_Master.fontSize / 2
	_CPS_Master.cellSize = _CPS_Master.fontSize + 1
	_CPS_Master.width = WINDOW_W and math.round(WINDOW_W / 6.4) or 160
	_CPS_Master.row = _CPS_Master.width * 0.7
	_CPS_Master.py1 = _G.CPS.StartY + _CPS_Master.cellSize
	for i = 1, #_G.CPS.Index do
		if _G.CPS.Index[i].VisibleVar and not _G.HidePermaShow[_G.CPS.Index[i].TextVar] then
			ValueTextVar, ColorVar = _GetPermaColor(_G.CPS.Index[i])
			DrawLine(_CPS_Master.px - 1, _CPS_Master.py1 + _CPS_Master.midSize, _CPS_Master.px + _CPS_Master.row - 1, _CPS_Master.py1 + _CPS_Master.midSize, _CPS_Master.cellSize, _CPS_Master.color.lgrey)
			_DrawText(_G.CPS.Index[i].TextVar, _CPS_Master.fontSize, _CPS_Master.px, _CPS_Master.py1, _CPS_Master.color.grey)
			DrawLine(_CPS_Master.px + _CPS_Master.row, _CPS_Master.py1 + _CPS_Master.midSize, _CPS_Master.px + _CPS_Master.width + 1, _CPS_Master.py1 + _CPS_Master.midSize, _CPS_Master.cellSize, ColorVar)
			_DrawText(ValueTextVar, _CPS_Master.fontSize, _CPS_Master.px + _CPS_Master.row + 1, _CPS_Master.py1, _CPS_Master.color.grey)
			_CPS_Master.py1 = _CPS_Master.py1 + _CPS_Master.cellSize
		end
	end
	for i = 1, #_G.CPS.NoIndex do
		if _G.CPS.NoIndex[i].VisibleVar and not _G.HidePermaShow[_G.CPS.NoIndex[i].TextVar] then
			ValueTextVar, ColorVar = _GetPermaColor(_G.CPS.NoIndex[i])
			DrawLine(_CPS_Master.px - 1, _CPS_Master.py1 + _CPS_Master.midSize, _CPS_Master.px + _CPS_Master.row - 1, _CPS_Master.py1 + _CPS_Master.midSize, _CPS_Master.cellSize, _CPS_Master.color.lgrey)
			_DrawText(_G.CPS.NoIndex[i].TextVar, _CPS_Master.fontSize, _CPS_Master.px, _CPS_Master.py1, _CPS_Master.color.grey)
			DrawLine(_CPS_Master.px + _CPS_Master.row, _CPS_Master.py1 + _CPS_Master.midSize, _CPS_Master.px + _CPS_Master.width + 1, _CPS_Master.py1 + _CPS_Master.midSize, _CPS_Master.cellSize, ColorVar)
			_DrawText(ValueTextVar, _CPS_Master.fontSize, _CPS_Master.px + _CPS_Master.row + 1, _CPS_Master.py1, _CPS_Master.color.grey)
			_CPS_Master.py1 = _CPS_Master.py1 + _CPS_Master.cellSize
		end
	end
end

function DrawText(Arg1, Arg2, Arg3, Arg4, Arg5)
	_G.CPS.GetSaveMenu = GetSave("scriptConfig")["Menu"]
	if _G.CPS.GetSaveMenu.menuKey then PressingKey = _G.CPS.GetSaveMenu.menuKey else PressingKey = 16 end
	if IsKeyDown(PressingKey) and IsKeyDown(1) then
		_G.CPS.WaitForRelease = true
	end

	if not (IsKeyDown(PressingKey) and IsKeyDown(1)) and _G.CPS.WaitForRelease then
		_G.CPS.WaitForRelease = false
		_G.CPS.OldCountDone = false
		_G.CPS.StartY = GetSave("scriptConfig")["Master"].py
		DelayAction(function() 	_G.CPS.OldCountDone = true end, 0.5)
	end

	if not _G.CPS.OldCountDone then
		_CPS_Master = GetSave("scriptConfig")["Master"]
		if Arg3 == _CPS_Master.px then
			if Arg4 > _G.CPS.StartY then
				_G.CPS.StartY = Arg4
			end
		end
	end

	_DrawText(Arg1, Arg2, Arg3, Arg4, Arg5)
end


-- } CustomPermaShow.lua from https://github.com/Superx321/BoL/blob/master/common/CustomPermaShow.lua