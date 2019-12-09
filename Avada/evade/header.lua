return {
  --type of the script, used for categorization in the menu
  ["scriptType"] = "Evade Script",
  --name of the script, displayed in core menu
  ["scriptName"] = "Avada Evade",
  --module name. maps your main.lua to api-call 'module = loadmodule(ModuleName)''
  ["moduleName"] = "avada_evade",
  --script is displayed in menu if filter function is true
  ["loadToCoreMenu"] = function()
      return true
  end
}