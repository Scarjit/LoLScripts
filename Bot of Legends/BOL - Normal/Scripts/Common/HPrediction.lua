_G.HPrediction_Version = 1.402

local myHero = myHero
local math, table, os = math, table, os
local pairs, ipairs, type = pairs, ipairs, type
local Vector = Vector

local function GetDistanceSqr(p1, p2)
    p2 = p2 or myHero
    
    local dx = p1.x - p2.x
    local dz = (p1.z or p1.y) - (p2.z or p2.y)
    
    return dx*dx + dz*dz
end

local function GetDistance(p1, p2)
    return math.sqrt(GetDistanceSqr(p1, p2))
end

local function IsNilOrFalse(condition)
  return not condition
end

class("HPredUpdate")
class("HPrediction")

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

function HPredUpdate:__init(LocalVersion, UseHttps, Host, VersionPath, ScriptPath, SavePath, CallbackUpdate, CallbackNoUpdate, CallbackNewVersion,CallbackError)
  self.LocalVersion = LocalVersion
  self.Host = Host
  self.VersionPath = '/BoL/TCPUpdater/GetScript'..(UseHttps and '5' or '6')..'.php?script='..self:Base64Encode(self.Host..VersionPath)..'&rand='..math.random(99999999)
  self.ScriptPath = '/BoL/TCPUpdater/GetScript'..(UseHttps and '5' or '6')..'.php?script='..self:Base64Encode(self.Host..ScriptPath)..'&rand='..math.random(99999999)
  self.SavePath = SavePath
  self.CallbackUpdate = CallbackUpdate
  self.CallbackNoUpdate = CallbackNoUpdate
  self.CallbackNewVersion = CallbackNewVersion
  self.CallbackError = CallbackError
  AddDrawCallback(function() self:OnDraw() end)
  self:CreateSocket(self.VersionPath)
  self.DownloadStatus = 'Connect to Server for VersionInfo'
  AddTickCallback(function() self:GetOnlineVersion() end)
end

function HPredUpdate:print(str)
  print('<font color="#FFFFFF">'..os.clock()..': '..str)
end

function HPredUpdate:OnDraw()

  if self.DownloadStatus ~= 'Downloading Script (100%)' and self.DownloadStatus ~= 'Downloading VersionInfo (100%)'then
    DrawText('Download Status: '..(self.DownloadStatus or 'Unknown'),50,10,50,ARGB(0xFF,0xFF,0xFF,0xFF))
  end
  
end

function HPredUpdate:CreateSocket(url)

  if not self.LuaSocket then
    self.LuaSocket = require("socket")
  else
    self.Socket:close()
    self.Socket = nil
    self.Size = nil
    self.RecvStarted = false
  end
  
  self.LuaSocket = require("socket")
  self.Socket = self.LuaSocket.tcp()
  self.Socket:settimeout(0, 'b')
  self.Socket:settimeout(99999999, 't')
  self.Socket:connect('sx-bol.eu', 80)
  self.Url = url
  self.Started = false
  self.LastPrint = ""
  self.File = ""
end

function HPredUpdate:Base64Encode(data)

  local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
  
  return ((data:gsub('.', function(x)
  
    local r,b='',x:byte()
    
    for i=8,1,-1 do
      r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0')
    end
    
    return r;
  end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
  
    if (#x < 6) then
      return ''
    end
    
    local c=0
    
    for i=1,6 do
      c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0)
    end
    
    return b:sub(c+1,c+1)
  end)..({ '', '==', '=' })[#data%3+1])
  
end

function HPredUpdate:GetOnlineVersion()

  if self.GotScriptVersion then
    return
  end
  
  self.Receive, self.Status, self.Snipped = self.Socket:receive(1024)
  
  if self.Status == 'timeout' and not self.Started then
    self.Started = true
    self.Socket:send("GET "..self.Url.." HTTP/1.1\r\nHost: sx-bol.eu\r\n\r\n")
  end
  
  if (self.Receive or (#self.Snipped > 0)) and not self.RecvStarted then
    self.RecvStarted = true
    self.DownloadStatus = 'Downloading VersionInfo (0%)'
  end
  
  self.File = self.File .. (self.Receive or self.Snipped)
  
  if self.File:find('</s'..'ize>') then
  
    if not self.Size then
      self.Size = tonumber(self.File:sub(self.File:find('<si'..'ze>')+6,self.File:find('</si'..'ze>')-1))
    end
    
    if self.File:find('<scr'..'ipt>') then
    
      local _,ScriptFind = self.File:find('<scr'..'ipt>')
      local ScriptEnd = self.File:find('</scr'..'ipt>')
      
      if ScriptEnd then
        ScriptEnd = ScriptEnd-1
      end
      
      local DownloadedSize = self.File:sub(ScriptFind+1,ScriptEnd or -1):len()
      
      self.DownloadStatus = 'Downloading VersionInfo ('..math.round(100/self.Size*DownloadedSize,2)..'%)'
    end
    
  end
  
  if self.File:find('</scr'..'ipt>') then
    self.DownloadStatus = 'Downloading VersionInfo (100%)'
    
    local a,b = self.File:find('\r\n\r\n')
    
    self.File = self.File:sub(a,-1)
     self.NewFile = ''
    
    for line,content in ipairs(self.File:split('\n')) do
    
      if content:len() > 5 then
        self.NewFile = self.NewFile .. content
      end
      
    end
    
    local HeaderEnd, ContentStart = self.File:find('<scr'..'ipt>')
    local ContentEnd, _ = self.File:find('</sc'..'ript>')
    
    if not ContentStart or not ContentEnd then
    
      if self.CallbackError and type(self.CallbackError) == 'function' then
        self.CallbackError()
      end
      
    else
      self.OnlineVersion = (Base64Decode(self.File:sub(ContentStart+1,ContentEnd-1)))
      self.OnlineVersion = tonumber(self.OnlineVersion)
      
      if self.OnlineVersion > self.LocalVersion then
      
        if self.CallbackNewVersion and type(self.CallbackNewVersion) == 'function' then
          self.CallbackNewVersion(self.OnlineVersion,self.LocalVersion)
        end
        
        self:CreateSocket(self.ScriptPath)
        self.DownloadStatus = 'Connect to Server for ScriptDownload'
        AddTickCallback(function() self:DownloadUpdate() end)
      else
        
        if self.CallbackNoUpdate and type(self.CallbackNoUpdate) == 'function' then
          self.CallbackNoUpdate(self.LocalVersion)
        end
        
      end
      
    end
    
    self.GotScriptVersion = true
  end
  
end

function HPredUpdate:DownloadUpdate()

  if self.GotScriptUpdate then
    return
  end
  
  self.Receive, self.Status, self.Snipped = self.Socket:receive(1024)
  
  if self.Status == 'timeout' and not self.Started then
    self.Started = true
    self.Socket:send("GET "..self.Url.." HTTP/1.1\r\nHost: sx-bol.eu\r\n\r\n")
  end
  
  if (self.Receive or (#self.Snipped > 0)) and not self.RecvStarted then
    self.RecvStarted = true
    self.DownloadStatus = 'Downloading Script (0%)'
  end
  
  self.File = self.File .. (self.Receive or self.Snipped)
  
  if self.File:find('</si'..'ze>') then
  
    if not self.Size then
      self.Size = tonumber(self.File:sub(self.File:find('<si'..'ze>')+6,self.File:find('</si'..'ze>')-1))
    end
    
    if self.File:find('<scr'..'ipt>') then
    
      local _,ScriptFind = self.File:find('<scr'..'ipt>')
      local ScriptEnd = self.File:find('</scr'..'ipt>')
      
      if ScriptEnd then
        ScriptEnd = ScriptEnd-1
      end
      
      local DownloadedSize = self.File:sub(ScriptFind+1,ScriptEnd or -1):len()
      
      self.DownloadStatus = 'Downloading Script ('..math.round(100/self.Size*DownloadedSize,2)..'%)'
    end
    
  end
  
  if self.File:find('</scr'..'ipt>') then
    self.DownloadStatus = 'Downloading Script (100%)'
    
    local a,b = self.File:find('\r\n\r\n')
    
    self.File = self.File:sub(a,-1)
    self.NewFile = ''
    
    for line,content in ipairs(self.File:split('\n')) do
    
      if content:len() > 5 then
        self.NewFile = self.NewFile .. content
      end
      
    end
    
    local HeaderEnd, ContentStart = self.NewFile:find('<sc'..'ript>')
    local ContentEnd, _ = self.NewFile:find('</scr'..'ipt>')
    
    if not ContentStart or not ContentEnd then
      
      if self.CallbackError and type(self.CallbackError) == 'function' then
        self.CallbackError()
      end
      
    else
      
      local newf = self.NewFile:sub(ContentStart+1,ContentEnd-1)
      local newf = newf:gsub('\r','')
      
      if newf:len() ~= self.Size then
      
        if self.CallbackError and type(self.CallbackError) == 'function' then
          self.CallbackError()
        end
        
        return
      end
      
      local newf = Base64Decode(newf)
      
      if type(load(newf)) ~= 'function' then
      
        if self.CallbackError and type(self.CallbackError) == 'function' then
          self.CallbackError()
        end
        
      else
      
        local f = io.open(self.SavePath,"w+b")
        
        f:write(newf)
        f:close()
        
        if self.CallbackUpdate and type(self.CallbackUpdate) == 'function' then
          self.CallbackUpdate(self.OnlineVersion,self.LocalVersion)
        end
        
      end
      
    end
    
    self.GotScriptUpdate = true
  end
  
end

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

function HPrediction:__init()

  if _G.HPrediction_Init then
    return
  end
  
  self:Update()
  self:Variables()
  self:Menu()
  self:Metatables()
  
  AddTickCallback(function() self:OnTick() end)
  
  AddAnimationCallback(function(...) self:OnAnimation(...) end)
  AddUpdateBuffCallback(function(unit, buff, stacks) self:OnUpdateBuff(unit, buff, stacks) end)
  AddRemoveBuffCallback(function(unit, buff) self:OnRemoveBuff(unit, buff) end)
  --AddProcessSpellCallback(function(unit, spell) self:OnProcessSpell(unit, spell) end)
  AddProcessAttackCallback(function(...) self:OnProcessAttack(...) end)
  
  _G.HPrediction_Init = true
end

---------------------------------------------------------------------------------

function HPrediction:Update()

  local ToUpdate = {}
  
  ToUpdate.Host = "raw.githubusercontent.com"
  ToUpdate.VersionPath = "/BolHTTF/BoL/master/HTTF/Version/HPrediction.version"
  ToUpdate.ScriptPath =  "/BolHTTF/BoL/master/HTTF/Common/HPrediction.lua"
  ToUpdate.SavePath = LIB_PATH.."HPrediction.lua"
  ToUpdate.CallbackUpdate = function(NewVersion, OldVersion) print("<font color=\"#00FA9A\"><b>[HPrediction] </b></font> <font color=\"#FFFFFF\">Updated to "..NewVersion..". </b></font>") end
  ToUpdate.CallbackNoUpdate = function(OldVersion) print("<font color=\"#00FA9A\"><b>[HPrediction] </b></font> <font color=\"#FFFFFF\">No Updates Found</b></font>") end
  ToUpdate.CallbackNewVersion = function(NewVersion) print("<font color=\"#00FA9A\"><b>[HPrediction] </b></font> <font color=\"#FFFFFF\">New Version found ("..NewVersion.."). Please wait until its downloaded</b></font>") end
  ToUpdate.CallbackError = function(NewVersion) print("<font color=\"#00FA9A\"><b>[HPrediction] </b></font> <font color=\"#FFFFFF\">Error while Downloading. Please try again.</b></font>") end
  HPredUpdate(HPrediction_Version, true, ToUpdate.Host, ToUpdate.VersionPath, ToUpdate.ScriptPath, ToUpdate.SavePath, ToUpdate.CallbackUpdate,ToUpdate.CallbackNoUpdate, ToUpdate.CallbackNewVersion,ToUpdate.CallbackError)
end

---------------------------------------------------------------------------------

function HPrediction:Variables()

  if myHero.charName == "Xerath" then
    self.OnQ = false
    self.LastQ = 0
  end
  
  self.EnemyHeroes = GetEnemyHeroes()
  
  self.buffer = .02
  self.Draw = false
  self.PredictionDamage = {}
  self.ProjectileSpeed = {["SRU_OrderMinionRanged"] = 650, ["SRU_ChaosMinionRanged"] = 650, ["SRU_OrderMinionSiege"] = 1200, ["SRU_ChaosMinionSiege"] = 1200, ["SRUAP_Turret_Chaos1"] = 1200, ["SRUAP_Turret_Chaos2"] = 1200, ["SRUAP_Turret_Order1"] = 1200, ["SRUAP_Turret_Order2"] = 1200}
  
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
    "SRU_Red10.1.1"
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
    "SRU_RedMini10.1.3",
    "SRU_RiftHerald17.1.1"
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
  end
  
  self.EnemyMinions = minionManager(MINION_ENEMY, 2000, myHero, MINION_SORT_HEALTH_ASC)
  self.JungleMobs = minionManager(MINION_JUNGLE, 2000, myHero, MINION_SORT_MAXHEALTH_DEC)
  
end

---------------------------------------------------------------------------------

function HPrediction:Menu()

  self.Menu = scriptConfig("HTTF Prediction", "HTTF Prediction")
  
    self.Menu:addSubMenu("Collision Settings", "Collision")
      self.Menu.Collision:addParam("Buffer", "Buffer distance (Default value = 10)", SCRIPT_PARAM_SLICE, 10, 0, 20, 0)
      
      self.Menu:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
    self.Menu:addParam("Ignore", "Ignore which is about to die", SCRIPT_PARAM_ONOFF, true)
    self.Menu:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
    self.Menu:addParam("Info", "http://botoflegends.com", SCRIPT_PARAM_INFO, "")
    self.Menu:addParam("SVersion", "Script version: ", SCRIPT_PARAM_LIST, 1, {""..HPrediction_Version})
    
end

---------------------------------------------------------------------------------

function HPrediction:Metatables()
  self.Presets = setmetatable({}, {__index = _G.HPrediction.Presets})
  --[[self.Presets = {}
  setmetatable(self.Presets,
  {
    __index = function(tbl, key) return _G.HPrediction.Presets[key] end,
    __metatable = function() end,
  })]]
end

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

function _G.Vector.HPred_angleBetween(self, v1, v2)

  if IsNilOrFalse(VectorType(v1) and VectorType(v2)) then
    error("HPrediction: HPred_angleBetween: wrong argument types (2 <Vector> expected)", 2)
  end
  
  local p1, p2 = (-self+v1), (-self+v2)
  local theta = p1:polar()-p2:polar()
  
  if theta < 0 then
    theta = theta+360
  elseif theta >= 360 then
    theta = theta-360
  end
  
  return theta
end

function _G.Vector.HPred_rotateYaxis(self, degree)

  if IsNilOrFalse(type(degree) == "number") then
    error("HPrediction: HPred_rotateYaxis: wrong argument types (expected <number> for degree)", 2)
  end
  
  local phi = (degree*math.pi)/180
  local c, s = math.cos(phi), math.sin(phi)
  local v = Vector(self.x*c+self.z*s, self.y, self.z*c-self.x*s)
  
  return v
end

function HPrediction:CircleIntersection(v1, v2, c, radius)

  if IsNilOrFalse(VectorType(v1) and VectorType(v2) and VectorType(c) and type(radius) == "number") then
    error("HPrediction: CircleIntersection: wrong argument types (<Vector>, <Vector>, <Vector>, integer expected)", 2)
  end
  
  local x1, y1, x2, y2, x3, y3 = v1.x, v1.z or v1.y, v2.x, v2.z or v2.y, c.x, c.z or c.y
  local r = radius
  local xp, yp, xm, ym = nil, nil, nil, nil
  local IsOnSegment = nil
  
  if x1 == x2 then
  
    local B = math.sqrt(r^2-(x1-x3)^2)
    
    xp, yp, xm, ym = x1, y3+B, x1, y3-B
  else
  
    local m = (y2-y1)/(x2-x1)
    local n = y1-m*x1
    local A = x3-m*(n-y3)
    local B = math.sqrt(A^2-(1+m^2)*(x3^2-r^2+(n-y3)^2))
    
    xp, xm = (A+B)/(1+m^2), (A-B)/(1+m^2)
    yp, ym = m*xp+n, m*xm+n
  end
  
  if x1 <= x2 then
    IsOnSegment = x1 <= xp and xp <= x2
  else
    IsOnSegment = x2 <= xp and xp <= x1        
  end
  
  if IsOnSegment then
    return Vector(xp, myHero.y, yp)
  else
    return Vector(xm, myHero.y, ym)
  end
  
end

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

function HPrediction:OnTick()

  self.EnemyMinions:update()
  self.JungleMobs:update()
  
  if self.Menu.Ignore then

    for i, minion in ipairs(self.EnemyMinions.objects) do

      if self.PredictionDamage[minion.networkID] then

        local Delete = true

        for ctime, damage in pairs(self.PredictionDamage[minion.networkID]) do

          if GetGameTimer()+GetLatency()/2000 < ctime-GetLatency()/2000 then
            Delete = false
            break
          end

        end

        if Delete then
          self.PredictionDamage[minion.networkID] = nil
        end

      end

    end

  end
  
  if myHero.charName == "Xerath" then
  
    if self.OnQ then
    
      local Time = os.clock()-self.LastQ
      
      _G.HPrediction.Presets.Xerath.Q.range = math.min(1500, 750+500*(Time+GetLatency()/2000))
    else
      _G.HPrediction.Presets.Xerath.Q.range = 750
    end
    
  end
  
end

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

function HPrediction:GetPredict(spell, unit, from, noh)

  if IsNilOrFalse(spell) then
    error("GetPredict: spell is nil", 2)
  end
  
  if IsNilOrFalse(unit) then
    error("GetPredict: unit is nil", 2)
  end
  
  if IsNilOrFalse(from) then
    error("GetPredict: from is nil", 2)
  end
  
  if spell == "Q" or spell == "W" or spell == "E" or spell == "R" then
    error("GetPredict: Do not declare spell like as \"_Q\"", 2)
  end
  
  local spell = spell.Properties or spell
  local type = spell.type
  local delay = spell.delay
  local range = spell.range
  local speed = spell.speed
  local width = spell.width
  local addmyboundingRadius = spell.addmyboundingRadius
  local addunitboundingRadius = spell.addunitboundingRadius
  local radius = spell.radius
  local angle = spell.angle
  local IsLowAccuracy = spell.IsLowAccuracy
  local IsVeryLowAccuracy = spell.IsVeryLowAccuracy
  
  self.fromAddRange = from.boundingRadius or myHero.boundingRadius
  self.unitAddRange = unit.boundingRadius
  self.unitSpeed = unit.ms
  
  if type == "DelayCircle" or type == "PromptCircle" then
  
    if addmyboundingRadius then
      radius = radius+self.fromAddRange
    end
    
    if addunitboundingRadius then
      radius = radius+self.unitAddRange
    end
    
  end
  
  self.RT = .4
  
  if IsVeryLowAccuracy then
    self.RT = .6
  elseif IsLowAccuracy then
    self.RT = .5
  end
  
  self.RT_S = self.RT+.3
  
  local unitPredPos, unitPredPos_S, unitPredPos_E, unitPredPos_D, unitPredPos_C, CastPos, HitChance, NoH = nil, nil, nil, nil, nil, nil, 0, nil
  
  if unit.hasMovePath and unit.pathCount >= 2 then
  
    local unitIndexPos = unit:GetPath(unit.pathIndex)
    
    if unitIndexPos == nil then
      unitIndexPos = unit:GetPath(unit.pathIndex-1)
    end
    
    self.TotalDST = GetDistance(unitIndexPos, unit)
    
    local DST, DST_S, DST_D = GetDistance(unitIndexPos, unit), GetDistance(unitIndexPos, unit), GetDistance(unitIndexPos, unit)
    local ExDST, ExDST_S, ExDST_D = nil, nil, nil
    local LastIndex, LastIndex_S, LastIndex_D = nil, nil, nil
    
    for i = unit.pathIndex, unit.pathCount do
    
      local Path = unit:GetPath(i)
      local Path2 = unit:GetPath(i+1)
      
      if unit.pathCount == i then
        Path2 = unit:GetPath(i)
      end
      
      if LastIndex == nil and DST > self.RT*self.unitSpeed then
        LastIndex = i
        ExDST = DST-self.RT*self.unitSpeed
      end
      
      if LastIndex_S == nil and DST_S > self.RT_S*self.unitSpeed then
        LastIndex_S = i
        ExDST_S = DST_S-self.RT_S*self.unitSpeed
      end
      
      if range == 0 and delay < self.RT and LastIndex_D == nil and DST_D > delay*self.unitSpeed then
        LastIndex_D = i
        ExDST_D = DST_D-delay*self.unitSpeed
      end
      
      DST = DST+GetDistance(Path2, Path)
      DST_S = DST_S+GetDistance(Path2, Path)
      DST_D = DST_D+GetDistance(Path2, Path)
      self.TotalDST = self.TotalDST+GetDistance(Path2, Path)
    end
    
    if LastIndex_S ~= nil then
      LastIndexPos = Vector(unit:GetPath(LastIndex))
      LastIndexPos2 = Vector(unit:GetPath(LastIndex-1))
      unitPredPos = LastIndexPos+(LastIndexPos2-LastIndexPos):normalized()*ExDST
      LastIndexPos_S = Vector(unit:GetPath(LastIndex_S))
      LastIndexPos_S2 = Vector(unit:GetPath(LastIndex_S-1))
      unitPredPos_S = LastIndexPos_S+(LastIndexPos_S2-LastIndexPos_S):normalized()*ExDST_S
    elseif LastIndex ~= nil then
      LastIndexPos = Vector(unit:GetPath(LastIndex))
      LastIndexPos2 = Vector(unit:GetPath(LastIndex-1))
      unitPredPos = LastIndexPos+(LastIndexPos2-LastIndexPos):normalized()*ExDST
    else
      unitPredPos_E = Vector(unit:GetPath(unit.pathCount))
    end
    
    if LastIndex_D ~= nil then
      LastIndexPos_D = Vector(unit:GetPath(LastIndex_D))
      LastIndexPos_D2 = Vector(unit:GetPath(LastIndex_D-1))
      unitPredPos_D = LastIndexPos_D+(LastIndexPos_D2-LastIndexPos_D):normalized()*ExDST_D
    end
    
  else
    unitPredPos = Vector(unit.x, unit.y, unit.z)
    unitPredPos_S = Vector(unit.x, unit.y, unit.z)
    
    if range == 0 and delay < self.RT then
      unitPredPos_D = Vector(unit.x, unit.y, unit.z)
    end
    
  end
  
  if unitPredPos_S ~= nil then
    CastPos = unitPredPos_S
    
    local SRT_S = self:SpellReactionTime(unit, unitPredPos_S, from, type, delay, range, speed, width, radius, angle)
    
    if SRT_S <= self.RT_S then
    
      SRT_S = math.max(GetLatency()/1000+self.buffer, SRT_S)
      
      if unit.hasMovePath and unit.pathCount >= 2 then
        HitChance = (self.RT_S-SRT_S)/self.RT_S+1
      else
        HitChance = (self.RT_S-SRT_S)/self.RT_S+0.5
      end
      
    end
    
  end
  
  if unitPredPos ~= nil then
  
    if unitPredPos_S == nil then
      CastPos = unitPredPos
    end
    
    local SRT = self:SpellReactionTime(unit, unitPredPos, from, type, delay, range, speed, width, radius, angle)
    
    if SRT <= self.RT then
    
      SRT = math.max(GetLatency()/1000+self.buffer, SRT)
      
      if unit.hasMovePath and unit.pathCount >= 2 then
        CastPos = unitPredPos
        HitChance = (self.RT-SRT)/self.RT+2
      else
        CastPos = unitPredPos
        HitChance = (self.RT-SRT)/self.RT+1.5
      end
      
    end
    
  end
  
  if unitPredPos_E ~= nil then
    CastPos = unitPredPos_E
    
    local SRT_E = self:SpellReactionTime(unit, unitPredPos_E, from, type, delay, range, speed, width, radius, angle)
    
    if SRT_E <= self.TotalDST/self.unitSpeed then
    
      SRT_E = math.max(GetLatency()/1000+self.buffer, SRT_E)
      
      HitChance = (self.TotalDST/self.unitSpeed-SRT_E)/(self.TotalDST/self.unitSpeed)+2
    end
    
  end
  
  if unitPredPos_D ~= nil and (unitPredPos_E == nil or delay <= self.TotalDST/self.unitSpeed) then
    CastPos = unitPredPos_D
    HitChance = 0
    
    local SRT_D = self:SpellReactionTime(unit, unitPredPos_D, from, type, delay, range, speed, width, radius, angle)
    
    if SRT_D <= delay then
    
      SRT_D = math.max(GetLatency()/1000+self.buffer, SRT_D)
      
      if unit.hasMovePath and unit.pathCount >= 2 then
        HitChance = (delay-SRT_D)/delay+2
      else
        HitChance = (delay-SRT_D)/delay+1.5
      end
      
    end
    
  end
  
  --if from.charName == "Xerath" and type == "PromptLine" and os.clock() < self.LastQ+1.5-GetLatency()/2000 and range+unit.boundingRadius < GetDistance(unit, from)+delay*unit.ms then
  if from.charName == "Xerath" and type == "PromptLine" and os.clock() < self.LastQ+1.5-GetLatency()/2000 and range < GetDistance(unit, from)+delay*unit.ms then
    HitChance = 0
  end
  
  if self:SpellReactionTime(unit, unit, from, type, delay, range, speed, width, radius, angle) <= 0 or unit.name == "SRU_Baron12.1.1" then
    CastPos = Vector(unit.x, unit.y, unit.z)
    HitChance = 3
  end
  
  if range == 0 then
  
    if GetDistance(CastPos, from) > radius then
      HitChance = 0
    end
    
    CastPos = Vector(from.x, from.y, from.z)
  else
  
    if type == "DelayLine2" then
    
      if GetDistance(CastPos, from) > range then
        HitChance = 0
        
        if GetDistance(unit, from) <= range then
          unitPredPos_C = self:CircleIntersection(unit, CastPos, from, range)
        else
          return nil, 0, 0
        end
        
      end
      
    elseif GetDistance(CastPos, myHero) > range then
      HitChance = 0
      
      if GetDistance(unit, myHero) <= range then
        unitPredPos_C = self:CircleIntersection(unit, CastPos, myHero, range)
      else
        return nil, 0, 0
      end
      
    end
    
  end
  
  if unitPredPos_C ~= nil then
    CastPos = unitPredPos_C
    
    local SRT_C = self:SpellReactionTime(unit, unitPredPos_C, from, type, delay, range, speed, width, radius, angle)
    local Time_C = GetDistance(unitPredPos_C, unit)/self.unitSpeed
    
    if SRT_C <= Time_C then
    
      SRT_C = math.max(GetLatency()/1000+self.buffer, SRT_C)
      
      HitChance = (Time_C-SRT_C)/Time_C+1
    end
    
  end
  
  if CastPos and (spell.type == "DelayLine" or spell.type == "PromptLine") and self:CollisionStatus(spell, unit, from, CastPos, noh) then
    HitChance = -1
  end
  
  if noh then
    NoH = self:NumberofHits(spell, from, CastPos)
  end
  
  return CastPos, HitChance, NoH
end

---------------------------------------------------------------------------------

function HPrediction:PredictPos(unit, time)

  if IsNilOrFalse(unit) then
    error("PredictPos: unit is nil", 2)
  end
  
  if IsNilOrFalse(unit) then
    error("PredictPos: time is nil", 2)
  end
  
  local unitPredPos
  
  if unit.hasMovePath and unit.pathCount >= 2 then
  
    local unitIndexPos = unit:GetPath(unit.pathIndex)
    
    if unitIndexPos == nil then
      unitIndexPos = unit:GetPath(unit.pathIndex-1)
    end
    
    local DST, ExDST, LastIndex = GetDistance(unitIndexPos, unit), nil, nil
    
    for i = unit.pathIndex, unit.pathCount do
    
      local Path = unit:GetPath(i)
      local Path2 = unit:GetPath(i+1)
      
      if unit.pathCount == i then
        Path2 = unit:GetPath(i)
      end
      
      if LastIndex == nil and DST > time*unit.ms then
        LastIndex = i
        ExDST = DST-time*unit.ms
      end
      
      DST = DST+GetDistance(Path2, Path)
    end
    
    if LastIndex ~= nil then
      LastIndexPos = Vector(unit:GetPath(LastIndex))
      LastIndexPos2 = Vector(unit:GetPath(LastIndex-1))
      unitPredPos = LastIndexPos+(LastIndexPos2-LastIndexPos):normalized()*ExDST
    end
    
  else
    unitPredPos = Vector(unit.x, unit.y, unit.z)
  end
  
  return unitPredPos
end

---------------------------------------------------------------------------------

function HPrediction:SpellReactionTime(unit, unitPredPos, from, type, delay, range, speed, width, radius, angle)

  local SRT = math.huge
  local from = Vector(from)
  
  if type == "DelayCircle" then
    SRT = delay+GetDistance(unitPredPos, from)/speed-radius/self.unitSpeed+GetLatency()/1000+self.buffer
  elseif type == "PromptCircle" then
    SRT = delay-radius/self.unitSpeed+GetLatency()/1000+self.buffer
    
    if range == 0 then
      SRT = SRT+GetDistance(unitPredPos, from)/self.unitSpeed
    end
    
  elseif type == "DelayLine" or type == "DelayLine2" then
  
    if unit.hasMovePath and unit.pathCount >= 2 then
    
      if speed >= self.unitSpeed then
        SRT = delay+math.max(0, GetDistance(unitPredPos, from)-self.unitAddRange)/(speed-self.unitSpeed)-(math.min(width/2, range-GetDistance(unitPredPos, from), GetDistance(unitPredPos, from))+self.unitAddRange)/self.unitSpeed+GetLatency()/1000+self.buffer
      else
        SRT = math.huge
      end
      
    else
      SRT = delay+math.max(0, GetDistance(unitPredPos, from)-self.unitAddRange)/speed-(math.min(width/2, range-GetDistance(unitPredPos, from), GetDistance(unitPredPos, from))+self.unitAddRange)/self.unitSpeed+GetLatency()/1000+self.buffer
    end
    
  elseif type == "PromptLine" then
    SRT = delay-(math.min(width/2, range-GetDistance(unitPredPos, from), GetDistance(unitPredPos, from))+self.unitAddRange)/self.unitSpeed+GetLatency()/1000+self.buffer
  elseif type == "DelayArc" or type == "CircularArc" then
  
    if angle >= 180 then
      print("HPrediction: please use the angle value below 180")
      return
    end
    
    local RotatedPos = from+(unitPredPos-from):HPred_rotateYaxis(angle/2)
    local dist = GetDistance(unitPredPos, VectorPointProjectionOnLine(RotatedPos, from, unitPredPos))
    
    if unit.hasMovePath and unit.pathCount >= 2 then
    
      if speed >= self.unitSpeed then
        SRT = delay+math.max(0, GetDistance(unitPredPos, from)-self.unitAddRange)/(speed-self.unitSpeed)-(math.min(dist, range-GetDistance(unitPredPos, from), GetDistance(unitPredPos, from))+self.unitAddRange)/self.unitSpeed+GetLatency()/1000+self.buffer
      else
        SRT = math.huge
      end
      
    else
      SRT = delay+math.max(0, GetDistance(unitPredPos, from)-self.unitAddRange)/speed-(math.min(dist, range-GetDistance(unitPredPos, from), GetDistance(unitPredPos, from))+self.unitAddRange)/self.unitSpeed+GetLatency()/1000+self.buffer
    end
    
  elseif type == "PromptArc" then
  
    if angle >= 180 then
      print("HPrediction: please use the angle value below 180")
      return
    end
    
    local RotatedPos = from+(unitPredPos-from):HPred_rotateYaxis(angle/2)
    local dist = GetDistance(unitPredPos, VectorPointProjectionOnLine(RotatedPos, from, unitPredPos))
    
    SRT = delay-(math.min(dist, range-GetDistance(unitPredPos, from), GetDistance(unitPredPos, from))+self.unitAddRange)/self.unitSpeed+GetLatency()/1000+self.buffer
  elseif type == "Triangle" then
  
    if angle >= 180 then
      print("HPrediction: please use the angle value below 180")
      return
    end
    
    local RotatedPos = from+(unitPredPos-from):HPred_rotateYaxis(angle/2)
    local dist = GetDistance(unitPredPos, VectorPointProjectionOnLine(RotatedPos, from, unitPredPos))
    
    SRT = delay-(math.min(dist, range-GetDistance(unitPredPos, from), GetDistance(unitPredPos, from))+self.unitAddRange)/self.unitSpeed+GetLatency()/1000+self.buffer
  else
    print("HPrediction: please declare the correct type of spell")
    return
  end
  
  return SRT
end

---------------------------------------------------------------------------------

function HPrediction:NumberofHits(spell, from, CastPos)

  if IsNilOrFalse(spell) then
    error("NumberofHits: spell is nil", 2)
  end
  
  if IsNilOrFalse(from) then
    error("NumberofHits: from is nil", 2)
  end
  
  if IsNilOrFalse(CastPos) then
    error("NumberofHits: CastPos is nil", 2)
  end
  
  local spell = spell.Properties or spell
  local type = spell.type
  local delay = spell.delay
  local speed = spell.speed
  local addmyboundingRadius = spell.addmyboundingRadius
  local addunitboundingRadius = spell.addunitboundingRadius
  local radius = spell.radius
  local angle = spell.angle
  
  local Enemies = {}
  
  if type == "DelayCircle" or type == "PromptCircle" then
  
    local HitTime = 0
    local fromAddRange = from.boundingRadius or myHero.boundingRadius
    
    if type == "DelayCircle" then
      HitTime = HitTime+delay+GetDistance(CastPos, from)/speed
    elseif type == "PromptCircle" then
      HitTime = HitTime+delay
    end
    
    for i, hero in ipairs(self.EnemyHeroes) do
    
      if not self:IsInvincible(hero, HitTime) then
      
        local heroAddRange = hero.boundingRadius
        
        if type == "DelayCircle" or type == "PromptCircle" then
        
          if addmyboundingRadius then
            radius = radius+fromAddRange
          end
          
          if addunitboundingRadius then
            radius = radius+heroAddRange
          end
          
        end
        
        local heroPredPos, heroPredPos_E = nil, nil
        local heroSpeed = hero.ms
        
        if hero.hasMovePath and hero.pathCount >= 2 then
        
          local heroIndexPos = hero:GetPath(hero.pathIndex)
          
          if heroIndexPos == nil then
            heroIndexPos = hero:GetPath(hero.pathIndex-1)
          end
          
          local DST = GetDistance(heroIndexPos, hero)
          local ExDST = nil
          local LastIndex = nil
          
          for i = hero.pathIndex, hero.pathCount do
          
            local Path = hero:GetPath(i)
            local Path2 = hero:GetPath(i+1)
            
            if hero.pathCount == i then
              Path2 = hero:GetPath(i)
            end
            
            if LastIndex == nil and DST > HitTime*heroSpeed then
              LastIndex = i
              ExDST = DST-HitTime*heroSpeed
            end
            
            DST = DST+GetDistance(Path2, Path)
          end
          
          if LastIndex ~= nil then
            LastIndexPos = Vector(hero:GetPath(LastIndex))
            LastIndexPos2 = Vector(hero:GetPath(LastIndex-1))
            heroPredPos = LastIndexPos+(LastIndexPos2-LastIndexPos):normalized()*ExDST
          else
            heroPredPos_E = Vector(hero:GetPath(hero.pathCount))
          end
          
        else
          heroPredPos = Vector(hero.x, hero.y, hero.z)
        end
        
        if heroPredPos_E ~= nil then
        
          if GetDistance(heroPredPos_E, CastPos) <= radius then
            table.insert(Enemies, hero)
          end
          
        else
        
          if GetDistance(heroPredPos, CastPos) <= radius then
            table.insert(Enemies, hero)
          end
          
        end
        
      end
      
    end
    
  elseif type == "DelayLine" or type == "DelayLine2" or type == "PromptLine" then
  
    for i, hero in ipairs(self.EnemyHeroes) do
    
      if not self:IsInvincible(hero) and self:SpellCollision(spell, hero, from, CastPos) then
        table.insert(Enemies, hero)
      end
      
    end
    
  elseif type == "DelayArc" or type == "CircularArc" then
    error("Get NoH of \"DelayArc\" is not supported yet", 2)
    --return
  elseif type == "PromptArc" then
    error("Get NoH of \"PromptArc\" is not supported yet", 2)
    --return
  elseif type == "Triangle" then
    error("Get NoH of \"Triangle\" is not supported yet", 2)
    --return
  end
  
  return #Enemies, Enemies
end

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

function HPrediction:CollisionStatus(spell, unit, from, to, noh)

  if IsNilOrFalse(spell) then
    error("CollisionStatus: spell is nil", 2)
  end
  
  if IsNilOrFalse(unit) then
    error("CollisionStatus: unit is nil", 2)
  end
  
  if IsNilOrFalse(from) then
    error("CollisionStatus: from is nil", 2)
  end
  
  if IsNilOrFalse(to) then
    error("CollisionStatus: to is nil", 2)
  end
  
  local spell = spell.Properties or spell
  local collisionM = spell.collisionM
  local collisionH = spell.collisionH
  
  --[[if self.Menu.Draw.Collision then
    draw = true
  else
    draw = false
  end]]
  
  if collisionM and self:MinionCollisionStatus(spell, unit, from, to, draw) then
    return true
  end
  
  if not noh and collisionH and self:HeroCollisionStatus(spell, unit, from, to, draw) then
    return true
  end
  
  return false
end

---------------------------------------------------------------------------------

function HPrediction:MinionCollisionStatus(spell, unit, from, to, draw)

  for i, minion in ipairs(self.EnemyMinions.objects) do
  
    if self:EachCollision(spell, unit, from, to, minion) then
    
      if draw then
        self.Draw = true
      end
      
      return true
    end
    
  end
  
  for i, junglemob in ipairs(self.JungleMobs.objects) do
  
    if self:EachCollision(spell, unit, from, to, junglemob) then
    
      if draw then
        self.Draw = true
      end
      
      return true
    end
    
  end
  
  self.Draw = false
  return false
end

---------------------------------------------------------------------------------

function HPrediction:HeroCollisionStatus(spell, unit, from, to, draw)

  for i, hero in ipairs(self.EnemyHeroes) do
  
    if self:EachCollision(spell, unit, from, to, hero) then
    
      if draw then
        self.Draw = true
      end
      
      return true
    end
    
  end
  
  self.Draw = false
  return false
end

---------------------------------------------------------------------------------

function HPrediction:EachCollision(spell, unit, from, to, object)

  local spell = spell.Properties or spell
  local type = spell.type
  local delay = spell.delay
  local speed = spell.speed
  local width = spell.width
  
  if type == "PromptLine" then
    speed = math.huge
  end
  
  local objectAddRange = object.boundingRadius+self.Menu.Collision.Buffer
  local objectSpeed = object.ms
  local to = Vector(to)
  
  local Ignore = self.Menu.Ignore and self:PredictHealth(object, delay+(GetDistance(to, from)-objectAddRange)/speed) <= 0
  
  if unit.dead or Ignore or object.dead or unit.networkID == object.networkID or unit.name == "SRU_Baron12.1.1" then
    return false
  end
  
  if object.hasMovePath and object.pathCount >= 2 then
  
    local objectIndexPos = object:GetPath(object.pathIndex)
    
    if objectIndexPos == nil then
      objectIndexPos = object:GetPath(object.pathIndex-1)
    end
    
    if GetDistance(objectIndexPos, object) >= 25 then
    
      local objectEndPos = object+(Vector(objectIndexPos)-object):normalized()*100
      local fromL = from+(to-from):perpendicular():normalized()*width/2
      local fromR = from+(to-from):perpendicular2():normalized()*width/2
      local toL = to+(to-from):perpendicular():normalized()*width/2
      local toR = to+(to-from):perpendicular2():normalized()*width/2
      local Node = VectorIntersection(object, objectEndPos, from, to)
      local NodefromL = VectorIntersection(object, objectEndPos, to, fromL)
      local NodefromR = VectorIntersection(object, objectEndPos, to, fromR)
      local NodetoL = VectorIntersection(object, objectEndPos, from, toL)
      local NodetoR = VectorIntersection(object, objectEndPos, from, toR)
      local nodefromL = nil
      local nodefromR = nil
      local nodetoL = nil
      local nodetoR = nil
      local pointfrom = VectorPointProjectionOnLine(object, objectEndPos, from)
      local pointto = VectorPointProjectionOnLine(object, objectEndPos, to)
      
      if NodefromL then
        nodefromL = Vector(NodefromL.x, myHero.y, NodefromL.y)
        nodetoR = Vector(NodetoR.x, myHero.y, NodetoR.y)
      else
        nodefromL = Vector(math.huge, myHero.y, math.huge)
        nodetoR = Vector(math.huge, myHero.y, math.huge)
      end
      
      if NodefromR then
        nodefromR = Vector(NodefromR.x, myHero.y, NodefromR.y)
        nodetoL = Vector(NodetoL.x, myHero.y, NodetoL.y)
      else
        nodefromR = Vector(math.huge, myHero.y, math.huge)
        nodetoL = Vector(math.huge, myHero.y, math.huge)
      end
      
      local angle = nil
      local angle2 = Vector(object):HPred_angleBetween(objectEndPos, from)*math.pi/180
      local angle3 = Vector(from):HPred_angleBetween(from+objectEndPos-object, to)*math.pi/180
      local angletoL = Vector(from):HPred_angleBetween(from+objectEndPos-object, toL)*math.pi/180
      local angletoR = Vector(from):HPred_angleBetween(from+objectEndPos-object, toR)*math.pi/180
      local anglefromL = to:HPred_angleBetween(to+objectEndPos-object, fromL)*math.pi/180
      local anglefromR = to:HPred_angleBetween(to+objectEndPos-object, fromR)*math.pi/180
      local node = nil
      
      if Node then
        node = Vector(Node.x, myHero.y, Node.y)
        angle = node:HPred_angleBetween(object, from)*math.pi/180
      elseif GetDistance(pointfrom, from) > width/2+objectAddRange or GetDistance(object, pointfrom)-GetDistance(pointto, pointfrom)+math.cos(angle3)/math.abs(math.cos(angle3))*delay*objectSpeed > objectAddRange and speed >= objectSpeed then
        return false
      else
        return true
      end
      
      local t0 = GetDistance(node, object)/objectSpeed
      local T0 = GetDistance(node, from)/speed
      local ds = (width/2+objectAddRange)/math.abs(math.sin(angle))
      local Ds = (width/2+objectAddRange)/math.abs(math.tan(angle))
      
      if math.sin(angle) < 0 then
        t0 = -t0
      end
      
      if math.sin(angle2) > 0 then
        t0 = -t0
        T0 = -T0
      end
      
      if math.sin(angle3) < 0 then
        T0 = -T0
      end
      
      local ts = t0-ds/objectSpeed
      local te = 2*t0-ts
      local Ts = nil
      
      T0 = T0+delay
      
      if math.cos(angle3) > 0 then
        Ts = T0-Ds/speed
      elseif math.cos(angle3) < 0 then
        Ts = T0+Ds/speed
      end
      
      if Ts == nil then
        return true
      end
      
      local Te = 2*T0-Ts
      
      if GetDistance(object, pointto)-GetDistance(pointfrom, pointto) > width/2*math.abs(math.sin(angle))+objectAddRange+math.cos(angle3)/math.abs(math.cos(angle3))*delay*objectSpeed and speed*math.abs(math.cos(angle3)) >= objectSpeed or math.sin(angle2)*math.sin(angle3) >= 0 and math.min(objectAddRange/math.abs(math.sin(anglefromL)), objectAddRange/math.abs(math.sin(anglefromR))) < math.min(GetDistance(nodefromL, to)-GetDistance(fromL, to), GetDistance(nodefromR, to)-GetDistance(fromR, to)) or math.sin(angle2)*math.sin(angle3) < 0 and math.min(objectAddRange/math.abs(math.sin(angletoL)), objectAddRange/math.abs(math.sin(angletoR))) < math.min(GetDistance(nodetoL, from)-GetDistance(toL, from), GetDistance(nodetoR, from)-GetDistance(toR, from)) or Ts < ts or Te > te or math.min(GetDistance(nodetoL, from)-GetDistance(toL, from), GetDistance(nodetoR, from)-GetDistance(toR, from)) > math.min(objectAddRange/math.abs(math.sin(angletoL)), objectAddRange/math.abs(math.sin(angletoR))) then
        return false
      end
      
    end
    
  else
  
    local fromAdd = from+(from-to):normalized()*objectAddRange
    local fromAddL = fromAdd+(to-from):perpendicular():normalized()*(width/2+objectAddRange)
    local fromAddR = fromAdd+(to-from):perpendicular2():normalized()*(width/2+objectAddRange)
    local toAdd = to+(to-from):normalized()*objectAddRange
    local toAddL = toAdd+(to-from):perpendicular():normalized()*(width/2+objectAddRange)
    local toAddR = toAdd+(to-from):perpendicular2():normalized()*(width/2+objectAddRange)
    local angleL = toAddL:HPred_angleBetween(fromAddL, object)
    local angleR = fromAddR:HPred_angleBetween(toAddR, object)
    local angleU = toAddR:HPred_angleBetween(toAddL, object)
    local angleD = fromAddL:HPred_angleBetween(fromAddR, object)
    
    if 0 < angleL and angleL < 180 or 0 < angleR and angleR < 180 or 0 < angleU and angleU < 180 or 0 < angleD and angleD < 180 then
      return false
    end
    
  end
  
  return true
end

---------------------------------------------------------------------------------

function HPrediction:SpellCollision(spell, object, from, to)

  if object.dead then
    return false
  end
  
  local spell = spell.Properties or spell
  local type = spell.type
  local delay = spell.delay
  local speed = spell.speed
  local width = spell.width
  
  local objectAddRange = object.boundingRadius+self.Menu.Collision.Buffer
  local objectSpeed = object.ms
  local to = Vector(to)
  
  if type == "PromptLine" then
    speed = math.huge
  end
  
  if object.hasMovePath and object.pathCount >= 2 then
  
    local objectIndexPos = object:GetPath(object.pathIndex)
    
    if objectIndexPos == nil then
      objectIndexPos = object:GetPath(object.pathIndex-1)
    end
    
    if GetDistance(objectIndexPos, object) >= 25 then
    
      local objectEndPos = object+(Vector(objectIndexPos)-object):normalized()*100
      local fromL = from+(to-from):perpendicular():normalized()*width/2
      local fromR = from+(to-from):perpendicular2():normalized()*width/2
      local toL = to+(to-from):perpendicular():normalized()*width/2
      local toR = to+(to-from):perpendicular2():normalized()*width/2
      local Node = VectorIntersection(object, objectEndPos, from, to)
      local NodefromL = VectorIntersection(object, objectEndPos, to, fromL)
      local NodefromR = VectorIntersection(object, objectEndPos, to, fromR)
      local NodetoL = VectorIntersection(object, objectEndPos, from, toL)
      local NodetoR = VectorIntersection(object, objectEndPos, from, toR)
      local nodefromL = nil
      local nodefromR = nil
      local nodetoL = nil
      local nodetoR = nil
      local pointfrom = VectorPointProjectionOnLine(object, objectEndPos, from)
      local pointto = VectorPointProjectionOnLine(object, objectEndPos, to)
      
      if NodefromL then
        nodefromL = Vector(NodefromL.x, myHero.y, NodefromL.y)
        nodetoR = Vector(NodetoR.x, myHero.y, NodetoR.y)
      else
        nodefromL = Vector(math.huge, myHero.y, math.huge)
        nodetoR = Vector(math.huge, myHero.y, math.huge)
      end
      
      if NodefromR then
        nodefromR = Vector(NodefromR.x, myHero.y, NodefromR.y)
        nodetoL = Vector(NodetoL.x, myHero.y, NodetoL.y)
      else
        nodefromR = Vector(math.huge, myHero.y, math.huge)
        nodetoL = Vector(math.huge, myHero.y, math.huge)
      end
      
      local angle = nil
      local angle2 = Vector(object):HPred_angleBetween(objectEndPos, from)*math.pi/180
      local angle3 = Vector(from):HPred_angleBetween(from+objectEndPos-object, to)*math.pi/180
      local angletoL = Vector(from):HPred_angleBetween(from+objectEndPos-object, toL)*math.pi/180
      local angletoR = Vector(from):HPred_angleBetween(from+objectEndPos-object, toR)*math.pi/180
      local anglefromL = to:HPred_angleBetween(to+objectEndPos-object, fromL)*math.pi/180
      local anglefromR = to:HPred_angleBetween(to+objectEndPos-object, fromR)*math.pi/180
      local node = nil
      
      if Node then
        node = Vector(Node.x, myHero.y, Node.y)
        angle = node:HPred_angleBetween(object, from)*math.pi/180
      elseif GetDistance(pointfrom, from) > width/2+objectAddRange or GetDistance(object, pointfrom)-GetDistance(pointto, pointfrom)+math.cos(angle3)/math.abs(math.cos(angle3))*delay*objectSpeed > objectAddRange and speed >= objectSpeed then
        return false
      else
        return true
      end
      
      local t0 = GetDistance(node, object)/objectSpeed
      local T0 = GetDistance(node, from)/speed
      local ds = (width/2+objectAddRange)/math.abs(math.sin(angle))
      local Ds = (width/2+objectAddRange)/math.abs(math.tan(angle))
      
      if math.sin(angle) < 0 then
        t0 = -t0
      end
      
      if math.sin(angle2) > 0 then
        t0 = -t0
        T0 = -T0
      end
      
      if math.sin(angle3) < 0 then
        T0 = -T0
      end
      
      local ts = t0-ds/objectSpeed
      local te = 2*t0-ts
      local Ts = nil
      
      T0 = T0+delay
      
      if math.cos(angle3) > 0 then
        Ts = T0-Ds/speed
      elseif math.cos(angle3) < 0 then
        Ts = T0+Ds/speed
      end
      
      if Ts == nil then
        return false
      end
      
      local Te = 2*T0-Ts
      
      if GetDistance(object, pointto)-GetDistance(pointfrom, pointto) > width/2*math.abs(math.sin(angle))+objectAddRange+math.cos(angle3)/math.abs(math.cos(angle3))*delay*objectSpeed and speed*math.abs(math.cos(angle3)) >= objectSpeed or math.sin(angle2)*math.sin(angle3) >= 0 and math.min(objectAddRange/math.abs(math.sin(anglefromL)), objectAddRange/math.abs(math.sin(anglefromR))) < math.min(GetDistance(nodefromL, to)-GetDistance(fromL, to), GetDistance(nodefromR, to)-GetDistance(fromR, to)) or math.sin(angle2)*math.sin(angle3) < 0 and math.min(objectAddRange/math.abs(math.sin(angletoL)), objectAddRange/math.abs(math.sin(angletoR))) < math.min(GetDistance(nodetoL, from)-GetDistance(toL, from), GetDistance(nodetoR, from)-GetDistance(toR, from)) or Ts < ts or Te > te or math.min(GetDistance(nodetoL, from)-GetDistance(toL, from), GetDistance(nodetoR, from)-GetDistance(toR, from)) > math.min(objectAddRange/math.abs(math.sin(angletoL)), objectAddRange/math.abs(math.sin(angletoR))) then
        return false
      else
        return true
      end
      
    end
    
  else
  
    local fromAdd = from+(from-to):normalized()*objectAddRange
    local fromAddL = fromAdd+(to-from):perpendicular():normalized()*(width/2+objectAddRange)
    local fromAddR = fromAdd+(to-from):perpendicular2():normalized()*(width/2+objectAddRange)
    local toAdd = to+(to-from):normalized()*objectAddRange
    local toAddL = toAdd+(to-from):perpendicular():normalized()*(width/2+objectAddRange)
    local toAddR = toAdd+(to-from):perpendicular2():normalized()*(width/2+objectAddRange)
    local angleL = toAddL:HPred_angleBetween(fromAddL, object)
    local angleR = fromAddR:HPred_angleBetween(toAddR, object)
    local angleU = toAddR:HPred_angleBetween(toAddL, object)
    local angleD = fromAddL:HPred_angleBetween(fromAddR, object)
    
    if (angleL == 0 or angleL >= 180) and (angleR == 0 or angleR >= 180) and (angleU == 0 or angleU >= 180) and (angleD == 0 or angleD >= 180) then
      return true
    end
    
  end
  
  return false
end

---------------------------------------------------------------------------------

function HPrediction:IsInvincible(enemy, time)

  if enemy and enemy.valid and enemy.team ~= myHero.team and not enemy.dead then
  
    for i=1, enemy.buffCount do
    
      local buff = enemy:getBuff(i)
      --if enemy.charName == "Kindred" and buff then print(buff.name) end
      if buff and buff.name and (buff.name == "ChronoShift" or buff.name == "JudicatorIntervention" or buff.name == "UndyingRage" or buff.name == "VladimirSanguinePool") and GetGameTimer() <= buff.endT+(time or 0) then 
        return true
      end
      
    end
    
  end
  
  return false
end

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

function HPrediction:OnAnimation(unit, animation)

  if unit == nil then
    return
  end

  if self.Menu.Ignore and unit.team == myHero.team and unit.spell ~= nil and unit.spell.target ~= nil and unit.spell.name:find("BasicAttack") then

    if unit.spell.target.networkID < 100 and self.PredictionDamage[unit.spell.target.networkID] == nil then
      self.PredictionDamage[unit.spell.target.networkID] = {}
    end

    if self.PredictionDamage[unit.spell.target.networkID] then

      if unit.type ~= myHero.type and self.ProjectileSpeed[unit.charName] then

        local ctime = GetGameTimer()+unit.spell.windUpTime+GetDistance(unit.spell.target, unit)/self.ProjectileSpeed[unit.charName]

        self.PredictionDamage[unit.spell.target.networkID][ctime] = self:GetAADmg(unit.spell.target, unit)
      else

        local ctime = GetGameTimer()+unit.spell.windUpTime

        self.PredictionDamage[unit.spell.target.networkID][ctime] = self:GetAADmg(unit.spell.target, unit)
      end

    end

  end

end

---------------------------------------------------------------------------------

function HPrediction:OnProcessAttack(unit, spell)

  if unit == nil then
    return
  end

  if self.Menu.Ignore and unit.team == myHero.team and unit.type == myHero.type and spell.target and spell.name:find("BasicAttack") and self.ProjectileSpeed[unit.charName] then

    if spell.target.networkID < 100 and self.PredictionDamage[spell.target.networkID] == nil then
      self.PredictionDamage[spell.target.networkID] = {}
    end

    if self.PredictionDamage[spell.target.networkID] then

      local ctime = GetGameTimer()+GetDistance(spell.target, unit)/self.ProjectileSpeed[unit.charName]

      self.PredictionDamage[spell.target.networkID][ctime] = self:GetAADmg(spell.target, unit)
    end

  end

end

---------------------------------------------------------------------------------

function HPrediction:PredictHealth(unit, time)

  local health = unit.health

  if self.PredictionDamage[unit.networkID] then

    local Delete = true

    for ctime, damage in pairs(self.PredictionDamage[unit.networkID]) do

      if GetGameTimer()+GetLatency()/2000 < ctime-GetLatency()/2000 then
        Delete = false
        break
      end

    end

    if Delete then
      self.PredictionDamage[unit.networkID] = nil
    else

      for ctime, damage in pairs(self.PredictionDamage[unit.networkID]) do
      
        if GetGameTimer()+GetLatency()/2000 >= ctime-GetLatency()/2000 then
          self.PredictionDamage[unit.networkID][ctime] = nil
        elseif GetGameTimer()+GetLatency()/2000+time > ctime+0.09-GetLatency()/2000 then --Temp 0.075
          health = health-damage
        end

      end

    end

  end

  return health
end

---------------------------------------------------------------------------------

function HPrediction:GetAADmg(enemy, ally)

  local Armor = math.max(0, enemy.armor*ally.armorPenPercent-ally.armorPen)
  local ArmorPercent = Armor/(100+Armor)
  local TrueDmg = ally.totalDamage*(1-ArmorPercent)

  return TrueDmg
end

---------------------------------------------------------------------------------

function HPrediction:OnUpdateBuff(unit, buff, stacks)

  if unit ~= myHero then
    return
  end
  
  if buff.name == "XerathArcanopulseChargeUp" then
    self.LastQ = os.clock()-GetLatency()/2000
    self.OnQ = true
  else
    --print("Buff: "..buff.name)
  end
  
end

---------------------------------------------------------------------------------

function HPrediction:OnRemoveBuff(unit, buff)

  if unit ~= myHero then
    return
  end
  
  if buff.name == "XerathArcanopulseChargeUp" then
    self.OnQ = false
  else
    --print("Delete: "..buff.name)
  end
  
end

---------------------------------------------------------------------------------

function HPrediction:Level(spell)
  return myHero:GetSpellData(spell).level
end

---------------------------------------------------------------------------------

function HPrediction:NewSkillshot(SpellData)
  return HPSkillshot(SpellData)
end

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

class("HPSkillshot")

function HPSkillshot:__init(properties)

  assert(properties, self.ErrorMessage("Properties nil."))
  
  self.Properties = {}
  self.Properties.Raw = {}
  
  setmetatable(self.Properties, self:__CreateMetaTable())
  
  for name, value in pairs(properties) do
    self:SetProperty(name:lower(), value)
  end
  
end

---------------------------------------------------------------------------------

function HPSkillshot.ErrorMessage(text)
  return "<font color='FFC117'>HPSkillshot: </font><font color='FFFFFF'>"..text.."</font>"
end

---------------------------------------------------------------------------------

function HPSkillshot:__CreateMetaTable()

  local mtbl = {}
  
  function mtbl.__index(obj, key)
  
    key = key:lower()
    local value = self.Properties.Raw[key]
    
    if type(value) == "function" then
      return value()
    end
    
    return value
  end
  
  function mtbl.__newindex(obj, key, value)
    self:SetProperty(key, value)
  end
  
  function mtbl.__metatable()
  end
  
  return mtbl
end

---------------------------------------------------------------------------------

function HPSkillshot:SetProperty(name, value)

  assert(name, self.ErrorMessage("SetProperty field 'name' is nil."))
  
  if value == nil then
    assert(value, self.ErrorMessage("SetProperty field 'value' is nil."))
  end
  
  self.Properties.Raw[name:lower()] = value
end

---------------------------------------------------------------------------------

function HPSkillshot.__tostring()
  return self.Properties["Type"]
end

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

function HPrediction:Level(spell)
  return myHero:GetSpellData(spell).level
end

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

_G.HPrediction.Presets = {}

_G.HPrediction.Presets["Ahri"] = 
{
  ["Q"] = HPSkillshot({type = "DelayLine", delay = 0.25, range = 900, speed = 950, width = 200, IsVeryLowAccuracy = true}),
  ["E"] = HPSkillshot({type = "DelayLine", delay = 0.25, range = 1000, speed = 1570, collisionM = true, collisionH = true, width = 120})
}
_G.HPrediction.Presets["Blitzcrank"] = 
{
  ["Q"] = HPSkillshot({type = "DelayLine", delay = 0.25, range = 1050, speed = 1800, collisionM = true, collisionH = true, width = 140}),
  ["R"] = HPSkillshot({type = "PromptCircle", delay = 0.25, range = 0, radius = 600})
}
_G.HPrediction.Presets["Cassiopeia"] = 
{
  ["Q"] = HPSkillshot({type = "PromptCircle", delay = 0.7, range = 850, radius = 200}),
  ["W"] = HPSkillshot({type = "DelayCircle", delay = 0.25, range = 850, radius = 147, speed = 2500}),
  ["R"] = HPSkillshot({type = "Triangle", delay = 0.6, range = 825, angle = 80})
}
_G.HPrediction.Presets["Corki"] = 
{
  ["Q"] = HPSkillshot({type = "DelayCircle", delay = 0.75, range = 825, speed = 1500, radius = 270}),
  ["R"] = HPSkillshot({type = "DelayLine", delay = 0.25, range = 1300, speed = 2000, collisionM = true, collisionH = true, width = 80})
}
_G.HPrediction.Presets["DrMundo"] = 
{
  ["Q"] = HPSkillshot({type = "DelayLine", delay = 0.25, range = 1050, speed = 2000, collisionM = true, collisionH = true, width = 120})
}
_G.HPrediction.Presets["Evelynn"] = 
{
  ["R"] = HPSkillshot({type = "PromptCircle", delay = 0.25, range = 900, radius = 500})
}
_G.HPrediction.Presets["Ezreal"] = 
{
  ["Q"] = HPSkillshot({type = "DelayLine", delay = 0.25, range = 1200, speed = 2000, collisionM = true, collisionH = true, width = 120}),
  ["W"] = HPSkillshot({type = "DelayLine", delay = 0, range = 1050, speed = 1600, width = 160}),
  ["R"] = HPSkillshot({type = "DelayLine", delay = 1, range = math.huge, speed = 2000, width = 320, IsVeryLowAccuracy = true})
}
_G.HPrediction.Presets["Karthus"] = 
{
  ["Q"] = HPSkillshot({type = "PromptCircle", delay = 1.1, range = 875, radius = 200, IsLowAccuracy = true}),
  ["E"] = HPSkillshot({type = "PromptCircle", delay = 0, range = 0, radius = 550})
}
_G.HPrediction.Presets["Lux"] = 
{
  ["Q"] = HPSkillshot({type = "DelayLine", delay = 0.25, range = 1300, speed = 1200, collisionM = true, collisionH = true, width = 140}),
  ["E"] = HPSkillshot({type = "DelayCircle", delay = 0.25, range = 1100, speed = 1300, radius = 350}),
  ["E2"] = HPSkillshot({type = "PromptCircle", delay = 0, range = 0, radius = 350}),
  ["R"] = HPSkillshot({type = "PromptLine", delay = 1.012, range = 3300, width = 380})
}
_G.HPrediction.Presets["Morgana"] = 
{
  ["Q"] = HPSkillshot({type = "DelayLine", delay = 0.25, range = 1300, speed = 1200, collisionM = true, collisionH = true, width = 140}),
  ["W"] = HPSkillshot({type = "PromptCircle", delay = 0.25, range = 900, radius = 280})
}
_G.HPrediction.Presets["Nidalee"] = 
{
  ["Q"] = HPSkillshot({type = "DelayLine", delay = 0.25, range = 1500, speed = 1300, collisionM = true, collisionH = true, width = 80, IsLowAccuracy = true}),
  ["W"] = HPSkillshot({type = "PromptCircle", delay = 1.75, range = 900, radius = 80, IsVeryLowAccuracy = true})
}
_G.HPrediction.Presets["Orianna"] = 
{
  ["Q"] = HPSkillshot({type = "DelayCircle", delay = 0, range = 825, radius = 175, speed = 1200}),
  ["W"] = HPSkillshot({type = "PromptCircle", delay = 0, range = 0, radius = 225}),
  ["E"] = HPSkillshot({type = "DelayLine", delay = 0, speed = 1800, width = 80}),
  ["R"] = HPSkillshot({type = "PromptCircle", delay = 0.5, range = 0, radius = 350})
}
_G.HPrediction.Presets["Rengar"] = 
{
  ["W"] = HPSkillshot({type = "PromptCircle", delay = 0, range = 0, radius = 300})
}
_G.HPrediction.Presets["Riven"] = 
{
  ["R"] = HPSkillshot({type = "DelayArc", delay = 0.25, range = 1075, speed = 1600, angle = 45}) --idk
}
_G.HPrediction.Presets["Syndra"] = 
{
  ["Q"] = HPSkillshot({type = "PromptCircle", delay = 0.75--[[0.65]], range = 800, radius = 210}),
  ["W"] = HPSkillshot({type = "DelayCircle", delay = 0.25, range = 950, speed = 1450, radius = 200}),
  ["E"] = HPSkillshot({type = "DelayArc", delay = 0.25, range = 700, speed = 2500, angle = 20})
}
_G.HPrediction.Presets["Viktor"] = 
{
  ["W"] = HPSkillshot({type = "PromptCircle", delay = 1+0.6, range = 700, radius = function() return 325*(100/(100-(4*HPrediction:Level(_W)+24))) end, IsVeryLowAccuracy = true}),
  ["E"] = HPSkillshot({type = "DelayLine2", delay = 0, range = 700, speed = 790, width = 180})
}
_G.HPrediction.Presets["Vladimir"] = 
{
  ["E"] = HPSkillshot({type = "PromptCircle", delay = 0.25, range = 0, radius = 620})
}
_G.HPrediction.Presets["Xerath"] = 
{
  ["Q"] = HPSkillshot({type = "PromptLine", delay = 0.55, range = 750, width = 200}),
  ["W"] = HPSkillshot({type = "PromptCircle", delay = 0.8, range = 1000, radius = 275}),
  ["E"] = HPSkillshot({type = "DelayLine", delay = 0.25, range = 1125, speed = 1400, collisionM = true, collisionH = true, width = 140}),
  ["R"] = HPSkillshot({type = "PromptCircle", delay = 0.25, radius = 190})
}
_G.HPrediction.Presets["Zed"] = 
{
  ["Q"] = HPSkillshot({type = "DelayLine", delay = 0.25, range = 925, speed = 1700, width = 90})
}
