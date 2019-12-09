require("PacketInspector")
 
local Inspector = PacketInspector()
 
Inspector.Filters.Send = function(p)
   return DumpPacketData(p):find(EncodeFHex(myHero.networkID))
end
 
function OnLoad()
   Inspector:StartLog(true, true)
end