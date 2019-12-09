class'LawsUi'
function LawsUi:__init()
	self.pages = {}
	self.input = LawsInput()
	AddDrawCallback(function() self:drawManager() end)
	AddMsgCallback(function(msg,wParam) self:eventChecker(msg,wParam) end)
	return self
end

function LawsUi:addPage(name)
	local page = LawsPage(name)
	table.insert(self.pages, page)
	return page
end

function LawsUi:eventChecker(msg, wParam)
	for x = 1, #self.pages do
		if self.pages[x].showPage then
			for i = 1, #self.pages[x].objects do
				for c = 1, #self.pages[x].objects[i].data.events do
					if self.pages[x].objects[i].data.events[c]._type == "mouseup" and msg == 514 and self.pages[x].objects[i].data:hover() then self.pages[x].objects[i].data.events[c]._callback() end
					if self.pages[x].objects[i].data.events[c]._type == "mousedown" and msg == 513 and self.pages[x].objects[i].data:hover() then self.pages[x].objects[i].data.events[c]._callback() end
					if self.pages[x].objects[i].data.events[c]._type == "mousemove" and msg == 512 and self.pages[x].objects[i].data:hover() then self.pages[x].objects[i].data.events[c]._callback() end
				end
			end
		end
	end
end

function LawsUi:drawManager()
	for x = 1, #self.pages do
		if self.pages[x].showPage then
			for z = 1, self.pages[x].maxLayer do
				for i = 1, #self.pages[x].objects do
					if self.pages[x].objects[i].data.layer == z then				
						if self.pages[x].objects[i]._type == "sprite" then 
							self.pages[x].objects[i].data.sprite:SetScale(self.pages[x].objects[i].data.width/self.pages[x].objects[i].data.sprite.width, self.pages[x].objects[i].data.height/self.pages[x].objects[i].data.sprite.height)
							self.pages[x].objects[i].data.sprite:Draw(self.pages[x].objects[i].data.x,self.pages[x].objects[i].data.y,0xFF)
						end
						if self.pages[x].objects[i]._type == "text" then 
							DrawText(self.pages[x].objects[i].data.text,self.pages[x].objects[i].data.size, self.pages[x].objects[i].data.x, self.pages[x].objects[i].data.y, self.pages[x].objects[i].data.color)
						end					
					end
				end
			end
		end
	end
end


class'LawsSprite'
function LawsSprite:__init(file)
	self.layer = 1
	self.path = file
	self.x = 0
	self.y = 0
	self.events = {}
	self.sprite = createSprite(file)
	self.width = self.sprite.width
	self.height = self.sprite.height
	return self
end

function LawsSprite:On(eventType,callback)
	table.insert(self.events, {_type=eventType,_callback=callback})
end

function LawsSprite:setPosition(x,y)
	self.x = x
	self.y = y
end

function LawsSprite:setScale(x,y)
	self.width = x
	self.height = y
end

function LawsSprite:setLayer(n)
	self.layer = n
end

function LawsSprite:hover()
    local posX, posY = GetCursorPos().x, GetCursorPos().y
    if self.height == nil then self.height = self.width end
    if self.width < 0 then
        self.x = self.x + self.width
        self.width = -self.width
    end
    if self.height < 0 then
        self.y = self.y + self.height
        self.height = -self.height
    end
    return (posX >= self.x and posX <= self.x + self.width and posY >= self.y and posY <= self.y + self.height)
end


class'LawsInput'

function LawsInput:__init()
	self.data = ""
	self.record = false
	return self
end

function LawsInput:startInput()
	self.input.record = true
end

function LawsInput:stopInput()
	self.input.record = false
end

function LawsInput:getInput()
	return self.input.data
end

function LawsInput:clearInput()
	self.input.data = ""
end

function LawsInput:inputChecker(msg,wParam)
	if self.record and msg == 257 and wParam == 8 then self.data = self.data:sub(1, #self.data - 1) end
	if self.record and msg == 257 and wParam ~= 8 then self.data = self.data..self:getCharFromKey(msg) end
end

function LawsInput:getCharFromKey(msg)
	keys = {
		_32 = " ",
		_48 = "0",
		_49 = "1",
		_50 = "2",
		_51 = "3",
		_52 = "4",
		_53 = "5",
		_54 = "6",
		_55 = "7",
		_56 = "8",
		_57 = "9",
		_65 = "a",
		_66 = "b",
		_67 = "c",
		_68 = "d",
		_69 = "e",
		_70 = "f",
		_71 = "g",
		_72 = "h",
		_73 = "i",
		_74 = "j",
		_75 = "k",
		_76 = "l",
		_77 = "m",
		_78 = "n",
		_79 = "o",
		_80 = "p",
		_81 = "q",
		_82 = "r",
		_83 = "s",
		_84 = "t",
		_85 = "u",
		_86 = "v",
		_87 = "w",
		_88 = "x",
		_89 = "y",
		_90 = "z",
	}
	if keys["_"..msg] then
		return keys["_"..msg]
	else
		return ""
	end
end

class'LawsText'
function LawsText:__init(text)
	self.text = text
	self.color = 0xFF00FF00
	self.size = 12
	self.x = 0
	self.events = {}
	self.layer = 1
	self.y = 0
	return self
end

function LawsText:hover()
	local textArea = GetTextArea(self.text,self.size)
    local posX, posY = GetCursorPos().x, GetCursorPos().y
    if textArea.y == nil then textArea.y = textArea.x end
    if textArea.x < 0 then
        self.x = self.x + textArea.x
        textArea.x = -textArea.x
    end
    if textArea.y < 0 then
        self.y = self.y + textArea.y
        textArea.y = -textArea.y
    end
    return (posX >= self.x and posX <= self.x + textArea.x and posY >= self.y and posY <= self.y + textArea.y)
end

function LawsText:setPosition(x,y)
	self.x = x
	self.y = y
end

function LawsText:setSize(size)
	self.size = size
end

function LawsText:setLayer(n)
	self.layer = n
end

function LawsText:On(eventType,callback)
	table.insert(self.events, {_type=eventType,_callback=callback})
end

class'LawsPage'
function LawsPage:__init()
	self.objects = {}
	self.maxLayer = 10
	self.showPage = false
	return self
end

function LawsPage:show()
	self.showPage = true
end

function LawsPage:hide()
	self.showPage = false
end

function LawsPage:setMaxLayer(n)
	self.maxLayer = n
end

function LawsPage:addSprite(file)
    if FileExist(file) then
		local sprite = LawsSprite(file)
		table.insert(self.objects, {_type="sprite",data=sprite})
		return sprite
	end
end

function LawsPage:addText(text)
	local text = LawsText(text)
	table.insert(self.objects, {_type="text",data=text})
	return text
end
