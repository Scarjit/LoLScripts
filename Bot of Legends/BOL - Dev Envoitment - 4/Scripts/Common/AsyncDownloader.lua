--By S1mple

--[[
function OnLoad()
	print("AsynDownloader, please stand by")
	host = "www.scarjit.de"
	file = "/S1mpleScripts/img/Nami-icon.png"
	file2 = "/S1mpleScripts/Scripts/BolStudio/Nami/S1mple_Nami.version"
	name = "test.png"
	name2 = "test2.txt"
	DelayAction(function ()
		DL = Download()
		DL:newDL(host,file, name, SCRIPT_PATH, function ()
			print("Done")
		end)
		DL:newDL(host,file2, name2, SCRIPT_PATH)

		
	end,2)
end
]]--
class "Download"
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
	if not callcack then
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
			print(type(self.callbacks[k]))
		end
	end
	self.aktivedownloads = {}
	self.aktivedownloads = x
end

