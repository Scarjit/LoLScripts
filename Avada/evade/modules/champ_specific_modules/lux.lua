local alib = loadmodule("avada_lib")
local common = alib.common
local draw = alib.draw
local polygon_helper = loadsubmodule("avada_evade", "modules/polygon_helper")
local clipper = loadclipper()
local myHero = objmanager.player

lux = common.Class(function (s, hero)
  callback.add(enum.callback.recv.createobj, function  (a,b)
    s:oncreateobj(a,b)
  end)
  callback.add(enum.callback.recv.deleteobj, function  (a,b)
    s:ondeleteobj(a,b)
  end)
  --callback.add(enum.callback.draw, function  ()
    --s:draw()
  --end)
  callback.add(enum.callback.tick, function  ()
    s:tick()
    s:calc_polygons()
  end)
  s.hero = hero
  s.e_objects = {}
  s.evpoly = clipper.polygon()
  print("Loaded lux submodule")
end)

function lux:isValidObject (obj)
  if(obj.team == self.hero.team)then
    return false
  end
  local objname = obj.name
  
  local black_list = {
    "Lux_Base_E_tar_nova.troy",
    "Lux_Base_E_tar_aoe_green.troy",
    "Lux_Base_E_tar_aoe_sound.troy",
    "Lux_Base_E_tar_hit.troy",
  }
  
  for i=1,#black_list do
    if(objname == black_list[i])then
      return false
    end
  end
  
  if(objname:find("Lux_Base_E"))then 
    return true
  end
  
  return false
end

function lux:oncreateobj (obj)
  if(not self:isValidObject(obj))then return false end
  --print("[CREATE] " .. obj.name .. ": [" .. obj.x ..",".. obj.y ..",".. obj.z .. "] " .. tostring(obj.type))
  self.e_objects[obj.ptr] = {obj = obj, tick1 = true, tick2pos = nil, rdy = false}
end

function lux:ondeleteobj (obj)
  if(not self:isValidObject(obj))then return false end
  --print("[DELETE] " .. obj.name .. ": [" .. obj.x ..",".. obj.y ..",".. obj.z .. "] " .. tostring(obj.type))
  self.e_objects[obj.ptr] = nil
end

function lux:tick ()
  for k,v in pairs(self.e_objects) do
    if(v.tick1)then
      self.e_objects[k].tick1 = false
    elseif(not v.tick2pos)then
      self.e_objects[k].tick2pos = vec3(v.obj.pos.x,v.obj.pos.y,v.obj.pos.z)
    else
      if(v.obj.pos.x ~= v.tick2pos.x or v.obj.pos.y ~= v.tick2pos.y)then
        self.e_objects[k] = nil
        break
      else
        self.e_objects[k].rdy = true
      end
    end
  end
end

function lux:calc_polygons ()
  self.evpoly = clipper.polygon()
  for k,v in pairs(self.e_objects) do
    if(v.rdy)then
      self.evpoly = polygon_helper.AddCircleToPolyGon(self.evpoly, v.obj.pos, 350, 32)
    end
  end
end

function lux:draw ()
  for i=1,self.evpoly:size() do
    local point = self.evpoly:get(i)
    local v3 = vec3(point.x, self.hero.pos.y, point.y)
    glx.world.circle(v3, 10, 1, draw.color.blue, 32)
  end
end

function lux:get_polygon ()
  return self.evpoly
end


return lux