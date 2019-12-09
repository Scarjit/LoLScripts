--EkkoW EkkoR

local alib = loadmodule("avada_lib")
local common = alib.common
local draw = alib.draw
local polygon_helper = loadsubmodule("avada_evade", "modules/polygon_helper")
local clipper = loadclipper()
local myHero = objmanager.player

ekko = common.Class(function (s, hero)
  callback.add(enum.callback.recv.spell, function  (a)
    s:recvspell(a)
  end)
  --callback.add(enum.callback.draw, function  ()
    --s:draw()
  --end)
  callback.add(enum.callback.tick, function  ()
    s:tick()
    s:deletespell()
    s:calc_polygons()
  end)
  s.hero = hero
  s.spells = {}
  s.evpoly = clipper.polygon()
  print("Loaded ekko submodule")
end)

function ekko:IsValidSpell (spell)
  if(spell.isBasicAttack)then return false end
  if(spell.owner.team == myHero.team)then return false end
  if(spell.owner.type ~= myHero.type)then return false end
  if(spell.name == "EkkoW")then return true end
  if(spell.name == "EkkoR")then return true end
  return false
end

function ekko:recvspell (spell)
  if(not self:IsValidSpell(spell)) then return end
  local timeout = os.clock() + spell.windUpTime
  
  if(spell.name == "EkkoW")then
    self.spells[#self.spells+1] = {timeout = timeout, time = os.clock(), width = 375, endPos = vec3(spell.endPos.x,spell.endPos.y,spell.endPos.z)}
  elseif(spell.name == "EkkoR")then
    self.spells[#self.spells+1] = {timeout = timeout, time = os.clock(), width = 375, endPos = vec3(spell.endPos.x,spell.endPos.y,spell.endPos.z)}
  end
end

function ekko:deletespell ()
  if(myHero.isDead)then
    self.spells = {}
  else
    local n = #self.spells
    for i=1,n do
      local spell = self.spells[i]
      
      if(spell.timeout < os.clock())then
        self.spells[i] = self.spells[n]
        self.spells[n] = nil
        break
      end
    end
  end
end

function ekko:tick ()
  self.evpoly = clipper.polygon()
end

function ekko:calc_polygons ()
  for i=1,#self.spells do
    local spell = self.spells[i]
    self.evpoly = polygon_helper.AddCircleToPolyGon(self.evpoly,spell.endPos , spell.width, 32)
  end
end

function ekko:get_polygon ()
  return self.evpoly
end


return ekko