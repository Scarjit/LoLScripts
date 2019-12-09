function OnLoad()
	QQQ = BarUnderObject()
	QQQ:AddBar(myHero, 10, nil, nil, 5)
end


class "BarUnderObject"
function BarUnderObject:__init()
	self.bars = {}
	self.draw = true
	AddDrawCallback(function ()
		self:OnDraw()
	end)
	AddTickCallback(function ()
		self:DeleteInvalid()
	end)
end

function BarUnderObject:OnDraw()
	DrawTextA(#self.bars)

	local w = WINDOW_W
	local h = WINDOW_H
	for i,v in pairs(self.bars) do
		local wts = WorldToScreen(D3DXVECTOR3(v.obj.x,v.obj.y,v.obj.z))
		local percentage = ((v.time-os.clock())/v.t)*100
		DrawLineBorder(wts.x-v.maxsize*(percentage/2),wts.y,wts.x+v.maxsize*(percentage/2),wts.y,12,v.color,1)
		DrawLine(wts.x-v.maxsize*(percentage/2)+1,wts.y,wts.x+v.maxsize*(percentage/2),wts.y, 11, v.fillcolor )
		DrawTextA(math.round(v.time-os.clock(),1),12,wts.x,wts.y-5)
	end
end

function BarUnderObject:AddBar(_obj,_time,_color, _fillcolor,_maxsize)
	if not _color then _color = ARGB(128,255,255,255) end
	if not _fillcolor then _fillcolor = ARGB(128,0,255,0) end
	if not _maxsize then _maxsize = 1.5 end

	if _obj.valid and _time and _time > 0 then
		self.bars[#self.bars+1] = {obj = _obj, t = _time, time = os.clock()+_time, color = _color, fillcolor = _fillcolor, maxsize = _maxsize}
	end
end

function BarUnderObject:RemoveBar(_obj)
	local n = {}
	for _, v in pairs(self.bars) do
		if v.obj ~= _obj then
			n[#n+1] = v
		end
	end
	self.bars = nil
	self.bars = n
end

function BarUnderObject:DeleteInvalid()
	local n = {}
	for _, v in pairs(self.bars) do
		if v.obj and v.obj.valid and v.time > os.clock() then
			n[#n+1] = v
		end
	end
	self.bars = nil
	self.bars = n
end


















--[[
function OnLoad()
	RB = RecallBar()
	RB:AddBar(myHero, true)
	RB:AddBar(myHero, true)
	RB:AddBar(myHero, false)
	RB:AddBar(myHero, true)
	DelayAction(function ()
		RB:RemoveBar(myHero)
	end,2)
end


class "RecallBar"
function RecallBar:__init()
	self.bars = {}
	self.draw = true
	AddDrawCallback(function ()
		self:OnDraw()
	end)
	AddTickCallback(function ()
		self:CheckIfTimeUp()
	end)
end

function RecallBar:AddBar(_hero,_hasbaron)
	if not _hero then return end
	if _hasbaron then
		t = os.clock() + 4
	else
		t = os.clock() + 8
	end
	self.bars[#self.bars+1] = {hero = _hero, time = t, hasbaron = _hasbaron}
end

function RecallBar:RemoveBar(_hero)
	if not _hero then return end
	local sb = {}
	for _,v in pairs(self.bars) do
		if v.hero ~= _hero then
			sb[#sb+1] = v
		end
	end
	self.bars = nil
	self.bars = sb
end

function RecallBar:CheckIfTimeUp()
	local sb = {}
	for _, v in pairs(self.bars) do
		if v.time-os.clock() > 0 then
			sb[#sb+1] = v
		end
	end
	self.bars = nil
	self.bars = sb
end

function RecallBar:OnDraw()
	local w = WINDOW_W
	local h = WINDOW_H
	for i, v in pairs(self.bars) do
		local n = 8
		if v.hasbaron then
			n = 4
		end
		local percentage = ((v.time-os.clock())/n)*1
		local m = w/3-w/1.4
		DrawLineBorder(w/3, h/1.25-20*i+20, w/1.4, h/1.25-20*i+20, 18, ARGB(255,255,255,255), 1)
		DrawLine(w/3, h/1.25-20*i+20, w/1.4+m*percentage, h/1.25-20*i+20, 18, ARGB(128,255,255,255))
		DrawTextA(v.hero.charName.. " is Recalling: "..math.round(v.time-os.clock()),18,w/2.1,h/1.262-20*i+20)
	end
end

]]--