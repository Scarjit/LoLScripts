return {
  --type of the script, used for categorization in the menu
  ["scriptType"] = "Champion",
  --name of the script, displayed in core menu
  ["scriptName"] = "eGirlsBundle [" .. objmanager.player.charName .. "]",
  --module name. maps your main.lua to api-call 'module = loadmodule(ModuleName)''
  ["moduleName"] = "egirlsbundle",
  --script is displayed in menu if filter function is true
  ["loadToCoreMenu"] = function()
      local enabled_champions = {
    	Annie = false,
    	Karma = false,
    	Janna = false,
    	Leona = false,
    	Lulu = false,
    	Lux = false,
    	Morgana = false,
    	Nami = false,
    	Sona = true,
    	Soraka = true,
    	Zyra = false,
    }
    return enabled_champions[objmanager.player.charName] and enabled_champions[objmanager.player.charName] == true
  end
}