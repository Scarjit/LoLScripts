--Set to false to disable autoupdate
autoupdate = true

require("SxOrbWalk")
SX = SxOrb()

function OnLoad()
	if autoupdate then
			SUpdate()
	end
	print("Sx Bridge Loader loaded")
	if SxOrb.Version > 3.29 then
		print("New SxOrbWalk detected, please delete SxBridgeLoader")
	end
end

--https://raw.githubusercontent.com/Superx321/BoL/master/common/SxOrbWalk.Version


class('SUpdate')
function SUpdate:__init()
	self.updating = false
	self.updated = false
	AddDrawCallback(function ()
		self:draw()
	end)
	self:download()
end

function SUpdate:download()
	self.updating = true
	local serveradress = "raw.githubusercontent.com"
	local scriptadress = "/Superx321/BoL/master/common/"
	local ServerVersionDATA = GetWebResult(serveradress , scriptadress.."/SxOrbWalk.Version")
	if ServerVersionDATA then
		local ServerVersion = tonumber(ServerVersionDATA)
		if ServerVersion then
			if ServerVersion > tonumber(3.29) then
				print("Updating, don't press F9")
				DownloadFile("https://"..serveradress..scriptadress.."/SxOrbWalk.lua",LIB_PATH.."SxOrbWalk.lua", function ()
					updated = true
				end)
			end
		else
			print("An error occured, while updating, please reload")
		end
	else
		print("Could not connect to update Server")
	end
	self.updating = false
end

function SUpdate:draw()
	local w, h = WINDOW_W, WINDOW_H
	if self.updating then
		DrawTextA("[SxBridgeLoader] Updating", 25, 10,h*0.05,ARGB(255,255,255,255), "left", "center")
	end
	if updated then
		DrawTextA("[SxBridgeLoader] Updated, press 2xF9", 25, 10,h*0.05,ARGB(255,255,255,255), "left", "center")
	end
end
