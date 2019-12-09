class("SDL")
function SDL:__init()
	print("QQQ")

	self.globalspeed = 0.002
	AddTickCallback(function ()
		self:Tick()
	end)
end

function SDL:Tick()
	if not rot then
		rot = 0
	end
	rot = rot + self.globalspeed --Global Speed Param
	if rot > 6.28318 then
		rot = 0
	end
end

--[[
                 _                 _           _   _______ _                       ____             
     /\         (_)               | |         | | |__   __(_)                     |  _ \            
    /  \   _ __  _ _ __ ___   __ _| |_ ___  __| |    | |   _ _ __ ___   ___ _ __  | |_) | __ _ _ __ 
   / /\ \ | '_ \| | '_ ` _ \ / _` | __/ _ \/ _` |    | |  | | '_ ` _ \ / _ \ '__| |  _ < / _` | '__|
  / ____ \| | | | | | | | | | (_| | ||  __/ (_| |    | |  | | | | | | |  __/ |    | |_) | (_| | |   
 /_/    \_\_| |_|_|_| |_| |_|\__,_|\__\___|\__,_|    |_|  |_|_| |_| |_|\___|_|    |____/ \__,_|_|   
                                                                                                    
]]--


function SDL:DrawTimerBar(x,y,width,height,time,fillcolor,outlinecolor,outlinethick,reverse,text,size,textcolor)
	class("Bar")
	function Bar:__init(x,y,width,height,time,fillcolor,outlinecolor,outlinethick,reverse,text,size,textcolor)
		self.x = x
		self.y = y
		self.width = width
		self.height = height
		self.time = os.clock()+time
		self.start = self.time-os.clock()
		self.fillcolor = fillcolor
		self.outlinecolor = outlinecolor
		self.outlinethick = outlinethick
		self.reverse = reverse
		self.text = text or ""
		self.size = size or 12
		self.textcolor = textcolor or ARGB(255,255,255,255)
		AddDrawCallback(function ()
			self:Draw()
		end)
	end
	function Bar:Draw()
		if self.time <= os.clock() then return end
		local t = ((self.time-os.clock())/self.start)
		if self.reverse then t = 1-t end
		local m = self.height/2
		DrawLine(self.x, self.y+m, (self.x+self.width)-self.width*t, self.y+m, self.height, self.fillcolor)
		DrawRectangleOutline(self.x, self.y, self.width, self.height, self.outlinecolor, self.outlinethick)
		DrawText(self.text,self.size, (self.x+self.width)-self.width*t, self.y-self.size,self.textcolor)

	end
	return Bar(x,y,width,height,time,fillcolor,outlinecolor,outlinethick,reverse,text,size,textcolor)
end

function SDL:DrawTimerBarVertical(x,y,width,height,time,fillcolor,outlinecolor,outlinethick,reverse,text,size,textcolor)
	class("Bar")
	function Bar:__init(x,y,width,height,time,fillcolor,outlinecolor,outlinethick,reverse,text,size,textcolor)
		self.x = x
		self.y = y
		self.width = width
		self.height = height
		self.time = os.clock()+time
		self.start = self.time-os.clock()
		self.fillcolor = fillcolor
		self.outlinecolor = outlinecolor
		self.outlinethick = outlinethick
		self.reverse = reverse
		self.text = text or ""
		self.size = size or 12
		self.textcolor = textcolor or ARGB(255,255,255,255)
		AddDrawCallback(function ()
			self:Draw()
		end)
	end
	function Bar:Draw()
		if self.time <= os.clock() then return end
		local t = ((self.time-os.clock())/self.start)
		if self.reverse then t = 1-t end
		local m = self.width/2

		DrawLine(self.x, self.y, self.x, self.y-self.height*t, self.width, self.fillcolor)
		DrawRectangleOutline(self.x-m, self.y-self.height, self.width, self.height, self.outlinecolor, self.outlinethick)
		DrawText(self.text,self.size, self.x+m, self.y-self.height*t,self.textcolor)
	end

	return Bar(x,y,width,height,time,fillcolor,outlinecolor,outlinethick,reverse,text,size,textcolor)
end

--[[
                 _                 _           _   _______   _                   _      
     /\         (_)               | |         | | |__   __| (_)                 | |     
    /  \   _ __  _ _ __ ___   __ _| |_ ___  __| |    | |_ __ _  __ _ _ __   __ _| | ___ 
   / /\ \ | '_ \| | '_ ` _ \ / _` | __/ _ \/ _` |    | | '__| |/ _` | '_ \ / _` | |/ _ \
  / ____ \| | | | | | | | | | (_| | ||  __/ (_| |    | | |  | | (_| | | | | (_| | |  __/
 /_/    \_\_| |_|_|_| |_| |_|\__,_|\__\___|\__,_|    |_|_|  |_|\__,_|_| |_|\__, |_|\___|
                                                                            __/ |       
                                                                           |___/        
]]

function SDL:DrawTriangle(x,y,width,height,time,fillcolor,outlinecolor,outlinethick,reverse)
	class("Triangle")
	function Triangle:__init(x,y,width,height,time,fillcolor,outlinecolor,outlinethick,reverse)
		self.x = x
		self.y = y
		self.width = width
		self.height = height
		self.time = os.clock()+time
		self.start = self.time-os.clock()
		self.fillcolor = fillcolor
		self.outlinecolor = outlinecolor
		self.outlinethick = outlinethick
		self.reverse = reverse
		AddDrawCallback(function ()
			self:Draw()
		end)
		print("QQ")
	end
	function Triangle:Draw()
		if self.time <= os.clock() then return end
		local t = ((self.time-os.clock())/self.start)
		if self.reverse then t = 1-t end

		DrawLine(self.x, self.y, self.x+self.width, self.y, self.outlinethick, self.outlinecolor)
		DrawLine(self.x, self.y, self.x+self.width, self.y-self.height, self.outlinethick, self.outlinecolor)
		DrawLine(self.x+self.width, self.y, self.x+self.width, self.y-self.height, self.outlinethick, self.outlinecolor)

		local m = self.width*-1
		local h = self.height
		DrawTextA(t)
		for i=0,self.width*(1-t) do
			DrawLine(self.x+self.width+m+i, self.y, self.x+self.width+m+i, self.y-self.height-i, 1, fillcolor)
		end
	end

	return Triangle(x,y,width,height,time,fillcolor,outlinecolor,outlinethick,reverse)
end