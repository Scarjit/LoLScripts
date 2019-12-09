local Version = 1.314 local FileName = GetCurrentEnv().FILE_NAME

if myHero.charName ~= "Orianna" then
  return
end

class "HTTF_Orianna"

function HTTF_Orianna:ScriptMsg(msg)
  print("<font color=\"#daa520\"><b>HTTF Orianna:</b></font> <font color=\"#FFFFFF\">"..msg.."</font>")
end

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
-- S1mple Updater class thanks mate ;) 

local function class(base, init)
    local c = {}
    if not init and type(base) == 'function' then
        init = base
        base = nil
    elseif type(base) == 'table' then
        for i,v in pairs(base) do
            c[i] = v
        end
        c._base = base
    end
    c.__index = c

    local mt = {}
    mt.__call = function(class_tbl, ...)
        local obj = {}
        setmetatable(obj,c)
        if init then
            init(obj,...)
        else
            if base and base.init then
                base.init(obj, ...)
            end
        end
        return obj
    end
    c.init = init
    c.is_a = function(self, klass)
        local m = getmetatable(self)
        while m do
            if m == klass then return true end
            m = m._base
        end
        return false
    end
    setmetatable(c, mt)
    return c
end

local downloads = {}
function AddDownload(server, server_path, localpath, port, data, options)
	local function sprite_file_exists()
		local file = io.open(SPRITE_PATH.."\\S1mple\\Downloader\\Sprite.png")
		if file then file:close() return true else return false end
	end
	if sprite_file_exists() then
		local dlsize = #downloads
		local pos_y = 20+dlsize*30
		downloads[#downloads+1] = FancyDownload(server, server_path, localpath, port, data, 20, pos_y, false, options, dlsize)
	else
		--Main Download
		local dlsize = #downloads
		local pos_y = 20+dlsize*30
		downloads[#downloads+1] = FancyDownload(server, server_path, localpath, port, data, 20, pos_y, true, options, dlsize)

		--Download sprite for next time
		local dlsize = #downloads
		local pos_y = 20+dlsize*30
		downloads[#downloads+1] = FancyDownload("s1mplescripts.de", "/S1mple/Scripts/BolStudio/FancyDownloader/Sprite.png", SPRITE_PATH.."\\S1mple\\Downloader\\Sprite.png", 80, {}, 20, pos_y, true)
	end
end

FancyDownload = class(function(fd,server, server_path, localpath, port, data, pos_x, pos_y, ncp, options, i)
    assert(type(server) == "string" or type(server_path) == "string", "FancyDownload: wrong argument types (<string><string> expected for server, server_path)")
    if not data then data = {} end
    if not port then port = 80 end
    if not options then options = {} end
    if not ncp then ncp = false end
    fd.server = server
    fd.server_path = server_path
    fd.localpath = localpath
    fd.port = port
    fd.data = data
    fd.progress = 0
    fd.ncp = ncp
    fd.pos_x = pos_x
    fd.pos_y = pos_y
    fd.file_size = math.huge
    fd.lua_socket = require("socket")
    fd.download_tcp = nil
    fd.response = ""
    fd.status = ""
    fd.cutheader = false
    fd.bytesperchunk = 8096
    fd.nicename = ""
    fd.i = i
    fd.c_time = 0
    fd.passed_time = 0
    fd.after_download_text = nil

    fd:parseoptions(options)
    fd:ncp_special_checks()
    fd:LoadSprite()
    fd:StartDownload()
    AddDrawCallback(function ()
    	fd:DrawProgress()
    end)
    AddUnloadCallback(function ()
    	fd:Cleanup()
    end)
end)

function FancyDownload:ncp_special_checks()
	CreateDirectory(SPRITE_PATH.."\\S1mple")
	CreateDirectory(SPRITE_PATH.."\\S1mple\\Downloader")
end

function FancyDownload:parseoptions(options)
	for _,v in pairs(options) do
		if v.key == "bps" then
			self.bytesperchunk = v.value
		elseif v.key == "nicename" then
			self.nicename = v.value
		elseif v.key == "afterdltext" then
			self.after_download_text = v.value
		end
	end
end

function FancyDownload:StartDownload()
	self:GetFileSize()
	self.download_tcp = self.lua_socket.connect(self.server,self.port)
	local requeststring = "GET "..self.server_path
	local first = true
	for i,v in pairs(self.data)do
		requeststring = requeststring..(first and "?" or "&")..i.."="..v
		first = false
	end
	requeststring = requeststring.. " HTTP/1.0\r\nHost: "..self.server.."\r\n\r\n"
	self.download_tcp:send(requeststring)
	AddTickCallback(function ()
		self:Tick()
	end)
end

function FancyDownload:Tick()
	if self.status == "timeout" or self.status == "closed" then
		self:WriteToFile(self.response)
		self.status = "end"
		self:Cleanup()
	elseif self.status ~= "end" then
		s,status, partial = self.download_tcp:receive(self.bytesperchunk)
		self.status = status
		self.response = self.response..(s or partial)

		local headerend = string.find(self.response, "\r\n\r\n")
		if (headerend and not self.cutheader) then
			self.response = self.response:sub(headerend+4)
			self.cutheader = true
		end
		self.progress = self.response:len()/self.file_size*100
		if(math.floor(os.clock()) > self.c_time)then
			self.passed_time = self.passed_time + 1
		end
	end
end

function FancyDownload:GetFileSize()
	local connection_tcp = self.lua_socket.connect(self.server,self.port)
	local requeststring = "HEAD "..self.server_path
	local first = true
	for i,v in pairs(self.data)do
		requeststring = requeststring..(first and "?" or "&")..i.."="..v
		first = false
	end
	requeststring = requeststring.. " HTTP/1.0\r\nHost: "..self.server.."\r\n\r\n"
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
	local snip_1 = string.find(response, "Length:")+8
	response = response:sub(snip_1)
	local snip_2 = string.find(response, "\n")-2
	response = response:sub(0,snip_2)
	self.file_size = tonumber(response)
end

function FancyDownload:DrawProgress()
	if self.ncp then return end

	--Background
	self.sprite:DrawEx(Rect(0,10,417,25), D3DXVECTOR3(0,0,0), D3DXVECTOR3(self.pos_x,self.pos_y,0), 255)
	--Foreground
	self.sprite:DrawEx(Rect(0,0,self.progress*4.17,10), D3DXVECTOR3(0,0,0), D3DXVECTOR3(self.pos_x+3,self.pos_y+2,0), 255)
	if self.status == "end" then
		if self.after_download_text then
			DrawTextA(self.after_download_text,12, self.pos_x+3,self.pos_y-12)
		else
			DrawTextA((self.nicename or self.localpath).. " downloaded",12, self.pos_x+3,self.pos_y-12)
		end
	else
		DrawTextA((self.nicename or self.localpath).." Speed: "..math.floor(self.response:len()/self.passed_time).." bytes/sec",12, self.pos_x+3,self.pos_y-12)
	end
end

function FancyDownload:LoadSprite()
	if self.ncp then return end
	self.sprite = GetSprite("S1mple\\Downloader\\Sprite.png")
end

function FancyDownload:Cleanup()
	if not self.ncp and self.sprite then
		self.sprite:Release()
	end
end

function FancyDownload:WriteToFile(text)
	local file = io.open(self.localpath, "wb")
	file:write(tostring(text))
	file:close()
end

function TCPGetRequest(server, path, data, port)
	local start_t = os.clock()
	local port = port or 80
	local data = data or {}
	local lua_socket = require("socket")
	local connection_tcp = lua_socket.connect(server,port)
	local requeststring = "GET "..path
	local first = true

	for i,v in pairs(data) do
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

function UpdateMe(base_url, version_uri, local_version, file_uri, save_path, port, version_data, file_data, options)
	--Check if update exists
	local r = TCPGetRequest(base_url, version_uri, version_data, port)
	if not r or not tonumber(r) then
		print("[FancyDownloader] There was an error checking the version file")
		return
	end

	if tonumber(r) > local_version then
		AddDownload(base_url, file_uri, save_path, port, file_data, options)
	else
		print("[FancyDownloader] No update found")
	end
end



---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

function DownloadHpred()
	print("Downloading HPrediction, please don't reload script")
	DownloadFile("https://raw.githubusercontent.com/Jaikor/BoL-1/master/HTTF/Common/HPrediction.lua", LIB_PATH.."HPrediction.lua", function() 
		print("Finished downloading HPrediction, please reload script !")
		DelayAction(function() require("HPrediction") end, 1)
	end)
end


function OnLoad()
	 UpdateMe("s1mplescripts.de", "/Jaikor/BoL/Versions/Orianna.version", Version, "/Jaikor/BoL/Scripts/HTTFOrianna.lua", SCRIPT_PATH.."HTTFOrianna.lua", 80, {}, {}, {{key = "HTTF Orianna", value = "HTTF Orianna"}, {key = "Download Finished.", value = "Please reload me F9x2"}})
  require 'HPrediction'
	if not FileExist(LIB_PATH .. "/HPrediction.lua") then
		DownloadHpred()
	end
  
  local H = HTTF_Orianna()
  
end

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

function HTTF_Orianna:__init()
  self:Variables()
  self:Menu()
  
  DelayAction(function() self:Orbwalk() end, 1)
  AddTickCallback(function() self:Tick() end)
  AddDrawCallback(function() self:Draw() end)
  AddAnimationCallback(function(unit, animation) self:Animation(unit, animation, hash) end)
  AddProcessSpellCallback(function(unit, spell) self:ProcessSpell(unit, spell) end)
  AddSendPacketCallback(function(p) self:OnSendPacket(p) end)
end

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

function HTTF_Orianna:Variables()

  self.HPred = HPrediction()
  self.HP_Q = HPSkillshot({type = "DelayLine", delay = 0, range = 825, speed = 1200, width = 160})
  
  self.Ball = myHero
  self.IsRecall = false
  self.LastFarmQ = os.clock()
  self.LastFarmE = os.clock()
  self.RebornLoaded, self.RevampedLoaded, self.MMALoaded, self.SxOrbLoaded, self.SOWLoaded = false, false, false, false, false
  
  if myHero:GetSpellData(SUMMONER_1).name:find("summonerdot") then
    self.Ignite = SUMMONER_1
  elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerdot") then
    self.Ignite = SUMMONER_2
  end
  
  if myHero:GetSpellData(SUMMONER_1).name:find("smite") then
    self.Smite = SUMMONER_1
  elseif myHero:GetSpellData(SUMMONER_2).name:find("smite") then
    self.Smite = SUMMONER_2
  end
  
  self.Q = {range = 825, radius = 175, speed = 1200, ready}
  self.W = {range = 1250, radius = 225, ready}
  self.E = {range = 1250, speed = 1800, width = 80, ready}
  self.R = {range = 1250, radius = 410, ready}
  self.I = {range = 600, ready}
  self.S = {range = 560, ready}
  
  self.AutoQEQW = {1, 3, 1, 2, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3}
  self.AutoEQQW = {3, 1, 1, 2, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3}
  
  self.QTargetRange = self.Q.range+self.Q.radius
  self.ETargetRange = self.E.range
  
  self.QMinionRange = self.Q.range+self.Q.radius
  self.QJunglemobRange = self.Q.range+self.Q.radius
  
  local S5SR = false
  local TT = false
  
  if GetGame().map.index == 15 then
    S5SR = true
  elseif GetGame().map.index == 4 then
    TT = true
  end
  
  if S5SR then
    self.FocusJungleNames =
    {
    "SRU_Baron12.1.1",
    "SRU_Blue1.1.1",
    "SRU_Blue7.1.1",
    "Sru_Crab15.1.1",
    "Sru_Crab16.1.1",
    "SRU_Dragon6.1.1",
    "SRU_Gromp13.1.1",
    "SRU_Gromp14.1.1",
    "SRU_Krug5.1.2",
    "SRU_Krug11.1.2",
    "SRU_Murkwolf2.1.1",
    "SRU_Murkwolf8.1.1",
    "SRU_Razorbeak3.1.1",
    "SRU_Razorbeak9.1.1",
    "SRU_Red4.1.1",
    "SRU_Red10.1.1",
    "SRU_RiftHerald17.1.1"
    }
    self.JungleMobNames =
    {
    "SRU_BlueMini1.1.2",
    "SRU_BlueMini7.1.2",
    "SRU_BlueMini21.1.3",
    "SRU_BlueMini27.1.3",
    "SRU_KrugMini5.1.1",
    "SRU_KrugMini11.1.1",
    "SRU_MurkwolfMini2.1.2",
    "SRU_MurkwolfMini2.1.3",
    "SRU_MurkwolfMini8.1.2",
    "SRU_MurkwolfMini8.1.3",
    "SRU_RazorbeakMini3.1.2",
    "SRU_RazorbeakMini3.1.3",
    "SRU_RazorbeakMini3.1.4",
    "SRU_RazorbeakMini9.1.2",
    "SRU_RazorbeakMini9.1.3",
    "SRU_RazorbeakMini9.1.4",
    "SRU_RedMini4.1.2",
    "SRU_RedMini4.1.3",
    "SRU_RedMini10.1.2",
    "SRU_RedMini10.1.3"
    }
  elseif TT then
    self.FocusJungleNames =
    {
    "TT_NWraith1.1.1",
    "TT_NGolem2.1.1",
    "TT_NWolf3.1.1",
    "TT_NWraith4.1.1",
    "TT_NGolem5.1.1",
    "TT_NWolf6.1.1",
    "TT_Spiderboss8.1.1"
    }   
    self.JungleMobNames =
    {
    "TT_NWraith21.1.2",
    "TT_NWraith21.1.3",
    "TT_NGolem22.1.2",
    "TT_NWolf23.1.2",
    "TT_NWolf23.1.3",
    "TT_NWraith24.1.2",
    "TT_NWraith24.1.3",
    "TT_NGolem25.1.1",
    "TT_NWolf26.1.2",
    "TT_NWolf26.1.3"
    }
  else
    self.FocusJungleNames =
    {
    }   
    self.JungleMobNames =
    {
    }
  end
  
  self.QTS = TargetSelector(TARGET_LESS_CAST, self.QTargetRange, DAMAGE_MAGIC, false)
  self.ETS = TargetSelector(TARGET_LESS_CAST, self.ETargetRange, DAMAGE_MAGIC, false)
  self.STS = TargetSelector(TARGET_LOW_HP, self.S.range)
  
  self.EnemyHeroes = GetEnemyHeroes()
  self.AllyHeroes = GetAllyHeroes()
  table.insert(self.AllyHeroes, myHero)
  self.EnemyMinions = minionManager(MINION_ENEMY, self.QMinionRange, myHero, MINION_SORT_MAXHEALTH_DEC)
  self.JungleMobs = minionManager(MINION_JUNGLE, self.QJunglemobRange, myHero, MINION_SORT_MAXHEALTH_DEC)
  
end

---------------------------------------------------------------------------------

function HTTF_Orianna:Menu()

  self.Menu = scriptConfig("HTTF Orianna", "HTTF Orianna")
  
  self.Menu:addSubMenu("HitChance", "HitChance")
  
    self.Menu.HitChance:addSubMenu("Combo", "Combo")
      self.Menu.HitChance.Combo:addParam("Q", "Q HitChacne (Default value = 1.2)", SCRIPT_PARAM_SLICE, 1.2, 1, 3, 2)
      
    self.Menu.HitChance:addSubMenu("Harass", "Harass")
      self.Menu.HitChance.Harass:addParam("Q", "Q HitChacne (Default value = 2.6)", SCRIPT_PARAM_SLICE, 2.6, 2, 3, 2)
      
  self.Menu:addSubMenu("Combo", "Combo")
    self.Menu.Combo:addParam("On", "Combo", SCRIPT_PARAM_ONKEYDOWN, false, 32)
    self.Menu.Combo:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
    self.Menu.Combo:addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
    self.Menu.Combo:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
    self.Menu.Combo:addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
    self.Menu.Combo:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
    self.Menu.Combo:addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
    self.Menu.Combo:addParam("E2", "Use E if Mana Percent > x% (10)", SCRIPT_PARAM_SLICE, 10, 0, 100, 0)
    self.Menu.Combo:addParam("E3", "and Use E if Enemy is near my Hero (true)", SCRIPT_PARAM_ONOFF, true)
    self.Menu.Combo:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
    self.Menu.Combo:addParam("R", "Use Smart R (Single Target)", SCRIPT_PARAM_ONOFF, true)
    self.Menu.Combo:addParam("R2", "Use R (Multiple Target)", SCRIPT_PARAM_ONOFF, true)
    self.Menu.Combo:addParam("RMin", "and Use R Min Count (3)", SCRIPT_PARAM_SLICE, 3, 2, 5, 0)
    --[[self.Menu.Combo:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
    self.Menu.Combo:addParam("Item", "Use Items", SCRIPT_PARAM_ONOFF, true)
    self.Menu.Combo:addParam("BRK", "Use BRK if my own HP < x% (30)", SCRIPT_PARAM_SLICE, 30, 0, 100, 0)]]
    
  self.Menu:addSubMenu("Harass", "Harass")
    self.Menu.Harass:addParam("On", "Harass", SCRIPT_PARAM_ONKEYDOWN, false, GetKey('C'))
    self.Menu.Harass:addParam("On2", "Harass Toggle", SCRIPT_PARAM_ONKEYTOGGLE, false, GetKey('H'))
    self.Menu.Harass:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
    self.Menu.Harass:addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
    self.Menu.Harass:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
    self.Menu.Harass:addParam("W", "Use W", SCRIPT_PARAM_ONOFF, false)
    self.Menu.Harass:addParam("W2", "Use W if Mana Percent > x% (70)", SCRIPT_PARAM_SLICE, 70, 0, 100, 0)
    self.Menu.Harass:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
    self.Menu.Harass:addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
    self.Menu.Harass:addParam("E2", "Use E if Mana Percent > x% (60)", SCRIPT_PARAM_SLICE, 60, 0, 100, 0)
    self.Menu.Harass:addParam("E3", "and Use E if Enemy is near my Hero (true)", SCRIPT_PARAM_ONOFF, true)
    
  self.Menu:addSubMenu("Clear", "Clear")
  
    self.Menu.Clear:addSubMenu("Lane Clear", "Farm")
      self.Menu.Clear.Farm:addParam("On", "Lane Clear", SCRIPT_PARAM_ONKEYDOWN, false, GetKey('V'))
      self.Menu.Clear.Farm:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
      self.Menu.Clear.Farm:addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
      self.Menu.Clear.Farm:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
      self.Menu.Clear.Farm:addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
      self.Menu.Clear.Farm:addParam("W2", "Use W if Mana Percent > x% (40)", SCRIPT_PARAM_SLICE, 40, 0, 100, 0)
      self.Menu.Clear.Farm:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
      self.Menu.Clear.Farm:addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
        
    self.Menu.Clear:addSubMenu("Jungle Clear", "JFarm")
      self.Menu.Clear.JFarm:addParam("On", "Jungle Clear", SCRIPT_PARAM_ONKEYDOWN, false, GetKey('V'))
      self.Menu.Clear.JFarm:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
      self.Menu.Clear.JFarm:addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
      self.Menu.Clear.JFarm:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
      self.Menu.Clear.JFarm:addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
      self.Menu.Clear.JFarm:addParam("W2", "Use W if Mana Percent > x% (0)", SCRIPT_PARAM_SLICE, 0, 0, 100, 0)
      self.Menu.Clear.JFarm:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
      self.Menu.Clear.JFarm:addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
      self.Menu.Clear.JFarm:addParam("E2", "Use E if Mana Percent > x% (10)", SCRIPT_PARAM_SLICE, 10, 0, 100, 0)
      
  self.Menu:addSubMenu("LastHit", "LastHit")
    self.Menu.LastHit:addParam("On", "LastHit", SCRIPT_PARAM_ONKEYDOWN, false, GetKey('X'))
    self.Menu.LastHit:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
    self.Menu.LastHit:addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
    self.Menu.LastHit:addParam("Q2", "Use Q if Mana Percent > x% (80)", SCRIPT_PARAM_SLICE, 80, 0, 100, 0)
    self.Menu.LastHit:addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
    self.Menu.LastHit:addParam("W2", "Use W if Mana Percent > x% (90)", SCRIPT_PARAM_SLICE, 90, 0, 100, 0)
    self.Menu.LastHit:addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
    self.Menu.LastHit:addParam("E2", "Use E if Mana Percent > x% (90)", SCRIPT_PARAM_SLICE, 90, 0, 100, 0)
    
  self.Menu:addSubMenu("Jungle Steal", "JSteal")
    self.Menu.JSteal:addParam("On", "Jungle Steal", SCRIPT_PARAM_ONKEYDOWN, false, GetKey('X'))
    self.Menu.JSteal:addParam("On2", "Jungle Steal Toggle", SCRIPT_PARAM_ONKEYTOGGLE, true, GetKey('N'))
    self.Menu.JSteal:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
    self.Menu.JSteal:addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
    self.Menu.JSteal:addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
    self.Menu.JSteal:addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
    if self.Smite ~= nil then
    self.Menu.JSteal:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
    self.Menu.JSteal:addParam("S", "Use Smite", SCRIPT_PARAM_ONOFF, true)
    end
    self.Menu.JSteal:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
    self.Menu.JSteal:addParam("Always", "Always Use Q, W, E and Smite\n(Baron & Dragon)", SCRIPT_PARAM_ONOFF, true)
    
  self.Menu:addSubMenu("KillSteal", "KillSteal")
    self.Menu.KillSteal:addParam("On", "KillSteal", SCRIPT_PARAM_ONOFF, true)
    self.Menu.KillSteal:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
    self.Menu.KillSteal:addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
    self.Menu.KillSteal:addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
    self.Menu.KillSteal:addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
    self.Menu.KillSteal:addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
    if self.Ignite ~= nil then
    self.Menu.KillSteal:addParam("Blank3", "", SCRIPT_PARAM_INFO, "")
    self.Menu.KillSteal:addParam("I", "Use Ignite", SCRIPT_PARAM_ONOFF, true)
    end
    if self.Smite ~= nil then
    self.Menu.KillSteal:addParam("Blank4", "", SCRIPT_PARAM_INFO, "")
    self.Menu.KillSteal:addParam("S", "Use Stalker's Blade", SCRIPT_PARAM_ONOFF, true)
    end
    
  self.Menu:addSubMenu("Auto", "Auto")
    self.Menu.Auto:addParam("On", "Auto", SCRIPT_PARAM_ONOFF, true)
    self.Menu.Auto:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
    self.Menu.Auto:addParam("W", "Use W (Multiple Target)", SCRIPT_PARAM_ONOFF, true)
    self.Menu.Auto:addParam("WMin", "and Use W Min Count (2)", SCRIPT_PARAM_SLICE, 2, 2, 5, 0)
    self.Menu.Auto:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
    --self.Menu.Auto:addParam("E", "Use E to defend from targeted spells", SCRIPT_PARAM_ONOFF, true)
    --self.Menu.Auto:addParam("E2", "Use E if Mana Percent > x% (80)", SCRIPT_PARAM_SLICE, 80, 0, 100, 0)
    --self.Menu.Auto:addParam("E3", "or Use E if Health Percent < x% (40)", SCRIPT_PARAM_SLICE, 40, 0, 100, 0)
    --self.Menu.Auto:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
    self.Menu.Auto:addParam("R", "Use R (Multiple Target)", SCRIPT_PARAM_ONOFF, true)
    self.Menu.Auto:addParam("RMin", "and Use R Min Count (4)", SCRIPT_PARAM_SLICE, 4, 2, 5, 0)
    
  self.Menu:addSubMenu("Flee", "Flee")
    self.Menu.Flee:addParam("On", "Flee", SCRIPT_PARAM_ONKEYDOWN, false, GetKey('G'))
    
  self.Menu:addSubMenu("Misc", "Misc")
    self.Menu.Misc:addParam("LESSCASTW", "Cast W for LESS CAST Target only", SCRIPT_PARAM_ONOFF, false)
    if VIP_USER then
    self.Menu.Misc:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
    self.Menu.Misc:addParam("BlockR", "Block R if HitChance < 2", SCRIPT_PARAM_ONOFF, true)
    end
    
  self.Menu:addSubMenu("Draw", "Draw")
  
    self.Menu.Draw:addSubMenu("Draw Target", "Target")
      self.Menu.Draw.Target:addParam("Q", "Draw Q Target", SCRIPT_PARAM_ONOFF, true)
      self.Menu.Draw.Target:addParam("E", "Draw E Target", SCRIPT_PARAM_ONOFF, false)
      
    self.Menu.Draw:addSubMenu("Draw Predicted Position & Line", "PP")
      self.Menu.Draw.PP:addParam("Q", "Draw Q Pos", SCRIPT_PARAM_ONOFF, true)
      self.Menu.Draw.PP:addParam("E", "Draw E Line", SCRIPT_PARAM_ONOFF, true)
      self.Menu.Draw.PP:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
      self.Menu.Draw.PP:addParam("Line", "Draw Line to Pos", SCRIPT_PARAM_ONOFF, true)
      self.Menu.Draw:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
        
    self.Menu.Draw:addParam("On", "Draw", SCRIPT_PARAM_ONOFF, true)
    self.Menu.Draw:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
    self.Menu.Draw:addParam("Lfc", "Draw Lag free circles", SCRIPT_PARAM_ONOFF, false)
    self.Menu.Draw:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
    self.Menu.Draw:addParam("Ball", "Draw Ball", SCRIPT_PARAM_ONOFF, true)
    self.Menu.Draw:addParam("AA", "Draw Attack range", SCRIPT_PARAM_ONOFF, false)
    self.Menu.Draw:addParam("Q", "Draw Q range", SCRIPT_PARAM_ONOFF, true)
    self.Menu.Draw:addParam("W", "Draw W radius", SCRIPT_PARAM_ONOFF, true)
    self.Menu.Draw:addParam("R", "Draw R radius", SCRIPT_PARAM_ONOFF, true)
    if self.Ignite ~= nil then
    self.Menu.Draw:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
    self.Menu.Draw:addParam("I", "Draw Ignite range", SCRIPT_PARAM_ONOFF, false)
    end
    if self.Smite ~= nil then
    self.Menu.Draw:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
    self.Menu.Draw:addParam("S", "Draw Smite range", SCRIPT_PARAM_ONOFF, true)
    end
    self.Menu.Draw:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
    self.Menu.Draw:addParam("Path", "Draw Move Path", SCRIPT_PARAM_ONOFF, false)
    self.Menu.Draw:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
    self.Menu.Draw:addParam("Hitchance", "Draw Hitchance", SCRIPT_PARAM_ONOFF, true)
    
  self.Menu.Combo.On = false
  self.Menu.Clear.Farm.On = false
  self.Menu.Clear.JFarm.On = false
  self.Menu.Harass.On = false
  self.Menu.Harass.On2 = false
  self.Menu.LastHit.On = false
  self.Menu.JSteal.On = false
  self.Menu.JSteal.On2 = false
  self.Menu.Flee.On = false
  
end

---------------------------------------------------------------------------------

function HTTF_Orianna:Orbwalk()

  if _G.AutoCarry then
  
    if _G.Reborn_Initialised then
      self.RebornLoaded = true
      self:ScriptMsg("Found SAC: Reborn.")
    else
      self.RevampedLoaded = true
      self:ScriptMsg("Found SAC: Reborn.")
    end
    
  elseif _G.Reborn_Loaded then
    DelayAction(function() self:Orbwalk() end, 1)
  elseif _G.MMA_IsLoaded then
    self.MMALoaded = true
    self:ScriptMsg("Found MMA.")
  elseif FileExist(LIB_PATH .. "SxOrbWalk.lua") then
  
    require 'SxOrbWalk'
    
    self.SxOrbMenu = scriptConfig("SxOrb", "SxOrb")
    
    self.SxOrb = SxOrbWalk()
    self.SxOrb:LoadToMenu(self.SxOrbMenu)
    
    self.SxOrbLoaded = true
    self:ScriptMsg("Found SxOrb.")
  elseif FileExist(LIB_PATH .. "SOW.lua") then
  
    require 'SOW'
    require 'VPrediction'
    
    self.VP = VPrediction()
    self.SOWVP = SOW(self.VP)
    
    self.Menu:addSubMenu("Orbwalk (SOW)", "Orbwalk")
      self.Menu.Orbwalk:addParam("Info", "SOW", SCRIPT_PARAM_INFO, "")
      self.Menu.Orbwalk:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
      self.SOWVP:LoadToMenu(self.Menu.Orbwalk)
      
    self.SOWLoaded = true
    self:ScriptMsg("Found SOW.")
  else
    self:ScriptMsg("Orbwalk not founded.")
  end
  
end

---------------------------------------------------------------------------------

function HTTF_Orianna:OrbwalkCanAttack()

  if self.RebornLoaded then
    return _G.AutoCarry.Orbwalker:CanShoot()
  elseif self.MMALoaded then
    return _G.MMA_AttackAvailable
  elseif self.SxOrbLoaded then
    return self.SxOrb:CanAttack()
  elseif self.SOWLoaded then
    return self.SOWVP:CanAttack()
  end
  
  return false
end

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

function HTTF_Orianna:Tick()

  if myHero.dead then
  
    if self.Ball ~= myHero then
      self.Ball = myHero
    end
    
    return
  end
  
  self:Checks()
  self:Targets()
  
  if self.Menu.KillSteal.On then
    self:KillSteal()
  end
  
  if self.Menu.Auto.On then
    self:Auto()
  end
  
  if self.Menu.Combo.On then
    self:Combo()
  end
  
  if self.Menu.Harass.On or (self.Menu.Harass.On2 and not self.IsRecall) then
    self:Harass()
  end
  
  if self.Menu.Clear.Farm.On then
    self:Farm()
  end
  
  if self.Menu.Clear.JFarm.On then
    self:JFarm()
  end
  
  if self.Menu.LastHit.On then
    self:LastHit()
  end
  
  if self.Menu.JSteal.On or self.Menu.JSteal.On2 then
    self:JSteal()
  end
  
  if self.Menu.JSteal.Always then
    self:JstealAlways()
  end
  
  if self.Menu.Flee.On then
    self:Flee()
  end
  
  --[[if self.Menu.Misc.AutoLevel then
    self:AutoLevel()
  end]]
  
end

---------------------------------------------------------------------------------

function HTTF_Orianna:Checks()

  self.Q.ready = myHero:CanUseSpell(_Q) == READY
  self.W.ready = myHero:CanUseSpell(_W) == READY
  self.E.ready = myHero:CanUseSpell(_E) == READY
  self.R.ready = myHero:CanUseSpell(_R) == READY
  self.I.ready = self.Ignite ~= nil and myHero:CanUseSpell(self.Ignite) == READY
  self.S.ready = self.Smite ~= nil and myHero:CanUseSpell(self.Smite) == READY
  
  self.Q.level = myHero:GetSpellData(_Q).level
  self.W.level = myHero:GetSpellData(_W).level
  self.E.level = myHero:GetSpellData(_E).level
  self.R.level = myHero:GetSpellData(_R).level
  
  self.EnemyMinions:update()
  self.JungleMobs:update()
  
end

---------------------------------------------------------------------------------

function HTTF_Orianna:Targets()

  self.QTS:update()
  self.QTarget = self.QTS.target
  self.ETS:update()
  self.ETarget = self.ETS.target
  self.STS:update()
  self.STarget = self.STS.target
  
end

---------------------------------------------------------------------------------

function HTTF_Orianna:Combo()

  local ComboQ = self.Menu.Combo.Q
  local ComboW = self.Menu.Combo.W
  local ComboE = self.Menu.Combo.E
  local ComboE2 = self.Menu.Combo.E2
  local ComboR = self.Menu.Combo.R
  local ComboR2 = self.Menu.Combo.R2
  --local ComboItem = self.Menu.Combo.Item
    
  if ComboW and self.W.ready then
  
    if not self.Menu.Misc.LESSCASTW then
    
      for i, enemy in ipairs(self.EnemyHeroes) do
      
        if self:ValidTargetNear(enemy, self.W.radius+100, self.Ball) then
          self:CastW(enemy, "Combo")
        end
        
      end
      
    elseif self.ETarget ~= nil and self:ValidTargetNear(self.ETarget, self.W.radius+100, self.Ball) then
      self:CastW(self.ETarget, "Combo")
    end
    
  end
  
  if (ComboR or ComboR2) and self.R.ready then
  
    for i, enemy in ipairs(self.EnemyHeroes) do
    
      if self:ValidTargetNear(enemy, self.R.radius+300, self.Ball) then
      
        if ComboR then
        
          local QenemyDmg = ComboQ and GetDistance(enemy, myHero) <= self.Q.range+self.Q.radius and (self.Q.ready and 2*self:GetDmg("Q", enemy) or self:GetDmg("Q", enemy)) or 0
          local WenemyDmg = ComboW and self.W.ready and self:GetDmg("W", enemy) or 0
          local RenemyDmg = self:GetDmg("R", enemy)
          
          if QenemyDmg+WenemyDmg+RenemyDmg >= enemy.health then
            self:CastR(enemy)
          end
          
        end
        
        if ComboR2 then
          self:CastR(enemy, "ComboM")
        end
        
      end
      
    end
    
  end
  
  if self.QTarget ~= nil and ComboQ and self.Q.ready then
    self.QHitChance = nil
    
    if ValidTarget(self.QTarget, self.Q.range+self.Q.radius) then
      self:CastQ(self.QTarget, "Combo")
    end
    
    if ComboE and self.E.ready and ComboE2 <= self:ManaPercent() and (self.QHitChance == nil or self.QHitChance < self.Menu.HitChance.Combo.Q) then
    
      local Time_EQ = math.huge
      local Target_E = nil
      
      for i, ally in ipairs(self.AllyHeroes) do
      
        local QPos, QHitChance = self.HPred:GetPredict(self.HPred.Presets["Orianna"]["Q"], self.QTarget, ally)
        
        if not ally == self.Ball and QHitChance > 0 and Time_EQ > GetDistance(ally, self.Ball)/1800+GetDistance(self.QTarget, ally)/1200 then
          Time_EQ = GetDistance(ally, self.Ball)/1800+GetDistance(self.QTarget, ally)/1200
          Target_E = ally
        end
        
      end
      
      if Target_E and GetDistance(self.QTarget, self.Ball)/1200 > .125+Time_EQ then
        self:GiveE(Target_E)
        return
      end
      
    end
    
    if self.QHitChance == nil or self.QHitChance == 0 then
    
      for i, enemy in ipairs(self.EnemyHeroes) do
      
        if ValidTarget(enemy, self.Q.range+self.Q.radius) then
          self:CastQ(enemy, "Combo")
        end
        
      end
      
    end
  
  end
  
  if ComboE and (ComboR or ComboR2) and self.E.ready and self.R.ready and ComboE2 <= self:ManaPercent() then
  
    for i, ally in ipairs(self.AllyHeroes) do
    
      if not ally == self.Ball and ValidTarget(ally, self.E.range) then
      
        for j, enemy in ipairs(self.EnemyHeroes) do
        
          if self:ValidTargetNear(enemy, self.R.radius+300, self.Ball) then
          
            if ComboR then
            
              local RPos, RHitChance = self.HPred:GetPredict(self.HPred.Presets["Orianna"]["R"], enemy, ally)
              local QenemyDmg = ComboQ and GetDistance(enemy, myHero) <= self.Q.range+self.Q.radius and (self.Q.ready and 2*self:GetDmg("Q", enemy) or self:GetDmg("Q", enemy)) or 0
              local WenemyDmg = ComboW and self.W.ready and self:GetDmg("W", enemy) or 0
              local RenemyDmg = self:GetDmg("R", enemy)
              
              if RHitChance == 3 and QenemyDmg+WenemyDmg+RenemyDmg >= enemy.health then
                self:GiveE(ally)
                return
              end
              
            end
            
            if ComboR2 then
            
              local RPos, RHitChance, RNoH = self.HPred:GetPredict(self.HPred.Presets["Orianna"]["R"], enemy, ally, true)
              
              if RNoH >= self.Menu.Combo.RMin then
                self:GiveE(ally)
                return
              end
              
            end
             
          end
          
        end
        
      end
      
    end
    
  end
  
  if self.ETarget ~= nil and ComboE and self.E.ready and ComboE2 <= self:ManaPercent() then
  
    local ComboE3 = self.Menu.Combo.E3
    
    if not ComboE3 then
    
      if ValidTarget(self.ETarget, self.E.range) then
        self:b(self.ETarget)
      end
      
    else
    
      if self.QTarget ~= nil and ComboQ and ComboE2 <= self:ManaPercent() and ValidTarget(self.QTarget, self.Q.range) then
      
        local QPos, QHitChance = self.HPred:GetPredict(self.HPred.Presets["Orianna"]["Q"], self.QTarget, myHero)
        
        if QHitChance >= self.Menu.HitChance.Combo.Q then
          self:CastE(self.ETarget)
        end
        
      end
      
      for i, enemy in ipairs(self.EnemyHeroes) do
      
        if ValidTarget(enemy, self:TrueRange(enemy)) then
          self:CastE(enemy)
        end
        
      end
      
    end
    
  end
  
  --[[if STarget ~= nil and ComboItem then
  
    local ComboBRK = self.Menu.Combo.BRK
    local BCSTargetDmg = self:GetDmg("BC", STarget)
    local BRKSTargetDmg = self:GetDmg("BRK", STarget)
    local SBSTargetDmg = self:GetDmg("STALKER", STarget)
    
    if self.Items["Stalker"].ready and ValidTarget(STarget, self.S.range) then
      self:CastS(STarget)
    end
    
    if ComboBRK >= self:HealthPercent(myHero) then
    
      if self.Items["BC"].ready and ValidTarget(STarget, self.Items["BC"].range) then
        self:CastBC(STarget)
      elseif self.Items["BRK"].ready and ValidTarget(STarget, self.Items["BRK"].range) then
        self:CastBRK(STarget)
      end
      
    end
    
  end]]
  
end

---------------------------------------------------------------------------------

function HTTF_Orianna:Harass()

  local HarassQ = self.Menu.Harass.Q
  local HarassW = self.Menu.Harass.W
  local HarassW2 = self.Menu.Harass.W2
  local HarassE = self.Menu.Harass.E
  local HarassE2 = self.Menu.Harass.E2
  
  if ComboW and self.W.ready then
  
    if not self.Menu.Misc.LESSCASTW then
    
      for i, enemy in ipairs(self.EnemyHeroes) do
      
        if self:ValidTargetNear(enemy, self.W.radius+100, self.Ball) then
          self:CastW(enemy, "Combo")
        end
        
      end
      
    elseif self.ETarget ~= nil and self:ValidTargetNear(self.ETarget, self.W.radius+100, self.Ball) then
      self:CastW(self.ETarget, "Combo")
    end
    
  end
  
  if HarassW and self.W.ready and HarassW2 <= self:ManaPercent() then
  
    if not self.Menu.Misc.LESSCASTW then
    
      for i, enemy in ipairs(self.EnemyHeroes) do
      
        if self:ValidTargetNear(enemy, self.W.radius+100, self.Ball) then
          self:CastW(enemy, "Harass")
        end
        
      end
      
    elseif self.ETarget ~= nil and self:ValidTargetNear(self.ETarget, self.W.radius+100, self.Ball) then
      self:CastW(self.ETarget, "Harass")
    end
    
  end
  
  if self.QTarget ~= nil and HarassQ and self.Q.ready then
    self.QHitChance = nil
    
    if ValidTarget(self.QTarget, self.Q.range+self.Q.radius) then
      self:CastQ(self.QTarget, "Harass")
    end
    
    if HarassE and self.E.ready and HarassE2 <= self:ManaPercent() and (self.QHitChance == nil or self.QHitChance < self.Menu.HitChance.Harass.Q) then
    
      local Time_EQ = math.huge
      local Target_E = nil
      
      for i, ally in ipairs(self.AllyHeroes) do
      
        local QPos, QHitChance = self.HPred:GetPredict(self.HPred.Presets["Orianna"]["Q"], self.QTarget, ally)
        
        if not ally == self.Ball and QHitChance > 0 and Time_EQ > GetDistance(ally, self.Ball)/1800+GetDistance(self.QTarget, ally)/1200 then
          Time_EQ = GetDistance(ally, self.Ball)/1800+GetDistance(self.QTarget, ally)/1200
          Target_E = ally
        end
        
      end
      
      if Target_E and GetDistance(self.QTarget, self.Ball)/1200 > .125+Time_EQ then
        self:GiveE(Target_E)
        return
      end
      
    end
    
    if self.QHitChance == nil or self.QHitChance == 0 then
    
      for i, enemy in ipairs(self.EnemyHeroes) do
      
        if ValidTarget(enemy, self.Q.range+self.Q.radius) then
          self:CastQ(enemy, "Harass")
        end
        
      end
      
    end
    
  end
  
  if self.ETarget ~= nil and HarassE and self.E.ready and HarassE2 <= self:ManaPercent() then
  
    local HarassE3 = self.Menu.Harass.E3
    
    if not HarassE3 then
    
      if ValidTarget(self.ETarget, self.E.range) then
        self:CastE(self.ETarget)
      end
      
    else
    
      if self.QTarget ~= nil and HarassQ and HarassE2 <= self:ManaPercent() and ValidTarget(self.QTarget, self.Q.range) then
      
        local QPos, QHitChance = self.HPred:GetPredict(self.HPred.Presets["Orianna"]["Q"], self.QTarget, myHero)
        
        if QHitChance >= self.Menu.HitChance.Harass.Q then
          self:CastE(self.ETarget)
        end
        
      end
      
      for i, enemy in ipairs(self.EnemyHeroes) do
      
        if ValidTarget(enemy, self:TrueRange(enemy)) then
          self:CastE(enemy)
        end
        
      end
      
    end
    
  end
  
end

---------------------------------------------------------------------------------

function HTTF_Orianna:Farm()

  local FarmQ = self.Menu.Clear.Farm.Q
  local FarmW = self.Menu.Clear.Farm.W
  local FarmW2 = self.Menu.Clear.Farm.W2
  local FarmE = self.Menu.Clear.Farm.E
  
  if FarmW and self.W.ready and FarmW2 <= self:ManaPercent() then
    
    for i, minion in pairs(self.EnemyMinions.objects) do
    
      local WMinionDmg = self:GetDmg("W", minion)
      
      if WMinionDmg >= minion.health and self:ValidTargetNear(minion, self.W.radius+100, self.Ball) then
        self:CastW(minion)
      end
      
    end
    
    --[[for i, minion in pairs(self.EnemyMinions.objects) do
    
      local AAMinionDmg = self:GetDmg("AA", minion)
      local WMinionDmg = self:GetDmg("W", minion)
      
      if WMinionDmg+2.5*AAMinionDmg <= minion.health and self:ValidTargetNear(minion, self.W.radius+100, self.Ball) then
        self:CastW(minion)
      end
      
    end]]
    
  end
  
  if FarmQ and self.Q.ready then
  
    if os.clock()-self.LastFarmQ >= .25 then
      self.LastFarmQ = os.clock()
      
      for i, eminion in pairs(self.EnemyMinions.objects) do
      
        local QMinionDmg = self:GetDmg("Q", eminion)
        local AAMinionDmg = self:GetDmg("AA", eminion)
        local Pos, HitChance = self.HPred:GetPredict(self.HPred.Presets['Orianna']["Q"], eminion, self.Ball)
        
        if Pos ~= nil and QMinionDmg+2.5*AAMinionDmg <= eminion.health then
        
          local QNoH = 0
          
          for j, minion in pairs(self.EnemyMinions.objects) do
          
            if GetDistance(minion, myHero) <= self.Q.range+self.Q.radius and self.HPred:SpellCollision(self.HP_Q, minion, self.Ball, Pos) then
              QNoH = QNoH+1
            end
            
          end
          
          if QNoH >= 2 and QNoH*myHero.mana/50 >= 20 then
            CastSpell(_Q, Pos.x, Pos.z)
            return
          end
          
        end
        
      end
      
    end
    
    for i, minion in pairs(self.EnemyMinions.objects) do
    
      local QMinionDmg = .7*self:GetDmg("Q", minion)
      
      if self:OrbwalkCanAttack() and QMinionDmg >= minion.health and myHero.mana >= 300 and ValidTarget(minion, self.Q.range+self.Q.radius) then
        self:CastQ(minion)
      end
      
    end
    
  end
  
  if FarmE and self.E.ready and self.Ball ~= myHero then
  
    if os.clock()-self.LastFarmE >= .25 then
      self.LastFarmE = os.clock()
      
      local ENoH = 0
      
      for i, minion in pairs(self.EnemyMinions.objects) do
      
        if ValidTarget(minion, GetDistance(self.Ball, myHero)+100) and self.HPred:SpellCollision(self.HPred.Presets['Orianna']["E"], minion, self.Ball, myHero) then
          ENoH = ENoH+1
        end
        
      end
      
      if ENoH >= 2 and ENoH*myHero.mana/60 >= 25 then
        self:GiveE(myHero)
        return
      end
      
    end
    
    for i, minion in pairs(self.EnemyMinions.objects) do
    
      local EMinionDmg = self:GetDmg("E", minion)
      
      if EMinionDmg >= minion.health and myHero.mana >= 450 and ValidTarget(minion, GetDistance(self.Ball, myHero)+100) then
        self:CastE(minion)
      end
      
    end
    
  end
  
end

---------------------------------------------------------------------------------

function HTTF_Orianna:JFarm()

  local JFarmQ = self.Menu.Clear.JFarm.Q
  local JFarmW = self.Menu.Clear.JFarm.W
  local JFarmW2 = self.Menu.Clear.JFarm.W2
  local JFarmE = self.Menu.Clear.JFarm.E
  local JFarmE2 = self.Menu.Clear.JFarm.E2
  
  if JFarmW and self.W.ready and JFarmW2 <= self:ManaPercent() then
  
    local Large = nil
    
    for i, junglemob in pairs(self.JungleMobs.objects) do
    
      local LargeJunglemob = nil
      
      for j = 1, #self.FocusJungleNames do
      
        if junglemob.name == self.FocusJungleNames[j] then
          LargeJunglemob = junglemob
          Large = true
          break
        end
        
      end
      
      if LargeJunglemob ~= nil and GetDistance(LargeJunglemob, mousePos) <= self.W.range+self.W.radius and ValidTarget(LargeJunglemob, self.W.range+self.W.radius) then
        self:CastW(LargeJunglemob, "JFarm")
      end
      
    end
    
    if Large == nil then
    
      for i, junglemob in pairs(self.JungleMobs.objects) do
      
        if ValidTarget(junglemob, self.W.range+self.W.radius) then
          self:CastW(junglemob, "JFarm")
        end
        
      end
      
    end
    
  end
  
  if JFarmQ and self.Q.ready then
  
    local Large = nil
    
    for i, junglemob in pairs(self.JungleMobs.objects) do
    
      local LargeJunglemob = nil
      
      for j = 1, #self.FocusJungleNames do
      
        if junglemob.name == self.FocusJungleNames[j] then
          LargeJunglemob = junglemob
          Large = true
          break
        end
        
      end
      
      if LargeJunglemob ~= nil and GetDistance(LargeJunglemob, mousePos) <= self.Q.range+self.Q.radius and ValidTarget(LargeJunglemob, self.Q.range+self.Q.radius) then
        self:CastQ(LargeJunglemob, "JFarm")
      end
      
    end
    
    if Large == nil then
    
      for i, junglemob in pairs(self.JungleMobs.objects) do
      
        if ValidTarget(junglemob, self.Q.range+self.Q.radius) then
          self:CastQ(junglemob, "JFarm")
        end
        
      end
      
    end
    
  end
  
  if JFarmE and self.E.ready and JFarmE2 <= self:ManaPercent() then
  
    for i, junglemob in pairs(self.JungleMobs.objects) do
    
      local LargeJunglemob = nil
      
      for j = 1, #self.FocusJungleNames do
      
        if junglemob.name == self.FocusJungleNames[j] then
          LargeJunglemob = junglemob
          break
        end
        
      end
      
      if LargeJunglemob ~= nil and GetDistance(LargeJunglemob, mousePos) <= self.E.range and ValidTarget(LargeJunglemob, GetDistance(self.Ball, myHero)+100) then
        self:CastE(LargeJunglemob)
      end
      
    end
    
    for i, junglemob in pairs(self.JungleMobs.objects) do
    
      if ValidTarget(junglemob, GetDistance(self.Ball, myHero)+100) then
        self:CastE(junglemob)
      end
      
    end
    
  end
  
end

---------------------------------------------------------------------------------

function HTTF_Orianna:LastHit()

  local LastHitQ = self.Menu.LastHit.Q
  local LastHitQ2 = self.Menu.LastHit.Q2
  local LastHitW = self.Menu.LastHit.W
  local LastHitW2 = self.Menu.LastHit.W2
  local LastHitE = self.Menu.LastHit.E
  local LastHitE2 = self.Menu.LastHit.E2
  
  if LastHitW and self.W.ready and LastHitW2 <= self:ManaPercent() then
  
    for i, minion in pairs(self.EnemyMinions.objects) do
    
      local WMinionDmg = self:GetDmg("W", minion)
      
      if WMinionDmg >= minion.health and ValidTarget(minion, self.W.range+self.W.radius) then
        self:CastW(minion)
      end
      
    end
    
  end
  
  if LastHitQ and self.Q.ready and LastHitQ2 <= self:ManaPercent() then
  
    for i, minion in pairs(self.EnemyMinions.objects) do
    
      local QMinionDmg = .7*self:GetDmg("Q", minion)
      
      if QMinionDmg >= minion.health and ValidTarget(minion, self.Q.range+self.Q.radius) then
        self:CastQ(minion)
      end
      
    end
    
  end
  
  if LastHitE and self.E.ready and LastHitE2 <= self:ManaPercent() then
  
    for i, minion in pairs(self.EnemyMinions.objects) do
    
      local EMinionDmg = self:GetDmg("E", minion)
      
      if EMinionDmg >= minion.health and ValidTarget(minion, GetDistance(self.Ball, myHero)+100) then
        self:CastE(minion)
      end
      
    end
    
  end
  
end

---------------------------------------------------------------------------------

function HTTF_Orianna:JSteal()

  local JStealQ = self.Menu.JSteal.Q
  local JStealW = self.Menu.JSteal.W
  local JStealE = self.Menu.JSteal.E
  local JStealS = self.Menu.JSteal.S
  
  if JStealS and self.S.ready then
  
    for i, junglemob in pairs(self.JungleMobs.objects) do
          
      local SJunglemobDmg = self:GetDmg("SMITE", junglemob)
      
      for j = 1, #self.FocusJungleNames do
      
        if junglemob.name == self.FocusJungleNames[j] and SJunglemobDmg >= junglemob.health and ValidTarget(junglemob, self.S.range) then
          self:CastS(junglemob)
          return
        end
        
      end
      
    end
    
  end
  
  if JStealW and self.W.ready then
  
    for i, junglemob in pairs(self.JungleMobs.objects) do
    
      local WJunglemobDmg = self:GetDmg("W", junglemob)
      
      for j = 1, #self.FocusJungleNames do
      
        if junglemob.name == self.FocusJungleNames[j] and WJunglemobDmg >= junglemob.health and self:ValidTargetNear(junglemob, self.W.radius, self.Ball) then
          self:CastW(junglemob)
        end
        
      end
      
    end
    
  end
  
  if JStealQ and self.Q.ready then
  
    for i, junglemob in pairs(self.JungleMobs.objects) do
    
      local QJunglemobDmg = .8*self:GetDmg("Q", junglemob)
      
      for j = 1, #self.FocusJungleNames do
      
        if junglemob.name == self.FocusJungleNames[j] and QJunglemobDmg >= junglemob.health and ValidTarget(junglemob, self.Q.range+self.Q.radius) then
          self:CastQ(junglemob)
        end
        
      end
      
    end
    
  end
  
  if JStealE and self.E.ready then
  
    for i, junglemob in pairs(self.JungleMobs.objects) do
    
      local EJunglemobDmg = self:GetDmg("E", junglemob)
      
      for j = 1, #self.FocusJungleNames do
      
        if junglemob.name == self.FocusJungleNames[j] and EJunglemobDmg >= junglemob.health and ValidTarget(junglemob, GetDistance(self.Ball, myHero)+100) then
          self:CastE(junglemob)
        end
        
      end
      
    end
    
  end
  
end

---------------------------------------------------------------------------------

function HTTF_Orianna:JstealAlways()

  if self.S.ready then
  
    for i, junglemob in pairs(self.JungleMobs.objects) do
    
      local SJunglemobDmg = self:GetDmg("SMITE", junglemob)
      
      for j = 1, #self.FocusJungleNames do
      
        if (junglemob.name == "SRU_Baron12.1.1" or junglemob.name == "SRU_Dragon6.1.1") and SJunglemobDmg >= junglemob.health and ValidTarget(junglemob, self.S.range) then
          self:CastS(junglemob)
          return
        end
        
      end
      
    end
    
  end
  
  if self.W.ready then
  
    for i, junglemob in pairs(self.JungleMobs.objects) do
    
      local WJunglemobDmg = self:GetDmg("W", junglemob)
      
      for j = 1, #self.FocusJungleNames do
      
        if (junglemob.name == "SRU_Baron12.1.1" or junglemob.name == "SRU_Dragon6.1.1") and WJunglemobDmg >= junglemob.health and self:ValidTargetNear(junglemob, self.W.radius, self.Ball) then
          self:CastW(junglemob)
        end
        
      end
      
    end
    
  end
  
  if self.Q.ready then
  
    for i, junglemob in pairs(self.JungleMobs.objects) do
    
      local QJunglemobDmg = .8*self:GetDmg("Q", junglemob)
      
      for j = 1, #self.FocusJungleNames do
      
        if (junglemob.name == "SRU_Baron12.1.1" or junglemob.name == "SRU_Dragon6.1.1") and QJunglemobDmg >= junglemob.health and ValidTarget(junglemob, self.Q.range+self.Q.radius) then
          self:CastQ(junglemob)
        end
        
      end
      
    end
    
  end
  
  if self.E.ready then
  
    for i, junglemob in pairs(self.JungleMobs.objects) do
    
      local EJunglemobDmg = self:GetDmg("E", junglemob)
      
      for j = 1, #self.FocusJungleNames do
      
        if (junglemob.name == "SRU_Baron12.1.1" or junglemob.name == "SRU_Dragon6.1.1") and EJunglemobDmg >= junglemob.health and ValidTarget(junglemob, GetDistance(self.Ball, myHero)+100) then
          self:CastE(junglemob)
        end
        
      end
      
    end
    
  end
  
end

---------------------------------------------------------------------------------

function HTTF_Orianna:KillSteal()

  local KillStealQ = self.Menu.KillSteal.Q
  local KillStealW = self.Menu.KillSteal.W
  local KillStealE = self.Menu.KillSteal.E
  local KillStealR = self.Menu.KillSteal.R
  local KillStealI = self.Menu.KillSteal.I
  local KillStealS = self.Menu.KillSteal.S
  
  for i, enemy in ipairs(self.EnemyHeroes) do
  
    local QenemyDmg = KillStealQ and self.Q.ready and (GetDistance(enemy, myHero) < self.Q.range+self.Q.radius) and .8*self:GetDmg("Q", enemy) or 0
    local WenemyDmg = KillStealW and self.W.ready and self:GetDmg("W", enemy) or 0
    local EenemyDmg = KillStealE and self.E.ready and self:GetDmg("E", enemy) or 0
    local RenemyDmg = KillStealR and self.R.ready and self:GetDmg("R", enemy) or 0
    local IenemyDmg = self.I.ready and self:GetDmg("IGNITE", enemy) or 0
    --local SBenemyDmg = self.Items["Stalker"].ready and self:GetDmg("STALKER", enemy) or 0
    
    if KillStealI and IenemyDmg >= enemy.health and ValidTarget(enemy, self.I.range) then
      self:CastI(enemy)
    end
    
    --[[if KillStealS and SBenemyDmg >= enemy.health and ValidTarget(enemy, self.S.range) then
      self:CastS(enemy)
      return
    end]]
    
    if KillStealW and QenemyDmg+WenemyDmg+RenemyDmg >= enemy.health and self:ValidTargetNear(enemy, self.W.radius+100, self.Ball) then
      self:CastW(enemy)
    end
    
    if KillStealR and QenemyDmg+WenemyDmg+RenemyDmg >= enemy.health and self:ValidTargetNear(enemy, self.R.radius+300, self.Ball) then
      self:CastR(enemy)
    end
    
    if KillStealQ and QenemyDmg+WenemyDmg+RenemyDmg >= enemy.health and ValidTarget(enemy, self.Q.range+self.Q.radius) then
      self:CastQ(enemy)
    end
    
    if KillStealE and EenemyDmg >= enemy.health and ValidTarget(enemy, GetDistance(self.Ball, myHero)+100) then
      self:CastE(enemy)
    end
    
  end
  
end

---------------------------------------------------------------------------------

function HTTF_Orianna:Auto()

  local AutoW = self.Menu.Auto.W
  local AutoWMin = self.Menu.Auto.WMin
  local AutoR = self.Menu.Auto.R
  local AutoRMin = self.Menu.Auto.RMin
  
  if self.W.ready and AutoW then
  
    for i, enemy in ipairs(self.EnemyHeroes) do
    
      if self:ValidTargetNear(enemy, self.W.radius+100, self.Ball) then
      
        local WPos, WHitChance, WNoH = self.HPred:GetPredict(self.HPred.Presets["Orianna"]["W"], enemy, self.Ball, true)
        
        if WNoH >= AutoWMin then
          CastSpell(_W)
          return
        end
        
      end
      
    end
    
  end
  
  if self.R.ready and AutoR then
  
    for i, enemy in ipairs(self.EnemyHeroes) do
    
      if self:ValidTargetNear(enemy, self.R.radius+300, self.Ball) then
      
        local RPos, RHitChance, RNoH = self.HPred:GetPredict(self.HPred.Presets["Orianna"]["R"], enemy, self.Ball, true)
        
        if RNoH >= AutoRMin then
          CastSpell(_R)
          return
        end
        
      end
      
    end
    
  end
  
end
---------------------------------------------------------------------------------

function HTTF_Orianna:Flee()

  self:MoveToMouse()
  
  if self.W.ready and self.Ball == myHero then
    CastSpell(_W)
  end
  
  if self.E.ready and self.Ball ~= myHero then
    self:GiveE(myHero)
  end
  
end

---------------------------------------------------------------------------------

function HTTF_Orianna:AutoLevel()

  if self.Menu.Misc.ALOpt == 1 then
    self:AutoLevel2(self.AutoQEQW)
  elseif self.Menu.Misc.ALOpt == 2 then
    self:AutoLevel2(self.AutoEQQW)
  end
  
end

function HTTF_Orianna:AutoLevel2(sequence)

  if self.Q.level+self.W.level+self.E.level+self.R.level < myHero.level then
  
    local spell = {_Q, _W, _E, _R}
    local level = {0, 0, 0, 0}
    
    for i = 1, myHero.level do
      level[sequence[i]] = level[sequence[i]]+1
    end
    
    for i, j in ipairs({self.Q.level, self.W.level, self.E.level, self.R.level}) do
    
      if j < level[i] then
        LevelSpell(spell[i])
      end
      
    end
    
  end
  
end

_G.LevelSpell = function(id)

  local offsets = {[_Q] = 0x70, [_W] = 0xB0, [_E] = 0xF0, [_R] = 0x30,}
  local p = CLoLPacket(0x0023)
  
  p.vTable = 0xE23A7C
  p:EncodeF(myHero.networkID)
  p:Encode4(0xBEBEBEBE)
  p:Encode4(0x16161616)
  p:Encode1(0x6B)
  p:Encode4(0x7C7C7C7C)
  p:Encode1(offsets[id])
  p:Encode4(0x00000000)
  p:Encode1(0x00)
  SendPacket(p)
  
end
--https://github.com/LegendBot/Developer_Snippets/blob/master/LevelSpell.lua
---------------------------------------------------------------------------------

function HTTF_Orianna:HealthPercent(unit)
  return (unit.health/unit.maxHealth)*100
end

function HTTF_Orianna:ManaPercent()
  return (myHero.mana/myHero.maxMana)*100
end

---------------------------------------------------------------------------------

function HTTF_Orianna:AddRange(unit)
  return unit.boundingRadius
end

function HTTF_Orianna:TrueRange(enemy)
  return myHero.range+self:AddRange(myHero)+self:AddRange(enemy)
end

---------------------------------------------------------------------------------

function HTTF_Orianna:GetDmg(spell, enemy)

  if enemy.health == 0 then
    return 0
  end
  
  local ADDmg = 0
  local APDmg = 0
  
  local Level = myHero.level
  local TotalDmg = myHero.totalDamage
  local AddDmg = myHero.addDamage
  local AP = myHero.ap
  local ArmorPen = myHero.armorPen
  local ArmorPenPercent = myHero.armorPenPercent
  local MagicPen = myHero.magicPen
  local MagicPenPercent = myHero.magicPenPercent
  
  local Armor = math.max(0, enemy.armor*ArmorPenPercent-ArmorPen)
  local ArmorPercent = Armor/(100+Armor)
  local MagicArmor = math.max(0, enemy.magicArmor*MagicPenPercent-MagicPen)
  local MagicArmorPercent = MagicArmor/(100+MagicArmor)
  
  if spell == "IGNITE" then
  
    local TrueDmg = 50+20*Level
    
    return TrueDmg
  elseif spell == "SMITE" then
  
    if Level <= 4 then
    
      local TrueDmg = 370+20*Level
      
      return TrueDmg
    elseif Level <= 9 then
    
      local TrueDmg = 330+30*Level
      
      return TrueDmg
    elseif Level <= 14 then
    
      local TrueDmg = 240+40*Level
      
      return TrueDmg
    else
    
      local TrueDmg = 100+50*Level
      
      return TrueDmg
    end
    
  elseif spell == "STALKER" then
  
    local TrueDmg = 20+8*Level
    
    return TrueDmg
  elseif spell == "BC" then
    APDmg = 100
  elseif spell == "BRK" then
    ADDmg = math.max(100, .1*enemy.maxHealth)
  elseif spell == "AA" then
    ADDmg = TotalDmg
  elseif spell == "Q" then
    APDmg = 30*self.Q.level+30+.5*AP
  elseif spell == "W" then
    APDmg = 45*self.W.level+25+.7*AP
  elseif spell == "E" then
    ADDmg = 30*self.E.level+30+.3*AP
  elseif spell == "R" then
    APDmg = 75*self.R.level+75+.7*AP
  end
  
  local TrueDmg = ADDmg*(1-ArmorPercent)+APDmg*(1-MagicArmorPercent)
  
  return TrueDmg
end

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

function HTTF_Orianna:CastQ(unit, mode)

  if unit.dead or unit.health == 0 then
    return
  end
  
  self.QPos, self.QHitChance = self.HPred:GetPredict(self.HPred.Presets["Orianna"]["Q"], unit, self.Ball)
  
  if mode == "Combo" and self.QHitChance >= self.Menu.HitChance.Combo.Q or mode == "Harass" and self.QHitChance >= self.Menu.HitChance.Harass.Q or mode == "JFarm" and self.QPos ~= nil or mode == nil and self.QHitChance > 1 then
    CastSpell(_Q, self.QPos.x, self.QPos.z)
  end
  
end

---------------------------------------------------------------------------------

function HTTF_Orianna:CastW(unit, mode)

  if unit.dead then
    return
  end
  
  self.WPos, self.WHitChance = self.HPred:GetPredict(self.HPred.Presets["Orianna"]["W"], unit, self.Ball)
  
  if (mode == "Combo" or mode == "Harass" or mode == "JFarm") and self.WHitChance == 3 or mode == nil and self.WHitChance > 2 then
    CastSpell(_W)
  end
  
end

---------------------------------------------------------------------------------

function HTTF_Orianna:CastE(unit)

  if unit.dead or Vector(unit) == Vector(self.Ball) then
    return
  end
  
  self.EHit = self.HPred:SpellCollision(self.HPred.Presets["Orianna"]["E"], unit, self.Ball, myHero)
  
  if self.EHit then
    self:GiveE(myHero)
  end
  
end

---------------------------------------------------------------------------------

function HTTF_Orianna:GiveE(unit)

  if unit.dead then
    return
  end
  
  CastSpell(_E, unit)
end

---------------------------------------------------------------------------------

function HTTF_Orianna:CastR(unit, mode)

  if unit.dead then
    return
  end
  
  if mode == "ComboM" then
    self.RPos, self.RHitChance, self.RNoH = self.HPred:GetPredict(self.HPred.Presets["Orianna"]["R"], unit, self.Ball, true)
    
    if self.RNoH >= self.Menu.Combo.RMin then
      CastSpell(_R)
    end
    
  else
  
    self.RPos, self.RHitChance = self.HPred:GetPredict(self.HPred.Presets["Orianna"]["R"], unit, self.Ball)
    
    if self.RHitChance == 3 then
      CastSpell(_R)
    end
    
  end
  
end

---------------------------------------------------------------------------------

function HTTF_Orianna:CastI(enemy)
  CastSpell(self.Ignite, enemy)
end

---------------------------------------------------------------------------------

function HTTF_Orianna:CastS(enemy)
  CastSpell(self.Smite, enemy)
end

---------------------------------------------------------------------------------

function HTTF_Orianna:CastBC(enemy)
  CastSpell(self.Items["BC"].slot, enemy)
end

---------------------------------------------------------------------------------

function HTTF_Orianna:CastBRK(enemy)
  CastSpell(self.Items["BRK"].slot, enemy)
end

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

function HTTF_Orianna:MoveToMouse()

  if mousePos and GetDistance(mousePos) <= 100 then
    self.MousePos = myHero+(Vector(mousePos)-myHero):normalized()*300
  else
    self.MousePos = mousePos
  end
  
  myHero:MoveTo(self.MousePos.x, self.MousePos.z)
end

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

function HTTF_Orianna:Draw()

  if not self.Menu.Draw.On or myHero.dead then
    return
  end
  
  if self.Menu.Harass.On or self.Menu.Harass.On2 then
    DrawText("Harass: On", 20, 1600, 150, ARGB(0xFF, 0xFF, 0xFF, 0xFF))
  else
    DrawText("Harass: Off", 20, 1600, 150, ARGB(0xFF, 0xFF, 0x80, 0x80))
  end
  
  if self.Menu.JSteal.On or self.Menu.JSteal.On2 then
    DrawText("Jungle Steal: On", 20, 1600, 200, ARGB(0xFF, 0xFF, 0xFF, 0xFF))
  else
    DrawText("Jungle Steal: Off", 20, 1600, 200, ARGB(0xFF, 0xFF, 0x80, 0x80))
  end
  
  if self.Menu.Draw.Target.Q and self.QTarget ~= nil then
    self:DrawCircles(self.QTarget.x, self.QTarget.y, self.QTarget.z, self.Q.radius, ARGB(0xFF, 0xFF, 0xFF, 0xFF))
  end
  
  if self.Menu.Draw.Target.E and self.ETarget ~= nil then
    self:DrawCircles(self.ETarget.x, self.ETarget.y, self.ETarget.z, self.E.width/2, ARGB(0xFF, 0xFF, 0xFF, 0xFF))
  end
  
  if self.QHitChance ~= nil then
  
    if self.QHitChance < 1 then
      self.Qcolor = ARGB(0xFF, 0xFF, 0x00, 0x00)
    elseif self.QHitChance == 3 then
      self.Qcolor = ARGB(0xFF, 0x00, 0x54, 0xFF)
    elseif self.QHitChance >= 2 then
      self.Qcolor = ARGB(0xFF, 0x1D, 0xDB, 0x16)
    elseif self.QHitChance >= 1 then
      self.Qcolor = ARGB(0xFF, 0xFF, 0xE4, 0x00)
    end
  
  end
  
  if self.WHitChance ~= nil then
  
    if self.WHitChance < 1 then
      self.Wcolor = ARGB(0xFF, 0xFF, 0x00, 0x00)
    elseif self.WHitChance == 3 then
      self.Wcolor = ARGB(0xFF, 0x00, 0x54, 0xFF)
    elseif self.WHitChance >= 2 then
      self.Wcolor = ARGB(0xFF, 0x1D, 0xDB, 0x16)
    elseif self.WHitChance >= 1 then
      self.Wcolor = ARGB(0xFF, 0xFF, 0xE4, 0x00)
    end
  
  end
  
  if self.EHit ~= nil then
  
    if self.EHit then
      self.Ecolor = ARGB(0xFF, 0x00, 0x54, 0xFF)
    else
      self.Ecolor = ARGB(0xFF, 0xFF, 0x00, 0x00)
    end
    
  end
  
  if self.RHitChance ~= nil then
  
    if self.RHitChance < 1 then
      self.Rcolor = ARGB(0xFF, 0xFF, 0x00, 0x00)
    elseif self.RHitChance == 3 then
      self.Rcolor = ARGB(0xFF, 0x00, 0x54, 0xFF)
    elseif self.RHitChance >= 2 then
      self.Rcolor = ARGB(0xFF, 0x1D, 0xDB, 0x16)
    elseif self.RHitChance >= 1 then
      self.Rcolor = ARGB(0xFF, 0xFF, 0xE4, 0x00)
    end
    
  end
  
  if self.Menu.Draw.PP.Q and self.QPos ~= nil then
  
    self:DrawCircles(self.QPos.x, self.QPos.y, self.QPos.z, self.Q.radius, self.Qcolor)
    
    if self.Menu.Draw.PP.Line then
      DrawLine3D(self.Ball.x, self.Ball.y, self.Ball.z, self.QPos.x, self.QPos.y, self.QPos.z, 2, self.Qcolor)
    end
    
    self.QPos = nil
  end
  
  if self.Menu.Draw.PP.E and self.EHit ~= nil then
    DrawLine3D(self.Ball.x, self.Ball.y, self.Ball.z, myHero.x, myHero.y, myHero.z, 2, self.Ecolor)
  end
  
  if self.Menu.Draw.Hitchance then
  
    if self.QHitChance ~= nil then
      DrawText("Q HitChance: "..self.QHitChance, 20, 1250, 550, self.Qcolor)
      self.QHitChance = nil
    end
  
    if self.WHitChance ~= nil then
      DrawText("W HitChance: "..self.WHitChance, 20, 1250, 600, self.Wcolor)
      self.WHitChance = nil
    end
  
    if self.EHit ~= nil then
      DrawText("E Hit: "..tostring(self.EHit), 20, 1250, 650, self.Ecolor)
    end
    
    if self.RHitChance ~= nil then
      DrawText("R HitChance: "..self.RHitChance, 20, 1250, 700, self.Rcolor)
      self.RHitChance = nil
      
      if self.RNoH ~= nil then
        DrawText("R NoH: "..self.RNoH, 20, 1050, 550, ARGB(0xFF, 0xFF, 0xFF, 0xFF))
        self.RNoH = nil
      end
      
    end
    
  end
  
  self.EHit = nil
  
  if self.Menu.Draw.AA then
    self:DrawCircles(myHero.x, myHero.y, myHero.z, myHero.range+myHero.boundingRadius, ARGB(0xFF, 0, 0xFF, 0))
  end
  
  if self.Menu.Draw.Q then
    self:DrawCircles(myHero.x, myHero.y, myHero.z, self.Q.range, ARGB(0xFF, 0xFF, 0xFF, 0xFF))
  end
  
  if self.Menu.Draw.Ball then
    self:DrawCircles(self.Ball.x, self.Ball.y, self.Ball.z, self.Q.radius, ARGB(0xFF, 0xFF, 0x5E, 0x00))
  end
  
  if self.Menu.Draw.W and self.W.ready then
    self:DrawCircles(self.Ball.x, self.Ball.y, self.Ball.z, self.W.radius, ARGB(0xFF, 0xFF, 0xFF, 0xFF))
  end
  
  if self.Menu.Draw.R and self.R.ready then
    self:DrawCircles(self.Ball.x, self.Ball.y, self.Ball.z, self.R.radius, ARGB(0xFF, 0x00, 0x00, 0xFF))
  end
  
  if self.Menu.Draw.I and self.I.ready then
    self:DrawCircles(myHero.x, myHero.y, myHero.z, self.I.range, ARGB(0xFF, 0xFF, 0x24, 0x24))
  end
  
  if self.Menu.Draw.S and self.S.ready and (self.Menu.JSteal.On or self.Menu.JSteal.On2) and self.Menu.JSteal.S then
    self:DrawCircles(myHero.x, myHero.y, myHero.z, self.S.range, ARGB(0xFF, 0xFF, 0x14, 0x93))
  end
  
  if self.Menu.Draw.Path then
  
    if myHero.hasMovePath and myHero.pathCount >= 2 then
    
      local IndexPath = myHero:GetPath(myHero.pathIndex)
      
      if IndexPath then
        DrawLine3D(myHero.x, myHero.y, myHero.z, IndexPath.x, IndexPath.y, IndexPath.z, 1, ARGB(255, 255, 255, 255))
      end
      
      for i=myHero.pathIndex, myHero.pathCount-1 do
      
        local Path = myHero:GetPath(i)
        local Path2 = myHero:GetPath(i+1)
        
        DrawLine3D(Path.x, Path.y, Path.z, Path2.x, Path2.y, Path2.z, 1, ARGB(255, 255, 255, 255))
      end
      
    end
    
    for i, enemy in ipairs(self.EnemyHeroes) do
    
      if enemy.hasMovePath and enemy.pathCount >= 2 then
      
        local IndexPath = enemy:GetPath(enemy.pathIndex)
        
        if IndexPath then
          DrawLine3D(enemy.x, enemy.y, enemy.z, IndexPath.x, IndexPath.y, IndexPath.z, 1, ARGB(255, 255, 255, 255))
        end
        
        for i=enemy.pathIndex, enemy.pathCount-1 do
        
          local Path = enemy:GetPath(i)
          local Path2 = enemy:GetPath(i+1)
          
          DrawLine3D(Path.x, Path.y, Path.z, Path2.x, Path2.y, Path2.z, 1, ARGB(255, 255, 255, 255))
        end
        
      end
      
    end
    
  end
  
end

---------------------------------------------------------------------------------

function HTTF_Orianna:DrawCircles(x, y, z, radius, color)

  if self.Menu.Draw.Lfc then
  
    local v1 = Vector(x, y, z)
    local v2 = Vector(cameraPos.x, cameraPos.y, cameraPos.z)
    local tPos = v1-(v1-v2):normalized()*radius
    local sPos = WorldToScreen(D3DXVECTOR3(tPos.x, tPos.y, tPos.z))
    
    if OnScreen({x = sPos.x, y = sPos.y}, {x = sPos.x, y = sPos.y}) then
      self:DrawCircles2(x, y, z, radius, color) 
    end
    
  else
    DrawCircle(x, y, z, radius, color)
  end
  
end

function HTTF_Orianna:DrawCircles2(x, y, z, radius, color)

  local length = 75
  local radius = radius*.92
  local quality = math.max(8,self:round(180/math.deg((math.asin((length/(2*radius)))))))
  local quality = 2*math.pi/quality
  local points = {}
  
  for theta = 0, 2*math.pi+quality, quality do
  
    local c = WorldToScreen(D3DXVECTOR3(x+radius*math.cos(theta), y, z-radius*math.sin(theta)))
    points[#points + 1] = D3DXVECTOR2(c.x, c.y)
  end
  
  DrawLines2(points, 1, color or 4294967295)
end

function HTTF_Orianna:round(num)

  if num >= 0 then
    return math.floor(num+.5)
  else
    return math.ceil(num-.5)
  end
  
end

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

function HTTF_Orianna:Animation(unit, animation, hash)

	if unit == nil or unit.networkID ~= myHero.networkID then
		return
	end
	--[[if not animation:find("Idle") and animation ~= "Run" then
		print("animation = " .. animation .. "\nhash = " .. hash)
	end]]
	if hash == "D93E11F8" then
		self.Ball = unit
	end
end

---------------------------------------------------------------------------------

function HTTF_Orianna:ProcessSpell(unit, spell)

	if unit == nil or unit.networkID ~= myHero.networkID then
		return
	end
	
  if spell.name == "OrianaIzunaCommand" then
		self.Ball = Vector(spell.endPos)
  elseif spell.name == "OrianaRedactCommand" then
		self.Ball = spell.target
  end
  
end


---------------------------------------------------------------------------------
function HTTF_Orianna:UpdateBuff(unit, buff, stacks)
	if unit == nil or unit.networkID ~= myHero.networkID then
		return
	end
	
	if buff.name == "recall" then
		self.IsRecall = true
	end
end

---------------------------------------------------------------------------------
function HTTF_Orianna:RemoveBuff(unit, buff)
  if unit == nil or unit.networkID ~= myHero.networkID then
  	return
  			end
  if buff.name == "recall" then
	self.IsRecall = false
	end
end

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

function HTTF_Orianna:OnSendPacket(p)

  if self.Menu.Misc.BlockR then
  
    if GetGameVersion():find("5.18.0.291") and p.header == 0xC0 then
      p.pos = 10
      
      if p:Decode1() == 0x7B and not self:RHit() then
        p:Block()
      end
      
    end
    
  end
  
end

---------------------------------------------------------------------------------

function HTTF_Orianna:RHit()

  for i, enemy in ipairs(self.EnemyHeroes) do
  
    local RPos, RHitChance = self.HPred:GetPredict(self.HPred.Presets["Orianna"]["R"], enemy, self.Ball)
    
    if RHitChance > 2 then
      return true
    end
    
  end
  
  return false
end

---------------------------------------------------------------------------------

function HTTF_Orianna:ValidTargetNear(object, distance, from)
  return object ~= nil and object.valid and object.team ~= player.team and object.visible and not object.dead and object.bTargetable and (object.bInvulnerable == 0) and GetDistanceSqr(object, from) <= distance*distance
end