 --[[
   _____ __                 _       __      ____  __  _____            _             _   _              _____ __                 _       _____           _       _       
  / ____/_ |               | |      \ \    / /  \/  |/ ____|          | |           | | | |            / ____/_ |               | |     / ____|         (_)     | |      
 | (___  | |_ __ ___  _ __ | | ___   \ \  / /| \  / | |     ___  _ __ | |_ _ __ ___ | | | |__  _   _  | (___  | |_ __ ___  _ __ | | ___| (___   ___ _ __ _ _ __ | |_ ___ 
  \___ \ | | '_ ` _ \| '_ \| |/ _ \   \ \/ / | |\/| | |    / _ \| '_ \| __| '__/ _ \| | | '_ \| | | |  \___ \ | | '_ ` _ \| '_ \| |/ _ \\___ \ / __| '__| | '_ \| __/ __|
  ____) || | | | | | | |_) | |  __/    \  /  | |  | | |___| (_) | | | | |_| | | (_) | | | |_) | |_| |  ____) || | | | | | | |_) | |  __/____) | (__| |  | | |_) | |_\__ \
 |_____/ |_|_| |_| |_| .__/|_|\___|     \/   |_|  |_|\_____\___/|_| |_|\__|_|  \___/|_| |_.__/ \__, | |_____/ |_|_| |_| |_| .__/|_|\___|_____/ \___|_|  |_| .__/ \__|___/
                     | |                                                                        __/ |                     | |                             | |            
                     |_|                                                                       |___/                      |_|                             |_|            
 ]]--

--Initializes Vars
	local version = "0.3"
	local updatefreq = 300 --In Seconds
	local nextupdate = 0
	--
	local team_kills = 0
	local team_deaths = 0
	local enemy_kills = 0
	local enemy_deaths = 0

	local kills = 0
	local deaths = 0
	local assists = 0

--End Initializes Vars

function OnLoad()
	nextupdate = os.clock() + updatefreq
	p(lastupdate)
	UpdateStats(true)
 	p("Loaded")
end

function OnTick()
	if os.clock() >= nextupdate then
		UpdateStats(true)
		nextupdate = os.clock() + updatefreq
	end
end

function OnUnload()
	UpdateStats(false)
end

function OnRecvPacket(p)
	if p.header == 0x0124 then
		p.pos = 2
		local object = objManager:GetObjectByNetworkId(p:DecodeF())
		if object and object.valid then
			print(object.charName.." got killed")
			if object.team == myHero.team then
				team_deaths = team_deaths+1
				enemy_kills = enemy_kills+1
				if object.networkID == myHero.networkID then
					deadts = deaths + 1
				end
			else
				team_kills = team_kills+1
				enemy_deaths = enemy_deaths+1
			end
		end
	end
end




--External Stuff

function UpdateStats(arg)
	local isrunning = arg
	local isrunningstr = "true"
	if isrunning == true then
		isrunningstr = "true"
	else
		isrunningstr = "false"
	end
	local file = io.open(SCRIPT_PATH.."\\".."S1mple_VMControlDATA.dat", "w")
	if not file then
		p("Error in Update Stats")
	else
		file:write(isrunningstr.."\n")
		file:write(myHero.charName.."\n")
		file:write(kills.."\n")
		file:write(deaths.."\n")
		file:write(assists.."\n")
		file:write(team_kills.."\n")
		file:write(team_deaths.."\n")
		file:write(enemy_kills.."\n")
		file:write(enemy_deaths.."\n")
		
		file:close()
		p("Stats Updated")
	end
end



function p(arg)
	if arg ~= nil then
		print("[S1mple_VMControl] <font color=\"#570BB2\">"..arg.."</font>")
	end
end