--[[


 			Doctor Tools
		SCRIPT BY DrPhoenix


Changelog :
	1.01 : First release
	1.02 : - Change each champion skin
	       - Cleanse support
	       - Potion support
	1.03 : Mastery Emote on Kill is back !
	1.04 : CS information
	1.05 : - Zhonya supported
		   - Last Hit helper
		   - Bug fixing
	1.06 : Smite Herald, Dragon, Nashor
	1.07 : Update the updater !
	1.08 : Fix the zonia :)
	
	More Soon !

]]--

version = 1.08

assert(load(Base64Decode("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"), nil, "bt", _ENV))()
TrackerLoad("NpnWbxiqjE5ZQBof")

SAVE_PATH = LIB_PATH.."\\Saves\\"
kills = 0
assists = 0
farmcolor = ARGB(255,3,229,0)
jungleMinions = minionManager(MINION_JUNGLE, 560, myHero, MINION_SORT_MINHEALTH_DEC)
PotionsItemsList = {
	HPT = { id = 2003, slot = nil }, -- Health Potion
	RPT = { id = 2031, slot = nil }, -- Refillable Potion
	HPT = { id = 2032, slot = nil }, -- Hunter's Potion
	CPT = { id = 2033, slot = nil }, -- Corrupting Potion
	BR1 = { id = 2009, slot = nil }, -- Total Biscuit of Rejuvenation 1
	BR2 = { id = 2010, slot = nil }, -- Total Biscuit of Rejuvenation 2
}
DefensiveItemsList = {
	QSS = { id = 3140, slot = nil }, -- Quicksilver Sash
	MCS = { id = 3139, slot = nil }, -- Mercurial Scimitar
}
local Game = {}
for i = 1, objManager.maxObjects do
	local object = objManager:getObject(i)
	if object and object.valid and object.type == "obj_HQ" then
		if object.name:find("1") then
			Game[myHero.team == 100 and "MyNexus" or "TheirNexus"] = object
		elseif object.name:find("2") then
			Game[myHero.team == 200 and "MyNexus" or "TheirNexus"] = object
		end
	end
end

function OnLoad()
	if myHero:GetSpellData(SUMMONER_1).name:find("Smite") then SmitePos = SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("Smite") then SmitePos = SUMMONER_2 end
	if myHero:GetSpellData(SUMMONER_1).name:find("SummonerBoost") then CleansePos = SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("SummonerBoost") then CleansePos = SUMMONER_2 end
	Update()
	AddMenu()
	SetSkin(myHero, Menu.SkinChanger.SkinChangerAlly.HeroSkin)
	if file_exists(SAVE_PATH.."DoctorTools_TotalFarm.txt") then
		SaveFile = io.open(SAVE_PATH.."DoctorTools_TotalFarm.txt", "r")
		totalfarm = SaveFile:read()
		SaveFile:close()
	else
		totalfarm = 0
	end
	if MinionsKilled() == 0 or totalfarm == "0" then
		farm = 100
	else
		farm = math.round(MinionsKilled() / totalfarm * 100)
	end
	PrintMsg("Loaded !")
end

function AddMenu()
	Menu = scriptConfig("Doctor Tools", "Menu")

	Menu:addParam("EmoteON", "Emote on kill", SCRIPT_PARAM_ONOFF, true)

	Menu:addSubMenu("Last Hit Helper", "LastHit")
		Menu.LastHit:addParam("LastHitON", "Activate", SCRIPT_PARAM_ONOFF, true)

	Menu:addSubMenu("Farm Informations", "FarmInfo")
		Menu.FarmInfo:addParam("FarmInfoON", "Activate", SCRIPT_PARAM_ONOFF, true)
		Menu.FarmInfo:addParam("FarmInfoMode", "Draw Mode", SCRIPT_PARAM_LIST, 1, {"Full", "Percent only", "Farm only", "Missed CS"})
		Menu.FarmInfo:addParam("FarmInfoSize", "Text Size", SCRIPT_PARAM_SLICE, 12, 0, 50, 0)
		Menu.FarmInfo:addParam("FarmInfoY", "Vertical Position", SCRIPT_PARAM_SLICE, 50, 0, WINDOW_H - 50, 0)
		Menu.FarmInfo:addParam("FarmInfoX", "Horizontal Position", SCRIPT_PARAM_SLICE, 50, 0, WINDOW_W - 100, 0)

	Menu:addSubMenu("Jungle settings", "Jungle")
		Menu.Jungle:addParam("SmiteON", "Use smite", SCRIPT_PARAM_ONOFF, true)
		Menu.Jungle:addParam("DrawSmiteON", "Draw smite range", SCRIPT_PARAM_ONOFF, true)
	
	Menu:addSubMenu("Skin Changer", "SkinChanger")
		Menu.SkinChanger:addSubMenu("My team skins", "SkinChangerAlly")
			Menu.SkinChanger.SkinChangerAlly:addParam("HeroSkin", "Change "..myHero.charName.." Skin", SCRIPT_PARAM_SLICE, 0, 0, 20, 0)
			Menu.SkinChanger.SkinChangerAlly:setCallback("HeroSkin", function(Val) SetSkin(myHero, Val - 1) end)
			for i, hero in pairs(GetAllyHeroes()) do
				Menu.SkinChanger.SkinChangerAlly:addParam("Ally"..i.."Skin", "Change "..hero.charName.." Skin", SCRIPT_PARAM_SLICE, 0, 0, 20, 0)
				Menu.SkinChanger.SkinChangerAlly:setCallback("Ally"..i.."Skin", function(Val) SetSkin(hero, Val - 1) end)
			end
		Menu.SkinChanger:addSubMenu("Enemy team skins", "SkinChangerEnemy")
			for i, hero in pairs(GetEnemyHeroes()) do
				Menu.SkinChanger.SkinChangerEnemy:addParam("Enemy"..i.."Skin", "Change "..hero.charName.." Skin", SCRIPT_PARAM_SLICE, 0, 0, 20, 0)
				Menu.SkinChanger.SkinChangerEnemy:setCallback("Enemy"..i.."Skin", function(Val) SetSkin(hero, Val - 1) end)
			end
	
	Menu:addSubMenu("Potions", "Potions")
		Menu.Potions:addParam("PotionsON", "Use potions", SCRIPT_PARAM_ONOFF, true)
		Menu.Potions:addParam("PotionsHealth", "Use potions at %", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
	
	Menu:addSubMenu("Zhonya", "Zhonya")
		Menu.Zhonya:addParam("ZhonyaON", "Use Zhonya", SCRIPT_PARAM_ONOFF, true)
		Menu.Zhonya:addParam("ZhonyaHealth", "Use Zhonya at %", SCRIPT_PARAM_SLICE, 10, 0, 100, 0)
	
	Menu:addSubMenu("QSS", "QSS")
		Menu.QSS:addParam("","", 5, "")
		Menu.QSS:addParam("Cleanse", "Use Cleanse", SCRIPT_PARAM_ONOFF, true)
		Menu.QSS:addParam("","", 5, "")
		Menu.QSS:addParam("Stun", "Remove stun", SCRIPT_PARAM_ONOFF, true)
		Menu.QSS:addParam("Silence", "Remove silence", SCRIPT_PARAM_ONOFF, true)
		Menu.QSS:addParam("Taunt", "Remove taunt", SCRIPT_PARAM_ONOFF, true)
		Menu.QSS:addParam("Root", "Remove root", SCRIPT_PARAM_ONOFF, true)
		Menu.QSS:addParam("Fear", "Remove fear", SCRIPT_PARAM_ONOFF, true)
		Menu.QSS:addParam("Charm", "Remove charm", SCRIPT_PARAM_ONOFF, true)
		Menu.QSS:addParam("Suppression", "Remove suppression", SCRIPT_PARAM_ONOFF, true)
		Menu.QSS:addParam("Blind", "Remove blind", SCRIPT_PARAM_ONOFF, true)
		Menu.QSS:addParam("KnockUp", "Remove knock up", SCRIPT_PARAM_ONOFF, true)
		Menu.QSS:addParam("Exhaust", "Remove exhaust", SCRIPT_PARAM_ONOFF, true)
		Menu.QSS:addSubMenu("Humanizer", "QSSHumanizer")
			Menu.QSS.QSSHumanizer:addParam("QSSHumanizerON", "Use humanizer", SCRIPT_PARAM_ONOFF, true)
			Menu.QSS.QSSHumanizer:addParam("QSSHumanizerMinValue", "Min Value", SCRIPT_PARAM_SLICE, 100, 0, 1000, 0)
			Menu.QSS.QSSHumanizer:addParam("QSSHumanizerMaxValue", "Max Value", SCRIPT_PARAM_SLICE, 200, 0, 1000, 0)
				Menu.QSS.QSSHumanizer:setCallback("QSSHumanizerMinValue", function (value) if value < Menu.QSS.QSSHumanizer.QSSHumanizerMinValue then Menu.QSS.QSSHumanizer.QSSHumanizerMaxValue = Menu.QSS.QSSHumanizer.QSSHumanizerMinValue end end)
				Menu.QSS.QSSHumanizer:setCallback("QSSHumanizerMaxValue", function (value) if value > Menu.QSS.QSSHumanizer.QSSHumanizerMaxValue then Menu.QSS.QSSHumanizer.QSSHumanizerMinValue = Menu.QSS.QSSHumanizer.QSSHumanizerMaxValue end end)
end

function PrintMsg(msg)
	PrintChat("<font color=\"#6eed00\"><b>[</b></font><font color=\"#a2ed00\"><b>Doctor Tools</b></font><font color=\"#6eed00\"><b>]</b></font> <font color=\"#fce700\">"..msg.."</font>")
end

function OnTick()
	if Menu.Potions.PotionsON and myHero.health / myHero.maxHealth * 100 < Menu.Potions.PotionsHealth then
		for _, item in pairs(PotionsItemsList) do
			item.slot = GetInventorySlotItem(item.id)
			if item.slot ~= nil then
				CastSpell(item.slot)
			end
		end
	end
	
	if Menu.Zhonya.ZhonyaON and myHero.health / myHero.maxHealth * 100 < Menu.Zhonya.ZhonyaHealth then
		if GetInventorySlotItem(3157) ~= nil then
			CastSpell(GetInventorySlotItem(3157))
		end
	end
	
	jungleMinions:update()
	CheckJungle()
end

function OnDraw()
	if SmitePos ~= nil and Menu.Jungle.DrawSmiteON and myHero:CanUseSpell(SmitePos) and not myHero.dead then
		DrawCircle3D(myHero.x, myHero.y, myHero.z, 560, 1, RGB(255,130,0), 50)
	end
	
	if Menu.FarmInfo.FarmInfoON then
		if Menu.FarmInfo.FarmInfoMode == 1 then
			DrawText(farm.." % ("..MinionsKilled().."/"..totalfarm..")", Menu.FarmInfo.FarmInfoSize, Menu.FarmInfo.FarmInfoX, Menu.FarmInfo.FarmInfoY, farmcolor)
		elseif Menu.FarmInfo.FarmMode == 2 then
			DrawText(farm.." %", Menu.FarmInfo.FarmInfoSize, Menu.FarmInfo.FarmInfoX, Menu.FarmInfo.FarmInfoY, farmcolor)
		elseif Menu.FarmInfo.FarmMode == 3 then
			DrawText(MinionsKilled().."/"..totalfarm, Menu.FarmInfo.FarmInfoSize, Menu.FarmInfo.FarmInfoX, Menu.FarmInfo.FarmInfoY, farmcolor)
		elseif Menu.FarmInfo.FarmMode == 4 then
			DrawText(farmmissed, Menu.FarmInfo.FarmInfoSize, Menu.FarmInfo.FarmInfoX, Menu.FarmInfo.FarmInfoY, farmcolor)
		end
	end
	
	if Menu.LastHit.LastHitON then
		for _, minion in pairs(minionManager(MINION_ENEMY, 1000, myHero, MINION_SORT_MINHEALTH_DEC).objects) do
			if minion.health < myHero.totalDamage then
				DrawCircle3D(minion.x, minion.y, minion.z, 43, 3, ARGB(255,3,229,0), 100)
				DrawCircle3D(minion.x, minion.y, minion.z, 25, 3, ARGB(255,3,229,0), 100)
				DrawLine3D(minion.x + 30, minion.y, minion.z + 30, minion.x - 30, minion.y, minion.z - 30, 3, ARGB(255,3,229,0))
				DrawLine3D(minion.x + 30, minion.y, minion.z - 30, minion.x - 30, minion.y, minion.z + 30, 3, ARGB(255,3,229,0))
			elseif minion.health < myHero.totalDamage * 2 then
				DrawCircle3D(minion.x, minion.y, minion.z, 43, 3, ARGB(255,229,145,0), 100)
				DrawCircle3D(minion.x, minion.y, minion.z, 25, 3, ARGB(255,229,145,0), 100)
				DrawLine3D(minion.x + 30, minion.y, minion.z + 30, minion.x - 30, minion.y, minion.z - 30, 3, ARGB(255,229,145,0))
				DrawLine3D(minion.x + 30, minion.y, minion.z - 30, minion.x - 30, minion.y, minion.z + 30, 3, ARGB(255,229,145,0))
			elseif minion.health < myHero.totalDamage * 3 then
				DrawCircle3D(minion.x, minion.y, minion.z, 43, 3, ARGB(255,229,0,0), 100)
				DrawCircle3D(minion.x, minion.y, minion.z, 25, 3, ARGB(255,229,0,0), 100)
				DrawLine3D(minion.x + 30, minion.y, minion.z + 30, minion.x - 30, minion.y, minion.z - 30, 3, ARGB(255,229,0,0))
				DrawLine3D(minion.x + 30, minion.y, minion.z - 30, minion.x - 30, minion.y, minion.z + 30, 3, ARGB(255,229,0,0))
			end
		end
	end
end

function OnApplyBuff(unit, source, buff)
	if source and source.isMe and not source.charName:lower():find("baron") and not source.charName:lower():find("spiderboss") then
		if buff.name == "SummonerExhaust" and Menu.QSS.Exhaust then
			DefensiveItems("Exhaust")
		end
		if buff.type == 5 and Menu.QSS.Stun then
			DefensiveItems("Stun")
		end
		if buff.type == 7 and Menu.QSS.Silence then
			DefensiveItems("Silence")
		end
		if buff.type == 8 and Menu.QSS.Taunt then
			DefensiveItems("Taunt")
		end
		if buff.type == 10 and Menu.QSS.Fear then
			DefensiveItems("Fear")
		end
		if buff.type == 11 and Menu.QSS.Root then
			DefensiveItems("Root")
		end
		if buff.type == 21 and Menu.QSS.Charm then
			DefensiveItems("Charm")
		end
		if buff.type == 24 and Menu.QSS.Suppression then
			DefensiveItems("Suppression")
		end
		if buff.type == 25 and Menu.QSS.Blind then
			DefensiveItems("Blind")
		end
		if buff.type == 29 and Menu.QSS.KnockUp then
			DefensiveItems("KnockUp")
		end
	end
end

function MinionsKilled()
	return myHero:GetInt('MINIONS_KILLED') + myHero:GetInt('NEUTRAL_MINIONS_KILLED')
end

function CheckJungle()
	if Menu.Jungle.SmiteON then
		for i, jungle in pairs(jungleMinions.objects) do
			if jungle ~= nil then
				SmiteMonster(jungle)
			end
		end
	end	 
end

function GetSmiteDamage()
	if myHero.level <= 4 then
		SmiteDamage = 370 + (myHero.level*20)
	end
	if myHero.level > 4 and myHero.level <= 9 then
		SmiteDamage = 330 + (myHero.level*30)
	end
	if myHero.level > 9 and myHero.level <= 14 then
		SmiteDamage = 240 + (myHero.level*40)
	end
	if myHero.level > 14 then
		SmiteDamage = 100 + (myHero.level*50)
	end
	return SmiteDamage
end

function SmiteMonster(obj)
	if SmitePos ~= nil and myHero:CanUseSpell(SmitePos) == READY and GetDistance(obj) <= 560 and obj.health <= GetSmiteDamage() then
		if obj.charName == "SRU_Baron" or obj.charName == "SRU_Dragon_Water" or obj.charName == "SRU_Dragon_Fire" or obj.charName == "SRU_Dragon_Earth" or obj.charName == "SRU_Dragon_Air" or obj.charName == "SRU_Dragon_Elder" or obj.charName == "SRU_RiftHerald" then
			CastSpell(SmitePos, obj)
		end
	end
end

function DefensiveItems(BuffType)
	for _, item in pairs(DefensiveItemsList) do
		item.slot = GetInventorySlotItem(item.id)
		if item.slot ~= nil then
			if Menu.QSS.QSSHumanizer == true then
				QSSHumanizer = math.random(Menu.QSS.QSSHumanizer.QSSHumanizerMinValue, Menu.QSS.QSSHumanizer.QSSHumanizerMinValue)/1000
			else
				QSSHumanizer = 0
			end
			DelayAction(function() CastSpell(item.slot) end, QSSHumanizer)
		elseif CleansePos ~= nil and Menu.QSS.Cleanse then
			DelayAction(function() CastSpell(CleansePos) end, QSSHumanizer)
		end
	end
end

function OnAnimation(unit, animation)
	if unit.team ~= myHero.team and unit.type == myHero.type and animation == "Death" and Menu.EmoteON then
		if kills ~= myHero.kills or assists ~= myHero.assists then
			EmoteHumanizer = math.random(100, 250)/1000
			DelayAction(function() SendChat("/masterybadge") end, EmoteHumanizer)
			kills = myHero.kills
			assists = myHero.assists
		end
    end
	
	if unit.type == "obj_AI_Minion" and unit.team ~= myHero.team and animation == "Death" and GetDistance(unit, myHero) < 1000 and Menu.FarmInfo.FarmInfoON then
		totalfarm = totalfarm + 1
		farm = math.round(MinionsKilled() / totalfarm * 100)
		farmmissed = tostring(totalfarm - MinionsKilled())
		if farm >= 80 then
			farmcolor = ARGB(255,3,229,0)
		elseif farm >= 50 then
			farmcolor = ARGB(255,229,221,0)
		elseif farm >= 30 then
			farmcolor = ARGB(255,229,145,0)
		else
			farmcolor = ARGB(255,229,0,0)
		end
    end
end

function OnUnload()
	SaveFile = io.open(SAVE_PATH.."DoctorTools_TotalFarm.txt", "w")
	SaveFile:write(totalfarm)
	SaveFile:close()
end

function OnBugSplat()
	SaveFile = io.open(SAVE_PATH.."DoctorTools_TotalFarm.txt", "w")
	SaveFile:write(totalfarm)
	SaveFile:close()
end

AddDeleteObjCallback(function(o)
	if o and o.valid then
		if not Game.DidEnd then
			if o.name == "SRU_Order_nexus_swirlies.troy" or o.name == "SRU_Chaos_nexus_swirlies.troy" then
				Game.DidEnd = true
				SaveFile = io.open(SAVE_PATH.."DoctorTools_TotalFarm.txt", "w")
				SaveFile:write("0")
				SaveFile:close()
			end
		end
	end
end)

function file_exists(name)
	local f = io.open(name,"r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

function Update()
    local UpdateHost = "www.s1mplescripts.de"
    local ServerPath = "/DrPhoenix/BoL/Scripts/DoctorTools/"
    local ServerFileName = "DoctorTools.lua"
    local ServerVersionFileName = "DoctorTools.version"
 
    DL = Download()
    local ServerVersionDATA = GetWebResult("s1mplescripts.de" , ServerPath..ServerVersionFileName)
    if ServerVersionDATA then
        local ServerVersion = tonumber(ServerVersionDATA)
        if ServerVersion then
            if ServerVersion > tonumber(version) then
                PrintMsg("Updating, don't press F9")
                DL:newDL(UpdateHost, ServerPath..ServerFileName, ServerFileName, SCRIPT_PATH, function ()
                    PrintMsg("DoctorTools updated, please reload")
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