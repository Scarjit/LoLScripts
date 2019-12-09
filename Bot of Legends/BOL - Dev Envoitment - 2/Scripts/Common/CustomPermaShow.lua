if not _G.HidePermaShow then
	_G.HidePermaShow = {}
end

function CustomPermaShow(TextVar, ValueVar, VisibleVar, PermaColorVar, OnColorVar, OffColorVar, IndexVar)
	if not _G._CPS_Added then
		if not DrawCustomText then
			_G.DrawCustomText = _G.DrawText
			_G.DrawText = function(Arg1, Arg2, Arg3, Arg4, Arg5) _DrawText(Arg1, Arg2, Arg3, Arg4, Arg5) end
			_G.DrawCustomLine = _G.DrawLine
			_G.DrawLine = function(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6) _DrawLine(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6) end
			OldPermaShowTable, OldPermaShowCount, IsPermaShowStatusOn, PermaShowTable = {}, 0, {}, {}
			AddDrawCallback(_DrawCustomPermaShow)
			_G._CPS_Added = true
		else
			OldPermaShowTable, OldPermaShowCount, IsPermaShowStatusOn, PermaShowTable = {}, 0, {}, {}
			AddDrawCallback(_DrawCustomPermaShow)
			_G._CPS_Added = true
		end
	end

	if IndexVar == nil then
		local _CPS_Updated = false
		for i=1, #PermaShowTable do
			if PermaShowTable[i]["TextVar"] == TextVar then
				PermaShowTable[i]["ValueVar"], PermaShowTable[i]["VisibleVar"],_CPS_Updated = ValueVar,VisibleVar,true
				PermaShowTable[i]["PermaColorVar"],PermaShowTable[i]["OnColorVar"],PermaShowTable[i]["OffColorVar"] = PermaColorVar, OnColorVar, OffColorVar
			end
		end

		if not _CPS_Updated then
			PermaShowTable[#PermaShowTable+1] = {["TextVar"] = TextVar, ["ValueVar"] = ValueVar, ["VisibleVar"] = VisibleVar, ["PermaColorVar"] = PermaColorVar, ["OnColorVar"] = OnColorVar, ["OffColorVar"] = OffColorVar}
		end
	else
		local _CPS_Updated = false
		for i=1, #PermaShowTable do
			if PermaShowTable[i]["IndexVar"] == IndexVar then
				PermaShowTable[i]["ValueVar"], PermaShowTable[i]["VisibleVar"],_CPS_Updated = ValueVar,VisibleVar,true
				PermaShowTable[i]["PermaColorVar"],PermaShowTable[i]["OnColorVar"],PermaShowTable[i]["OffColorVar"] = PermaColorVar, OnColorVar, OffColorVar
				PermaShowTable[i]["TextVar"] = TextVar
			end
		end

		if not _CPS_Updated then
			PermaShowTable[#PermaShowTable+1] = {["TextVar"] = TextVar, ["ValueVar"] = ValueVar, ["VisibleVar"] = VisibleVar, ["PermaColorVar"] = PermaColorVar, ["OnColorVar"] = OnColorVar, ["OffColorVar"] = OffColorVar, ["IndexVar"] = IndexVar}
		end
	end
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

	for i = 1, #PermaShowTable do
		if PermaShowTable[i].ValueVar == true then
			if PermaShowTable[i].OnColorVar == nil then
				if PermaShowTable[i].PermaColorVar == nil then
					ColorVar = _CPS_Master.color.green
				else
					ColorVar = PermaShowTable[i].PermaColorVar
				end
			else
				ColorVar = PermaShowTable[i].OnColorVar
			end
			TextVar = "      ON"
		elseif PermaShowTable[i].ValueVar == false then
			if PermaShowTable[i].OffColorVar == nil then
				if PermaShowTable[i].PermaColorVar == nil then
					ColorVar = _CPS_Master.color.lgrey
				else
					ColorVar = PermaShowTable[i].PermaColorVar
				end
			else
				ColorVar = PermaShowTable[i].OffColorVar
			end
			TextVar = "      OFF"
		else
			if PermaShowTable[i].PermaColorVar == nil then
				ColorVar = _CPS_Master.color.lgrey
			else
				ColorVar = PermaShowTable[i].PermaColorVar
			end
			TextVar = PermaShowTable[i].ValueVar
		end
		if PermaShowTable[i]["VisibleVar"] then
			if not (_G.HidePermaShow[PermaShowTable[i].TextVar] ~= nil and _G.HidePermaShow[PermaShowTable[i].TextVar] == true) then
				DrawCustomLine(_CPS_Master.px - 1, _CPS_Master.py1 + _CPS_Master.midSize, _CPS_Master.px + _CPS_Master.row - 1, _CPS_Master.py1 + _CPS_Master.midSize, _CPS_Master.cellSize, _CPS_Master.color.lgrey)
				DrawCustomText(PermaShowTable[i].TextVar, _CPS_Master.fontSize, _CPS_Master.px, _CPS_Master.py1, _CPS_Master.color.grey)
				DrawCustomLine(_CPS_Master.px + _CPS_Master.row, _CPS_Master.py1 + _CPS_Master.midSize, _CPS_Master.px + _CPS_Master.width + 1, _CPS_Master.py1 + _CPS_Master.midSize, _CPS_Master.cellSize, ColorVar)
				DrawCustomText(TextVar, _CPS_Master.fontSize, _CPS_Master.px + _CPS_Master.row + 1, _CPS_Master.py1, _CPS_Master.color.grey)
				_CPS_Master.py1 = _CPS_Master.py1 + _CPS_Master.cellSize
			end
		end
	end
	for i=1,OldPermaShowCount do
		if IsPermaShowStatusOn[_CPS_Master.py2] == true then
			ColorVar = _CPS_Master.color.green
			TextVar = "      ON"
		elseif IsPermaShowStatusOn[_CPS_Master.py2] == false then
			ColorVar = _CPS_Master.color.lgrey
			TextVar = "      OFF"
		else
			ColorVar = _CPS_Master.color.lgrey
			TextVar = IsPermaShowStatusOn[_CPS_Master.py2]
		end
		DrawCustomLine(_CPS_Master.px - 1, _CPS_Master.py1 + _CPS_Master.midSize, _CPS_Master.px + _CPS_Master.row - 1, _CPS_Master.py1 + _CPS_Master.midSize, _CPS_Master.cellSize, _CPS_Master.color.lgrey)
		DrawCustomText(OldPermaShowTable[i].Arg1, _CPS_Master.fontSize, _CPS_Master.px, _CPS_Master.py1, _CPS_Master.color.grey)
		DrawCustomLine(_CPS_Master.px + _CPS_Master.row, _CPS_Master.py1 + _CPS_Master.midSize, _CPS_Master.px + _CPS_Master.width + 1, _CPS_Master.py1 + _CPS_Master.midSize, _CPS_Master.cellSize, (ColorVar))
		DrawCustomText(TextVar, _CPS_Master.fontSize, _CPS_Master.px + _CPS_Master.row + 1, _CPS_Master.py1, _CPS_Master.color.grey)
		_CPS_Master.py1 = _CPS_Master.py1 + _CPS_Master.cellSize
		_CPS_Master.py2 = _CPS_Master.py2 + _CPS_Master.cellSize
	end
end

function _DrawText(Arg1, Arg2, Arg3, Arg4, Arg5)
	_CPS_Master = GetSave("scriptConfig")["Master"]
	_CPS_Master.row = (WINDOW_W and math.round(WINDOW_W / 6.4) or 160) * 0.7
	if Arg3 == _CPS_Master.px then
		if not (_G.HidePermaShow[Arg1] ~= nil and _G.HidePermaShow[Arg1] == true) then
			if not OldPermaShowTable[Arg1] then
				OldPermaShowTable[Arg1] = true
				OldPermaShowCount = OldPermaShowCount + 1
				OldPermaShowTable[OldPermaShowCount] = {}
				OldPermaShowTable[OldPermaShowCount]["Status"] = true
				OldPermaShowTable[OldPermaShowCount]["Arg1"] = Arg1
				OldPermaShowTable[OldPermaShowCount]["Arg2"] = Arg2
				OldPermaShowTable[OldPermaShowCount]["Arg3"] = Arg3
				OldPermaShowTable[OldPermaShowCount]["Arg4"] = Arg4
				OldPermaShowTable[OldPermaShowCount]["Arg5"] = Arg5
			end
		end
	elseif Arg3 == (_CPS_Master.px + _CPS_Master.row + 1) then
		if Arg1 == "      ON" then
			IsPermaShowStatusOn[Arg4] = true
		elseif Arg1 == "      OFF" then
			IsPermaShowStatusOn[Arg4] = false
		else
			IsPermaShowStatusOn[Arg4] = Arg1
		end
	else
		DrawCustomText(Arg1, Arg2, Arg3, Arg4, Arg5)
	end
end

function _DrawLine(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6)
	_CPS_Master = GetSave("scriptConfig")["Master"]
	_CPS_Master.row = (WINDOW_W and math.round(WINDOW_W / 6.4) or 160) * 0.7
	if not (Arg1 == (_CPS_Master.px - 1) or Arg1 == (_CPS_Master.px + _CPS_Master.row)) then
		DrawCustomLine(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6)
	end
end