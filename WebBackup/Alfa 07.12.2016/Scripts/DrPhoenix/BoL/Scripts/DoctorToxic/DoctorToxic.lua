--[[


 		    Doctor Toxic
		SCRIPT BY DrPhoenix


Changelog :
	1.01 : First release
	1.02 : Add ScriptStatus Tracker
	1.03 : - Rework all the script
           - Add a random sentence part you can use at any time :)
           - Add a lot of new sentences !
	1.04 : Little fix
	1.05 : Update the updater
	1.06 : Stick to ally
	1.07 : - Rework all the script
		   - Now support toxicity in English, French and German
		   - More sentences !
	1.08 : Intentionnal feeding added !
	1.09 : Adding sentences :)
	
	More Soon !


]]--

Languages = {
	"English",
	"French",
	-- "German",
	-- "Spanish",
	"Portuguese"
}

Emote = {
	"Laugh",
	"Dance",
	"Joke"
}

Messages = {
	ToxicOnDeathAllChat = {
		['English'] = {
			"Are you scripting ?",
			"I go AFK gg...",
			"Ty Rito.. Fixs your bugs please..",
			"I'm done bye !",
			"Enjoy your free win !",
			"Always unlucky..",
			"I WAS IN ALPHA !"
		},
		['French'] = {
			"Putain de scripteur de merde...",
			"GG FILS DE PUTE !",
			"BIEN DE JOUER DES CHAMPIONS DE NOOBS ?",
			"Encore un main tryndamerde....",
			"AFK !",
			"GG mentalite !",
			"Encore une team de merde qui aide pas.."
		},
		-- ['German'] = {},
		-- ['Spanish'] = {},
		['Portuguese'] = {
			"Ta usando script ?",
			"To AFK, gg...",
			"Obrigado Rito... Arruma esses bugs por favor.",
			"Estou cheio, tchau.",
			"Aproveita sua vitoria de graca.",
			"Sempre sem sorte..."
		}
	},
	ToxicOnDeath = {
		['English'] = {
			"Can someone SS ?",
			"Where is my jungler ?????",
			"This team don't have a support ?",
			"GG no wards...."
		},
		['French'] = {
			"Putain mais personne dit ses SS ?",
			"T'en a pas marre d'AFK farm jungler de merde ??",
			"Putain de support qui sert a rien",
			"Les wards c'est pour les bronzes ??",
			"Putain mais c'est quoi ce elo..",
			"MERCI POUR L'AIDE"
		},
		-- ['German'] = {},
		-- ['Spanish'] = {},
		['Portuguese'] = {
			"Alguem pode MIAR?",
			"Cade meu jungler????",
			"Esse time nao tem um suporte ?",
			"GG, sem wards"
		}
	},
	ToxicOnAllyDeathAllChat = {
		['English'] = {
			"My teammates are so damn bad...",
			"Please report this useless feeder ! Say thank you for the free win..."
		},
		['French'] = {
			"PUTAIN DE TEAM QUI SERT A RIEN",
			"REPORT CES BONOBOS PLEASE....",
			"GG LA FREE WIN"
		},
		-- ['German'] = {},
		-- ['Spanish'] = {},
		['Portuguese'] = {
			"Meu time e tao ruim.",
			"Por favor report esse feeder inutil ! Agradeca pela vitoria de graca"
		}
	},
	ToxicOnAllyDeath = {
		['English'] = {
			"Are you Bronze V dude ?",
			"Plz uninstall, you're so damn bad...",
			"ZZZzzz...",
			"Go play Minecraft noob...",
			"I go AFK you're so bad...",
			"Can you stop feed one day ?",
			"Fucking noob !"
		},
		['French'] = {
			"Tu t'es fait PL ou quoi ??",
			"Bien d'etre bronze ?",
			"MAIS DESINSTALLE LE JEU PUTAIN",
			"PUTAIN DE BONOBO",
			"Va jouer a minecraft FDP",
			"Putain je go afk vous puez trop la merde",
			"MAIS TU VAS ARRETER DE FEED A UN MOMENT ????",
			"SALE CHIEN",
			"Connard de feeder de merde",
			"zzz..."
		},
		-- ['German'] = {},
		-- ['Spanish'] = {},
		['Portuguese'] = {
			"Voce e Bronze 5 cara ?",
			"Plz, desistala, voce e tao ruim...",
			"ZZZzzz...",
			"Vai jogar Minecraft, noob...",
			"To AFK, voce e tao ruim",
			"Pode parar de feedar 1 dia ?",
			"Noob, porra !"
		}
	},
	ToxicOnEnemyDeath = {
		['English'] = {
			"Easy Peasy",
			":)",
			":D",
			":p",
			":*",
			"Cya",
			"Cy@sign",
			"Bronze V smurf ?",
			"Get Rekt",
			"EZ",
			"RIP",
			"Better surrender",
			"Sorry for this teammate",
			"Is this ranked or Co-Op vs AI right now?",
			"Thanks for the tutorial !",
			"Not even close",
			"Outplayed !",
			"Skill :)",
			"U WOT m8 ?",
			"U MAD BRO ?",
			"MAD because BAD",
			"GET OUTTA MY JUNGLE",
			"This guy want to go on a Wood Division video !",
			"Time to sleep",
			"Hello youtube !",
			"Dicks out for harambe"
		},
		['French'] = {
			"et bim !",
			"trop facile",
			"gros noob",
			"nooblard !",
			"Tellement nul putain",
			"ez",
			"ptite merde",
			"GROS DECHET",
			"Ben alors on est nul ?",
			"Ca fait quoi d'etre bronze ?",
			"EZ",
			"RIP",
			"Surrend ??",
			"Desole pour ce bonobo dur a carry :D",
			":)",
			":D",
			":p",
			":*",
			"Merci pour le tutorial :)",
			"On joue en Coop vs IA ?",
			"not even close !",
			"Outplayed !",
			"Skill :)",
			"U WOT m8 ?",
			"U MAD BRO ?",
			"Casse toi grosse merde",
			"Pauvre con !",
			"Tu veux passer dans un Wood Division ?",
			"VA TE COUCHER !",
			"Dit bonjour à Youtube ;)"
		},
		-- ['German'] = {},
		-- ['Spanish'] = {},
		['Portuguese'] = {
			"Easy Peasy",
			":)",
			":D",
			":p",
			":*",
			"Cya",
			"Cy@sign",
			"Smurf de Bronze 5 ?",
			"Get Rekt",
			"EZ",
			"RIP",
			"Melhor dar surrender.",
			"Desculpa por esse cara.",
			"Isso e ranked ou Co-Op vs AI?",
			"Obrigado pelo tutorial !",
			"Nem chegou perto",
			"Outplayed !",
			"Skill :)",
			"U WOT m8 ?",
			"U MAD BRO ?",
			"Louco porque ruim",
			"SAI DA MINHA JUNGLE",
			"Esse cara quer ir em um video de Madeira 5 !"
		}
	},
	RandomMessageAllChat = {
		['English'] = {
			"This game is so easy !",
			"EZ",
			"Noobs",
			"Bad/20",
			"SUCKERS",
			"U WOT M8",
			"U MAD BRO ?",
			"Dicks out for harambe"
		},
		['French'] = {
			"noobs",
			"nul nul nul nul !",
			"TU PUES !",
			"Merci pour le tutorial :)",
			"Bronze de mort",
			"U WOT M8",
			"U MAD BRO ?"
		},
		-- ['German'] = {},
		-- ['Spanish'] = {},
		['Portuguese'] = {
			"Esse jogo e tao facil",
			"Ez",
			"Ruim/20",
			"U WOT M8",
			"U MAD BRO ?"
		}
	},
	RandomMessage = {
		['English'] = {
			"Noob team gg...",
			"Go uninstall please...",
			"Fun to be bronze team ?",
			"Fucking monkey team..",
			"GO PLAY MINECRAFT !",
			"I GO AFK YOU ALL SUCKS !",
			"GG FEEDERS !",
			"noobs",
			"zzz.."
		},
		['French'] = {
			"Team de mort...",
			"Bien d'etre bronze ?",
			"DESINSTALLEZ LE JEU PUTAIN",
			"PUTAIN DE BONOBO",
			"Va jouer a minecraft FDP",
			"Putain je go afk vous puez trop la merde",
			"MAIS TU VAS ARRETER DE FEED A UN MOMENT ????",
			"SALE CHIEN",
			"Connard de feeder de merde",
			"zzz..."
		},
		-- ['German'] = {},
		-- ['Spanish'] = {},
		['Portuguese'] = {
			"Time noob, gg..."
		}
	}
}

version = "1.08"
AutoUpdate = true

assert(load(Base64Decode("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"), nil, "bt", _ENV))()
TrackerLoad("ipOhYBHWKu4LutLV")

function OnLoad()
	if AutoUpdate then
		if version ~= TCPGetRequest("s1mplescripts.de", "/DrPhoenix/BoL/Scripts/DoctorToxic/DoctorToxic.version", {}, 80) then
			PrintChatMsg("Updating don't press F9 !")
			GetWebFile("s1mplescripts.de","/DrPhoenix/BoL/Scripts/DoctorToxic/DoctorToxic.lua", {}, SCRIPT_PATH..GetCurrentEnv().FILE_NAME, 80, false)
			PrintChatMsg("Updated ! Press 2xF9 to reload !")
		end
	end
	Menu()
	PrintChatMsg("Loaded !")
	KeyDown = false
end

function Menu()
	Config = scriptConfig("DoctorToxic", "Doctor Toxic")
	
	Config:addSubMenu("Chat Settings", "Chat")
		Config.Chat:addParam("space11", "  ----[>  Language settings <]----", 5, "")
		Config.Chat:addParam("space12", "", 5, "")
		Config.Chat:addParam("Language", "Select Language:", SCRIPT_PARAM_LIST, 1, {"English", "French", "Portuguese"})
		
		Config.Chat:addParam("space21", "", 5, "")
		Config.Chat:addParam("space22", "    ----[>  Your settings <]----", 5, "")
		Config.Chat:addParam("space23", "", 5, "")
			Config.Chat:addParam("ToxicOnDeath", "Flame when you die", SCRIPT_PARAM_ONOFF, true)
			
		for i, hero in pairs(GetAllyHeroes()) do	
			if i > 0 then
				Config.Chat:addParam("space31", "", 5, "")
				Config.Chat:addParam("space32", "    ----[>  Ally settings <]----", 5, "")
				Config.Chat:addParam("space33", "", 5, "")
					for i, hero in pairs(GetAllyHeroes()) do
						Config.Chat:addParam("ToxicOnAlly"..hero.charName.."Death", "Flame when "..hero.charName.." die", SCRIPT_PARAM_ONOFF, true)
					end
				break
			end
		end
		
		for i, hero in pairs(GetEnemyHeroes()) do	
			if i > 0 then
				Config.Chat:addParam("space41", "", 5, "")
				Config.Chat:addParam("space42", "    ----[>  Enemy settings <]----", 5, "")
				Config.Chat:addParam("space43", "", 5, "")
					for i, hero in pairs(GetEnemyHeroes()) do
						Config.Chat:addParam("ToxicOnEnemy"..hero.charName.."Death", "Flame when "..hero.charName.." die", SCRIPT_PARAM_ONOFF, true)
					end
				break
			end
		end
			
		Config.Chat:addParam("space51", "", 5, "")
		Config.Chat:addParam("space52", "    ----[>  Other settings <]----", 5, "")
		Config.Chat:addParam("space53", "", 5, "")
			Config.Chat:addParam("SendRandomMessage", "Send a Random Message", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("T"))
	
	Config:addSubMenu("Emote Settings", "Emote")
		for i, hero in pairs(GetEnemyHeroes()) do
			Config.Emote:addParam("EmoteOn"..hero.charName.."Kill", "Show emote when "..hero.charName.." die", SCRIPT_PARAM_ONOFF, true)
			Config.Emote:addParam("EmoteType"..hero.charName, "Select Emote:", SCRIPT_PARAM_LIST, 1, {"Laugh", "Dance", "Joke"})
			Config.Emote:addParam("EmoteMastery"..hero.charName, "Show Champion Mastery when "..hero.charName.." die", SCRIPT_PARAM_ONOFF, true)
			Config.Emote:addParam("space"..hero.charName, "", 5, "")
		end
		
	Config:addSubMenu("Stick Settings", "Stick")
		for i, hero in pairs(GetAllyHeroes()) do
			Config.Stick:addParam("StickTo"..hero.charName, "Stick to "..hero.charName, SCRIPT_PARAM_ONOFF, false)
			Config.Stick:setCallback("StickTo"..hero.charName, function(val) if val then StickToChampion = hero else StickToChampion = nil end end)
		end
		
	Config:addSubMenu("Feeding Settings", "Feeding")
		Config.Feeding:addParam("ON", "Activate Intentionnal Feeding", SCRIPT_PARAM_ONOFF, false)
end
 
function PrintChatMsg(msg)
	PrintChat("<font color=\"#6eed00\"><b>[</b></font><font color=\"#a2ed00\"><b>Doctor Toxic</b></font><font color=\"#6eed00\"><b>]</b></font> <font color=\"#fce700\">"..msg.."</font>")
end

function AllChatMsg(msg)
	SendChat("/all "..msg)
end

function OnTick()
	if Config.Feeding.ON then
		if myHero.team == 100 then
			myHero:MoveTo(15000, 15000)
		else
			myHero:MoveTo(0, 0)
		end
	end
	
	if Config.Chat.SendRandomMessage and not KeyDown then
		RandomMessage()
		KeyDown = true
	end
	
	if not Config.Chat.SendRandomMessage and KeyDown then
		KeyDown = false
	end
	
	if StickToChampion then
		myHero:MoveTo(StickToChampion.x, StickToChampion.z)
	end
end

function OnAnimation(unit, animation)
	if animation == "Death" and unit.type == myHero.type then
		if unit == myHero then
			if Config.Chat.ToxicOnDeath then
				ToxicOnDeath()
			end
		elseif unit.team == myHero.team then
			if Config.Chat["ToxicOnAlly"..unit.charName.."Death"] then
				ToxicOnAllyDeath(unit)
			end
		else
			if Config.Chat["ToxicOnEnemy"..unit.charName.."Death"] then
				ToxicOnEnemyDeath(unit)
			end
			
			if Config.Emote["EmoteOn"..unit.charName.."Kill"] then
				SendChat("/"..Emote[Config.Emote["EmoteType"..unit.charName]])
			end
			
			if Config.Emote["EmoteMastery"..unit.charName] then
				SendChat("/masterybadge")
			end
		end
	end
end

function ToxicOnDeath()
	local typeMsg = math.random(1,2)
	if typeMsg == 1 then
		AllChatMsg(Messages.ToxicOnDeathAllChat[Languages[Config.Chat.Language]][math.floor(math.random(1,#Messages.ToxicOnDeathAllChat[Languages[Config.Chat.Language]]))])
	elseif typeMsg == 2 then
		SendChat(Messages.ToxicOnDeath[Languages[Config.Chat.Language]][math.floor(math.random(1,#Messages.ToxicOnDeath[Languages[Config.Chat.Language]]))])
	end
end

function ToxicOnAllyDeath()
	local typeMsg = math.random(1,2)
	if typeMsg == 1 then
		AllChatMsg(Messages.ToxicOnAllyDeathAllChat[Languages[Config.Chat.Language]][math.floor(math.random(1,#Messages.ToxicOnAllyDeathAllChat[Languages[Config.Chat.Language]]))])
	elseif typeMsg == 2 then
		SendChat(Messages.ToxicOnAllyDeath[Languages[Config.Chat.Language]][math.floor(math.random(1,#Messages.ToxicOnAllyDeath[Languages[Config.Chat.Language]]))])
	end
end

function ToxicOnEnemyDeath()
	AllChatMsg(Messages.ToxicOnEnemyDeath[Languages[Config.Chat.Language]][math.floor(math.random(1,#Messages.ToxicOnEnemyDeath[Languages[Config.Chat.Language]]))])
end

function RandomMessage()
	local typeMsg = math.random(1,2)
	if typeMsg == 1 then
		AllChatMsg(Messages.RandomMessageAllChat[Languages[Config.Chat.Language]][math.floor(math.random(1,#Messages.RandomMessageAllChat[Languages[Config.Chat.Language]]))])
	elseif typeMsg == 2 then
		SendChat(Messages.RandomMessage[Languages[Config.Chat.Language]][math.floor(math.random(1,#Messages.RandomMessage[Languages[Config.Chat.Language]]))])
	end
end





--[[
		 _____   ___       ___  ___   _____   _       _____        _____   _____   _          __  __   _   _       _____       ___   _____   _____   _____   
		/  ___/ |_  |     /   |/   | |  _  \ | |     | ____|      |  _  \ /  _  \ | |        / / |  \ | | | |     /  _  \     /   | |  _  \ | ____| |  _  \  
		| |___    | |    / /|   /| | | |_| | | |     | |__        | | | | | | | | | |  __   / /  |   \| | | |     | | | |    / /| | | | | | | |__   | |_| |  
		\___  \   | |   / / |__/ | | |  ___/ | |     |  __|       | | | | | | | | | | /  | / /   | |\   | | |     | | | |   / / | | | | | | |  __|  |  _  /  
		 ___| |   | |  / /       | | | |     | |___  | |___       | |_| | | |_| | | |/   |/ /    | | \  | | |___  | |_| |  / /  | | | |_| | | |___  | | \ \  
		/_____/   |_| /_/        |_| |_|     |_____| |_____|      |_____/ \_____/ |___/|___/     |_|  \_| |_____| \_____/ /_/   |_| |_____/ |_____| |_|  \_\ 

]]--


function TCPGetRequest(server, path, data, port)
	local start_t = os.clock()
	local port = port or 80
	local data = data or {}
	local lua_socket = require("socket")
	local connection_tcp = lua_socket.connect(server,port)
	local requeststring = "GET "..path
	local first = true
	for i,v in pairs(data)do
		requeststring = requeststring..(first and "?" or "&")..i.."="..v
		first = false
	end
	requeststring = requeststring.. " HTTP/1.0\r\nHost: "..server.."\r\n\r\n"
	connection_tcp:send(requeststring)
	local response = ""
	local status
	while true do
		s,status, partial = connection_tcp:receive('*a')
		response = response..(s or partial)
		if(status == "closed" or status == "timeout")then
			break
		end
	end
	local end_t = os.clock()
	local start_content = response:find("\r\n\r\n")+4
	response = response:sub(start_content)
	return response, status, end_t-start_t
end

function GetWebFile(server, path, data, localfilename, port, b64)
	local r,s,t = TCPGetRequest(server, path, data, port)
	file = io.open(localfilename,"w+b")
	file:write(r)
	file:close()
end