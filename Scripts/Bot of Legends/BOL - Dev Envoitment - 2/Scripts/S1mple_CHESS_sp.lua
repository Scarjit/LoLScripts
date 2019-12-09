local version = 0.0
oldprint = _G.print
print = function (arg)
	oldprint('<font color=\"#515151\">S1mple_Syndra</font><font color=\"#000000\"> - </font><font color=\"#cccccc\">'..arg..'</font>')
end
function OnLoad()
	print("Loading S1mple_Chess Version "..tostring(version))
end