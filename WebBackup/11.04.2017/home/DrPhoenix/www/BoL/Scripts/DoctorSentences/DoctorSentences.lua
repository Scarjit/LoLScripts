--[[

                            SCRIPT BY DrPhoenix
				Special thanks to S1mple for the Download function
				
				
				
		DON'T READ THIS FILE ! YOU ARE GOING TO SPOIL YOU THE SENTENCES !
		
		
		
		
	If you really want to read this file you can add your own sentence bellow :p
	
	
	
	
	
	
Changelog :
	1.01 : First release
	1.02 : Add ScriptStatus Tracker
	1.03 : 3 New sentences :)
	1.04 : Little fix
	1.05 : Update the updater !
	
	More Soon !
	

]]--

version = 1.05



assert(load(Base64Decode("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"), nil, "bt", _ENV))()
TrackerLoad("qOwtvYRxGGFQaDCc")

local AutoUpdate = true

local nbK = 0
local nbD = 0
local nbA = 0
 
function OnLoad()
  AddMenu()
  Update()
end
 
function AddMenu()
  Config = scriptConfig("Doctor Sentences", "DoctorSentences")
 
  Config:addSubMenu("Settings", "Settings")
    Config.Settings:addParam("sentencesON", "Say sententences", SCRIPT_PARAM_ONOFF, true)
end
 
function OnTick()
  nbK = myHero.kills
  nbD = myHero.deaths
  nbA = myHero.assists
 
  if nbK + nbD + nbA ~= KDA and Config.Settings.sentencesON then
    checkKDA()
  end
end
 
function checkKDA()
  if nbK == 0 and nbD == 0 and nbA == 0 then
    PrintChatMsg("Time to get some kills !")
  elseif nbK == 0 and nbD ~= nil and nbA == 0 then
    PrintChatMsg("One kill participation is not that much, I'm sure you can do it !")
  elseif nbK == 0 and nbD == 0 and nbA == 7 then
    PrintChatMsg("James Bond support !")
  elseif nbK == 2 and nbD == 7 and nbA == 0 then
    PrintChatMsg("2/7/0 Kaaris Omega Squad !")
  elseif nbK == 3 and nbD == 1 and nbA == 4 then
    PrintChatMsg("Are you excited by pi=3.14159265359 ?")
  elseif nbK == 4 and nbD == 0 and nbA == 4 then
    PrintChatMsg("404 : Skill not found ! Are you playing Teemo ?")
  elseif nbK == 4 and nbD == 2 and nbA == 0 then
    PrintChatMsg("420 BLAZE IT FAGGOT !")
  elseif nbK == 6 and nbD == 6 and nbA == 6 then
    PrintChatMsg("6/6/6 but don't vote for Donald Drumpf !")
  elseif nbK == 9 and nbD == 1 and nbA == 1 then
    PrintChatMsg("CALL 911 !")
  elseif nbK == 9 and nbD == 11 then
    PrintChatMsg("Don't stay in 9/11,it's not a good number (except if you are a main Ziggs)")
  elseif nbK == 13 and nbD == 3 and nbA == 7 then
    PrintChatMsg("1337 5p34k : y0u 607 7h15 !")
  elseif nbK == 14 and nbD == 9 and nbA == 2 then
    PrintChatMsg("Good job Christophe !\n<font color=\"#FF7F07\"><b>\"Achievement unlocked : Discover America !\"</b></font>")
  elseif nbK == 16 and nbD == 6 and nbA == 4 then
    PrintChatMsg("You're an alcoholic but you still play well ! You will be Challenger if you stop drink that much !")
  elseif nbK == 17 and nbD == 8 and nbA == 9 then
    PrintChatMsg("Time to cut some more heads !")
  end
  KDA = nbK + nbD + nbA
end
 
function PrintChatMsg(msg)
  PrintChat("<font color=\"#6eed00\"><b>[</b></font><font color=\"#a2ed00\"><b>Doctor Sentences</b></font><font color=\"#6eed00\"><b>]</b></font> <font color=\"#fce700\">"..msg.."</font>")
end
 
function Update()
    local UpdateHost = "www.s1mplescripts.de"
    local ServerPath = "/DrPhoenix/BoL/Scripts/DoctorSentences/"
    local ServerFileName = "DoctorSentences.lua"
    local ServerVersionFileName = "DoctorSentences.version"
 
    DL = Download()
    local ServerVersionDATA = GetWebResult("s1mplescripts.de" , ServerPath..ServerVersionFileName)
    if ServerVersionDATA then
        local ServerVersion = tonumber(ServerVersionDATA)
        if ServerVersion then
            if ServerVersion > tonumber(version) then
                PrintChatMsg("Updating, don't press F9")
                DL:newDL(UpdateHost, ServerPath..ServerFileName, ServerFileName, SCRIPT_PATH, function ()
                    PrintChatMsg("DoctorSentences updated, please reload")
                end)
            end
        else
            PrintChatMsg("An error occured, while updating, please reload")
        end
    else
        PrintChatMsg("Could not connect to update Server")
    end
	
	local KDA = nil
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