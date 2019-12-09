common = loadmodule("avada_lib").common
myHero = objmanager.player


mh = common.Class()
function mh:init ()
  mh:registercallbacks()
  mh.missiles = {}
end

function mh:registercallbacks ()
  callback.add(enum.callback.recv.missile, function  (a)
    mh:recvmissile(a)
  end)
  
  callback.add(enum.callback.recv.deleteobj, function  (a)
    mh:deleteobj(a)
  end)
end

function mh:deleteobj (obj)
  local n = #mh.missiles
  for i=1,n do
    if(mh.missiles[i].ptr == obj.ptr)then
      print("Deleted missile " .. tostring(mh.missiles[i].ptr))
      mh.missiles[i] = mh.missiles[n]
      mh.missiles[n] = nil
      break
    end
  end
end

mh.missile_name_blacklist = {
  "dummy",
  "vfx",
}

function mh:IsValidmissile (missile)
  if(not missile.valid)then return false end
  if(missile.isBasicAttack)then return false end
  if(missile.owner.team == myHero.team)then return false end
  if(missile.owner.type ~= myHero.type)then return false end
  if(missile.width == 0)then return false end
  
  local name = missile.name:lower()
  for i=1,#mh.missile_name_blacklist do
    if(string.find(name, mh.missile_name_blacklist[i]))then
      return false
    end
  end
  
  return true
end

function mh:recvmissile (missile)
  if(not mh:IsValidmissile(missile))then return end
  print("Registered missile " .. tostring(missile.ptr) .. " width: " .. missile.width .. " slot: " .. missile.slot .. " name: " .. missile.name .. " speed:" .. missile.speed)
  mh.missiles[#mh.missiles+1] = missile
end

mh.init()
return mh