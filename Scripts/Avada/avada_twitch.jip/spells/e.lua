local alib = loadmodule("avada_lib")
local common = alib.common

local orb = loadorbwalker()

local player = objmanager.player
local isExhausted = false
local hasLament = false

local e = {
  slot = player:spellslotcast(2),
  range = 1200,
  last = 0,
  stacks = {},
  base_damage = { 20, 35, 50, 65, 80 },
  stack_damage = { 15, 20, 25, 30, 35 },
}

e.is_ready = function()
  return e.slot.state == 0
end

e.invoke_action = function()
  game.cast("self", 2)
  orb.core.set_server_pause()
end

e.get_prediction = function()
  if e.last == game.time then
    return e.result
  end
  e.last = game.time
  e.result = nil
  
  for i, enemy in pairs(e.stacks) do
    if enemy.obj and enemy.obj.type == enum.type.hero and not enemy.obj.isDead then
      if common.GetDistance(player, enemy.obj) < e.range then
		local e_spell_damage = e.base_damage[e.slot.level] + ((e.stack_damage[e.slot.level] + ((player.ap * player.apMod) * 0.2) + (player.bonusAD * 0.25)) * enemy.stacks)
		local damage = e.adjust_damage((e_spell_damage * common.DamageReduction(enemy.obj)))
        if damage >= (enemy.obj.health + enemy.obj.physicalShield) then
          e.result = enemy.obj
        end
      end
    end
  end
  
  return e.result
end

e.get_prediction_after_aa = function()
  e.result_after_aa = nil
  
  for i, enemy in pairs(e.stacks) do
	if enemy.obj and enemy.obj.type == enum.type.hero and not enemy.obj.isDead then
	  local aa_dmg = e.adjust_damage(((player.baseAD + player.bonusAD) * common.DamageReduction(enemy.obj)))
	  local e_spell_damage = e.base_damage[e.slot.level] + ((e.stack_damage[e.slot.level] + ((player.ap * player.apMod) * 0.2) + (player.bonusAD * 0.25)) * enemy.stacks)
	  local damage = aa_dmg + e.adjust_damage((e_spell_damage * common.DamageReduction(enemy.obj)))
	  if damage >= (enemy.obj.health + enemy.obj.physicalShield) then
		e.result_after_aa = enemy.obj
	  end
	end
  end
  
  return e.result_after_aa
end

e.adjust_damage = function(temp)
  if isExhausted then
    temp = temp * 0.6
  end
  if hasLament then
    temp = temp * 0.88
  end
  
  return temp
end

e.on_load = function()
  for i = 0, objmanager.enemies_n - 1 do
    local obj = objmanager.enemies[i]
    e.stacks[obj.networkID] = nil
  end
end

e.on_update_buff = function(buff, causer)
  if causer == player then
	if not isExhausted and buff.name == "SummonerExhaust" then
	  isExhausted = true
	elseif not hasLament and buff.name == "itemphantomdancerdebuff" then
	  hasLament = true
	end
  elseif buff and buff.valid and buff.name == "TwitchDeadlyVenom" and not buff.owner.isDead then
	  e.stacks[buff.owner.networkID] = { obj = buff.owner, stacks = math.min(6, buff.stacks2 + 1) }
  end
end

e.on_remove_buff = function(buff)
  local target = buff.owner
  if target == player then
	if buff.name == "SummonerExhaust" then
	  isExhausted = false
	elseif buff.name == "itemphantomdancerdebuff" then
	  hasLament = false
	end
  elseif buff and buff.valid and buff.name == "TwitchDeadlyVenom" and e.stacks[target.networkID] ~= nil then
	e.stacks[target.networkID] = nil
  end
end

e.on_delete_obj = function(obj)
  if obj and obj.valid and e.stacks[obj.networkID] ~= nil then
	e.stacks[obj.networkID] = nil
  end
end

e.draw = function()
  if e.slot.level > 0 then
    glx.world.drawCircle(objmanager.player.pos, e.range, 2, glx.argb(255, 255, 255, 255), 44)
  end
end

return e