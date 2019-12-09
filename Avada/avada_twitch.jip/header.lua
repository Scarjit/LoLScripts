return {
  --type of the script, used for categorization in the menu
  ["scriptType"] = "Champion",
  --name of the script, displayed in core menu
  ["scriptName"] = "Avada Twitch",
  --module name. maps your main.lua to api-call 'module = loadmodule(ModuleName)''
  ["moduleName"] = "avadatwitch",
  --script is displayed in core menu if filter function is true
  ["loadToCoreMenu"] = function()
    return objmanager.player.charName == "Twitch"
  end
}