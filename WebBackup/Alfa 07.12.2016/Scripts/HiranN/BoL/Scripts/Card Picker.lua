if myHero.charName ~= "TwistedFate" then return end

function OnLoad()
	CardPick()
end

function Print(msg)
	print("<font color=\"#5E9C19\">Card Picker ></font><font color=\"#5E9C41\"> "..msg.."</font>")
end

class 'CardPick'

function CardPick:__init()
	ToSelectCard = nil
    RN = 0

	Menu = scriptConfig("Card Picker", "HiranNCardPick")

	Menu:addParam("Yellow", "Yellow Card Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("W"))
	Menu:addParam("Red", "Red Card Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("E"))
	Menu:addParam("Blue", "Blue Card Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("T"))
    Menu:addParam("R", "Select Gold Card in Ultimate", SCRIPT_PARAM_ONOFF, true)
	Menu:addParam("On", "Only Select Card: When W is READY", SCRIPT_PARAM_ONOFF, true)

	AddTickCallback(function() self:Tick() end)
    AddTickCallback(function() self:Tick() end)
	AddCastSpellCallback(function(iSpell, startPos, endPos, targetUnit) self:OnCastSpell(iSpell, startPos, endPos, targetUnit) end)
    Print("Loaded !")
end

function CardPick:Tick()
	if myHero.dead then
		return
	end
	if myHero:CanUseSpell(_W) == READY then
		if ToSelectCard ~= nil and myHero:GetSpellData(_W).name == "PickACard" then
			CastSpell(_W)
		end
		if ToSelectCard ~= nil and myHero:GetSpellData(_W).name:find(ToSelectCard) then
			CastSpell(_W)
		end
	end
end

function CardPick:OnCastSpell(iSpell, startPos, endPos, targetUnit)
	if iSpell == 1 and ToSelectCard ~= nil and myHero:GetSpellData(_W).name:find(ToSelectCard) then
		ToSelectCard = nil
	end
    if iSpell == 3 then
        RN = RN + 1
        if Menu.R and RN >= 2 and myHero:CanUseSpell(_W) == READY then
            ToSelectCard = "Gold"
            RN = 0
        end
    end
end

function OnWndMsg(msg, key)
	if Menu.On and myHero:CanUseSpell(_W) ~= READY then
		return
	end
	if key == Menu._param[1].key then
		ToSelectCard = "Gold"
	elseif key == Menu._param[2].key then
		ToSelectCard = "Red"
	elseif key == Menu._param[3].key then
		ToSelectCard = "Blue"
	end
end

function CardPick:Update()
	Version = 0.10
	if Version ~= TCPGetRequest("s1mplescripts.de", "/HiranN/BoL/Versions/Card%20Picker.version", {}, 80) then
		Print("Downloading new version, don't press 2x F9.")
		GetWebFile("s1mplescripts.de","/HiranN/BoL/Scripts/Card%20Picker.lua",{},SCRIPT_PATH..GetCurrentEnv().FILE_NAME)
	else
		Print("You are using the latest version. ("..Version..")")
	end
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