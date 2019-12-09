function a2v ( a, m )
  m = m or 1
  local x = math.cos ( a ) * m
  local y = math.sin ( a ) * m
  return x, y
end

local white = ARGB(255,255,255,255)
local pi = math.pi
local pointsSmall = {}
local pointsLarge = {}
local drawPoints = {}
local resolution = 35
for i=1,resolution do
	local PX, PZ = a2v(pi*i/(resolution/3.5),200)
	pointsSmall[#pointsSmall+1] = {x = PX, z = PZ}
	local PX, PZ = a2v(pi*i/(resolution/3.5)+(resolution/70),300)
	pointsLarge[#pointsLarge+1] = {x = PX, z = PZ}
end

function OnDraw()
	local X,Y,Z = myHero.x, myHero.y, myHero.z
	DrawCircle3D(X,Y,Z,200,1, white)
	DrawCircle3D(X,Y,Z,300,1, white)
	for i,v in ipairs(pointsSmall) do
		if i > 1 and i < #pointsSmall then
			local nextPointL = pointsLarge[i-1]
			local nextPointS = pointsSmall[i+1]
			DrawLine3D(X+v.x, Y, Z+v.z,X+nextPointL.x, Y, Z+nextPointL.z)
			DrawLine3D(X+nextPointL.x, Y, Z+nextPointL.z,X+nextPointS.x, Y, Z+nextPointS.z)
		end
	end
end