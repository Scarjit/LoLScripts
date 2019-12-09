local alib = loadmodule("avada_lib")
local common = alib.common

translatron = common.Class()

translatron.languages = {
  "english",
  "french",
  "danish",
  --"german",
  
}
translatron.translations = {
  english = {
    debug = "Debug",
    
    myHero_submenu_header = "[myHero]",
    myHero_additional_collision_radius = "Additional collision radius",
    myHero_max_intersection_precision = "Max collision intersections",
    
    missile_submenu_header = "[Missile]",
    missile_max_polygons = "Max collision polygons",
    
    spell_handler_submenu_header = "[Spell Handler]",
    spell_handler_add_range_div_speed = "Add Range/Speed to spell timeout",
    
    missile_getter_submenu_header = "[Missile Handler]",
    missile_getter_nose_s_cone_multiplier = "Nose cone speed multiplier",
    missile_getter_nose_s_multiplier = "Nose speed multiplier",
    missile_getter_nose_w_cone_multiplier = "Nose cone width multiplier",
    missile_getter_nose_w_multiplier = "Nose cone width multiplier",
    missile_getter_nose_add = "Nose additional factor",
    
    evaders_submenu_header = "[Evader Modules]",
    evaders_select_evader = "Select Module",
    evaders_disable_evasion = "Disable Evasion",
    
    mouve_to_mouse_submenu_header = "[Move to mouse]",
    mouve_to_mouse_precision_divisor = "Search steps",
    mouve_to_mouse_max_width = "Max search angle",
    mouve_to_mouse_n_step_witdh = "Search angle steps",
    mouve_to_mouse_max_intersection_precision = "Max collision intersections",
    mouve_to_mouse_force_distance = "Max checked distance",
    mouve_to_mouse_use_full_distance = "Use full distance",
    
    omni_evade_submenu_header = "[Omni Evade]",
    omni_evade_precision_divisor = "Search steps",
    omni_evade_max_width = "Max search angle",
    omni_evade_n_step_witdh = "Search angle steps",
    omni_evade_max_intersection_precision = "Max collision intersections",
    omni_evade_force_distance = "Max checked distance",
    omni_evade_use_full_distance = "Use full distance",
  },
  french = {
    debug = "Debug", --Enables debug menus
    
    myHero_submenu_header = "[Mon Champion]",
    myHero_additional_collision_radius = "Rayon additionel autour de moi", -- Additional collision radius around myHero
    myHero_max_intersection_precision = "Précision de la détection", -- Max circles to check for collision
    
    missile_submenu_header = "[Missile]", 
    missile_max_polygons = "Nombre maximum de polygones", -- Max polygons for missiles (more == better circles)
    
    spell_handler_submenu_header = "[Gestionnaire de Sorts]",
    spell_handler_add_range_div_speed = "Continuer à dodge tant que le sort est proche", --Added spell.range / spell.speed to the spell removal timeout
    
    missile_getter_submenu_header = "[Gestionnaire de Missiles]",
    missile_getter_nose_s_cone_multiplier = "Augmenter l'angle de la détection (% vitesse)", -- Increase to enlenghten the missiles nose cone based on missile speed
    missile_getter_nose_s_multiplier = "Augmenter la longeur de la détection (% vitesse)", -- Increase to enlenghten the missiles nose based on missile speed
    missile_getter_nose_w_cone_multiplier = "Augmenter l'angle de la détection (% largeur)", -- Increase to enlenghten the missiles nose based on missile width
    missile_getter_nose_w_multiplier = "Augmenter la longeur de la détection (% largeur)", -- Increase to enlenghten the missiles nose cone based on missile width
    missile_getter_nose_add = "Augmenter la taille de la détection", -- Add X to nose lenght
    
    evaders_submenu_header = "[Modules d'Evade]",
    evaders_select_evader = "Choisir un module", -- Selector for an evasion module (see below)
    evaders_disable_evasion = "Désactiver l'évasion",
    
    mouve_to_mouse_submenu_header = "[Evade vers la souris]", --Tries to evade towards the mouse
    mouve_to_mouse_precision_divisor = "Nombre maximum de points", -- Max pathfinding steps
    mouve_to_mouse_max_width = "Angle maximum de recherche", -- Max angle to search new paths (calculated from the normalized vector of myHero.pos and mousePos)
    mouve_to_mouse_n_step_witdh = "Angle maximum pour chaque point", -- Angle stepping (increase finds better paths, but draws fps)
    mouve_to_mouse_max_intersection_precision = "Précision à chaque point", -- Max circles to check for collision (at each step)
    mouve_to_mouse_force_distance = "Distance maximum de la recherche", -- Max distance to calculate the path to (useless, if below is active)
    mouve_to_mouse_use_full_distance = "Chercher jusqu'à la souris", -- Calculate path for the full distance to the mouse Pos
    
    omni_evade_submenu_header = "[Evade classique]", -- Just tries to evade
    omni_evade_precision_divisor = "Nombre maximum de points", -- Max pathfinding steps
    omni_evade_max_width = "Angle maximum de recherche", -- Max angle to search new paths (calculated from the normalized vector of myHero.pos and mousePos)
    omni_evade_n_step_witdh = "Angle maximum pour chaque point", -- Angle stepping (increase finds better paths, but draws fps)
    omni_evade_max_intersection_precision = "Précision à chaque point", -- Max circles to check for collision (at each step)
    omni_evade_force_distance = "Distance maximum de la recherche", -- Max distance to calculate the path to (useless, if below is active)
    omni_evade_use_full_distance = "Chercher jusqu'à la souris", -- Calculate path for the full distance to the mouse Pos
  },
  danish = {
      debug = "Debug", --Enables debug menus
      
      myHero_submenu_header = "[myHero]",
      myHero_additional_collision_radius = "Ekstra kollisions radius", -- Additional collision radius around myHero
      myHero_max_intersection_precision = "Maks kollisionskrydsninger", -- Max circles to check for collision
      
      missile_submenu_header = "[Missile]", 
      missile_max_polygons = "Maks kollisions polygoner", -- Max polygons for missiles (more == better circles)
      
      spell_handler_submenu_header = "[Spell Handler]",
      spell_handler_add_range_div_speed = "Tilf�j afstand/hastighed til spell timeout", --Added spell.range / spell.speed to the spell removal timeout
      
      missile_getter_submenu_header = "[Missile Handler]",
      missile_getter_nose_s_cone_multiplier = "N�se kegle hastighed multiplikator", -- Increase to enlenghten the missiles nose cone based on missile speed
      missile_getter_nose_s_multiplier = "N�se hastigheds multiplikator", -- Increase to enlenghten the missiles nose based on missile speed
      missile_getter_nose_w_cone_multiplier = "N�se kegle bredde multiplikator", -- Increase to enlenghten the missiles nose based on missile width
      missile_getter_nose_w_multiplier = "N�se kegle bredde multiplikator", -- Increase to enlenghten the missiles nose cone based on missile width
      missile_getter_nose_add = "N�ste ekstra faktor", -- Add X to nose lenght
      
      evaders_submenu_header = "[Evader Modules]",
      evaders_select_evader = "V�lg Modul", -- Selector for an evasion module (see below)
      evaders_disable_evasion = "Deaktiver unddragelse",
      
      mouve_to_mouse_submenu_header = "[Bev�g til mus]", --Tries to evade towards the mouse
      mouve_to_mouse_precision_divisor = "S�g skridt", -- Max pathfinding steps
      mouve_to_mouse_max_width = "Maks s�g vinkel", -- Max angle to search new paths (calculated from the normalized vector of myHero.pos and mousePos)
      mouve_to_mouse_n_step_witdh = "S�g vinkel skridt", -- Angle stepping (increase finds better paths, but draws fps)
      mouve_to_mouse_max_intersection_precision = "Maks kollisions krydsninger", -- Max circles to check for collision (at each step)
      mouve_to_mouse_force_distance = "Maks kontrolleret afstand", -- Max distance to calculate the path to (useless, if below is active)
      mouve_to_mouse_use_full_distance = "Brug fuld afstand", -- Calculate path for the full distance to the mouse Pos
      
      omni_evade_submenu_header = "[Omni Evade]", -- Just tries to evade
      omni_evade_precision_divisor = "S�g skridt", -- Max pathfinding steps
      omni_evade_max_width = "Maks s�g vinkel", -- Max angle to search new paths (calculated from the normalized vector of myHero.pos and mousePos)
      omni_evade_n_step_witdh = "S�g vinkel skridt", -- Angle stepping (increase finds better paths, but draws fps)
      omni_evade_max_intersection_precision = "Maks kollisions krydsninger", -- Max circles to check for collision (at each step)
      omni_evade_force_distance = "Maks kontrolleret afstand", -- Max distance to calculate the path to (useless, if below is active)
      omni_evade_use_full_distance = "Brug fuld afstand", -- Calculate path for the full distance to the mouse Pos
    },
    
    
}

function translatron:init (menu)
  translatron.menu = menu
  translatron.language = "english" --fallback
  translatron:create_menu()
  translatron.language = translatron.languages[translatron.menu.lang:get()]
end

function translatron:create_menu()
  translatron.menu:menu("translatron", "Language Settings")
  translatron.menu = translatron.menu.translatron
  translatron.menu:dropdown("lang", "Language", 1, translatron.languages)
  translatron.menu.lang:set('callback', function  (a,b)
      translatron:language_changed(a,b)
  end)
end

function translatron:language_changed(old,new)
  translatron.language = translatron.languages[b]
end

function translatron:get_translation (id)
  return translatron.translations[translatron.language][id] ~= nil and translatron.translations[translatron.language][id] or (translatron.translations["english"][id] ~= nil and translatron.translations["english"][id] or id)
end



return translatron