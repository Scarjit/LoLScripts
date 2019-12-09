local alib = loadmodule("avada_lib")
local common = alib.common
local draw = alib.draw
local menu = loadsubmodule("avada_evade", "menu")
local polygon_helper = loadsubmodule("avada_evade", "modules/polygon_helper")
local clipper = loadclipper()
local myHero = objmanager.player

local mouve_to_mouse =  {}
function mouve_to_mouse.run (evader)
  local mypos = myHero.pos
  
  
  local endPos = nil
  if(menu.mc.evaders.omni_evade.use_full_distance:get())then
      endPos = mypos+(game.mousePos-mypos):norm()*common.GetDistance(mypos, game.mousePos)  
  else
    endPos = mypos+(game.mousePos-mypos):norm()*menu.mc.evaders.mouve_to_mouse.force_distance:get()
  end
  
  local current_hits = evader.intersections:get(1):size()

  --Calc hits at mousePos
  local points_mp = evader.calculate_intersections(endPos, myHero.collisionRadius+menu.mc.myHero.additional_collision_radius:get(), menu.mc.evaders.mouve_to_mouse.max_intersection_precision:get())
  local c_hits_mp = (points_mp:size() == 0 and 0 or points_mp:get(1):size())

  if(c_hits_mp >= current_hits)then
    return false
  end

  local current_intersections = evader.intersections
  local distance = common.GetDistance(mypos, endPos)  
  local precision = math.floor(distance/menu.mc.evaders.mouve_to_mouse.precision_divisor:get())
  local vec_mult = distance/precision
  local base_vec = (endPos - mypos):norm()


  local max_width = menu.mc.evaders.mouve_to_mouse.max_width:get()
  local best_rotation = math.huge
  local min_hits = math.huge


  for n=max_width*-1,max_width,menu.mc.evaders.mouve_to_mouse.n_step_witdh:get() do
    local hits = 0
    local steps_with_hits = 0
    mbase_vec = polygon_helper.RotateVector3(base_vec, n)
    
    for i=1,precision do
      local c_vec = mypos + mbase_vec*(vec_mult*i)         
      local points = evader.calculate_intersections(c_vec, myHero.collisionRadius+menu.mc.myHero.additional_collision_radius:get(), menu.mc.evaders.mouve_to_mouse.max_intersection_precision:get())
      local c_hits = (points:size() == 0 and 0 or points:get(1):size())      
      if(c_hits >=  menu.mc.evaders.mouve_to_mouse.max_intersection_precision:get())then  
        hits = math.huge
        break
      else
        hits = hits + c_hits
        steps_with_hits = steps_with_hits + 1
      end
    end
    
    if(hits*steps_with_hits < min_hits)then
      best_rotation = n
      min_hits = hits
    end
  end

  mbase_vec = polygon_helper.RotateVector3(base_vec, best_rotation)
  local c_vec = mypos + mbase_vec*(distance)
  game.issue("move", c_vec)

  evader.method = "mouve_to_mouse"
  return true
end

return mouve_to_mouse