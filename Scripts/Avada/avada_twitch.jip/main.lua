local orb = loadorbwalker() --loadmodule("generic_orbwalker") -- load orb after your tick

local menu = loadsubmodule("avadatwitch", "menu")
local core = loadsubmodule("avadatwitch", "core")

local e = loadsubmodule("avadatwitch", "spells/e")

print("Orbwalker combat key overwritten by Lucian combat key.")
--overwrite orbwalkers combat key with lucians combat key

local function on_tick()
  core.get_action()
end
orb.combat.register_f_pre_tick(on_tick)
--because the core locks and unlocks the orbwalker, 
--we have the tick bound to be pre the orbwalks tick so that after unlocking the orbwalker, 
--the orbwalk tick gets executed right away instead of waiting for the next tick

local function on_load()
  e.on_load()
end

local function on_recv_spell(spell)
  core.on_recv_spell(spell)
end

local function on_update_buff(buff, causer)
  e.on_update_buff(buff, causer)
end

local function on_remove_buff(buff)
  e.on_remove_buff(buff)
end

local function on_delete_obj(obj)
  e.on_delete_obj(obj)
end

local function on_draw()
  if menu.draw_e_range:get() then
    e.draw()
  end
end

callback.add(enum.callback.load, on_load)
callback.add(enum.callback.recv.spell, on_recv_spell)
callback.add(enum.callback.recv.updatebuff, on_update_buff)
callback.add(enum.callback.recv.removebuff, on_remove_buff)
callback.add(enum.callback.recv.deleteobj, on_delete_obj)
callback.add(enum.callback.draw, on_draw)

print("Twitch loaded.")

return {}