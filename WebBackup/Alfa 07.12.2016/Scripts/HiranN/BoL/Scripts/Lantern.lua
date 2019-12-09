class 'Lantern'
class 'Download'

function Lantern:__init()
	Allies = 0
    for i = 1, heroManager.iCount do
    local hero = heroManager:GetHero(i)
    if hero.team == myHero.team and hero.networkID ~= myHero.networkID then
    Allies = Allies+1
    end
	end
	if VIP_USER then
  	for i, ally in ipairs(GetAllyHeroes()) do
  	if i >= Allies then self:SendMsg("Ally Thresh not found") end
  	if ally.charName == "Thresh" then  	
	self.Version = 0.10
	self.HasLantern = nil
	self.NotifyList = {}
	self.LastP = 0
	self:Menu()
	self:Callbacks()
	self:SendMsg("Loaded")
	self:CheckUpdates()
	end
	end
	else
	self:SendMsg("You need be VIP to use this")
	end
end

function Lantern:Menu()
  	Menu = scriptConfig("Grab Thresh Lantern", "ThreshLanternHiranN")
	Menu:addParam("Grab", "Grab Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("T"))
    Menu:addParam("Auto", "Auto Grab if life below %", SCRIPT_PARAM_SLICE, 15, 0, 100, 0)
	Menu:addParam("Autoinfo", "0 % will disable this option.", SCRIPT_PARAM_INFO, "")
    Menu:addParam("AutoR", "Range to Auto Grab", SCRIPT_PARAM_SLICE, 1000, 250, 2000, 0)
	AddTickCallback(function() self:Tick() end)
end

function Lantern:Callbacks()
	AddCreateObjCallback(function(obj) 
	if obj and obj.valid and obj.team == myHero.team and obj.name == "ThreshLantern" then
	self.HasLantern = obj
	end
	end)
	AddDeleteObjCallback(function(obj) 
	if obj and obj.valid and obj.team == myHero.team and obj.name == "ThreshLantern" then
	self.HasLantern = nil
	end
	end)
end

function Lantern:Tick()
	if myHero.dead then return end
	if os.clock() - self.LastP >= 0.50 then
	if self.HasLantern and self.HasLantern.valid and Menu.Auto ~= 0 and ((myHero.health * 100 ) / myHero.maxHealth) <= Menu.Auto and 
	GetDistance(self.HasLantern) <= Menu.AutoR or Menu.Grab and self.HasLantern and self.HasLantern.valid then
	self:UseLantern()
	end
	end
end

TableRef = 
{
[0x18] = 0x01, [0x3C] = 0x02, [0x51] = 0x03, [0xC8] = 0x04, [0x80] = 0x05, [0xE1] = 0x06, [0xF9] = 0x07, 
[0x2E] = 0x08, [0x86] = 0x09, [0x8A] = 0x0A, [0x6B] = 0x0B, [0x96] = 0x0C, [0x1F] = 0x0D, [0xD3] = 0x0E, 
[0x44] = 0x0F, [0x8E] = 0x10, [0x47] = 0x11, [0x0C] = 0x12, [0x30] = 0x13, [0x03] = 0x14, [0xB2] = 0x15, 
[0xCF] = 0x16, [0x3F] = 0x17, [0xBC] = 0x18, [0xCA] = 0x19, [0xA1] = 0x1A, [0xA4] = 0x1B, [0x93] = 0x1C, 
[0x6E] = 0x1D, [0x37] = 0x1E, [0x79] = 0x1F, [0x88] = 0x20, [0x81] = 0x21, [0x9D] = 0x22, [0x02] = 0x23, 
[0x2D] = 0x24, [0x1A] = 0x25, [0xAF] = 0x26, [0x0D] = 0x27, [0xA7] = 0x28, [0x41] = 0x29, [0xA3] = 0x2A, 
[0xB8] = 0x2B, [0x7F] = 0x2C, [0x82] = 0x2D, [0xA0] = 0x2E, [0x32] = 0x2F, [0xAE] = 0x30, [0x28] = 0x31, 
[0x23] = 0x32, [0x57] = 0x33, [0xEB] = 0x34, [0x1E] = 0x35, [0xD6] = 0x36, [0xE6] = 0x37, [0x35] = 0x38, 
[0x4D] = 0x39, [0x08] = 0x3A, [0xCC] = 0x3B, [0x1D] = 0x3C, [0x25] = 0x3D, [0x83] = 0x3E, [0x5E] = 0x3F, 
[0xA5] = 0x40, [0x5A] = 0x41, [0xB3] = 0x42, [0xC1] = 0x43, [0x2A] = 0x44, [0x4E] = 0x45, [0x5D] = 0x46, 
[0xCB] = 0x47, [0xA9] = 0x48, [0xC3] = 0x49, [0x73] = 0x4A, [0xF1] = 0x4B, [0x9E] = 0x4C, [0x61] = 0x4D, 
[0x05] = 0x4E, [0xAD] = 0x4F, [0x17] = 0x50, [0xEA] = 0x51, [0x56] = 0x52, [0x91] = 0x53, [0x5B] = 0x54, 
[0xFB] = 0x55, [0xEC] = 0x56, [0x10] = 0x57, [0xBD] = 0x58, [0xC4] = 0x59, [0xDB] = 0x5A, [0x04] = 0x5B, 
[0x36] = 0x5C, [0x89] = 0x5D, [0x8F] = 0x5E, [0x42] = 0x5F, [0xDC] = 0x60, [0x5C] = 0x61, [0xB9] = 0x62, 
[0x0A] = 0x63, [0x69] = 0x64, [0xD2] = 0x65, [0x2B] = 0x66, [0x52] = 0x67, [0x3A] = 0x68, [0x6D] = 0x69, 
[0x15] = 0x6A, [0xD5] = 0x6B, [0x40] = 0x6C, [0x77] = 0x6D, [0x49] = 0x6E, [0x13] = 0x6F, [0xF8] = 0x70, 
[0x07] = 0x71, [0x70] = 0x72, [0x90] = 0x73, [0xCD] = 0x74, [0x87] = 0x75, [0x3E] = 0x76, [0x48] = 0x77, 
[0x1C] = 0x78, [0xB5] = 0x79, [0xDD] = 0x7A, [0x3B] = 0x7B, [0xF0] = 0x7C, [0x43] = 0x7D, [0x71] = 0x7E, 
[0xBE] = 0x7F, [0xE7] = 0x80, [0xEE] = 0x81, [0xD7] = 0x82, [0xB1] = 0x83, [0x55] = 0x84, [0xC6] = 0x85, 
[0x19] = 0x86, [0xFC] = 0x87, [0xA2] = 0x88, [0x31] = 0x89, [0x00] = 0x8A, [0x9B] = 0x8B, [0xC7] = 0x8C, 
[0x76] = 0x8D, [0xC0] = 0x8E, [0xDA] = 0x8F, [0x6C] = 0x90, [0x7C] = 0x91, [0xD8] = 0x92, [0x75] = 0x93, 
[0x68] = 0x94, [0xF6] = 0x95, [0x95] = 0x96, [0x97] = 0x97, [0x78] = 0x98, [0x14] = 0x99, [0x94] = 0x9A, 
[0xE9] = 0x9B, [0x60] = 0x9C, [0x5F] = 0x9D, [0x2F] = 0x9E, [0xBA] = 0x9F, [0x33] = 0xA0, [0xAC] = 0xA1, 
[0xDE] = 0xA2, [0x7E] = 0xA3, [0x9A] = 0xA4, [0xD9] = 0xA5, [0xC9] = 0xA6, [0x22] = 0xA7, [0x99] = 0xA8, 
[0x27] = 0xA9, [0xFF] = 0xAA, [0x45] = 0xAB, [0xF2] = 0xAC, [0xB7] = 0xAD, [0xA6] = 0xAE, [0x72] = 0xAF, 
[0xCE] = 0xB0, [0x98] = 0xB1, [0x24] = 0xB2, [0x65] = 0xB3, [0x0F] = 0xB4, [0xD4] = 0xB5, [0xA8] = 0xB6, 
[0x66] = 0xB7, [0xF4] = 0xB8, [0x54] = 0xB9, [0x39] = 0xBA, [0x92] = 0xBB, [0xAB] = 0xBC, [0x0E] = 0xBD, 
[0xAA] = 0xBE, [0x11] = 0xBF, [0x8B] = 0xC0, [0xFA] = 0xC1, [0x8D] = 0xC2, [0xEF] = 0xC3, [0x64] = 0xC4, 
[0x4A] = 0xC5, [0xE4] = 0xC6, [0x67] = 0xC7, [0x8C] = 0xC8, [0x21] = 0xC9, [0x38] = 0xCA, [0x06] = 0xCB, 
[0x2C] = 0xCC, [0xF7] = 0xCD, [0x7A] = 0xCE, [0x3D] = 0xCF, [0x63] = 0xD0, [0xD1] = 0xD1, [0x12] = 0xD2, 
[0x85] = 0xD3, [0x4F] = 0xD4, [0x53] = 0xD5, [0x34] = 0xD6, [0x9C] = 0xD7, [0xFE] = 0xD8, [0x29] = 0xD9, 
[0x26] = 0xDA, [0xD0] = 0xDB, [0xB4] = 0xDC, [0xE8] = 0xDD, [0x58] = 0xDE, [0x62] = 0xDF, [0xE0] = 0xE0, 
[0x01] = 0xE1, [0xF5] = 0xE2, [0xFD] = 0xE3, [0x84] = 0xE4, [0xF3] = 0xE5, [0x09] = 0xE6, [0x50] = 0xE7, 
[0xE2] = 0xE8, [0x1B] = 0xE9, [0x46] = 0xEA, [0xC2] = 0xEB, [0x6A] = 0xEC, [0xB6] = 0xED, [0x0B] = 0xEE, 
[0x20] = 0xEF, [0xC5] = 0xF0, [0x7D] = 0xF1, [0xBB] = 0xF2, [0x7B] = 0xF3, [0xE5] = 0xF4, [0x6F] = 0xF5, 
[0x4B] = 0xF6, [0xE3] = 0xF7, [0xB0] = 0xF8, [0x16] = 0xF9, [0x59] = 0xFA, [0xDF] = 0xFB, [0x4C] = 0xFC, 
[0x9F] = 0xFD, [0xBF] = 0xFE, [0x74] = 0xFF, [0xED] = 0x00,
}

function Lantern:UseLantern()
 	if (string.find(GetGameVersion(), 'Releases/6.3') ~= nil) then
	self.LastP = os.clock()
	p = CLoLPacket(0x00E4)
	p.vTable = 0xF53580
	p:EncodeF(myHero.networkID)
	local aFake = CLoLPacket(0x0001)
	aFake:EncodeF(self.HasLantern.networkID)
	aFake.pos = 2
	local bytes = {}
	for i = 1, 4 do
	bytes[i]=TableRef[aFake:Decode1()]
	end
	for i = 1, 4 do p:Encode1(bytes[i]) end 
	SendPacket(p)
	end
end

function Lantern:SendMsg(msg)
	PrintChat("<font color=\"#3FF4CB\"><b>[Grab Thresh Lantern]</b></font> ".."<font color=\"#DFBC5E\"><b>"..msg..".</b></font>")
end

function Lantern:CheckUpdates()
  	local ServerVersionDATA = GetWebResult("www.scarjit.de", "/HiranN/BoL/Versions/Lantern.version")  
  	local ServerVersion = tonumber(ServerVersionDATA)
  	if ServerVersionDATA then
  	if ServerVersion then
  	if ServerVersion > tonumber(self.Version) then
  	self:SendMsg("Updating, don't press F9")
  	DL = Download()
  	file = "/HiranN/BoL/Scripts/Lantern.lua"
  	name = GetCurrentEnv().FILE_NAME
  	DL:newDL("www.scarjit.de", file, name, SCRIPT_PATH, function()
  	self:SendMsg("Downloaded update, press F9 2x to reload")
  	end)
  	else
  	self:SendMsg("No updates found")
  	end
  	end
	end
end

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

function OnLoad() Lantern() end