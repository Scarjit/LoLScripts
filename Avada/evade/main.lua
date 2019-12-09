--[[
  Avade Evade
--]]

common = loadmodule("avada_lib").common
myHero = objmanager.player


main = common.Class()
function main:init()
  print("Loading")
  
  main:registermodules()
  main:registercallbacks()
end

function main:registermodules()  
  main.menu = loadsubmodule("avada_evade", "menu")
  main.debug = loadsubmodule("avada_evade", "modules/debug")
  main.evader = loadsubmodule("avada_evade", "modules/evader")
end

function main:registercallbacks()
  --print("Registering Callbacks")
end



callback.add(enum.callback.load, main.init)