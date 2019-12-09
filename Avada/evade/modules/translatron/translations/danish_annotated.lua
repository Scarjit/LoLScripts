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