_AUTO_UPDATE = true

---//==================================================\\---
--|| > Auto Update                              ||--
---\\==================================================//---
local serveradress = "raw.github.com"
local scriptadress = "/Lonsemaria/scripts/master/"
local LocalVersion = "5.246"
  function Say(text)
    print("<font color=\"#00FFFF\"><b>Keyboard Master Lib:</b></font> <font color=\"#FFFFFF\">" .. text .. "</font>")
  end
  
if _AUTO_UPDATE or true then
  local ServerVersionDATA = GetWebResult(serveradress , scriptadress.."version/Packet.version")
  if ServerVersionDATA then
    local ServerVersion = tonumber(ServerVersionDATA)
    if ServerVersion then
      if ServerVersion > tonumber(LocalVersion) then
       Say("New version available "..ServerVersion)
          Say("Updating, please don't press F9")
        DelayAction(DownloadFile, 0, {
          "http://"..serveradress..scriptadress.."KeyboardMasterLib.lua",
          LIB_PATH.."\\KeyboardMasterLib.lua",
          function ()
          DelayAction(function() Say("Successfully updated., press F9 twice to load the updated version.")end, 3)
          end
        })
      end
    else
    Say("An error occured, while updating, please reload")
    end
  end
  end
DelayAction(function() print("<font color='#00FFFF'>[Keyboard Master Lib] </font><font color='#FFFFFF'>-</font><font color='#FFFFFF'> Loaded..</font>")end, 0.2)
  _GAME_VERSION = string.find(GetGameVersion(), 'Releases/5.24') 
_GAME_LEVEL = string.find(GetGameVersion(), 'Releases/5.24') 
  ---//==================================================\\---
--|| > LevelSpell Packet                             ||--
---\\==================================================//---
  if (_GAME_LEVEL ~= nil) then
  _G.LevelSpell = function(id)
     local offsets = { 
    [_Q] = 0x1E,
    [_W] = 0xD3,
    [_E] = 0x3A,
    [_R] = 0xA8,
  }
  local p = CLoLPacket(0x00B6)
  p.vTable = 0xFE3124
  p:EncodeF(myHero.networkID)
  p:Encode1(0xC1)
  p:Encode1(offsets[id])
  for i = 1, 4 do p:Encode1(0x63) end
  for i = 1, 4 do p:Encode1(0xC5) end
  for i = 1, 4 do p:Encode1(0x6A) end
  for i = 1, 4 do p:Encode1(0x00) end
  SendPacket(p)
end
end

---//==================================================\\---
--|| > Skin Hack Packets -Divine                         ||--
---\\==================================================//---
 function SendSkinPacket(mObject, skinPB, networkID)
if (_GAME_VERSION ~= nil) then
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
  end;
end;
if (_GAME_VERSION ~= nil) then
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
end;
---//==================================================\\---
--|| > Basic Needs For My Scripts                              ||--
---\\==================================================//---
function CountEnemyHeroInRange(range)
    local enemyInRange = 0
    for i = 1, heroManager.iCount, 1 do
        local hero = heroManager:getHero(i)
        if ValidTarget(hero,range) then
            enemyInRange = enemyInRange + 1
        end
    end
    return enemyInRange
end 
  function UnitHaveBuff(unit, buffName)
    if unit and buffName and unit.buffCount then
      for i = 1, unit.buffCount do
        local buff = unit:getBuff(i)
        if buff and buff.valid and buff.startT <= GetGameTimer() and buff.endT >= GetGameTimer() and buff.name ~= nil and (buff.name:lower():find(buffName:lower()) or buffName:lower():find(buff.name:lower()) or buffName:lower() == buff.name:lower()) then 
          return true
        end
      end
    end
    return false
  end

function CountObjectsNearPos(pos, range, radius, objects)
      local n = 0
      for i, object in ipairs(objects) do
          if GetDistanceSqr(pos, object) <= radius * radius then
              n = n + 1
          end
      end
      return n
  end
  function GetBestCircularFarmPosition(range, radius, objects)
      local BestPos 
      local BestHit = 0
      for i, object in ipairs(objects) do
          local hit = CountObjectsNearPos(object.pos or object, range, radius, objects)
          if hit > BestHit then
              BestHit = hit
              BestPos = Vector(object)
              if BestHit == #objects then
                 break
              end
           end
      end
      return BestPos, BestHit
  end
   function GetBestLineFarmPosition(range, width, objects)
      local BestPos 
      local BestHit = 0
      for i, object in ipairs(objects) do
          local EndPos = Vector(myHero.pos) + range * (Vector(object) - Vector(myHero.pos)):normalized()
          local hit = CountObjectsOnLineSegment(myHero.pos, EndPos, width, objects)
          if hit > BestHit then
              BestHit = hit
              BestPos = Vector(object)
              if BestHit == #objects then
                 break
              end
           end
      end
  
      return BestPos, BestHit
  end
  
  function CountObjectsOnLineSegment(StartPos, EndPos, width, objects)
      local n = 0
      for i, object in ipairs(objects) do
          local pointSegment, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(StartPos, EndPos, object)
          if isOnSegment and GetDistanceSqr(pointSegment, object) < width * width then
              n = n + 1
          end
      end
  
      return n
  end
   function CurrentTimeInMillis()
  return (os.clock() * 1000);
end
    function CircleIntersection(v1, v2, c, radius)
    assert(VectorType(v1) and VectorType(v2) and VectorType(c) and type(radius) == "number", "CircleIntersection: wrong argument types (<Vector>, <Vector>, <Vector>, integer expected)")
    
    local x1, y1, x2, y2, x3, y3 = v1.x, v1.z or v1.y, v2.x, v2.z or v2.y, c.x, c.z or c.y
    local r = radius
    local xp, yp, xm, ym = nil, nil, nil, nil
    local IsOnSegment = nil
    
    if x1 == x2 then
    
      local B = math.sqrt(r^2-(x1-x3)^2)
      
      xp, yp, xm, ym = x1, y3+B, x1, y3-B
    else
    
      local m = (y2-y1)/(x2-x1)
      local n = y1-m*x1
      local A = x3-m*(n-y3)
      local B = math.sqrt(A^2-(1+m^2)*(x3^2-r^2+(n-y3)^2))
      
      xp, xm = (A+B)/(1+m^2), (A-B)/(1+m^2)
      yp, ym = m*xp+n, m*xm+n
    end
    
    if x1 <= x2 then
      IsOnSegment = x1 <= xp and xp <= x2
    else
      IsOnSegment = x2 <= xp and xp <= x1        
    end
      if IsOnSegment then
      return Vector(xp, 0, yp)
    else
      return Vector(xm, 0, ym)
    end
    
  end
  function itemfix()
  
    ItemNames       = {
      [3303]        = "ArchAngelsDummySpell",
      [3007]        = "ArchAngelsDummySpell",
      [3144]        = "BilgewaterCutlass",
      [3188]        = "ItemBlackfireTorch",
      [3153]        = "ItemSwordOfFeastAndFamine",
      [3405]        = "TrinketSweeperLvl1",
      [3411]        = "TrinketOrbLvl1",
      [3166]        = "TrinketTotemLvl1",
      [3450]        = "OdinTrinketRevive",
      [2041]        = "ItemCrystalFlask",
      [2054]        = "ItemKingPoroSnack",
      [2138]        = "ElixirOfIron",
      [2137]        = "ElixirOfRuin",
      [2139]        = "ElixirOfSorcery",
      [2140]        = "ElixirOfWrath",
      [3184]        = "OdinEntropicClaymore",
      [2050]        = "ItemMiniWard",
      [3401]        = "HealthBomb",
      [3363]        = "TrinketOrbLvl3",
      [3092]        = "ItemGlacialSpikeCast",
      [3460]        = "AscWarp",
      [3361]        = "TrinketTotemLvl3",
      [3362]        = "TrinketTotemLvl4",
      [3159]        = "HextechSweeper",
      [2051]        = "ItemHorn",
      --[2003]      = "RegenerationPotion",
      [3146]        = "HextechGunblade",
      [3187]        = "HextechSweeper",
      [3190]        = "IronStylus",
      [2004]        = "FlaskOfCrystalWater",
      [3139]        = "ItemMercurial",
      [3222]        = "ItemMorellosBane",
      [3042]        = "Muramana",
      [3043]        = "Muramana",
      [3180]        = "OdynsVeil",
      [3056]        = "ItemFaithShaker",
      [2047]        = "OracleExtractSight",
      [3364]        = "TrinketSweeperLvl3",
      [2052]        = "ItemPoroSnack",
      [3140]        = "QuicksilverSash",
      [3143]        = "RanduinsOmen",
      [3074]        = "ItemTiamatCleave",
      [3800]        = "ItemRighteousGlory",
      [2045]        = "ItemGhostWard",
      [3342]        = "TrinketOrbLvl1",
      [3040]        = "ItemSeraphsEmbrace",
      [3048]        = "ItemSeraphsEmbrace",
      [2049]        = "ItemGhostWard",
      [3345]        = "OdinTrinketRevive",
      [2044]        = "SightWard",
      [3341]        = "TrinketSweeperLvl1",
      [3069]        = "shurelyascrest",
      [3599]        = "KalistaPSpellCast",
      [3185]        = "HextechSweeper",
      [3077]        = "ItemTiamatCleave",
      [2009]        = "ItemMiniRegenPotion",
      [2010]        = "ItemMiniRegenPotion",
      [3023]        = "ItemWraithCollar",
      [3290]        = "ItemWraithCollar",
      [2043]        = "VisionWard",
      [3340]        = "TrinketTotemLvl1",
      [3090]        = "ZhonyasHourglass",
      [3154]        = "wrigglelantern",
      [3142]        = "YoumusBlade",
      [3157]        = "ZhonyasHourglass",
      [3512]        = "ItemVoidGate",
      [3131]        = "ItemSoTD",
      [3137]        = "ItemDervishBlade",
      [3352]        = "RelicSpotter",
      [3350]        = "TrinketTotemLvl2",
    }
    
    _G.ITEM_1       = 06
    _G.ITEM_2       = 07
    _G.ITEM_3       = 08
    _G.ITEM_4       = 09
    _G.ITEM_5       = 10
    _G.ITEM_6       = 11
    _G.ITEM_7       = 12
    
    ___GetInventorySlotItem = rawget(_G, "GetInventorySlotItem")
    _G.GetInventorySlotItem = GetSlotItem
    
    
  end
  
  Interrupt = {
    ["Katarina"] = {charName = "Katarina", stop = {["KatarinaR"] = {name = "Death lotus(R)", spellName = "KatarinaR", ult = true }}},
    ["Nunu"] = {charName = "Nunu", stop = {["AbsoluteZero"] = {name = "Absolute Zero(R)", spellName = "AbsoluteZero", ult = true }}},
    ["Malzahar"] = {charName = "Malzahar", stop = {["AlZaharNetherGrasp"] = {name = "Nether Grasp(R)", spellName = "AlZaharNetherGrasp", ult = true}}},
    ["Caitlyn"] = {charName = "Caitlyn", stop = {["CaitlynAceintheHole"] = {name = "Ace in the hole(R)", spellName = "CaitlynAceintheHole", ult = true, projectileName = "caitlyn_ult_mis.troy"}}},
    ["FiddleSticks"] = {charName = "FiddleSticks", stop = {["Crowstorm"] = {name = "Crowstorm(R)", spellName = "Crowstorm", ult = true}}},
    ["Galio"] = {charName = "Galio", stop = {["GalioIdolOfDurand"] = {name = "Idole of Durand(R)", spellName = "GalioIdolOfDurand", ult = true}}},
    ["Janna"] = {charName = "Janna", stop = {["ReapTheWhirlwind"] = {name = "Monsoon(R)", spellName = "ReapTheWhirlwind", ult = true}}},
    ["MissFortune"] = {charName = "MissFortune", stop = {["MissFortune"] = {name = "Bullet time(R)", spellName = "MissFortuneBulletTime", ult = true}}},
    ["MasterYi"] = {charName = "MasterYi", stop = {["MasterYi"] = {name = "Meditate(W)", spellName = "Meditate", ult = false}}},
    ["Pantheon"] = {charName = "Pantheon", stop = {["PantheonRJump"] = {name = "Skyfall(R)", spellName = "PantheonRJump", ult = true}}},
    ["Shen"] = {charName = "Shen", stop = {["ShenStandUnited"] = {name = "Stand united(R)", spellName = "ShenStandUnited", ult = true}}},
    ["Urgot"] = {charName = "Urgot", stop = {["UrgotSwap2"] = {name = "Position Reverser(R)", spellName = "UrgotSwap2", ult = true}}},
    ["Varus"] = {charName = "Varus", stop = {["VarusQ"] = {name = "Piercing Arrow(Q)", spellName = "Varus", ult = false}}},
    ["Warwick"] = {charName = "Warwick", stop = {["InfiniteDuress"] = {name = "Infinite Duress(R)", spellName = "InfiniteDuress", ult = true}}},
}
---//==================================================\\---
--|| >  iskeydownfix                           ||--
---\\==================================================//---
  local originalKD = _G.IsKeyDown;
  _G.IsKeyDown = function(theKey)
    if (type(theKey) ~= 'number') then
      local theNumber = tonumber(theKey);
      if (theNumber ~= nil) then
        return originalKD(theNumber);
      else
        return originalKD(GetKey(theKey));
      end;
    else
      return originalKD(theKey);
    end;
  end;


---//==================================================\\---
--|| > Skin Hack Table --Credits to Divine                 ||--
---\\==================================================//---
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
