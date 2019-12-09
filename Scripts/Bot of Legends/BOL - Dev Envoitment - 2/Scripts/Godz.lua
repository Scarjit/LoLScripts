if not _G.UPLloaded then
  if FileExist(LIB_PATH .. "/UPL.lua") then
    require("UPL")
    _G.UPL = UPL()
  else 
    print("Downloading UPL, please don't press F9")
    DelayAction(function() DownloadFile("https://raw.github.com/nebelwolfi/BoL/master/Common/UPL.lua".."?rand="..math.random(1,10000), LIB_PATH.."UPL.lua", function () print("Successfully downloaded UPL. Press F9 twice.") end) end, 3) 
    return
  end
end

function OnWndMsg(msg,wParam)
	if msg ~= 256 or wParam ~= 99 then return end
   	targetSelector:update()
   	if not targetSelector.target then return end

   	CastPosition, HitChance, HeroPosition = UPL:Predict(_E, myHero, targetSelector.target)
   	if CastPosition and HitChance > 0 then
   		CastSpell(_E, CastPosition.x, CastPosition.z)
   	end
end

function OnLoad()
	Config = scriptConfig("Godz Caitlyn", "godz_cait")
	targetSelector = TargetSelector(TARGET_LESS_CAST, 1000, DAMAGE_MAGIC, true)
	UPL:AddToMenu(Config)
	UPL:AddSpell(_E, {speed = 1600, delay = 125, range = 1000, width = 70, collision = true, aoe = false, type="linear"})
end