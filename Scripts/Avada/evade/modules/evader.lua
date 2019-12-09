local alib = loadmodule("avada_lib")
if(alib.version < 1.0)then
  error("Outdated avada_lib")
end
local common = alib.common
local draw = alib.draw
local missle_handler = loadsubmodule("avada_evade", "modules/missile_handler")
local spell_handler = loadsubmodule("avada_evade", "modules/spell_handler")
local menu = loadsubmodule("avada_evade", "menu")
local polygon_helper = loadsubmodule("avada_evade", "modules/polygon_helper")
local clipper = loadclipper()
local myHero = objmanager.player


evader = common.Class()
function evader:init()
  evader.method = ""
  evader.polygons = clipper.polygons()
  evader.intersections = clipper.polygons()
  evader.evaders = {}
  evader:load_evaders()
  evader:registercallbacks()
  evader.champ_modules = {}
  
  local csm = {
    aatrox = true,
    amumu = true,
    annie = true,
    bard = true,
    brand = true,
    cassiopeia = true,
    chogath = true,
    corki = true,
    darius = true,
    diana = true,
    ekko = true,
    evelynn = true,
    lux = true,
  }
  for i=0,objmanager.enemies_n-1 do
    local hero = objmanager.enemies[i]
    if(csm[hero.charName:lower()])then
      local m = loadsubmodule("avada_evade", "modules/champ_specific_modules/"..hero.charName:lower())
      evader.champ_modules[#evader.champ_modules+1] = m(hero)
    end
  end
end

evader.evade_modules = {"move_to_mouse", "omni_evade"}
function evader:load_evaders(args)
  for i=1,#evader.evade_modules do
    evader.evaders[evader.evade_modules[i]] = loadsubmodule("avada_evade", "modules/evaders/basic/"..evader.evade_modules[i])    
  end
end

function evader:registercallbacks()
  callback.add(enum.callback.draw, evader.tick)
  callback.add(enum.callback.draw, evader.draw)
end

function evader:draw ()
  for i=1, evader.polygons:size() do
    local poly = evader.polygons:get(i)
    for n=1, poly:size() do
      local current = poly:get(n)
      local next = n < poly:size() and poly:get(n+1) or poly:get(1)
      local v_vec = vec3(tonumber(current.x), myHero.y, tonumber(current.y))
      local v_vec_n = vec3(tonumber(next.x), myHero.y, tonumber(next.y))
      if(draw.vec3IsOnScreen(v_vec))then
        glx.world.circle(v_vec, 10, 1, draw.color.white, 32)
      end
      glx.world.line(v_vec, v_vec_n, 1, draw.color.white)
    end
  end
  
  if(evader.intersections)then
    for i=1, evader.intersections:size() do
      local poly = evader.intersections:get(i)
      for n=1, poly:size() do
        local current = poly:get(n)
        local next = n < poly:size() and poly:get(n+1) or poly:get(1)
        local v_vec = vec3(tonumber(current.x), myHero.y, tonumber(current.y))
        local v_vec_n = vec3(tonumber(next.x), myHero.y, tonumber(next.y))
        if(draw.vec3IsOnScreen(v_vec))then
          glx.world.circle(v_vec, 10, 1, draw.color.white, 32)
        end
        glx.world.line(v_vec, v_vec_n, 1, draw.color.red)
      end
    end
  end
end

function evader:tick()
  evader.polygons = clipper.polygons()
  evader.intersections = clipper.polygons()
  evader:missile_getter()
  evader:spell_getter()
  evader:sub_module_getter()
  evader:calculate_attack_poly()
  evader:calculate_current_intersection()
  
  evader:calculate_evade_path()
end

function evader.calculate_current_intersection ()
  evader.intersections = evader.calculate_intersections(myHero, myHero.collisionRadius+menu.mc.myHero.additional_collision_radius:get(), menu.mc.myHero.max_intersection_precision:get())
end

function evader.calculate_intersections (pos, radius, precision)
  if(not evader.polygons or evader.polygons:size() == 0)then return end
  local cl = clipper.new()
  cl:add_subject(evader.polygons)
  cl:add_clip(polygon_helper.AddCircleToPolyGon(clipper.polygon(), pos, radius, precision))
  return cl:execute('intersection')
end

function evader.calculate_attack_poly ()
  if(not evader.polygons or evader.polygons:size() == 0)then return end
  --evader.polygons = evader.polygons:simplify('non_zero')
end

function evader:add_if_on_screen (poly, point)
  if(draw.vec3IsOnScreen(point))then
    poly:add(point.x, point.z)
  end
  return poly
end

function evader:spell_getter ()
  for i=1, #spell_handler.spells do
    local spell = spell_handler.spells[i]
    if(spell)then
      local base_vec = (spell.endPos-spell.startPos):norm()
      
      local right_start = spell.startPos+polygon_helper.RotateVector3(base_vec,90)*spell.width/2
      local left_start = spell.startPos+polygon_helper.RotateVector3(base_vec,-90)*spell.width/2
      
      local right_end = spell.endPos+polygon_helper.RotateVector3(base_vec,90)*spell.width/2
      local left_end = spell.endPos+polygon_helper.RotateVector3(base_vec,-90)*spell.width/2
      
          
      local poly = clipper.polygon()      
      poly:add(right_start.x, right_start.z)
      poly:add(left_start.x, left_start.z)
      poly:add(left_end.x, left_end.z)
      poly:add(right_end.x, right_end.z)
      if(polygon_helper:IsValidPolygon(poly))then 
        evader.polygons:add(poly)
      end
    end
  end
end

function evader:sub_module_getter ()
  for i=1,#evader.champ_modules do
    local module = evader.champ_modules[i]
    local poly = module:get_polygon()
    if(polygon_helper:IsValidPolygon(poly))then
      evader.polygons:add(poly)
    end
  end
end


function evader:missile_getter ()
  local missiles = missle_handler.missiles
  for i=1,#missiles do
    local m = missiles[i]
    local x_vec_pos = vec3(m.pos)
    local x_vec_end = vec3(m.endPos)
    
    local poly = clipper.polygon()
    local poly2 = clipper.polygon()
    poly = polygon_helper.AddCircleToPolyGon(poly, x_vec_pos, m.width, menu.mc.missile.max_polygons:get())
    
    
    local nose_right = x_vec_pos+polygon_helper.RotateVector3((x_vec_end-x_vec_pos):norm(), 90)*m.width
    local nose_left = x_vec_pos+polygon_helper.RotateVector3((x_vec_end-x_vec_pos):norm(), -90)*m.width
    
    --Only add if not over spell_max_range    
    local dst_spell_target = common.GetDistance(m.spell.endPos, m.pos)+m.width
    
    local nose_front_mult = (m.width*menu.mc.missile_getter.nose_w_cone_multiplier:get())*(m.speed*(menu.mc.missile_getter.nose_s_cone_multiplier:get()+menu.mc.missile_getter.nose_add:get())/myHero.moveSpeed)
    local next_pos_mult = (m.width*menu.mc.missile_getter.nose_w_multiplier:get())*(m.speed*(menu.mc.missile_getter.nose_s_multiplier:get()+menu.mc.missile_getter.nose_add:get())/myHero.moveSpeed)
    
    local use_dst = nose_front_mult < dst_spell_target and false or true
    
    nose_front_mult = use_dst and dst_spell_target or nose_front_mult
    next_pos_mult = use_dst and dst_spell_target or next_pos_mult
    
    local nose_front = x_vec_pos+polygon_helper.RotateVector3((x_vec_end-x_vec_pos):norm(), 0)*nose_front_mult
    local next_pos = x_vec_pos+(x_vec_end - x_vec_pos):norm()*next_pos_mult
    local nose_front_right = next_pos+polygon_helper.RotateVector3((x_vec_end-next_pos):norm(),90)*m.width
    local nose_front_left = next_pos+polygon_helper.RotateVector3((x_vec_end-next_pos):norm(),-90)*m.width
    
    if(not use_dst)then
      poly2:add(nose_left.x, nose_left.z)
      poly2:add(nose_right.x, nose_right.z)
      poly2:add(nose_front_right.x, nose_front_right.z)
      poly2:add(nose_front.x, nose_front.z)
      poly2:add(nose_front_left.x, nose_front_left.z)
    else
      poly2:add(nose_left.x, nose_left.z)
      poly2:add(nose_right.x, nose_right.z)
      poly2:add(nose_front_left.x, nose_front_left.z)
      poly2:add(nose_front.x, nose_front.z)
      poly2:add(nose_front_right.x, nose_front_right.z)  
    end
    
    if(polygon_helper:IsValidPolygon(poly) and polygon_helper:IsValidPolygon(poly2))then
      evader.polygons:add(poly)
      evader.polygons:add(poly2)
    end
  end
end

function evader.calculate_evade_path()
  if(not evader.intersections or evader.intersections:size() == 0)then return end
  if(menu.mc.evaders.disable_evasion:get())then return end
  
  evader.evaders[evader.evade_modules[menu.mc.evaders.selected_evader:get()]].run(evader)
end


  




evader.init()
