if myHero.charName ~= 'Ashe' then return end

function Print(text, isError)
	if isError then
		print('<font color=\'#0099FF\'>[PewAshe] </font> <font color=\'#FF0000\'>'..text..'</font>')	
		return
	end
	print('<font color=\'#0099FF\'>[PewAshe] </font> <font color=\'#FF6600\'>'..text..'</font>')
end

function NormalizeX(v1, v2, length)
	local x, z = v1.x - v2.x, v1.z - v2.z
    local nLength  = math.sqrt(x * x + z * z)
	return { ['x'] = v2.x + ((x / nLength) * length), ['z'] = v2.z + ((z / nLength) * length)} 
end

local HP, HP_W, Menu
local Enemies = {}
local Channels = {
	['FiddleSticks'] = {
		['crowstorm'] = 'Fiddlesticks: Crowstorm [R]',
	},
	['Galio'] = {
		['galioidolofdurand'] = 'Galio: Idol of Durand [R]',
	},
	['Jhin'] = {
		['jhinrshot'] = 'Jhin: Curtain Call [R]',
	},
	['Karthus'] = {
		['fallenone'] = 'Karthus: Requiem [R]',
	},
	['Katarina'] = {
		['katarinar'] = 'Katarina: Death Lotus [R]',
	},
	['Lucian'] = {
		['lucianr'] = 'Lucian: The Culling [R]'
	},
	['Malzahar'] = {
		['alzaharnethergrasp'] = 'Malzahar: Nether Grasp [R]',
	},
	['MissFortune'] = {
		['missfortunebullets'] = 'Miss Fortune: Bullet Time [R]',
	},
	['Nunu'] = {
		['absolutezero'] = 'Nunu: Absolute Zero [R]',
	},
	['Pantheon'] = {
		['pantheonrjump'] = 'Pantheon: Grand Skyfall [R]',
	},
	['Velkoz'] = {
		['velkozr'] = 'Vel\'Koz: Lifeform Disintegration Beam [R]',
	},
}
if FileExist(LIB_PATH..'/HPrediction.lua') then
	Print('Succesfully Loaded.')
	require('HPrediction')
	HP = HPrediction()
	HP_W = HPSkillshot({type = 'DelayLine', delay = 0.25, range = 1200, width = 40, speed = 1600, collisionM = true,})
	HP_R = HPSkillshot({type = 'DelayLine', delay = 0.25, range = 1200, width = 260, speed = 1500, })
else
	Print('HPrediction required, please download manually!', true)
	return
end

Menu = scriptConfig('PewAshe', 'PewAshe')
Menu:addParam('space', '', SCRIPT_PARAM_INFO, '') 
Menu:addParam('info', 'Uses Pewalks hotkeys.', SCRIPT_PARAM_INFO, '') 
Menu:addParam('space', '', SCRIPT_PARAM_INFO, '') 
Menu:addParam('info', '-Ranger\'s Focus-', SCRIPT_PARAM_INFO, '') 
Menu:addParam('CarryQ', 'Use in Carry Mode', SCRIPT_PARAM_ONOFF, true)
Menu:addParam('ClearQ', 'Use in Skill Lane Clear', SCRIPT_PARAM_ONOFF, true)

Menu:addParam('space', '', SCRIPT_PARAM_INFO, '') 
Menu:addParam('info', '-Volley-', SCRIPT_PARAM_INFO, '') 
Menu:addParam('CarryW', 'Use in Carry Mode', SCRIPT_PARAM_ONOFF, true)
Menu:addParam('MixedW', 'Harass in Mixed Mode', SCRIPT_PARAM_ONOFF, true)
Menu:addParam('ClearW', 'Harass in Lane Clear', SCRIPT_PARAM_ONOFF, true)
Menu:addParam('HarassMana', 'Minimum Harass Mana', SCRIPT_PARAM_SLICE, 40, 0, 100)

Menu:addParam('space', '', SCRIPT_PARAM_INFO, '') 
Menu:addParam('info', '-Hawkshot-', SCRIPT_PARAM_INFO, '')
Menu:addParam('LoseVision', 'Use on lose vision of killable target.', SCRIPT_PARAM_ONOFF, true)
Menu:addParam('info', '(While in Carry Mode only!)', SCRIPT_PARAM_INFO, '')

Menu:addParam('space', '', SCRIPT_PARAM_INFO, '') 
Menu:addParam('info', '-Enchanted Crystal Arrow-', SCRIPT_PARAM_INFO, '')
Menu:addParam('CastR', 'Cast Key', SCRIPT_PARAM_ONKEYDOWN, false, ('C'):byte())
Menu:addParam('MaxRange', 'Max Target Range', SCRIPT_PARAM_SLICE, 1100, 500, 3000)
Menu:addSubMenu('Channels', 'Channels')
Menu.Channels:addParam('info', 'Auto Cast R to break Channels', SCRIPT_PARAM_INFO, '') 
Menu.Channels:addParam('space', '', SCRIPT_PARAM_INFO, '') 
for charName, channel in pairs(Channels) do
	for spellName, menuName in pairs(channel) do
		Menu.Channels:addParam(spellName, menuName, SCRIPT_PARAM_ONOFF, true) 
	end
end

AddLoadCallback(function()
	local version = 0.02
	for i=1, heroManager.iCount do
		local h = heroManager:getHero(i)
		if h and h.team~=myHero.team then
			Enemies[#Enemies+1] = h
		end
	end
	DelayAction(function()
		if _Pewalk.AddAfterAttackCallback then 
			_Pewalk.AddAfterAttackCallback(function(target)
				local AM = _Pewalk.GetActiveMode()
				if target.type == 'AIHeroClient' and AM.Carry and Menu.CarryQ then
					if myHero:CanUseSpell(_Q) == READY then
						if _Pewalk.ValidTarget(target,myHero.range+myHero.boundingRadius,true) then
							CastSpell(_Q)
						end
					end
				elseif target.type == 'obj_AI_Minion' and AM.SkillClear and Menu.ClearQ then
					if myHero:CanUseSpell(_Q) == READY then
						CastSpell(_Q)
					end					
				end
			end)
		else
			Print('Pewalk not found!', true)
		end
	end, 2)

	ScriptUpdate(
		version,
		true, 
		'raw.githubusercontent.com', 
		'/PewPewPew2/BoL/master/Versions/PewAshe.version', 
		'/PewPewPew2/BoL/master/PewAshe.lua', 
		SCRIPT_PATH.._ENV.FILE_NAME, 
		function() Print('Update Complete. Please reload. (F9 F9)') end, 
		function() Print('Loaded latest version. v'..version..'.') end, 
		function() Print('New version found, downloading now...') end,
		function() Print('There was an error during update.') end
	)
end)

AddTickCallback(function()
	for i=1, #Enemies do
		if Enemies[i].dead or Enemies[i].visible then
			Enemies[i].inFoW = nil
		elseif not Enemies[i].inFoW then
			Enemies[i].inFoW = os.clock()
		end
	end

	local AM = _Pewalk.GetActiveMode()
	if AM.Carry and _Pewalk.CanMove() then
		if Menu.CarryW then
			CastW()
		end
		if myHero:CanUseSpell(_E) == READY then
			for i=1, #Enemies do
				local e = Enemies[i]
				if not e.dead and not e.visible and e.inFoW and os.clock() - e.inFoW < 2 then
					if e.health / e.maxHealth < 20 and GetDistanceSqr(e) < 1440000 then
						local p = NormalizeX(e.endPath, e, 100)
						if IsWallOfGrass(D3DXVECTOR3(p.x,e.y,p.z)) or CalculatePath(myHero,D3DXVECTOR3(p.x,e.y,p.z)).count > 3 then
							CastSpell(_E, e.x, e.z)
						end					
					end
				end
			end
		end
		if myHero:CanUseSpell(_R) == READY and Menu.CastR then
			local t = _Pewalk.GetTarget(Menu.MaxRange)
			if t then
				local CP, HC = HP:GetPredict(HP_R, t, myHero)
				if CP and HC > -1 then
					CastSpell(_R, CP.x, CP.z)
				end			
			end
		end
	elseif (AM.LaneClear and Menu.ClearW) or (AM.Mixed and Menu.MixedW) then
		if myHero.mana / myHero.maxMana > Menu.HarassMana * .01 then
			CastW()
		end
	end
end)

AddAnimationCallback(function(unit,animation)
	if unit.valid and unit.type == 'AIHeroClient' and unit.team ~= myHero.team and Channels[unit.charName] then		
		if myHero:CanUseSpell(_R) == READY and unit.spell and Channels[unit.charName][unit.spell.name:lower()] then
			if Menu.Channels[unit.spell.name:lower()] and GetDistanceSqr(unit) < 1000000 then
				CastSpell(_R, unit.x, unit.z)
			end
		end
	end
end)

function CastW()
	if myHero:CanUseSpell(_W) == READY then
		local t = _Pewalk.GetTarget(1000,true)
		if t then
			local CP, HC = HP:GetPredict(HP_W, t, myHero)
			if CP and HC > -1 then
				CastSpell(_W, CP.x, CP.z)
			end
		end
	end
end

class "ScriptUpdate"
function ScriptUpdate:__init(LocalVersion,UseHttps, Host, VersionPath, ScriptPath, SavePath, CallbackUpdate, CallbackNoUpdate, CallbackNewVersion,CallbackError)
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

function ScriptUpdate:print(str)
    print('<font color="#FFFFFF">'..os.clock()..': '..str)
end

function ScriptUpdate:OnDraw()
    if self.DownloadStatus ~= 'Downloading Script (100%)' and self.DownloadStatus ~= 'Downloading VersionInfo (100%)'then
        DrawText('Download Status: '..(self.DownloadStatus or 'Unknown'),50,10,50,ARGB(0xFF,0xFF,0xFF,0xFF))
    end
end

function ScriptUpdate:CreateSocket(url)
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

function ScriptUpdate:Base64Encode(data)
    local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    return ((data:gsub('.', function(x)
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end

function ScriptUpdate:GetOnlineVersion()
    if self.GotScriptVersion then return end

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
            if ScriptEnd then ScriptEnd = ScriptEnd - 1 end
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
            self.OnlineVersion = (Base64Decode(self.File:sub(ContentStart + 1,ContentEnd-1)))
            self.OnlineVersion = tonumber(self.OnlineVersion)
            if self.OnlineVersion and self.OnlineVersion > self.LocalVersion then
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

function ScriptUpdate:DownloadUpdate()
    if self.GotScriptUpdate then return end
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
            if ScriptEnd then ScriptEnd = ScriptEnd - 1 end
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
