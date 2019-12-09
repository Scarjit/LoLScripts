local orb = loadorbwalker()

local menu = loadsubmodule("avadatwitch", "menu")

local q = loadsubmodule("avadatwitch", "spells/q")
local w = loadsubmodule("avadatwitch", "spells/w")
local e = loadsubmodule("avadatwitch", "spells/e")
local r = loadsubmodule("avadatwitch", "spells/r")

local player = objmanager.player

local core = {
  on_end_func = nil,
  on_end_time = 0,
  f_spell_map = {},
}

core.on_after_attack = function()
  if e.is_ready() then
    if e.get_prediction_after_aa() then
      e.invoke_action()
      return "on_after_attack_e"
    end
  end
  orb.combat.set_invoke_after_attack(false)
end

core.on_out_of_range = function()
  
end

core.on_end_w = function()
  core.on_end_func = nil
  orb.core.set_pause(0)
end

core.on_end_e = function()
  core.on_end_func = nil
  orb.core.set_pause(0)
end

core.on_cast_w = function(spell)
  if os.clock() + spell.windUpTime > core.on_end_time then
    core.on_end_func = core.on_end_w
    core.on_end_time = os.clock() + spell.windUpTime
    orb.core.set_pause(math.huge)
  end
end

core.on_cast_e = function(spell)
  if os.clock() + spell.windUpTime > core.on_end_time then
    core.on_end_func = core.on_end_e
    core.on_end_time = os.clock() + spell.windUpTime
    orb.core.set_pause(math.huge)
  end
end

core.get_action = function()
  if core.on_end_func then
    if os.clock() + network.latency > core.on_end_time then
      core.on_end_func()
    end
  end
  if e.is_ready() then
    if e.get_prediction() then
      e.invoke_action()
      --return "on_after_attack_e"
    end
  end
end

core.on_recv_spell = function(spell)
  if spell.owner == player then
    if core.f_spell_map[spell.data.name] then
      core.f_spell_map[spell.data.name](spell)
    end
  end
end

core.f_spell_map["TwitchVenomCask"] = core.on_cast_w
core.f_spell_map["TwitchExpunge"] = core.on_cast_e

orb.combat.register_f_after_attack(core.on_after_attack)
orb.combat.register_f_out_of_range(core.on_out_of_range)

return core