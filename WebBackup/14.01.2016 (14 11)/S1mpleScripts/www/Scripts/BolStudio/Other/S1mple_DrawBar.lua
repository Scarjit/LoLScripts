--[[
   _____ __                 _        _____                     ____               _              _____ __                 _       _____           _       _       
  / ____/_ |               | |      |  __ \                   |  _ \             | |            / ____/_ |               | |     / ____|         (_)     | |      
 | (___  | |_ __ ___  _ __ | | ___  | |  | |_ __ __ ___      _| |_) | __ _ _ __  | |__  _   _  | (___  | |_ __ ___  _ __ | | ___| (___   ___ _ __ _ _ __ | |_ ___ 
  \___ \ | | '_ ` _ \| '_ \| |/ _ \ | |  | | '__/ _` \ \ /\ / /  _ < / _` | '__| | '_ \| | | |  \___ \ | | '_ ` _ \| '_ \| |/ _ \\___ \ / __| '__| | '_ \| __/ __|
  ____) || | | | | | | |_) | |  __/ | |__| | | | (_| |\ V  V /| |_) | (_| | |    | |_) | |_| |  ____) || | | | | | | |_) | |  __/____) | (__| |  | | |_) | |_\__ \
 |_____/ |_|_| |_| |_| .__/|_|\___| |_____/|_|  \__,_| \_/\_/ |____/ \__,_|_|    |_.__/ \__, | |_____/ |_|_| |_| |_| .__/|_|\___|_____/ \___|_|  |_| .__/ \__|___/
                     | |                                                                 __/ |                     | |                             | |            
                     |_|                                                                |___/                      |_|                             |_|            
]]--

--Credits: Jorj, for barOffsets

function OnLoad()
	print("Loaded")
	db = DrawBar()
	db:addLine(myHero, os.clock(), os.clock()+30,255,255,255,255,255,0,255,0,true,true)


end

class("DrawBar") --By S1mple
function DrawBar:__init()
	self.bars = {}
end

function DrawBar:addLine(target, starttime, endtime, alpha, red, green, blue, alphafade, redfade, greenfade, bluefade, inc, delondeath) --Time in Seconds
	--[[Usage:
	target = any obj with an position
	starttime/endtime any game Times (os.clock)
	alpha, red, green, blue = Standart ARGB Color Coding

	Optional:
		alphafade, redfade, greenfade, bluefade = Standart ARGB Color Coding
		inc = If true the Bar will increase, else it will decrease
		delondeath = Auto deletes the Line on object death

	]]--
	if not target then target = myHero end
	if not starttime then error("starttime required") end
	if not endtime then error("endtime required") end
	if not alpha then alpha = 255 end
	if not red then red = 255 end
	if not green then green = 255 end
	if not blue then blue = 255 end
	if not inc then inc = false end
	if not delondeath then delondeath = false end

	if not alphafade then alphafade = alpha end
	if not redfade then redfade = red end
	if not greenfade then greenfade = green end
	if not bluefade then bluefade = blue end

	local nb = {}
	table.insert(nb,target.networkID)
	table.insert(nb,starttime)
	table.insert(nb,endtime)
	table.insert(nb,alpha)
	table.insert(nb,red)
	table.insert(nb,green)
	table.insert(nb,blue)
	table.insert(nb,alphafade)
	table.insert(nb,redfade)
	table.insert(nb,greenfade)
	table.insert(nb,bluefade)
	table.insert(nb,inc)
	table.insert(nb,delondeath)
	table.insert(self.bars, nb)
end

function DrawBar:draw()
	for _,bar in pairs(self.bars) do
		local starttime = 0
		local endtime = 0
		local target = nil
		local inc = false
		local alpha, red, green, blue, alphafade, redfade, greenfade, bluefade = 255
		for v,k in pairs(bar) do
			if v == 1 then 
				target = objManager:GetObjectByNetworkId(k)
			elseif v == 2 then
				starttime = k
			elseif v == 3 then
				endtime = k
			elseif v == 4 then
				alpha = k
			elseif v == 5 then
				red = k
			elseif v == 6 then
				green = k
			elseif v == 7 then
				blue = k
			elseif v == 8 then
				alphafade = k
			elseif v == 9 then
				redfade = k
			elseif v == 10 then
				greenfade = k
			elseif v == 11 then
				bluefade = k
			elseif v == 12 then
				inc = k
			end
		end
		if starttime < endtime and starttime < os.clock() and endtime > os.clock() then
			local lenght = 130
			--Calc lenght
			local deltat = endtime - starttime
			local mult = endtime - os.clock()
			local multiplier = mult/deltat
			multiplier = multiplier
			if not inc then
				lenght = lenght * multiplier
			else
				lenght = 130 - lenght * multiplier
			end

			--Calc color
			alphaN = (alpha * multiplier) + (alphafade - (alphafade * multiplier))
			redN = (red * multiplier) + (redfade - (redfade * multiplier))
			greenN = (green * multiplier) + (greenfade - (greenfade * multiplier))
			blueN = (blue * multiplier) + (bluefade - (bluefade * multiplier))
			
			if multiplier >= 0 then
				local barPos = GetUnitHPBarPos(target) --THANKS Jori
				local barOffset = GetUnitHPBarOffset(target)
				do -- For some reason the x offset never exists
					local t = {
						["Darius"] = -0.05,
						["Renekton"] = -0.05,
						["Sion"] = -0.05,
						["Thresh"] = 0.03,
					}
					barOffset.x = t[target.charName] or 0
				end

				local baseX = barPos.x - 69 + barOffset.x * 150
				local baseY = barPos.y + barOffset.y * 50 + 12.5

				local yoffset = 10 --Increase to move the Line down more
				local px = baseX
				local py = baseY+yoffset
				local cx = baseX+lenght
				local cy = baseY+yoffset
				DrawLine(px, py, cx, cy, 7, ARGB(alphaN, redN, greenN, blueN))
			end
		end
	end
end

function DrawBar:update()
	for _,bar in pairs(self.bars) do
		local endtime = 0
		local delete = false
		local obj = nil
		for k,v in pairs(bar) do
			if k == 1 then 
				obj = objManager:GetObjectByNetworkId(v)
			end
			if k == 3 then endtime = v end
			if k == 13 then 
				if obj.dead then
					delete = true
				end
			end
		end
		if (endtime < os.clock()) or delete == true then
			table.clear(bar)
		end
	end
end

function DrawBar:delete(target)
	for _,bar in pairs(self.bars) do
		local delete = false
		for k,v in pairs(bar) do
			if k == 1 then
				if v == target.networkID then
					delete = true
				end
			end
		end
		if delete == true then
			table.clear(bar)
		end
	end
end


AddTickCallback(function()
	db:update()
end)

AddDrawCallback(function()
	db:draw()
end)