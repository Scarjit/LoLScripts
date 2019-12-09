--[[
   _____ __                 _        __  __           _                   _____ _                                 _              _____ __                 _       _____           _       _       
  / ____/_ |               | |      |  \/  |         | |                 / ____| |                               | |            / ____/_ |               | |     / ____|         (_)     | |      
 | (___  | |_ __ ___  _ __ | | ___  | \  / | __ _ ___| |_ ___ _ __ _   _| |    | |__   ___   ___  ___  ___ _ __  | |__  _   _  | (___  | |_ __ ___  _ __ | | ___| (___   ___ _ __ _ _ __ | |_ ___ 
  \___ \ | | '_ ` _ \| '_ \| |/ _ \ | |\/| |/ _` / __| __/ _ \ '__| | | | |    | '_ \ / _ \ / _ \/ __|/ _ \ '__| | '_ \| | | |  \___ \ | | '_ ` _ \| '_ \| |/ _ \\___ \ / __| '__| | '_ \| __/ __|
  ____) || | | | | | | |_) | |  __/ | |  | | (_| \__ \ ||  __/ |  | |_| | |____| | | | (_) | (_) \__ \  __/ |    | |_) | |_| |  ____) || | | | | | | |_) | |  __/____) | (__| |  | | |_) | |_\__ \
 |_____/ |_|_| |_| |_| .__/|_|\___| |_|  |_|\__,_|___/\__\___|_|   \__, |\_____|_| |_|\___/ \___/|___/\___|_|    |_.__/ \__, | |_____/ |_|_| |_| |_| .__/|_|\___|_____/ \___|_|  |_| .__/ \__|___/
                     | |                                            __/ |                                                __/ |                     | |                             | |            
                     |_|                                           |___/                                                |___/                      |_|                             |_|            

API Documentation:
	MasteryChooser:open()
		Show's the MasteryChooser on the Screen
	MasteryChooser:close()
		Hide's the MasteryChooser from the Screen
	MasteryChooser:GetValue(mpage, page, id)
		Get the Integer Value.
			mpage: Mastery Page (0-math.huge) [User Created]
			page: 
				1: Ferocity
				2: Cunning
				3: Resolve
			id:
				Valid Values: 1-13 (Including 1 and 13)
				Goes from the top left of the page (Ferocity, Cunning, Resolve)
				to the bottom right
	MasteryChooser:SetValue(mpage, page, id, newvalue)
		Set the Integer Value.
			mpage: Mastery Page (0-math.huge) [User Created]
			page: 
				1: Ferocity
				2: Cunning
				3: Resolve
			id:
				Valid Values: 1-13 (Including 1 and 13)
				Goes from the top left of the page (Ferocity, Cunning, Resolve)
				to the bottom right
			newvalue:
				Valid Values:
					5 for id 1,2,5,6,9,10
					1 for 3,4,7,8,11,12,13
	MasteryChooser:GetValuebyName(mpage, mname)
		Get the Integer Value.
			mpage: Mastery Page (0-math.huge) [User Created]
			mname: Name of the Mastery


	MasteryChooser:SetValuebyName(mpage, mname, newvalue)
		Set the Integer Value.
			mpage: Mastery Page (0-math.huge) [User Created]
			mname: Name of the Mastery
			newvalue: A valid integer Value
	MasteryChooser:GetVersion()
		Returns current Libary Version
	MasteryChooser:GetDescription(id)
		Get description by Mastery id (1-39)

	MasteryChooser:GetDescriptionbyName(name)
		Get description by Mastery name



Example Script:

require("S1mple_MasteryChooser")

function OnLoad()
	print("Loaded")
	mc = MasteryChooser()
	mc:open()
	print(mc:GetValue(0 ,1, 1))
	mc:SetValue(0,1,1,5)
	print(mc:GetValuebyName(0,"Fury"))
	mc:SetValuebyName(0,"Fury",1)
	print(mc:GetDescription(10))
	print(mc:GetDescriptionbyName("Intelligence"))
end


Other Information:

	MasteryChooser:GetValue(mpage, page, id) and MasteryChooser:SetValue(mpage, page, id, newvalue) both have some check's in it to error on wrong Values,
	but please also try to make some Checks in your Script.

	The Savedata can be found in the Scripts/Common/Saves folder.
	It's named: MasteryChooser.dat (A simple Text file)


License Disclaimer:
	This Script is licensed under:
		Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
		Read the License here:
		http://creativecommons.org/licenses/by-sa/4.0/

		TL;DR:
		You may:
			Copy and redistribute the Script
			Modify the Script as you like
		You have to:
			Give credit to the Original Owner (S1mpleScripts)
		You may not:
			Change the License of any Part of this Script
]]--


local sqrt, max, deg, asin, cos, pi, floor, ceil, sin, huge, random, round = math.sqrt, math.max, math.deg, math.asin, math.cos, math.pi, math.floor, math.ceil, math.sin, math.huge, math.random, math.round

class ("MasteryChooser")
function MasteryChooser:__init()
	self.masterynames = {
		["Fury"] = {1,1},
		["Sorcery"] = {1,2},
		["Double Edged Sword"] = {1,3},
		["Feast"] = {1,4},
		["Vampirism"] = {1,5},
		["Natural Talent"] = {1,6},
		["Bounty Hunter"] = {1,7},
		["Oppressor"] = {1,8},
		["Battering Blows"] = {1,9},
		["Piercing Thought"] = {1,10},
		["Warlord's Bloodlust"] = {1,11},
		["Fervor of Battle"] = {1,12},
		["Deathfire Touch"] = {1,13},

		["Wanderer"] = {2,1},
		["Savagery"] = {2,2},
		["Runic Affinity"] = {2,3},
		["Secret Stash"] = {2,4},
		["Merciless"] = {2,5},
		["Meditation"] = {2,6},
		["Bandit"] = {2,7},
		["Dangerous Game"] = {2,8},
		["Precision"] = {2,9},
		["Intelligence"] = {2,10},
		["Stormraider's Surge"] = {2,11},
		["Thunderlord's Decree"] = {2,12},
		["Windspeaker's Blessing"] = {2,13},
		
		
		["Recovery"] = {3,1},
		["Unyielding"] = {3,2},
		["Explorer"] = {3,3},
		["Though Skin"] = {3,4},
		["Runic Armor"] = {3,5},
		["Veteran's Scars"] = {3,6},
		["Insight"] = {3,7},
		["Perseverance"] = {3,8},
		["Swiftness"] = {3,9},
		["Legendary Guardian"] = {3,10},
		["Grasp of the Undying"] = {3,11},
		["Strengh of the Ages"] = {3,12},
		["Bond of Stone"] = {3,13}
	}
	self.masterydesc = {
		[1] = "+0.8% Attack Speed.",
		[2] = "+0.4% increased Ability and Spell damage.",
		[3] = "Melee - Deal an additional 3% damage,\ntake an additional 1.5% damage.\nRanged - Deal and take an additional\n2% damage.",
		[4] = "Killing a unit restored 20 Health\n(20 second cooldown).",
		[5] = "+0.4% Lifesteal and Spell Vamp.",
		[6] = "+2 Attack Damage and 3 Ability Power\nat level 18 (.11 Attack Damage and\n.16 Ability Power per level).",
		[7] = "You deal 1% increased damage for each\n unique enemy champion you kill.",
		[8] = "You deal 2.5% increased damage to\ntargets with impaired movement\n(slow, stun, snare, taunt, etc.).",
		[9] = "+1.4% Armor Penetration.",
		[10] = "+1.4% Magic Penetration.",
		[11] = "Critical strikes heal for 15% of the\ndamage deal and grant you 20%\nattack speed for 4 second (2 second\ncooldown).",
		[12] = "You basic attacks and spells grant you\na stack of Fervor for 5 seconds\n(max 10 Stacks). Each stack of\nFervor adds 1-8 bonus physical damage\nto your basic attacks against champions,\nbased on your level.",
		[13] = "Your damaging abilities cause enemy\nchampions to take 6 + 50% of you\nBonus Attack Damage and 20% of you\nAbility Power in Magic damage over 3\nsecond (Area of effect and damage over\ntime abilities apply half of this\ndamage over 1.5 seconds instead).",
		[14] = "+0.6% Movement Speed out of Combat.",
		[15] = "Basic attacks and single target spells\ndeal 1 bonus damage to minions\nand monsters.",
		[16] = "Buffs granted by jungle monsters last\n15% longer, including Epic Monsters.",
		[17] = "Your potions, flask, and elexirs last\n10% longer. Additionaly, your\npotions are replaced with biscuits\nthat restore 20 Health and 10 Mana\ninstantly upon consumation.",
		[18] = "Dead 1% increased damage to champions\nbelow 40% Health.",
		[19] = "Once every 5 seconds regenerate 0.3% of\nyour missing Mana.",
		[20] = "Gain 1 gold of each nearby minions\nkilled by allied champions. Gain\nan additional 3 gold (or 10 if you're\nmelee) when hitting an enemy champion\nwith an attack or spell (Cannot occure\nmore then once every 5 seconds).",
		[21] = "Champion kills and assits restore 5% of\nyour missing Health and Mana.",
		[22] = "Gain 0.6 + 0.06 per level Armor and\nMagic Penetration.",
		[23] = "Your Cooldown Reduction cap is increased\nby 1%, gain 1% Cooldown\nReduction.",
		[24] = "Dealing 30% of a champion's max Health\nwithin 2 seconds grant you\n35% Movement Speed for 3 seconds (10\nseconds cooldown).",
		[25] = "Your 3rd attack or spell on an enemy\nchampion shocks the area around\nthem, dealing 10 damage per level plu\n20% of your Bonus Attack Damage\nand 10% of your Ability Power as Magic\ndamage to enemies in the area\n(30 second cooldown).",
		[26] = "Your heals and shields are 10% stronger.\nAdditionaly, your shields\nand heals increase your target's resitance\nby 15% for 3 seconds when used\non an ally other than yourself.",
		[27] = "+0.4% Health Regen per 5 seconds.",
		[28] = "+1.2 Bonus Armor and Magic Resist.",
		[29] = "+12 Movement Speed in Brush and River.",
		[30] = "You take 2 less damage form Champion and\nMonster basic attacks.",
		[31] = "+1.6% bonus to all shields and healing\non you (includes lifesteal\nand regeneration).",
		[32] = "+0.8% Total Health.",
		[33] = "Your summoner spells have 15% reduced\ncooldown.",
		[34] = "+50% Health Regen, increased to +200%\nwhen below 20% Health.",
		[35] = "+3% Tenacity and Slow Resist.",
		[36] = "+0.6 Armor and Magic Resist for each\nnearby enemy Champion.",
		[37] = "Every 4 seconds in combat your next attack\nagainst an enemy champion\nsteal life equal to 3% of your max\nHealth (halved for ranged champions).",
		[38] = "Large monsters and siege minions that you\nor nearby allies kill grant\nyou 20 and 10 permanent Health resprectively\n(300 max). After reaching\nthe max bonus further siege minions\nkills restore 100 Health.",
		[39] = "+4% Damage Reduction. While near an ally\nthis bonus is doubled and\n8% of the damage they would take from\nchampions is dealt to you instead\n(cannont reduce you below 15% Health)."
	}
	self.updated = false
	self.visible = false
	self.buttons = {}
	self.pages = {}
	self.sprites = {}
	self.bgsprite = createSprite(SPRITE_PATH.."\\S1mple\\masterypage.jpg")
	self.activepage = 0
	self.version = "1.83"
	self.hoverbutton = ""

	self:update()
	self:checkSprites()
	if self.updated == false then
		self:registerSprite()
		self:load()

		AddDrawCallback(function()
			self:draw()
		end)

		AddMsgCallback(function(msg, wParam)
			self:clicklogic(msg, wParam)
		end)
	end
end

--Draws

function MasteryChooser:draw()
	if self.visible == false or self.updated == true then return end
	local w, h1, h2 = (WINDOW_W*0.50), (WINDOW_H*.15), (WINDOW_H*.9)
	table.clear(self.buttons)
	self.bgsprite:Draw(w/2.7+1.35,h1*1.875,255)

	--Draw Functional Buttons
	self:DrawRectangleButton(w*1.25,h1+230,210,45, ARGB(255,30,30,30), ARGB(255,0,0,0), "save")
	DrawTextA("Save Masteries",18 , w*1.25+80,h1+230, ARGB(255,204,204,0), "center", "center")

	self:DrawRectangleButton(w*1.25,h1+300,210,45, ARGB(255,30,30,30), ARGB(255,0,0,0), "delete")
	DrawTextA("Delete Page",18 , w*1.25+80,h1+300, ARGB(255,204,204,0), "center", "center")

	self:DrawRectangleButton(w*1.25,h1+370,210,45, ARGB(255,30,30,30), ARGB(255,0,0,0), "empty")
	DrawTextA("Empty Page",18 , w*1.25+80,h1+370, ARGB(255,204,204,0), "center", "center")

	self:DrawRectangleButton(w*1.25,h1+440,210,45, ARGB(255,30,30,30), ARGB(255,0,0,0), "close")
	DrawTextA("CLOSE",18 , w*1.25+80,h1+440, ARGB(255,204,204,0), "center", "center")

	--Draw Text Area
	if self.hoverbutton ~= "" then
		local mnum
		if tonumber(string.sub(self.hoverbutton,-2)) then
			mnum = tonumber(string.sub(self.hoverbutton,-2))
		else 
			mnum = tonumber(string.sub(self.hoverbutton,-1))
		end
		if mnum then
			local TAreax = w*1.25
			local TAreay = h1+510
			local TAreaWidht = 250
			local points = {}
			points[1] = D3DXVECTOR2(floor(TAreax), floor(TAreay))
    		points[2] = D3DXVECTOR2(floor(TAreax + TAreaWidht), floor(TAreay))
			DrawLines2(points, 90, ARGB(120,18,18,18))
			local line = self.masterydesc[mnum]
			DrawTextA(line,14 , w*1.25+2,h1+475, ARGB(255,255,255,255), "left", "top")
		end
	end

	--Draw Page Buttons
	for i=0, #self.pages do --For every created runepage
		if i == self.activepage then
			self:DrawRectangleButton(w/3+32+i*50,h1+100,45,45, ARGB(255,0,0,204), ARGB(255,0,0,204), "page"..i)
			DrawTextA(tostring(i),18 , w/3+32+22.5+i*50,h1+100, ARGB(255,204,204,0), "center", "center")
		else
			self:DrawRectangleButton(w/3+32+i*50,h1+100,45,45, ARGB(255,0,0,204), ARGB(255,0,0,104), "page"..i)
			DrawTextA(tostring(i),18 , w/3+32+22.5+i*50,h1+100, ARGB(255,204,204,0), "center", "center")
		end
	end
	--Draw Plus Button
	local numpages = #self.pages+1 --For every created runepage + 1
	self:DrawRectangleButton(w/3+32+numpages*50,h1+100,45,45, ARGB(255,0,0,204), ARGB(255,0,0,104), "newpage")
	DrawTextA("+",18 , w/3+32+22.5+numpages*50,h1+100, ARGB(255,204,204,0), "center", "center")

	--Draw Counters
	local fero = 0
	local cunn = 0
	local reso = 0
	for i=1,13 do
		fero = fero + self.pages[self.activepage][1][i]
		cunn = cunn + self.pages[self.activepage][2][i]
		reso = reso + self.pages[self.activepage][3][i]
	end
	DrawTextA(tostring(fero),21 , w/1.96,h1*4.43, ARGB(255,204,204,0), "center", "center")
	DrawTextA(tostring(cunn),21 , w/1.244,h1*4.43, ARGB(255,204,204,0), "center", "center")
	DrawTextA(tostring(reso),21 , w*1.076,h1*4.43, ARGB(255,204,204,0), "center", "center")

	--Draw Mastery Images (Ferocity)
	local textoffX = 20
	local shiftw = 0
	self:DrawRectangleButton(w/2.42+shiftw,h1*2.12,45,45, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery1")
	DrawTextA(tostring(self.pages[self.activepage][1][1]), 21 ,textoffX+w/2.42+shiftw,h1*2.12,ARGB(255,0,255,0), "center", "center")
	self:DrawRectangleButton(w/1.8+shiftw,h1*2.12,45,45, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery2")
	DrawTextA(tostring(self.pages[self.activepage][1][2]), 21 ,textoffX+w/1.8+shiftw,h1*2.12,ARGB(255,0,255,0), "center", "center")

	self:DrawRectangleButton(w/2.2+shiftw,h1*2.53,45,45, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery3")
	DrawTextA(tostring(self.pages[self.activepage][1][3]), 21 ,textoffX+w/2.2+shiftw,h1*2.53,ARGB(255,0,255,0), "center", "center")
	self:DrawRectangleButton(w/1.91+shiftw,h1*2.53,45,45, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery4")
	DrawTextA(tostring(self.pages[self.activepage][1][4]), 21 ,textoffX+w/1.91+shiftw,h1*2.53,ARGB(255,0,255,0), "center", "center")

	self:DrawRectangleButton(w/2.41+shiftw,h1*2.92,45,45, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery5")
	DrawTextA(tostring(self.pages[self.activepage][1][5]), 21 ,textoffX+w/2.41+shiftw,h1*2.92,ARGB(255,0,255,0), "center", "center")
	self:DrawRectangleButton(w/1.8+shiftw,h1*2.92,45,45, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery6")
	DrawTextA(tostring(self.pages[self.activepage][1][6]), 21 ,textoffX+w/1.8+shiftw,h1*2.92,ARGB(255,0,255,0), "center", "center")

	self:DrawRectangleButton(w/2.2+shiftw,h1*3.33,45,45, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery7")
	DrawTextA(tostring(self.pages[self.activepage][1][7]), 21 ,textoffX+w/2.2+shiftw,h1*3.33,ARGB(255,0,255,0), "center", "center")
	self:DrawRectangleButton(w/1.91+shiftw,h1*3.33,45,45, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery8")
	DrawTextA(tostring(self.pages[self.activepage][1][8]), 21 ,textoffX+w/1.91+shiftw,h1*3.33,ARGB(255,0,255,0), "center", "center")

	self:DrawRectangleButton(w/2.41+shiftw,h1*3.7,45,45, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery9")
	DrawTextA(tostring(self.pages[self.activepage][1][9]), 21 ,textoffX+w/2.41+shiftw,h1*3.7,ARGB(255,0,255,0), "center", "center")
	self:DrawRectangleButton(w/1.8+shiftw,h1*3.7,45,45, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery10")
	DrawTextA(tostring(self.pages[self.activepage][1][10]), 21 ,textoffX+w/1.8+shiftw,h1*3.7,ARGB(255,0,255,0), "center", "center")

	self:DrawRectangleButton(w/2.4+shiftw,h1*4.12,50,50, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery11")
	DrawTextA(tostring(self.pages[self.activepage][1][11]), 21 ,textoffX+w/2.4+shiftw,h1*4.12,ARGB(255,0,255,0), "center", "center")
	self:DrawRectangleButton(w/2.05+shiftw,h1*4.12,50,50, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery12")
	DrawTextA(tostring(self.pages[self.activepage][1][12]), 21 ,textoffX+w/2.05+shiftw,h1*4.12,ARGB(255,0,255,0), "center", "center")
	self:DrawRectangleButton(w/1.8+shiftw,h1*4.12,50,50, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery13")
	DrawTextA(tostring(self.pages[self.activepage][1][13]), 21 ,textoffX+w/1.8+shiftw,h1*4.12,ARGB(255,0,255,0), "center", "center")

	--Draw Mastery Images (Cunning)
	shiftw = 244
	self:DrawRectangleButton(w/2.42+shiftw,h1*2.12,45,45, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery14")
	DrawTextA(tostring(self.pages[self.activepage][2][1]), 21 ,textoffX+w/2.42+shiftw,h1*2.12,ARGB(255,0,255,0), "center", "center")
	self:DrawRectangleButton(w/1.8+shiftw,h1*2.12,45,45, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery15")
	DrawTextA(tostring(self.pages[self.activepage][2][2]), 21 ,textoffX+w/1.8+shiftw,h1*2.12,ARGB(255,0,255,0), "center", "center")
	
	self:DrawRectangleButton(w/2.2+shiftw,h1*2.53,45,45, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery16")
	DrawTextA(tostring(self.pages[self.activepage][2][3]), 21 ,textoffX+w/2.2+shiftw,h1*2.53,ARGB(255,0,255,0), "center", "center")
	self:DrawRectangleButton(w/1.91+shiftw,h1*2.53,45,45, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery17")
	DrawTextA(tostring(self.pages[self.activepage][2][4]), 21 ,textoffX+w/1.91+shiftw,h1*2.53,ARGB(255,0,255,0), "center", "center")
	
	self:DrawRectangleButton(w/2.41+shiftw,h1*2.92,45,45, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery18")
	DrawTextA(tostring(self.pages[self.activepage][2][5]), 21 ,textoffX+w/2.41+shiftw,h1*2.92,ARGB(255,0,255,0), "center", "center")
	self:DrawRectangleButton(w/1.8+shiftw,h1*2.92,45,45, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery19")
	DrawTextA(tostring(self.pages[self.activepage][2][6]), 21 ,textoffX+w/1.8+shiftw,h1*2.92,ARGB(255,0,255,0), "center", "center")
	
	self:DrawRectangleButton(w/2.2+shiftw,h1*3.33,45,45, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery20")
	DrawTextA(tostring(self.pages[self.activepage][2][7]), 21 ,textoffX+w/2.2+shiftw,h1*3.33,ARGB(255,0,255,0), "center", "center")
	self:DrawRectangleButton(w/1.91+shiftw,h1*3.33,45,45, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery21")
	DrawTextA(tostring(self.pages[self.activepage][2][8]), 21 ,textoffX+w/1.91+shiftw,h1*3.33,ARGB(255,0,255,0), "center", "center")
	
	self:DrawRectangleButton(w/2.41+shiftw,h1*3.7,45,45, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery22")
	DrawTextA(tostring(self.pages[self.activepage][2][9]), 21 ,textoffX+w/2.41+shiftw,h1*3.7,ARGB(255,0,255,0), "center", "center")
	self:DrawRectangleButton(w/1.8+shiftw,h1*3.7,45,45, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery23")
	DrawTextA(tostring(self.pages[self.activepage][2][10]), 21 ,textoffX+w/1.8+shiftw,h1*3.7,ARGB(255,0,255,0), "center", "center")
	
	self:DrawRectangleButton(w/2.4+shiftw,h1*4.12,50,50, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery24")
	DrawTextA(tostring(self.pages[self.activepage][2][11]), 21 ,textoffX+w/2.4+shiftw,h1*4.12,ARGB(255,0,255,0), "center", "center")
	self:DrawRectangleButton(w/2.05+shiftw,h1*4.12,50,50, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery25")
	DrawTextA(tostring(self.pages[self.activepage][2][12]), 21 ,textoffX+w/2.05+shiftw,h1*4.12,ARGB(255,0,255,0), "center", "center")
	self:DrawRectangleButton(w/1.8+shiftw,h1*4.12,50,50, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery26")
	DrawTextA(tostring(self.pages[self.activepage][2][13]), 21 ,textoffX+w/1.8+shiftw,h1*4.12,ARGB(255,0,255,0), "center", "center")

	--Draw Mastery Images (Resolve)
	shiftw = shiftw * 2 - 2
	self:DrawRectangleButton(w/2.42+shiftw,h1*2.12,45,45, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery27")
	DrawTextA(tostring(self.pages[self.activepage][3][1]), 21 ,textoffX+w/2.42+shiftw,h1*2.12,ARGB(255,0,255,0), "center", "center")
	self:DrawRectangleButton(w/1.8+shiftw,h1*2.12,45,45, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery28")
	DrawTextA(tostring(self.pages[self.activepage][3][2]), 21 ,textoffX+w/1.8+shiftw,h1*2.12,ARGB(255,0,255,0), "center", "center")
	
	self:DrawRectangleButton(w/2.2+shiftw,h1*2.53,45,45, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery29")
	DrawTextA(tostring(self.pages[self.activepage][3][3]), 21 ,textoffX+w/2.2+shiftw,h1*2.53,ARGB(255,0,255,0), "center", "center")
	self:DrawRectangleButton(w/1.91+shiftw,h1*2.53,45,45, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery30")
	DrawTextA(tostring(self.pages[self.activepage][3][4]), 21 ,textoffX+w/1.91+shiftw,h1*2.53,ARGB(255,0,255,0), "center", "center")
	
	self:DrawRectangleButton(w/2.41+shiftw,h1*2.92,45,45, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery31")
	DrawTextA(tostring(self.pages[self.activepage][3][5]), 21 ,textoffX+w/2.41+shiftw,h1*2.92,ARGB(255,0,255,0), "center", "center")
	self:DrawRectangleButton(w/1.8+shiftw,h1*2.92,45,45, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery32")
	DrawTextA(tostring(self.pages[self.activepage][3][6]), 21 ,textoffX+w/1.8+shiftw,h1*2.92,ARGB(255,0,255,0), "center", "center")
	
	self:DrawRectangleButton(w/2.2+shiftw,h1*3.33,45,45, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery33")
	DrawTextA(tostring(self.pages[self.activepage][3][7]), 21 ,textoffX+w/2.2+shiftw,h1*3.33,ARGB(255,0,255,0), "center", "center")
	self:DrawRectangleButton(w/1.91+shiftw,h1*3.33,45,45, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery34")
	DrawTextA(tostring(self.pages[self.activepage][3][8]), 21 ,textoffX+w/1.91+shiftw,h1*3.33,ARGB(255,0,255,0), "center", "center")
	
	self:DrawRectangleButton(w/2.41+shiftw,h1*3.7,45,45, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery35")
	DrawTextA(tostring(self.pages[self.activepage][3][9]), 21 ,textoffX+w/2.41+shiftw,h1*3.7,ARGB(255,0,255,0), "center", "center")
	self:DrawRectangleButton(w/1.8+shiftw,h1*3.7,45,45, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery36")
	DrawTextA(tostring(self.pages[self.activepage][3][10]), 21 ,textoffX+w/1.8+shiftw,h1*3.7,ARGB(255,0,255,0), "center", "center")
	
	self:DrawRectangleButton(w/2.4+shiftw,h1*4.12,50,50, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery37")
	DrawTextA(tostring(self.pages[self.activepage][3][11]), 21 ,textoffX+w/2.4+shiftw,h1*4.12,ARGB(255,0,255,0), "center", "center")
	self:DrawRectangleButton(w/2.05+shiftw,h1*4.12,50,50, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery38")
	DrawTextA(tostring(self.pages[self.activepage][3][12]), 21 ,textoffX+w/2.05+shiftw,h1*4.12,ARGB(255,0,255,0), "center", "center")
	self:DrawRectangleButton(w/1.8+shiftw,h1*4.12,50,50, ARGB(0,100,100,100), ARGB(0,100,200,100), "mastery39")
	DrawTextA(tostring(self.pages[self.activepage][3][13]), 21 ,textoffX+w/1.8+shiftw,h1*4.12,ARGB(255,0,255,0), "center", "center")
end


function MasteryChooser:RegisterButton(x,y,w,h,name) --Internal DO NOT CALL externaly
	local btn = {}
	btn[#btn+1] = x
	btn[#btn+1] = y
	btn[#btn+1] = w
	btn[#btn+1] = h
	btn[#btn+1] = name
	self.buttons[#self.buttons+1] = btn
end

function MasteryChooser:DrawWindow(x, y, w, h, color)
	if not x or not y or not w or not h then error("DrawRectangleButton Error, missing Size or Position") end
	if not color then color = ARGB(255, 255,255,255 ) end
	local points = {}
    points[1] = D3DXVECTOR2(floor(x), floor(y))
    points[2] = D3DXVECTOR2(floor(x + w), floor(y))
	DrawLines2(points, floor(h), color)
end

function MasteryChooser:DrawRectangleButton(x, y, w, h, color, convertcolor, name)
	if not x or not y or not w or not h then error("DrawRectangleButton Error, missing Size or Position") end
	if not name then error("Requires Internal name") end
	if not color then color = ARGB(255, 255,255,255 ) end
	if not convertcolor then convertcolor = ARGB(255, 1,1,1 ) end
    local points = {}
    points[1] = D3DXVECTOR2(floor(x), floor(y))
    points[2] = D3DXVECTOR2(floor(x + w), floor(y))
	local points2 = {}
	points2[1] = D3DXVECTOR2(floor(x), floor(y - h/2))
	points2[2] = D3DXVECTOR2(floor(x + w), floor(y - h/2))
	points2[3] = D3DXVECTOR2(floor(x + w), floor(y + h/2))
	points2[4] = D3DXVECTOR2(floor(x), floor(y + h/2))
	local t = GetCursorPos()
	polygon = Polygon(Point(points2[1].x, points2[1].y), Point(points2[2].x, points2[2].y), Point(points2[3].x, points2[3].y), Point(points2[4].x, points2[4].y))
	if polygon:contains(Point(t.x, t.y)) and t.x <= x+w and t.x > x then
		DrawLines2(points, floor(h), color)
		self.hoverbutton = name
	else
		DrawLines2(points, floor(h), convertcolor)
	end
	self:RegisterButton(x,y,w,h,name)
end

--Logic

function MasteryChooser:clicklogic(msg, wParam)
	if self.visible == false or self.updated == true then return end
	if msg == WM_LBUTTONDOWN  then
		local wtsmouse = WorldToScreen(D3DXVECTOR3(mousePos.x,mousePos.y,mousePos.z))
		local selectedbtn = ""
		for _,btn in pairs(self.buttons) do
			local x, y, w, h = 0, 0, 0, 0
			local name = ""
			for k,v in pairs(btn) do
				if k == 1 then x = v end
				if k == 2 then y = v end
				if k == 3 then w = v end
				if k == 4 then h = v end
				if k == 5 then name = v end
			end

			local points2 = {}
			points2[1] = D3DXVECTOR2(floor(x), floor(y - h/2))
			points2[2] = D3DXVECTOR2(floor(x + w), floor(y - h/2))
			points2[3] = D3DXVECTOR2(floor(x + w), floor(y + h/2))
			points2[4] = D3DXVECTOR2(floor(x), floor(y + h/2))
			local t = GetCursorPos()
			local polygon = Polygon(Point(points2[1].x, points2[1].y), Point(points2[2].x, points2[2].y), Point(points2[3].x, points2[3].y), Point(points2[4].x, points2[4].y))
			if polygon:contains(Point(t.x, t.y)) then
				if t.x <= x+w and t.x > x then
					self:btnlogic(name,x,y,w,h)
				end
			end
		end
	end
end

function MasteryChooser:btnlogic(name)

	if string.sub(name,1,-2) == "page" then
		self.activepage = tonumber(string.sub(name,5))
	elseif string.sub(name,1,-3) == "page" then
		self.activepage = tonumber(string.sub(name,5))
	end
	if name == "save" then
		self:save()
	end
	if name == "newpage" then
		local page = {}
		local ferocity = {}
		local cunning = {}
		local resolve = {}
		for i=1,13 do
			ferocity[i] = 0
			cunning[i] = 0
			resolve[i] = 0
		end
		page[1] = ferocity
		page[2] = cunning
		page[3] = resolve
		self.pages[#self.pages+1] = page
	end
	if name == "delete" then
		table.remove(self.pages,self.activepage)
		if self.activepage ~= 0 then
			self.activepage = self.activepage-1
		end
	end

	if name == "close" then
		self:close()
	end

	if name == "empty" then
		for k,v in pairs(self.pages[self.activepage]) do
			for k2,v2 in pairs(v) do
				self.pages[self.activepage][k][k2] = 0
			end
		end
	end

	if string.sub(name,1,-2) == "mastery" or string.sub(name,1,-3) == "mastery" then
		local mnum
		if tonumber(string.sub(name,-2)) then
			mnum = tonumber(string.sub(name,-2))
		else 
			mnum = tonumber(string.sub(name,-1))
		end
		local page = 0
		local x = mnum
		while x > 0 do
			x = x - 13
			page = page +1
		end
		mnum = mnum - (13*(page-1))
		if mnum ~= 3 and mnum ~= 4 and mnum ~= 7 and mnum ~= 8 and mnum ~= 11 and mnum ~= 12 and mnum ~= 13 then
			local otherpage = 0
			if mnum % 2 == 0 then
				otherpage = mnum - 1
			else
				otherpage = mnum + 1
			end
			local combinedvalue = self.pages[self.activepage][page][mnum] +self.pages[self.activepage][page][otherpage]
			if combinedvalue < 5 then
				self.pages[self.activepage][page][mnum] = self.pages[self.activepage][page][mnum] + 1
			elseif self.pages[self.activepage][page][mnum] < 5 then
				self.pages[self.activepage][page][mnum] = self.pages[self.activepage][page][mnum] + 1
				self.pages[self.activepage][page][otherpage] = self.pages[self.activepage][page][otherpage] - 1
			end
		elseif mnum == 3 or mnum == 4 or mnum == 7 or  mnum == 8 then
			local otherpage = 0
			if mnum % 2 == 0 then
				otherpage = mnum - 1
			else
				otherpage = mnum + 1
			end
			local combinedvalue = self.pages[self.activepage][page][mnum] +self.pages[self.activepage][page][otherpage]
			if combinedvalue < 1 then
				self.pages[self.activepage][page][mnum] = self.pages[self.activepage][page][mnum] + 1
			elseif self.pages[self.activepage][page][mnum] < 1 then
				self.pages[self.activepage][page][mnum] = self.pages[self.activepage][page][mnum] + 1
				self.pages[self.activepage][page][otherpage] = self.pages[self.activepage][page][otherpage] - 1
			end
		elseif mnum == 11 or mnum == 12 or mnum == 13 then
			local combinedvalue = self.pages[self.activepage][page][11] + self.pages[self.activepage][page][12] +self.pages[self.activepage][page][13]
			if combinedvalue < 1 then
				self.pages[self.activepage][page][mnum] = self.pages[self.activepage][page][mnum] + 1
			else
				self.pages[self.activepage][page][11] = 0
				self.pages[self.activepage][page][12] = 0
				self.pages[self.activepage][page][13] = 0
				self.pages[self.activepage][page][mnum] = self.pages[self.activepage][page][mnum] + 1
			end
		end
		local combined = 0
		for i=1,13 do
			combined = combined + self.pages[self.activepage][1][i] + self.pages[self.activepage][2][i] + self.pages[self.activepage][3][i]
		end
		if combined > 30 then
			self.pages[self.activepage][page][mnum] = self.pages[self.activepage][page][mnum] - 1
		end
	end

end

function MasteryChooser:save()
	MakeSurePathExists(LIB_PATH.."\\".."Saves")
	WriteFile(table.concat({"return ",table.serialize(self.pages, nil, true)}), LIB_PATH.."\\".."Saves".."\\".."MasteryChooser.dat", "w")
	print("Saved Masteries")
end

function MasteryChooser:load()
	if FileExist(LIB_PATH.."\\".."Saves".."\\".."MasteryChooser.dat") then
		local savedata = loadfile(LIB_PATH.."\\".."Saves".."\\".."MasteryChooser.dat")()
		self.pages = savedata
	else
		local page = {}
		local ferocity = {}
		local cunning = {}
		local resolve = {}
		for i=1,13 do
			ferocity[i] = 0
			cunning[i] = 0
			resolve[i] = 0
		end
		page[1] = ferocity
		page[2] = cunning
		page[3] = resolve
		self.pages[0] = page
		self:save()
	end
end

--Sprite Register
function MasteryChooser:registerSprite()
	if self.updated == true then return end
	for i=1,39 do
		local sprite = createSprite(SPRITE_PATH.."\\S1mple\\MasteryIcons\\"..i..".png")
		self.sprites[#self.sprites+1] = sprite
	end
end

--Downloads

function MasteryChooser:update()
	local serveradress = "www.s1mplescripts.de"
	local scriptadress = "/S1mple/Scripts/BolStudio/Libary/MasteryChooser/"
	local ServerVersionDATA = GetWebResult(serveradress , scriptadress.."/S1mple_MasteryChooser.version")
	if ServerVersionDATA then
		local ServerVersion = tonumber(ServerVersionDATA)
		if ServerVersion then
			if ServerVersion > tonumber(self.version) then
				print("Updating S1mple_MasteryChooser, don't press F9")
				DownloadFile("http://"..serveradress..scriptadress.."/S1mple_MasteryChooser.lua",LIB_PATH.."S1mple_MasteryChooser.lua", function ()
					print("Updated, press 2xF9")
					self.updated = true
					self.visible = false
				end)
			end
		else
			print("An error occured, while updating, please reload")
		end
	else
		print("Could not connect to update Server")
	end
end

function MasteryChooser:checkSprites()
	self.toupdate = 0
	CreateDirectory(SPRITE_PATH.."\\S1mple\\")
	CreateDirectory(SPRITE_PATH.."\\S1mple\\MasteryIcons\\")
	for i=1, 39 do
		if not FileExist(SPRITE_PATH.."\\S1mple\\MasteryIcons\\"..i..".png") then
			self:downloadSprite("MasteryIcons\\"..i..".png")
			self.toupdate = self.toupdate + 1
		end
	end
	if not FileExist(SPRITE_PATH.."\\S1mple\\masterypage.jpg") then
		self:downloadSprite("masterypage.jpg")
		self.toupdate = self.toupdate + 1
	end
	if self.updated then
		print("Downloading Sprites for S1mple_MasteryChooser, don't press F9")
	end
end

function MasteryChooser:downloadSprite(spritename)
	self.updated = true
	self.visible = false
s1mplesc
	local serveradress = "s1mplescripts.de"
	local scriptadress = "/S1mple/Scripts/BolStudio/Libary/MasteryChooser/Sprites/"
	DownloadFile("http://"..serveradress..scriptadress.."/"..spritename,SPRITE_PATH.."\\S1mple\\"..spritename, function ()
		self.toupdate = self.toupdate - 1
		if self.toupdate == 0 then
			print("Downloaded sprites, please do 2xF9")
		end
	end)
end

--[[External Calls]]

function MasteryChooser:open()
	self.visible = true
end

function MasteryChooser:close()
	self.visible = false
end

function MasteryChooser:GetValue(mpage, page, id)
	if not mpage then error("MasteryChooser: Mastery Page required") end
	if not id then error("MasteryChooser: Id required") end
	if not page then error("MasteryChooser: Page required") end
	mpage = tonumber(mpage)
	page = tonumber(page)
	id = tonumber(id)
	if page > 3 or page < 1 then error("MasteryChooser: page, has to be between 1-3") end
	if id > 13 or id < 1 then error("MasteryChooser: id, has to be between 1-13") end
	if mpage ~= 0 then
		if mpage > #self.pages then
			error("MasteryChooser: Page not found")
		end
	end
	if not self.pages[mpage][page][id] then
		error("MasteryChooser: self.pages["..mpage.."]["..page.."]["..id.."] could not be found")
	end
	return self.pages[mpage][page][id]
end

function MasteryChooser:SetValue(mpage, page, id, newvalue)
	if not mpage then error("MasteryChooser: Page required") end
	if not id then error("MasteryChooser: Id required") end
	if not page then error("MasteryChooser: Page required") end
	mpage = tonumber(mpage)
	page = tonumber(page)
	id = tonumber(id)
	newvalue = tonumber(newvalue)
	if page > 3 or page < 1 then error("MasteryChooser: page, has to be between 1-3") end
	if id > 13 or id < 1 then error("MasteryChooser: id, has to be between 1-13") end
	if newvalue > 5 or newvalue < 0 then error("MasteryChooser: newvalue, has to be within limits") end
	mpage = tonumber(mpage)
	if newvalue > 1 then
		if id == 3 or id == 4 or id == 7 or id == 8 or id == 11 or id == 12 or id == 13 then
			error("MasteryChooser: newvalue, hast to be within limits")
		end
	end
	if newvalue == 1 then
		if id == 3 or id == 4 or id == 7 or  id == 8 then
			local otherpage = 0
			if id % 2 == 0 then
				otherpage = id - 1
			else
				otherpage = id + 1
			end
			local combinedvalue = self.pages[mpage][page][id] +self.pages[mpage][page][otherpage]
			if combinedvalue < 1 then
				self.pages[mpage][page][id] = self.pages[mpage][page][id] + 1
			elseif self.pages[mpage][page][id] < 1 then
				self.pages[mpage][page][id] = self.pages[mpage][page][id] + 1
				self.pages[mpage][page][otherpage] = self.pages[mpage][page][otherpage] - 1
			end
		elseif id == 11 or id == 12 or id == 13 then
			local combinedvalue = self.pages[mpage][page][11] + self.pages[mpage][page][12] +self.pages[mpage][page][13]
			if combinedvalue < 1 then
				self.pages[mpage][page][id] = self.pages[mpage][page][id] + 1
			else
				self.pages[mpage][page][11] = 0
				self.pages[mpage][page][12] = 0
				self.pages[mpage][page][13] = 0
				self.pages[mpage][page][id] = self.pages[mpage][page][id] + 1
			end
		end
	end
	if mpage ~= 0 then
		if mpage > #self.pages then
			error("MasteryChooser: Page not found")
		end
	end
	self.pages[mpage][page][id] = newvalue
	self:save()
end

function MasteryChooser:GetValuebyName(mpage, mname)
	if not mname then error("MasteryChooser: MasteryName required") end
	local v = self.masterynames[mname]
	return self:GetValue(mpage, v[1], v[2])
end

function MasteryChooser:SetValuebyName(mpage, mname, newvalue)
	if not mname then error("MasteryChooser: MasteryName required") end
	local v = self.masterynames[mname]
	self:SetValue(mpage, v[1], v[2], newvalue)
end

function MasteryChooser:GetVersion()
	return(self.version)
end

function MasteryChooser:GetDescription(id)
	if not id or id < 1 or id > 39 then error("MasteryChooser: id required or out of range.") end
	return self.masterydesc[id]
end

function MasteryChooser:GetDescriptionbyName(name)
	if not name then error("MasteryChooser: name is required") end
	local v = self.masterynames[name]
	return self.masterydesc[(v[1]*v[2])]
end