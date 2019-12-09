local function CreateWard(object)
    if object and object.valid and object.type and object.name and object.team ~= myHero.team and object.mana and object.maxMana then
		if object.name == "VisionWard" and object.maxMana == 0 then
			pinkWardTable[#pinkWardTable+1] = object
		elseif object.name ~= "WardCorpse" and object.name:lower():find("ward") and not object.name:lower():find("warddeath") then
			greenWardTable[#greenWardTable+1] = { position = object.pos, endTime = math.floor(object.maxMana + game.time), object = object }
		end
    end
end

local function DeleteWard(object)
    if object and object.valid and object.type == "obj_AI_Minion" and object.team ~= myHero.team then
        local name = object.name and object.name:lower() or nil
        if not name then return end
        if not name:find("corpse") and (name:find("ward") or name:find("trinket")) and not name:find("idle") and object.maxMana > 0 then
            for i = 1, #greenWardTable do
                local ward = greenWardTable[i]
                if ward and ward.object and ward.object.valid and object.networkID == ward.object.networkID then
                    if greenWardTable[i] ~= nil then
                        greenWardTable[i] = nil
                    end
                end
            end
        elseif name:find("vision") then
            for i = 1, #pinkWardTable do
                local ward = pinkWardTable[i]
                if ward and ward.valid and object.networkID == ward.networkID then
                    if pinkWardTable[i] ~= nil then
                        pinkWardTable[i] = nil
                    end
                end
            end
        end
    end
end

local function DrawWards()
    local function DrawPinkWard(ward)
        if ward and ward.valid and ward.object == nil and ward.health > 0 then
            if ward.maxMana == 0 then
                local screenPos = WorldToScreen(ward.pos)
                if OnScreen(screenPos, screenPos) then
                    DrawCircle3D(ward.pos.x, ward.pos.y, ward.pos.z, 75, 2, ARGB(255,255,0,255), Menu.WardsSettings.WardTrackerQuality)
                    DrawTextA("Pink ward", 16, screenPos.x, screenPos.y, ARGB(255,255,0,255), "center", "center")
                end
            end
        end
    end

    local function DrawGreenWard(ward)
         if ward and ward.valid and ward.object.health > 0 and ward.endTime >= GetInGameTimer() then
            local screenPos = WorldToScreen(ward.position)
            if OnScreen(screenPos, screenPos) then
                DrawCircle3D(ward.position.x, ward.position.y, ward.position.z, 75, 2, ARGB(255,0,190,0), Menu.WardsSettings.WardTrackerQuality)
                DrawTextA("Ward", 16, screenPos.x, screenPos.y - 10, ARGB(255,0,190,0), "center", "center")
                DrawTextA(math.floor(ward.endTime - GetInGameTimer()), 16, screenPos.x, screenPos.y + 10, ARGB(255,0,190,0), "center", "center")
            end
        end
    end

	if pinkWardTable and pinkWardTable.valid then
		for i = 1, #pinkWardTable do
			DrawPinkWard(pinkWardTable[i])
		end
    end

	if greenWardTable and greenWardTable.valid then
		for i = 1, #greenWardTable do
			DrawGreenWard(greenWardTable[i])
		end
    end
end