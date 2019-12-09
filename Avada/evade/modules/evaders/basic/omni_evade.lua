local alib = loadmodule("avada_lib")
local common = alib.common
local draw = alib.draw
local menu = loadsubmodule("avada_evade", "menu")
local polygon_helper = loadsubmodule("avada_evade", "modules/polygon_helper")
local clipper = loadclipper()
local myHero = objmanager.player

omni_evade = {}
function omni_evade.run (evader)
  local mypos = myHero.pos
  local endPos = nil
  if(menu.mc.evaders.omni_evade.use_full_distance:get())then
      endPos = mypos+(game.mousePos-mypos):norm()*common.GetDistance(mypos, game.mousePos)  
  else
    endPos = mypos+(game.mousePos-mypos):norm()*menu.mc.evaders.omni_evade.force_distance:get()
  end
  local current_hits = evader.intersections:get(1):size()
    
  local current_intersections = evader.intersections
  local distance = common.GetDistance(mypos, endPos)  
  local precision = math.floor(distance/menu.mc.evaders.omni_evade.precision_divisor:get())
  local vec_mult = distance/precision
  local base_vec = (endPos - mypos):norm()

  
  local max_width = menu.mc.evaders.omni_evade.max_width:get()
  local best_rotation = math.huge
  local steps = math.huge
  
  
  for n=max_width*-1,max_width,menu.mc.evaders.omni_evade.n_step_witdh:get() do
    local steps_s = 0
    mbase_vec = polygon_helper.RotateVector3(base_vec, n)
    
    for i=1,precision do
      local c_vec = mypos + mbase_vec*(vec_mult*i)
      local points = evader.calculate_intersections(c_vec, myHero.collisionRadius+menu.mc.myHero.additional_collision_radius:get(), menu.mc.evaders.omni_evade.max_intersection_precision:get())
      local c_hits = (points:size() == 0 and 0 or points:get(1):size())      
      if(c_hits >=  menu.mc.evaders.omni_evade.max_intersection_precision:get())then  
        steps_s = math.huge
        break
      elseif(c_hits > 0)then
        steps_s = steps_s + 1
      end
    end
    
    if(steps_s < steps)then
      best_rotation = n
      steps = steps_s
    end
  end
  
  mbase_vec = polygon_helper.RotateVector3(base_vec, best_rotation)
  local c_vec = mypos + mbase_vec*(distance)
    
  glx.world.circle(c_vec, 10, 1, draw.color.gold, 64)
  
  game.issue("move", c_vec)
  
  evader.method = "omni_evade"
  return true
end
return omni_evade