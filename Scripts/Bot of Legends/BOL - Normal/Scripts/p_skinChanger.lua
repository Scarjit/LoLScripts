-- Developers: 
    --Divine (http://forum.botoflegends.com/user/86308-divine/)
    --PvPSuite (http://forum.botoflegends.com/user/76516-pvpsuite/)

local sVersion = '3.2';
local rVersion = GetWebResult('raw.githubusercontent.com', '/Nader-Sl/BoLStudio/master/Versions/p_skinChanger.version?no-cache=' .. math.random(1, 25000));

if ((rVersion) and (tonumber(rVersion) ~= nil)) then
	if (tonumber(sVersion) < tonumber(rVersion)) then
		print('<font color="#FF1493"><b>[p_skinChanger]</b> </font><font color="#FFFF00">An update has been found and it is now downloading!</font>');
		DownloadFile('https://raw.githubusercontent.com/Nader-Sl/BoLStudio/master/Scripts/p_skinChanger.lua?no-cache=' .. math.random(1, 25000), (SCRIPT_PATH.. GetCurrentEnv().FILE_NAME), function()
			print('<font color="#FF1493"><b>[p_skinChanger]</b> </font><font color="#00FF00">Script has been updated, please reload!</font>');
		end);
		return;
	end;
else
	print('<font color="#FF1493"><b>[p_skinChanger]</b> </font><font color="#FF0000">Update Error</font>');
end;

if (not VIP_USER) then
	print('<font color="#FF1493"><b>[p_skinChanger]</b> </font><font color="#FF0000">Non-VIP Not Supported</font>');
	return;
elseif ((string.find(GetGameVersion(), 'Releases/5.23') == nil) and ((string.find(GetGameVersion(), 'Releases/5.24') == nil))) then
		print('<font color="#FF1493"><b>[p_skinChanger]</b> </font><font color="#FF0000">Game Version Not Supported</font>');
		return;
end;

local skinsPB = {};
local skinObjectPos = nil;
local skinHeader = nil;
local dispellHeader = nil;
local skinH = nil;
local skinHPos = nil;

if (string.find(GetGameVersion(), 'Releases/5.24') ~= nil) then
	skinsPB = {
		[1] = 0xCA,
		[10] = 0x68,
		[8] = 0xE8,
		[4] = 0xF8,
		[12] = 0xD8,
		[5] = 0xB8,
		[9] = 0xA8,
		[7] = 0x38,
		[3] = 0x0C,
		[11] = 0x28,
		[6] = 0x78,
		[2] = 0x4C,
	};
	skinObjectPos = 6;
	skinHeader = 0x3A;
	dispellHeader = 0xB7;
	skinH = 0x8C;
	skinHPos = 32;
elseif (string.find(GetGameVersion(), 'Releases/5.23') ~= nil) then
		skinsPB = {
			[1] = 0x74,
			[10] = 0x04,
			[8] = 0x14,
			[4] = 0x34,
			[12] = 0x44,
			[5] = 0x54,
			[9] = 0x84,
			[7] = 0x94,
			[3] = 0xB4,
			[11] = 0xC4,
			[6] = 0xD4,
			[2] = 0xF4,
		};
		skinObjectPos = 16;
		skinHeader = 0x13;
		dispellHeader = 0x13B;
		skinH = 0x74;
		skinHPos = 11;
end;

local theMenu = nil;
local initBall = false;
local ballCreated = false;
local ballNetworkID = nil;
local lastFormSeen = nil;
local cougarForm = false;
local spiderForm = false;
local lastTimeTickCalled = 0;
local lastSkin = 0;

function OnLoad()
	InitMenu();
	
	if (not theMenu['save' .. myHero.charName .. 'Skin']) then
		theMenu['change' .. myHero.charName .. 'Skin'] = false;
		theMenu['selected' .. myHero.charName .. 'Skin'] = 1;
	elseif (theMenu['change' .. myHero.charName .. 'Skin']) then
			SendSkinPacket(myHero.charName, skinsPB[theMenu['selected' .. myHero.charName .. 'Skin']], myHero.networkID);
	end;
	
	if (myHero.charName == 'Orianna') then
		for I = 1, objManager.maxObjects do
			local tempObject = objManager:getObject(I);
			if ((tempObject) and (tempObject.name == 'TheDoomBall') and (tempObject.team == myHero.team)) then
				initBall = true;
				ballCreated = true;
				ballNetworkID = tempObject.networkID;
				break;
			end;
		end;
	elseif (myHero.charName == 'Nidalee') then
			if (myHero:GetSpellData(_Q).name == 'Takedown') then
				cougarForm = true;
			end;
	elseif (myHero.charName == 'Elise') then
			if (myHero:GetSpellData(_Q).name == 'EliseSpiderQCast') then
				spiderForm = true;
			end;
	end;
	
	print('<font color="#FF1493"><b>[p_skinChanger]</b> </font><font color="#00EE00">Loaded Successfully</font>');
end;

function OnUnload()
	if (theMenu['change' .. myHero.charName .. 'Skin']) then
		if (myHero.charName == 'Orianna') then
			if (ballCreated) then
				return print('<font color="#FF1493"><b>[p_skinChanger]</b> </font><font color="#FFFF00">Skin could not be unloaded because ball is active!</font>');
			else
				SendSkinPacket('Orianna', nil, myHero.networkID);
			end;
		elseif (myHero.charName == 'Nidalee') then
				if (cougarForm) then
					return print('<font color="#FF1493"><b>[p_skinChanger]</b> </font><font color="#FFFF00">Skin could not be unloaded due to cougar form!</font>');
				else
					SendSkinPacket('Nidalee', nil, myHero.networkID);
				end;
		elseif (myHero.charName == 'Elise') then
				if (spiderForm) then
					return print('<font color="#FF1493"><b>[p_skinChanger]</b> </font><font color="#FFFF00">Skin could not be unloaded due to spider form!</font>');
				else
					SendSkinPacket('Elise', nil, myHero.networkID);
				end;
		else
			SendSkinPacket(myHero.charName, nil, myHero.networkID);
		end;
	end;
end;

function OnTick()
	if ((CurrentTimeInMillis() - lastTimeTickCalled) > 200) then
		lastTimeTickCalled = CurrentTimeInMillis();
		if (theMenu['change' .. myHero.charName .. 'Skin']) then
			if (theMenu['selected' .. myHero.charName .. 'Skin'] ~= lastSkin) then
				lastSkin = theMenu['selected' .. myHero.charName .. 'Skin'];
				if (myHero.charName == 'Orianna') then
					if (ballCreated) then
						SendSkinPacket('OriannaNoBall', skinsPB[theMenu['selected' .. myHero.charName .. 'Skin']], myHero.networkID);
						if (ballNetworkID ~= nil) then
							SendSkinPacket('OriannaBall', skinsPB[theMenu['selected' .. myHero.charName .. 'Skin']], ballNetworkID);
						end;
					else
						SendSkinPacket('Orianna', skinsPB[theMenu['selected' .. myHero.charName .. 'Skin']], myHero.networkID);
					end;
				elseif (myHero.charName == 'Nidalee') then
						if (cougarForm) then
							SendSkinPacket('Nidalee_Cougar', skinsPB[theMenu['selected' .. myHero.charName .. 'Skin']], myHero.networkID);
						else
							SendSkinPacket('Nidalee', skinsPB[theMenu['selected' .. myHero.charName .. 'Skin']], myHero.networkID);
						end;
				elseif (myHero.charName == 'Elise') then
						if (spiderForm) then
							SendSkinPacket('EliseSpider', skinsPB[theMenu['selected' .. myHero.charName .. 'Skin']], myHero.networkID);
						else
							SendSkinPacket('Elise', skinsPB[theMenu['selected' .. myHero.charName .. 'Skin']], myHero.networkID);
						end;
				else
					SendSkinPacket(myHero.charName, skinsPB[theMenu['selected' .. myHero.charName .. 'Skin']], myHero.networkID);
				end;
			end;
		elseif (lastSkin ~= 0) then
			if (myHero.charName == 'Orianna') then
				if ((ballCreated) and (ballNetworkID ~= nil)) then
					theMenu['change' .. myHero.charName .. 'Skin'] = true;
					return print('<font color="#FF1493"><b>[p_skinChanger]</b> </font><font color="#FFFF00">You can\'t disable skin changer while the ball is active!</font>');
				else
					SendSkinPacket('Orianna', nil, myHero.networkID);
				end;
			elseif (myHero.charName == 'Nidalee') then
					if (cougarForm) then
						theMenu['change' .. myHero.charName .. 'Skin'] = true;
						return print('<font color="#FF1493"><b>[p_skinChanger]</b> </font><font color="#FFFF00">You can\'t disable skin changer while on cougar form!</font>');
					else
						SendSkinPacket('Nidalee', nil, myHero.networkID);
					end;
			elseif (myHero.charName == 'Elise') then
					if (spiderForm) then
						theMenu['change' .. myHero.charName .. 'Skin'] = true;
						return print('<font color="#FF1493"><b>[p_skinChanger]</b> </font><font color="#FFFF00">You can\'t disable skin changer while on spider form!</font>');
					else
						SendSkinPacket('Elise', nil, myHero.networkID);
					end;
			else
				SendSkinPacket(myHero.charName, nil, myHero.networkID);
			end;
			lastSkin = 0;
		end;
	end;
end;

function OnRecvPacket(rPacket)
	if (rPacket.header == skinHeader) then
		if ((myHero.charName == 'Orianna') or (myHero.charName == 'Nidalee') or (myHero.charName == 'Elise')) then
			rPacket.pos = 2;
			if (myHero.networkID == rPacket:DecodeF()) then
				rPacket.pos = skinObjectPos;
				local pS1 = rPacket:Decode4();
				local pS2 = rPacket:Decode4();
				local pS3 = rPacket:Decode2();
				local pS4 = rPacket:Decode1();
				local pS5 = rPacket:Decode1();
				local pS6 = rPacket:Decode1();
				local pS7 = rPacket:Decode1();
				
				if (myHero.charName == 'Orianna') then
					if ((pS1 == 0x6169724F) and (pS2 == 0x4E616E6E) and (pS3 == 0x426F) and (pS4 == 0x61) and (pS5 == 0x6C) and (pS5 == 0x6C)) then
						ballCreated = true;
						if (theMenu['change' .. myHero.charName .. 'Skin']) then
							rPacket:Replace1(skinsPB[theMenu['selected' .. myHero.charName .. 'Skin']], skinHPos);
							rPacket:Replace1(skinH, skinHPos + 1);
							rPacket:Replace1(skinH, skinHPos + 2);
							rPacket:Replace1(skinH, skinHPos + 3);
						end;
					end;
				elseif (myHero.charName == 'Nidalee') then
						if ((pS1 == 0x6164694E) and (pS2 == 0x5F65656C) and (pS3 == 0x6F43) and (pS4 == 0x75) and (pS5 == 0x67) and (pS6 == 0x61) and (pS7 == 0x72)) then
							cougarForm = true;
							if (theMenu['change' .. myHero.charName .. 'Skin']) then
								rPacket:Replace1(skinsPB[theMenu['selected' .. myHero.charName .. 'Skin']], skinHPos);
								rPacket:Replace1(skinH, skinHPos + 1);
								rPacket:Replace1(skinH, skinHPos + 2);
								rPacket:Replace1(skinH, skinHPos + 3);
							end;
						else
							lastFormSeen = cougarForm;
						end;
				elseif (myHero.charName == 'Elise') then
						if ((pS1 == 0x73696C45) and (pS2 == 0x69705365) and (pS3 == 0x6564) and (pS4 == 0x72)) then
							spiderForm = true;
							if (theMenu['change' .. myHero.charName .. 'Skin']) then
								rPacket:Replace1(skinsPB[theMenu['selected' .. myHero.charName .. 'Skin']], skinHPos);
								rPacket:Replace1(skinH, skinHPos + 1);
								rPacket:Replace1(skinH, skinHPos + 2);
								rPacket:Replace1(skinH, skinHPos + 3);
							end;
						else
							lastFormSeen = spiderForm;
						end;
				end;
			end;
		end;
	elseif (rPacket.header == dispellHeader) then
			rPacket.pos = 2;
			if (myHero.networkID == rPacket:DecodeF()) then
				if (myHero.charName == 'Nidalee') then
					if (lastFormSeen ~= nil) then
						if (lastFormSeen) then
							if (theMenu['change' .. myHero.charName .. 'Skin']) then
								SendSkinPacket('Nidalee_Cougar', skinsPB[theMenu['selected' .. myHero.charName .. 'Skin']], myHero.networkID);
							end;
							
							cougarForm = true;
						else
							if (theMenu['change' .. myHero.charName .. 'Skin']) then
								SendSkinPacket('Nidalee', skinsPB[theMenu['selected' .. myHero.charName .. 'Skin']], myHero.networkID);
							end;
							
							cougarForm = false;
						end;
						
						lastFormSeen = nil;
					else
						if (theMenu['change' .. myHero.charName .. 'Skin']) then
							SendSkinPacket('Nidalee', skinsPB[theMenu['selected' .. myHero.charName .. 'Skin']], myHero.networkID);
						end;
						
						cougarForm = false;
					end;
				elseif (myHero.charName == 'Elise') then
						if (lastFormSeen ~= nil) then
							if (lastFormSeen) then
								if (theMenu['change' .. myHero.charName .. 'Skin']) then
									SendSkinPacket('EliseSpider', skinsPB[theMenu['selected' .. myHero.charName .. 'Skin']], myHero.networkID);
								end;
								
								spiderForm = true;
							else
								if (theMenu['change' .. myHero.charName .. 'Skin']) then
									SendSkinPacket('Elise', skinsPB[theMenu['selected' .. myHero.charName .. 'Skin']], myHero.networkID);
								end;
								
								spiderForm = false;
							end;
							
							lastFormSeen = nil;
						else
							if (theMenu['change' .. myHero.charName .. 'Skin']) then
								SendSkinPacket('Elise', skinsPB[theMenu['selected' .. myHero.charName .. 'Skin']], myHero.networkID);
							end;
							
							spiderForm = false;
						end;
				end;
			end;
	end;
end;

function OnCreateObj(tObj)
	if (myHero.charName == 'Orianna') then
		if ((tObj.valid) and (tObj.name == 'TheDoomBall') and (tObj.team == myHero.team)) then
			ballNetworkID = tObj.networkID;
			ballCreated = true;
			
			if (theMenu['change' .. myHero.charName .. 'Skin']) then
				SendSkinPacket('OriannaBall', skinsPB[theMenu['selected' .. myHero.charName .. 'Skin']], ballNetworkID);
			end;
		end;
	end;
end;

function OnApplyBuff(bSource, bUnit, tBuff)
	if (myHero.charName == 'Orianna') then
		if (bUnit and (bUnit.isMe) and (tBuff.name == 'orianaghostself')) then
			if ((theMenu['change' .. myHero.charName .. 'Skin']) and (ballCreated)) then
				SendSkinPacket('Orianna', skinsPB[theMenu['selected' .. myHero.charName .. 'Skin']], myHero.networkID);
			elseif (initBall) then
					SendSkinPacket('Orianna', nil, myHero.networkID);
					initBall = false;
			end;
			
			ballCreated = false;
			ballNetworkID = nil;
		end;
	end;
end;

function InitMenu()
	theMenu = scriptConfig('p_skinChanger', 'p_skinChanger');
	theMenu:addParam('save' .. myHero.charName .. 'Skin', 'Save Skin', SCRIPT_PARAM_ONOFF, false);
	theMenu:addParam('change' .. myHero.charName .. 'Skin', 'Change Skin', SCRIPT_PARAM_ONOFF, false);
	theMenu:addParam('selected' .. myHero.charName .. 'Skin', 'Selected Skin', SCRIPT_PARAM_LIST, 1,skinMeta[myHero.charName]);
end;

function SendSkinPacket(mObject, skinPB, networkID)
	if (string.find(GetGameVersion(), 'Releases/5.24') ~= nil) then
		local mP = CLoLPacket(0x3A);

    mP.vTable = 0xF351B0;
		mP:EncodeF(myHero.networkID);

		for I = 1, string.len(mObject) do
			mP:Encode1(string.byte(string.sub(mObject, I, I)));
		end;

		for I = 1, (16 - string.len(mObject)) do
			mP:Encode1(0x00);
		end;

		mP:Encode4(0x0000000E);
		mP:Encode4(0x0000000F);
    mP:Encode2(0x0000);
		
		if (skinPB == nil) then
			mP:Encode4(0x82828282);
		else
			mP:Encode1(skinPB);
			for I = 1, 3 do
				mP:Encode1(skinH);
			end;
		end;

    mP:Encode4(0x00000000);
		mP:Encode4(0x00000000);
    mP:Encode1(0x00);
		
		mP:Hide();
		RecvPacket(mP);
	elseif (string.find(GetGameVersion(), 'Releases/5.23') ~= nil) then
			local mP = CLoLPacket(0x13);
      mP.vTable = 0xF4FDE0;
 
			mP:EncodeF(myHero.networkID);
      mP:Encode4(0x00000000);
      mP:Encode1(0x00);
   
      if (skinPB == nil) then
        mP:Encode4(0x2F2F2F2F);
      else

        mP:Encode1(skinPB);
        for I = 1, 3 do
          mP:Encode1(0x74);
        end;

      end;
      mP:Encode1(0x75);

      for I = 1, string.len(mObject) do
        mP:Encode1(string.byte(string.sub(mObject, I, I)));
      end;

      for I = 1, (16 - string.len(mObject)) do
        mP:Encode1(0x00);
      end;

      mP:Encode4(0x00000000);
      mP:Encode4(0x0000000F);
      mP:Encode4(0x00000000);
      mP:Encode1(0x00);
      
      mP:Hide();
      RecvPacket(mP);
	end;
end;

function CurrentTimeInMillis()
	return (os.clock() * 1000);
end;

skinMeta = {

  -- A
["Aatrox"]       = {"Classic", "Justicar", "Mecha", "Sea Hunter"},
["Ahri"]         = {"Classic", "Dynasty", "Midnight", "Foxfire", "Popstar", "Challenger", "Academy"},
["Akali"]        = {"Classic", "Stinger", "Crimson", "All-star", "Nurse", "Blood Moon", "Silverfang", "Headhunter"},
["Alistar"]      = {"Classic", "Black", "Golden", "Matador", "Longhorn", "Unchained", "Infernal", "Sweeper", "Marauder"},
["Amumu"]        = {"Classic", "Pharaoh", "Vancouver", "Emumu", "Re-Gifted", "Almost-Prom King", "Little Knight", "Sad Robot", "Surprise Party"},
["Anivia"]       = {"Classic", "Team Spirit", "Bird of Prey", "Noxus Hunter", "Hextech", "Blackfrost", "Prehistoric"},
["Annie"]        = {"Classic", "Goth", "Red Riding", "Annie in Wonderland", "Prom Queen", "Frostfire", "Reverse", "FrankenTibbers", "Panda", "Sweetheart"},
["Ashe"]         = {"Classic", "Freljord", "Sherwood Forest", "Woad", "Queen", "Amethyst", "Heartseeker", "Marauder"},
["Azir"]         = {"Classic", "Galactic", "Gravelord"},
  -- B  
["Bard"]         = {"Classic", "Elderwood", "Chroma Pack: Marigold", "Chroma Pack: Ivy", "Chroma Pack: Sage"},
["Blitzcrank"]   = {"Classic", "Rusty", "Goalkeeper", "Boom Boom", "Piltover Customs", "Definitely Not", "iBlitzcrank", "Riot", "Chroma Pack: Molten", "Chroma Pack: Cobalt", "Chroma Pack: Gunmetal", "Battle Boss"},
["Brand"]        = {"Classic", "Apocalyptic", "Vandal", "Cryocore", "Zombie", "Spirit Fire"},
["Braum"]        = {"Classic", "Dragonslayer", "El Tigre", "Lionheart"},
  -- C  
["Caitlyn"]      = {"Classic", "Resistance", "Sheriff", "Safari", "Arctic Warfare", "Officer", "Headhunter", "Chroma Pack: Pink", "Chroma Pack: Green", "Chroma Pack: Blue"},
["Cassiopeia"]   = {"Classic", "Desperada", "Siren", "Mythic", "Jade Fang", "Chroma Pack: Day", "Chroma Pack: Dusk", "Chroma Pack: Night"},
["Chogath"]      = {"Classic", "Nightmare", "Gentleman", "Loch Ness", "Jurassic", "Battlecast Prime", "Prehistoric"},
["Corki"]        = {"Classic", "UFO", "Ice Toboggan", "Red Baron", "Hot Rod", "Urfrider", "Dragonwing", "Fnatic"},
  -- D
["Darius"]       = {"Classic", "Lord", "Bioforge", "Woad King", "Dunkmaster", "Chroma Pack: Black Iron", "Chroma Pack: Bronze", "Chroma Pack: Copper", "Academy"},
["Diana"]        = {"Classic", "Dark Valkyrie", "Lunar Goddess"},
["DrMundo"]      = {"Classic", "Toxic", "Mr. Mundoverse", "Corporate Mundo", "Mundo Mundo", "Executioner Mundo", "Rageborn Mundo", "TPA Mundo", "Pool Party"},
["Draven"]       = {"Classic", "Soul Reaver", "Gladiator", "Primetime", "Pool Party"},
  -- E 
["Ekko"]         = {"Classic", "Sandstorm", "Academy"},
["Elise"]        = {"Classic", "Death Blossom", "Victorious", "Blood Moon"},
["Evelynn"]      = {"Classic", "Shadow", "Masquerade", "Tango", "Safecracker"},
["Ezreal"]       = {"Classic", "Nottingham", "Striker", "Frosted", "Explorer", "Pulsefire", "TPA", "Debonair", "Ace of Spades"},
  -- F 
["FiddleSticks"] = {"Classic", "Spectral", "Union Jack", "Bandito", "Pumpkinhead", "Fiddle Me Timbers", "Surprise Party", "Dark Candy", "Risen"},
["Fiora"]        = {"Classic", "Royal Guard", "Nightraven", "Headmistress", "PROJECT"},
["Fizz"]         = {"Classic", "Atlantean", "Tundra", "Fisherman", "Void", "Chroma Pack: Orange", "Chroma Pack: Black", "Chroma Pack: Red", "Cottontail"},
  -- G  
["Galio"]        = {"Classic", "Enchanted", "Hextech", "Commando", "Gatekeeper", "Debonair"},
["Gangplank"]    = {"Classic", "Spooky", "Minuteman", "Sailor", "Toy Soldier", "Special Forces", "Sultan", "Captain"},
["Garen"]        = {"Classic", "Sanguine", "Desert Trooper", "Commando", "Dreadknight", "Rugged", "Steel Legion", "Chroma Pack: Garnet", "Chroma Pack: Plum", "Chroma Pack: Ivory", "Rogue Admiral"},
["Gnar"]         = {"Classic", "Dino", "Gentleman"},
["Gragas"]       = {"Classic", "Scuba", "Hillbilly", "Santa", "Gragas, Esq.", "Vandal", "Oktoberfest", "Superfan", "Fnatic", "Caskbreaker"},
["Graves"]       = {"Classic", "Hired Gun", "Jailbreak", "Mafia", "Riot", "Pool Party", "Cutthroat"},
  -- H 
["Hecarim"]      = {"Classic", "Blood Knight", "Reaper", "Headless", "Arcade", "Elderwood"},
["Heimerdinger"] = {"Classic", "Alien Invader", "Blast Zone", "Piltover Customs", "Snowmerdinger", "Hazmat"},
  -- I 
["Illaoi"]       = {"Classic", "Void Bringer"},
["Irelia"]       = {"Classic", "Nightblade", "Aviator", "Infiltrator", "Frostblade", "Order of the Lotus"},
  -- J 
["Janna"]        = {"Classic", "Tempest", "Hextech", "Frost Queen", "Victorious", "Forecast", "Fnatic"},
["JarvanIV"]     = {"Classic", "Commando", "Dragonslayer", "Darkforge", "Victorious", "Warring Kingdoms", "Fnatic"},
["Jax"]          = {"Classic", "The Mighty", "Vandal", "Angler", "PAX", "Jaximus", "Temple", "Nemesis", "SKT T1", "Chroma Pack: Cream", "Chroma Pack: Amber", "Chroma Pack: Brick", "Warden"},
["Jayce"]        = {"Classic", "Full Metal", "Debonair", "Forsaken"},
["Jinx"]         = {"Classic", "Mafia", "Firecracker", "Slayer"},
  -- K 
["Kalista"]      = {"Classic", "Blood Moon", "Championship"},
["Karma"]        = {"Classic", "Sun Goddess", "Sakura", "Traditional", "Order of the Lotus", "Warden"},
["Karthus"]      = {"Classic", "Phantom", "Statue of", "Grim Reaper", "Pentakill", "Fnatic", "Chroma Pack: Burn", "Chroma Pack: Blight", "Chroma Pack: Frostbite"},
["Kassadin"]     = {"Classic", "Festival", "Deep One", "Pre-Void", "Harbinger", "Cosmic Reaver"},
["Katarina"]     = {"Classic", "Mercenary", "Red Card", "Bilgewater", "Kitty Cat", "High Command", "Sandstorm", "Slay Belle", "Warring Kingdoms"},
["Kayle"]        = {"Classic", "Silver", "Viridian", "Unmasked", "Battleborn", "Judgment", "Aether Wing", "Riot"},
["Kennen"]       = {"Classic", "Deadly", "Swamp Master", "Karate", "Kennen M.D.", "Arctic Ops"},
["Khazix"]       = {"Classic", "Mecha", "Guardian of the Sands"},
["Kindred"]      = {"Classic", "Shadowfire"},
["KogMaw"]       = {"Classic", "Caterpillar", "Sonoran", "Monarch", "Reindeer", "Lion Dance", "Deep Sea", "Jurassic", "Battlecast"},
  -- L 
["Leblanc"]      = {"Classic", "Wicked", "Prestigious", "Mistletoe", "Ravenborn"},
["LeeSin"]       = {"Classic", "Traditional", "Acolyte", "Dragon Fist", "Muay Thai", "Pool Party", "SKT T1", "Chroma Pack: Black", "Chroma Pack: Blue", "Chroma Pack: Yellow", "Knockout"},
["Leona"]        = {"Classic", "Valkyrie", "Defender", "Iron Solari", "Pool Party", "Chroma Pack: Pink", "Chroma Pack: Azure", "Chroma Pack: Lemon", "PROJECT"},
["Lissandra"]    = {"Classic", "Bloodstone", "Blade Queen"},
["Lucian"]       = {"Classic", "Hired Gun", "Striker", "Chroma Pack: Yellow", "Chroma Pack: Red", "Chroma Pack: Blue", "PROJECT"},
["Lulu"]         = {"Classic", "Bittersweet", "Wicked", "Dragon Trainer", "Winter Wonder", "Pool Party"},
["Lux"]          = {"Classic", "Sorceress", "Spellthief", "Commando", "Imperial", "Steel Legion", "Star Guardian"},
  -- M 
["Malphite"]     = {"Classic", "Shamrock", "Coral Reef", "Marble", "Obsidian", "Glacial", "Mecha", "Ironside"},
["Malzahar"]     = {"Classic", "Vizier", "Shadow Prince", "Djinn", "Overlord", "Snow Day"},
["Maokai"]       = {"Classic", "Charred", "Totemic", "Festive", "Haunted", "Goalkeeper"},
["MasterYi"]     = {"Classic", "Assassin", "Chosen", "Ionia", "Samurai Yi", "Headhunter", "Chroma Pack: Gold", "Chroma Pack: Aqua", "Chroma Pack: Crimson", "PROJECT"},
["MissFortune"]  = {"Classic", "Cowgirl", "Waterloo", "Secret Agent", "Candy Cane", "Road Warrior", "Mafia", "Arcade", "Captain"},
["Mordekaiser"]  = {"Classic", "Dragon Knight", "Infernal", "Pentakill", "Lord", "King of Clubs"},
["Morgana"]      = {"Classic", "Exiled", "Sinful Succulence", "Blade Mistress", "Blackthorn", "Ghost Bride", "Victorious", "Chroma Pack: Toxic", "Chroma Pack: Pale", "Chroma Pack: Ebony"},
  -- N 
["Nami"]         = {"Classic", "Koi", "River Spirit", "Urf", "Chroma Pack: Sunbeam", "Chroma Pack: Smoke", "Chroma Pack: Twilight"},
["Nasus"]        = {"Classic", "Galactic", "Pharaoh", "Dreadknight", "Riot K-9", "Infernal", "Archduke", "Chroma Pack: Burn", "Chroma Pack: Blight", "Chroma Pack: Frostbite",},
["Nautilus"]     = {"Classic", "Abyssal", "Subterranean", "AstroNautilus", "Warden"},
["Nidalee"]      = {"Classic", "Snow Bunny", "Leopard", "French Maid", "Pharaoh", "Bewitching", "Headhunter", "Warring Kingdoms"},
["Nocturne"]     = {"Classic", "Frozen Terror", "Void", "Ravager", "Haunting", "Eternum"},
["Nunu"]         = {"Classic", "Sasquatch", "Workshop", "Grungy", "Nunu Bot", "Demolisher", "TPA", "Zombie"},
  -- O 
["Olaf"]         = {"Classic", "Forsaken", "Glacial", "Brolaf", "Pentakill", "Marauder"},
["Orianna"]      = {"Classic", "Gothic", "Sewn Chaos", "Bladecraft", "TPA", "Winter Wonder"},
  -- P 
["Pantheon"]     = {"Classic", "Myrmidon", "Ruthless", "Perseus", "Full Metal", "Glaive Warrior", "Dragonslayer", "Slayer"},
["Poppy"]        = {"Classic", "Noxus", "Lollipoppy", "Blacksmith", "Ragdoll", "Battle Regalia", "Scarlet Hammer"},
  -- Q 
["Quinn"]        = {"Classic", "Phoenix", "Woad Scout", "Corsair"},
  -- R 
["Rammus"]       = {"Classic", "King", "Chrome", "Molten", "Freljord", "Ninja", "Full Metal", "Guardian of the Sands"},
["Reksai"]       = {"Classic", "Eternum", "Pool Party"},
["Renekton"]     = {"Classic", "Galactic", "Outback", "Bloodfury", "Rune Wars", "Scorched Earth", "Pool Party", "Scorched Earth", "Prehistoric"},
["Rengar"]       = {"Classic", "Headhunter", "Night Hunter", "SSW"},
["Riven"]        = {"Classic", "Redeemed", "Crimson Elite", "Battle Bunny", "Championship", "Dragonblade", "Arcade"},
["Rumble"]       = {"Classic", "Rumble in the Jungle", "Bilgerat", "Super Galaxy"},
["Ryze"]         = {"Classic", "Human", "Tribal", "Uncle", "Triumphant", "Professor", "Zombie", "Dark Crystal", "Pirate", "Whitebeard"},
  -- S 
["Sejuani"]      = {"Classic", "Sabretusk", "Darkrider", "Traditional", "Bear Cavalry", "Poro Rider"},
["Shaco"]        = {"Classic", "Mad Hatter", "Royal", "Nutcracko", "Workshop", "Asylum", "Masked", "Wild Card"},
["Shen"]         = {"Classic", "Frozen", "Yellow Jacket", "Surgeon", "Blood Moon", "Warlord", "TPA"},
["Shyvana"]      = {"Classic", "Ironscale", "Boneclaw", "Darkflame", "Ice Drake", "Championship"},
["Singed"]       = {"Classic", "Riot Squad", "Hextech", "Surfer", "Mad Scientist", "Augmented", "Snow Day", "SSW"},
["Sion"]         = {"Classic", "Hextech", "Barbarian", "Lumberjack", "Warmonger"},
["Sivir"]        = {"Classic", "Warrior Princess", "Spectacular", "Huntress", "Bandit", "PAX", "Snowstorm", "Warden", "Victorious"},
["Skarner"]      = {"Classic", "Sandscourge", "Earthrune", "Battlecast Alpha", "Guardian of the Sands"},
["Sona"]         = {"Classic", "Muse", "Pentakill", "Silent Night", "Guqin", "Arcade", "DJ"},
["Soraka"]       = {"Classic", "Dryad", "Divine", "Celestine", "Reaper", "Order of the Banana"},
["Swain"]        = {"Classic", "Northern Front", "Bilgewater", "Tyrant"},
["Syndra"]       = {"Classic", "Justicar", "Atlantean", "Queen of Diamonds"},
  -- T 
["TahmKench"]    = {"Classic", "Master Chef"},
["Talon"]        = {"Classic", "Renegade", "Crimson Elite", "Dragonblade", "SSW"},
["Taric"]        = {"Classic", "Emerald", "Armor of the Fifth Age", "Bloodstone"},
["Teemo"]        = {"Classic", "Happy Elf", "Recon", "Badger", "Astronaut", "Cottontail", "Super", "Panda", "Omega Squad"},
["Thresh"]       = {"Classic", "Deep Terror", "Championship", "Blood Moon", "SSW"},
["Tristana"]     = {"Classic", "Riot Girl", "Earnest Elf", "Firefighter", "Guerilla", "Buccaneer", "Rocket Girl", "Chroma Pack: Navy", "Chroma Pack: Purple", "Chroma Pack: Orange", "Dragon Trainer"},
["Trundle"]      = {"Classic", "Lil' Slugger", "Junkyard", "Traditional", "Constable"},
["Tryndamere"]   = {"Classic", "Highland", "King", "Viking", "Demonblade", "Sultan", "Warring Kingdoms", "Nightmare"},
["TwistedFate"]  = {"Classic", "PAX", "Jack of Hearts", "The Magnificent", "Tango", "High Noon", "Musketeer", "Underworld", "Red Card", "Cutpurse"},
["Twitch"]       = {"Classic", "Kingpin", "Whistler Village", "Medieval", "Gangster", "Vandal", "Pickpocket", "SSW"},
  -- U 
["Udyr"]         = {"Classic", "Black Belt", "Primal", "Spirit Guard", "Definitely Not"},
["Urgot"]        = {"Classic", "Giant Enemy Crabgot", "Butcher", "Battlecast"},
  -- V 
["Varus"]        = {"Classic", "Blight Crystal", "Arclight", "Arctic Ops", "Heartseeker", "Swiftbolt"},
["Vayne"]        = {"Classic", "Vindicator", "Aristocrat", "Dragonslayer", "Heartseeker", "SKT T1", "Arclight", "Chroma Pack: Green", "Chroma Pack: Red", "Chroma Pack: Silver"},
["Veigar"]       = {"Classic", "White Mage", "Curling", "Veigar Greybeard", "Leprechaun", "Baron Von", "Superb Villain", "Bad Santa", "Final Boss"},
["Velkoz"]       = {"Classic", "Battlecast", "Arclight"},
["Vi"]           = {"Classic", "Neon Strike", "Officer", "Debonair", "Demon"},
["Viktor"]       = {"Classic", "Full Machine", "Prototype", "Creator"},
["Vladimir"]     = {"Classic", "Count", "Marquis", "Nosferatu", "Vandal", "Blood Lord", "Soulstealer", "Academy"},
["Volibear"]     = {"Classic", "Thunder Lord", "Northern Storm", "Runeguard", "Captain"},
  -- W 
["Warwick"]      = {"Classic", "Grey", "Urf the Manatee", "Big Bad", "Tundra Hunter", "Feral", "Firefang", "Hyena", "Marauder"},
["MonkeyKing"]   = {"Classic", "Volcanic", "General", "Jade Dragon", "Underworld"},
  -- X 
["Xerath"]       = {"Classic", "Runeborn", "Battlecast", "Scorched Earth", "Guardian of the Sands"},
["XinZhao"]      = {"Classic", "Commando", "Imperial", "Viscero", "Winged Hussar", "Warring Kingdoms", "Secret Agent"},
  -- Y 
["Yasuo"]        = {"Classic", "High Noon", "PROJECT"},
["Yorick"]       = {"Classic", "Undertaker", "Pentakill"},
  -- Z 
["Zac"]          = {"Classic", "Special Weapon", "Pool Party", "Chroma Pack: Orange", "Chroma Pack: Bubblegum", "Chroma Pack: Honey"},
["Zed"]          = {"Classic", "Shockblade", "SKT T1", "PROJECT"},
["Ziggs"]        = {"Classic", "Mad Scientist", "Major", "Pool Party", "Snow Day", "Master Arcanist"},
["Zilean"]       = {"Classic", "Old Saint", "Groovy", "Shurima Desert", "Time Machine", "Blood Moon"},
["Zyra"]         = {"Classic", "Wildfire", "Haunted", "SKT T1"},

}
