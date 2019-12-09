function OnLoad()
	Selector()
end

class 'Selector'

function Selector:__init()
	self.Version = 0.14
	self.SelectedTarget = nil
	self.TimeSelected = 0
	self:Menu()
	self:Callbacks()
	self:Update()
end

function Selector:Menu()
	Menu = scriptConfig("HiranN's Target Selector", "TSByHiranN")

	Menu:addParam("On", "Enable Target Selector", SCRIPT_PARAM_ONOFF, true)
	Menu:addParam("TimeCheck", "Enable Time Check", SCRIPT_PARAM_ONOFF, false)
	Menu:addParam("Print", "Print in Chat the Target Selected", SCRIPT_PARAM_ONOFF, true)
	Menu:setCallback("On", function(value)
		if not Menu.On then
			TS_SetFocus(nil)
    		self:OrbWalkers(nil)
    	end
	end)

	Menu:addSubMenu("Draws", "Draws")
	Menu.Draws:addParam("Target", "Draw Circle on Target", SCRIPT_PARAM_ONOFF, true)

	Menu:addParam("Info", "Author:", SCRIPT_PARAM_INFO, "HiranN")
end

function Selector:Callbacks()
	AddTickCallback(function() self:Tick() end)
	AddMsgCallback(function(msg, key) self:WndMsg(msg, key) end)
	AddDrawCallback(function() self:Draws() end)
	AddAnimationCallback(function(unit, animation) self:Animation(unit, animation) end)
end

function Selector:Tick()
	if self.SelectedTarget ~= nil and Menu.TimeCheck and self.TimeSelected + 60 <= os.clock() then
        if Menu.Print then
       		self:SendMsg("Unselected Target: "..self.SelectedTarget.charName)
        end
        self.SelectedTarget = nil
    	self:OrbWalkers(nil)
		TS_SetFocus(nil)
	end
end

function Selector:Animation(unit, animation)
	if unit and animation and unit.team ~= myHero.team then
		if unit.dead and animation:lower() == "death" and unit == self.SelectedTarget then
        	if Menu.Print then
        		self:SendMsg("Unselected Target: "..unit.charName)
        	end
        	self.SelectedTarget = nil
    		self:OrbWalkers(nil)
			TS_SetFocus(nil)
		end
	end
end

function Selector:Update()
    local host = "s1mplescripts.de"
    local ServerVersionDATA = GetWebResult(host, "/HiranN/BoL/Versions/HiranN%20Target%20Selector.version")  
    local ServerVersion = tonumber(ServerVersionDATA)
    if ServerVersionDATA then
        if ServerVersion then
            if ServerVersion > tonumber(self.Version) then
                Print("Downloading new version, don't press 2x F9.")
                GetWebFile("s1mplescripts.de","/HiranN/BoL/Scripts/HiranN%20Target%20Selector.lua",{},SCRIPT_PATH..GetCurrentEnv().FILE_NAME)
            else
                Print("You are using the latest version. ("..self.Version..")")
            end
        end
    else
        Print("Could not connect to update Server.")
    end
end

function Selector:WndMsg(msg, key)
	if msg == WM_LBUTTONDOWN and Menu.On and not myHero.dead then
		for i, enemy in ipairs(GetEnemyHeroes()) do
        	if GetDistance(enemy, mousePos) <= 135 and ValidTarget(enemy) and enemy.type == "AIHeroClient" then
        		if self.SelectedTarget ~= enemy then
        			self.SelectedTarget = enemy
					TS_SetFocus(enemy)
					self:OrbWalkers(enemy)
					if Menu.Print then
        				self:SendMsg("Selected Target: "..enemy.charName)
        			end
        			self.TimeSelected = os.clock()
        		else
        			self.SelectedTarget = nil 
        			TS_SetFocus(nil)
        			self:OrbWalkers(nil)
        			if Menu.Print then
        				self:SendMsg("Unselected Target: "..enemy.charName)
        			end
        		end
			end
		end
	end
end

function Selector:Draws()
	if Menu.On then
		if Menu.Draws.Target and ValidTarget(self.SelectedTarget) then
			DrawCircle(self.SelectedTarget.x, self.SelectedTarget.y, self.SelectedTarget.z, 200, 0x0000FF)
		end
	end
end

function Selector:SendMsg(msg)
	print("<font color=\"#5E9C19\"><b>[HiranN's Target Selector]</b></font> ".."<font color=\"#158583\"><b>"..msg.."</b></font>")
end

function Selector:OrbWalkers(target)
	if _G.Reborn_Loaded then
		_G.AutoCarry.Crosshair:ForceTarget(target)
	elseif _Pewalk then
		_Pewalk.ForceTarget(target)
	elseif _G.S1mpleOrbLoaded then
		S1 = S1mpleOrbWalker()
		S1:SetTarget(target)
	elseif _G.MMA_IsLoaded then
		_G.MMA_Target(target)
	elseif _G.NebelwolfisOrbWalkerLoaded then
		_G.NebelwolfisOrbWalker:SetTarget(target)
	end
end

function Print(msg)
	print("<font color=\"#5E9C19\"><b>[HiranN's Target Selector]</b></font> ".."<font color=\"#158583\"><b>"..msg.."</b></font>")
end

function TCPGetRequest(server, path, data, port)
	local start_t = os.clock()
	local port = port or 80
	local data = data or {}
	local lua_socket = require("socket")
	local connection_tcp = lua_socket.connect(server,port)
	local requeststring = "GET "..path
	local first = true
	for i,v in pairs(data)do
		requeststring = requeststring..(first and "?" or "&")..i.."="..v
		first = false
	end
	requeststring = requeststring.. " HTTP/1.0\r\nHost: "..server.."\r\n\r\n"
	connection_tcp:send(requeststring)
	local response = ""
	local status
	while true do
		s,status, partial = connection_tcp:receive('*a')
		response = response..(s or partial)
		if(status == "closed" or status == "timeout")then
			break
		end
	end
	local end_t = os.clock()
	local start_content = response:find("\r\n\r\n")+4
	response = response:sub(start_content)
	return response, status, end_t-start_t
end

function GetWebFile(server, path, data, localfilename, port, b64)
	local r,s,t = TCPGetRequest(server, path, data, port)
	
	local a,b 
	if b64 then
		a,b = Base64Decode(r)
	else
		a = r
	end
	if (a ~= "No_new_version" and a ~= "Invalid Request" and a ~= "MYSQL Error" and a ~= "") then
		file = io.open(localfilename,"w+b")
		file:write(a)
		file:close()
        Print("New version downloaded, press 2x F9.")
		return true
	else
		if a ~= "No_new_version" then
			print(a, 4)
		end
		return false
	end
end

-- START: BOL TOOLS.
assert(load(Base64Decode("G0x1YVIAAQQEBAgAGZMNChoKAAAAAAAAAAAAAQpQAAAABAAAAEYAQAClAAAAXUAAAUZAQAClQAAAXUAAAWWAAAAIQACBZcAAAAhAgIFLAAAAgQABAMZAQQDHgMEBAQEBAKGACoCGQUEAjMFBAwACgAKdgYABmwEAABcACYDHAUID2wEAABdACIDHQUIDGIDCAxeAB4DHwUIDzAHDA0FCAwDdgYAB2wEAABdAAoDGgUMAx8HDAxgAxAMXgACAwUEEANtBAAAXAACAwYEEAEqAgQMXgAOAx8FCA8wBwwNBwgQA3YGAAdsBAAAXAAKAxoFDAMfBwwMYAMUDF4AAgMFBBADbQQAAFwAAgMGBBABKgIEDoMD0f4ZARQDlAAEAnUAAAYaARQDBwAUAnUAAAYbARQDlQAEAisAAjIbARQDlgAEAisCAjIbARQDlwAEAisAAjYbARQDlAAIAisCAjR8AgAAcAAAABBIAAABBZGRVbmxvYWRDYWxsYmFjawAEFAAAAEFkZEJ1Z3NwbGF0Q2FsbGJhY2sABAwAAABUcmFja2VyTG9hZAAEDQAAAEJvbFRvb2xzVGltZQADAAAAAAAA8D8ECwAAAG9iak1hbmFnZXIABAsAAABtYXhPYmplY3RzAAQKAAAAZ2V0T2JqZWN0AAQGAAAAdmFsaWQABAUAAAB0eXBlAAQHAAAAb2JqX0hRAAQFAAAAbmFtZQAEBQAAAGZpbmQABAIAAAAxAAQHAAAAbXlIZXJvAAQFAAAAdGVhbQADAAAAAAAAWUAECAAAAE15TmV4dXMABAsAAABUaGVpck5leHVzAAQCAAAAMgADAAAAAAAAaUAEFQAAAEFkZERlbGV0ZU9iakNhbGxiYWNrAAQGAAAAY2xhc3MABA4AAABTY3JpcHRUcmFja2VyAAQHAAAAX19pbml0AAQSAAAAU2VuZFZhbHVlVG9TZXJ2ZXIABAoAAABzZW5kRGF0YXMABAsAAABHZXRXZWJQYWdlAAkAAAACAAAAAwAAAAAAAwkAAAAFAAAAGABAABcAAIAfAIAABQAAAAxAQACBgAAAHUCAAR8AgAADAAAAAAQSAAAAU2VuZFZhbHVlVG9TZXJ2ZXIABAcAAAB1bmxvYWQAAAAAAAEAAAABAAAAAAAAAAAAAAAAAAAAAAAEAAAABQAAAAAAAwkAAAAFAAAAGABAABcAAIAfAIAABQAAAAxAQACBgAAAHUCAAR8AgAADAAAAAAQSAAAAU2VuZFZhbHVlVG9TZXJ2ZXIABAkAAABidWdzcGxhdAAAAAAAAQAAAAEAAAAAAAAAAAAAAAAAAAAAAAUAAAAHAAAAAQAEDQAAAEYAwACAAAAAXYAAAUkAAABFAAAATEDAAMGAAABdQIABRsDAAKUAAADBAAEAXUCAAR8AgAAFAAAABA4AAABTY3JpcHRUcmFja2VyAAQSAAAAU2VuZFZhbHVlVG9TZXJ2ZXIABAUAAABsb2FkAAQMAAAARGVsYXlBY3Rpb24AAwAAAAAAQHpAAQAAAAYAAAAHAAAAAAADBQAAAAUAAAAMAEAAgUAAAB1AgAEfAIAAAgAAAAQSAAAAU2VuZFZhbHVlVG9TZXJ2ZXIABAgAAAB3b3JraW5nAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAEAAAAAAAAAAAAAAAAAAAAAAAAACAAAAA0AAAAAAAYyAAAABgBAAB2AgAAaQEAAF4AAgEGAAABfAAABF0AKgEYAQQBHQMEAgYABAMbAQQDHAMIBEEFCAN0AAAFdgAAACECAgUYAQQBHQMEAgYABAMbAQQDHAMIBEMFCAEbBQABPwcICDkEBAt0AAAFdgAAACEAAhUYAQQBHQMEAgYABAMbAQQDHAMIBBsFAAA9BQgIOAQEARoFCAE/BwgIOQQEC3QAAAV2AAAAIQACGRsBAAIFAAwDGgEIAAUEDAEYBQwBWQIEAXwAAAR8AgAAOAAAABA8AAABHZXRJbkdhbWVUaW1lcgADAAAAAAAAAAAECQAAADAwOjAwOjAwAAQGAAAAaG91cnMABAcAAABzdHJpbmcABAcAAABmb3JtYXQABAYAAAAlMDIuZgAEBQAAAG1hdGgABAYAAABmbG9vcgADAAAAAAAgrEAEBQAAAG1pbnMAAwAAAAAAAE5ABAUAAABzZWNzAAQCAAAAOgAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAABUAAAAcAAAAAQAFIwAAABsAAAAXwAeARwBAAFsAAAAXAAeARkBAAFtAAAAXQAaACIDAgEfAQABYAMEAF4AAgEfAQAAYQMEAF4AEgEaAwQCAAAAAxsBBAF2AgAGGgMEAwAAAAAYBQgCdgIABGUAAARcAAYBFAAABTEDCAMGAAgBdQIABF8AAgEUAAAFMQMIAwcACAF1AgAEfAIAADAAAAAQGAAAAdmFsaWQABAcAAABEaWRFbmQAAQEEBQAAAG5hbWUABB4AAABTUlVfT3JkZXJfbmV4dXNfc3dpcmxpZXMudHJveQAEHgAAAFNSVV9DaGFvc19uZXh1c19zd2lybGllcy50cm95AAQMAAAAR2V0RGlzdGFuY2UABAgAAABNeU5leHVzAAQLAAAAVGhlaXJOZXh1cwAEEgAAAFNlbmRWYWx1ZVRvU2VydmVyAAQEAAAAd2luAAQGAAAAbG9vc2UAAAAAAAMAAAABAQAAAQAAAAAAAAAAAAAAAAAAAAAAHQAAAB0AAAACAAICAAAACkAAgB8AgAABAAAABAoAAABzY3JpcHRLZXkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHQAAAB4AAAACAAUKAAAAhgBAAMAAgACdgAABGEBAARfAAICFAIAAjIBAAQABgACdQIABHwCAAAMAAAAEBQAAAHR5cGUABAcAAABzdHJpbmcABAoAAABzZW5kRGF0YXMAAAAAAAIAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAB8AAAAuAAAAAgATPwAAAApAAICGgEAAnYCAAAqAgICGAEEAxkBBAAaBQQAHwUECQQECAB2BAAFGgUEAR8HBAoFBAgBdgQABhoFBAIfBQQPBgQIAnYEAAcaBQQDHwcEDAcICAN2BAAEGgkEAB8JBBEECAwAdggABFgECAt0AAAGdgAAACoCAgYaAQwCdgIAACoCAhgoAxIeGQEQAmwAAABdAAIAKgMSHFwAAgArAxIeGQEUAh4BFAQqAAIqFAIAAjMBFAQEBBgBBQQYAh4FGAMHBBgAAAoAAQQIHAIcCRQDBQgcAB0NAAEGDBwCHw0AAwcMHAAdEQwBBBAgAh8RDAFaBhAKdQAACHwCAACEAAAAEBwAAAGFjdGlvbgAECQAAAHVzZXJuYW1lAAQIAAAAR2V0VXNlcgAEBQAAAGh3aWQABA0AAABCYXNlNjRFbmNvZGUABAkAAAB0b3N0cmluZwAEAwAAAG9zAAQHAAAAZ2V0ZW52AAQVAAAAUFJPQ0VTU09SX0lERU5USUZJRVIABAkAAABVU0VSTkFNRQAEDQAAAENPTVBVVEVSTkFNRQAEEAAAAFBST0NFU1NPUl9MRVZFTAAEEwAAAFBST0NFU1NPUl9SRVZJU0lPTgAECwAAAGluZ2FtZVRpbWUABA0AAABCb2xUb29sc1RpbWUABAYAAABpc1ZpcAAEAQAAAAAECQAAAFZJUF9VU0VSAAMAAAAAAADwPwMAAAAAAAAAAAQJAAAAY2hhbXBpb24ABAcAAABteUhlcm8ABAkAAABjaGFyTmFtZQAECwAAAEdldFdlYlBhZ2UABA4AAABib2wtdG9vbHMuY29tAAQXAAAAL2FwaS9ldmVudHM/c2NyaXB0S2V5PQAECgAAAHNjcmlwdEtleQAECQAAACZhY3Rpb249AAQLAAAAJmNoYW1waW9uPQAEDgAAACZib2xVc2VybmFtZT0ABAcAAAAmaHdpZD0ABA0AAAAmaW5nYW1lVGltZT0ABAgAAAAmaXNWaXA9AAAAAAACAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAvAAAAMwAAAAMACiEAAADGQEAAAYEAAN2AAAHHwMAB3YCAAArAAIDHAEAAzADBAUABgACBQQEA3UAAAscAQADMgMEBQcEBAIABAAHBAQIAAAKAAEFCAgBWQYIC3UCAAccAQADMgMIBQcECAIEBAwDdQAACxwBAAMyAwgFBQQMAgYEDAN1AAAIKAMSHCgDEiB8AgAASAAAABAcAAABTb2NrZXQABAgAAAByZXF1aXJlAAQHAAAAc29ja2V0AAQEAAAAdGNwAAQIAAAAY29ubmVjdAADAAAAAAAAVEAEBQAAAHNlbmQABAUAAABHRVQgAAQSAAAAIEhUVFAvMS4wDQpIb3N0OiAABAUAAAANCg0KAAQLAAAAc2V0dGltZW91dAADAAAAAAAAAAAEAgAAAGIAAwAAAPyD15dBBAIAAAB0AAQKAAAATGFzdFByaW50AAQBAAAAAAQFAAAARmlsZQAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAABAAAAAAAAAAAAAAAAAAAAAAA="), nil, "bt", _ENV))()
TrackerLoad("J5mt34lWsXS3sKbb")
-- END: BOL TOOLS.