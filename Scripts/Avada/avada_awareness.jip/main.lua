local version = "1.02"

local menu = menuconfig("aawareness", "Avada Awareness")
menu:boolean("HealthBarDrawer_load", "Draw Health Bar Infos", true)
menu:boolean("HUDDrawer_load", "Draw Advanced HUD", true)
-- menu:boolean("JunglerTracker_load", "Draw Jungler Ganks Alert", true)
-- menu:boolean("ObjectivesTracker_load", "Draw Objectives Alert (Dragon/Baron/Herald)", true)
menu:boolean("RecallTracker_load", "Draw Ennemy Recalls / Teleports", true)
menu:boolean("PathDrawer_load", "Draw Path of Ennemies", true)
-- menu:boolean("WardsTracker_load", "Draw Enemy Wards", true)
-- menu:boolean("TowerRangeDrawer_load", "Draw Tower Range", true)

local HealthBarDrawer = loadsubmodule("avadaawareness", "HealthBarDrawer")
HealthBarDrawer(menu.HealthBarDrawer_load:get())
menu.HealthBarDrawer_load:set('callback', function(newValue, oldValue) HealthBarDrawer(oldValue) end)

local HUDDrawer = loadsubmodule("avadaawareness", "HUDDrawer")
HUDDrawer(menu.HUDDrawer_load:get())
menu.HUDDrawer_load:set('callback', function(newValue, oldValue) HUDDrawer(oldValue) end)

-- local JunglerTracker = loadsubmodule("avadaawareness", "JunglerTracker")
-- JunglerTracker(menu.JunglerTracker_load:get())
-- menu.JunglerTracker_load:set('callback', function(newValue, oldValue) JunglerTracker(oldValue) end)

-- local ObjectivesTracker = loadsubmodule("avadaawareness", "ObjectivesTracker")
-- ObjectivesTracker(menu.ObjectivesTracker_load:get())
-- menu.ObjectivesTracker_load:set('callback', function(newValue, oldValue) ObjectivesTracker(oldValue) end)

local RecallTracker = loadsubmodule("avadaawareness", "RecallTracker")
RecallTracker(menu.RecallTracker_load:get())
menu.RecallTracker_load:set('callback', function(newValue, oldValue) RecallTracker(oldValue) end)

local PathDrawer = loadsubmodule("avadaawareness", "PathDrawer")
PathDrawer(menu.PathDrawer_load:get())
menu.PathDrawer_load:set('callback', function(newValue, oldValue) PathDrawer(oldValue) end)

-- local WardsTracker = loadsubmodule("avadaawareness", "WardsTracker")
-- WardsTracker(menu.WardsTracker_load:get())
-- menu.WardsTracker_load:set('callback', function(newValue, oldValue) WardsTracker(oldValue) end)

-- local TowerRangeDrawer = loadsubmodule("avadaawareness", "TowerRangeDrawer")
-- TowerRangeDrawer(menu.TowerRangeDrawer_load:get())
-- menu.TowerRangeDrawer_load:set('callback', function(newValue, oldValue) TowerRangeDrawer(oldValue) end)


print("Avada Awareness "..version..": Loaded")