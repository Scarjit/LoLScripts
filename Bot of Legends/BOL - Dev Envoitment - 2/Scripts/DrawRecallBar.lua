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