--By S1mple
local oldprint = print
local stack = {}
local isopen = false --start console closed
local currentPos = 0
local msgsincelastopen = 0
local autoscroll = false
local showcaller = true

_G.print = function(...)
	function pack(...)
	    return { n = select("#", ...); ... }
	end

	function show(...)
	    local string = ""

	    local args = pack(...)

	    for i = 1, args.n do
	        string = string .. tostring(args[i]) .. "\t"
	    end

	    return string
	end

		printResult = show(...)
	if showcaller then
		local calling_script = debug.getinfo(2).short_src
		stack[#stack+1] = calling_script.." : "..printResult
	else
		stack[#stack+1] = printResult
	end
	if not isopen then
		msgsincelastopen = msgsincelastopen+1
	end
end

function OnWndMsg(msg,param)
	if msg == 512 then return end
	if msg == 522 then
		if param == 7864320 then --Scroll Up
			if currentPos > 1 then
				currentPos = currentPos - 1
			end
		elseif param == 4287102976 then --Scroll Down
			if currentPos < #stack-16 then
				currentPos = currentPos + 1
			end
		end
	end
	if msg == 513 then
		local wts = WorldToScreen(D3DXVECTOR3(mousePos))
		if wts.x < 125 and wts.y < 25 and not isopen then
			msgsincelastopen = 0
			isopen = true
		elseif wts.x < 120 and wts.y > 350 and wts.y < 375 and isopen then
			stack = {}
			currentPos = 0
		elseif wts.x > 120 and wts.x < 240 and wts.y > 350 and wts.y < 375 and isopen then
			currentPos = #stack-16
		elseif wts.x > 120 and wts.x < 240 and wts.y > 375 and wts.y < 400 and isopen then
			autoscroll = not autoscroll
		elseif wts.x > 240 and wts.x < 360 and wts.y > 350 and wts.y < 375 and isopen then
			isopen = false
		elseif wts.x > 360 and wts.x < 480 and wts.y > 350 and wts.y < 375 and isopen then
			showcaller = not showcaller
		end
	end
end

function OnDraw()
	if isopen then
		if autoscroll then
			currentPos = #stack-16
		end

		DrawRectangle(0,0,WINDOW_W,350,ARGB(128,0,0,0))
		local n = 0
		for i=currentPos,currentPos+16 do
			if stack[i] then
				DrawTextA(i.." : "..stack[i],12,20,5+20*n)
			end
			n = n+1
		end
		--Advanced
		DrawRectangle(0,350,120,25,ARGB(128,255,0,0))
		DrawTextA("Clear Console", 15,20,355)

		DrawRectangle(120,350,120,25,ARGB(128,0,255,0))
		DrawTextA("Scroll to latest", 15,140,355)

		DrawRectangle(120,375,120,25,ARGB(128,0,255,255))
		if not autoscroll then
			DrawTextA("Auto-Scroll OFF", 15,140,380,ARGB(255,255,0,255))
		else
			DrawTextA("Auto-Scroll ON", 15,140,380,ARGB(255,0,255,255))
		end

		DrawRectangle(240,350,120,25,ARGB(128,0,0,255))
		DrawTextA("Close Console", 15,260,355)

		DrawRectangle(360,350,120,25,ARGB(128,255,0,255))
		if not showcaller then
			DrawTextA("Show Script OFF", 15,375,355)
		else
			DrawTextA("Show Script ON", 15,375,355)
		end
	else
		DrawRectangle(0,0,125,25,ARGB(200,0,0,0))
		if msgsincelastopen > 0 then
			DrawTextA("Missed Messages: "..msgsincelastopen,12,0,5)
		else
			DrawTextA("Open Console",12,20,5)
		end
	end
end