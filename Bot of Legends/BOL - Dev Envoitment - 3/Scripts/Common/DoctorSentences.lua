local Version = "0.2"
local Author = "DrPhoenix"
local ScriptName = "DoctorSentences"
local UpdateHOST = "scarjit.de"
local UpdateUrl = "http://scarjit.de/DrPhoenix/BoL/Scripts/DoctorSentences/DoctorSentences.lua"
local VersionUrl = "/DrPhoenix/BoL/Scripts/DoctorSentences/DoctorSentences.version"
local UpdatePath = SCRIPT_PATH..GetCurrentEnv().FILE_NAME

local AutoUpdate = true

local nbK = 0
local nbD = 0
local nbA = 0
local KDA = 0

function PrintChatMsg(msg)
  PrintChat("<font color=\"#6eed00\"><b>[</b></font><font color=\"#a2ed00\"><b>Doctor Sentences</b></font><font color=\"#6eed00\"><b>]</b></font> <font color=\"#fce700\">"..msg.."</font>")
end

if AutoUpdate then
	local ServerData = GetWebResult(UpdateHOST, VersionURL)
	if ServerData then
		ServerVersion = type(tonumber(ServerData)) == "number" and tonumber(ServerData) or nil
		if ServerVersion then
			if tonumber(Version) < ServerVersion then
				PrintChatMsg("New Version available "..ServerVersion)
				PrintChatMsg("Updating, please don't press F9 !")
				DelayAction(function() DownloadFile(UpdateUrl, UpdatePath, function () PrintChatMsg("Successfully updated. ("..Version.." => "..ServerVersion.."), press F9 twice to load the updated Version.") end) end, 3)
			elseif tonumber(Version) == ServerVersion then
				PrintChatMsg("Loaded !")
			end
		end
	else
		PrintChatMsg("Error downloading Version info")
	end
end

function OnLoad()
  AddMenu()
end

function AddMenu()
  Config = scriptConfig("Doctor Sentences", "DoctorSentences")

  Config:addSubMenu("Settings", "Settings")
    Config.Settings:addParam("sentencesON", "Say sententences", SCRIPT_PARAM_ONOFF, true)
end

function OnTick()
  nbK = myHero.kills
  nbD = myHero.deaths
  nbA = myHero.assists
  
  if nbK + nbD + nbA ~= KDA and Config.Settings.sentencesON then
    checkKDA()
  end
end

function checkKDA()
  if nbK == 0 and nbD == 0 and nbA == 0 then
    PrintChatMsg("Time to get some kills !")
  elseif nbK == 6 and nbD == 6 and nbA == 6 then
    PrintChatMsg("6/6/6 but don't vote for Donald Trump !")
  elseif nbK == 2 and nbD == 7 and nbA == 0 then
    PrintChatMsg("2/7/0 Kaaris Omega Squad !")
  elseif nbK == 3 and nbD == 1 and nbA == 4 then
    PrintChatMsg("Are you excited by pi=3.14159265359 ?")
  elseif nbK == 9 and nbD == 11 then
    PrintChatMsg("Don't stay in 9/11,it's not a good number (except if you are a main Ziggs)")
  elseif nbK == 13 and nbD == 3 and nbA == 7 then
    PrintChatMsg("1337 5p34k : y0u 607 7h15 !")
  elseif nbK == 4 and nbD == 0 and nbA == 4 then
    PrintChatMsg("404 : Skill not found ! Are you playing Teemo ?")
  elseif nbK == 4 and nbD == 2 and nbA == 0 then
    PrintChatMsg("420 BLAZE IT FAGGOT !")
  elseif nbK == 14 and nbD == 9 and nbA == 2 then
    PrintChatMsg("Good job Christophe ! <font color=\"#FF7F07\"><b>\"Achievement unlocked : Discover America !\"</b></font>")
  elseif nbK == 16 and nbD == 6 and nbA == 4 then
    PrintChatMsg("You're an alcoholic but you still play well ! You will be Challenger if you stop drink that much !")
  elseif nbK == 0 and nbA == 0 then
    PrintChatMsg("One kill participation is not that much, I'm sure you can do it !")
  end
  KDA = nbK + nbD + nbA
end