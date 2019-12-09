function OnLoad()
	enemys = GetEnemyHeroes()
	menu = scriptConfig("DrawLinesToEnemysIfRangeUnderX", "dlteifux")

	menu:addParam("range", "Max Range", SCRIPT_PARAM_SLICE, 5000,50,10000,0)
	menu:addSubMenu("Blacklist", "black")
	for _, v in pairs(enemys) do
		menu.black:addParam("bl"..v.charName,v.charName, SCRIPT_PARAM_ONOFF,false)
	end
end

function CalcVector(source,target)
	local V = Vector(source.x, source.y, source.z)
	local V2 = Vector(target.x, target.y, target.z)
	local vec = V-V2
	local vec2 = vec:normalized()
	return vec2
end

function OnDraw()
	if not enemys or not menu then return end
	for _,v in pairs(enemys) do
		if v and v.valid and not v.dead and v.visible and not menu.black["bl"..v.charName] and GetDistance(v) <= menu.range then
			DrawLine3D2(v.x,v.y,v.z,myHero.x,myHero.y,myHero.z,2,ARGB(255,255,255,255))

			local V = CalcVector(myHero,v)*-250

			DrawText3D(v.charName..": "..math.round(GetDistance(v,myHero)),V.x+myHero.x,V.y+myHero.y,V.z+myHero.z,18,ARGB(255,255,0,0))
		end
	end
end

function DrawLine3D2(x1, y1, z1, x2, y2, z2, width, color)
    local p = WorldToScreen(D3DXVECTOR3(x1, y1, z1))
    local px, py = p.x, p.y
    local c = WorldToScreen(D3DXVECTOR3(x2, y2, z2))
    local cx, cy = c.x, c.y
    DrawLine(cx, cy, px, py, width or 1, color or 4294967295)
end