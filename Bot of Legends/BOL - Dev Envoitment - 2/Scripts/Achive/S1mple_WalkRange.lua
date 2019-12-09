version = 0.1
autoupdate = true


--[[------------------DO NOT CHANGE ANYTHING BELOW THIS LINE------------------]]--

-- Made by Nebelwolfi. Makes Classes Local, Not Global -- 
function Class(name)
	_ENV[name] = { }
	_ENV[name].__index = _ENV[name]
	local mt = { __call = function(self, ...) local b = { } setmetatable(b, _ENV[name]) b:__init(...) return b end }
	setmetatable(_ENV[name], mt)
end

-- Keydown Fix --
local originalKD = _G.IsKeyDown;
_G.IsKeyDown = function(theKey)
	if (type(theKey) ~= 'number') then
		local tn = tonumber(theKey);
		if (tn ~= nil) then
			return originalKD(tn);
		else
			return originalKD(GetKey(theKey));
		end;
	else
		return originalKD(theKey);
	end
end

local enemys = {}
function OnLoad()
	Config()
	if autoupdate then
		update()
	end
	for i,v in pairs(GetEnemyHeroes()) do
		enemys[#enemys+1] = Enemy(v,i)
	end
end

function Config()
	--Conf = MenuConfig(string ID, string ID)
end


Class "Enemy"
function Enemy:__init(v,i)
	if not v then
		print("An error occured while registering Enemy Heroes")
		print("Please report this to S1mple")
		return
	end
	print(v.charName.." registerd")
	self.hero = v
	self.lastposition = v.pos
	self.lastseen = os.clock()
	self.i = i
	AddTickCallback(function ()
		self:OnTick()
	end)
	AddDrawCallback(function ()
		self:OnDraw()
	end)
end

function Enemy:OnTick()
	if self.hero.visible and not self.hero.dead then
		self.lastposition = self.hero.pos
		self.lastseen = os.clock()
	end
end

function Enemy:OnDraw()
	if self.hero.visible or self.hero.dead then return end
	local dst = (os.clock()-self.lastseen)*self.hero.ms
	if dst < 10000 then
		local quality = 24
		if dst > 2500 then quality = 32 end
		if dst > 5000 then quality = 48 end
		if dst > 7500 then quality = 64 end
		DrawTextA(quality)
		DrawCircleMinimap(self.lastposition.x, self.lastposition.y, self.lastposition.z, dst, 1, ARGB(255,255,0,0), quality)
		if dst >= GetDistance(myHero,self.hero) then
			DrawTextA(self.hero.charName.." could be right next to you",30,WINDOW_H/2, WINDOW_W/2-(36*(self.i-1)))
		end
	else
		DrawTextA(self.hero.charName.." could be anywhere, be carefull",30,WINDOW_H/2, WINDOW_W/2-(36*(self.i-1)))
	end
end







function update()
	host = "www.scarjit.de"
	file = "/S1mpleScripts/Scripts/BolStudio/Other/S1mple_WalkRange.lua"
	name = "S1mple_WalkRange.lua"

	local ServerVersionDATA = GetWebResult("scarjit.de" , "/S1mpleScripts/Scripts/BolStudio/Other/S1mple_WalkRange.version")
	if ServerVersionDATA then
		local ServerVersion = tonumber(ServerVersionDATA)
		if ServerVersion then
			if ServerVersion > tonumber(version) then
				print("Updating, don't press F9")
				print("Server Version: "..ServerVersion.." Client Version: "..version)
				DelayAction(function ()
					DL = Download()
					DL:newDL(host,file, name, SCRIPT_PATH, function ()
						print("S1mple_WalkRange updated, please reload (2xF9)")
					end)
				end,0.2)
				
			end
		else
			print("An error occured, while updating, please reload")
		end
	else
		print("Could not connect to update Server")
	end
end

Class "Download"
function Download:__init()
	self.aktivedownloads = {}
	self.callbacks = {}

	AddTickCallback(function ()
		self:RemoveDone()
	end)

	class "AsyncDL"
	function AsyncDL:__init(host, file, name,offset, path)
		self.Data = ''
		self.host = host
		self.file = file
		self.name = name
		self.size = 0
		self.path = path
		self.offset = offset
		self.percentage = 0
		self.socket = require("socket")
		self.tcp = self.socket.tcp()
		self.tcp:settimeout(99999,'b')
		self.tcp:settimeout(9999999,'t')
		self.tcp:connect(self.host, 80)
		self.writentofile = false
		self:download()
		AddDrawCallback(function ()
			self:Draw()
		end)
		AddTickCallback(function ()
			self:Tick()
		end)
	end

	function AsyncDL:download()
		local CRLF = '\r\n';
		self.tcp:send('GET '..self.file..' HTTP/1.1'.. CRLF ..'Host: '..self.host.. CRLF ..'User-Agent: Bot of Legends 1.0'.. CRLF .. CRLF)
	end

	function AsyncDL:Draw()
		if self.Data and self.size then
			if self.percentage ~= 100 then
				DrawTextA("Updating: "..self.name,15,50,35+self.offset)
				DrawRectangleOutline(49,50+self.offset,152,20, ARGB(255,255,255,255),1)
				DrawLine(50,60+self.offset,50+(1.5*self.percentage),60+self.offset,18,ARGB(150,255,255,255))
			end

			--DrawTextA(self.Data)
		end
	end

	function AsyncDL:Tick()
		if self.cStatus ~= 'timeout' then
			self.fString, self.cStatus, self.pString = self.tcp:receive(1024);
		end
		if ((self.fString) or (#self.pString > 0)) then
			self.Data = self.Data .. (self.fString or self.pString)
		end

		if self.cStatus == 'closed' and self.writentofile == false then
			self.writentofile = true
			local file = io.open(self.path.."\\"..self.name, "w+b")
			if self.l then
				file:write(string.sub(self.Data,self.l+1))
			else
				local begins = string.find(self.Data, "Length: .+")
				local ends = string.find(self.Data, "Connection")
				local sizeraw = tonumber(string.sub(self.Data, begins+string.len("Length: "), ends-1))
				local beginx = string.find(self.Data, "Type: .+\n")
				local endx = string.find(string.sub(self.Data,beginx,beginx+20),"\n")
				self.l = string.sub(self.Data,0,beginx+endx):len()+1
				self.size = sizeraw+self.l
				self.percentage = (#self.Data/self.size)*100
				file:write(string.sub(self.Data,self.l+1))
			end
			file:close()
			self.tcp:close()
		end

		if self.Data then
			local begins = string.find(self.Data, "Length: .+")
			local ends = string.find(self.Data, "Connection")
			local sizeraw = tonumber(string.sub(self.Data, begins+string.len("Length: "), ends-1))
			local beginx = string.find(self.Data, "Type: .+\n")
			local endx = string.find(string.sub(self.Data,beginx,beginx+20),"\n")
			self.l = string.sub(self.Data,0,beginx+endx):len()+1
			self.size = sizeraw+self.l
			self.percentage = (#self.Data/self.size)*100
		end
	end
end

function Download:newDL(host, file, name, path, callback)
	local offset = (#self.aktivedownloads)*40
	self.aktivedownloads[#self.aktivedownloads+1] = AsyncDL(host, file, name, offset, path)
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
		if v.percentage ~= 100 then
			x[#x+1] = v
		else
			self.callbacks[k]()
		end
	end
	self.aktivedownloads = {}
	self.aktivedownloads = x
end











function update()
	host = "www.scarjit.de"
	file = "/S1mpleScripts/Scripts/BolStudio/Other/S1mple_WalkRange.lua"
	name = "S1mple_WalkRange.lua"

	local ServerVersionDATA = GetWebResult("scarjit.de" , "/S1mpleScripts/Scripts/BolStudio/Other/S1mple_WalkRange.version")
	if ServerVersionDATA then
		local ServerVersion = tonumber(ServerVersionDATA)
		if ServerVersion then
			if ServerVersion > tonumber(version) then
				print("Updating, don't press F9")
				print("Server Version: "..ServerVersion.." Client Version: "..version)
				DelayAction(function ()
					DL = Download()
					DL:newDL(host,file, name, SCRIPT_PATH, function ()
						print("S1mple_WalkRange updated, please reload (2xF9)")
					end)
				end,0.2)
				
			end
		else
			print("An error occured, while updating, please reload")
		end
	else
		print("Could not connect to update Server")
	end
end

Class "Download"
function Download:__init()
	self.aktivedownloads = {}
	self.callbacks = {}

	AddTickCallback(function ()
		self:RemoveDone()
	end)

	class "AsyncDL"
	function AsyncDL:__init(host, file, name,offset, path)
		self.Data = ''
		self.host = host
		self.file = file
		self.name = name
		self.size = 0
		self.path = path
		self.offset = offset
		self.percentage = 0
		self.socket = require("socket")
		self.tcp = self.socket.tcp()
		self.tcp:settimeout(99999,'b')
		self.tcp:settimeout(9999999,'t')
		self.tcp:connect(self.host, 80)
		self.writentofile = false
		self:download()
		AddDrawCallback(function ()
			self:Draw()
		end)
		AddTickCallback(function ()
			self:Tick()
		end)
	end

	function AsyncDL:download()
		local CRLF = '\r\n';
		self.tcp:send('GET '..self.file..' HTTP/1.1'.. CRLF ..'Host: '..self.host.. CRLF ..'User-Agent: Bot of Legends 1.0'.. CRLF .. CRLF)
	end

	function AsyncDL:Draw()
		if self.Data and self.size then
			if self.percentage ~= 100 then
				DrawTextA("Updating: "..self.name,15,50,35+self.offset)
				DrawRectangleOutline(49,50+self.offset,152,20, ARGB(255,255,255,255),1)
				DrawLine(50,60+self.offset,50+(1.5*self.percentage),60+self.offset,18,ARGB(150,255,255,255))
			end

			--DrawTextA(self.Data)
		end
	end

	function AsyncDL:Tick()
		if self.cStatus ~= 'timeout' then
			self.fString, self.cStatus, self.pString = self.tcp:receive(1024);
		end
		if ((self.fString) or (#self.pString > 0)) then
			self.Data = self.Data .. (self.fString or self.pString)
		end

		if self.cStatus == 'closed' and self.writentofile == false then
			self.writentofile = true
			local file = io.open(self.path.."\\"..self.name, "w+b")
			if self.l then
				file:write(string.sub(self.Data,self.l+1))
			else
				local begins = string.find(self.Data, "Length: .+")
				local ends = string.find(self.Data, "Connection")
				local sizeraw = tonumber(string.sub(self.Data, begins+string.len("Length: "), ends-1))
				local beginx = string.find(self.Data, "Type: .+\n")
				local endx = string.find(string.sub(self.Data,beginx,beginx+20),"\n")
				self.l = string.sub(self.Data,0,beginx+endx):len()+1
				self.size = sizeraw+self.l
				self.percentage = (#self.Data/self.size)*100
				file:write(string.sub(self.Data,self.l+1))
			end
			file:close()
			self.tcp:close()
		end

		if self.Data then
			local begins = string.find(self.Data, "Length: .+")
			local ends = string.find(self.Data, "Connection")
			local sizeraw = tonumber(string.sub(self.Data, begins+string.len("Length: "), ends-1))
			local beginx = string.find(self.Data, "Type: .+\n")
			local endx = string.find(string.sub(self.Data,beginx,beginx+20),"\n")
			self.l = string.sub(self.Data,0,beginx+endx):len()+1
			self.size = sizeraw+self.l
			self.percentage = (#self.Data/self.size)*100
		end
	end
end

function Download:newDL(host, file, name, path, callback)
	local offset = (#self.aktivedownloads)*40
	self.aktivedownloads[#self.aktivedownloads+1] = AsyncDL(host, file, name, offset, path)
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
		if v.percentage ~= 100 then
			x[#x+1] = v
		else
			self.callbacks[k]()
		end
	end
	self.aktivedownloads = {}
	self.aktivedownloads = x
end

