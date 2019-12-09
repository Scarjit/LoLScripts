--[[


 			Doctor Spells
		SCRIPT BY DrPhoenix


Changelog :
	1.01 : First release
	1.02 : Little fix
	1.03 : Update the updater !
	
	More Soon !

]]--

version = 1.03

assert(load(Base64Decode("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"), nil, "bt", _ENV))()
TrackerLoad("n7TmXS22iHfLhqer")


-- Start of the Code

function OnLoad()
	Update()
	AddMenu()
	PrintMsg("version "..version.." loaded !")
end

function AddMenu()
	Menu = scriptConfig("Doctor Spells", "Menu")

	Menu:addParam("UseON", "Time Enemy Spells", SCRIPT_PARAM_ONOFF, true)
	
	Menu:addParam("HumanizerON", "Use Humanizer", SCRIPT_PARAM_ONOFF, true)

	Menu:addSubMenu("Spells to time", "Spells")
		Menu.Spells:addParam("FlashON", "Time Flash", SCRIPT_PARAM_ONOFF, true)
		Menu.Spells:addParam("IgniteON", "Time Ignite", SCRIPT_PARAM_ONOFF, true)
		Menu.Spells:addParam("TeleportON", "Time Teleport", SCRIPT_PARAM_ONOFF, true)
		Menu.Spells:addParam("HealON", "Time Heal", SCRIPT_PARAM_ONOFF, true)
		Menu.Spells:addParam("ExhaustON", "Time Exhaust", SCRIPT_PARAM_ONOFF, true)
end

function PrintMsg(msg)
		PrintChat("<b><font color=\"#ff6600\">[</font><font color=\"#ffae00\">Doctor Spells</font><font color=\"#ff6600\">]</font></b> <font color=\"#f79731\">"..msg.."</font>")
end

function WriteChat(msg)
	if Menu.HumanizerON then
		DelayAction(function() SendChat(msg) end, math.random(4,11))
	else
		SendChat(msg)
	end
end

function OnProcessSpell(unit,spell)
	if Menu.UseON then
		if Menu.Spells.FlashON and unit.team ~= myHero.team and spell and spell.name:lower():find("summonerflash") and GetDistance(myHero, unit) < 1500 then
			FlashTimer(GetInGameTimer(), unit.charName)
		end
		
		if Menu.Spells.IgniteON and unit.team ~= myHero.team and spell and spell.name:lower():find("summonerdot") and GetDistance(myHero, unit) < 1500 then
			IgniteTimer(unit.charName)
		end
		
		if Menu.Spells.TeleportON and unit.team ~= myHero.team and spell and spell.name:lower():find("summonerteleport") then
			TeleportTimer(unit.charName)
		end
		
		if Menu.Spells.HealON and unit.team ~= myHero.team and spell and spell.name:lower():find("summonerheal") and GetDistance(myHero, unit) < 1500 then
			HealTimer(unit.charName)
		end
		
		if Menu.Spells.ExhaustON and unit.team ~= myHero.team and spell and spell.name:lower():find("summonerexhaust") and GetDistance(myHero, unit) < 1500 then
			ExhaustTimer(unit.charName)
		end
	end
end

function TimerFormat(timer)
	TimerMin = math.floor(timer/60)
	TimerSec = timer - (math.floor(timer/60)*60)
	
	if Menu.HumanizerON then
		TimerSecError = math.random(0,1)
		if TimerSecError == 1 then
			TimerSec = TimerSec + math.random(-2,2)
		end
	end
	
	TimerSec = math.floor(TimerSec)
	
	if TimerSec < 10 then
		TimerSec = "0"..TimerSec
	end
	
	TimerDisplay = math.random(0,1)
	if TimerDisplay == 0 then
		return TimerMin..":"..TimerSec
	elseif TimerDisplay == 1 then
		return TimerMin..TimerSec
	end
end

function FlashTimer(timer, champ)
	local baguette = math.random(0,11)
	if baguette == 0 then
		WriteChat("flash "..champ)
	elseif baguette == 1 then
		WriteChat(champ.." flash")
	elseif baguette == 2 then
		WriteChat("flash "..champ.." "..TimerFormat(timer))
	elseif baguette == 3 then
		WriteChat(champ.." flash "..TimerFormat(timer))
	elseif baguette == 4 then
		WriteChat(champ.." nf")
	elseif baguette == 5 then
		WriteChat("nf "..champ)
	elseif baguette == 6 then
		WriteChat(champ.." nf "..TimerFormat(timer))
	elseif baguette == 7 then
		WriteChat("nf "..champ.." "..TimerFormat(timer))
	elseif baguette == 8 then
		WriteChat(champ.." f")
	elseif baguette == 9 then
		WriteChat("f "..champ)
	elseif baguette == 10 then
		WriteChat(champ.." f "..TimerFormat(timer))
	elseif baguette == 11 then
		WriteChat("f "..champ.." "..TimerFormat(timer))
	end
end

function IgniteTimer(champ)
	local baguette = math.random(0,7)
	if baguette == 0 then
		WriteChat("ig "..champ)
	elseif baguette == 1 then
		WriteChat(champ.." ig")
	elseif baguette == 2 then
		WriteChat("ignite "..champ)
	elseif baguette == 3 then
		WriteChat(champ.." ignite")
	elseif baguette == 4 then
		WriteChat("no ig "..champ)
	elseif baguette == 5 then
		WriteChat(champ.." no ig")
	elseif baguette == 6 then
		WriteChat("no ignite "..champ)
	elseif baguette == 7 then
		WriteChat(champ.." no ignite")
	end
end

function TeleportTimer(champ)
	local baguette = math.random(0,3)
	if baguette == 0 then
		WriteChat("tp "..champ)
	elseif baguette == 1 then
		WriteChat(champ.." tp")
	elseif baguette == 2 then
		WriteChat("no tp "..champ)
	elseif baguette == 3 then
		WriteChat(champ.." no tp")
	end
end

function HealTimer(champ)
	local baguette = math.random(0,3)
	if baguette == 0 then
		WriteChat("heal "..champ)
	elseif baguette == 1 then
		WriteChat(champ.." heal")
	elseif baguette == 2 then
		WriteChat("no heal "..champ)
	elseif baguette == 3 then
		WriteChat(champ.." no heal")
	end
end

function ExhaustTimer(champ)
	local baguette = math.random(0,3)
	if baguette == 0 then
		WriteChat("ex "..champ)
	elseif baguette == 1 then
		WriteChat(champ.." ex")
	elseif baguette == 2 then
		WriteChat("exhaust "..champ)
	elseif baguette == 3 then
		WriteChat(champ.." exhaust")
	elseif baguette == 4 then
		WriteChat("no ex "..champ)
	elseif baguette == 5 then
		WriteChat(champ.." no ex")
	elseif baguette == 6 then
		WriteChat("no exhaust "..champ)
	elseif baguette == 7 then
		WriteChat(champ.." no exhaust")
	end
end

-- End of the Code


function Update()
    local UpdateHost = "www.s1mplescripts.de"
    local ServerPath = "/DrPhoenix/BoL/Scripts/DoctorSpells/"
    local ServerFileName = "DoctorSpells.lua"
    local ServerVersionFileName = "DoctorSpells.version"
 
    DL = Download()
    local ServerVersionDATA = GetWebResult("s1mplescripts.de" , ServerPath..ServerVersionFileName)
    if ServerVersionDATA then
        local ServerVersion = tonumber(ServerVersionDATA)
        if ServerVersion then
            if ServerVersion > tonumber(version) then
                PrintMsg("Updating, don't press F9")
                DL:newDL(UpdateHost, ServerPath..ServerFileName, ServerFileName, SCRIPT_PATH, function ()
                    PrintMsg("DoctorSpells updated, please reload")
                end)
            end
        else
            PrintMsg("An error occured, while updating, please reload")
        end
    else
        PrintMsg("Could not connect to update Server")
    end
end
 
 
class "Download"
function Download:__init()
    socket = require("socket")
    self.aktivedownloads = {}
    self.callbacks = {}
 
    AddTickCallback(function ()
        self:RemoveDone()
    end)
 
    class("Async")
    function Async:__init(host, filepath, localname, drawoffset, localpath)
        self.progress = 0
        self.host = host
        self.filepath = filepath
        self.localname = localname
        self.offset = drawoffset
        self.localpath = localpath
        self.CRLF = '\r\n'
 
        self.headsocket = socket.tcp()
        self.headsocket:settimeout(1)
        self.headsocket:connect(self.host, 80)
        self.headsocket:send('HEAD '..self.filepath..' HTTP/1.1'.. self.CRLF ..'Host: '..self.host.. self.CRLF ..'User-Agent: Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36'.. self.CRLF .. self.CRLF)
 
        self.HEADdata = ""
        self.DLdata = ""
        self.StartedDownload = false
        self.canDL = true
 
        AddTickCallback(function ()
            self:tick()
        end)
        AddDrawCallback(function ()
            self:draw()
        end)
    end
 
    function Async:tick()
        if self.progress == 100 then return end
        if self.HEADcStatus ~= "timeout" and self.HEADcStatus ~= "closed" then
            self.HEADfString, self.HEADcStatus, self.HEADpString = self.headsocket:receive(16);
            if self.HEADfString then
                self.HEADdata = self.HEADdata..self.HEADfString
            elseif self.HEADpString and #self.HEADpString > 0 then
                self.HEADdata = self.HEADdata..self.HEADpString
            end
        elseif self.HEADcStatus == "timeout" then
            self.headsocket:close()
            --Find Lenght
            local begin = string.find(self.HEADdata, "Length: ")
            if begin then
                self.HEADdata = string.sub(self.HEADdata,begin+8)
                local n = 0
                local _break = false
                for i=1, #self.HEADdata do
                    local c = tonumber(string.sub(self.HEADdata,i,i))
                    if c and _break == false then
                        n = n+1
                    else
                        _break = true
                    end
                end
                self.HEADdata = string.sub(self.HEADdata,1,n)
                self.StartedDownload = true
                self.HEADcStatus = "closed"
            end
        end
        if self.HEADcStatus == "closed" and self.StartedDownload == true and self.canDL == true then --Double Check
            self.canDL = false
            self.DLsocket = socket.tcp()
            self.DLsocket:settimeout(1)
            self.DLsocket:connect(self.host, 80)
            --Start Main Download
            self.DLsocket:send('GET '..self.filepath..' HTTP/1.1'.. self.CRLF ..'Host: '..self.host.. self.CRLF ..'User-Agent: Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36'.. self.CRLF .. self.CRLF)
        end
       
        if self.DLsocket and self.DLcStatus ~= "timeout" and self.DLcStatus ~= "closed" then
            self.DLfString, self.DLcStatus, self.DLpString = self.DLsocket:receive(1024);
           
            if ((self.DLfString) or (self.DLpString and #self.DLpString > 0)) then
                self.DLdata = self.DLdata .. (self.DLfString or self.DLpString)
            end
 
        elseif self.DLcStatus and self.DLcStatus == "timeout" then
            self.DLsocket:close()
            self.DLcStatus = "closed"
            self.DLdata = string.sub(self.DLdata,#self.DLdata-tonumber(self.HEADdata)+1)
 
            local file = io.open(self.localpath.."\\"..self.localname, "w+b")
            file:write(self.DLdata)
            file:close()
            self.progress = 100
        end
 
        if self.progress ~= 100 and self.DLdata and #self.DLdata > 0 then
            self.progress = (#self.DLdata/tonumber(self.HEADdata))*100
        end
    end
 
    function Async:draw()
        if self.progress < 100 then
            DrawTextA("Downloading: "..self.localname,15,50,35+self.offset)
            DrawRectangleOutline(49,50+self.offset,250,20, ARGB(255,255,255,255),1)
            if self.progress ~= 100 then
                DrawLine(50,60+self.offset,50+(2.5*self.progress),60+self.offset,18,ARGB(150,255-self.progress*2.5,self.progress*2.5,255-self.progress*2.5))
                DrawTextA(tostring(math.round(self.progress).." %"), 15,150,52+self.offset)
            end
        end
    end
 
end
 
function Download:newDL(host, file, name, path, callback)
    local offset = (#self.aktivedownloads+1)*40
    self.aktivedownloads[#self.aktivedownloads+1] = Async(host, file, name, offset-40, path)
    if not callback then
        callback = (function ()
        end)
    end
 
    self.callbacks[#self.callbacks+1] = callback
 
end
 
function Download:RemoveDone()
    if #self.aktivedownloads == 0 then return end
    local x = {}
    for k, v in pairs(self.aktivedownloads) do
        if math.round(v.progress) < 100 then
            v.offset = k*40-40
            x[#x+1] = v
        else
            self.callbacks[k]()
        end
    end
    self.aktivedownloads = {}
    self.aktivedownloads = x
end