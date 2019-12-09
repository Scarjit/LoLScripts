--[[ Ez Ryze by timo62
    Have Fun with my First Script!
    If you have any problem here is the Thread for bug reports! 
    Thread: 


]]

local PassiveStacks = 0
local PassiveCharged = false

local LocalVersion = "0.6"
local AutoUpdate = true

local serveradress = "raw.githubusercontent.com"
local scriptadress = "/timo62/GetChallengerEz/master"
local scriptname = "EZ Ryze"
local scriptmsg = "<font color=\"#AA0000\"><b>[Ez Ryze]</b></font>"
    function FindUpdates()
    --if not AutoUpdate then return end
    local ServerVersionDATA = GetWebResult(serveradress , scriptadress.."/"..scriptname..".version")
    if ServerVersionDATA then
        local ServerVersion = tonumber(ServerVersionDATA)
        if ServerVersion then
            if ServerVersion > tonumber(LocalVersion) then
            PrintChat(scriptmsg.."<font color=\"#01cc9c\"><b> Updating, don't press F9.</b></font>")
            Update()
            else
            PrintChat(scriptmsg.."<font color=\"#01cc9c\"><b> You have the latest version.</b></font>")
            end
        else
        PrintChat(scriptmsg.."<font color=\"#01cc9c\"><b> An error occured, while updating, please reload.</b></font>")
        end
    else
    PrintChat(scriptmsg.."<font color=\"#01cc9c\"><b> Could not connect to update Server.</b></font>")
    end
end

function Update()
    DownloadFile("http://"..serveradress , scriptadress.."/"..scriptname..".lua",SCRIPT_PATH..scriptname..".lua", function()
    PrintChat(scriptmsg.."<font color=\"#01cc9c\"><b> Updated, press 2x F9.</b></font>")
    end)
end

if myHero.charName ~= "Ryze" then return end 
local ts
    if not _G.UPLloaded then
        if FileExist(LIB_PATH .. "/UPL.lua") then
            require("UPL")
            _G.UPL = UPL()
        else
            print("Downloading UPL, please don't press F9")
            DelayAction(function() DownloadFile("https://raw.github.com/nebelwolfi/BoL/master/Common/UPL.lua".."?rand="..math.random(1,10000), LIB_PATH.."UPL.lua", function () print("Successfully downloaded UPL. Press F9 twice.") end) end, 3)
            return
        end
    end


        function SayHello()
            -- Print to the chat area
            PrintChat("<font color=\"#AA0000\"><b>[Ez Ryze] </b></font>".."<font color=\"#01cc9c\"><b>Loaded! Good Luck!</b></font>")
            PrintChat("<font color=\"#AA0000\"><b>[Ez Ryze] </b></font>".."<font color=\"#01cc9c\"><b>By: timo62</b></font>")
        end

        function OnLoad()
            --FindUpdates()
            -- Minions 
            EnemyMinions = minionManager(MINION_ENEMY, 600, player, MINION_SORT_HEALTH_ASC)
            allyMinions = minionManager(MINION_ALLY, 300, player, MINION_SORT_HEALTH_DES)
            jungleMinions = minionManager(MINION_JUNGLE, 700, myHero, MINION_SORT_MAXHEALTH_DEC)

            spells = {
            Q = { speed = 1700, delay = 0.25, range = 900, width = 50, collision = false, aoe = false, type = "linear" },
            }
   
            UPL:AddSpell(_Q, spells.Q)
            SayHello()

            -- Menü
            Menu = scriptConfig("{ EZ Ryze } ", "ez ryzee")
                Menu:addSubMenu("|->Key Settings", "Key")
                    Menu.Key:addParam("combo", "Combo Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte(" "))
                    Menu.Key:addParam("laneclear", "Lane Clear Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
                    --[[Menu.Key:addParam("harass", "Harass Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))]]
                    Menu.Key:addParam("lasthit", "Last Hit Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte ("X"))
                    Menu.Key:addParam("Toggle", "Auto Skill Farm", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("T"))

                Menu:addSubMenu("|->Combo", "c")
                    Menu.c:addParam("x1", "-[    Ryze   ]-", SCRIPT_PARAM_INFO, LocalVersion)
                    -- Create conditionals in your menu/keybinds or in certain situations
                    Menu.c:addParam("comboMode", "Set Combo Mode", SCRIPT_PARAM_LIST, 1, {"R W Q E", "W Q E Q"}) -- Combo list default set at 1 (Q W E R)
                    Menu.c:addParam("autoR", "Use R after x Stacks", SCRIPT_PARAM_SLICE, 2, 0, 4)

                --[[Menu:addSubMenu("Harass", "h")
                    Menu.h:addParam("x1", "-[    Ryze   ]-", SCRIPT_PARAM_INFO, "Ver 1.3")
                    Menu.h:addParam("useQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
                    Menu.h:addParam("useW", "Use W", SCRIPT_PARAM_ONOFF, true)
                    Menu.h:addParam("useE", "Use E", SCRIPT_PARAM_ONOFF, true)]]

                Menu:addSubMenu("|->Clear", "l")
                    Menu.l:addParam("x1", "-[    Ryze   ]-", SCRIPT_PARAM_INFO, LocalVersion)
                    Menu.l:addParam("useQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
                    Menu.l:addParam("useW", "Use W", SCRIPT_PARAM_ONOFF, true)
                    Menu.l:addParam("useE", "Use E", SCRIPT_PARAM_ONOFF, true)
                    Menu.l:addParam("useR", "Use R", SCRIPT_PARAM_ONOFF, false)

                Menu:addSubMenu("|->Last Hit", "lh")
                    Menu.lh:addParam("x1", "-[    Ryze   ]-", SCRIPT_PARAM_INFO, LocalVersion)
                    Menu.lh:addParam("useQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
                    Menu.lh:addParam("useW", "Use W", SCRIPT_PARAM_ONOFF, false)
                    Menu.lh:addParam("useE", "Use E", SCRIPT_PARAM_ONOFF, true)

                Menu:addSubMenu("|->Auto Skill Farm", "tg")
                    Menu.tg:addParam("x1", "-[    Ryze   ]-", SCRIPT_PARAM_INFO, LocalVersion)
                    Menu.tg:addParam("useQ", "Use Q", SCRIPT_PARAM_ONOFF, true)

                Menu:addSubMenu("|->Prediction", "pred")
                    Menu.pred:addParam("qhs", "Q Hit Chance", SCRIPT_PARAM_SLICE, 1,1,3)
                    UPL:AddToMenu2(Menu.pred)

                Menu:addSubMenu("|->Drawing", "draw")
                    Menu.draw:addParam("qd", "Draw Q Range", SCRIPT_PARAM_ONOFF, true)
                    Menu.draw:addParam("wd", "Draw W Range", SCRIPT_PARAM_ONOFF, true)
                    Menu.draw:addParam("aad", "Draw AA Range", SCRIPT_PARAM_ONOFF, true) 
                    Menu.draw:addParam("CDTracker", "CD Tracker", SCRIPT_PARAM_ONOFF, true)

                Menu:addSubMenu("|->Target Selector", "TargetSelector")
                        Menu.TargetSelector:addParam ("drawtext", "Draw Target Select Text", SCRIPT_PARAM_ONOFF, true)
                        Menu.TargetSelector:addParam ("hitbox", "Target-Selector", SCRIPT_PARAM_LIST, 1, {"Hitbox", "3D Circle"})



                ts = TargetSelector(TARGET_LOW_HP_PRIORITY,650)
                ts.name = "Ryze"
                Menu:addTS(ts)
        end

        function OnTick()




                if SelectedTarget ~= nil then 
                    Target = SelectedTarget 
                else Target = ts.target 
                end

                checks()
            if Menu.Key.combo and (Target ~= nil) then
                if Menu.c.comboMode == 1 then 
                    Combo1()
                else
                    Combo2()
            
            end
                elseif Menu.Key.laneclear then
                    Clear()
                elseif Menu.Key.lasthit then
                    Lasthit()
                elseif Menu.Key.Toggle then
                    Lasthith()
                elseif Menu.Key.harass then
                    harass1()
                end
        end

function GetHPBarPos(enemy)
    enemy.barData = {PercentageOffset = {x = -0.05, y = 0}}--GetEnemyBarData()
    local barPos = GetUnitHPBarPos(enemy)
    local barPosOffset = GetUnitHPBarOffset(enemy)
    local barOffset = { x = enemy.barData.PercentageOffset.x, y = enemy.barData.PercentageOffset.y }
    local barPosPercentageOffset = { x = enemy.barData.PercentageOffset.x, y = enemy.barData.PercentageOffset.y }
    local BarPosOffsetX = 171
    local BarPosOffsetY = 46
    local CorrectionY = 39
    local StartHpPos = 31

    barPos.x = math.floor(barPos.x + (barPosOffset.x - 0.5 + barPosPercentageOffset.x) * BarPosOffsetX + StartHpPos)
    barPos.y = math.floor(barPos.y + (barPosOffset.y - 0.5 + barPosPercentageOffset.y) * BarPosOffsetY + CorrectionY)

    local StartPos = Vector(barPos.x , barPos.y, 0)
    local EndPos = Vector(barPos.x + 108 , barPos.y , 0)
    return Vector(StartPos.x, StartPos.y, 0), Vector(EndPos.x, EndPos.y, 0)
end

function DrawCD()
    for i = 1, heroManager.iCount, 1 do
        local champ = heroManager:getHero(i)
        if champ ~= nil and champ ~= myHero and champ.visible and champ.dead == false then
            local barPos = GetHPBarPos(champ)
            if OnScreen(barPos.x, barPos.y) then
                local cd = {}
                cd[0] = math.ceil(champ:GetSpellData(SPELL_1).currentCd)
                cd[1] = math.ceil(champ:GetSpellData(SPELL_2).currentCd)
                cd[2] = math.ceil(champ:GetSpellData(SPELL_3).currentCd)
                cd[3] = math.ceil(champ:GetSpellData(SPELL_4).currentCd)
            
                local spellColor = {}
                spellColor[0] = 0xBBFFD700;
                spellColor[1] = 0xBBFFD700;
                spellColor[2] = 0xBBFFD700;
                spellColor[3] = 0xBBFFD700;
                                       
                if cd[0] == nil or cd[0] == 0 then cd[0] = "Q" spellColor[0] = 0xBBFFFFFF end
                if cd[1] == nil or cd[1] == 0 then cd[1] = "W" spellColor[1] = 0xBBFFFFFF end
                if cd[2] == nil or cd[2] == 0 then cd[2] = "E" spellColor[2] = 0xBBFFFFFF end
                if cd[3] == nil or cd[3] == 0 then cd[3] = "R" spellColor[3] = 0xBBFFFFFF end
            
                if champ:GetSpellData(SPELL_1).level == 0 then spellColor[0] = 0xBBFF0000 end
                if champ:GetSpellData(SPELL_2).level == 0 then spellColor[1] = 0xBBFF0000 end
                if champ:GetSpellData(SPELL_3).level == 0 then spellColor[2] = 0xBBFF0000 end
                if champ:GetSpellData(SPELL_4).level == 0 then spellColor[3] = 0xBBFF0000 end
                DrawRectangle(barPos.x-6, barPos.y-40, 80, 15, 0xBB202020)
                DrawText("[" .. cd[0] .. "]" ,12, barPos.x-5+2, barPos.y-40, spellColor[0])
                DrawText("[" .. cd[1] .. "]", 12, barPos.x+15+2, barPos.y-40, spellColor[1])
                DrawText("[" .. cd[2] .. "]", 12, barPos.x+35+2, barPos.y-40, spellColor[2])
                DrawText("[" .. cd[3] .. "]", 12, barPos.x+54+2, barPos.y-40, spellColor[3])
            end
        end
    end
end


        function OnWndMsg(msg, key)
            if msg == WM_LBUTTONDOWN then
                local minD = 200
                    for i, unit in ipairs(GetEnemyHeroes()) do
                        if ValidTarget(unit) and not unit.dead then
                            if GetDistance(unit, mousePos) <= minD or target == nil then
                                minD = GetDistance(unit, mousePos)
                                target = unit
                            end
                        end
                    end
                        if target and minD < 200 then
                            if SelectedTarget and target.charName == SelectedTarget.charName then
                                SelectedTarget = nil
                                if Menu.TargetSelector.drawtext then
                                print("Target unselected")
                                end
                            else
                                SelectedTarget = target
                                if Menu.TargetSelector.drawtext then
                                print("Target Selected: "..SelectedTarget.charName)
                                end
                            end
                        end
            end
        end


        function OnApplyBuff(source, unit, buff) 
            if source and source.isMe and buff and buff.name and buff.name:find("ryzepassivecharged") then
                PassiveStacks = 1
                PassiveCharged = true
            end
        end


        function OnUpdateBuff(unit, buff, stacks)
            if unit and unit.isMe and buff and buff.name and buff.name:find("ryzepassivestack") then
                PassiveStacks = stacks
            end
        end



        function checks()
            ts:update()
            Qready = (myHero:CanUseSpell(_Q) == READY)
            Wready = (myHero:CanUseSpell(_W) == READY)
            Eready = (myHero:CanUseSpell(_E) == READY)
            Rready = (myHero:CanUseSpell(_R) == READY)
            Target = ts.target
        end

        -- Combo RWQE during you're passive
        function Combo1()
            if Menu.Key.combo and Rready and PassiveStacks >= Menu.c.autoR then
                CastSpell(_R)

            elseif Menu.Key.combo and Wready then
                CastSpell(_W, Target)


            elseif Menu.Key.combo and Qready then
                CastQ(Target)

            elseif Menu.Key.combo and Eready then
                CastSpell(_E, Target)
            end

        end

        -- Combo RWQE during you're passive
        function Combo2()
            if Menu.Key.combo and Rready then
                CastSpell(_R)

            elseif Menu.Key.combo and Wready then
                CastSpell(_W, Target)


            elseif Menu.Key.combo and Qready then
                CastQ(Target)

            elseif Menu.Key.combo and Eready then
                CastSpell(_E, Target)
            end

        end


        --[[-- Combo RWQE during you're passive
        function harass1()

            if Menu.Key.harass and Wready then
                CastSpell(_W, Target)


            elseif Menu.Key.harass and Qready then
                CastQ(Target)

            elseif Menu.Key.harass and Eready then
                CastSpell(_E, Target)
            end

        end]]

        
        --LaneClear
       --[[ function Clear()
            if  Menu.l.useE  then
                EnemyMinions:update()
                for i, minion in pairs(EnemyMinions.objects) do
                    local wDmg = getDmg("W", minion, myHero)
                        if Menu.l.useW and Wready and wDmg >= minion.health then
                            CastSpell(_W,minion)
                        else 
                            CastSpell(_W, minion)
             
                        end
                    --end vllt.

                    local qDmg = getDmg("Q", minion, myHero)
                        if Menu.l.useQ and Qready and not Qready and GetDistance(myHero,minion) <= 600 and qDmg >= minion.health then
                            CastQ(minion)
                        else
                            CastQ(minion)
                        end

                    local eDmg = getDmg("E", minion, myHero)
                        if Menu.l.useE and Eready and eDmg >= minion.health then
                            CastSpell(_E, minion)
                        else
                            CastSpell(_E, minion)
                        end

                        if Menu.l.useR and Rready then
                            CastSpell(_R)
                        end
                end
            end
        end]]


        function Clear()
            EnemyMinions:update()
            jungleMinions:update()
                for _, minion in pairs(EnemyMinions.objects) do
                    if Menu.l.useR then CastSpell(_R) end
                    if Menu.l.useW then CastSpell(_W, minion) end
                    if Menu.l.useE then CastSpell(_E, minion) end
                    if Menu.l.useQ then CastQ(minion) end
                    
                end
                for _, minion in pairs(jungleMinions.objects) do
                    if Menu.l.useR then CastSpell(_R) end
                    if Menu.l.useW then CastSpell(_W, minion) end
                    if Menu.l.useE then CastSpell(_E, minion) end
                    if Menu.l.useQ then CastQ(minion) end 
                    
                end
        end
  
 
        --Last Hit
        function Lasthit()
            if  Menu.lh.useQ then
                EnemyMinions:update()
                for i, minion in pairs (EnemyMinions.objects) do
                    local qDmg = getDmg("Q", minion, myHero)
                        if Menu.lh.useQ and Qready and qDmg >= (minion.health+20) then
                            CastQ(minion)
                        end
                end
            elseif  Menu.lh.useW then
                    EnemyMinions:update()
                    for i, minion in pairs (EnemyMinions.objects) do
                        local wDmg = getDmg("W", minion, myHero)
                            if Menu.lh.useW and Wready and wDmg >= (minion.health) then
                                CastSpell(_W, minion)
                            end
                    end
            elseif  Menu.lh.useE then
                    EnemyMinions:update()
                    for i, minion in pairs(EnemyMinions.objects) do
                        local eDmg = getDmg("E", minion, myHero)
                            if Menu.lh.useE and Eready and eDmg >= (minion.health+20) then
                                CastSpell(_E, minion)
                            end
                    end
            end
        end


        --Last Hit Q Auto
        function Lasthith()
            if  Menu.tg.useQ then
                EnemyMinions:update()
                for i, minion in pairs (EnemyMinions.objects) do
                    local qDmg = getDmg("Q", minion, myHero)
                        if Menu.tg.useQ and Qready and qDmg >= (minion.health +20) then
                            CastQ(minion)
                        end
                end
            end
        end


        function CastQ(target, minion)
            if not target and minion then return end
            CastPosition, HitChance, HeroPosition = UPL:Predict(_Q, myHero, target, minion)
                if Qready and HitChance >= Menu.pred.qhs then
                    DelayAction(function ()
                        CastSpell(_Q, CastPosition.x,CastPosition.z)
                end,0)
            end
        end



            function DrawCircle3D(x, y, z, radius, width, color, quality)
                radius = radius or 900
                quality = quality and 2 * math.pi / quality or 2 * math.pi / (radius / 5)
                local points = {}
                    for theta = 0, 2 * math.pi + quality, quality do
                        local c = WorldToScreen(D3DXVECTOR3(x + radius * math.cos(theta), y, z - radius * math.sin(theta)))
                        points[#points + 1] = D3DXVECTOR2(c.x, c.y)
                    end
                DrawLines2(points, width or 1, color or 2294967295)
            end

            function DrawCircle3D2(x, y, z, radius, width, color, quality)
                radius = radius or 600
                quality = quality and 2 * math.pi / quality or 2 * math.pi / (radius / 5)
                local points = {}
                    for theta = 0, 2 * math.pi + quality, quality do
                        local c = WorldToScreen(D3DXVECTOR3(x + radius * math.cos(theta), y, z - radius * math.sin(theta)))
                        points[#points + 1] = D3DXVECTOR2(c.x, c.y)
                    end
                DrawLines2(points, width or 1, color or 4294967295)
            end

            function DrawCircle3D4(x, y, z, radius, width, color, quality)
                radius = radius or 100
                quality = quality and 2 * math.pi / quality or 2 * math.pi / (radius / 5)
                local points = {}
                    for theta = 0, 2 * math.pi + quality, quality do
                        local c = WorldToScreen(D3DXVECTOR3(x + radius * math.cos(theta), y, z - radius * math.sin(theta)))
                        points[#points + 1] = D3DXVECTOR2(c.x, c.y)
                    end
                DrawLines2(points, width or 1, color or 8294967295)
            end

            function DrawHitBox(object, linesize, linecolor)
                if object and object.valid and object.minBBox then
                    DrawLine3D(object.minBBox.x, object.minBBox.y, object.minBBox.z, object.minBBox.x, object.minBBox.y, object.maxBBox.z, linesize, linecolor)
                    DrawLine3D(object.minBBox.x, object.minBBox.y, object.maxBBox.z, object.maxBBox.x, object.minBBox.y, object.maxBBox.z, linesize, linecolor)
                    DrawLine3D(object.maxBBox.x, object.minBBox.y, object.maxBBox.z, object.maxBBox.x, object.minBBox.y, object.minBBox.z, linesize, linecolor)
                    DrawLine3D(object.maxBBox.x, object.minBBox.y, object.minBBox.z, object.minBBox.x, object.minBBox.y, object.minBBox.z, linesize, linecolor)
                    DrawLine3D(object.minBBox.x, object.minBBox.y, object.minBBox.z, object.minBBox.x, object.maxBBox.y, object.minBBox.z, linesize, linecolor)
                    DrawLine3D(object.minBBox.x, object.minBBox.y, object.maxBBox.z, object.minBBox.x, object.maxBBox.y, object.maxBBox.z, linesize, linecolor)
                    DrawLine3D(object.maxBBox.x, object.minBBox.y, object.maxBBox.z, object.maxBBox.x, object.maxBBox.y, object.maxBBox.z, linesize, linecolor)
                    DrawLine3D(object.maxBBox.x, object.minBBox.y, object.minBBox.z, object.maxBBox.x, object.maxBBox.y, object.minBBox.z, linesize, linecolor)
                    DrawLine3D(object.minBBox.x, object.maxBBox.y, object.minBBox.z, object.minBBox.x, object.maxBBox.y, object.maxBBox.z, linesize, linecolor)
                    DrawLine3D(object.minBBox.x, object.maxBBox.y, object.maxBBox.z, object.maxBBox.x, object.maxBBox.y, object.maxBBox.z, linesize, linecolor)
                    DrawLine3D(object.maxBBox.x, object.maxBBox.y, object.maxBBox.z, object.maxBBox.x, object.maxBBox.y, object.minBBox.z, linesize, linecolor)
                    DrawLine3D(object.maxBBox.x, object.maxBBox.y, object.minBBox.z, object.minBBox.x, object.maxBBox.y, object.minBBox.z, linesize, linecolor)
                end
            end


        function OnDraw()

                if Menu.draw.CDTracker then DrawCD() end


                if (Menu.draw.qd) then
                -- Q Range
                DrawCircle3D(myHero.x, myHero.y, myHero.z)
                end

                if (Menu.draw.wd) then
                -- W Range
                    DrawCircle3D2(myHero.x, myHero.y, myHero.z)
                end

                local pos = WorldToScreen(D3DXVECTOR3(myHero.x, myHero.y, myHero.z))
                if PassiveStacks >= 1 then
                   
                    --DrawText("XXX", TextSize, X, Y, HexColor)
                    DrawText("Stack:"..PassiveStacks, 18, pos.x, pos.y, 0xFFFFFF00)
                    elseif PassiveStacks == 5 then
                        DrawText("Stack: 5 ", 18, pos.x, pos.y, 0xFFFFFF00)
                   
                end

                if SelectedTarget ~= nil and Menu.TargetSelector.hitbox == 1 then 
                    DrawHitBox(SelectedTarget)

                end

                if SelectedTarget ~= nil and Menu.TargetSelector.hitbox == 2 then
                    DrawCircle3D4(SelectedTarget.x, SelectedTarget.y, SelectedTarget.z)
                end


        end
