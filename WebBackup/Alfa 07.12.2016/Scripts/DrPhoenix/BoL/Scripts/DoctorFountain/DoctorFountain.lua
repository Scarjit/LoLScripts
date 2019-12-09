--[[


		  Doctor Fountain
		SCRIPT BY DrPhoenix


Changelog :
	1.01 : First release
	
	More Soon !

]]--

version = 1.01


function OnLoad()
	Update()
	
	for i = 1, objManager.maxObjects do
		local object = objManager:getObject(i)
		if object ~= nil and object.valid and object.name == "sruap_order_laserturret_idle.troy" then
			ObeliskBlue = object
		end
		if object ~= nil and object.valid and object.name == "sruap_chaos_laserturret_idle.troy" then
			ObeliskRed = object
		end
	end
	MovePos = { x = 0, y = 0, z = 0 }
	Message = false
end

function OnDraw()
	if myHero.team == 100 then
		DrawCircle3D(ObeliskRed.x, 100, ObeliskRed.z, 1375, 1, ARGB(255,255,255,255), 100)
	else
		DrawCircle3D(ObeliskBlue.x, 95, ObeliskBlue.z, 1570, 1, ARGB(255,255,255,255), 100)
	end
	
	if Message then
		DrawText3D("DON'T GO IN ENEMY BASE !", mousePos.x, mousePos.y, mousePos.z + 70, 40, ARGB(255,255,0,0))
	end
end

function OnTick()
	if myHero.hasMovePath then
		if myHero.path:Path(2) then
			a=2
			while(myHero.path:Path(a) ~= nil) do
				a = a+1
			end
			MovePos = { x = myHero.path:Path(a-1).x, y = myHero.path:Path(a-1).y, z = myHero.path:Path(a-1).z }
		end
	end
	
	RedDistance = math.sqrt( ( ObeliskRed.x - MovePos.x )^2 + ( ObeliskRed.y - MovePos.y )^2 + ( ObeliskRed.z - MovePos.z )^2 )
	BlueDistance = math.sqrt( ( ObeliskBlue.x - MovePos.x )^2 + ( ObeliskBlue.y - MovePos.y )^2 + ( ObeliskBlue.z - MovePos.z )^2 )
	
	if myHero.team == 100 then
		if RedDistance < 1460 then
			myHero:MoveTo(myHero.x, myHero.z)
			Message = true
		else
			Message = false
		end
	else
		if BlueDistance < 1800 then
			myHero:MoveTo(myHero.x, myHero.z)
			Message = true
		else
			Message = false
		end
	end
end


function Update()
    local UpdateHost = "www.s1mplescripts.de"
    local ServerPath = "/DrPhoenix/BoL/Scripts/DoctorFountain/"
    local ServerFileName = "DoctorFountain.lua"
    local ServerVersionFileName = "DoctorFountain.version"
 
    DL = Download()
    local ServerVersionDATA = GetWebResult("s1mplescripts.de" , ServerPath..ServerVersionFileName)
    if ServerVersionDATA then
        local ServerVersion = tonumber(ServerVersionDATA)
        if ServerVersion then
            if ServerVersion > tonumber(version) then
                print("Updating, don't press F9")
                DL:newDL(UpdateHost, ServerPath..ServerFileName, ServerFileName, SCRIPT_PATH, function ()
                    print("DoctorFountain updated, please reload")
                end)
            end
        else
            print("An error occured, while updating, please reload")
        end
    else
        print("Could not connect to update Server")
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