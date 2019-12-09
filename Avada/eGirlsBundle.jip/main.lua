local objmanager = objmanager
local myHero = objmanager.player
local orb = loadorbwalker()

local alib = loadmodule("avada_lib")
if(alib.version < 1.1)then
  print("Outdated Avada Lib")
end

local champ_module = loadsubmodule("egirlsbundle", "Champions/"..myHero.charName)
champ_module:load()



--Disable this in production
--Anti AFK
callback.add(enum.callback.tick, function  ()
    --[[
     if(math.random(0,1000) > 990)then
         local v = vec3(math.random(0,1000),math.random(0,1000),math.random(0,1000))
         game.issue("move", v)
     end
     --]]
end)