function OnProcessAttack(object, spell)
	if object.team ~= myHero.team and not myHero.dead and object.type and object.type == "AIHeroClient" then
		if myHero:CanUseSpell(_R) ~= 0 then return end

		spelltype, casttype = getSpellType(object, spell.name)
		if casttype >= 4 and casttype <= 6 then
			return
		end

		

	end
end