--CassiopeiaQ

local alib = loadmodule("avada_lib")
local common = alib.common
local draw = alib.draw
local polygon_helper = loadsubmodule("avada_evade", "modules/polygon_helper")
local clipper = loadclipper()
local myHero = objmanager.player

cassiopeia = common.Class(function (s, hero)
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
  print("Loaded cassiopeia submodule")
end)

function cassiopeia:IsValidSpell (spell)
  if(spell.isBasicAttack)then return false end
  if(spell.owner.team == myHero.team)then return false end
  if(spell.owner.type ~= myHero.type)then return false end
  if(spell.name == "CassiopeiaQ")then return true end
  return false
end

function cassiopeia:recvspell (spell)
  if(not self:IsValidSpell(spell)) then return end
  local timeout = os.clock() + spell.windUpTime
  self.spells[#self.spells+1] = {timeout = timeout, time = os.clock(), width = 150, endPos = vec3(spell.endPos.x,spell.endPos.y,spell.endPos.z)}
end

function cassiopeia:deletespell ()
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

function cassiopeia:tick ()
  self.evpoly = clipper.polygon()
end

function cassiopeia:calc_polygons ()
  for i=1,#self.spells do
    local spell = self.spells[i]
    self.evpoly = polygon_helper.AddCircleToPolyGon(self.evpoly,spell.endPos , spell.width, 32)
  end
end

function cassiopeia:get_polygon ()
  return self.evpoly
end


return cassiopeia