return {
  --type of the script, used for categorization in the menu
  ["scriptType"] = "Libary",
  --name of the script, displayed in core menu
  ["scriptName"] = "Avada Lib",
  --module name. maps your main.lua to api-call 'module = loadmodule(ModuleName)''
  ["moduleName"] = "avada_lib",
  --script is displayed in menu if filter function is true
  ["loadToCoreMenu"] = function()
      return false
  end
}