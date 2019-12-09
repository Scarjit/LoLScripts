function OnLoad()
	test = objManager:GetObjectByNetworkId(myHero.networkID).name
	print(test)
end