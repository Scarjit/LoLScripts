class("S1mple_Timer")
function S1mple_Timer:__init()
	self.clocks = {}
	AddTickCallback(function ()
		self:updateClocks()
	end)
end

function S1mple_Timer:updateClocks()
	for i,v in pairs(self.clocks) do
		if v and GetGameTimer() > v.t then
			if v.r > 0 then
				self.clocks[i].r = v.r-1
				v.c()
				self.clocks[i].t = v.t+v.i
			else
				self.clocks[i] = nil
			end
		end
	end
end

function S1mple_Timer:AddTimer(time,callback,reoccuring,interval)
	if time and callback then
		self.clocks[#self.clocks+1] = {t = time+GetGameTimer(),c = callback, r = reoccuring and reoccuring or 1,i = interval or 1}
	end
end
STimer = S1mple_Timer()

function OnLoad()
	STimer:AddTimer(1,function ()
		print("Hello World Current Time is:"..GetGameTimer())
	end,3,0.5)

	STimer:AddTimer(3,function ()
		print("Hello i will tick every 1 sec, until game end")
	end,math.huge,1)
end