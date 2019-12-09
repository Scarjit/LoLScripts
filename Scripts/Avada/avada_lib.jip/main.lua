--[[
    Returns all libs
    
	
    common = Common functions
--]]

local main = {}
main.version = 1.1

main.common = loadsubmodule("avada_lib", "common")
main.draw = loadsubmodule("avada_lib", "draw")

return main