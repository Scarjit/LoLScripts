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