_G.S1OrbLoading = true
-- http://bol-tools.com/ tracker
assert(load(Base64Decode("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"), nil, "bt", _ENV))()
TrackerLoad("xwcsl4vNguBEn5UW")

--[[
S1mpleOrbWalker API Version 2.1
	
	Variables:
		.version - current Script Version as String
		.menu - Script Menu, if AddToMenu() was used
		.allowMovement - Set this to os.clock()+X to Block Script Movement for X Seconds
		.allowAutoAttacks - Set this to os.clock()+X to Block Script AutoAttacks for X Seconds
		.myTeam - same as myHero.team
		.projectilespeeds - huge Table with AA Projectile Speeds
		.aaprojectilespeed - The actuall Projectile Speed
		.altAANames - Array of other AA Names
		.aaresets - Spells who are reseting AA Timer
		.aarange - The Auto Attack range of your Champion
		.LastAttack - Time of the last Auto Attack
		.windUpTime - Last WindUp Duration
		.animationTime - Last AnimationTime
		.AttackDoneAt - Time when the Attack will be finished
		.BaseWindUp - 1 / (windUpTime * attackspeed)
		.BaseAttackSpeed - 1 / (animationTime * attackSpeed)
		.LastMoveOrder - Time the last move Order was given
		_G.S1mpleOrbLoaded - Returns if the file was loaded
		_G.S1OrbLoading - Returns if the Script was loaded
		.callbacks = {} - Table of all registered Callbacks
		.forcedTarget - Table with the Forced Target and time until it should be enfoced

		--LEGACY
		Please only use Legacy functions if you have to.
		
		.aamode - Returns the Current AA Mode
			sbtw
			laneclear
			harass
			lasthit

	Classes:
		TargetSelector - The Target Selector i use
		Download - I would not recommend calling this Class Externaly


	Methods:
		:__init() - Init Method of the OrbWalker
		:draw() - All Draw happen here
		:OnProcessAttack(unit, spell) - Processes Auto Attacks and detects AA reset
		:IsAttack(spell) - returns if spell is an Auto Attack
		:ISAAReset(spell) - returns if spell resets AA Timer
		:ResetAA() - resets the AA timer
		:CanMove() - returns if the Hero can Move
		:CanAttack() - returns if the Hero can Attack
		:GetTime()  - returns os.clock()*1000
		:MoveOrFight() - Decides wheter to move or attack
		:IsOrbWalking() - returns if Hero is OrbWalking
		:GetTarget() - returns the Current OrbWalker Target
		:GetOrbMode() - returns the current OrbWalker Mode
		:AddToMenu(menu) - adds the OrbWalker to the given Menu
			Required for the OrbWalker to load
		:update() - performs the Script Autoupdate
		:AddCallback(callback, function)
			callback's:
				OnAttack - Triggered after an AA is recognized
				CanMove - Triggers when then Champion can move again
				CanAttack - Triggers when the Champion can AA again
		:RemoveCallback(function) - removes a callback
		:updateLegacy - updates legacy API functions
		:handleCallbacks() - Handles the Callback logic
		:CanLastHit(target) - Returns if myHero Damage > target.healt
		:SetTarget(target, time)
			Enforces a target
				target - any Valid Unit
				time (optional) - Only force till os.clock()+time
								- If you use a time < os.clock() it will assume that you
								- meant os.clock()+time
			Target will be unset, if out of range or time runs out
		:UnSetTarget()
			Unsets the enforced Target
		:spriteloader - Loads/Downloads the Sprites and if nessecary creates the Folders
		:print(arg) - Prints a Text using the Formating of my OrbWalker
		:GetLatency() - Returns the Current Latency or the Custom if overwriten

		
	Non Listed vars and Methods are not for public use
	Any write access to this Objects could damage the Performance of the OrbWalker

	ANY BUGREPORTS/FEATURE REQUEST:
		Please post them in my Forum Topic (http://forum.botoflegends.com/topic/89594-)
		or
		write me on Skype (S1mpleScripts)

		Please provide as much information as you can, if you report a bug.
]]--

class("S1mpleOrbWalker")
function S1mpleOrbWalker:__init()
	if _G.S1mpleOrbLoaded then return end
	
	if FileExist(LIB_PATH.."FHPrediction.lua") then
		require("FHPrediction")
		self.isFHPredloaded = true
	elseif FileExist(LIB_PATH.."VPrediction.lua") then
		require("VPrediction")
		VPred = VPrediction()
		self.isVPredloaded = true
	else
		error("VPred or FHPred needed to load S1mpleOrbWalker")
	end


	--Vars
		--External
			self.version = "3.0"
			self.menu = nil
			self.allowMovement = 0
			self.allowAutoAttacks = 0

		--Misc
			TargetSelector = TargetSelector()
		--OrbWalker
			--static
				self.myTeam = myHero.team
				self.projectilespeeds = {
						["Velkoz"] = 2000.0000 ,
						["Xerath"] = 2000.0000 ,
						["Thresh"] = 1000.0000 ,
						["Ziggs"] = 1500.0000 ,
						["KogMaw"] = 1800.0000 ,
						["Skarner"] = 500.0000 ,
						["Katarina"] = 467.0000 ,
						["Riven"] = 347.79999 ,
						["Ashe"] = 2000.0000 ,
						["Soraka"] = 1000.0000 ,
						["Jinx"] = 2750.0000 ,
						["JarvanIV"] = 20.0000 ,
						["Tryndamere"] = 347.79999 ,
						["Singed"] = 700.0000 ,
						["Diana"] = 347.79999 ,
						["Yasuo"] = 347.79999 ,
						["Ahri"] = 1750.0000 ,
						["Lulu"] = 1450.0000 ,
						["Lissandra"] = 2000.0000 ,
						["Draven"] = 1700.0000 ,
						["FiddleSticks"] = 1750.0000 ,
						["Sivir"] = 1750.0000 ,
						["Corki"] = 2000.0000 ,
						["Janna"] = 1200.0000 ,
						["Jax"] = 400.0000 ,
						["Shen"] = 400.0000 ,
						["Sona"] = 1500.0000 ,
						["Caitlyn"] = 2500.0000 ,
						["Trundle"] = 347.79999 ,
						["Malphite"] = 1000.0000 ,
						["Vi"] = 1000.0000 ,
						["Anivia"] = 1400.0000 ,
						["Heimerdinger"] = 1500.0000 ,
						["Evelynn"] = 467.0000 ,
						["Rumble"] = 347.79999 ,
						["Leblanc"] = 1700.0000 ,
						["Viktor"] = 2300.0000 ,
						["XinZhao"] = 20.0000 ,
						["Orianna"] = 1450.0000 ,
						["Vladimir"] = 1400.0000 ,
						["Nidalee"] = 1750.0000 ,
						["Syndra"] = 1800.0000 ,
						["Zac"] = 1000.0000 ,
						["Olaf"] = 347.79999 ,
						["Veigar"] = 1100.0000 ,
						["Twitch"] = 2500.0000 ,
						["Akali"] = 467.0000 ,
						["Urgot"] = 1300.0000 ,
						["Leona"] = 347.79999 ,
						["Karma"] = 1500.0000 ,
						["Jayce"] = 347.79999 ,
						["Galio"] = 1000.0000 ,
						["TwistedFate"] = 1500.0000 ,
						["Varus"] = 2000.0000 ,
						["Garen"] = 347.79999 ,
						["Swain"] = 1600.0000 ,
						["Vayne"] = 2000.0000 ,
						["Fiora"] = 467.0000 ,
						["Quinn"] = 2000.0000 ,
						["Brand"] = 2000.0000 ,
						["Teemo"] = 1300.0000 ,
						["Amumu"] = 500.0000 ,
						["Annie"] = 1200.0000 ,
						["Elise"] = 1600.0000 ,
						["Nami"] = 1500.0000 ,
						["Poppy"] = 500.0000 ,
						["Tristana"] = 2250.0000 ,
						["Graves"] = 3000.0000 ,
						["Morgana"] = 1600.0000 ,
						["MissFortune"] = 2000.0000 ,
						["Cassiopeia"] = 1200.0000 ,
						["Volibear"] = 467.0000 ,
						["Irelia"] = 467.0000 ,
						["Lucian"] = 2800.0000 ,
						["Udyr"] = 467.0000 ,
						["MonkeyKing"] = 20.0000 ,
						["Kennen"] = 1600.0000 ,
						["Nunu"] = 500.0000 ,
						["Ryze"] = 2400.0000 ,
						["Zed"] = 467.0000 ,
						["Nautilus"] = 1000.0000 ,
						["Gangplank"] = 1000.0000 ,
						["Lux"] = 1600.0000 ,
						["Sejuani"] = 500.0000 ,
						["Ezreal"] = 2000.0000 ,
						["Khazix"] = 500.0000 ,
						["Aatrox"] = 347.79999 ,
						["Hecarim"] = 500.0000 ,
						["Pantheon"] = 20.0000 ,
						["Shyvana"] = 467.0000 ,
						["Zyra"] = 1700.0000 ,
						["Karthus"] = 1200.0000 ,
						["Zilean"] = 1200.0000 ,
						["Chogath"] = 500.0000 ,
						["Malzahar"] = 2000.0000
					}
					self.aaprojectilespeed = myHero.range > 300 and (self.projectilespeeds[myHero.charName] and self.projectilespeeds[myHero.charName] or math.huge) or math.huge
					self.altAANames = {"caitlynheadshotmissile", "frostarrow", "garenslash2", "kennenmegaproc", "lucianpassiveattack", "masteryidoublestrike", "quinnwenhanced", "renektonexecute", "renektonsuperexecute", "rengarnewpassivebuffdash", "trundleq", "xenzhaothrust", "xenzhaothrust2", "xenzhaothrust3"}
					self.aaresets = { "dariusnoxiantacticsonh", "fiorae", "garenq", "hecarimrapidslash", "jaxempowertwo", "jaycehypercharge", "leonashieldofdaybreak", "luciane", "monkeykingdoubleattack", "mordekaisermaceofspades", "nasusq", "nautiluspiercinggaze", "netherblade", "parley", "poppydevastatingblow", "powerfist", "renektonpreexecute", "rengarq", "shyvanadoubleattack", "sivirw", "takedown", "talonnoxiandiplomacy", "trundletrollsmash", "vaynetumble", "vie", "volibearq", "xenzhaocombotarget", "yorickspectral", "reksaiq", "riventricleave", "kalistaexpunge", "itemtitanichydracleave", "itemtiamatcleave", "gravesmove", "masochism" }

				--non Static
					self.aarange = myHero.range + myHero.boundingRadius

					self.stop = false

					self.LastAttack = 0
					self.windUpTime = 0
					self.animationTime = 0
					self.AttackDoneAt = 0
					self.BaseWindUp = 1
					self.BaseAttackSpeed = 1
					self.LastMoveOrder = 0

					self.callbacks = {}
					self.triggercallA = false
					self.triggercallM = false

					self.forcedTarget = {target = nil, time = 0}

				--Legacy
					self.aamode = "none"


	self:update()
	self:spriteloader()

	AddProcessAttackCallback(function (unit, spell)
		self:OnProcessAttack(unit, spell)
	end)

	AddDrawCallback(function ()
		self:draw()
	end)

	AddTickCallback(function ()
		self.aarange = myHero.range + myHero.boundingRadius
		self:MoveOrFight()
		self:handleCallbacks()
		self:updateLegacy()
	end)

	_G.S1mpleOrbLoaded = true
end

function S1mpleOrbWalker:updateLegacy()
	local aamode = self:GetOrbMode()
	if aamode == "Combo" then
		self.aamode = "sbtw"
	else
		self.aamode = aamode:lower()
	end
end

function S1mpleOrbWalker:draw()
	if self.BaseWindUp == 1 and self.BaseAttackSpeed == 1 then
		DrawTextA("Please perform an Auto Attack to configure S1mpleOrbWalker", 36, WINDOW_W*0.2, 20)
	end
	if not self.menu then return end
	
	if self.menu and self.menu.misc.debug then
		DrawTextA("GetTime: "..self:GetTime(), 18,20,0)
		DrawTextA("LastAttack: "..self.LastAttack,18,20,20)
		DrawTextA("windUpTime: "..self.windUpTime,18,20,40)
		DrawTextA("animationTime: "..self.animationTime,18,20,60)
		DrawTextA("AttackDoneAt: "..self.AttackDoneAt,18,20,80)
		DrawTextA("BaseWindUp: "..self.BaseWindUp,18,20,100)
		DrawTextA("BaseAttackSpeed: "..self.BaseAttackSpeed,18,20,120)
		DrawTextA("CanAttack: "..tostring(self:CanAttack()), 18,20,140)
		DrawTextA("CanMove: "..tostring(self:CanMove()), 18,20,160)
		DrawTextA("OrbMode: "..tostring(self:GetOrbMode()), 18,20,180)
		DrawTextA("aarange: "..tostring(self.aarange),18,20,200)
		DrawTextA("_G.Evade: "..tostring(_G.Evade),18,20,220)
		DrawText3D("stop: "..tostring(self.stop),myHero.x,myHero.y,myHero.z)
	end

	if self.menu and self.menu.draw.range and not myHero.dead then
		DrawCircle3D(myHero.x,myHero.y,myHero.z,self.aarange,1,ARGB(255,0,255,0),30)
	end

	if self.menu.draw.erange then
		for _,v in pairs(GetEnemyHeroes()) do
			if v and not v.dead then
				DrawCircle3D(v.x,v.y,v.z,v.range+v.boundingRadius,1,ARGB(255,0,255,0),30)
			end
		end
	end

	if self.menu.draw.mhealth and not myHero.dead then
		for _,v in pairs(TargetSelector:GetAllTargets(self.aarange+300)) do
			if v and v.valid and not v.dead then
				local inrange = GetDistance(v,myHero) < self.aarange and true or false
				local dmg = self:RealADDamage(v, myHero, {name = "Basic"}, 0)
				local perc = dmg/v.health*100
				if self.menu.misc.debug then
					DrawText3D(tostring(GetDistance(v)),v.x,v.y+300,v.z)
				end
				if self.menu.draw.sprites then
					if self.crosshair_red and self.crosshair_green and self.crosshair_yellow then
						local wts = WorldToScreen(D3DXVECTOR3(v.x,v.y,v.z))
						Size = v.boundingRadius/300

						if perc < 50 then
							self.crosshair_red:SetScale(Size,Size)
							self.crosshair_red:Draw(wts.x-v.boundingRadius/2, wts.y-v.boundingRadius/2,255)		
						elseif perc > 50 and perc < 100 then
							self.crosshair_yellow:SetScale(Size,Size)
							self.crosshair_yellow:Draw(wts.x-v.boundingRadius/2, wts.y-v.boundingRadius/2,255)		
						elseif perc > 100 then
							self.crosshair_green:SetScale(Size,Size)
							self.crosshair_green:Draw(wts.x-v.boundingRadius/2, wts.y-v.boundingRadius/2,255)		
						end
					end
				elseif self.menu.draw.circleinstead then
					if perc < 50 then
						DrawCircle3D(v.x,v.y,v.z,20,5,ARGB(255,25.5*perc,255-25.5*perc,0),6)
					elseif perc > 50 and perc < 100 then
						DrawCircle3D(v.x,v.y,v.z,20,8,ARGB(255,25.5*perc,255-25.5*perc,0),6)
					elseif perc > 100 then
						DrawCircle3D(v.x,v.y,v.z,20,11,ARGB(255,255,0,255),6)
					end
				end
				if self.menu.draw.aaneeded then
					local tabs = math.floor(v.health/dmg)+1
					if self.menu.draw.numericaa then
						DrawText3D(tostring(tabs),v.x,v.y+10,v.z,30)
					else
						baseX = 0
						baseY = 0
						lenght = 0
						onehitsize = 9
						onehityoffset = 5
						onehitsizebordersize = 2
						permashownumber = false
						if v.type == myHero.type then
							local barPos = GetUnitHPBarPos(v) --THANKS Jori
							local barOffset = GetUnitHPBarOffset(v)
							do -- For some reason the x offset never exists
								local t = {
									["Darius"] = -0.05,
									["Renekton"] = -0.05,
									["Sion"] = -0.05,
									["Thresh"] = 0.03,
									["Jhin"] = -0.06,
								}
								
								barOffset.x = t[v.charName] or 0
							end
							baseX = barPos.x - 42 + barOffset.x * 150
							baseY = barPos.y + barOffset.y * 50 + 12.5
							if v.charName == "Jhin" then
								baseY = baseY-12
							end
							lenght = 63
						elseif v.type == 'obj_AI_Minion' then
							local barPos = GetUnitHPBarPos(v) --THANKS Jori
							local barOffset = GetUnitHPBarOffset(v)
							baseX = barPos.x + barOffset.x-32
							baseY = barPos.y + barOffset.y
							lenght = 63
							
							--Jungle and Special Mobs
							local charName = v.charName
							if charName and not string.match(charName,"Minion") then
								if charName == "SRU_Red" or charName == "SRU_Blue" or string.match(charName,"SRU_Dragon") or charName == "SRU_RiftHerald" then
									lenght = 141
									baseX = baseX-39
								elseif charName == "SRU_RedMini" or charName == "SRU_RedMini2" or charName == "SRU_BlueMini" or charName == "SRU_BlueMini2" then
									lenght = 50
									baseX = baseX+6
								elseif charName == "SRU_Krug"then
									lenght = 81
									baseX = baseX-8
								elseif charName == "SRU_KrugMini" or charName == "SRU_RazorbeakMini" or charName == "SRU_MurkwolfMini" then
									lenght = 55
									baseX = baseX+4
								elseif charName == "SRU_Razorbeak" or charName == "Sru_Crab" then
									lenght = 76
									baseX = baseX-5
								elseif charName == "SRU_Gromp" then
									lenght = 86
									baseX = baseX-12
								elseif charName == "SRU_Murkwolf" then
									lenght = 75
									baseX = baseX-6
								elseif charName == "SRU_Baron" then
									lenght = 192
									baseX = baseX-65
									onehitsizebordersize = 12
									onehitsize = 9
								else
									DrawText3D(tostring(tabs),v.x,v.y+10,v.z,30)
								end
							end
						elseif v.type == 'obj_AI_Turret' then
							
							local barPos = GetUnitHPBarPos(v) --THANKS Jori
							local barOffset = GetUnitHPBarOffset(v)
							baseX = barPos.x + barOffset.x-66
							baseY = barPos.y + barOffset.y
							lenght = 128
							
							permashownumber = true
						elseif v.type == 'obj_BarracksDampener' then
							local wts = WorldToScreen(D3DXVECTOR3(v.x,v.y,v.z))
							baseX = wts.x
							baseY = wts.y
							isbig = true
							permashownumber = true
						elseif v.type == 'obj_HQ' then
							local wts = WorldToScreen(D3DXVECTOR3(v.x,v.y,v.z))
							baseX = wts.x
							baseY = wts.y
							isbig = true
							permashownumber = true
						else
							local wts = WorldToScreen(D3DXVECTOR3(v.x,v.y,v.z))
							baseX = wts.x
							baseY = wts.y
							isbig = true
							permashownumber = true
						end

						if permashownumber then
							if isbig then
								DrawText(tostring(tabs),35,baseX,baseY,ARGB(255,255,255,255))
							else
								DrawText(tostring(tabs),18,baseX,baseY,ARGB(255,255,255,255))
							end
						else
							if tabs > 1 and tabs < 10 then
								lenght = lenght*(v.health/v.maxHealth)
								local tabsize = lenght/tabs
								for i=1,tabs do
									if inrange or not self.menu.draw.othercolor then
										DrawLine(baseX+tabsize*i,baseY,baseX+tabsize*i+2,baseY,7,ARGB(255,0,0,0))
									else
										DrawLine(baseX+tabsize*i,baseY,baseX+tabsize*i+2,baseY,7,ARGB(255,255,255,255))
									end
								end
							elseif tabs >= 10 then
								DrawText(tostring(tabs),18,baseX,baseY,ARGB(255,255,255,255))
							elseif self.menu.draw.showpurplebar then
								DrawRectangleOutline(baseX, baseY-onehityoffset, lenght, onehitsize, ARGB(255,255,0,255), onehitsizebordersize)
							end
						end
					end
				end
			end
		end
	end
end

function S1mpleOrbWalker:OnProcessAttack(unit, spell)
	if unit.isMe and spell then
		if self:IsAttack(spell) then
			self.LastAttack = self:GetTime()-self:GetLatency()/2
			self.windUpTime = spell.windUpTime * 1000
			self.animationTime = spell.animationTime * 1000
			self.AttackDoneAt = self.windUpTime + self.LastAttack

			self.BaseWindUp = 1 / (spell.windUpTime * myHero.attackSpeed)
			self.BaseAttackSpeed = 1 / (spell.animationTime * myHero.attackSpeed)

			for _,v in pairs(self.callbacks) do
				if v.cb == "OnAttack" then
					v.f()
				end
			end
			self.triggercallA = true
			self.triggercallM = true

		elseif self:IsAAReset(spell) then
			self:ResetAA()
		end
	end
end

function S1mpleOrbWalker:IsAttack(spell)
	name = spell.name:lower()
	if name:find("attack") then return true end
	for _,v in pairs(self.altAANames) do
		if v == name then return true end
	end
	return false
end

function S1mpleOrbWalker:IsAAReset(spell)
	name = spell.name:lower()
	for _, v in pairs(self.aaresets) do
		if v == name then return true end
	end
	return false
end

function S1mpleOrbWalker:ResetAA()
	self.LastAttack = 0
end

function S1mpleOrbWalker:CanMove()
	if not self.menu then return false end
	if self.allowMovement > os.clock() then return false end
	return self:GetTime() - (self.menu.adv.cannmovetoggle and self.menu.adv.canmove or 0) + self:GetLatency()/2 - self.LastAttack >= (1000/(myHero.attackSpeed*self.BaseWindUp))
end

function S1mpleOrbWalker:CanAttack()
	if not self.menu then return false end
	if self.allowAutoAttacks > os.clock() then return false end
	return self:GetTime() - (self.menu.adv.cannaatoggle and self.menu.adv.canaa or 20) + self:GetLatency()/2 - self.LastAttack >= (1000/(myHero.attackSpeed*self.BaseAttackSpeed))
end

function S1mpleOrbWalker:AddCallback(callback,func)
	if not func or not callback or (callback ~= "OnAttack" and callback ~= "CanMove" and callback ~= "CanAttack") then error("Error while adding Callback") end
	self.callbacks[#self.callbacks+1] = {cb = callback, f = func}
end

function S1mpleOrbWalker:RemoveCallback(func)
	if not func then error("func required to remove Callback") end
	local n = {}
	local x = false
	for _,v in pairs(self.callbacks) do
		if v.f ~= func then
			n[n+1] = func
		else
			x = true
		end
	end
	self.callbacks = n
	return x
end

function S1mpleOrbWalker:handleCallbacks()
	local m = self:CanMove() and self.triggercallA
	local a = self:CanAttack() and self.triggercallM
	for _,v in pairs(self.callbacks) do
		if v.cb == "CanMove" and m then
			v.f()
		elseif v.cb == "CanAttack" and a then
			v.f()
		end
	end
	if m then self.triggercallA = false end
	if a then self.triggercallM = false end
end

function S1mpleOrbWalker:GetTime()
	return os.clock() * 1000
end

function S1mpleOrbWalker:MoveOrFight()
	if _G.Evade ~= nil and _G.Evade == true then return end
	if not self:IsOrbWalking() then return end
	if not self.menu then return end
	if self:CanMove() or self:CanAttack() then
		if self:CanAttack() then
			local t = self:GetTarget()
			if t then
				myHero:Attack(t)
			elseif self:CanMove() and GetDistance(myHero, mousePos) > self.menu.misc.deadradius and os.clock() > self.LastMoveOrder+1/self:getMPS() then
				self.LastMoveOrder = os.clock()
				if not self.menu.misc.moveunderTower and self:GetOrbMode() == "Laneclear" and TargetSelector:IsDangerZone(mousePos) then
					myHero:HoldPosition()
				else
					myHero:MoveTo(mousePos.x,mousePos.z)
				end
			end
		elseif 
			self:CanMove() and GetDistance(myHero, mousePos) > self.menu.misc.deadradius and os.clock() > self.LastMoveOrder+1/self:getMPS() then
			self.LastMoveOrder = os.clock()
			if not self.menu.misc.moveunderTower and self:GetOrbMode() == "Laneclear" and TargetSelector:IsDangerZone(mousePos) then
				myHero:HoldPosition()
			else
				myHero:MoveTo(mousePos.x,mousePos.z)
			end
		end
	end
end

function S1mpleOrbWalker:IsOrbWalking()
	if self.menu and (self.menu.keys.harass or self.menu.keys.combo or self.menu.keys.laneclear or self.menu.keys.lasthit) then return true end
end

function S1mpleOrbWalker:GetTarget()
	local target = nil
	local mode = self:GetOrbMode()
	if mode == "none" then return end
	if self.forcedTarget.time > os.clock() then
		if ValidTarget(self.forcedTarget.target) and GetDistance(target) <= self.aarange then
			target = self.forcedTarget.target
		else
			self.forcedTarget = {target = nil, time = 0}
		end
	end

	if mode == "Combo" then
		target = TargetSelector:GetEnemyHero(self.aarange)
	elseif mode == "Harass" then
		target = TargetSelector:GetEnemyHero(self.aarange)
		if not target then target = TargetSelector:GetEnemyMinion(self.aarange) end
		if target and target.type == "obj_AI_Minion" and target.health > self:RealADDamage(target, myHero, {name = "Basic"}, 0) then
			target = nil
		end
	elseif mode == "Laneclear" then
		if not self.menu.misc.preferm then
			target = TargetSelector:GetStructurTarget(self.aarange)
		end
		if not target then
			target = TargetSelector:GetEnemyMinion(self.aarange)
		end
		if self.menu.minion.jungle and not target then
			target = TargetSelector:GetJungleMinion(self.aarange)
		end
		if self.menu.misc.tower and not target then
			target = TargetSelector:GetStructurTarget(self.aarange)
		end

		if target and target.type == "obj_AI_Minion" then
			--Only Attack if Lasthitable or no lasthit lost
			if not self:CanLastHit(target) then
				local minions = TargetSelector:GetAllEnemyMinions(self.aarange)
				for _, v in pairs(minions) do

					if self.isFHPredloaded then
						if not v.dead and FHPrediction.PredictHealth(v,(1000/(myHero.attackSpeed*self.BaseAttackSpeed)-GetDistance(v)/self.aaprojectilespeed))-self:RealADDamage(v, myHero, {name = "Basic"}, 0) <= 0 then
							target = nil
						end
					elseif self.isVPredloaded then
						if not v.dead and VPred:GetPredictedHealth(v,(1000/(myHero.attackSpeed*self.BaseAttackSpeed)-GetDistance(v)/self.aaprojectilespeed)+self:GetLatency()/2)-self:RealADDamage(v, myHero, {name = "Basic"}, 0) <= 0 then
							target = nil
						end
					end

				end
			end
		end
	elseif mode == "Lasthit" then
		target = TargetSelector:GetEnemyMinion(self.aarange)
		if target and not self:CanLastHit(target) then
			target = nil
		end
	end
	
	self.stop = target and false or true

	return target
end

function S1mpleOrbWalker:CanLastHit(target)
	return target.health < self:RealADDamage(target, myHero, {name = "Basic"}, 0)
end

function S1mpleOrbWalker:SetTarget(target, time)
	if not target or not ValidTarget(target) then return end
	if time and type(time) == number then
		if time > os.clock() then
			self.forcedTarget = {target = target, time = time}
		else
			self.forcedTarget = {target = target, time = os.clock()+time}
		end
	else
		self.forcedTarget = {target = target, time = math.huge}
	end
end

function S1mpleOrbWalker:UnSetTarget()
	self.forcedTarget = {target = nil, time = 0}
end

function S1mpleOrbWalker:GetOrbMode()
	if not self.menu then return "none" end
	if self.menu.keys.combo then return "Combo" end
	if self.menu.keys.harass or self.menu.keys.harassToggle then return "Harass" end
	if self.menu.keys.laneclear then return "Laneclear" end
	if self.menu.keys.lasthit then return "Lasthit" end
	return "none"
end

function S1mpleOrbWalker:AddToMenu(menu)
	self.menu = menu
	self.menu:addSubMenu("Keys", "keys")
		self.menu.keys:addParam("harass", "Harass Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
		self.menu.keys:addParam("combo", "Combo Key (32: Space)", SCRIPT_PARAM_ONKEYDOWN, false, string.byte(" "))
		self.menu.keys:addParam("laneclear", "Laneclear Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
		self.menu.keys:addParam("lasthit", "Lasthit Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("X"))
		self.menu.keys:addParam("info1", "To use the Toggle Key, please rebind them", SCRIPT_PARAM_INFO,"")
		self.menu.keys:addParam("harassToggle", "Harass Toggle Key", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("-"))
	self.menu:addSubMenu("Minion Settings", "minion")
		self.menu.minion:addParam("jungle", "Attack Jungle", SCRIPT_PARAM_ONOFF, true)
	self.menu:addSubMenu("Misc", "misc")
		self.menu.misc:addParam("tower", "Attack Structures", SCRIPT_PARAM_ONOFF, true)
		self.menu.misc:addParam("preferm", "Prefer Minions over Towers", SCRIPT_PARAM_ONOFF, false)
		self.menu.misc:addParam("deadradius", "Dead Radius", SCRIPT_PARAM_SLICE,20,0,200,0)
		self.menu.misc:addParam("healthpred", "Use Health Prediction", SCRIPT_PARAM_ONOFF, true)
		self.menu.misc:addParam("moveunderTower", "Move under Enemy Tower if no Minion (Laneclear)", SCRIPT_PARAM_ONOFF, false)
		self.menu.misc:addParam("debug", "Draw Debug Messages", SCRIPT_PARAM_ONOFF, false)

	self.menu:addSubMenu("Draw", "draw")
		self.menu.draw:addParam("range", "Draw Range", SCRIPT_PARAM_ONOFF, true)
		self.menu.draw:addParam("erange", "Draw Enemy Range", SCRIPT_PARAM_ONOFF, true)
		self.menu.draw:addParam("mhealth", "Draw Lasthit Indicators",SCRIPT_PARAM_ONOFF, true)
		self.menu.draw:addParam("aaneeded", "-> Draw Number of AA needed", SCRIPT_PARAM_ONOFF, true)
		self.menu.draw:addParam("othercolor","->->-> Draw out-of-range in other color", SCRIPT_PARAM_ONOFF, false)
		self.menu.draw:addParam("numericaa", "->-> Draw as Number", SCRIPT_PARAM_ONOFF, false)
		self.menu.draw:addParam("showpurplebar","->-> Show Purple Bar if Killable", SCRIPT_PARAM_ONOFF,true)
		self.menu.draw:addParam("sprites", "->Use Sprites", SCRIPT_PARAM_ONOFF, false)
		self.menu.draw:addParam("circleinstead", "->-> Use Circles instead",SCRIPT_PARAM_ONOFF, false)

	self.menu:addSubMenu("Humanizer", "human")
		self.menu.human:addParam("mpsmin", "Moves per Second (Min)", SCRIPT_PARAM_SLICE,8,1,75,0)
		self.menu.human:addParam("mpsmax", "Moves per Second (Max)", SCRIPT_PARAM_SLICE,10,1,75,0)
		self.menu.human:setCallback("mpsmin", function (value)
			if value > self.menu.human.mpsmax then
				self.menu.human.mpsmin = self.menu.human.mpsmax - 1
			end
		end)
		self.menu.human:setCallback("mpsmax", function (value)
			if value < self.menu.human.mpsmin then
				self.menu.human.mpsmax = self.menu.human.mpsmin + 1
			end
		end)

	self.menu:addSubMenu("Advanced", "adv")
		self.menu.adv:addParam("info1", "-----------------------Warning-----------------------", SCRIPT_PARAM_INFO, "")
		self.menu.adv:addParam("info1", "Modifing this Values, could make", SCRIPT_PARAM_INFO, "")
		self.menu.adv:addParam("info1", "this OrbWalker behave strange", SCRIPT_PARAM_INFO, "")
		self.menu.adv:addParam("info1", "-----------------------------------------------------", SCRIPT_PARAM_INFO, "")
		self.menu.adv:addParam("latencytoggle", "Override Latency", SCRIPT_PARAM_ONOFF, false)
		self.menu.adv:addParam("latency", "Latency: ", SCRIPT_PARAM_SLICE, 0,0,800,0)
		self.menu.adv:addParam("canaatoggle", "Override Can Attack Delay", SCRIPT_PARAM_ONOFF, false)
		self.menu.adv:addParam("canaa", "Can AA Delay", SCRIPT_PARAM_SLICE, 0,-50,50,0)
		self.menu.adv:addParam("canmovetoggle", "Override Can Move Delay", SCRIPT_PARAM_ONOFF, false)
		self.menu.adv:addParam("canmove", "Can Move Delay", SCRIPT_PARAM_SLICE, 20,-50,50,0)
		self.menu.adv:addParam("reloadsprites", "Reload Sprites", SCRIPT_PARAM_ONOFF, false)
		self.menu.adv.reloadsprites = false
		self.menu.adv:setCallback("reloadsprites", function (value)
			if value then
				self.menu.adv.reloadsprites = false
				self:spriteloader()
				self:print("Reloaded Sprites")
			end
		end)



	self.menu:addParam("versioninfo", "Version", SCRIPT_PARAM_INFO, self.version)
end


function S1mpleOrbWalker:RealADDamage(target, source, spell, additionalDamage)
	--Big Thanks to VPrediction
	-- read initial armor and damage values
    local armorPenPercent = source.armorPenPercent
    local armorPen = source.armorPen
    local totalDamage = source.totalDamage + (additionalDamage or 0)
    local damageMultiplier = spell.name:find("CritAttack") and 2 or 1

    -- minions give wrong values for armorPen and armorPenPercent
    if source.type == "obj_AI_Minion" then
        armorPenPercent = 1
    elseif source.type == "obj_AI_Turret" then
        armorPenPercent = 0.7
    end

    -- turrets ignore armor penetration and critical attacks
    if target.type == "obj_AI_Turret" then
        armorPenPercent = 1
        armorPen = 0
        damageMultiplier = 1
    end

    -- calculate initial damage multiplier for negative and positive armor

    local targetArmor = (target.armor * armorPenPercent) - armorPen
    if targetArmor < 0 then -- minions can't go below 0 armor.
        --damageMultiplier = (2 - 100 / (100 - targetArmor)) * damageMultiplier
        damageMultiplier = 1 * damageMultiplier
    else
        damageMultiplier = 100 / (100 + targetArmor) * damageMultiplier
    end

    -- use ability power or ad based damage on turrets
    if source.type == myHero.type and target.type == "obj_AI_Turret" then
        totalDamage = math.max(source.totalDamage, source.damage + 0.4 * source.ap)
    end

    -- minions deal less damage to enemy heros
    if source.type == "obj_AI_Minion" and target.type == myHero.type and source.team ~= TEAM_NEUTRAL then
        damageMultiplier = 0.60 * damageMultiplier
    end

    -- heros deal less damage to turrets
    if source.type == myHero.type and target.type == "obj_AI_Turret" then
        damageMultiplier = 0.95 * damageMultiplier
    end

    -- minions deal less damage to turrets
    if source.type == "obj_AI_Minion" and target.type == "obj_AI_Turret" then
        damageMultiplier = 0.475 * damageMultiplier
    end

    -- siege minions and superminions take less damage from turrets
    if source.type == "obj_AI_Turret" and (target.charName == "Red_Minion_MechCannon" or target.charName == "Blue_Minion_MechCannon") then
        damageMultiplier = 0.8 * damageMultiplier
    end

    -- caster minions and basic minions take more damage from turrets
    if source.type == "obj_AI_Turret" and (target.charName == "Red_Minion_Wizard" or target.charName == "Blue_Minion_Wizard" or target.charName == "Red_Minion_Basic" or target.charName == "Blue_Minion_Basic") then
        damageMultiplier = (1 / 0.875) * damageMultiplier
    end

    -- turrets deal more damage to all units by default
    if source.type == "obj_AI_Turret" then
        damageMultiplier = 1.05 * damageMultiplier
    end

    -- calculate damage dealt
    local dmg = damageMultiplier * totalDamage
    return dmg
end

function S1mpleOrbWalker:spriteloader()
	if not MakeSurePathExists(SPRITE_PATH.."\\S1mple") then
		CreateDirectory(SPRITE_PATH.."\\S1mple")
	end
	if not MakeSurePathExists(SPRITE_PATH.."\\S1mple\\OrbWalker") then
		CreateDirectory(SPRITE_PATH.."\\S1mple\\OrbWalker")
	end
	if not self.DL then self.DL = Download() end
	local todl = {}

	if FileExist(SPRITE_PATH.."\\S1mple\\OrbWalker\\crosshair_r.png") then
		self.crosshair_red = GetSprite("\\S1mple\\OrbWalker\\crosshair_r.png")

	else
		todl[#todl+1] = "crosshair_r.png"
	end
	if FileExist(SPRITE_PATH.."\\S1mple\\OrbWalker\\crosshair_g.png") then
		self.crosshair_green = GetSprite("\\S1mple\\OrbWalker\\crosshair_g.png")
	else
		todl[#todl+1] = "crosshair_g.png"
	end
	if FileExist(SPRITE_PATH.."\\S1mple\\OrbWalker\\crosshair_y.png") then
		self.crosshair_yellow = GetSprite("\\S1mple\\OrbWalker\\crosshair_y.png")
	else
		todl[#todl+1] = "crosshair_y.png"
	end

	local n = #todl
	if #todl > 0 then
		self:print("Downloading "..tostring(#todl).." new Sprites")
		for _,v in pairs(todl) do
			self.DL:newDL("www.s1mplescripts.de", "/S1mple/Scripts/BolStudio/OrbWalker/Sprites/"..v,v,SPRITE_PATH.."S1mple\\OrbWalker\\", function ()
				n = n-1
				if n == 0 then
					self.crosshair_red = nil
					self.crosshair_green = nil
					self.crosshair_yellow = nil
					todl = {}
					DelayAction(function ()
						self:print("Download Finished, please reload the script")
					end,1)
				end
			end)
		end
	end
end

function S1mpleOrbWalker:update()
	--if GetGameTimer() > 120 then self:print("Game is already progressing, skipping Auto Update") return end

	local UpdateHost = "www.s1mplescripts.de"
	local ServerPath = "/S1mple/Scripts/BolStudio/OrbWalker/"
	local ServerFileName = "S1mpleOrbWalker.lua"
	local ServerVersionFileName = "S1mpleOrbWalker.version"

	if not self.DL then self.DL = Download() end
	local ServerVersionDATA = GetWebResult("s1mplescripts.de" , ServerPath..ServerVersionFileName)
	if ServerVersionDATA then
		local ServerVersion = tonumber(ServerVersionDATA)
		if ServerVersion then
			if ServerVersion > tonumber(self.version) then
				self:print("Updating, don't press F9")
				self.DL:newDL(UpdateHost, ServerPath..ServerFileName, ServerFileName, LIB_PATH, function ()
					self:print("S1mpleOrbWalker updated, please reload")
				end)
			end
		else
			self:print("An error occured, while updating, please reload")
		end
	else
		self:print("Could not connect to update Server")
	end
end

function S1mpleOrbWalker:print(arg)
	print('<font color=\"#515151\">S1mpleOrbWalker</font><font color=\"#000000\"> - </font><font color=\"#cccccc\">'..arg..'</font>')
end

function S1mpleOrbWalker:GetLatency()
	if not self.menu.adv.latencytoggle then
		return GetLatency()
	else
		return self.menu.adv.latency
	end
end

function S1mpleOrbWalker:getMPS()
	return math.random(self.menu.human.mpsmin, self.menu.human.mpsmax)
end

class("TargetSelector")
function TargetSelector:__init()

	self.enemyHeroes = GetEnemyHeroes()

	self.AllyForces = {}
	for _,v in pairs(GetAllyHeroes()) do
		self.AllyForces[#self.AllyForces+1] = v
	end
	self.Minions = {}
	self.JungleMinions = {}
	self.Structures = {}

	--On Reload
	for i = 1, objManager.maxObjects do
		local object = objManager:getObject(i)
		if object and object.valid and object.type and object.type == "obj_AI_Minion" then
			if object.team ~= myHero.team then
				if object.charName:find("Minion") then
					self.Minions[#self.Minions+1] = object
				else
					self.JungleMinions[#self.JungleMinions+1] = object
				end
			else
				if object.charName:find("Minion") then
					self.AllyForces[#self.AllyForces+1] = object 
				end
			end
		elseif object and object.valid and object.health and object.health > 1 and (object.type == "obj_AI_Turret" or object.type == "obj_HQ" or object.type == "obj_BarracksDampener") and object.team ~= myHero.team then
			self.Structures[#self.Structures+1] = object
		end
	end

	AddCreateObjCallback(function (object)
		if object and object.valid and object.type and object.type == "obj_AI_Minion" then
			if object.team ~= myHero.team then
				if object.charName:find("Minion") then
					self.Minions[#self.Minions+1] = object
				else
					self.JungleMinions[#self.JungleMinions+1] = object
				end
			else
				if object.charName:find("Minion") then
					self.AllyForces[#self.AllyForces+1] = object 
				end
			end
		elseif object and object.valid and object.health and object.health > 1 and (object.type == "obj_AI_Turret" or object.type == "obj_HQ" or object.type == "obj_BarracksDampener") and object.team ~= myHero.team then
			self.Structures[#self.Structures+1] = object
		end
	end)

	AddDeleteObjCallback(function (object)
		local a = {}
		for _,v in pairs(GetAllyHeroes()) do
			a[#a+1] = v
		end
		local m = {}
		local j = {}
		local s = {}
		for _, v in pairs(self.AllyForces) do
			if v.networkID ~= object.networkID then
				a[#a+1] = v
			end
		end
		for _, v in pairs(self.Minions) do
			if v.networkID ~= object.networkID then
				m[#m+1] = v
			end
		end
		for _, v in pairs(self.JungleMinions) do
			if v.networkID ~= object.networkID then
				j[#j+1] = v
			end
		end
		for _, v in pairs(self.Structures) do
			if v.networkID ~= object.networkID then
				s[#s+1] = v
			end
		end
		self.AllyForces = a
		self.Minions = m
		self.JungleMinions = j
		self.Structures = s
	end)
end

function TargetSelector:IsUnderTower(target,range)
	local tower = nil
	for _,v in pairs(GetTurrets()) do
		if v and v.team ~= myHero.team then
			if GetDistance(v,target) < range then
				tower = v
			end
		end
	end
	return tower
end

function TargetSelector:FriendlyUnderTower(tower)
	for _,v in pairs(self.AllyForces) do
		if v and not v.dead and v.health > 1 and GetDistance(v,tower) < 800 and not v.isMe then
			local turret = self:IsUnderTower(v,800)
			if turret and tower.networkID == turret.networkID then
				return true
			end
		end
	end
end

function TargetSelector:IsDangerZone(position)
	local turret = self:IsUnderTower(position,1025)
	if turret and GetDistance(turret,myHero) < 1025 then
		if self:FriendlyUnderTower(turret) then
			return false
		else
			return true
		end
		return true
	end
	return false
end

function TargetSelector:GetEnemyHero(range)
	local t = nil
	for _, v in pairs(self.enemyHeroes) do
		if v and ValidTarget(v) and GetDistance(v) < range+v.boundingRadius then
			if t and v.health < t.health then
				t = v
			elseif not t then
				t = v
			end
		end
	end
	return t
end

function TargetSelector:GetEnemyMinion(range)
	local t = nil
	for _, v in pairs(self.Minions) do
		if v and ValidTarget(v) and GetDistance(v) < range+v.boundingRadius then
			if t and v.health < t.health then
				t = v
			elseif not t then
				t = v
			end
		end
	end
	return t
end

function TargetSelector:GetAllEnemyMinions(range)
	local n = {}
	for _, v in pairs(self.Minions) do
		if GetDistance(v) < range+v.boundingRadius then
			n[#n+1] = v
		end
	end	
	return n
end

function TargetSelector:GetJungleMinion(range)
	local t = nil
	for _, v in pairs(self.JungleMinions) do
		if v and ValidTarget(v) and GetDistance(v) < range+v.boundingRadius then
			if t and v.health < t.health then
				t = v
			elseif not t then
				t = v
			end
		end
	end
	return t
end

function TargetSelector:GetStructurTarget(range)
	for _, v in pairs(self.Structures) do
		if v and v.valid and v.health > 0 and GetDistance(v) < range+v.boundingRadius and v.bTargetable and v.bInvulnerable == 0 then
			return v
		end
	end
end

function TargetSelector:GetAllTargets(range)
	local n = {}
	n = self:GetAllEnemyMinions(range)
	for _,v in pairs(self.JungleMinions) do
		if v and v.valid and ValidTarget(v) and GetDistance(v) < range+v.boundingRadius then
			n[#n+1] = v
		end
	end

	for _,v in pairs(self.Structures) do
		if v and v.valid and v.health > 0 and GetDistance(v) < range+v.boundingRadius and v.bTargetable and v.bInvulnerable == 0 then
			n[#n+1] = v
		end
	end

	return n
end

function GetDistanceSqr(p1, p2)
    assert(p1, "GetDistance: invalid argument: cannot calculate distance to "..type(p1))
    p2 = p2 or player
    return (p1.x - p2.x) ^ 2 + ((p1.z or p1.y) - (p2.z or p2.y)) ^ 2
end

function GetDistance(p1, p2)
    return math.sqrt(GetDistanceSqr(p1, p2))
end

class "Download"
function Download:__init()
	socket = require("socket")
	self.aktivedownloads = {}
	self.callbacks = {}

	AddTickCallback(function ()
		self:RemoveDone()
	end)

	class("Async")
	function Async:__init(host, filepath, localname, drawoffset, localpath)
		self.progress = 0
		self.host = host
		self.filepath = filepath
		self.localname = localname
		self.offset = drawoffset
		self.localpath = localpath
		self.CRLF = '\r\n'

		self.headsocket = socket.tcp()
		self.headsocket:settimeout(1)
		self.headsocket:connect(self.host, 80)
		self.headsocket:send('HEAD '..self.filepath..' HTTP/1.1'.. self.CRLF ..'Host: '..self.host.. self.CRLF ..'User-Agent: Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36'.. self.CRLF .. self.CRLF)

		self.HEADdata = ""
		self.DLdata = ""
		self.StartedDownload = false
		self.canDL = true

		AddTickCallback(function ()
			self:tick()
		end)
		AddDrawCallback(function ()
			self:draw()
		end)
	end

	function Async:tick()
		if self.progress == 100 then return end
		if self.HEADcStatus ~= "timeout" and self.HEADcStatus ~= "closed" then
			self.HEADfString, self.HEADcStatus, self.HEADpString = self.headsocket:receive(16);
			if self.HEADfString then
				self.HEADdata = self.HEADdata..self.HEADfString
			elseif self.HEADpString and #self.HEADpString > 0 then
				self.HEADdata = self.HEADdata..self.HEADpString
			end
		elseif self.HEADcStatus == "timeout" then
			self.headsocket:close()
			--Find Lenght
			local begin = string.find(self.HEADdata, "Length: ")
			if begin then
				self.HEADdata = string.sub(self.HEADdata,begin+8)
				local n = 0
				local _break = false
				for i=1, #self.HEADdata do
					local c = tonumber(string.sub(self.HEADdata,i,i))
					if c and _break == false then
						n = n+1
					else
						_break = true
					end
				end
				self.HEADdata = string.sub(self.HEADdata,1,n)
				self.StartedDownload = true
				self.HEADcStatus = "closed"
			end
		end
		if self.HEADcStatus == "closed" and self.StartedDownload == true and self.canDL == true then --Double Check
			self.canDL = false
			self.DLsocket = socket.tcp()
			self.DLsocket:settimeout(1)
			self.DLsocket:connect(self.host, 80)
			--Start Main Download
			self.DLsocket:send('GET '..self.filepath..' HTTP/1.1'.. self.CRLF ..'Host: '..self.host.. self.CRLF ..'User-Agent: Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36'.. self.CRLF .. self.CRLF)
		end
		
		if self.DLsocket and self.DLcStatus ~= "timeout" and self.DLcStatus ~= "closed" then
			self.DLfString, self.DLcStatus, self.DLpString = self.DLsocket:receive(1024);
			
			if ((self.DLfString) or (self.DLpString and #self.DLpString > 0)) then
				self.DLdata = self.DLdata .. (self.DLfString or self.DLpString)
			end

		elseif self.DLcStatus and self.DLcStatus == "timeout" then
			self.DLsocket:close()
			self.DLcStatus = "closed"
			self.DLdata = string.sub(self.DLdata,#self.DLdata-tonumber(self.HEADdata)+1)

			local file = io.open(self.localpath.."\\"..self.localname, "w+b")
			file:write(self.DLdata)
			file:close()
			self.progress = 100
		end

		if self.progress ~= 100 and self.DLdata and #self.DLdata > 0 then
			self.progress = (#self.DLdata/tonumber(self.HEADdata))*100
		end
	end

	function Async:draw()
		if self.progress < 100 then
			DrawTextA("Downloading: "..self.localname,15,50,35+self.offset)
			DrawRectangleOutline(49,50+self.offset,250,20, ARGB(255,255,255,255),1)
			if self.progress ~= 100 then
				DrawLine(50,60+self.offset,50+(2.5*self.progress),60+self.offset,18,ARGB(150,255-self.progress*2.5,self.progress*2.5,255-self.progress*2.5))
				DrawTextA(tostring(math.round(self.progress).." %"), 15,150,52+self.offset)
			end
		end
	end

end

function Download:newDL(host, file, name, path, callback)
	local offset = (#self.aktivedownloads+1)*40
	self.aktivedownloads[#self.aktivedownloads+1] = Async(host, file, name, offset-40, path)
	if not callback then
		callback = (function ()
		end)
	end

	self.callbacks[#self.callbacks+1] = callback

end

function Download:RemoveDone()
	if #self.aktivedownloads == 0 then return end
	local x = {}
	for k, v in pairs(self.aktivedownloads) do
		if math.round(v.progress) < 100 then
			v.offset = k*40-40
			x[#x+1] = v
		else
			self.callbacks[k]()
		end
	end
	self.aktivedownloads = {}
	self.aktivedownloads = x
end