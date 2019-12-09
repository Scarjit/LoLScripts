function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

local main = {}

print("Loading Feature Lib")

main.menu, a = loadsubmodule("featurelib", "menu")
main.menu.init()


main.items = {}
main.registeritem = function  (item_name, script_name)
  item_name_l = item_name:lower()
  script_name = tostring(script_name)
  --Item reg
  local first = false
  if(not main.items[item_name_l])then
    main.items[item_name_l] = {}
    first = true
  end
  if(main.items[item_name_l][script_name])then
    error("[Feature lib] Adding items twice is not allowed")
  end
  
  main.items[item_name_l][script_name] = first
  
  --Menu
  if(first)then
    main.menu.m:menu(item_name_l, firstToUpper(item_name_l))
  end
  main.menu.m[item_name_l]:boolean(script_name, script_name, first)
  
  print("[Feature lib] Added " .. script_name .. " as item handler for " .. item_name_l .. " | Activated: " .. tostring(first))
end

main.caniuse = function(item_name, script_name)
  item_name_l = item_name:lower()
  script_name = tostring(script_name)
  if(not main.items[item_name_l])then
    print("[Feature lib] " ..item_name_l .. " is not registered [Callee: " .. script_name .. "]")
    return false
  end
  
  return main.items[item_name_l][script_name]
end

return main