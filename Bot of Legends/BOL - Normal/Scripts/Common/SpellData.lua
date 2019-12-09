return {
	["Aatrox"] = {
		[_Q] = { name = "AatroxQ", speed = 450, delay = 0.25, range = 650, width = 150, collision = false, aoe = true, type = "circular"},
		[_E] = { name = "AatroxE", speed = 1200, delay = 0.25, range = 1000, width = 150, collision = false, aoe = false, type = "linear"}
	},
	["Ahri"] = {
		[_Q] = { name = "AhriOrbofDeception", speed = 2500, delay = 0.25, range = 975, width = 100, collision = false, aoe = false, type = "linear", dmgAP = function(source, target) return 15+25*source:GetSpellData(_Q).level+0.35*source.ap end},
		[_W] = { name = "AhriFoxFire", range = 700, dmgAP = function(source, target) return 15+25*source:GetSpellData(_W).level+0.4*source.ap end},
		[_E] = { name = "AhriSeduce", speed = 1550, delay = 0.25, range = 1075, width = 65, collision = true, aoe = false, type = "linear", dmgAP = function(source, target) return 25+35*source:GetSpellData(_E).level+0.5*source.ap end},
		[_R] = { name = "AhriTumble", range = 450, dmgAP = function(source, target) return 40*source:GetSpellData(_R).level+30+0.3*source.ap end}
	},
	["Akali"] = {
		[_E] = { name = "", speed = math.huge, delay = 0.125, range = 0, width = 325, collision = false, aoe = true, type = "circular"}
	},
	["Alistar"] = {
		[_Q] = { name = "", speed = math.huge, delay = 0.25, range = 0, width = 365, collision = false, aoe = true, type = "circular"}
	},
	["Amumu"] = {
		[_Q] = { name = "BandageToss", speed = 725, delay = 0.25, range = 1000, width = 100, collision = true, aoe = false, type = "linear"}
	},
	["Anivia"] = {
		[_Q] = { name = "FlashFrostSpell", speed = 850, delay = 0.250, range = 1200, width = 110, collision = false, aoe = false, type = "linear"},
		[_R] = { name = "", speed = math.huge, delay = 0.100, range = 615, width = 350, collision = false, aoe = true, type = "circular"}
	},
	["Annie"] = {
		[_Q] = { name = "Disintegrate" },
		[_W] = { name = "Incinerate", speed = math.huge, delay = 0.25, range = 625, width = 250, collision = false, aoe = true, type = "cone"},
		[_E] = { name = "MoltenShield" },
		[_R] = { name = "InfernalGuardian", speed = math.huge, delay = 0.25, range = 600, width = 300, collision = false, aoe = true, type = "circular"}
	},
	["Ashe"] = {
		[_Q] = { range = 700, dmgAD = function(source, target) return (0.05*source:GetSpellData(_Q).level+1.1)*source.totalDamage end},
		[_W] = { name = "Volley", speed = 902, delay = 0.25, range = 1200, width = 100, collision = true, aoe = false, type = "cone", dmgAD = function(source, target) return 10*source:GetSpellData(_W).level+30+source.totalDamage end},
		[_E] = { speed = 1500, delay = 0.5, range = 25000, width = 1400, collision = false, aoe = false, type = "linear"},
		[_R] = { name = "EnchantedCrystalArrow", speed = 1600, delay = 0.5, range = 25000, width = 100, collision = true, aoe = false, type = "linear", dmgAP = function(source, target) return 175*source:GetSpellData(_R).level+75+source.ap end}
	},
	["Azir"] = {
		[_Q] = { name = "AzirQ", speed = 2500, delay = 0.250, range = 880, width = 100, collision = false, aoe = false, type = "linear", dmgAP = function(source, target) return 15+25*source:GetSpellData(_Q).level+0.35*source.ap end},
		[_W] = { name = "AzirW", range = 520, dmgAP = function(source, target) return 15+25*source:GetSpellData(_W).level+0.4*source.ap end},
		[_E] = { name = "AzirE", range = 1100, delay = 0.25, speed = 1200, width = 60, collision = true, aoe = false, type = "linear", dmgAP = function(source, target) return 25+35*source:GetSpellData(_E).level+0.5*source.ap end},
		[_R] = { name = "AzirR", speed = 1300, delay = 0.2, range = 520, width = 600, collision = false, aoe = true, type = "linear", dmgAP = function(source, target) return 40*source:GetSpellData(_R).level+30+0.3*source.ap end}
	},
	["Bard"] = {
		[_Q] = { name = "", speed = 1100, delay = 0.25, range = 850, width = 108, collision = true, aoe = false, type = "linear"}
	},
	["Blitzcrank"] = {
		[_Q] = { name = "RocketGrabMissile", speed = 1800, delay = 0.250, range = 900, width = 70, collision = true, type = "linear", dmgAP = function(source, target) return 55*source:GetSpellData(_Q).level+25+source.ap end},
		[_W] = { name = "", range = 2500},
		[_E] = { name = "", range = 225, dmgAD = function(source, target) return 2*source.totalDamage end},
		[_R] = { name = "StaticField", speed = math.huge, delay = 0.25, range = 0, width = 500, collision = false, aoe = false, type = "circular", dmgAP = function(source, target) return 125*source:GetSpellData(_R).level+125+source.ap end}
	},
	["Brand"] = {
		[_Q] = { name = "BrandBlaze", speed = 1200, delay = 0.25, range = 1050, width = 80, collision = false, aoe = false, type = "linear", dmgAP = function(source, target) return 40*source:GetSpellData(_Q).level+40+0.65*source.ap end},
		[_W] = { name = "BrandFissure", speed = math.huge, delay = 0.625, range = 1050, width = 275, collision = false, aoe = false, type = "circular", dmgAP = function(source, target) return 45*source:GetSpellData(_W).level+30+0.6*source.ap end},
		[_E] = { name = "", range = 625, dmgAP = function(source, target) return 25*source:GetSpellData(_E).level+30+0.55*source.ap end},
		[_R] = { name = "BrandWildfire", range = 750, dmgAP = function(source, target) return 100*source:GetSpellData(_R).level+50+0.5*source.ap end}
	},
	["Braum"] = {
		[_Q] = { name = "BraumQ", speed = 1600, delay = 0.25, range = 1000, width = 100, collision = false, aoe = false, type = "linear"},
		[_R] = { name = "BraumR", speed = 1250, delay = 0.5, range = 1250, width = 0, collision = false, aoe = false, type = "linear"}
	},
	["Caitlyn"] = {
		[_Q] = { name = "CaitlynPiltoverPeacemaker", speed = 2200, delay = 0.625, range = 1300, width = 0, collision = false, aoe = false, type = "linear"},
		[_E] = { name = "CaitlynEntrapment", speed = 2000, delay = 0.400, range = 1000, width = 80, collision = false, aoe = false, type = "linear"},
		[_R] = { name = "CaitlynAceintheHole" }
	},
	["Cassiopeia"] = {
		[_Q] = { name = "CassiopeiaNoxiousBlast", speed = math.huge, delay = 0.75, range = 850, width = 100, collision = false, aoe = true, type = "circular", dmgAP = function(source, target) return 45+30*source:GetSpellData(_Q).level+0.45*source.ap end},
		[_W] = { name = "CassiopeiaMiasma", speed = 2500, delay = 0.5, range = 925, width = 90, collision = false, aoe = true, type = "circular", dmgAP = function(source, target) return 5+5*source:GetSpellData(_W).level+0.1*source.ap end},
		[_E] = { name = "CassiopeiaTwinFang", range = 700, dmgAP = function(source, target) return 30+25*source:GetSpellData(_E).level+0.55*source.ap end },
		[_R] = { name = "CassiopeiaPetrifyingGaze", speed = math.huge, delay = 0.5, range = 825, width = 410, collision = false, aoe = true, type = "cone", dmgAP = function(source, target) return 50+10*source:GetSpellData(_R).level+0.5*source.ap end}
	},
	["Chogath"] = {
		[_Q] = { name = "Rupture", speed = math.huge, delay = 0.25, range = 950, width = 300, collision = false, aoe = true, type = "circular"},
		[_W] = { name = "", speed = math.huge, delay = 0.5, range = 650, width = 275, collision = false, aoe = false, type = "linear"},
	},
	["Corki"] = {
		[_Q] = { name = "", speed = 700, delay = 0.4, range = 825, width = 250, collision = false, aoe = false, type = "circular"},
		[_R] = { name = "MissileBarrage", speed = 2000, delay = 0.200, range = 1225, width = 60, collision = false, aoe = false, type = "linear"},
	},
	["Darius"] = {
		[_Q] = { name = "", speed = math.huge, delay = 0.75, range = 450, width = 450, type = "circular", dmgAD = function(source, target) return 20*source:GetSpellData(_Q).level+(0.9 + 0.1 * source:GetSpellData(_Q).level)*source.totalDamage end},
		[_W] = { name = "", range = 275, dmgAD = function(source, target) return source.totalDamage*1.4 end},
		[_E] = { name = "", speed = math.huge, delay = 0.32, range = 570, width = 125, collision = false, aoe = true, type = "cone"},
		[_R] = { name = "", range = 460, dmgTRUE = function(source, target, stacks) return math.floor(99*source:GetSpellData(_R).level+0.749*source.addDamage+stacks*(19*source:GetSpellData(_R).level+0.149*source.addDamage)) end}
	},
	["Diana"] = {
		[_Q] = { name = "DianaArc", speed = 1500, delay = 0.250, range = 835, width = 130, collision = false, aoe = false, type = "circular", dmgAP = function(source, target) return 35*source:GetSpellData(_Q).level+45+0.2*source.ap end},
		[_W] = { name = "", range = 250, dmgAP = function(source, target) return 12*source:GetSpellData(_W).level+10+0.2*source.ap end },
		[_E] = { name = "DianaVortex", speed = math.huge, delay = 0.33, range = 0, width = 395, collision = false, aoe = false, type = "circular" },
		[_R] = { name = "", range = 825, dmgAP = function(source, target) return 60*source:GetSpellData(_R).level+40+0.6*source.ap end }
	},
	["DrMundo"] = {
		[_Q] = { name = "InfectedCleaverMissile", speed = 2000, delay = 0.250, range = 1050, width = 75, collision = true, aoe = false, type = "linear"}
	},
	["Draven"] = {
		[_E] = { name = "DravenDoubleShot", speed = 1400, delay = 0.250, range = 1100, width = 130, collision = false, aoe = false, type = "linear"},
		[_R] = { name = "DravenRCast", speed = 2000, delay = 0.5, range = 25000, width = 160, collision = false, aoe = false, type = "linear"}
	},
	["Ekko"] = {
		[_Q] = { name = "", speed = 1050, delay = 0.25, range = 925, width = 140, collision = false, aoe = false, type = "linear", dmgAP = function(source, target) return 15*source:GetSpellData(_Q).level+45+0.1*source.ap end},
		[_W] = { name = "", speed = math.huge, delay = 2.5, range = 1600, width = 450, collision = false, aoe = true, type = "circular"},
		[_E] = { name = "", delay = 0.50, range = 350, dmgAP = function(source, target) return 30*source:GetSpellData(_E).level+20+0.2*source.ap+source.totalDamage end},
		[_R] = { name = "", speed = math.huge, delay = 0.5, range = 0, width = 400, collision = false, aoe = true, type = "circular", dmgAP = function(source, target) return 150*source:GetSpellData(_R).level+50+1.3*source.ap end}
	},
	["Elise"] = {
		[_E] = { name = "EliseHumanE", speed = 1450, delay = 0.250, range = 975, width = 70, collision = true, aoe = false, type = "linear"}
	},
	["Evelynn"] = {
		[_Q] = { name = "", speed = 1300, delay = 0.250, range = 650, width = 350, collision = false, aoe = true, type = "circular" }
	},
	["Ezreal"] = {
		[_Q] = { name = "EzrealMysticShot", speed = 2000, delay = 0.25, range = 1200, width = 65, collision = true, aoe = false, type = "linear", dmgAD = function(source, target) return 20*source:GetSpellData(_Q).level+15+source.totalDamage+0.4*source.ap end},
		[_W] = { name = "EzrealEssenceFlux", speed = 1200, delay = 0.25, range = 900, width = 90, collision = false, aoe = false, type = "linear", dmgAP = function(source, target) return 45*source:GetSpellData(_W).level+25+0.8*source.ap end},
		[_E] = { name = "", range = 450, dmgAP = function(source, target) return 50*source:GetSpellData(_R).level+25+0.5*source.addDamage+0.75*source.ap end},
		[_R] = { name = "EzrealTrueshotBarrage", speed = 2000, delay = 1, range = 25000, width = 180, collision = false, aoe = false, type = "linear", dmgAP = function(source, target) return 150*source:GetSpellData(_R).level+200+source.addDamage+0.9*source.ap end}
	},
	["Fiddlesticks"] = {
	},
	["Fiora"] = {
	},
	["Fizz"] = {
		[_R] = { name = "FizzMarinerDoom", speed = 1350, delay = 0.250, range = 1150, width = 100, collision = false, aoe = false, type = "linear"}
	},
	["Galio"] = {
		[_Q] = { name = "GalioResoluteSmite", speed = 1300, delay = 0.25, range = 900, width = 250, collision = false, aoe = true, type = "circular"},
		[_E] = { name = "", speed = 1200, delay = 0.25, range = 1000, width = 200, collision = false, aoe = false, type = "linear"}
	},
	["Gangplank"] = {
		[_Q] = { name = "GangplankQWrapper", range = 900},
		[_E] = { name = "", speed = math.huge, delay = 0.25, range = 900, width = 250, collision = false, aoe = true, type = "circular"},
		[_R] = { name = "", speed = math.huge, delay = 0.25, range = 25000, width = 575, collision = false, aoe = true, type = "circular"}
	},
	["Garen"] = {
	},
	["Gnar"] = {
		[_Q] = { name = "", speed = 1225, delay = 0.125, range = 1200, width = 80, collision = true, aoe = false, type = "linear"}
	},
	["Gragas"] = {
		[_Q] = { name = "GragasQ", speed = 1000, delay = 0.250, range = 1000, width = 300, collision = false, aoe = true, type = "circular"},
		[_E] = { name = "GragasE", speed = math.huge, delay = 0.250, range = 600, width = 50, collision = true, aoe = true, type = "circular"},
		[_R] = { name = "GragasR", speed = 1000, delay = 0.250, range = 1050, width = 400, collision = false, aoe = true, type = "circular"}
	},
	["Graves"] = {
		[_Q] = { name = "", speed = 1950, delay = 0.265, range = 750, width = 85, collision = false, aoe = false, type = "cone"},
		[_W] = { name = "", speed = 1650, delay = 0.300, range = 700, width = 250, collision = false, aoe = true, type = "circular"},
		[_R] = { name = "", speed = 2100, delay = 0.219, range = 1000, width = 100, collision = false, aoe = false, type = "linear"}
	},
	["Hecarim"] = {
		[_Q] = { name = "", speed = math.huge, delay = 0.250, range = 0, width = 350, collision = false, aoe = true, type = "circular"},
		[_R] = { name = "", speed = 1900, delay = 0.219, range = 1000, width = 200, collision = false, aoe = false, type = "linear"}
	},
	["Heimerdinger"] = {
		[_W] = { name = "", speed = 900, delay = 0.500, range = 1325, width = 100, collision = true, aoe = false, type = "linear"},
		[_E] = { name = "", speed = 2500, delay = 0.250, range = 970, width = 180, collision = false, aoe = true, type = "circular"}
	},
	["Irelia"] = {
		[_R] = { name = "", speed = 1700, delay = 0.250, range = 1200, width = 25, collision = false, aoe = false, type = "linear"}
	},
	["Janna"] = {
		[_Q] = { name = "HowlingGale", speed = 1500, delay = 0.250, range = 1700, width = 150, collision = false, aoe = false, type = "linear"}
	},
	["JarvanIV"] = {
		[_Q] = { name = "", speed = 1400, delay = 0.25, range = 770, width = 70, collision = false, aoe = false, type = "linear"},
		[_E] = { name = "", speed = 1450, delay = 0.25, range = 850, width = 175, collision = false, aoe = false, type = "linear"}
	},
	["Jax"] = {
		[_E] = { name = "", speed = math.huge, delay = 0.250, range = 0, width = 375, collision = false, aoe = true, type = "circular"}
	},
	["Jayce"] = {
		[_Q] = { name = "jayceshockblast", speed = 2350, delay = 0.15, range = 1750, width = 70, collision = true, aoe = false, type = "linear"}
	},
	["Jinx"] = {
		[_W] = { name = "JinxWMissile", speed = 3000, delay = 0.600, range = 1400, width = 60, collision = true, aoe = false, type = "linear"},
		[_E] = { name = "JinxE", speed = 887, delay = 0.500, range = 830, width = 0, collision = false, aoe = true, type = "circular"},
		[_R] = { name = "JinxR", speed = 1700, delay = 0.600, range = 20000, width = 120, collision = false, aoe = true, type = "circular"}
	},
	["Kalista"] = {
		[_Q] = { name = "KalistaMysticShot", speed = 1700, delay = 0.25, range = 1150, width = 40, collision = true, aoe = false, type = "linear", dmgAD = function(source, target) return 0-50+60*source:GetSpellData(_Q).level+source.totalDamage end},
		[_W] = { name = "", delay = 1.5, range = 5000},
		[_E] = { name = "", range = 1000, dmgAD = function(source, target, stacks) return stacks > 0 and (10 + (10 * source:GetSpellData(_E).level) + (source.totalDamage * 0.6)) + (stacks-1) * (({10, 14, 19, 25, 32})[source:GetSpellData(_E).level] + (0.175 + 0.025 * source:GetSpellData(_E).level)*source.totalDamage) or 0 end},
		[_R] = { name = "", range = 2000}
	},
	["Karma"] = {
		[_Q] = { name = "KarmaQ", speed = 1700, delay = 0.250, range = 950, width = 90, collision = true, aoe = false, type = "linear"}
	},
	["Karthus"] = {
		[_Q] = { name = "KarthusLayWaste", speed = math.huge, delay = 0.65, range = 875, width = 190*2, collision = false, aoe = false, type = "circular", dmgAP = function(source, target) local m=minionManager(MINION_JUNGLE, 190, target, MINION_SORT_HEALTH_ASC); return (#m.objects == 0 and 2 or 1) * (20+20*source:GetSpellData(_Q).level+0.3*source.ap) end},
		[_W] = { name = "KarthusWallOfPain", speed = math.huge, delay = 0.25, range = 1000, width = 160, collision = false, aoe = true, type = "circular"},
		[_E] = { name = "KarthusDefile", speed = math.huge, delay = 0.25, range = 550, width = 550, collision = false, aoe = true, type = "circular", dmgAP = function(source, target) return 10+20*source:GetSpellData(_Q).level+0.2*source.ap end},
		[_R] = { name = "KarthusFallenOne", range = math.huge, dmgAP = function(source, target) return 100+150*source:GetSpellData(_Q).level+0.60*source.ap end}
	},
	["Kassadin"] = {
		[_Q] = { name = "", range = 650, dmgAP = function(source, target) return 35+25*source:GetSpellData(_Q).level+0.7*source.ap end},
		[_W] = { name = "", range = 150+myHero.boundingRadius, dmgAP = function(source, target) return 15+25*source:GetSpellData(_W).level+0.6*source.ap end},
		[_E] = { name = "", speed = 2200, delay = 0.25, range = 650, width = 80, collision = false, aoe = false, type = "cone", dmgAP = function(source, target) return 45+25*source:GetSpellData(_E).level+0.7*source.ap end},
		[_R] = { name = "", speed = math.huge, delay = 0.5, range = 500, width = 150, collision = false, aoe = true, type = "circular", dmgAP = function(source, target, stacks) return (1+stacks/2)*(60+20*source:GetSpellData(_E).level+0.02*source.maxMana) end}
	},
	["Katarina"] = {
		[_Q] = { name = "", range = 675, dmgAP = function(source, target) return 35+25*source:GetSpellData(_Q).level+0.45*source.ap end},
		[_W] = { name = "", range = 375, dmgAP = function(source, target) return 5+35*source:GetSpellData(_W).level+0.25*source.ap+0.6*source.addDamage end},
		[_E] = { name = "", range = 700, dmgAP = function(source, target) return 10+30*source:GetSpellData(_E).level+0.25*source.ap end},
		[_R] = { name = "", range = 550, dmgAP = function(source, target) return 15+20*source:GetSpellData(_R).level+0.25*source.ap+0.375*source.addDamage end}
	},
	["Kayle"] = {
        [_Q] = { name = "JudicatorReckoning" },
        [_W] = { name = "JudicatorDivineBlessing" },
        [_E] = { name = "JudicatorRighteosFury" },
        [_R] = { name = "JudicatorIntervention" }
	},
	["Kennen"] = {
		[_Q] = { name = "KennenShurikenHurlMissile1", speed = 1700, delay = 0.180, range = 1050, width = 70, collision = true, aoe = false, type = "linear"}
	},
	["KhaZix"] = {
		[_W] = { name = "KhazixW", speed = 1700, delay = 0.25, range = 1025, width = 70, collision = true, aoe = false, type = "linear"},
		[_E] = { name = "", speed = 400, delay = 0.25, range = 600, width = 325, collision = false, aoe = true, type = "circular"}
	},
	["KogMaw"] = {
		[_Q] = { range = 975, delay = 0.25, speed = 1600, width = 80, type = "linear", dmgAP = function(source, target) return 30+50*source:GetSpellData(_Q).level+0.5*source.ap end},
        [_W] = { range = function() return myHero.range + myHero.boundingRadius*2 + 110+20*myHero:GetSpellData(_W).level end, dmgAP = function(source, target) return target.maxHealth*0.01*(source:GetSpellData(_W).level+1)+0.01*source.ap+source.totalDamage end},
		[_E] = { name = "", speed = 1200, delay = 0.25, range = 1200, width = 120, collision = false, aoe = false, type = "linear", dmgAP = function(source, target) return 10+50*source:GetSpellData(_E).level+0.7*source.ap end},
		[_R] = { name = "KogMawLivingArtillery", speed = math.huge, delay = 1.1, range = 2200, width = 250, collision = false, aoe = true, type = "circular", dmgAP = function(source, target) return 40+40*source:GetSpellData(_R).level+0.3*source.ap+0.5*source.totalDamage end}
	},
	["LeBlanc"] = {
		[_Q] = { range = 700, dmgAP = function(source, target) return 30+25*source:GetSpellData(_Q).level+0.4*source.ap end},
		[_W] = { name = "LeblancDistortion", speed = 1300, delay = 0.250, range = 600, width = 250, collision = false, aoe = false, type = "circular", dmgAP = function(source, target) return 45+40*source:GetSpellData(_W).level+0.6*source.ap end},
		[_E] = { name = "LeblancSoulShackle", speed = 1300, delay = 0.250, range = 950, width = 55, collision = true, aoe = false, type = "linear", dmgAP = function(source, target) return 15+25*source:GetSpellData(_E).level+0.5*source.ap end},
        [_R] = { range = 0}
	},
	["LeeSin"] = {
		[_Q] = { name = "BlindMonkQOne", speed = 1750, delay = 0.25, range = 1000, width = 70, collision = true, aoe = false, type = "linear", dmgAD = function(source, target) return 20+30*source:GetSpellData(_Q).level+0.9*source.addDamage end},
        [_W] = { name = "", range = 600},
		[_E] = { name = "BlindMonkEOne", speed = math.huge, delay = 0.25, range = 0, width = 450, collision = false, aoe = false, type = "circular", dmgAD = function(source, target) return 25+35*source:GetSpellData(_E).level+source.addDamage end},
		[_R] = { name = "BlindMonkR", speed = 2000, delay = 0.25, range = 2000, width = 150, collision = false, aoe = false, type = "linear", dmgAD = function(source, target) return 200*source:GetSpellData(_R).level+2*source.addDamage end}
	},
	["Leona"] = {
		[_E] = { name = "LeonaZenithBlade", speed = 2000, delay = 0.250, range = 875, width = 80, collision = false, aoe = false, type = "linear"},
		[_R] = { name = "LeonaSolarFlare", speed = 2000, delay = 0.250, range = 1200, width = 300, collision = false, aoe = true, type = "circular"}
	},
	["Lissandra"] = {
		[_Q] = { name = "", speed = 1800, delay = 0.250, range = 725, width = 20, collision = true, aoe = false, type = "linear"}
	},
	["Lucian"] = {
		[_Q] = { name = "LucianQ" },
		[_W] = { name = "LucianW", speed = 800, delay = 0.300, range = 1000, width = 80, collision = true, aoe = false, type = "linear"},
		[_R] = { name = "LucianR" }
	},
	["Lulu"] = {
		[_Q] = { name = "LuluQ", speed = 1400, delay = 0.250, range = 925, width = 80, collision = false, aoe = false, type = "linear"}
	},
	["Lux"] = {
		[_Q] = { name = "LuxLightBinding", speed = 1200, delay = 0.25, range = 1300, width = 130, collision = true, type = "linear", dmgAP = function(source, target) return 10+50*source:GetSpellData(_Q).level+0.7*source.ap end},
		[_W] = { name = "LuxPrismaticWave", speed = 1630, delay = 0.25, range = 1250, width = 210, collision = false, type = "linear"},
		[_E] = { name = "LuxLightStrikeKugel", speed = 1300, delay = 0.25, range = 1100, width = 325, collision = false, type = "circular", dmgAP = function(source, target) return 15+45*source:GetSpellData(_E).level+0.6*source.ap end},
		[_R] = { name = "LuxMaliceCannon", speed = math.huge, delay = 1, range = 3340, width = 250, collision = false, type = "linear", dmgAP = function(source, target) return 200+100*source:GetSpellData(_R).level+0.75*source.ap end}
	},
	["Malphite"] = {
		[_R] = { name = "", speed = 1600, delay = 0.5, range = 900, width = 500, collision = false, aoe = true, type = "circular"}
	},
	["Malzahar"] = {
		[_Q] = { name = "AlZaharCalloftheVoid1", speed = math.huge, delay = 1, range = 900, width = 100, collision = false, aoe = false, type = "linear", dmgAP = function(source, target) return 25+55*source:GetSpellData(_Q).level+0.8*source.ap end},
		[_W] = { name = "", speed = math.huge, delay = 0.5, range = 800, width = 250, collision = false, aoe = false, type = "circular", dmgAP = function(source, target) return (3+source:GetSpellData(_W).level+source.ap*0.01)*target.maxHealth*0.01 end},
		[_E] = { name = "", range = 650, dmgAP = function(source, target) return (20+60*source:GetSpellData(_E).level)/8+0.1*source.ap end},
		[_R] = { name = "", range = 700, dmgAP = function(source, target) return 20+30*source:GetSpellData(_R).level+0.26*source.ap end}
	},
	["Maokai"] = {
		[_Q] = { name = "", speed = math.huge, delay = 0.25, range = 600, width = 100, collision = false, aoe = false, type = "linear"},
		[_E] = { name = "", speed = 1500, delay = 0.25, range = 1100, width = 175, collision = false, aoe = false, type = "circular"}
	},
	["MasterYi"] = {
	},
	["MissFortune"] = {
		[_E] = { name = "", speed = math.huge, delay = 0.25, range = 800, width = 200, collision = false, aoe = true, type = "circular"},
		[_R] = { name = "", speed = math.huge, delay = 0.25, range = 1400, width = 700, collision = false, aoe = true, type = "cone"}
	},
	["Mordekaiser"] = {
		[_E] = { name = "", speed = math.huge, delay = 0.25, range = 700, width = 0, collision = false, aoe = true, type = "cone"}
	},
	["Morgana"] = {
		[_Q] = { name = "DarkBindingMissile", speed = 1200, delay = 0.250, range = 1300, width = 80, collision = true, aoe = false, type = "linear"}
	},
	["Nami"] = {
		[_Q] = { name = "NamiQ", speed = math.huge, delay = 0.8, range = 850, width = 0, collision = false, aoe = true, type = "circular"}
	},
	["Nasus"] = {
		[_E] = { name = "", speed = math.huge, delay = 0.25, range = 450, width = 250, collision = false, aoe = true, type = "circular"}
	},
	["Nautilus"] = {
		[_Q] = { name = "NautilusAnchorDrag", speed = 2000, delay = 0.250, range = 1080, width = 80, collision = true, aoe = false, type = "linear"}
	},
	["Nidalee"] = {
		[_Q] = { name = "JavelinToss", speed = 1350, delay = 0.25, range = 1625, width = 37.5, collision = true, type = "linear", dmgAP = function(source, target) return (30+20*source:GetSpellData(_Q).level+0.4*source.ap)*math.max(1,math.min(3,GetDistance(source,target)/1250*3)) end}
	},
	["Nocturne"] = {
		[_Q] = { name = "NocturneDuskbringer", speed = 1400, delay = 0.250, range = 1125, width = 60, collision = false, aoe = false, type = "linear"}
	},
	["Nunu"] = {
	},
	["Olaf"] = {
		[_Q] = { name = "OlafAxeThrow", speed = 1600, delay = 0.25, range = 1000, width = 90, collision = false, aoe = false, type = "linear"}
	},
	["Orianna"] = {
		[_Q] = { name = "OrianaIzunaCommand", speed = 1200, delay = 0.250, range = 825, width = 175, collision = false, aoe = false, type = "linear", dmgAP = function(source, target) return 30+30*source:GetSpellData(_Q).level+0.5*source.ap end},
		[_W] = { name = "OrianaDissonanceCommand", speed = math.huge, delay = 0.250, range = 0, width = 225, collision = false, aoe = true, type = "circular", dmgAP = function(source, target) return 25+45*source:GetSpellData(_W).level+0.7*source.ap end},
		[_E] = { name = "OrianaRedactCommand", speed = 1800, delay = 0.250, range = 825, width = 80, collision = false, aoe = false, type = "linear", dmgAP = function(source, target) return 30+30*source:GetSpellData(_E).level+0.3*source.ap end},
		[_R] = { name = "OrianaDetonateCommand", speed = math.huge, delay = 0.250, range = 0, width = 410, collision = false, aoe = true, type = "circular", dmgAP = function(source, target) return 75+75*source:GetSpellData(_R).level+0.7*source.ap end}
	},
	["Pantheon"] = {
		[_E] = { name = "", speed = math.huge, delay = 0.250, range = 400, width = 100, collision = false, aoe = true, type = "cone"},
		[_R] = { name = "", speed = 3000, delay = 1, range = 5500, width = 1000, collision = false, aoe = true, type = "circular"}
	},
	["Poppy"] = {
	},
	["Quinn"] = {
		[_Q] = { name = "QuinnQ", speed = 1550, delay = 0.25, range = 1050, width = 80, collision = true, aoe = false, type = "linear", dmgAD = function(source, target) return 30+40*source:GetSpellData(_Q).level+0.65*source.addDamage+0.5*source.ap end},
		[_W] = { },
		[_E] = { range = 0, dmgAD = function(source, target) return 10+30*source:GetSpellData(_E).level+0.2*source.addDamage end},
		[_R] = { range = 0, dmgAD = function(source, target) return (70+50*source:GetSpellData(_R).level+0.5*source.addDamage)*(1+((target.maxHealth-target.health)/target.maxHealth)) end}
	},
	["Rammus"] = {
	},
	["RekSai"] = {
		[_Q] = { name = "", speed = 1550, delay = 0.25, range = 1050, width = 180, collision = true, aoe = false, type = "linear"}
	},
	["Renekton"] = {
		[_Q] = { name = "", speed = math.huge, delay = 0.25, range = 0, width = 450, collision = false, aoe = true, type = "circular"},
		[_E] = { name = "", speed = 1225, delay = 0.25, range = 450, width = 150, collision = false, aoe = false, type = "linear"}
	},
	["Rengar"] = {
		[_Q] = { range = 450+myHero.boundingRadius*2, dmgAD = function(source, target) return 30*source:GetSpellData(_Q).level+(0.95+0.05*source:GetSpellData(_Q).level)*source.totalDamage end},
		[_W] = { name = "RengarW", speed = math.huge, delay = 0.25, range = 0, width = 490, collision = false, aoe = true, type = "circular"},
		[_E] = { name = "RengarE", speed = 1225, delay = 0.25, range = 1000, width = 80, collision = true, aoe = false, type = "linear"},
		[_R] = { range = 4000}
	},
	["Riven"] = {
		[_Q] = { name = "RivenTriCleave", speed = math.huge, delay = 0.250, range = 310, width = 225, collision = false, aoe = true, type = "circular", dmgAD = function(source, target) return 0-10+20*myHero:GetSpellData(_Q).level+(0.35+0.05*myHero:GetSpellData(_Q).level)*source.totalDamage end},
		[_W] = { name = "RivenMartyr", speed = math.huge, delay = 0.250, range = 0, width = 265, collision = false, aoe = true, type = "circular", dmgAD = function(source, target) return 20+30*myHero:GetSpellData(_W).level+source.totalDamage end},
        [_E] = { range = 390},
		[_R] = { name = "rivenizunablade", speed = 2200, delay = 0.5, range = 1100, width = 200, collision = false, aoe = false, type = "cone", dmgAD = function(source, target) return (40+40*myHero:GetSpellData(_R).level+0.6*source.addDamage)*(math.min(3,math.max(1,4*(target.maxHealth-target.health)/target.maxHealth))) end}
	},
	["Rumble"] = {
		[_Q] = { name = "RumbleFlameThrower", speed = math.huge, delay = 0.250, range = 600, width = 500, collision = false, aoe = false, type = "cone", dmgAP = function(source, target) return 5+20*source:GetSpellData(_Q).level+0.33*source.ap end},
		[_W] = { range = myHero.boundingRadius},
		[_E] = { name = "RumbleGrenadeMissile", speed = 1200, delay = 0.250, range = 850, width = 90, collision = true, aoe = false, type = "linear", dmgAP = function(source, target) return 20+25*source:GetSpellData(_E).level+0.4*source.ap end},
		[_R] = { name = "RumbleCarpetBomb", speed = 1200, delay = 0.250, range = 1700, width = 90, collision = false, aoe = false, type = "linear", dmgAP = function(source, target) return 75+55*source:GetSpellData(_R).level+0.3*source.ap end}
	},
	["Ryze"] = {
		[_Q] = { name = "RyzeQ", speed = 1700, delay = 0.25, range = 900, width = 50, collision = true, aoe = false, type = "linear", dmgAP = function(source, target) return 35+25*source:GetSpellData(_Q).level+0.55*source.ap+(0.015+0.005*source:GetSpellData(_Q).level)*source.maxMana end},
		[_W] = { name = "RyzeW", range = 600, dmgAP = function(source, target) return 60+20*source:GetSpellData(_W).level+0.4*source.ap+0.025*source.maxMana end},
		[_E] = { name = "RyzeE", range = 600, dmgAP = function(source, target) return 34+16*source:GetSpellData(_E).level+0.3*source.ap+0.02*source.maxMana end},
		[_R] = { name = "RyzeR", range = 900}
	},
	["Sejuani"] = {
		[_Q] = { range = 0, dmgAP = function(source, target) return 35+45*source:GetSpellData(_Q).level+0.4*source.ap end},
		[_W] = { range = 0, dmgAP = function(source, target) return end},
		[_E] = { range = 0, dmgAP = function(source, target) return 30+30*source:GetSpellData(_E).level*0.5*source.ap end},
		[_R] = { name = "SejuaniGlacialPrisonCast", speed = 1600, delay = 0.250, range = 1200, width = 110, collision = false, aoe = false, type = "linear", dmgAP = function(source, target) return 50+100*source:GetSpellData(_R).level*0.8*source.ap end}
	},
	["Shaco"] = {
	},
	["Shen"] = {
		[_E] = { name = "ShenShadowDash", speed = 1200, delay = 0.25, range = 600, width = 40, collision = false, aoe = false, type = "linear"}
	},
	["Shyvana"] = {
		[_Q] = { range = 0, dmgAD = function(source, target) return (0.75+0.05*source:GetSpellData(_Q).level)*source.totalDamage end},
		[_W] = { range = 0, dmgAP = function(source, target) return 5+15*source:GetSpellData(_W).level+0.2*source.totalDamage end},
		[_E] = { name = "", speed = 1500, delay = 0.250, range = 925, width = 60, collision = false, aoe = false, type = "linear", dmgAP = function(source, target) return 20+40*source:GetSpellData(_E).level+0.6*source.totalDamage end},
		[_R] = { range = 0, dmgAP = function(source, target) return 50+125*source:GetSpellData(_R).level+0.7*source.ap end}
	},
	["Singed"] = {
	},
	["Sion"] = {
		[_Q] = { name = "", speed = math.huge, delay = 0.125, range = 925, width = 250, collision = false, aoe = false, type = "cone"}
	},
	["Sivir"] = {
		[_Q] = { name = "SivirQ", speed = 1330, delay = 0.250, range = 1075, width = 0, collision = false, aoe = false, type = "linear"}
	},
	["Skarner"] = {
		[_E] = { name = "", speed = 1200, delay = 0.600, range = 350, width = 60, collision = false, aoe = false, type = "linear"}
	},
	["Sona"] = {
		[_R] = { name = "SonaCrescendo", speed = 2400, delay = 0.5, range = 900, width = 160, collision = false, aoe = false, type = "linear"}
	},
	["Soraka"] = {
		[_Q] = { name = "SorakaQ", speed = 2400, delay = 0.25, range = 900, width = 160, collision = false, aoe = true, type = "circular"}
	},
	["Swain"] = {
		[_W] = { name = "SwainShadowGrasp", speed = math.huge, delay = 0.850, range = 900, width = 125, collision = false, aoe = true, type = "circular"}
	},
	["Syndra"] = {
		[_Q] = { name = "SyndraQ", speed = math.huge, delay = 0.67, range = 790, width = 125, collision = false, aoe = true, type = "circular", dmgAP = function(source, target) return ((source:GetSpellData(_Q).level == 5 and target.type == myHero.type) and 1.15 or 1)*(5+45*source:GetSpellData(_Q).level+0.6*source.ap) end},
		[_W] = { name = "syndrawcast", speed = math.huge, delay = 0.8, range = 925, width = 190, collision = false, aoe = true, type = "circular", dmgAP = function(source, target) return 40+40*source:GetSpellData(_W).level+0.7*source.ap end},
		[_E] = { name = "", speed = 2500, delay = 0.25, range = 730, width = 45, collision = false, aoe = true, type = "cone", dmgAP = function(source, target) return 25+45*source:GetSpellData(_E).level+0.4*source.ap end},
		[_R] = { name = "", range = 725, dmgAP = function(source, target, stacks) return math.max((stacks or 1) + 3, 7)*(45+45*source:GetSpellData(_R).level+0.2*source.ap) end}
	},
	["Talon"] = {
		[_Q] = { name = "", range = myHero.range+myHero.boundingRadius*2, dmgAD = function(source, target) return source.totalDamage+30*source:GetSpellData(_Q).level+0.3*(source.addDamage) end},
		[_W] = { name = "", speed = 900, delay = 0.25, range = 600, width = 200, collision = false, aoe = false, type = "cone", dmgAD = function(source, target) return 2*(5+25*source:GetSpellData(_W).level+0.6*(source.addDamage)) end},
		[_E] = { name = "", range = 700},
		[_R] = { name = "", speed = math.huge, delay = 0.25, range = 0, width = 650, collision = false, aoe = false, type = "circular", dmgAD = function(source, target) return 2*(70+50*source:GetSpellData(_R).level+0.75*(source.addDamage)) end}
	},
	["Taric"] = {
		[_R] = { name = "", speed = math.huge, delay = 0.25, range = 0, width = 175, collision = false, aoe = false, type = "circular"}
	},
	["Teemo"] = {
		[_Q] = { name = "", range = myHero.range+myHero.boundingRadius*3, dmgAP = function(source, target) return 35+45*source:GetSpellData(_Q).level+0.8*source.ap end},
		[_W] = { name = "", range = 25000},
		[_E] = { name = "", range = myHero.range+myHero.boundingRadius, dmgAP = function(source, target) return 10*source:GetSpellData(_E).level+0.3*source.ap end},
		[_R] = { name = "", speed = 1200, delay = 1.25, range = 900, width = 250, type = "circular", dmgAP = function(source, target) return 75+125*source:GetSpellData(_E).level+0.5*source.ap end}
	},
	["Thresh"] = {
		[_Q] = { name = "ThreshQ", speed = 1825, delay = 0.5, range = 1050, width = 70, collision = true, aoe = false, type = "linear", dmgAP = function(source, target) return 35+45*source:GetSpellData(_Q).level+0.8*source.ap end},
		[_W] = { range = 25000},
		[_E] = { name = "ThreshE", speed = 2000, delay = 0.25, range = 450, width = 110, collision = false, aoe = false, type = "linear", dmgAP = function(source, target) return 9*source:GetSpellData(_E).level+0.3*source.ap end},
		[_R] = { range = 450, width = 250}
	},
	["Tristana"] = {
		[_Q] = { name = "", range = 543 },
		[_W] = { name = "", speed = 2100, delay = 0.25, range = 900, width = 125, collision = false, aoe = false, type = "circular", dmgAP = function(source, target, stacks) return (1+(stacks or 0)*0.25)*(45+35*source:GetSpellData(_W).level+0.5*source.ap) end},
		[_E] = { name = "", range = 543, dmgAD = function(source, target, stacks) return (1+(stacks or 0)*0.3)*(50+10*source:GetSpellData(_E).level+0.5*source.ap+(0.35+0.15*source:GetSpellData(_E).level)*source.addDamage) end },
		[_R] = { name = "", range = 543, dmgAP = function(source, target) return 200+100*source:GetSpellData(_R).level+source.ap end }
	},
	["Trundle"] = {
		[_Q] = { name = "", speed = math.huge, delay = 0.25, range = 1000, width = 125, collision = false, aoe = false, type = "circular"}
	},
	["Tryndamere"] = {
		[_E] = { name = "", speed = 700, delay = 0.250, range = 650, width = 160, collision = false, aoe = false, type = "linear"}
	},
	["TwistedFate"] = {
		[_Q] = { name = "WildCards", speed = 1500, delay = 0.250, range = 1200, width = 80, collision = false, aoe = false, type = "cone"}
	},
	["Twitch"] = {
		[_W] = { name = "", speed = 1750, delay = 0.250, range = 950, width = 275, collision = false, aoe = true, type = "circular"}
	},
	["Udyr"] = {
	},
	["Urgot"] = {
		[_Q] = { name = "UrgotHeatseekingLineMissile", speed = 1575, delay = 0.175, range = 1000, width = 80, collision = true, aoe = false, type = "linear"},
		[_E] = { name = "UrgotPlasmaGrenade", speed = 1750, delay = 0.25, range = 890, width = 200, collision = false, aoe = true, type = "circular"}
	},
	["Varus"] = {
		[_Q] = { name = "VarusQ", speed = 1500, delay = 0.5, range = 1475, width = 100, collision = false, aoe = false, type = "linear"},
		[_E] = { name = "VarusEMissile", speed = 1750, delay = 0.25, range = 925, width = 235, collision = false, aoe = true, type = "circular"},
		[_R] = { name = "VarusR", speed = 1200, delay = 0.5, range = 800, width = 100, collision = false, aoe = false, type = "linear"}
	},
	["Vayne"] = {
		[_Q] = { name = "", range = 450, dmgAD = function(source, target) return (1.25+0.05*source:GetSpellData(_Q).level)*source.totalDamage end},
		[_W] = { name = "", range = myHero.range+myHero.boundingRadius*2, dmgTRUE = function(source, target) return 10+10*source:GetSpellData(_W).level+((0.03+0.01*source:GetSpellData(_W).level)*target.maxHealth) end},
		[_E] = { name = "", speed = 2000, delay = 0.25, range = 650, width = 0, collision = false, aoe = false, type = "linear", dmgAD = function(source, target) return 10+35*source:GetSpellData(_E).level+0.5*source.addDamage end},
		[_R] = { name = "", range = 1000}
	},
	["Veigar"] = {
		[_Q] = { name = "VeigarBalefulStrike", speed = 1200, delay = 0.25, range = 900, width = 70, collision = true, aoe = false, type = "linear", dmgAP = function(source, target) return 30+40*source:GetSpellData(_Q).level+0.6*source.ap end},
		[_W] = { name = "VeigarDarkMatter", speed = math.huge, delay = 1.2, range = 900, width = 225, collision = false, aoe = false, type = "circular", dmgAP = function(source, target) return 50+50*source:GetSpellData(_W).level+source.ap end},
		[_E] = { name = "", speed = math.huge, delay = 0.75, range = 725, width = 275, collision = false, aoe = false, type = "circular"},
		[_R] = { name = "", range = 650, dmgAP = function(source, target) return 125+125*source:GetSpellData(_R).level+source.ap+target.ap end}
	},
	["VelKoz"] = {
		[_Q] = { name = "VelKozQ", speed = 1300, delay = 0.066, range = 1050, width = 50, collision = true, aoe = false, type = "linear"},
		[_W] = { name = "VelKozW", speed = 1700, delay = 0.064, range = 1050, width = 80, collision = false, aoe = false, type = "linear"},
		[_E] = { name = "VelKozE", speed = 1500, delay = 0.333, range = 850, width = 225, collision = false, aoe = true, type = "circular"},
		[_R] = { name = "VelKozR", speed = math.huge, delay = 0.333, range = 1550, width = 50, collision = false, aoe = false, type = "linear"}
	},
	["Vi"] = {
		[_Q] = { name = "", speed = 1500, delay = 0.25, range = 715, width = 55, collision = false, aoe = false, type = "linear"}
	},
	["Viktor"] = {
		[_Q] = { range = 0, dmgAP = function(source, target) return 20+20*source:GetSpellData(_Q).level+0.2*source.ap end},
		[_W] = { name = "", speed = 750, delay = 0.6, range = 700, width = 125, collision = false, aoe = true, type = "circular"},
		[_E] = { name = "ViktorDeathRay", speed = 1200, delay = 0.25, range = 1200, width = 0, collision = false, aoe = false, type = "linear", dmgAP = function(source, target) return 25+45*source:GetSpellData(_E).level+0.7*source.ap end},
		[_R] = { name = "", speed = 1000, delay = 0.25, range = 700, width = 0, collision = false, aoe = true, type = "circular", dmgAP = function(source, target) return 50+100*source:GetSpellData(_R).level+0.55*source.ap end}
	},
	["Vladimir"] = {
	},
	["Volibear"] = {
		[_Q] = { range = myHero.range+myHero.boundingRadius*2, dmgAD = function(source, target) return 30*source:GetSpellData(_Q).level+source.totalDamage end},
		[_W] = { range = myHero.range*2+myHero.boundingRadius+25, dmgAD = function(source, target) return ((1+(target.maxHealth-target.health)/target.maxHealth))*(45*source:GetSpellData(_W).level+35+0.15*(source.maxHealth-(440+86*source.level))) end},
		[_E] = { range = myHero.range*2+myHero.boundingRadius*2+10, dmgAP = function(source, target) return 45*source:GetSpellData(_E).level+15+0.6*source.ap end},
		[_R] = { range = myHero.range+myHero.boundingRadius, dmgAP = function(source, target) return 40*source:GetSpellData(_R).level+35+0.3*source.ap end}
	},
	["Warwick"] = {
	},
	["Wukong"] = {
	},
	["Xerath"] = {
		[_Q] = { name = "", speed = math.huge, delay = 1.75, range = 750, width = 100, collision = false, aoe = false, type = "linear"},
		[_W] = { name = "", speed = math.huge, delay = 0.25, range = 1100, width = 100, collision = false, aoe = true, type = "circular"},
		[_E] = { name = "", speed = 1600, delay = 0.25, range = 1050, width = 70, collision = true, aoe = false, type = "linear"},
		[_R] = { name = "", speed = math.huge, delay = 0.75, range = 3200, width = 245, collision = false, aoe = true, type = "circular"}
	},
	["XinZhao"] = {
		[_R] = { name = "", speed = math.huge, delay = 0.25, range = 0, width = 375, collision = false, aoe = true, type = "circular"}
	},
	["Yasuo"] = {
		[_Q] = { name = "YasuoQ", speed = math.huge, delay = 0.25, range = 475, width = 40, collision = false, aoe = false, type = "linear", dmgAD = function(source, target) return 20*source:GetSpellData(_Q).level+source.totalDamage-10 end},
		[_W] = { name = "", range = 350},
		[_E] = { name = "", range = 475, dmgAP = function(source, target) return 50+20*source:GetSpellData(_E).level+source.ap end},
		[_R] = { name = "", range = 1200, dmgAD = function(source, target) return 100+100*source:GetSpellData(_R).level+1.5*source.totalDamage end},
		[-2] = { name = "", range = 1200, speed = 1200, delay = 0.125, width = 65, collision = false, aoe = false, type = "linear" }
	},
	["Yorick"] = {
		[_Q] = { range = 0, dmgAD = function(source, target) return 30*source:GetSpellData(_Q).level+1.2*source.totalDamage+source.totalDamage end},
		[_W] = { name = "", speed = math.huge, delay = 0.25, range = 600, width = 175, collision = false, aoe = true, type = "circular", dmgAP = function(source, target) return 50+20*source:GetSpellData(_W).level+source.ap end},
		[_E] = { range = 0, dmgAD = function(source, target) return 100+100*source:GetSpellData(_E).level+source.addDamage*1.5 end},
	},
	["Zac"] = {
		[_Q] = { name = "", speed = 2500, delay = 0.110, range = 500, width = 110, collision = false, aoe = false, type = "linear"}
	},
	["Zed"] = {
		[_Q] = { name = "ZedShuriken", speed = 1700, delay = 0.25, range = 900, width = 48, collision = false, aoe = false, type = "linear"},
		[_E] = { name = "", speed = math.huge, delay = 0.25, range = 0, width = 300, collision = false, aoe = true, type = "circular"}
	},
	["Ziggs"] = {
		[_Q] = { name = "ZiggsQ", speed = 1750, delay = 0.25, range = 1400, width = 155, collision = true, aoe = false, type = "linear"},
		[_W] = { name = "ZiggsW", speed = 1800, delay = 0.25, range = 970, width = 275, collision = false, aoe = true, type = "circular"},
		[_E] = { name = "ZiggsE", speed = 1750, delay = 0.12, range = 900, width = 350, collision = false, aoe = true, type = "circular"},
		[_R] = { name = "ZiggsR", speed = 1750, delay = 0.14, range = 5300, width = 525, collision = false, aoe = true, type = "circular"}
	},
	["Zilean"] = {
		[_Q] = { name = "", speed = math.huge, delay = 0.5, range = 900, width = 150, collision = false, aoe = true, type = "circular"}
	},
	["Zyra"] = {
		[-1] = { name = "zyrapassivedeathmanager" },
		[_Q] = { name = "ZyraQFissure", speed = math.huge, delay = 0.7, range = 800, width = 85, collision = false, aoe = true, type = "circular"},
		[_E] = { name = "ZyraGraspingRoots", speed = 1150, delay = 0.25, range = 1100, width = 70, collision = false, aoe = false, type = "linear"},
		[_R] = { name = "ZyraBrambleZone", speed = math.huge, delay = 1, range = 1100, width = 500, collision=false, aoe = true, type = "circular"}
	}
}
