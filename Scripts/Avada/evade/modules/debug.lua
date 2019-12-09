menu = loadsubmodule("avada_evade", "menu")

if(menu.mc.debug:get() == false)then return end

common = loadmodule("avada_lib").common
missle_handler = loadsubmodule("avada_evade", "modules/missile_handler")
myHero = objmanager.player
COLOR_WHITE = glx.argb(255,255,255,255)
COLOR_BLACK = glx.argb(255,0,0,0)
COLOR_RED = glx.argb(255,255,0,0)
COLOR_GREEN = glx.argb(255,0,255,0)
COLOR_LIGHT_GREEN = glx.argb(255,0,128,0)
COLOR_BLUE = glx.argb(255,0,0,255)
COLOR_GREY_HALF = glx.argb(128,61,61,61)


--[[ FAKE MISSLE ]]--
fake_missile = common.Class()
function fake_missile:init()
  fake_missile:registercallbacks()
  fake_missile:RegisterButtons()
  fake_missile.mouse_state = 0
  fake_missile.missile_settings = {
    radius = 80,
    speed = 50,
    range = 1600,
    active = false,
  }
  fake_missile.global_start = {x = 11324, y = -70, z = 4240}
  fake_missile.global_end = {x = 10422, y = -64, z = 5538}
  fake_missile.missiles = {}
  fake_missile.last_missile = 0
end

function fake_missile:registercallbacks ()
  callback.add(enum.callback.wndmsg, function  (a,b)
    fake_missile.wndmsg(a,b)
  end) 
  callback.add(enum.callback.tick, function  ()
    if(fake_missile.mouse_state ~= 0 and os.clock() > fake_missile.mouse_state )then
      fake_missile.mouse_state = 0
    end
    
    fake_missile:update_missile()
  end)
  callback.add(enum.callback.draw, fake_missile.draw)
  callback.add(enum.callback.drawgui, fake_missile.drawgui)
end

function fake_missile:wndmsg(a,b)
  if a == 1 then
    fake_missile.mouse_state = os.clock() + 0.1
    fake_missile:check_is_clicked()
  elseif(a == 192)then
    if(fake_missile.last_missile < os.clock())then
      fake_missile:fire_test_missile()
      fake_missile.last_missile = os.clock() + 0.5
    end
  end
end

function fake_missile:fire_test_missile ()

  local m = {
    identifer = math.random(),
    ptr = math.random(),
    valid = true,
    name = "test",
    team = -3,
    x = fake_missile.global_start.x,
    y = fake_missile.global_start.y,
    z = fake_missile.global_start.z,
    pos = {x = fake_missile.global_start.x, y = fake_missile.global_start.y, z = fake_missile.global_start.z},
    startPos = {x = fake_missile.global_start.x, y = fake_missile.global_start.y, z = fake_missile.global_start.z},
    endPos = {x = fake_missile.global_end.x, y = fake_missile.global_end.y, z = fake_missile.global_end.z},
    speed = fake_missile.missile_settings.speed,
    width = fake_missile.missile_settings.radius,
    owner = {team = -3, type = myHero.type},
    target = myHero,
    slot = 49,
    windUpTime = 0,
    animationTime = 0,
    isBasicAttack = false,
    start_tick = os.clock(),
    spell = {
      endPos =  {x = fake_missile.global_end.x, y = fake_missile.global_end.y, z = fake_missile.global_end.z},
    }
  }
  --calculate end
  local x_vec_start = vec3(m.startPos)
  local x_vec_end = vec3(m.endPos)
  local m_vec = x_vec_start+(x_vec_end-x_vec_start):norm()*fake_missile.missile_settings.range
  m.endPos = {x = m_vec.x, y = m_vec.y, z = m_vec.z}
  
  fake_missile.missiles[#fake_missile.missiles+1] = m
  missle_handler:recvmissile(m)
  print("Fired test missile")
end

function fake_missile:draw()
  glx.world.circle(fake_missile.global_start, 50, 1, COLOR_WHITE, 64)
  glx.world.circle(fake_missile.global_end, 50, 1, COLOR_WHITE, 64)
  glx.world.line(fake_missile.global_start,fake_missile.global_end,2, COLOR_GREY_HALF)
end

function fake_missile:update_missile ()
  local n = #fake_missile.missiles
    for i=1,n do
      local m = fake_missile.missiles[i]
      
      local distance = (os.clock() - m.start_tick)*m.speed
      
      local x_vec_start = vec3(m.startPos)
      local x_vec_end = vec3(m.endPos)
      
      local m_vec = (x_vec_end-x_vec_start)*distance*0.002
      
      local last_pos = fake_missile.missiles[i].pos
      local new_pos = x_vec_start + m_vec
      
      fake_missile.missiles[i].pos = {x = new_pos.x, y = new_pos.y, z = new_pos.z}      
      
      if(common.GetDistance(m.endPos,new_pos) < 10)then
        missle_handler:deleteobj(m)
        fake_missile.missiles[i] = fake_missile.missiles[n]
        fake_missile.missiles[n] = nil
        break
      end
    end
end

function fake_missile:check_is_clicked ()
  for i=1,#fake_missile.buttons do
    local button = fake_missile.buttons[i]
    local pos = button.pos
    local mouse_pos = game.cursorPos
    
    
    if(mouse_pos.x > pos.x and mouse_pos.x < pos.x+pos.width)then
      if(mouse_pos.y > pos.y-pos.height/2 and mouse_pos.y < pos.y+pos.height/2)then
        button.callback()
      end
    end
  end
end

function fake_missile:RegisterButtons ()
  fake_missile.buttons = {}
  
  --SPEED
  fake_missile:AddButton("[UP]", {x = 1610, y = 220, width = 30, height = 20}, COLOR_WHITE, COLOR_GREEN, function  ()
    fake_missile.missile_settings.radius = fake_missile.missile_settings.radius + 10
  end)
  fake_missile:AddButton("[DOWN]", {x = 1645, y = 220, width = 57, height = 20}, COLOR_WHITE, COLOR_RED, function  ()
    fake_missile.missile_settings.radius = fake_missile.missile_settings.radius - 10
    fake_missile.missile_settings.radius =  fake_missile.missile_settings.radius > 10 and  fake_missile.missile_settings.radius or 10
  end)
  
  --RADIUS
  fake_missile:AddButton("[UP]", {x = 1610, y = 250, width = 30, height = 20}, COLOR_WHITE, COLOR_GREEN, function  ()
    fake_missile.missile_settings.speed = fake_missile.missile_settings.speed + 10
  end)
  fake_missile:AddButton("[DOWN]", {x = 1645, y = 250, width = 57, height = 20}, COLOR_WHITE, COLOR_RED, function  ()
    fake_missile.missile_settings.speed = fake_missile.missile_settings.speed - 10
    fake_missile.missile_settings.speed =  fake_missile.missile_settings.speed > 0 and  fake_missile.missile_settings.speed or 0
  end)
  
  --RANGE
  fake_missile:AddButton("[UP]", {x = 1610, y = 280, width = 30, height = 20}, COLOR_WHITE, COLOR_GREEN, function  ()
    fake_missile.missile_settings.range = fake_missile.missile_settings.range + 10
  end)
  fake_missile:AddButton("[DOWN]", {x = 1645, y = 280, width = 57, height = 20}, COLOR_WHITE, COLOR_RED, function  ()
    fake_missile.missile_settings.range = fake_missile.missile_settings.range - 10
    fake_missile.missile_settings.range =  fake_missile.missile_settings.range > 10 and  fake_missile.missile_settings.range or 10
  end)
end

function fake_missile:drawgui()
  glx.screen.drawText(game.cursorPos.x .. "," ..game.cursorPos.y, 12,20,10, COLOR_WHITE)
  glx.screen.drawText(myHero.pos.x .. "," ..myHero.pos.y.. "," ..myHero.pos.z, 12,20,20, COLOR_WHITE)
  
  glx.screen.line(1600,400,1900,400,500,COLOR_GREY_HALF)
  
  local top_right = {x = 1600, y = 150}
  local top_left = {x = 1900, y = 150}
  local bot_right = {x = 1600, y = 650}
  local bot_left = {x = 1900, y = 650}
  DrawTextCentered("Avada Evade Fake Missile Sender", 20, COLOR_WHITE, top_right, top_left)
  
  DrawTextCentered("Radius: " .. tostring(fake_missile.missile_settings.radius), 20, COLOR_WHITE, {x = top_right.x+125, y = top_right.y+50}, top_left)
  DrawTextCentered("Speed: " .. tostring(fake_missile.missile_settings.speed), 20, COLOR_WHITE, {x = top_right.x+125, y = top_right.y+80}, top_left)
  DrawTextCentered("Range: " .. tostring(fake_missile.missile_settings.range), 20, COLOR_WHITE, {x = top_right.x+125, y = top_right.y+110}, top_left)
  
  --Draw Buttons
  for i=1,#fake_missile.buttons do
    local button = fake_missile.buttons[i]
    glx.screen.line(button.pos.x, button.pos.y, button.pos.x+button.pos.width, button.pos.y, button.pos.height, button.color)
    glx.screen.drawText(tostring(button.text), button.pos.height-2, button.pos.x, button.pos.y, button.color2)
  end
end

function fake_missile:AddButton (text, pos, color, color2, callback)
  fake_missile.buttons[#fake_missile.buttons+1] = {text = text, pos = pos, color = color, color2 = color2, callback = callback}
end

function DrawTextCentered (text, size, color, anchor_r, anchor_l)
  glx.screen.drawText(tostring(text), size, anchor_r.x + text:len()/2, anchor_r.y+size, color)
end
fake_missile.init()


































