local debug = false
local version = '1.3'
local Author = 'Linkpad - AuroraScripters'

local _menuInit = false
local globalMenu = { }
local MenuStartX = 10
local MenuStartY = 60
local MenuStartWidth = 250
local MenuStartHeight = 25
local MenuTextSize = 15
local GlobalVar = { }
local GlobalId = 0
local menuconf

class 'AutoUpdate'
function AutoUpdate:__init(localVersion, host, versionPath, scriptPath, savePath, callbackUpdate, callbackNoUpdate, callbackNewVersion, callbackError)
	self.localVersion = localVersion
	self.versionPath = host .. versionPath
	self.scriptPath = host .. scriptPath
	self.savePath = savePath
	self.callbackUpdate = callbackUpdate
	self.callbackNoUpdate = callbackNoUpdate
	self.callbackNewVersion = callbackNewVersion
	self.callbackError = callbackError
	self:createSocket(self.versionPath)
	self.downloadStatus = 'Connect to Server for VersionInfo'
	AddTickCallback(function() self:getVersion() end)
end

function AutoUpdate:createSocket(url)
	if not self.LuaSocket then
	    self.LuaSocket = require("socket")
	else
	    self.socket:close()
	    self.socket = nil
	end
	self.LuaSocket = require("socket")
	self.socket = self.LuaSocket.tcp()
	self.socket:settimeout(0, 'b')
	self.socket:settimeout(99999999, 't')
	self.socket:connect("linkpad.fr", 80)
	self.url = "/aurora/TcpUpdater/getscript.php?page=" .. url
	self.started = false
	self.File = ''
end

function AutoUpdate:getVersion()
	if self.gotScriptVersion then return end

	local Receive, Status, Snipped = self.socket:receive(1024)
	if Status == 'timeout' and self.started == false then
		self.started = true
	    self.socket:send("GET ".. self.url .." HTTP/1.0\r\nHost: linkpad.fr\r\n\r\n")
	end
	if (Receive or (#Snipped > 0)) then
		self.File = self.File .. (Receive or Snipped)
	end
	if Status == "closed" then
		local _, ContentStart = self.File:find('<script'..'data>')
		local ContentEnd, _ = self.File:find('</script'..'data>')
		if not ContentStart or not ContentEnd then
		    self.callbackError()
		else
			self.onlineVersion = tostring(self.File:sub(ContentStart + 1,ContentEnd-1))
			if self.onlineVersion ~= self.localVersion then
				self.callbackNewVersion(self.onlineVersion)
				self:createSocket(self.scriptPath)
				self.DownloadStatus = 'Connect to Server for ScriptDownload'
				AddTickCallback(function() self:downloadUpdate() end)

			elseif self.onlineVersion <= self.localVersion then
				self.callbackNoUpdate()
			end
		end
		self.gotScriptVersion = true

	end
end

function AutoUpdate:downloadUpdate()
	if self.gotScriptUpdate then return end

	local Receive, Status, Snipped = self.socket:receive(1024)
	if Status == 'timeout' and self.started == false then
		self.started = true
	    self.socket:send("GET ".. self.url .." HTTP/1.0\r\nHost: linkpad.fr\r\n\r\n")
	end
	if (Receive or (#Snipped > 0)) then
		self.File = self.File .. (Receive or Snipped)
	end
	if Status == "closed" then
		local _, ContentStart = self.File:find('<script'..'data>')
		local ContentEnd, _ = self.File:find('</script'..'data>')

		if not ContentStart or not ContentEnd then
		    self.callbackError()
		else
			self.File = self.File:sub(ContentStart + 1,ContentEnd-1)
			local f = io.open(self.savePath,"w+b")
			f:write(self.File)
			f:close()
			self.callbackUpdate(self.onlineVersion, self.localVersion)
		end
		self.gotScriptUpdate = true

	end
end


class "MenuConfig"
function printDebug(_text)
	if debug then
		print(_text)
	end
end

function addSettings()
    -- Add Menuconfig option
    menuconf = MenuConfig("__menuconfig_option__", "MenuConfig - Settings")
    menuconf:Section("MenuConfig - Settings", ARGB(255, 52, 152, 219))
    menuconf:KeyToggle("togglemenu", "Show/hide menu:", string.byte("M"))
    menuconf:Section("about menuconfig", ARGB(255, 52, 152, 219))
    menuconf:Info("Version: 1.3", "leaf")
    menuconf:Info("Author: Linkpad - AuroraScripters")
    menuconf:Info("Updated: 10/03/2016", "clock")
end

function MenuConfig:__init(_header, _name, _parent, _icon)
	UpdateWindow()

	if not _menuInit then
	    _menuInit = true
	    AddDrawCallback(function() self:OnDraw() end)
	    AddMsgCallback(function(Msg, Key) self:Msg(Msg, Key) end)
	    AddTickCallback(function() self:OnTick() end)
	    self.MenuConfigOpen = false
	    self:InitComponents()

	    self.mousedown = false

	    GlobalVar.MenuStartWidth = 250

	    addSettings()
	end

	if _parent == nil then
		-- it's creating the menu.
		self.menu = {}
		self.menu.submenu = {}
		self.menu.parent = nil
		self.menu.main = _name
		self.menu.depth = 0
		self.menu.header = _header
		GlobalId = GlobalId + 1
		self.menu.id = GlobalId
		self.menu.name = _name
		self.menu.subwidth = 200
		self.menu.x = MenuStartX
		self.menu.y = MenuStartY
		self.menu.open = false
		self.menu.suby = 0
		self.menu.subx = MenuStartX + GlobalVar.MenuStartWidth + 10

		MenuStartY = MenuStartY + MenuStartHeight
		result = self:CalculateWidth(_name)
		if GlobalVar.MenuStartWidth < result then
		    GlobalVar.MenuStartWidth = result
		end

		-- self.menu.subwidth = GlobalVar.MenuStartWidth

		self.menu.child = nil
		table.insert(globalMenu, self.menu)
	else
		self.menu = {}
		self.menu.main = _parent.main
		self.menu.submenu = _parent.submenu
		self.menu.depth = _parent.depth + 1
		self.menu.header = _header
		GlobalId = GlobalId + 1
		self.menu.id = GlobalId
		self.menu.name = _name
		self.menu.subwidth = 200
		self.menu.parent = _parent

		if _icon ~= nil then
			self.menu.icon = _icon
		else
			self.menu.icon = "menu-hamburger"
		end

		result = self:CalculateWidth(_name)
		if _parent.subwidth < result then
		    _parent.subwidth = result
		end


		self.menu.width = _parent.subwidth
		-- self.menu.x = _parent.x + _parent.subwidth + 10
		if _parent.depth == 0 then
			self.menu.main = _parent.name
			_parent.subx = _parent.x + GlobalVar.MenuStartWidth + 10
		end

		self.menu.y = _parent.y + _parent.suby
		_parent.suby = _parent.suby + MenuStartHeight


		self.menu.suby = 0
		self.menu.subx = 0

		self.menu.open = false
		self.menu.ismenu = true
		self.menu.issection = false

		table.insert(self.menu.submenu, self.menu)

		-- for _, menu in pairs(_parent.submenu) do
		-- 	printDebug(menu.width)
		-- end

		table.insert(globalMenu, self.menu)
	end

end

function MenuConfig:checkUpdate()
	local ToUpdate = {}
	ToUpdate.Version = version
	ToUpdate.Name = "MenuConfig"
	ToUpdate.Host = "http://raw.githubusercontent.com"
	ToUpdate.VersionPath = "/linkpad/BoL/master/Common/MenuConfig.version" .."?rand="..math.random(1, 10000)
	ToUpdate.ScriptPath =  "/linkpad/BoL/master/Common/MenuConfig.lua" .."?rand="..math.random(1, 10000)
	ToUpdate.SavePath = SCRIPT_PATH .."/Common/MenuConfig.lua"
	ToUpdate.CallbackUpdate = function(NewVersion,OldVersion) print("<font color=\"#FF794C\"><b>" .. ToUpdate.Name .. ": </b></font> <font color=\"#FFDFBF\">Updated to "..NewVersion..". Please Reload with 2x F9</b></font>") end
	ToUpdate.CallbackNoUpdate = function()  end
	ToUpdate.CallbackNewVersion = function(NewVersion) print("<font color=\"#FF794C\"><b>" .. ToUpdate.Name .. ": </b></font> <font color=\"#FFDFBF\">New Version found ("..NewVersion.."). Please wait until its downloaded</b></font>") end
	ToUpdate.CallbackError = function(NewVersion) print("<font color=\"#FF794C\"><b>" .. ToUpdate.Name .. ": </b></font> <font color=\"#FFDFBF\">Error while Downloading. Please try again.</b></font>") end
	AutoUpdate(ToUpdate.Version, ToUpdate.Host, ToUpdate.VersionPath, ToUpdate.ScriptPath, ToUpdate.SavePath, ToUpdate.CallbackUpdate,ToUpdate.CallbackNoUpdate, ToUpdate.CallbackNewVersion,ToUpdate.CallbackError)
end

function MenuConfig:CheckSprite()

	self.updatingSprite = false
	self.endDownload = false
	self.madeUpdate = false

	sprite = { "cogwheel.png", 
	"eye-open.png",
	"flag.png",
	"info-sign.png",
	"keyboard.png",
	"menu-hamburger.png",
	"mouse.png",
	"target.png",
	"user.png",
	"chevron-right.png",
	"ok.png",
	"remove.png",
	"activated.png",
	"deactivated.png",
	"arrow-right.png",
	"eyedropper.png",
	"list.png",
	"adjust-alt.png",
	"bug.png",
	"clock.png",
	"cup.png",
	"eye-close.png",
	"gamepad.png",
	"heart.png",
	"leaf.png",
	"riflescope.png",
	"shield.png",
	"skull.png",
	"alert.png" }

	 if not MakeSurePathExists(SPRITE_PATH .. "MenuConfig\\") then
	 	CreateDirectory(SPRITE_PATH .. "MenuConfig\\")
	 end


	for _, _sprite in pairs(sprite) do
		location = SPRITE_PATH .. "MenuConfig\\" .. _sprite
		if not FileExist(location) then
			self.madeUpdate = true
			DownloadFile("https://raw.githubusercontent.com/linkpad/BoL/master/Sprites/MenuConfig/".. _sprite .."?rand="..math.random(1,10000), location, function() self.updatingSprite = false end)
		    if not self.updatingSprite then
		    	self.updatingSprite = true
		    	print("<font color=\"#FF794C\"><b>MenuConfig: </b></font> <font color=\"#FFDFBF\">Downloading sprite...</b></font>")
		    end
		end
	end

end

function MenuConfig:InitComponents()
	self:checkUpdate()
	self:CheckSprite()

    self.cogwheelSprite = createSprite('MenuConfig\\cogwheel.png')
    self.eyeopenSprite = createSprite('MenuConfig\\eye-open.png')
    self.flagSprite = createSprite('MenuConfig\\flag.png')
    self.infosignSprite = createSprite('MenuConfig\\info-sign.png')
    self.keyboardSprite = createSprite('MenuConfig\\keyboard.png')
    self.menuhamburgerSprite = createSprite('MenuConfig\\menu-hamburger.png')
    self.mouseSprite = createSprite('MenuConfig\\mouse.png')
    self.targetSprite = createSprite('MenuConfig\\target.png')
    self.userSprite = createSprite('MenuConfig\\user.png')
    self.chevronrightSprite = createSprite('MenuConfig\\chevron-right.png')
    self.okSprite = createSprite('MenuConfig\\ok.png')
    self.removeSprite = createSprite('MenuConfig\\remove.png')
    self.activatedSprite = createSprite('MenuConfig\\activated.png')
    self.deactivatedSprite = createSprite('MenuConfig\\deactivated.png')
    self.arrowrightSprite = createSprite('MenuConfig\\arrow-right.png')
    self.eyedropperSprite = createSprite('MenuConfig\\eyedropper.png')
    self.listSprite = createSprite('MenuConfig\\list.png')
    self.adjustaltSprite = createSprite('MenuConfig\\adjust-alt.png')
    self.bugSprite = createSprite('MenuConfig\\bug.png')
    self.clockSprite = createSprite('MenuConfig\\clock.png')
    self.cupSprite = createSprite('MenuConfig\\cup.png')
    self.eyecloseSprite = createSprite('MenuConfig\\eye-close.png')
    self.gamepadSprite = createSprite('MenuConfig\\gamepad.png')
    self.heartSprite = createSprite('MenuConfig\\heart.png')
    self.leafSprite = createSprite('MenuConfig\\leaf.png')
    self.riflescopeSprite = createSprite('MenuConfig\\riflescope.png')
    self.shieldSprite = createSprite('MenuConfig\\shield.png')
    self.skullSprite = createSprite('MenuConfig\\skull.png')
    self.alertSprite = createSprite('MenuConfig\\alert.png')

    -- Open Menu Button
    self.OpenMenuButtonX = 10
    self.OpenMenuButtonY = 10
    self.OpenMenuButtonWidth = 140
    self.OpenMenuButtonHeight = 30
    self.OpenMenuButtonText = "Open MenuConfig"
    self.OpenMenuButtonTextX = 30
    self.OpenMenuButtonTextY = 7
    self.OpenMenuButtonTextSize = 15
end

-- #region MenuConfig API function
function MenuConfig:Menu(_header, _name, _icon)
	local sub = MenuConfig(_header, _name, self.menu, _icon)
	self[_header] = sub
	printDebug("create menu " .. _header .. " parent is " .. self.menu.header)
end

function MenuConfig:Save()
	local content = {}

	-- printDebug("main menu " .. self.menu.main)
	for _, menu in pairs(globalMenu) do
		if menu.name == self.menu.main then
			for _, submenu in pairs(menu.submenu) do
				if submenu.iskeybinding or submenu.iskeytoggle then
					if content[submenu.parent.header] == nil then
						content[submenu.parent.header] = {}
					end
					content[submenu.parent.header][submenu.header] = { key = submenu.key }
				elseif submenu.isboolean then
					if content[submenu.parent.header] == nil then
						content[submenu.parent.header] = {}
					end
					content[submenu.parent.header][submenu.header] = { status = submenu.status }
				elseif submenu.isdropdown then
					if content[submenu.parent.header] == nil then
						content[submenu.parent.header] = {}
					end
					content[submenu.parent.header][submenu.header] = { dropid = submenu.dropid }
				elseif submenu.isslider then
					if content[submenu.parent.header] == nil then
						content[submenu.parent.header] = {}
					end
					content[submenu.parent.header][submenu.header] = { value = submenu.value }
				elseif submenu.iscolorpick then
					if content[submenu.parent.header] == nil then
						content[submenu.parent.header] = {}
					end
					content[submenu.parent.header][submenu.header] = { color = submenu.instance[submenu.header] }
				end
			end
		end
	end
	-- printDebug(content)
	if not GetSave("MenuConfig")[self.menu.main] then GetSave("MenuConfig")[self.menu.main] = {} end
	table.clear(GetSave("MenuConfig")[self.menu.main])
	table.merge(GetSave("MenuConfig")[self.menu.main], content, true)

end

function MenuConfig:KeyBinding(_header, _text, _key)
	keybinding = {}
	keybinding.header = _header
	GlobalId = GlobalId + 1
	keybinding.id = GlobalId
	keybinding.parent = self.menu
	keybinding.iskeybinding = true
	keybinding.name = _text
	keybinding.key = _key

	if GetSave("MenuConfig")[self.menu.main] then
		if  GetSave("MenuConfig")[self.menu.main][self.menu.header] then
			if GetSave("MenuConfig")[self.menu.main][self.menu.header][_header] then
				keybinding.key = GetSave("MenuConfig")[self.menu.main][self.menu.header][_header].key
			end
		end
	end


	keybinding.open = false
	keybinding.currentkeychange = false

	keybinding.x = self.menu.subx + self.menu.subwidth + 10
	keybinding.y = self.menu.y + self.menu.suby
	result = self:CalculateWidth(keybinding.name)
	if self.menu.subwidth < result then
	    self.menu.subwidth = result
	end

	keybinding.status = false

	self.menu.suby = self.menu.suby + MenuStartHeight

	keybinding.save = function() self:Save() end

	keybinding.instance = self
	keybinding.instance[_header] = keybinding.status


	table.insert(self.menu.submenu, keybinding)
end

function MenuConfig:KeyToggle(_header, _text, _key)
	keytoggle = {}
	keytoggle.header = _header
	GlobalId = GlobalId + 1
	keytoggle.id = GlobalId
	keytoggle.parent = self.menu
	keytoggle.iskeytoggle = true
	keytoggle.name = _text
	keytoggle.key = _key

	if GetSave("MenuConfig")[self.menu.main] then
		if  GetSave("MenuConfig")[self.menu.main][self.menu.header] then
			if GetSave("MenuConfig")[self.menu.main][self.menu.header][_header] then
				keytoggle.key = GetSave("MenuConfig")[self.menu.main][self.menu.header][_header].key
			end
		end
	end

	keytoggle.open = false
	keytoggle.currentkeychange = false

	keytoggle.x = self.menu.subx + self.menu.subwidth + 10
	keytoggle.y = self.menu.y + self.menu.suby
	result = self:CalculateWidth(keytoggle.name)
	if self.menu.subwidth < result then
	    self.menu.subwidth = result
	end

	keytoggle.status = false
	keytoggle.keydown = false

	self.menu.suby = self.menu.suby + MenuStartHeight

	keytoggle.save = function() self:Save() end

	keytoggle.instance = self
	keytoggle.instance[_header] = keytoggle.status

	table.insert(self.menu.submenu, keytoggle)
end

function MenuConfig:TargetSelector(_header, _text, _mode, _range, _dmgtype, _targetselected, _enemyteam)
	targetselector = {}
	targetselector.header = _header
	GlobalId = GlobalId + 1
	targetselector.id = GlobalId
	targetselector.parent = self.menu
	targetselector.istargetselector = true

	ts = TargetSelector(_mode, _range, _dmgtype, _targetselected, _enemyteam)

	targetselector.instance = self
	targetselector.instance[_header] = ts


	if GetSave("MenuConfig")[self.menu.main] then
		if  GetSave("MenuConfig")[self.menu.main]["__tsmenu"] then
			if GetSave("MenuConfig")[self.menu.main]["__tsmenu"]["__tsmode"] then
				ts.mode = GetSave("MenuConfig")[self.menu.main]["__tsmenu"]["__tsmode"].dropid
			end
		end
	end

	callback = function(id) self:Tsmodechange(id, ts) end

	self:Menu("__tsmenu", _text)
	self.__tsmenu:DropDown("__tsmode", "Target Selector mode:", ts.mode, { "Low HP", "Most AP", "Most AD", "Less Cast", "Near Mouse", "Priority", "Low HP Priority", "Less Cast Priority", "Dead", "Closest" }, callback)

end

function MenuConfig:Tsmodechange(id, ts)
	printDebug("ts mode changed to id " .. id)
	ts.mode = id
end

function MenuConfig:ColorPick(_header, _text, _value)
	colorpick = {}
	colorpick.header = _header
	GlobalId = GlobalId + 1
	colorpick.id = GlobalId
	colorpick.parent = self.menu
	colorpick.iscolorpick = true
	colorpick.name = _text
	colorpick.open = false


	colorpick.color = _value

	colorpick.subwidth = 100
	colorpick.currentcolorchange = false

	colorpick.x = self.menu.subx + self.menu.subwidth + 10
	colorpick.y = self.menu.y + self.menu.suby
	result = self:CalculateWidth(colorpick.name)
	if self.menu.subwidth < result then
	    self.menu.subwidth = result
	end

	self.menu.suby = self.menu.suby + MenuStartHeight

	colorpick.save = function() self:Save() end

	colorpick.instance = self
	colorpick.instance[_header] = _value

	if GetSave("MenuConfig")[self.menu.main] then
		if  GetSave("MenuConfig")[self.menu.main][self.menu.header] then
			if GetSave("MenuConfig")[self.menu.main][self.menu.header][_header] then
				colorpick.instance[_header] = GetSave("MenuConfig")[self.menu.main][self.menu.header][_header].color
			end
		end
	end

	table.insert(self.menu.submenu, colorpick)
end

function MenuConfig:Slider(_header, _text, _value, _minvalue, _maxvalue, _step)
	slider = {}
	slider.header = _header
	GlobalId = GlobalId + 1
	slider.id = GlobalId
	slider.parent = self.menu
	slider.isslider = true
	slider.name = _text
	slider.open = false
	slider.subwidth = 100

	slider.value = _value

	if GetSave("MenuConfig")[self.menu.main] then
		if  GetSave("MenuConfig")[self.menu.main][self.menu.header] then
			if GetSave("MenuConfig")[self.menu.main][self.menu.header][_header] then
				slider.value = GetSave("MenuConfig")[self.menu.main][self.menu.header][_header].value
			end
		end
	end

	slider.minvalue = _minvalue
	slider.maxvalue = _maxvalue
	slider.step = _step
	slider.movingslider = false

	slider.x = self.menu.subx + self.menu.subwidth + 10
	slider.y = self.menu.y + self.menu.suby
	result = self:CalculateWidth(slider.name)
	if self.menu.subwidth < result then
	    self.menu.subwidth = result
	end

	self.menu.suby = self.menu.suby + MenuStartHeight

	slider.save = function() self:Save() end

	slider.instance = self
	slider.instance[_header] = slider.value

	table.insert(self.menu.submenu, slider)
end

function MenuConfig:DropDown(_header, _text, _value, _droptable, _callback)
	dropdown = {}
	dropdown.header = _header
	GlobalId = GlobalId + 1
	dropdown.id = GlobalId
	dropdown.parent = self.menu
	dropdown.isdropdown = true
	dropdown.name = _text
	dropdown.droptable = {}
	dropdown.open = false
	dropdown.subwidth = 100
	dropdown.callback = _callback

	countid = 0
	dropdown.suby = 0

	dropdown.x = self.menu.subx + self.menu.subwidth + 10
	dropdown.y = self.menu.y + self.menu.suby
	result = self:CalculateWidth(dropdown.name)
	if self.menu.subwidth < result then
	    self.menu.subwidth = result
	end

	self.menu.suby = self.menu.suby + MenuStartHeight

	dropdown.save = function() self:Save() end

	dropdown.dropid = _value

	if GetSave("MenuConfig")[self.menu.main] then
		if  GetSave("MenuConfig")[self.menu.main][self.menu.header] then
			if GetSave("MenuConfig")[self.menu.main][self.menu.header][_header] then
				dropdown.dropid = GetSave("MenuConfig")[self.menu.main][self.menu.header][_header].dropid
			end
		end
	end

	for _, _dropmenu in pairs(_droptable) do
		printDebug(_dropmenu)
		dropmenu = {}
		countid = countid + 1
		dropmenu.parent = dropdown
		dropmenu.id = countid
		dropmenu.name = _dropmenu
		if dropmenu.id == dropdown.dropid then
			dropmenu.selected = true
		else
			dropmenu.selected = false
		end
		dropmenu.parent = dropdown

		result = self:CalculateWidth(dropmenu.name)
		if dropdown.subwidth < result then
		    dropdown.subwidth = result
		end

		dropmenu.y = dropdown.y + dropdown.suby
		dropdown.suby = dropdown.suby + MenuStartHeight
		
		table.insert(dropdown.droptable, dropmenu)
	end

	dropdown.instance = self
	dropdown.instance[_header] = _value

	table.insert(self.menu.submenu, dropdown)
end

function MenuConfig:Boolean(_header, _text, _value)
	boolean = {}
	boolean.header = _header
	GlobalId = GlobalId + 1
	boolean.id = GlobalId
	boolean.parent = self.menu
	boolean.isboolean = true
	boolean.name = _text
	boolean.x = self.menu.subx + self.menu.subwidth + 10
	boolean.y = self.menu.y + self.menu.suby
	result = self:CalculateWidth(boolean.name)
	if self.menu.subwidth < result then
	    self.menu.subwidth = result
	end

	boolean.status = _value

	if GetSave("MenuConfig")[self.menu.main] then
		if  GetSave("MenuConfig")[self.menu.main][self.menu.header] then
			if GetSave("MenuConfig")[self.menu.main][self.menu.header][_header] then
				boolean.status = GetSave("MenuConfig")[self.menu.main][self.menu.header][_header].status
			end
		end
	end

	self.menu.suby = self.menu.suby + MenuStartHeight

	boolean.instance = self
	boolean.instance[_header] = boolean.status

	boolean.save = function() self:Save() end

	table.insert(self.menu.submenu, boolean)

end

function MenuConfig:Info(_text, _icon)
	info = {}
	GlobalId = GlobalId + 1
	info.id = GlobalId
	info.parent = self.menu
	info.isinfo = true
	info.name = _text
	info.icon = _icon
	info.x = self.menu.subx + self.menu.subwidth + 10
	info.y = self.menu.y + self.menu.suby
	result = self:CalculateWidth(info.name)
	if self.menu.subwidth < result then
	    self.menu.subwidth = result
	end

	self.menu.suby = self.menu.suby + MenuStartHeight
	table.insert(self.menu.submenu, info)
end

function MenuConfig:Section(_name, _color)

    if _color == nil then
        _color = ARGB(255,243,156,18)
    end

    section = {}
    section.id = GlobalId + 1
    section.parent = self.menu
    section.issection = true
    section.name = string.upper(_name)
    section.color = _color
    section.x = self.menu.subx + self.menu.subwidth + 10
    section.y = self.menu.y + self.menu.suby
    result = self:CalculateWidth(section.name)
    if self.menu.subwidth < result then
        self.menu.subwidth = result
    end


    section.centerText = false

    textwidth, centerx = self:CenterText(section.name, 12, section.parent.subwidth)

    section.textwidth = textwidth
    section.centerx = centerx

    printDebug("parent is : " .. self.menu.header)

    self.menu.suby = self.menu.suby + MenuStartHeight
    table.insert(self.menu.submenu, section)
end
-- #endregion


-- #region OnDraw & OnTick function
function MenuConfig:OnDraw()
	self:DrawOpenMenuButton()
	self:DrawMenu()
end


function MenuConfig:OnTick()

    local cursor = GetCursorPos()
    self.pos = { x = cursor.x, y = cursor.y }

    if not self.updatingSprite and not self.endDownload and self.madeUpdate then
    	print("<font color=\"#FF794C\"><b>MenuConfig: </b></font> <font color=\"#FFDFBF\">Download finished.</b></font>")
    	self.endDownload = true
    end

    if self.mousedown then
    	for _, menu in pairs(globalMenu) do
    		for _, submenu in pairs(menu.submenu) do
    			if submenu.isslider and submenu.movingslider then
    				position = self.pos.x - (submenu.parent.subx + submenu.parent.subwidth + 10 + 40)

    				posvalue = submenu.minvalue + ((position / 100) * (submenu.maxvalue - submenu.minvalue))

    				if posvalue > submenu.maxvalue then
    					posvalue = submenu.maxvalue
    				elseif posvalue < submenu.minvalue then
    					posvalue = submenu.minvalue
    				end
    				-- printDebug(posvalue)
    				modulo = posvalue % submenu.step
    				stepping = submenu.step / 2
    				if modulo > stepping then
    					submenu.value = (posvalue - modulo) + submenu.step
    					submenu.instance[submenu.header] = submenu.value
    				else
    					submenu.value = (posvalue - modulo)
    					submenu.instance[submenu.header] = submenu.value
    				end

    				submenu.save()
    			end
    		end
    	end
    end
end
-- #endregion

-- #region Msg function

function MenuConfig:Msg(Msg, Key)

    local pressed = false

    if Msg == WM_LBUTTONDOWN and not pressed and not menuconf.togglemenu then
        printDebug("press button at x : " .. self.pos.x .. " y : " .. self.pos.y)
        self:CursorOnMenu()
        pressed = true
    end

    if Msg == WM_LBUTTONDOWN then
    	for _, menu in pairs(globalMenu) do
    		for _, submenu in pairs(menu.submenu) do
    			if submenu.isslider and submenu.movingslider then
    				self.mousedown = true
    			end
    		end
    	end
    end

    if Msg == WM_LBUTTONUP then
    	for _, menu in pairs(globalMenu) do
    		for _, submenu in pairs(menu.submenu) do
    			if submenu.isslider and submenu.movingslider then
    				self.mousedown = false
    				submenu.movingslider = false
    			end
    		end
    	end
    end

    if Msg == WM_LBUTTONUP and pressed then
        pressed = false
    end

    if Msg == KEY_DOWN and Key ~= nil then
    	for _, menu in pairs(globalMenu) do
    		for _, _menu in pairs(menu.submenu) do
    			if _menu.iskeybinding then
    				if _menu.currentkeychange then
    					_menu.key = Key
    					printDebug("key changed.")
    					_menu.save()
    					_menu.currentkeychange = false
    				else
    					if _menu.key == Key and not _menu.status then
    						_menu.status = true
    						_menu.instance[_menu.header] = _menu.status
    						-- printDebug("key pressed")
    					end
    				end
    			elseif _menu.iskeytoggle then
    				if _menu.currentkeychange then
    					_menu.key = Key
    					printDebug("key changed")
    					_menu.save()
    					_menu.currentkeychange = false
    				else
    					if _menu.key == Key and not _menu.keydown then
    						_menu.keydown = true
    					end
    				end
    			end
    		end
    	end
    end

    if Msg == KEY_UP and Key ~= nil then
    	for _, menu in pairs(globalMenu) do
    		for _, _menu in pairs(menu.submenu) do
    			if _menu.iskeybinding then
    				if not _menu.currentkeychange then
    					if _menu.key == Key and _menu.status then
    						_menu.status = false
    						_menu.instance[_menu.header] = _menu.status
    						-- printDebug("key release")
    					end
    				end
    			elseif _menu.iskeytoggle then
    				if not _menu.currentkeychange then
    					if _menu.key == Key and _menu.keydown then
    						if _menu.status then
    							_menu.status = false
    							_menu.instance[_menu.header] = _menu.status
    						else
    							_menu.status = true
    							_menu.instance[_menu.header] = _menu.status
    						end
    						_menu.keydown = false
    					end
    				end
    			end
    		end
    	end
    end
end

function MenuConfig:CursorOnMenu()

    -- Check if openmenu is cliked.
    if self.pos.x > self.OpenMenuButtonX and self.pos.x < self.OpenMenuButtonX + self.OpenMenuButtonWidth then
        if self.pos.y > self.OpenMenuButtonY and self.pos.y < self.OpenMenuButtonY + self.OpenMenuButtonHeight then
            if not self.MenuConfigOpen then
                printDebug("menu open")
                self.MenuConfigOpen = true
            elseif self.MenuConfigOpen then
                printDebug("close menu")
                self.MenuConfigOpen = false
            end
        end
    end

    -- check if we click on a menu
    if self.MenuConfigOpen then
        for _, menu in pairs(globalMenu) do
        	if menu.depth == 0 then
	            if self.pos.x > menu.x and self.pos.x < menu.x + GlobalVar.MenuStartWidth then
	                if self.pos.y > menu.y and self.pos.y < menu.y + MenuStartHeight then
	                    if not menu.open then 
	                        printDebug("you cliked on " .. menu.name)
	                        for _, _menu in pairs(globalMenu) do
	                        	_menu.open = false
	                        end
	                        menu.open = true
	                    elseif menu.open then
	                        printDebug("you closed the menu " .. menu.name)
	                        menu.open = false
	                        for _, _submenu in pairs(menu.submenu) do
	                        	_submenu.open = false
	                        end
	                    end
	                end
	            end
	        end

            if menu.open then
            	for _, _menu in pairs(menu.submenu) do
            		if _menu.ismenu then
	            		if self.pos.x > _menu.parent.subx and self.pos.x < _menu.parent.subx + _menu.parent.subwidth then
	            		    if self.pos.y > _menu.y and self.pos.y < _menu.y + MenuStartHeight then
			            		if _menu.depth == menu.depth+1 and _menu.parent == menu then
			            			if not _menu.open then 
			            			    printDebug("you cliked on " .. _menu.name)
			            			    printDebug("subx : " .. _menu.parent.subx)
			            			    for _, _parentsubmenu in pairs(_menu.parent.submenu) do
			            			    	if _parentsubmenu.ismenu then
				            			    	if _parentsubmenu ~= _menu and _parentsubmenu.depth >= _menu.depth then
				            			    		_parentsubmenu.open = false
				            			    	end
				            			    else
				            			    	_parentsubmenu.open = false
				            			    end
			            			    end
			            			    _menu.open = true
			            			elseif _menu.open then
			            			    printDebug("you closed the menu " .. _menu.name)
			            			    _menu.open = false
			            			    for _, _submenu in pairs(_menu.submenu) do
			            			    	if _submenu.ismenu then
				            			    	if _submenu.depth > _menu.depth then
				            			    		_submenu.open = false
				            			    	end
				            			    end
			            			    end
			            			end
			            		end
			            	end
			            end
			        elseif _menu.isboolean then
	            		if self.pos.x > _menu.parent.subx and self.pos.x < _menu.parent.subx + _menu.parent.subwidth then
	            		    if self.pos.y > _menu.y and self.pos.y < _menu.y + MenuStartHeight then
			            		if _menu.parent == menu then
			            			if not _menu.status then 
			            			    printDebug("you activated " .. _menu.name)
			            			    _menu.status = true
			            			    _menu.save()
			            			    _menu.instance[_menu.header] = _menu.status
			            			elseif _menu.status then
			            			    printDebug("you deactivated " .. _menu.name)
			            			    _menu.status = false
			            			    _menu.save()
			            			    _menu.instance[_menu.header] = _menu.status
			            			end
			            		end
			            	end
				        end
				    elseif _menu.iskeybinding or _menu.iskeytoggle then
	            		if self.pos.x > _menu.parent.subx and self.pos.x < _menu.parent.subx + _menu.parent.subwidth then
	            		    if self.pos.y > _menu.y and self.pos.y < _menu.y + MenuStartHeight then
			            		if _menu.parent == menu then
			            			if not _menu.open then 
			            			    printDebug("you open " .. _menu.name)
    	                			    for _, _submenu in pairs(_menu.parent.submenu) do
    	                			    	if not _submenu.ismenu and _submenu.open then
        	            			    		_submenu.open = false
    	    	            			    else
    	    	            			    	if _menu.parent == _submenu.parent then
    	    	            			    		_submenu.open = false
    	    	            			    	end
    	    	            			    end
    	                			    end
			            			    _menu.open = true
			            			elseif _menu.open then
			            			    printDebug("you close " .. _menu.name)
			            			    _menu.open = false
			            			end
			            		end
			            	end
				        end

				        if _menu.open then
				        	 -- DrawRectangle(x + width + 10, y, 200, height, ARGB(140,0,0,0))
				        	if self.pos.x > _menu.parent.subx + _menu.parent.subwidth + 10 and self.pos.x < _menu.parent.subx + _menu.parent.subwidth + 10 + 200 then
				        		if self.pos.y > _menu.y and self.pos.y < _menu.y + 30 then
				        			-- printDebug("cliked")
				        			if not _menu.currentkeychange then
				        				printDebug("you clicked on current key.")
				        				_menu.currentkeychange = true
				        			end
				        		end
				        	end
				        end
				    elseif _menu.iscolorpick then
	            		if self.pos.x > _menu.parent.subx and self.pos.x < _menu.parent.subx + _menu.parent.subwidth then
	            		    if self.pos.y > _menu.y and self.pos.y < _menu.y + MenuStartHeight then
			            		if _menu.parent == menu then
			            			if not _menu.open then 
			            			    printDebug("you open " .. _menu.name)
    	                			    for _, _submenu in pairs(_menu.parent.submenu) do
    	                			    	if not _submenu.ismenu and _submenu.open then
        	            			    		_submenu.open = false
    	    	            			    else
    	    	            			    	if _menu.parent == _submenu.parent then
    	    	            			    		_submenu.open = false
    	    	            			    	end
    	    	            			    end
    	                			    end
			            			    _menu.open = true
			            			elseif _menu.open then
			            			    printDebug("you close " .. _menu.name)
			            			    _menu.open = false
			            			end
			            		end
			            	end
				        end

				        if _menu.open then
				        	 -- DrawRectangle(x + width + 10, y, 200, height, ARGB(140,0,0,0))
				        	if self.pos.x > _menu.parent.subx + _menu.parent.subwidth + 10 and self.pos.x < _menu.parent.subx + _menu.parent.subwidth + 10 + 200 then
				        		if self.pos.y > _menu.y and self.pos.y < _menu.y + 30 then
				        			-- printDebug("cliked")
			        				printDebug("you clicked on current color.")
			        				__CP(nil, nil, _menu.instance[_menu.header][1], _menu.instance[_menu.header][2], _menu.instance[_menu.header][3], _menu.instance[_menu.header][4], _menu.instance[_menu.header])
				        		end
				        	end
				        end
				    elseif _menu.isslider then
	            		if self.pos.x > _menu.parent.subx and self.pos.x < _menu.parent.subx + _menu.parent.subwidth then
	            		    if self.pos.y > _menu.y and self.pos.y < _menu.y + MenuStartHeight then
			            		if _menu.parent == menu then
			            			if not _menu.open then 
			            			    printDebug("you open " .. _menu.name)
    	                			    for _, _submenu in pairs(_menu.parent.submenu) do
    	                			    	if not _submenu.ismenu and _submenu.open then
        	            			    		_submenu.open = false
    	    	            			    else
    	    	            			    	if _menu.parent == _submenu.parent then
    	    	            			    		_submenu.open = false
    	    	            			    	end
    	    	            			    end
    	                			    end
			            			    _menu.open = true
			            			elseif _menu.open then
			            			    printDebug("you close " .. _menu.name)
			            			    _menu.open = false
			            			end
			            		end
			            	end
				        end

				        if _menu.open then
        		        	if self.pos.x > _menu.parent.subx + _menu.parent.subwidth + 10 + 40 and self.pos.x < _menu.parent.subx + _menu.parent.subwidth + 10 + 40 + 100 + 10 then
        		        		if self.pos.y > _menu.y and self.pos.y < _menu.y + MenuStartHeight then
        		        			-- printDebug("cliked")
        	        				printDebug("you clicked on slider")
        	        				_menu.movingslider = true
        		        		end
        		        	end
        		        end

				    elseif _menu.isdropdown then
	            		if self.pos.x > _menu.parent.subx and self.pos.x < _menu.parent.subx + _menu.parent.subwidth then
	            		    if self.pos.y > _menu.y and self.pos.y < _menu.y + MenuStartHeight then
			            		if _menu.parent == menu then
			            			if not _menu.open then 
			            			    printDebug("you open " .. _menu.name)
		                			    for _, _submenu in pairs(_menu.parent.submenu) do
		                			    	if not _submenu.ismenu and _submenu.open then
	    	            			    		_submenu.open = false
		    	            			    else
		    	            			    	if _menu.parent == _submenu.parent then
		    	            			    		_submenu.open = false
		    	            			    	end
		    	            			    end
		                			    end
		                			    _menu.open = true
		                			elseif _menu.open then
		                			    printDebug("you close " .. _menu.name)
		                			    _menu.open = false
		                			end
		                		end
		                	end
		                end

		                if _menu.open then
		                	for _, dropmenu in pairs(_menu.droptable) do
		                		-- for _, dropmenu in pairs(droptable) do
		                		-- 	subx = dropmenu.parent.parent.subx + dropmenu.parent.parent.subwidth + 5

		                		-- 	-- draw border
		                		-- 	DrawRectangle(subx, dropmenu.y, 5, height, ARGB(50,0,0,0))
		                		-- 	DrawRectangle(subx + dropmenu.parent.subwidth, dropmenu.y, 5, height, ARGB(50,0,0,0))

		                		-- 	-- draw background
		                		-- 	DrawRectangle(subx + 5, dropmenu.y, dropmenu.parent.subwidth - 5, height, ARGB(140,0,0,0))
		                		-- 	if dropmenu.selected then
		                		-- 		self:DrawTextIcon("arrow-right", dropmenu.name, MenuTextSize, 30 + subx, 5 + dropmenu.y, ARGB(255,255,255,255))
		                		-- 	else
		                		-- 		self:DrawTextIcon(nil, dropmenu.name, MenuTextSize, 30 + subx, 5 + dropmenu.y, ARGB(255,255,255,255))
		                		-- 	end
		                		-- end
		                		subx = dropmenu.parent.parent.subx + dropmenu.parent.parent.subwidth + 5
		                		if self.pos.x > subx and self.pos.x < subx + dropmenu.parent.subwidth then
		                			if self.pos.y > dropmenu.y and self.pos.y < dropmenu.y + MenuStartHeight then
		                				if not dropmenu.selected then
		                					printDebug("you clicked on dropdown " .. dropmenu.name)
		                					for _, dropmenu in pairs(_menu.droptable) do
		                						dropmenu.selected = false
		                					end
		                					dropmenu.selected = true
		                					dropmenu.parent.dropid = dropmenu.id
		                					dropmenu.parent.save()
		                					dropmenu.parent.instance[dropmenu.parent.header] = dropmenu.id
		                					if dropmenu.parent.callback ~= nil then
	                							dropmenu.parent.callback(dropmenu.id)
	                						end
		                				end
		                			end
		                		end
		                	end
		                end
				    end
            	end
            end
        end


    end
end
-- #endregion

-- #region draw Function

function MenuConfig:DrawOpenMenuButton()

	if not menuconf.togglemenu then
    	DrawRectangle(self.OpenMenuButtonX - 5, self.OpenMenuButtonY - 5, self.OpenMenuButtonWidth + 10, self.OpenMenuButtonHeight + 10, ARGB(70,0,0,0))
    	DrawRectangle(self.OpenMenuButtonX, self.OpenMenuButtonY, self.OpenMenuButtonWidth, self.OpenMenuButtonHeight, ARGB(140,0,0,0))

    	self:DrawTextIcon("menu-hamburger", self.OpenMenuButtonText, self.OpenMenuButtonTextSize, self.OpenMenuButtonTextX + self.OpenMenuButtonX, self.OpenMenuButtonTextY + self.OpenMenuButtonY, ARGB(255,255,255,255))
    end
end

function MenuConfig:DrawMenu()
	if not self.MenuConfigOpen or menuconf.togglemenu then return end

	-- Draw top and bottom border
	DrawRectangle(MenuStartX - 5, 60 - 5, GlobalVar.MenuStartWidth + 10, 5, ARGB(70,0,0,0))
	DrawRectangle(MenuStartX - 5, MenuStartY, GlobalVar.MenuStartWidth + 10, 5, ARGB(70,0,0,0))

	local TopBorderIsDraw = {}
	local BottomBorderIsDraw = {}


	-- Draw menu
	for _, menu in pairs(globalMenu) do
		if menu.depth == 0 then
			if menu.header == "__menuconfig_option__" then
	    		self:DrawMenuTitle(menu.name, "cogwheel", menu.x, menu.y, GlobalVar.MenuStartWidth, MenuStartHeight, menu.open)
	    	else
	    		self:DrawMenuTitle(menu.name, "menu-hamburger", menu.x, menu.y, GlobalVar.MenuStartWidth, MenuStartHeight, menu.open)
	    	end
	    end

	    -- draw submenu
	    if menu.open then
	    	for _, _menu in pairs(menu.submenu) do

			    -- draw submenu bottom and top border
			    if _menu.parent ~= nil then
			    	if _menu.parent.open then
			    		if TopBorderIsDraw[_menu.parent.id] == nil then
		    				DrawRectangle(_menu.parent.subx - 5, _menu.parent.y - 5, _menu.parent.subwidth + 10, 5, ARGB(70,0,0,0))
		    				TopBorderIsDraw[_menu.parent.id] = true
		    			end

			    		if BottomBorderIsDraw[_menu.parent.id] == nil then
							DrawRectangle(_menu.parent.subx - 5, _menu.parent.y + _menu.parent.suby, _menu.parent.subwidth + 10, 5, ARGB(70,0,0,0))
							BottomBorderIsDraw[_menu.parent.id] = true
						end
			    	end
			    end


	    		if _menu.ismenu then
		    		if _menu.parent == menu then
		    			if not _menu.init then
		    				_menu.init = true
		    				_menu.subx = _menu.parent.subx + _menu.parent.subwidth + 10
		    			end
						self:DrawMenuTitle(_menu.name, _menu.icon, _menu.parent.subx, _menu.y, _menu.parent.subwidth, MenuStartHeight, _menu.open)
		    		end
		    	elseif _menu.issection then
		    		-- printDebug("draw section")
		    		if _menu.parent == menu  then
		    			if not _menu.init then
		    				textwidth, centerx = self:CenterText(_menu.name, 12, _menu.parent.subwidth)
		    				_menu.textwidth = textwidth
		    				_menu.centerx = centerx
		    				_menu.init = true
		    			end
		    			self:DrawMenuSection(_menu.name, _menu.parent.subx, _menu.y, _menu.parent.subwidth, MenuStartHeight, _menu.color, _menu.textwidth, _menu.centerx)
		    		end
		    	elseif _menu.isinfo then
		    		if _menu.parent == menu then
		    			self:DrawInfo(_menu.name, _menu.icon, _menu.parent.subx, _menu.y, _menu.parent.subwidth, MenuStartHeight)
		    		end
		    	elseif _menu.isboolean then
		    		if _menu.parent == menu then
		    			self:DrawBoolean(_menu.name, _menu.status, _menu.parent.subx, _menu.y, _menu.parent.subwidth, MenuStartHeight)
		    		end
		    	elseif _menu.iskeybinding or _menu.iskeytoggle then
		    		if _menu.parent == menu then
		    			self:DrawKeyBinding(_menu.name, _menu.status, _menu.key, _menu.currentkeychange, _menu.parent.subx, _menu.y, _menu.parent.subwidth, MenuStartHeight, _menu.open)
		    		end
		    	elseif _menu.isdropdown then
		    		if _menu.parent == menu then
		    			self:DrawDropDown(_menu.name, _menu.droptable, _menu.parent.subx, _menu.y, _menu.parent.subwidth, MenuStartHeight, _menu.open)
		    		end
		    	elseif _menu.iscolorpick then
		    		if _menu.parent == menu then
		    			self:DrawColorPick(_menu.name, _menu.instance[_menu.header], _menu.parent.subx, _menu.y, _menu.parent.subwidth, MenuStartHeight, _menu.open)
		    		end
		    	elseif _menu.isslider then
		    		if _menu.parent == menu then
		    			self:DrawSlider(_menu.name, _menu.value, _menu.minvalue, _menu.maxvalue, _menu.step, _menu.parent.subx, _menu.y, _menu.parent.subwidth, MenuStartHeight, _menu.open)
		    		end
		    	end

	    	end
	    end
	end
end

-- #endregion

-- #region Util Function
-------------------
----- util --------
-------------------

function MenuConfig:DrawTextIcon(icon,text, size, x, y, color)

    if icon == "menu-hamburger" then
        self.menuhamburgerSprite:SetScale(0.5, 0.5)
        self.menuhamburgerSprite:Draw(x - 20, y + 3, 255)
    elseif icon == "info-sign" then
    	self.infosignSprite:SetScale(0.5, 0.5)
    	self.infosignSprite:Draw(x - 20, y + 1, 255)
    elseif icon == "ok" then
    	self.okSprite:SetScale(0.5, 0.5)
    	self.okSprite:Draw(x - 20, y + 3, 255)
    elseif icon == "remove" then
    	self.removeSprite:SetScale(0.5, 0.5)
    	self.removeSprite:Draw(x - 19, y + 3, 255)
    elseif icon == "arrow-right" then
    	self.arrowrightSprite:SetScale(0.5, 0.5)
    	self.arrowrightSprite:Draw(x - 18, y + 3, 255)
    elseif icon == "eyedropper" then
    	self.eyedropperSprite:SetScale(0.5, 0.5)
    	self.eyedropperSprite:Draw(x - 18, y + 3, 255)
    elseif icon == "keyboard" then
    	self.keyboardSprite:SetScale(0.5, 0.5)
    	self.keyboardSprite:Draw(x - 20, y + 3, 255)
    elseif icon == "list" then
    	self.listSprite:SetScale(0.5, 0.5)
    	self.listSprite:Draw(x - 20, y + 3, 255)
    elseif icon == "adjust-alt" then
    	self.adjustaltSprite:SetScale(0.5, 0.5)
    	self.adjustaltSprite:Draw(x - 20, y + 3, 255)
    elseif icon == "cogwheel" then
    	self.cogwheelSprite:SetScale(0.5, 0.5)
    	self.cogwheelSprite:Draw(x - 20, y + 3, 255)
    elseif icon == "eye-open" then
    	self.eyeopenSprite:SetScale(0.5, 0.5)
    	self.eyeopenSprite:Draw(x - 21, y + 3, 255)
    elseif icon == "flag" then
    	self.flagSprite:SetScale(0.5, 0.5)
    	self.flagSprite:Draw(x - 18, y + 3, 255)
    elseif icon == "mouse" then
    	self.mouseSprite:SetScale(0.5, 0.5)
    	self.mouseSprite:Draw(x - 17, y + 3, 255)
    elseif icon == "target" then
    	self.targetSprite:SetScale(0.5, 0.5)
    	self.targetSprite:Draw(x - 20, y + 3, 255)
    elseif icon == "user" then
    	self.userSprite:SetScale(0.5, 0.5)
    	self.userSprite:Draw(x - 20, y + 3, 255)
    elseif icon == "bug" then
    	self.bugSprite:SetScale(0.5, 0.5)
    	self.bugSprite:Draw(x - 20, y + 3, 255)
	elseif icon == "clock" then
		self.clockSprite:SetScale(0.5, 0.5)
		self.clockSprite:Draw(x - 20, y + 3, 255)
	elseif icon == "cup" then
		self.cupSprite:SetScale(0.5, 0.5)
		self.cupSprite:Draw(x - 20, y + 3, 255)
	elseif icon == "eye-close" then
		self.eyecloseSprite:SetScale(0.5, 0.5)
		self.eyecloseSprite:Draw(x - 20, y + 3, 255)
	elseif icon == "gamepad" then
		self.gamepadSprite:SetScale(0.5, 0.5)
		self.gamepadSprite:Draw(x - 20, y + 3, 255)
	elseif icon == "heart" then
		self.heartSprite:SetScale(0.5, 0.5)
		self.heartSprite:Draw(x - 20, y + 3, 255)
	elseif icon == "leaf" then
		self.leafSprite:SetScale(0.5, 0.5)
		self.leafSprite:Draw(x - 20, y + 3, 255)
	elseif icon == "riflescope" then
		self.riflescopeSprite:SetScale(0.5, 0.5)
		self.riflescopeSprite:Draw(x - 20, y + 3, 255)
	elseif icon == "shield" then
		self.shieldSprite:SetScale(0.5, 0.5)
		self.shieldSprite:Draw(x - 20, y + 3, 255)
	elseif icon == "skull" then
		self.skullSprite:SetScale(0.5, 0.5)
		self.skullSprite:Draw(x - 20, y + 3, 255)
	elseif icon == "alert" then
		self.alertSprite:SetScale(0.5, 0.5)
		self.alertSprite:Draw(x - 20, y + 3, 255)
	end

    DrawText(text, size, x, y, color)
end

function MenuConfig:DrawMenuTitle(name, icon, x, y, width, height, selected)

    DrawRectangle(x - 5, y, 5, height, ARGB(50,0,0,0))
    DrawRectangle(x + width, y, 5, height, ARGB(50,0,0,0))

    if selected then
        DrawRectangle(x, y, width, height, ARGB(255,0,0,0))
    else
        DrawRectangle(x, y, width, height, ARGB(140,0,0,0))
    end
    self:DrawTextIcon(icon, name, MenuTextSize, 30 + x, 5 + y, ARGB(255,255,255,255))
    self.chevronrightSprite:SetScale(0.5, 0.5)
    self.chevronrightSprite:Draw(x + width - 15, y + 7, 255)
end

function MenuConfig:DrawSlider(text, value, minvalue, maxvalue, step, x, y, width, height, selected)
	-- draw border
	DrawRectangle(x - 5, y, 5, height, ARGB(50,0,0,0))
	DrawRectangle(x + width, y, 5, height, ARGB(50,0,0,0))


	-- draw background
	if selected then
	    DrawRectangle(x, y, width, height, ARGB(255,0,0,0))
	else
	    DrawRectangle(x, y, width, height, ARGB(140,0,0,0))
	end

	self.chevronrightSprite:SetScale(0.5, 0.5)
	self.chevronrightSprite:Draw(x + width - 15, y + 7, 255)
	self:DrawTextIcon("adjust-alt", text, MenuTextSize, 30 + x, 5 + y, ARGB(255,255,255,255))

	if selected then
		-- draw current Key
		-- draw border
		DrawRectangle(x + width + 10 - 5, y, 5, height, ARGB(50,0,0,0))
		DrawRectangle(x + width + 200 + 10, y, 5, height, ARGB(50,0,0,0))
		DrawRectangle(x + width + 5, y - 5, 200 + 10, 5, ARGB(70,0,0,0))
		DrawRectangle(x + width + 5, y + 25, 200 + 10, 5, ARGB(70,0,0,0))

		-- draw background
		DrawRectangle(x + width + 10, y, 200, height, ARGB(140,0,0,0))

		if value < minvalue then
			value = minvalue
		elseif value > maxvalue then
			value = maxvalue
		end
		-- draw slider
		-- draw sliderbar
		DrawRectangle(x + width + 10 + 40, y + 11, 100, 2, ARGB(140,255,255,255))
		-- draw sliderbutton

		cursor = ((value - minvalue) / (maxvalue - minvalue)) * 100
		-- printDebug(cursor)

		-- sliderbuttonx = x + width + 10 + 40 + ((((100 / maxvalue) * value) - minvalue) * (100 / minvalue))
		sliderbuttonx = x + width + 10 + 40 + cursor

		DrawRectangle(sliderbuttonx, y + 7, 5, 10, ARGB(255,255,255,255))

		-- draw value
		self:DrawTextIcon(nil, tostring(value), MenuTextSize, x + width + 10 + 40 + 100 + 10, 5 + y, ARGB(255,255,255,255))

		-- if color ~= nil then
		-- 	self:DrawTextIcon(nil, "current color :", MenuTextSize, 30 + x + width, 5 + y, ARGB(255,255,255,255))
		-- 	DrawRectangle(30 + x + width + 90, y + 5, 15, 15, ARGB(color[1], color[2], color[3], color[4]))
		-- else
		-- 	self:DrawTextIcon(nil, "current color : NONE", MenuTextSize, 30 + x + width, 5 + y, ARGB(255,255,255,255))
		-- end
	end
end

function MenuConfig:DrawColorPick(text, color, x, y, width, height, selected)
	-- draw border
	DrawRectangle(x - 5, y, 5, height, ARGB(50,0,0,0))
	DrawRectangle(x + width, y, 5, height, ARGB(50,0,0,0))

	-- draw background
	if selected then
	    DrawRectangle(x, y, width, height, ARGB(255,0,0,0))
	else
	    DrawRectangle(x, y, width, height, ARGB(140,0,0,0))
	end

	self.chevronrightSprite:SetScale(0.5, 0.5)
	self.chevronrightSprite:Draw(x + width - 15, y + 7, 255)
	self:DrawTextIcon("eyedropper", text, MenuTextSize, 30 + x, 5 + y, ARGB(255,255,255,255))

	if selected then
		-- draw current Key
		-- draw border
		DrawRectangle(x + width + 10 - 5, y, 5, height, ARGB(50,0,0,0))
		DrawRectangle(x + width + 200 + 10, y, 5, height, ARGB(50,0,0,0))
		DrawRectangle(x + width + 5, y - 5, 200 + 10, 5, ARGB(70,0,0,0))
		DrawRectangle(x + width + 5, y + 25, 200 + 10, 5, ARGB(70,0,0,0))

		-- draw background
		DrawRectangle(x + width + 10, y, 200, height, ARGB(140,0,0,0))
		if color ~= nil then
			self:DrawTextIcon(nil, "current color :", MenuTextSize, 30 + x + width, 5 + y, ARGB(255,255,255,255))
			DrawRectangle(30 + x + width + 90, y + 5, 15, 15, ARGB(color[1], color[2], color[3], color[4]))
		else
			self:DrawTextIcon(nil, "current color : NONE", MenuTextSize, 30 + x + width, 5 + y, ARGB(255,255,255,255))
		end
	end
end

function MenuConfig:DrawDropDown(text, droptable, x, y, width, height, selected)
	-- draw border
	DrawRectangle(x - 5, y, 5, height, ARGB(50,0,0,0))
	DrawRectangle(x + width, y, 5, height, ARGB(50,0,0,0))

	-- draw background
	if selected then
	    DrawRectangle(x, y, width, height, ARGB(255,0,0,0))
	else
	    DrawRectangle(x, y, width, height, ARGB(140,0,0,0))
	end

	self.chevronrightSprite:SetScale(0.5, 0.5)
	self.chevronrightSprite:Draw(x + width - 15, y + 7, 255)
	self:DrawTextIcon("list", text, MenuTextSize, 30 + x, 5 + y, ARGB(255,255,255,255))

	TopBorderIsDraw = {}

	if selected then
		for _, dropmenu in pairs(droptable) do
			subx = dropmenu.parent.parent.subx + dropmenu.parent.parent.subwidth + 5
			suby = dropmenu.y
			subwidth = dropmenu.parent.subwidth

			-- draw border
			DrawRectangle(subx, dropmenu.y, 5, height, ARGB(50,0,0,0))
			DrawRectangle(subx + dropmenu.parent.subwidth, dropmenu.y, 5, height, ARGB(50,0,0,0))

    		if TopBorderIsDraw[dropmenu.parent.id] == nil then
				DrawRectangle(subx, dropmenu.y - 5, dropmenu.parent.subwidth + 5, 5, ARGB(70,0,0,0))
				TopBorderIsDraw[dropmenu.parent.id] = true
			end

			if dropmenu.selected then
				-- draw background
				DrawRectangle(subx + 5, dropmenu.y, dropmenu.parent.subwidth - 5, height, ARGB(255,0,0,0))
				self:DrawTextIcon("arrow-right", dropmenu.name, MenuTextSize, 30 + subx, 5 + dropmenu.y, ARGB(255,255,255,255))
			else
				-- draw background
				DrawRectangle(subx + 5, dropmenu.y, dropmenu.parent.subwidth - 5, height, ARGB(140,0,0,0))
				self:DrawTextIcon(nil, dropmenu.name, MenuTextSize, 30 + subx, 5 + dropmenu.y, ARGB(255,255,255,255))
			end

		end

		DrawRectangle(subx, suby + 25, subwidth + 5, 5, ARGB(70,0,0,0))
	end
end

function MenuConfig:DrawKeyBinding(text, status, key, keychange, x, y, width, height, selected)
	-- draw border
	DrawRectangle(x - 5, y, 5, height, ARGB(50,0,0,0))
	DrawRectangle(x + width, y, 5, height, ARGB(50,0,0,0))

	-- draw background
	if selected then
	    DrawRectangle(x, y, width, height, ARGB(255,0,0,0))
	else
	    DrawRectangle(x, y, width, height, ARGB(140,0,0,0))
	end

	if not status then
		self.deactivatedSprite:SetScale(0.5, 0.5)
		self.deactivatedSprite:Draw(x + width - 30, y + 7, 255)
	else
		self.activatedSprite:SetScale(0.5, 0.5)
		self.activatedSprite:Draw(x + width - 30, y + 7, 255)
	end

	self.chevronrightSprite:SetScale(0.5, 0.5)
	self.chevronrightSprite:Draw(x + width - 15, y + 7, 255)
	self:DrawTextIcon("keyboard", text, MenuTextSize, 30 + x, 5 + y, ARGB(255,255,255,255))

	if selected then
		-- draw current Key
		-- draw border
		DrawRectangle(x + width + 10 - 5, y, 5, height, ARGB(50,0,0,0))
		DrawRectangle(x + width + 200 + 10, y, 5, height, ARGB(50,0,0,0))
		DrawRectangle(x + width + 5, y - 5, 200 + 10, 5, ARGB(70,0,0,0))
		DrawRectangle(x + width + 5, y + 25, 200 + 10, 5, ARGB(70,0,0,0))

		-- draw background
		DrawRectangle(x + width + 10, y, 200, height, ARGB(140,0,0,0))
		if key ~= nil and type(key) == "number" then
			if not keychange then
				if key == 32 then
					self:DrawTextIcon(nil, "current key :  SPACEBAR", MenuTextSize, 30 + x + width, 5 + y, ARGB(255,255,255,255))
				else
					self:DrawTextIcon(nil, "current key :  " .. string.char(key), MenuTextSize, 30 + x + width, 5 + y, ARGB(255,255,255,255))
				end
			else
				self:DrawTextIcon(nil, "current key :  Press new key", MenuTextSize, 30 + x + width, 5 + y, ARGB(255,255,255,255))
			end
		else
			if not keychange then
				self:DrawTextIcon(nil, "current key : NONE", MenuTextSize, 30 + x + width, 5 + y, ARGB(255,255,255,255))
			else
				self:DrawTextIcon(nil, "current key :  Press new key", MenuTextSize, 30 + x + width, 5 + y, ARGB(255,255,255,255))
			end
		end
	end
end

function MenuConfig:DrawBoolean(text, status, x, y, width, height)
	-- draw border
	DrawRectangle(x - 5, y, 5, height, ARGB(50,0,0,0))
	DrawRectangle(x + width, y, 5, height, ARGB(50,0,0,0))

	-- draw background
	DrawRectangle(x, y, width, height, ARGB(140,0,0,0))
	if not status then
		self:DrawTextIcon("remove", text, MenuTextSize, 30 + x, 5 + y, ARGB(255,255,255,255))
	else
		self:DrawTextIcon("ok", text, MenuTextSize, 30 + x, 5 + y, ARGB(255,255,255,255))
	end
end

function MenuConfig:DrawInfo(text, icon, x, y, width, height)
	-- draw border
	DrawRectangle(x - 5, y, 5, height, ARGB(50,0,0,0))
	DrawRectangle(x + width, y, 5, height, ARGB(50,0,0,0))

	if icon == nil then
		icon = "info-sign"
	end

	-- draw background
	DrawRectangle(x, y, width, height, ARGB(140,0,0,0))
	self:DrawTextIcon(icon, text, MenuTextSize, 30 + x, 5 + y, ARGB(255,255,255,255))
end

function MenuConfig:DrawMenuSection(name, x, y, width, height, color, textwidth, centerx)

    DrawRectangle(x - 5, y, width + 10, height, ARGB(50,0,0,0))

    local pos = math.floor(height / 2)
    local pos2 = (height + 1) - pos

    DrawRectangle(x, y, width, height - pos, ARGB(110,0,0,0))
    DrawRectangle(x, y + pos2, width, height - pos2, ARGB(110,0,0,0))


    DrawRectangle(x + centerx - 2, y + 8, textwidth + 3, 11, ARGB(255,0,0,0))
    self:DrawTextIcon(nil, name, 12, x + centerx, 7 + y, color)
    -- self.chevronrightSprite:SetScale(0.5, 0.5)
    -- self.chevronrightSprite:Draw(x + width - 15, y + 9, 255)
end

function MenuConfig:CenterText(text, textsize, width)
    -- if string.find(text, " ") ~= nil then
    --     size = string.len(text)
    --     textwidth = size * (textsize / 1.9)
    --     result = (width - textwidth) / 2
    -- else
    --     size = string.len(text)
    --     textwidth = size * (textsize / 1.68)
    --     result = (width - textwidth) / 2 
    -- end

    textwidth = GetTextArea(text, textsize).x
    result = (width - textwidth) / 2

    return textwidth, result
end

function MenuConfig:CalculateWidth(text)
    size = GetTextArea(text, MenuTextSize).x
    return size + 80
end

-- #endregion
