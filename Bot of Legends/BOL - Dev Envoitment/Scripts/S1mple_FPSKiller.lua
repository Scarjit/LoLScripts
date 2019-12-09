local draws = {}
function OnDraw()
	draws[#draws+1] = D()
end

class('D')
function D:__init()
	AddDrawCallback(function ()
 		self:OnDraw()
 	end)
end

function D:OnDraw()
	DrawCircle3D(myHero.x,myHero.y,myHero.z,math.random(1,500), math.random(1,500), ARGB(math.random(1,255),math.random(1,255),math.random(1,255),math.random(1,255)))
end