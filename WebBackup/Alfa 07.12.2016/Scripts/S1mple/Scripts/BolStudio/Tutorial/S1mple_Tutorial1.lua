local version = 0.2 --The Version of your Local Scripts

function OnLoad()
	SUpdate() --Run SUpdate
	-- Rest of your code goes here
end




class('SUpdate')
function SUpdate:__init()
	self.updating = false --This will be true, if the Updater searches for an update and/or downloads it.
	self.updated = false --This will be true, if the Script has been updated.
	AddDrawCallback(function () --This add's an Draw Callback to SUpdate:draw(), so it will be executed everytime OnDraw is executed
		self:draw()
	end)
	self:download() --Runs SUpdate:download()
end

function SUpdate:download()
	self.updating = true --Set's updating to true, cause the update Process has Started
	local serveradress = "scarjit.de" --The adress of the Webserver, you are updating from (scarjit.de is my Webserver)
	local scriptadress = "/S1mpleScripts/Scripts/BolStudio/Tutorial" --The Remote Path to the Files
	local ServerVersionDATA = GetWebResult(serveradress , scriptadress.."/S1mple_Tutorial1.version") --This will get the Server Version of the Script
	if ServerVersionDATA then
		local ServerVersion = tonumber(ServerVersionDATA) --This will convert the returned String into a Number, so we can easily compare it
		if ServerVersion then
			if ServerVersion > tonumber(version) then --If the Server has a newer Version then:
				print("Updating, don't press F9")
				DownloadFile("http://"..serveradress..scriptadress.."/S1mple_Tutorial1.lua",SCRIPT_PATH.."S1mple_Tutorial1.lua", function () --This will download the new File from the Server to SCRIPT_PATH.."S1mple_Tutorial1.lua"
					updated = true --If the operation was successfull, it will set updated to true
				end)
			end
		else
			print("An error occured, while updating, please reload")
		end
	else
		print("Could not connect to update Server")
	end
	self.updating = false --Since we are done updating, this will go back to false
end

function SUpdate:draw()
	local w, h = WINDOW_W, WINDOW_H
	if self.updating then
		DrawTextA("[S1mple_Tutorial1] Updating", 25, 10,h*0.05,ARGB(255,255,255,255), "left", "center") --This will draw a nice Updating Text onto the User Screen
	end
	if updated then
		DrawTextA("[S1mple_Tutorial1] Updated, press 2xF9", 25, 10,h*0.05,ARGB(255,255,255,255), "left", "center") --This will draw a reminder for the User on the Screen to reload his scripts
	end
end
