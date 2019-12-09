function OnLoad()
	PR = PentagonRot(myHero, ARGB(255,255,255,255),1,200)
end


class "PentagonRot"
function PentagonRot:__init(object, color, thickness, size,version)
	self.VisionVector = nil
	self.object = object
	self.color = color
	self.thickness = thickness
	self.size = size
	self.version = version
	AddDrawCallback(function ()
		self:DrawHexagonRot(self.object, self.color, self.thickness, self.size,self.version)
	end)
end


function PentagonRot:DrawHexagonRot(object, color, thickness, size)
	local function CalcVisionVector(source)
		local vV = Vector(myHero.visionPos.x,myHero.visionPos.y,myHero.visionPos.z)
		local hV = Vector(myHero.x,myHero.y,myHero.z)
		local vec = vV-hV
		local vec2 = vec:normalized()
		return vec2
	end

	local function CalcZeroVector(source)
		local V = Vector(myHero.x, myHero.y, myHero.z)
		local V2 = Vector(myHero.x+100, myHero.y, myHero.z)
		local vec = V-V2
		local vec2 = vec:normalized()
		return vec2
	end

	local function CalcAngle(vector1, vector2)
		local angle = math.atan2(vector1.z-vector2.z, vector1.x-vector2.x)
		return angle
	end

	if CalcVisionVector(myHero).x < 5000 then
		self.VisionVector = CalcVisionVector(myHero)
		self.VisionVector = self.VisionVector*100
	end
	local ZeroVector = CalcZeroVector(myHero)*100
	local rot = 0
	if self.VisionVector and ZeroVector then
		rot = CalcAngle(self.VisionVector,ZeroVector)
	end

	local pi = 3.14159
	if not object then object = myHero end
	if not color then color = ARGB(255,255,255,255) end
	if not thickness then thickness = 3 end
	if not size then size = 50 end
	local X, Y, Z = object.x, object.y, object.z
	local RX1, RZ1 = a2v((rot), size)
	local RX2, RZ2 = a2v((rot)+pi*0.2, size)
	local RX3, RZ3 = a2v((rot)+pi*0.4, size)
	local RX4, RZ4 = a2v((rot)+pi*0.6, size)
	local RX5, RZ5 = a2v((rot)+pi*0.8, size)

	local PX1 = X+RX1
	local PZ1 = Z+RZ1

	local PX2 = X+RX2
	local PZ2 = Z+RZ2

	local PX3 = X+RX3
	local PZ3 = Z+RZ3

	local PX4 = X+RX4
	local PZ4 = Z+RZ4

	local PX5 = X+RX5
	local PZ5 = Z+RZ5	



	local PXT1 = X-(PX1-X)
	local PZT1 = Z-(PZ1-Z)

	local PXT2 = X-(PX2-X)
	local PZT2 = Z-(PZ2-Z)

	local PXT3 = X-(PX3-X)
	local PZT3 = Z-(PZ3-Z)

	local PXT4 = X-(PX4-X)
	local PZT4 = Z-(PZ4-Z)

	local PXT5 = X-(PX5-X)
	local PZT5 = Z-(PZ5-Z)

	--[[======Version 1=======]]--
	if version == 1 then
		DrawLine3D(PX1, Y, PZ1, PX3, Y, PZ3, thickness, color)
		DrawLine3D(PX3, Y, PZ3, PX5, Y, PZ5, thickness, color)
		DrawLine3D(PX5, Y, PZ5, PXT2, Y, PZT2, thickness, color)
		DrawLine3D(PXT2, Y, PZT2, PXT4, Y, PZT4, thickness, color)
		DrawLine3D(PXT4, Y, PZT4, PX1, Y, PZ1, thickness, color)
	else
	--[[======Version 2=======]]--
		DrawLine3D(PX2, Y, PZ2, PX4, Y, PZ4, thickness, color)
		DrawLine3D(PX4, Y, PZ4, PXT1, Y, PZT1, thickness, color)
		DrawLine3D(PXT1, Y, PZT1, PXT3, Y, PZT3, thickness, color)
		DrawLine3D(PXT3, Y, PZT3, PXT5, Y, PZT5, thickness, color)
		DrawLine3D(PXT5, Y, PZT5, PX2, Y, PZ2, thickness, color)
	end
end


function a2v ( a, m )
  m = m or 1
  local x = math.cos ( a ) * m
  local y = math.sin ( a ) * m
  return x, y
end