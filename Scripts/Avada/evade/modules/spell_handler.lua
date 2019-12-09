local alib = loadmodule("avada_lib")
local common = alib.common
local draw = alib.draw
local menu = loadsubmodule("avada_evade", "menu")
myHero = objmanager.player


sh = common.Class()
function sh:init ()
  sh:registercallbacks()
  sh.spells = {}
end


function sh:registercallbacks ()
  callback.add(enum.callback.recv.spell, function  (a)
    sh:recvspell(a)
  end)
  
  callback.add(enum.callback.tick, sh.deletespell)
end

function sh:IsValidSpell (spell)
  if(spell.isBasicAttack)then return false end
  if(spell.owner.team == myHero.team)then return false end
  if(spell.owner.type ~= myHero.type)then return false end
  if(spell.data.width == 0)then 
    local range = common.GetDistance(spell.startPos, spell.endPos)
    print("RecvSpell2: " .. spell.data.name .. " id:" .. spell.identifier .. " ptr: ".. spell.ptr .. " width: " .. spell.data.width .. " speed: " .. spell.data.speed .. " range: " .. range .. " windup: " .. spell.windUpTime)
    return false 
  end
  
  return true
end

function sh:recvspell (spell)
  if(not sh:IsValidSpell(spell)) then return end
  local range = common.GetDistance(spell.startPos, spell.endPos)
  print("RecvSpell: " .. spell.data.name .. " id:" .. spell.identifier .. " ptr: ".. spell.ptr .. " width: " .. spell.data.width .. " speed: " .. spell.data.speed .. " range: " .. range .. " windup: " .. spell.windUpTime)

  local timeout = os.clock() + spell.windUpTime + (menu.mc.spell_handler.add_range_div_speed:get() and (range/spell.data.speed) or 0)
  sh.spells[#sh.spells+1] = {timeout = timeout, time = os.clock(), width = spell.data.width, speed = spell.data.speed, range = range, windUpTime = spell.windUpTime, startPos = vec3(spell.startPos.x,spell.startPos.y,spell.startPos.z), endPos = vec3(spell.endPos.x,spell.endPos.y,spell.endPos.z)}
end

function sh.deletespell ()
  if(myHero.isDead)then
    sh.spells = {}
  else
    local n = #sh.spells
    for i=1,n do
      local spell = sh.spells[i]
      
      if(spell.timeout < os.clock())then
        sh.spells[i] = sh.spells[n]
        sh.spells[n] = nil
        break
      end
    end
  end
end

sh.init()
return sh