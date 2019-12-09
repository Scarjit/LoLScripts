local alib = loadmodule("avada_lib")
local common = alib.common

local translatron = loadsubmodule("avada_evade","modules/translatron/translatron")

menu = common.Class()

function menu:init ()
  menu.mc = menuconfig("avada_evade", "Avada Evade")
  
  translatron:init(menu.mc)
  menu:create_menu()
end

function menu:create_menu ()
  menu:myHeroMenu()
  menu:missileMenu()
  menu:spellhandlerMenu()
  menu:missilegetterMenu()
  
  menu:evadersMenu()
  
  menu.mc:boolean("debug", translatron:get_translation("debug"), false)
  
  --cls
  menu.mc:boolean("cls", translatron:get_translation("cls"), false)
  menu.mc.cls:set('callback', function  (old, new)
    if(new == true)then
      for i=1,250 do
        print("")
      end
      menu.mc.cls:set('value', false)
    end
  end)
end

function menu:myHeroMenu ()
  menu.mc:menu("myHero", translatron:get_translation("myHero_submenu_header"))
  local m = menu.mc.myHero
  m:slider("additional_collision_radius", translatron:get_translation("myHero_additional_collision_radius"), 20, 0, 100, 1)
  m:slider("max_intersection_precision", translatron:get_translation("myHero_max_intersection_precision"), 32, 4, 128, 2)
end

function menu:missileMenu ()
  menu.mc:menu("missile", translatron:get_translation("missile_submenu_header"))
  local m = menu.mc.missile
  m:slider("max_polygons", translatron:get_translation("missile_max_polygons"), 12, 4, 200, 1)
end

function menu:spellhandlerMenu ()
  menu.mc:menu("spell_handler", translatron:get_translation("spell_handler_submenu_header"))
  local m = menu.mc.spell_handler
  m:boolean("add_range_div_speed", translatron:get_translation("spell_handler_add_range_div_speed"), true)
end

function menu:missilegetterMenu ()
  menu.mc:menu("missile_getter", translatron:get_translation("missile_getter_submenu_header"))
  local m = menu.mc.missile_getter
  m:slider("nose_s_cone_multiplier", translatron:get_translation("missile_getter_nose_s_cone_multiplier"), 19, 0, 200, 1)
  m:slider("nose_s_multiplier", translatron:get_translation("missile_getter_nose_s_multiplier"), 9, 0, 200, 1)
  m:slider("nose_w_cone_multiplier", translatron:get_translation("missile_getter_nose_w_cone_multiplier"), 5, 0, 200, 1)
  m:slider("nose_w_multiplier", translatron:get_translation("missile_getter_nose_w_multiplier"), 2, 0, 200, 1)
  m:slider("nose_add", translatron:get_translation("missile_getter_nose_add"), 20, 0, 200, 1)
end

--[[

  Evasion modules submenus

--]]

function menu:evadersMenu ()
  menu.mc:menu("evaders", translatron:get_translation("evaders_submenu_header"))
  local m = menu.mc.evaders
  
  menu:evaders_move_to_mouseMenu(m)
  menu:evaders_omni_evade(m)
  
  m:boolean("disable_evasion", translatron:get_translation("evaders_disable_evasion"), false)
  m:dropdown("selected_evader", translatron:get_translation("evaders_select_evader"), 2, {"move_to_mouse", "omni_evade"})
end

function menu:evaders_move_to_mouseMenu (m)
  m:menu("mouve_to_mouse", translatron:get_translation("mouve_to_mouse_submenu_header"))
  m = m.mouve_to_mouse
  m:slider("precision_divisor", translatron:get_translation("mouve_to_mouse_precision_divisor"), 20, 0, 200, 1)
  m:slider("max_width", translatron:get_translation("mouve_to_mouse_max_width"), 20, 0, 200, 1)
  m:slider("n_step_witdh", translatron:get_translation("mouve_to_mouse_n_step_witdh"), 20, 0, 200, 1)
  m:slider("max_intersection_precision", translatron:get_translation("mouve_to_mouse_max_intersection_precision"), 20, 0, 200, 1)
  m:slider("force_distance", translatron:get_translation("mouve_to_mouse_force_distance"), 20, 0, 200, 1)
  m:boolean("use_full_distance", translatron:get_translation("mouve_to_mouse_use_full_distance"), false)
end

function menu:evaders_omni_evade (m)
  m:menu("omni_evade", translatron:get_translation("omni_evade_submenu_header"))
  m = m.omni_evade
  m:slider("precision_divisor", translatron:get_translation("omni_evade_precision_divisor"), 20, 0, 200, 1)
  m:slider("max_width", translatron:get_translation("omni_evade_max_width"), 90, 0, 200, 1)
  m:slider("n_step_witdh", translatron:get_translation("omni_evade_n_step_witdh"), 20, 0, 200, 1)
  m:slider("max_intersection_precision", translatron:get_translation("omni_evade_max_intersection_precision"), 20, 0, 200, 1)
  m:slider("force_distance", translatron:get_translation("omni_evade_force_distance"), 20, 0, 200, 1)
  m:boolean("use_full_distance", translatron:get_translation("omni_evade_use_full_distance"), true)
end



menu.init()
return menu










