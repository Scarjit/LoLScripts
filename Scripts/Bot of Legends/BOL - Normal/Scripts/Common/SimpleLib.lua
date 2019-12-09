local AUTOUPDATES = true
local ScriptName = "SimpleLib"
_G.SimpleLibVersion = 1.44

SPELL_TYPE = { LINEAR = 1, CIRCULAR = 2, CONE = 3, TARGETTED = 4, SELF = 5}

ORBWALK_MODE = { COMBO = 1, HARASS = 2, CLEAR = 3, LASTHIT = 4, NONE = -1}

CIRCLE_MANAGER = { CIRCLE_2D = 1, CIRCLE_3D = 2, CIRCLE_MINIMAP = 3}

LASTHIT_MODE = { NEVER = 1, SMART = 2, ALWAYS = 3}


class "_CircleManager"
class "_SpellManager"
class "_Spell"
class "_Prediction"
class "_Circle"
class "_OrbwalkManager"
class "_KeyManager"
class "_Required"
class "_Downloader"
class "_ScriptUpdate"
class "_Interrupter"
class "_Initiator"
class "_Evader"
class "_AutoSmite"
class "_SimpleTargetSelector"

local CHANELLING_SPELLS = {
    ["Caitlyn"]                     = { "R" },
    ["Katarina"]                    = { "R" },
    ["MasterYi"]                    = { "W" },
    ["Fiddlesticks"]                = { "R" },
    ["Galio"]                       = { "R" },
    ["Lucian"]                      = { "R" },
    ["MissFortune"]                 = { "R" },
    ["VelKoz"]                      = { "R" },
    ["Nunu"]                        = { "R" },
    ["Shen"]                        = { "R" },
    ["Karthus"]                     = { "R" },
    ["Malzahar"]                    = { "R" },
    ["Pantheon"]                    = { "R" },
    ["Warwick"]                     = { "R" },
    ["Xerath"]                      = { "R" },
}

local GAPCLOSER_SPELLS = {
    ["Aatrox"]                      = { "Q" },
    ["Akali"]                       = { "R" },
    ["Alistar"]                     = { "W" },
    ["Amumu"]                       = { "Q" },
    ["Caitlyn"]                     = { "E" },
    ["Corki"]                       = { "W" },
    ["Diana"]                       = { "R" },
    ["Ezreal"]                       = { "E" },
    ["Elise"]                       = { "Q", "E" },
    ["Fiddlesticks"]                = { "R" },
    ["Fiora"]                       = { "Q" },
    ["Fizz"]                        = { "Q" },
    ["Gnar"]                        = { "E" },
    ["Gragas"]                      = { "E" },
    ["Graves"]                      = { "E" },
    ["Hecarim"]                     = { "R" },
    ["Irelia"]                      = { "Q" },
    ["JarvanIV"]                    = { "Q", "R" },
    ["Jax"]                         = { "Q" },
    ["Jayce"]                       = { "Q" },
    ["Katarina"]                    = { "E" },
    ["Kassadin"]                    = { "R" },
    ["Kennen"]                      = { "E" },
    ["KhaZix"]                      = { "E" },
    ["Lissandra"]                   = { "E" },
    ["LeBlanc"]                     = { "W" , "R"},
    ["LeeSin"]                      = { "Q" },
    ["Leona"]                       = { "E" },
    ["Lucian"]                      = { "E" },
    ["Malphite"]                    = { "R" },
    ["MasterYi"]                    = { "Q" },
    ["MonkeyKing"]                  = { "E" },
    ["Nautilus"]                    = { "Q" },
    ["Nocturne"]                    = { "R" },
    ["Olaf"]                        = { "R" },
    ["Pantheon"]                    = { "W" , "R"},
    ["Poppy"]                       = { "E" },
    ["RekSai"]                      = { "E" },
    ["Renekton"]                    = { "E" },
    ["Riven"]                       = { "Q", "E"},
    ["Rengar"]                      = { "R" },
    ["Sejuani"]                     = { "Q" },
    ["Sion"]                        = { "R" },
    ["Shen"]                        = { "E" },
    ["Shyvana"]                     = { "R" },
    ["Talon"]                       = { "E" },
    ["Thresh"]                      = { "Q" },
    ["Tristana"]                    = { "W" },
    ["Tryndamere"]                  = { "E" },
    ["Udyr"]                        = { "E" },
    ["Volibear"]                    = { "Q" },
    ["Vi"]                          = { "Q" },
    ["XinZhao"]                     = { "E" },
    ["Yasuo"]                       = { "E" },
    ["Zac"]                         = { "E" },
    ["Ziggs"]                       = { "W" },
}

local CC_SPELLS = {
    ["Ahri"]                        = { "E" },
    ["Amumu"]                       = { "Q", "R" },
    ["Anivia"]                      = { "Q" },
    ["Annie"]                       = { "R" },
    ["Ashe"]                        = { "R" },
    ["Bard"]                        = { "Q" },
    ["Blitzcrank"]                  = { "Q" },
    ["Brand"]                       = { "Q" },
    ["Braum"]                       = { "Q" },
    ["Cassiopeia"]                  = { "R" },
    ["Darius"]                      = { "E" },
    ["Draven"]                      = { "E" },
    ["DrMundo"]                     = { "Q" },
    ["Ekko"]                        = { "W" },
    ["Elise"]                       = { "E" },
    ["Evelynn"]                     = { "R" },
    ["Ezreal"]                      = { "R" },
    ["Fizz"]                        = { "R" },
    ["Galio"]                       = { "R" },
    ["Gnar"]                        = { "R" },
    ["Gragas"]                      = { "R" },
    ["Graves"]                      = { "R" },
    ["Jinx"]                        = { "W" , "R" },
    ["KhaZix"]                      = { "W" },
    ["Leblanc"]                     = { "E" },
    ["LeeSin"]                      = { "Q" },
    ["Leona"]                       = { "E" , "R" },
    ["Lux"]                         = { "Q" , "R" },
    ["Malphite"]                    = { "R" },
    ["Morgana"]                     = { "Q" },
    ["Nami"]                        = { "Q" },
    ["Nautilus"]                    = { "Q" },
    ["Nidalee"]                     = { "Q" },
    ["Orianna"]                     = { "R" },
    ["Rengar"]                      = { "E" },
    ["Riven"]                       = { "R" },
    ["Sejuani"]                     = { "R" },
    ["Sion"]                        = { "E" },
    ["Shen"]                        = { "E" },
    --["Shyvana"]                   = { "R" },
    ["Sona"]                        = { "R" },
    ["Swain"]                       = { "W" },
    ["Thresh"]                      = { "Q" },
    ["Varus"]                       = { "R" },
    ["Veigar"]                      = { "E" },
    ["Vi"]                          = { "Q" },
    ["Xerath"]                      = { "E" , "R" },
    ["Yasuo"]                       = { "Q" },
    ["Zyra"]                        = { "E" },
    ["Quinn"]                       = { "E" },
    ["Rumble"]                      = { "E" },
    ["Zed"]                         = { "R" },
}

local YASUO_WALL_SPELLS = {
    ["Ahri"]                        = { "Q" , "E" },
    ["Amumu"]                       = { "Q" },
    ["Anivia"]                      = { "Q" },
    ["Annie"]                       = { "R" },
    ["Ashe"]                        = { "W" , "R" },
    ["Bard"]                        = { "Q" },
    ["Blitzcrank"]                  = { "Q" },
    ["Brand"]                       = { "Q" },
    ["Braum"]                       = { "Q" , "R" },
    ["Caitlyn"]                     = { "Q" , "E", "R" },
    ["Corki"]                       = { "Q" , "R" },
    ["Cassiopeia"]                  = { "R" },
    ["Diana"]                       = { "Q" },
    ["Darius"]                      = { "E" },
    ["Draven"]                      = { "E" , "R" },
    ["DrMundo"]                     = { "Q" },
    ["Ekko"]                        = { "Q" },
    ["Elise"]                       = { "E" },
    ["Ezreal"]                      = { "Q" , "W" , "R" },
    ["Fiora"]                       = { "W" },
    ["Fizz"]                        = { "R" },
    ["Galio"]                       = { "E" },
    ["Gnar"]                        = { "Q" },
    ["Gragas"]                      = { "Q" , "R" },
    ["Graves"]                      = { "R" },
    ["Heimerdinger"]                = { "W" , "E" },
    ["Irelia"]                      = { "R" },
    ["Janna"]                       = { "Q" },
    ["Jayce"]                       = { "Q" },
    ["Jinx"]                        = { "W" , "R" },
    ["Kalista"]                     = { "Q" },
    ["Karma"]                       = { "Q" },
    ["Kennen"]                      = { "Q" },
    ["KhaZix"]                      = { "W" },
    ["KogMaw"]                      = { "Q" , "E" },
    ["Leblanc"]                     = { "E" },
    ["LeeSin"]                      = { "Q" },
    ["Leona"]                       = { "E" },
    ["Lissandra"]                   = { "Q" , "E" },
    ["Lulu"]                        = { "Q" },
    ["Lux"]                         = { "Q" , "E" ,  "R" },
    ["Morgana"]                     = { "Q" },
    ["Nami"]                        = { "R" },
    ["Nautilus"]                    = { "Q" },
    ["Nocturne"]                    = { "Q" },
    ["Nidalee"]                     = { "Q" },
    ["Olaf"]                        = { "Q" },
    ["Orianna"]                     = { "Q" , "E" },
    ["Quinn"]                       = { "Q" },
    ["Rengar"]                      = { "E" },
    ["RekSai"]                      = { "Q" },
    ["Riven"]                       = { "R" },
    ["Rumble"]                      = { "E" },
    ["Ryze"]                        = { "Q" },
    ["Sejuani"]                     = { "Q" , "R"},
    ["Sion"]                        = { "E" },
    ["Soraka"]                      = { "Q" },
    ["Shen"]                        = { "E" },
    ["Shyvana"]                     = { "E" },
    ["Sivir"]                       = { "Q" },
    ["Skarner"]                     = { "E" },
    ["Sona"]                        = { "R" },
    ["TahmKench"]                   = { "Q" },
    ["Thresh"]                      = { "Q" },
    ["TwistedFate"]                 = { "Q" },
    ["Twitch"]                      = { "W" },
    ["Varus"]                       = { "Q" , "R" },
    ["Veigar"]                      = { "Q" },
    ["VelKoz"]                      = { "Q" },
    ["Viktor"]                      = { "E" },
    ["Xerath"]                      = { "E" },
    ["Yasuo"]                       = { "Q" },
    ["Zed"]                         = { "Q" },
    ["Ziggs"]                       = { "W" },
    ["Zilean"]                      = { "Q" },
    ["Zyra"]                        = { "E" },
}

local EnemiesInGame = {}

function ExtraTime()
    return -0.07--Latency() - 0.1
end

function Latency()
    return GetLatency()/2000 
end

function CheckUpdate()
    if AUTOUPDATES then
        local ToUpdate = {}
        ToUpdate.LocalVersion = _G.SimpleLibVersion
        ToUpdate.VersionPath = "raw.githubusercontent.com/jachicao/BoL/master/version/SimpleLib.version"
        ToUpdate.ScriptPath = "raw.githubusercontent.com/jachicao/BoL/master/SimpleLib.lua"
        ToUpdate.SavePath = LIB_PATH.."SimpleLib.lua"
        ToUpdate.CallbackUpdate = function(NewVersion,OldVersion) PrintMessage("Updated to "..NewVersion..". Please reload with 2x F9.") end
        ToUpdate.CallbackNoUpdate = function(OldVersion) PrintMessage("No Updates Found.") end
        ToUpdate.CallbackNewVersion = function(NewVersion) PrintMessage("New Version found ("..NewVersion.."). Please wait...") end
        ToUpdate.CallbackError = function(NewVersion) PrintMessage("Error while trying to check update.") end
        _ScriptUpdate(ToUpdate)
    end
end

function Immune(target)
    --[[
    if EnemiesInGame["Kayle"] and TargetHaveBuff("judicatorintervention", target) then return true
    elseif target.charName == "Tryndamere" and TargetHaveBuff("undyingrage", target) then return true
    elseif target.charName == "Sion" and TargetHaveBuff("sionpassivezombie", target) then return true
    elseif target.charName == "Aatrox" and TargetHaveBuff("aatroxpassivedeath", target) then return true
    elseif EnemiesInGame["Zilean"] and TargetHaveBuff("chronoshift", target) then return true end
    ]]
    return false
end

function IsEvading()
    return _G.evade or _G.Evade
end

function IsValidTarget(object, distance, enemyTeam)
    local enemyTeam = (enemyTeam ~= false)
    return object ~= nil and object.valid and (object.team ~= player.team) == enemyTeam and object.visible and not object.dead and object.bTargetable and (enemyTeam == false or object.bInvulnerable == 0) 
    and (distance == nil or GetDistanceSqr(object) <= distance * distance)
    and (object.type == myHero.type and not Immune(object) or (object.type ~= myHero.type and true))
end

function SlotToString(Slot)
    local string = "Q"
    if Slot == _Q then
        string = "Q"
    elseif Slot == _W then
        string = "W"
    elseif Slot == _E then
        string = "E"
    elseif Slot == _R then
        string = "R"
    elseif Slot == SUMMONER_1 then
        string = "D"
    elseif Slot == SUMMONER_2 then
        string = "F"
    elseif Slot == ITEM_1 then
        string = "ITEM_1"
    elseif Slot == ITEM_2 then
        string = "ITEM_2"
    elseif Slot == ITEM_3 then
        string = "ITEM_3"
    elseif Slot == ITEM_4 then
        string = "ITEM_4"
    elseif Slot == ITEM_5 then
        string = "ITEM_5"
    elseif Slot == ITEM_6 then
        string = "ITEM_6"
    elseif Slot == ITEM_7 then
        string = "ITEM_7"
    end
    return string
end

function PrintMessage(arg1, arg2)
    local a, b = "", ""
    if arg2 ~= nil then
        a = arg1
        b = arg2
    else
        a = ScriptName
        b = arg1
    end
    print("<font color=\"#6699ff\"><b>" .. a .. ":</b></font> <font color=\"#FFFFFF\">" .. b .. "</font>") 
end

function FindItemSlot(name)
    for slot = ITEM_1, ITEM_7 do
        if myHero:CanUseSpell(slot) == READY and myHero:GetSpellData(slot) ~= nil and myHero:GetSpellData(slot).name ~= nil and ( tostring(myHero:GetSpellData(slot).name):lower():find(tostring(name):lower()) or tostring(name):lower():find(tostring(myHero:GetSpellData(slot).name):lower()) ) then
            return slot
        end
    end
    return nil
end

function FindSummonerSlot(name)
    for slot = SUMMONER_1, SUMMONER_2 do
        if myHero:GetSpellData(slot)  ~= nil and myHero:GetSpellData(slot).name  ~= nil and ( tostring(myHero:GetSpellData(slot).name):lower():find(tostring(name):lower()) or tostring(name):lower():find(tostring(myHero:GetSpellData(slot).name):lower()) ) then
            return slot
        end
    end
    return nil
end

function GetPriority(enemy)
    return 1 + math.max(0, math.min(1.5, TS_GetPriority(enemy) * 0.25))
end


function _GetDistanceSqr(p1, p2)
    p2 = p2 or player
    if p1 and p1.networkID and (p1.networkID ~= 0) and p1.visionPos then p1 = p1.visionPos end
    if p2 and p2.networkID and (p2.networkID ~= 0) and p2.visionPos then p2 = p2.visionPos end
    return GetDistanceSqr(p1, p2)
    
end

function CountObjectsNearPos(pos, range, radius, objects)
    local n = 0
    for i, object in ipairs(objects) do
        local r = radius --+ object.boundingRadius
        if _GetDistanceSqr(pos, object) <= math.pow(r, 2) then
            n = n + 1
        end
    end

    return n
end

function GetBestCircularFarmPosition(range, radius, objects)
    local BestPos 
    local BestHit = 0
    for i, object in ipairs(objects) do
        local hit = CountObjectsNearPos(object.visionPos or object, range, radius, objects)
        if hit > BestHit then
            BestHit = hit
            BestPos = object--Vector(object)
            if BestHit == #objects then
               break
            end
         end
    end
    return BestPos, BestHit
end

function CountObjectsOnLineSegment(StartPos, EndPos, width, objects)
    local n = 0
    for i, object in ipairs(objects) do
        local pointSegment, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(StartPos, EndPos, object)
        local w = width --+ object.boundingRadius
        if isOnSegment and GetDistanceSqr(pointSegment, object) < math.pow(w, 2) and GetDistanceSqr(StartPos, EndPos) > GetDistanceSqr(StartPos, object) then
            n = n + 1
        end
    end
    return n
end
    

function GetBestLineFarmPosition(range, width, objects)
    local BestPos 
    local BestHit = 0
    for i, object in ipairs(objects) do
        local EndPos = Vector(myHero) + range * (Vector(object) - Vector(myHero)):normalized()
        local hit = CountObjectsOnLineSegment(myHero, EndPos, width, objects)
        if hit > BestHit then
            BestHit = hit
            BestPos = object--Vector(object)
            if BestHit == #objects then
               break
            end
         end
    end
    return BestPos, BestHit
end



function GetHPBarPos(enemy)
    enemy.barData = {PercentageOffset = {x = -0.05, y = 0}}
    local barPos = GetUnitHPBarPos(enemy)
    local barPosOffset = GetUnitHPBarOffset(enemy)
    local barOffset = { x = enemy.barData.PercentageOffset.x, y = enemy.barData.PercentageOffset.y }
    local barPosPercentageOffset = { x = enemy.barData.PercentageOffset.x, y = enemy.barData.PercentageOffset.y }
    local BarPosOffsetX = -50
    local BarPosOffsetY = 46
    local CorrectionY = 39
    local StartHpPos = 31 
    barPos.x = math.floor(barPos.x + (barPosOffset.x - 0.5 + barPosPercentageOffset.x) * BarPosOffsetX + StartHpPos)
    barPos.y = math.floor(barPos.y + (barPosOffset.y - 0.5 + barPosPercentageOffset.y) * BarPosOffsetY + CorrectionY)
    local StartPos = Vector(barPos.x , barPos.y, 0)
    local EndPos = Vector(barPos.x + 108 , barPos.y , 0)    
    return Vector(StartPos.x, StartPos.y, 0), Vector(EndPos.x, EndPos.y, 0)
end

function DrawLineHPBar(damage, text, unit, enemyteam)
    if unit.dead or not unit.visible then return end
    local p = WorldToScreen(D3DXVECTOR3(unit.x, unit.y, unit.z))
    if not OnScreen(p.x, p.y) then return end
    local thedmg = 0
    local line = 2
    local linePosA  = {x = 0, y = 0 }
    local linePosB  = {x = 0, y = 0 }
    local TextPos   = {x = 0, y = 0 }
    
    
    if damage >= unit.maxHealth then
        thedmg = unit.maxHealth - 1
    else
        thedmg = damage
    end
    
    thedmg = math.round(thedmg)
    
    local StartPos, EndPos = GetHPBarPos(unit)
    local Real_X = StartPos.x + 24
    local Offs_X = (Real_X + ((unit.health - thedmg) / unit.maxHealth) * (EndPos.x - StartPos.x - 2))
    if Offs_X < Real_X then Offs_X = Real_X end 
    local mytrans = 350 - math.round(255*((unit.health-thedmg)/unit.maxHealth))
    if mytrans >= 255 then mytrans=254 end
    local my_bluepart = math.round(400*((unit.health-thedmg)/unit.maxHealth))
    if my_bluepart >= 255 then my_bluepart=254 end

    
    if enemyteam then
        linePosA.x = Offs_X-150
        linePosA.y = (StartPos.y-(30+(line*15)))    
        linePosB.x = Offs_X-150
        linePosB.y = (StartPos.y-10)
        TextPos.x = Offs_X-148
        TextPos.y = (StartPos.y-(30+(line*15)))
    else
        linePosA.x = Offs_X-125
        linePosA.y = (StartPos.y-(30+(line*15)))    
        linePosB.x = Offs_X-125
        linePosB.y = (StartPos.y-15)
    
        TextPos.x = Offs_X-122
        TextPos.y = (StartPos.y-(30+(line*15)))
    end

    DrawLine(linePosA.x, linePosA.y, linePosB.x, linePosB.y , 2, ARGB(mytrans, 255, my_bluepart, 0))
    DrawText(tostring(thedmg).." "..tostring(text), 15, TextPos.x, TextPos.y , ARGB(mytrans, 255, my_bluepart, 0))
end

 
function _arrangePriorities()
    local priorityTable2 = {
        p5 = {"Alistar", "Amumu", "Blitzcrank", "Braum", "ChoGath", "DrMundo", "Garen", "Gnar", "Hecarim", "JarvanIV", "Leona", "Lulu", "Malphite", "Nasus", "Nautilus", "Nunu", "Olaf", "Rammus", "Renekton", "Sejuani", "Shen", "Shyvana", "Singed", "Sion", "Skarner", "TahmKench", "Taric", "Thresh", "Volibear", "Warwick", "MonkeyKing", "Yorick", "Zac"},
        p4 = {"Aatrox", "Darius", "Elise", "Evelynn", "Galio", "Gangplank", "Gragas", "Irelia", "Jax","LeeSin", "Maokai", "Morgana", "Nocturne", "Pantheon", "Poppy", "Rengar", "Rumble", "Ryze", "Swain","Trundle", "Tryndamere", "Udyr", "Urgot", "Vi", "XinZhao", "RekSai"},
        p3 = {"Akali", "Diana", "Fiddlesticks", "Fiora", "Fizz", "Heimerdinger", "Janna", "Jayce", "Kassadin","Kayle", "KhaZix", "Lissandra", "Mordekaiser", "Nami", "Nidalee", "Riven", "Shaco", "Sona", "Soraka", "Vladimir", "Yasuo", "Zilean", "Zyra"},
        p2 = {"Ahri", "Anivia", "Annie",  "Brand",  "Cassiopeia", "Ekko", "Karma", "Karthus", "Katarina", "Kennen", "LeBlanc",  "Lux", "Malzahar", "MasterYi", "Orianna", "Syndra", "Talon",  "TwistedFate", "Veigar", "VelKoz", "Viktor", "Xerath", "Zed", "Ziggs" },
        p1 = {"Ashe", "Caitlyn", "Corki", "Draven", "Ezreal", "Graves", "Jinx", "Kalista", "KogMaw", "Lucian", "MissFortune", "Quinn", "Sivir", "Teemo", "Tristana", "Twitch", "Varus", "Vayne"},
    }
     local priorityOrder = {
        [1] = {1,1,1,1,1},
        [2] = {1,1,2,2,2},
        [3] = {1,1,2,3,3},
        [4] = {1,2,3,4,4},
        [5] = {1,2,3,4,5},
    }
    local function _SetPriority(tab, hero, priority)
        if table ~= nil and hero ~= nil and priority ~= nil and type(table) == "table" then
            for i=1, #tab, 1 do
                if tostring(hero.charName):find(tostring(tab[i])) ~= nil and type(priority) == "number" then
                    TS_SetHeroPriority(priority, hero.charName)
                end
            end
        end
    end
    local enemies = #GetEnemyHeroes()
    if priorityTable2~=nil and type(priorityTable2) == "table" and enemies > 0 then
        for i, enemy in ipairs(GetEnemyHeroes()) do
            _SetPriority(priorityTable2.p1, enemy, math.min(1, #GetEnemyHeroes()))
            _SetPriority(priorityTable2.p2, enemy, math.min(2, #GetEnemyHeroes()))
            _SetPriority(priorityTable2.p3,  enemy, math.min(3, #GetEnemyHeroes()))
            _SetPriority(priorityTable2.p4,  enemy, math.min(4, #GetEnemyHeroes()))
            _SetPriority(priorityTable2.p5,  enemy, math.min(5, #GetEnemyHeroes()))
        end
    end
end

--CLASS: _AutoSmite
function _AutoSmite:__init()
    self.Spell = _Spell({Slot = FindSummonerSlot("smite"), DamageName = "SMITE", Range = 780, Type = SPELL_TYPE.TARGETTED})
    if self.Spell.Slot ~= nil then
        if _G.SimpleAutoSmite == nil then
            self.JungleMinions = minionManager(MINION_JUNGLE, self.Spell.Range + 100, myHero, MINION_SORT_MAXHEALTH_DEC)
            _G.SimpleAutoSmite = scriptConfig("SimpleLib - Auto Smite", "SimpleAutoSmite".."07072015"..tostring(myHero.charName))
            _G.SimpleAutoSmite:addParam("Baron", "Use Smite on Dragon/Baron", SCRIPT_PARAM_ONOFF, true)
            _G.SimpleAutoSmite:addParam("Killsteal", "Use Smite to Killsteal", SCRIPT_PARAM_ONOFF, true)
            AddTickCallback(
                function()
                    if self.Spell:IsReady() then
                        if _G.SimpleAutoSmite.Baron then
                            self.JungleMinions:update()
                            for i, minion in pairs(self.JungleMinions.objects) do
                                if self.Spell:ValidTarget(minion) and minion.health > 0 and (tostring(minion.charName):lower():find("dragon") or tostring(minion.charName):lower():find("baron")) then
                                    if self.Spell:Damage(minion) > minion.health then
                                        self.Spell:Cast(minion)
                                    end
                                end
                            end
                        end
                        if _G.SimpleAutoSmite.Killsteal then
                            for i, enemy in ipairs(GetEnemyHeroes()) do
                                if self.Spell:ValidTarget(enemy) and self.Spell:Damage(enemy) > enemy.health then
                                    self.Spell:Cast(enemy)
                                end
                            end
                        end
                    end
                end
            )
        end
    end
end

--CLASS: _CircleManager
function _CircleManager:__init()
    self.circles = {}
    AddDrawCallback(
        function()
            if #self.circles > 0 and not myHero.dead then
                for _, circle in ipairs(self.circles) do
                    local menu = circle.Menu
                    local condition = true
                    if circle.Condition ~= nil then
                        if type(circle.Condition) == "function" then
                            condition = circle.Condition()
                        elseif type(circle.Condition) == "boolean" then
                            condition = circle.Condition
                        end
                    end
                    if menu.Enable and condition then
                        local source = myHero
                        local range = 0
                        if circle.Source ~= nil then
                            if type(circle.Source) == "function" then
                                source = circle.Source()
                            elseif type(circle.Source) == "boolean" then
                                source = circle.Source
                            end
                        end
                        if circle.Range ~= nil then
                            if type(circle.Range) == "function" then
                                range = circle.Range()
                            elseif type(circle.Range) == "number" then
                                range = circle.Range
                            end
                        end
                        if source ~= nil and range > 0 then
                            local mode      = circle.Mode
                            local color     = menu.Color
                            local width     = menu.Width
                            local quality   = menu.Quality
                            local pos = WorldToScreen(D3DXVECTOR3(source.x , source.y, source.z))
                            if mode == CIRCLE_MANAGER.CIRCLE_2D and OnScreen(pos.x, pos.y) then
                                DrawCircle2D(source.x, source.y, range, width, ARGB(color[1], color[2], color[3], color[4]), quality)
                            elseif mode == CIRCLE_MANAGER.CIRCLE_3D and OnScreen(pos.x, pos.y) then
                                if OnScreen(pos.x, pos.y) and range <= 1800 then
                                    DrawCircle3D(source.x, source.y, source.z, range, width, ARGB(color[1], color[2], color[3], color[4]), quality)
                                elseif range > 1800 then
                                    DrawCircleMinimap(source.x, source.y, source.z, range, width, ARGB(color[1], color[2], color[3], color[4]), quality)
                                end
                            elseif mode == CIRCLE_MANAGER.CIRCLE_MINIMAP then
                                DrawCircleMinimap(source.x, source.y, source.z, range, width, ARGB(color[1], color[2], color[3], color[4]), quality)
                            end
                        end
                    end
                end
            end
        end
    )
end

function _CircleManager:AddCircle(circle)
    table.insert(self.circles, circle)
end

--CLASS: _Circle
function _Circle:__init(t)
    self.Menu = nil
    assert(t and type(t) == "table", "_Circle: table is invalid!")
    assert(t.Menu ~= nil, "_Circle: Table doesn't have Menu!")
    self.Mode = nil
    self.Name = nil
    self.Text = nil
    self.Range = nil
    self.Condition = nil
    self.Source = nil
    if t ~= nil then
        if t.Menu ~= nil then
            local mode = t.Mode ~= nil and t.Mode or CIRCLE_MANAGER.CIRCLE_3D
            local name = t.Name ~= nil and t.Name or "Circle"..tostring(#CircleManager.circles + 1)
            local text = t.Text ~= nil and t.Text or name
            local range = 0
            if t.Range ~= nil then
                if type(t.Range) == "function" then
                    range = t.Range()
                elseif type(t.Range) == "number" then
                    range = t.Range
                end
            end
            t.Menu:addSubMenu(text, name)
            self.Menu = t.Menu[name]
            if self.Menu ~= nil then
                local enable = true
                if t.Enable ~= nil and type(t.Enable) == "boolean" then enable = t.Enable end
                local color = t.Color ~= nil and t.Color or { 255, 255, 255, 255 }
                local width = t.Width ~= nil and t.Width or 1
                local quality = t.Quality ~= nil and t.Quality or math.min(math.round((range/5 + 6)/2), 30)
                self.Menu:addParam("Enable", "Enable", SCRIPT_PARAM_ONOFF, enable)
                self.Menu:addParam("Color", "Color", SCRIPT_PARAM_COLOR, color)
                self.Menu:addParam("Width", "Width", SCRIPT_PARAM_SLICE, width, 1, 6)
                self.Menu:addParam("Quality", "Quality", SCRIPT_PARAM_SLICE, quality, 10, math.round(range/5))
            end
            self.Mode = mode
            self.Name = name
            self.Text = text
            self.Range = t.Range
            self.Condition = t.Condition
            self.Source = t.Source ~= nil and t.Source or myHero
            CircleManager:AddCircle(self)
        end
    end
    return self
end

function _SpellManager:__init()
    self.spells = {}
end

function _SpellManager:AddSpell(spell)
    table.insert(self.spells, spell)
end

function _SpellManager:InitMenu()
    if _G.SpellManagerMenu == nil then
        _G.SpellManagerMenu = scriptConfig("SimpleLib - Spell Manager", "SpellManager".."19052015"..tostring(myHero.charName))
        if VIP_USER then
            _G.SpellManagerMenu:addParam("Packet", "Enable Packets", SCRIPT_PARAM_ONOFF, false)
            _G.SpellManagerMenu:addParam("Exploit", "Enable No-Face Exploit", SCRIPT_PARAM_ONOFF, false)
        end
        _G.SpellManagerMenu:addParam("DisableDraws", "Disable All Draws", SCRIPT_PARAM_ONOFF, false)
        local tab = {" "}
        for i, name in ipairs(Prediction.PredictionList) do
            table.insert(tab, name)
        end
        _G.SpellManagerMenu:addParam("PredictionSelected", "Set All Skillshots to: ", SCRIPT_PARAM_LIST, 1, tab)
        _G.SpellManagerMenu.PredictionSelected = 1
        _G.SpellManagerMenu:setCallback("PredictionSelected",
            function(v)
                if v and v ~= 1 then
                    --print(tostring(_G.SpellManagerMenu._param[_G.SpellManagerMenu:getParamIndex("PredictionSelected")].listTable[v]))
                    for i, spell in ipairs(self.spells) do
                        if spell.Menu ~= nil then
                            if spell.Menu.PredictionSelected ~= nil then
                                spell.Menu.PredictionSelected = _G.SpellManagerMenu.PredictionSelected -1
                            end
                        end
                    end
                end
            end
            )
    end
end

function _SpellManager:AddLastHit()
    if _G.SpellManagerMenu ~= nil then
        if not _G.SpellManagerMenu.FarmDelay then
            _G.SpellManagerMenu:addParam("FarmDelay", "Delay for LastHit (in ms)", SCRIPT_PARAM_SLICE, 0, -150, 150)
        end
    end
end

--CLASS: _Spell
function _Spell:__init(tab)
    assert(tab and type(tab) == "table", "_Spell: Table is invalid!")
    self.LastCastTime = 0
    self.LastSentTime = 0
    self.Object = nil
    self.Source = myHero
    self.DrawSource = myHero
    self.TS = nil
    self.Menu = nil
    --self.LastHitMode = LASTHIT_MODE.NEVER
    if tab ~= nil then
        self.Type = tab.Type ~= nil and tab.Type or SPELL_TYPE.SELF
        self.Slot = tab.Slot
        self.IsForEnemies = true
        if tab.IsForEnemies ~= nil and type(tab.IsForEnemies) == "boolean" then self.IsForEnemies = tab.IsForEnemies end
        self.DamageName = nil
        if tab.DamageName ~= nil then
            self.DamageName = tab.DamageName
            self.Name = tab.DamageName
        elseif self.Slot ~= nil then
            self.DamageName = SlotToString(self.Slot)
            self.Name = SlotToString(self.Slot)
        else
            self.Name = "Spell"..tostring(#SpellManager.spells + 1)
        end
        assert(tab.Range and type(tab.Range) == "number", "_Spell: Range is invalid!")
        self.Range = tab.Range
        self.Width = tab.Width ~= nil and tab.Width or 1
        self.EnemyMinions = minionManager(MINION_ENEMY, self.Range + self.Width + 50, self.Source, MINION_SORT_MAXHEALTH_DEC)
        self.JungleMinions = minionManager(MINION_JUNGLE, self.Range + self.Width + 50, self.Source, MINION_SORT_MAXHEALTH_DEC)
        self.Delay = tab.Delay ~= nil and tab.Delay or 0
        self.Speed = tab.Speed ~= nil and tab.Speed or math.huge
        self.Collision = tab.Collision ~= nil and tab.Collision or false
        self.Aoe = tab.Aoe ~= nil and tab.Aoe or false
        self.IsVeryLowAccuracy = tab.IsVeryLowAccuracy
        if self:IsSkillShot() then
            self:AddToMenu()
            if self.Menu ~= nil then
                self.Menu:addParam("PredictionSelected", "Prediction Selection", SCRIPT_PARAM_LIST, 1, Prediction.PredictionList)
                Prediction:LoadPrediction(tostring(self.Menu._param[self.Menu:getParamIndex("PredictionSelected")].listTable[self.Menu.PredictionSelected]))
                local lastest = self.Menu.PredictionSelected
                self.Menu:setCallback("PredictionSelected",
                    function(v)
                        if v then
                            Prediction:LoadPrediction(tostring(self.Menu._param[self.Menu:getParamIndex("PredictionSelected")].listTable[v]))
                            if tostring(self.Menu._param[self.Menu:getParamIndex("PredictionSelected")].listTable[v]) == "DivinePred" then
                                Prediction:BindSpell(self)
                            end
                            if tostring(self.Menu._param[self.Menu:getParamIndex("PredictionSelected")].listTable[lastest]) == "DivinePred" and v ~= lastest then
                                local boolean = true
                                for i, spell in ipairs(SpellManager.spells) do
                                    if spell.Menu ~= nil then
                                        if spell.Menu.PredictionSelected ~= nil then
                                            if tostring(spell.Menu._param[spell.Menu:getParamIndex("PredictionSelected")].listTable[spell.Menu.PredictionSelected]) == "DivinePred" then
                                                boolean = false
                                            end
                                        end
                                    end
                                end
                                if boolean then
                                    if not self.Draw then
                                        self.Draw = true
                                        AddDrawCallback(
                                            function()
                                                local p = WorldToScreen(D3DXVECTOR3(myHero.x, myHero.y, myHero.z))
                                                local boolean = true
                                                for i, spell in ipairs(SpellManager.spells) do
                                                    if spell.Menu ~= nil then
                                                        if spell.Menu.PredictionSelected ~= nil then
                                                            if tostring(spell.Menu._param[spell.Menu:getParamIndex("PredictionSelected")].listTable[spell.Menu.PredictionSelected]) == "DivinePred" then
                                                                boolean = false
                                                            end
                                                        end
                                                    end
                                                end
                                                if OnScreen(p.x, p.y) and boolean then
                                                    DrawText("Press 2x F9!", 25, p.x, p.y, ARGB(255, 255, 255, 255))
                                                end
                                            end
                                        )
                                    end
                                end
                            end
                            lastest = v
                        end
                    end
                    )
                self.Menu:addParam("Combo", "X % Combo Accuracy", SCRIPT_PARAM_SLICE, 60, 0, 100)
                self.Menu:addParam("Harass", "X % Harass Accuracy", SCRIPT_PARAM_SLICE, 70, 0, 100)
                self.Menu:addParam("info", "80 % ~ Super High Accuracy", SCRIPT_PARAM_INFO, "")
                self.Menu:addParam("info2", "60 % ~ High Accuracy (Recommended)", SCRIPT_PARAM_INFO, "")
                self.Menu:addParam("info3", "30 % ~ Medium Accuracy", SCRIPT_PARAM_INFO, "")
                self.Menu:addParam("info4", "10 % ~ Low Accuracy", SCRIPT_PARAM_INFO, "")
            end
            Prediction:BindSpell(self)
        elseif self:IsSelf() then

        end
        SpellManager:AddSpell(self)
    end
    return self
end

function _Spell:AddDraw(t)
    self:AddToMenu()
    if self.Menu ~= nil then
        local table = {Menu = self.Menu, Name = "Draw", Text = "Drawing Settings", Source = function() if self.DrawSourceFunction ~= nil then return self.DrawSource end return self.Source end, Range = function() return self.Range end, Condition = function() return self:IsReady() and not _G.SpellManagerMenu.DisableDraws end}
        local enable = true
        if t ~= nil and t.Enable ~= nil and type(t.Enable) == "boolean" then enable = t.Enable end
        local color = t ~= nil and t.Color ~= nil and t.Color or { 255, 255, 255, 255 }
        local width = t ~= nil and t.Width ~= nil and t.Width or 1
        table.Enable = enable
        table.Color = color
        table.Width = width
        _Circle(table)
    end
    return self
end

function _Spell:AddTrackTime(t)
    assert(t and (type(t) == "string" or type(t) == "table"), "_Spell: AddTrackTime is invalid!")
    self.Track = type(t) == "table" and t or { t }
    self:LoadProcessSpellCallback()
    return self
end

function _Spell:AddTrackCallback(func)
    assert(self.Track and type(self.Track) == "table", "_Spell: AddTrackCallback needs TrackTime!")
    assert(func and type(func) == "function", "_Spell: AddTrackCallback needs function!")
    self.TrackCallback = func
    return self
end

function _Spell:AddRangeFunction(rngFunc)
    assert(rngFunc and type(rngFunc) == "function", "_Spell: RangeFunction is invalid!")
    self.RangeFunction = rngFunc
    self:LoadTickCallback()
    return self
end
function _Spell:AddWidthFunction(func)
    assert(func and type(func) == "function", "_Spell: WidthFunction is invalid!")
    self.WidthFunction = func
    self:LoadTickCallback()
    return self
end

function _Spell:AddTypeFunction(f)
    assert(f and type(f) == "function", "_Spell: TypeFunction is invalid!")
    self.TypeFunction = f
    self:LoadTickCallback()
    return self
end

function _Spell:AddDamageFunction(f)
    assert(f and type(f) == "function", "_Spell: DamageFunction is invalid!")
    self.DamageFunction = f
    return self
end

function _Spell:AddSlotFunction(f)
    assert(f and type(f) == "function", "_Spell: SlotFunction is invalid!")
    self.SlotFunction = f
    self:LoadTickCallback()
    return self
end

function _Spell:AddSourceFunction(srcFunc)
    assert(srcFunc and type(srcFunc) == "function", "_Spell: SourceFunction is invalid!")
    self.SourceFunction = srcFunc
    self:LoadTickCallback()
    return self
end

function _Spell:AddDrawSourceFunction(drawSrcFunc)
    assert(drawSrcFunc and type(drawSrcFunc) == "function", "_Spell: DrawSourceFunction is invalid!")
    self.DrawSourceFunction = drawSrcFunc
    self:LoadTickCallback()
    return self
end

function _Spell:AddTrackObject(t)
    assert(t and (type(t) == "string" or type(t) == "table"), "_Spell: AddTrackObject is invalid!")
    self.TrackObject = type(t) == "table" and t or { t }
    self:LoadCreateAndDeleteCallback()
    return self
end

function _Spell:SetAccuracy(int)
    if self.Menu ~= nil then
        assert(int and type(int) == "number", "_Spell: SetAccuracy is invalid!")
        self.Menu.Combo = int
        self.Menu.Harass = int + 10
    end
    return self
end

function _Spell:YasuoWall(vector)
    if YasuoWall ~= nil and self.Speed ~= math.huge and vector ~= nil then
        for i, enemy in ipairs(GetEnemyHeroes()) do
            if tostring(enemy.charName):lower():find("yasuo") then
                local level = enemy:GetSpellData(_W) ~= nil and enemy:GetSpellData(_W).level ~= nil and enemy:GetSpellData(_W).level or 0
                local width = 250 + level * 50
                local pos1 = Vector(YasuoWall.Object) + Vector(Vector(YasuoWall.Object) - Vector(YasuoWall.StartVector)):normalized():perpendicular() * width/2
                local pos2 = Vector(YasuoWall.Object) + Vector(Vector(YasuoWall.Object) - Vector(YasuoWall.StartVector)):normalized():perpendicular2() * width/2
                local p1 = WorldToScreen(D3DXVECTOR3(pos1.x, pos1.y, pos1.z))
                local p2 = WorldToScreen(D3DXVECTOR3(pos2.x, pos2.y, pos2.z))
                local p3 = WorldToScreen(D3DXVECTOR3(self.Source.x, self.Source.y, self.Source.z))
                local p4 = WorldToScreen(D3DXVECTOR3(vector.x, vector.y, vector.z))
                return IsLineSegmentIntersection(p1, p2, p3, p4)
            end
        end
    end
    return false
end

function _Spell:CastToVector(vector)
    if self:IsReady() and vector ~= nil and not IsEvading() then
        if self:YasuoWall(vector) then return end
        self.LastSentTime = os.clock()
        CastSpell(self.Slot, vector.x, vector.z)
    end
end

function _Spell:Cast(target, t)
    if self:IsReady() and not IsEvading() then
        if self:ValidTarget(target) then
            if OrbwalkManager:IsHarass() and target.type == myHero.type then
                if OrbwalkManager:IsAttacking() and OrbwalkManager.AA.LastTarget and OrbwalkManager.AA.LastTarget.type ~= myHero.type then return end
                if OrbwalkManager:ShouldWait() then return end
            end
            if self:IsSkillShot() then
                local CastPosition, WillHit = self:GetPrediction(target, t)
                if CastPosition ~= nil and WillHit then
                    self.LastSentTime = os.clock()
                    self:CastToVector(CastPosition)
                end
            elseif self:IsTargetted() then
                if self:YasuoWall(target) then return end
                self.LastSentTime = os.clock()
                CastSpell(self.Slot, target)
            elseif self:IsSelf() then
                local CastPosition,  WillHit = self:GetPrediction(target, t)
                if CastPosition ~= nil and GetDistanceSqr(self.Source, CastPosition) <= self.Range * self.Range then
                    if (target.type == myHero.type and WillHit) or (target.type ~= myHero.type) then
                        self.LastSentTime = os.clock()
                        CastSpell(self.Slot)
                    end
                end
            end
        elseif target == nil and self:IsSelf() then
            self.LastSentTime = os.clock()
            CastSpell(self.Slot)
        end
    end
end

function _Spell:GetPrediction(target, t)
    local range = t ~= nil and t.Range ~= nil and t.Range or self.Range
    if self:ValidTarget(target, range) then
        if self:IsSkillShot() then
            local pred = t ~= nil and t.TypeOfPrediction ~= nil and t.TypeOfPrediction or self:PredictionSelected()
            local accuracy = t ~= nil and t.Accuracy ~= nil and t.Accuracy or self:GetAccuracy()
            local source = t ~= nil and t.Source ~= nil and t.Source or self.Source
            local delay = t ~= nil and t.Delay ~= nil and t.Delay or self.Delay
            local speed = t ~= nil and t.Speed ~= nil and t.Speed or self.Speed
            local width = t ~= nil and t.Width ~= nil and t.Width or self.Width
            local type = t ~= nil and t.Type ~= nil and t.Type or self.Type
            local tab = {Delay = delay, Width = width, Speed = speed, Range = range, Source = source, Type = type, Collision = self.Collision, Aoe = self.Aoe, TypeOfPrediction = pred, Accuracy = accuracy, Slot = self.Slot, IsVeryLowAccuracy = self.IsVeryLowAccuracy, Name = self.Name}
            return Prediction:GetPrediction(target, tab)
        elseif self:IsSelf() then
            local pred = t ~= nil and t.TypeOfPrediction ~= nil and t.TypeOfPrediction or self:PredictionSelected()
            local accuracy = t ~= nil and t.Accuracy ~= nil and t.Accuracy or self:GetAccuracy()
            local source = t ~= nil and t.Source ~= nil and t.Source or self.Source
            local tab = {Delay = self.Delay, Speed = self.Speed, Source = source, Collision = self.Collision, TypeOfPrediction = pred, Accuracy = accuracy}
            return Prediction:GetPredictedPos(target, tab)
        end
    end
    return Vector(target), false, Vector(target)
end

function _Spell:LoadTickCallback()
    if not self.TickCallback then
        self.TickCallback = true
        local LastTick = 0
        local Interval = 10 --segs
        AddTickCallback(
            function()
                if myHero.dead then return end

                if self.SourceFunction ~= nil then
                    self.Source = self.SourceFunction()
                end

                if self.RangeFunction ~= nil then
                    self.Range = self.RangeFunction()
                end

                if self.TypeFunction ~= nil then
                    self.Type = self.TypeFunction()
                end

                if self.DrawSourceFunction ~= nil then
                    self.DrawSource = self.DrawSourceFunction()
                end

                if self.WidthFunction ~= nil then
                    self.Width = self.WidthFunction()
                end
                if self.SlotFunction ~= nil then
                    if os.clock() - LastTick > Interval then
                        self.Slot = self.SlotFunction()
                        LastTick = os.clock()
                    end
                end
            end
        )
    end
end

function _Spell:LoadCreateAndDeleteCallback()
    if not self.ObjectCallback then
        AddCreateObjCallback(
            function(obj)
                if obj and obj.name and self.Object == nil and os.clock() - self.LastCastTime > self.Delay * 0.8 and os.clock() - self.LastCastTime < self.Delay * 1.2 then
                    local name = tostring(obj.name):lower()
                    if name == "missile" and ( (obj.spellOwner and obj.spellOwner.isMe) or GetDistanceSqr(self.Source, obj) < 10 * 10) then
                        for _, s in ipairs(self.TrackObject) do
                            if obj.name:lower():find(s:lower()) then
                                self.Object = obj
                            end
                        end
                    end
                end
            end
        )
        AddDeleteObjCallback(
            function(obj)
                if obj and obj.name and self.Object ~= nil and tostring(obj.name):lower() == "missile" and GetDistanceSqr(obj, self.Object) < math.pow(10, 2) then
                    for _, s in ipairs(self.TrackObject) do
                        if obj.name:lower():find(s:lower()) then
                            self.Object = nil
                        end
                    end
                end
            end
        )
        self.ObjectCallback = true
    end
end

function _Spell:LoadProcessSpellCallback()
    if not self.ProcessCallback then
        self.ProcessCallback = true
        if AddProcessSpellCallback then
            AddProcessSpellCallback(function(unit, spell) self:OnProcessSpell(unit, spell) end)
        end
        if AddProcessAttackCallback then
            AddProcessAttackCallback(function(unit, spell) self:OnProcessSpell(unit, spell) end)
        end
    end
end

function _Spell:OnProcessSpell(unit, spell)
    if unit and spell and spell.name and unit.isMe then
        if self.Track ~= nil then
            for _, s in ipairs(self.Track) do
                if tostring(spell.name):lower():find(tostring(s):lower()) then
                    self.LastCastTime = os.clock()
                    if self.TrackCallback ~= nil then
                        self.TrackCallback(spell)
                    end
                end
            end
        end
    end
end

function _Spell:IsLinear()
    return self.Type == SPELL_TYPE.LINEAR
end

function _Spell:IsCircular()
    return self.Type == SPELL_TYPE.CIRCULAR
end

function _Spell:IsCone()
    return self.Type == SPELL_TYPE.CONE
end

function _Spell:IsSkillShot()
    return self:IsLinear() or self.Type == SPELL_TYPE.CIRCULAR or self.Type == SPELL_TYPE.CONE
end

function _Spell:IsSelf()
    return self.Type == SPELL_TYPE.SELF
end

function _Spell:IsTargetted()
    return self.Type == SPELL_TYPE.TARGETTED
end

function _Spell:PredictionSelected()
    local int = self.Menu ~= nil and self.Menu.PredictionSelected or 1
    return Prediction.PredictionList[int] ~= nil and tostring(Prediction.PredictionList[int]) or "VPrediction"
end

function _Spell:ValidTarget(target, range)
    local source = self.DrawSourceFunction ~= nil and self.DrawSource or self.Source
    local extrarange = self:IsCircular() and self.Width or 0
    local range = range ~= nil and range or self.Range
    return IsValidTarget(target, math.huge, self.IsForEnemies) and GetDistanceSqr(source, target) <= math.pow(range + extrarange, 2)
end

function _Spell:ObjectsInArea(objects)
    local objects2 = {}
    if objects ~= nil and self:IsSelf() and self:IsReady() then
        for i, object in ipairs(objects) do
            if self:ValidTarget(object) then
                local Position, WillHit = self:GetPrediction(object)
                if GetDistanceSqr(self.Source, Position) <= self.Range * self.Range then
                    if object.type == myHero.type then
                        if WillHit then
                            table.insert(objects2, object)
                        end
                    else
                        table.insert(objects2, object)
                    end
                end
            end
        end
    end
    return objects2
end

function _Spell:IsReady()
    if tostring(myHero.charName) == "Kennen" then
        if self.Slot ~= nil and self.Slot == _W then
            return myHero:CanUseSpell(self.Slot) == READY or myHero:CanUseSpell(self.Slot) == 3
        end
    end
    return self.Slot ~= nil and (self:CanUseSpell() == READY or ( self:GetSpellData().level > 0 and self:GetSpellData().currentCd <= Latency()))
end

function _Spell:GetSpellData()
    return self.Slot ~= nil and myHero:GetSpellData(self.Slot) or nil
end

function _Spell:CanUseSpell()
    return self.Slot ~= nil and myHero:CanUseSpell(self.Slot) or nil
end

function _Spell:Damage(target, stage)
    if self.DamageName ~= nil and self.Slot ~= nil then
        if tostring(myHero.charName) == "Irelia" and self.Slot ~= nil and self.Slot == _Q then
            return getDmg(self.DamageName, target, myHero, stage) + getDmg("AD", target, myHero, stage)
        end
        if self.DamageFunction ~= nil then
            return self.DamageFunction(self.DamageName, target, stage)
        end
        if self.DamageName == "SMITE" then
            if IsValidTarget(target) then
                if target.type == myHero.type then
                    local name = self:GetSpellData() ~= nil and self:GetSpellData().name ~= nil and self:GetSpellData().name or ""
                    if name:lower():find("smiteduel") then
                        return getDmg("SMITESS", target, myHero, stage)
                    elseif name:lower():find("smiteplayerganker") then
                        return getDmg("SMITESB", target, myHero, stage)
                    end
                else
                    return math.max(20 * myHero.level + 370, 30 * myHero.level + 330, 40 * myHero.level + 240, 50 * myHero.level + 100)
                end
            end
            return 0
        end
        return getDmg(self.DamageName, target, myHero, stage)
    end
    return 0
end

function _Spell:Mana()
    return self.Slot ~= nil and myHero:GetSpellData(self.Slot) ~= nil and myHero:GetSpellData(self.Slot).mana ~= nil and myHero:GetSpellData(self.Slot).mana or 0
end

function _Spell:GetAccuracy()
    if self.Menu ~= nil then
        if not OrbwalkManager:IsNone() then
            if OrbwalkManager:IsHarass() then
                return self.Menu.Harass
            else
                return self.Menu.Combo
            end
        end
    end
    return 60
end
--TODO: Normalize this
function _Spell:LaneClear(tab)
    if self.EnemyMinions ~= nil and self:IsReady() then
        if self.SourceFunction ~= nil then
            self.EnemyMinions.fromPos = self.Source
        end
        if self.RangeFunction ~= nil then
            self.EnemyMinions.range = self.Range
        end
        self.EnemyMinions:update()
        local NumberOfHits = tab ~= nil and tab.NumberOfHits ~= nil and type(tab.NumberOfHits) == "number" and tab.NumberOfHits or 1
        local UseCast = true
        if tab ~= nil and tab.UseCast ~= nil and type(tab.UseCast) == "boolean" then UseCast = tab.UseCast end
        if NumberOfHits >= 1 and #self.EnemyMinions.objects >= NumberOfHits then
            if self:IsLinear() then
                local bestMinion, hits = GetBestLineFarmPosition(self.Range, self.Width, self.EnemyMinions.objects)
                if hits >= NumberOfHits then
                    if UseCast then
                        self:Cast(bestMinion)
                    end
                    return bestMinion
                end
            elseif self:IsCircular() then
                local bestMinion, hits = GetBestCircularFarmPosition(self.Range, self.Width, self.EnemyMinions.objects)
                if hits >= NumberOfHits then
                    if UseCast then
                        self:Cast(bestMinion)
                    end
                    return bestMinion
                end
            elseif self:IsCone() then
                local bestMinion, hits = GetBestLineFarmPosition(self.Range, self.Width, self.EnemyMinions.objects)
                if hits >= NumberOfHits then
                    if UseCast then
                        self:Cast(bestMinion)
                    end
                    return minion
                end
            elseif self:IsSelf() then
                local objects = self:ObjectsInArea(self.EnemyMinions.objects)
                local hits = #objects
                if hits >= NumberOfHits then
                    local bestMinion = nil
                    for i, minion in pairs(objects) do
                        bestMinion = minion
                        break
                    end
                    if UseCast then
                        self:Cast(bestMinion)
                    end
                    return bestMinion
                end
            elseif self:IsTargetted() then
                local bestMinion = nil
                for i, minion in pairs(self.EnemyMinions.objects) do
                    if self:IsReady() then
                        self:Cast(minion)
                        bestMinion = minion
                    end
                end
                return bestMinion
            end
        end
    end
    return nil
end

function _Spell:JungleClear(tab)
    if self.JungleMinions ~= nil and self:IsReady() then
        if self.SourceFunction ~= nil then
            self.JungleMinions.fromPos = self.Source
        end
        if self.RangeFunction ~= nil then
            self.JungleMinions.range = self.Range
        end
        self.JungleMinions:update()
        local NumberOfHits = 1
        local UseCast = true
        if tab ~= nil and tab.UseCast ~= nil and type(tab.UseCast) == "boolean" then UseCast = tab.UseCast end
        if self:IsLinear() then
            local bestMinion, hits = GetBestLineFarmPosition(self.Range, self.Width, self.JungleMinions.objects)
            if hits >= NumberOfHits then
                if UseCast then
                    self:Cast(bestMinion)
                end
                return bestMinion
            end
        elseif self:IsCircular() then
            local bestMinion, hits = GetBestCircularFarmPosition(self.Range, self.Width, self.JungleMinions.objects)
            if hits >= NumberOfHits then
                if UseCast then
                    self:Cast(bestMinion)
                end
                return bestMinion
            end
        elseif self:IsCone() then
            local bestMinion, hits = GetBestLineFarmPosition(self.Range, self.Width, self.JungleMinions.objects)
            if hits >= NumberOfHits then
                if UseCast then
                    self:Cast(bestMinion)
                end
            end
            return bestMinion
        elseif self:IsSelf() then
            local objects = self:ObjectsInArea(self.JungleMinions.objects)
            local hits = #objects
            if hits >= NumberOfHits then
                local bestMinion = nil
                for i, minion in pairs(objects) do
                    bestMinion = minion
                    break
                end
                if UseCast then
                    self:Cast(bestMinion)
                end
                return bestMinion
            end
        elseif self:IsTargetted() then
            local bestMinion = nil
            for i, minion in pairs(self.JungleMinions.objects) do
                if self:IsReady() then
                    if UseCast then
                        self:Cast(minion)
                        bestMinion = minion
                    end
                end
            end
            return bestMinion
        end
    end
    return nil
end

function _Spell:LastHit(tab)
    SpellManager:AddLastHit()
    local mode = tab ~= nil and tab.Mode ~= nil and type(tab.Mode) == "number" and tab.Mode or LASTHIT_MODE.SMART
    if self.EnemyMinions ~= nil and (self:IsSkillShot() or self:IsTargetted() or self:IsSelf()) and mode ~= LASTHIT_MODE.NEVER and self:IsReady() and _G.VP then
        if self.SourceFunction ~= nil then
            self.EnemyMinions.fromPos = self.Source
        end
        if self.RangeFunction ~= nil then
            self.EnemyMinions.range = self.Range
        end        
        local UseCast = true
        if tab ~= nil and tab.UseCast ~= nil and type(tab.UseCast) == "boolean" then UseCast = tab.UseCast end
        if self:IsReady() then
            self.EnemyMinions:update()
            for i, object in pairs(self.EnemyMinions.objects) do
                if self:IsReady() and self:ValidTarget(object) and not object.dead and object.health > 0 then
                    local delay = _G.SpellManagerMenu.FarmDelay ~= nil and _G.SpellManagerMenu.FarmDelay or 0
                    local CanCalculate = false
                    if mode == LASTHIT_MODE.SMART then
                        if not OrbwalkManager:CanAttack() then
                            if  OrbwalkManager.AA.LastTarget and object.networkID ~= OrbwalkManager.AA.LastTarget.networkID and not OrbwalkManager:IsAttacking() then
                                CanCalculate = true
                            end
                        else
                            if not OrbwalkManager:InRange(object) then
                                CanCalculate = true
                            else
                                local ProjectileSpeed = _G.VP:GetProjectileSpeed(myHero)
                                local time = OrbwalkManager:WindUpTime() + GetDistance(myHero, object) / ProjectileSpeed + ExtraTime()
                                local predHealth = _G.VP:GetPredictedHealth(object, time, delay)
                                if predHealth <= 20 then
                                    CanCalculate = true
                                end
                            end
                        end
                    elseif mode == LASTHIT_MODE.ALWAYS then
                        CanCalculate = true
                    end
                    if CanCalculate then
                        local dmg = self:Damage(object)
                        local time = 0
                        if self:IsSkillShot() then
                            time = self.Delay + GetDistance(object, self.Source) / self.Speed + ExtraTime()
                        elseif self:IsTargetted() then
                            time = self.Delay + GetDistance(object, self.Source) / self.Speed + ExtraTime()
                        elseif self:IsSelf() then
                            time = self.Delay + GetDistance(object, self.Source) / self.Speed + ExtraTime()
                        end
                        local predHealth = _G.VP:GetPredictedHealth(object, time, delay)
                        if predHealth == object.health and self.Delay + GetDistance(object, self.Source) / self.Speed > 0 and mode == LASTHIT_MODE.SMART then return end 
                        if dmg > predHealth and predHealth > -1 then
                            if UseCast then
                               self:Cast(object)
                            end
                            return object
                        end
                    end
                end
            end
        end
    end
end

function _Spell:AddToMenu()
    SpellManager:InitMenu()
    if self.Menu == nil then
        _G.SpellManagerMenu:addSubMenu(self.Name.." Settings", self.Name)
        self.Menu = _G.SpellManagerMenu[self.Name]
    end
end

--CLASS: _Prediction
function _Prediction:__init()
    self.UnitsImmobile = {}
    self.PredictionList = {}
    self.Actives = {
        ["VPrediction"] = false,
        ["HPrediction"] = false,
        ["DivinePred"] = false,
        ["SPrediction"] = false,
        ["Prodiction"] = false,
    }
    if FileExist(LIB_PATH.."VPrediction.lua") then
        table.insert(self.PredictionList, "VPrediction")
        require "VPrediction"
        self.Actives["VPrediction"] = true
        self.VP = VPrediction()
        _G.VP = self.VP
        if _G.VP.version < 2.973 then
            PrintMessage("Downloading the lastest version of VPrediction...")
            local r = _Required()
            local d = _Downloader({Name = "VPrediction", Url = "raw.githubusercontent.com/SidaBoL/Scripts/master/Common/VPrediction.lua", Extension = "lua", UseHttps = true})
            table.insert(r.downloading, d)
            r:Check()
        end
        self.VP.projectilespeeds = {["Velkoz"]= 2000, ["TeemoMushroom"] = math.huge, ["TestCubeRender"] = math.huge ,["Xerath"] = 2000.0000 ,["Kassadin"] = math.huge ,["Rengar"] = math.huge ,["Thresh"] = 1000.0000 ,["Ziggs"] = 1500.0000 ,["ZyraPassive"] = 1500.0000 ,["ZyraThornPlant"] = 1500.0000 ,["KogMaw"] = 1800.0000 ,["HeimerTBlue"] = 1599.3999 ,["EliseSpider"] = 500.0000 ,["Skarner"] = 500.0000 ,["ChaosNexus"] = 500.0000 ,["Katarina"] = 467.0000 ,["Riven"] = 347.79999 ,["SightWard"] = 347.79999 ,["HeimerTYellow"] = 1599.3999 ,["Ashe"] = 2000.0000 ,["VisionWard"] = 2000.0000 ,["TT_NGolem2"] = math.huge ,["ThreshLantern"] = math.huge ,["TT_Spiderboss"] = math.huge ,["OrderNexus"] = math.huge ,["Soraka"] = 1000.0000 ,["Jinx"] = 2750.0000 ,["TestCubeRenderwCollision"] = 2750.0000 ,["Red_Minion_Wizard"] = 650.0000 ,["JarvanIV"] = 20.0000 ,["Blue_Minion_Wizard"] = 650.0000 ,["TT_ChaosTurret2"] = 1200.0000 ,["TT_ChaosTurret3"] = 1200.0000 ,["TT_ChaosTurret1"] = 1200.0000 ,["ChaosTurretGiant"] = 1200.0000 ,["Dragon"] = 1200.0000 ,["LuluSnowman"] = 1200.0000 ,["Worm"] = 1200.0000 ,["ChaosTurretWorm"] = 1200.0000 ,["TT_ChaosInhibitor"] = 1200.0000 ,["ChaosTurretNormal"] = 1200.0000 ,["AncientGolem"] = 500.0000 ,["ZyraGraspingPlant"] = 500.0000 ,["HA_AP_OrderTurret3"] = 1200.0000 ,["HA_AP_OrderTurret2"] = 1200.0000 ,["Tryndamere"] = 347.79999 ,["OrderTurretNormal2"] = 1200.0000 ,["Singed"] = 700.0000 ,["OrderInhibitor"] = 700.0000 ,["Diana"] = 347.79999 ,["HA_FB_HealthRelic"] = 347.79999 ,["TT_OrderInhibitor"] = 347.79999 ,["GreatWraith"] = 750.0000 ,["Yasuo"] = 347.79999 ,["OrderTurretDragon"] = 1200.0000 ,["OrderTurretNormal"] = 1200.0000 ,["LizardElder"] = 500.0000 ,["HA_AP_ChaosTurret"] = 1200.0000 ,["Ahri"] = 1750.0000 ,["Lulu"] = 1450.0000 ,["ChaosInhibitor"] = 1450.0000 ,["HA_AP_ChaosTurret3"] = 1200.0000 ,["HA_AP_ChaosTurret2"] = 1200.0000 ,["ChaosTurretWorm2"] = 1200.0000 ,["TT_OrderTurret1"] = 1200.0000 ,["TT_OrderTurret2"] = 1200.0000 ,["TT_OrderTurret3"] = 1200.0000 ,["LuluFaerie"] = 1200.0000 ,["HA_AP_OrderTurret"] = 1200.0000 ,["OrderTurretAngel"] = 1200.0000 ,["YellowTrinketUpgrade"] = 1200.0000 ,["MasterYi"] = math.huge ,["Lissandra"] = 2000.0000 ,["ARAMOrderTurretNexus"] = 1200.0000 ,["Draven"] = 1700.0000 ,["FiddleSticks"] = 1750.0000 ,["SmallGolem"] = math.huge ,["ARAMOrderTurretFront"] = 1200.0000 ,["ChaosTurretTutorial"] = 1200.0000 ,["NasusUlt"] = 1200.0000 ,["Maokai"] = math.huge ,["Wraith"] = 750.0000 ,["Wolf"] = math.huge ,["Sivir"] = 1750.0000 ,["Corki"] = 2000.0000 ,["Janna"] = 1200.0000 ,["Nasus"] = math.huge ,["Golem"] = math.huge ,["ARAMChaosTurretFront"] = 1200.0000 ,["ARAMOrderTurretInhib"] = 1200.0000 ,["LeeSin"] = math.huge ,["HA_AP_ChaosTurretTutorial"] = 1200.0000 ,["GiantWolf"] = math.huge ,["HA_AP_OrderTurretTutorial"] = 1200.0000 ,["YoungLizard"] = 750.0000 ,["Jax"] = 400.0000 ,["LesserWraith"] = math.huge ,["Blitzcrank"] = math.huge ,["ARAMChaosTurretInhib"] = 1200.0000 ,["Shen"] = 400.0000 ,["Nocturne"] = math.huge ,["Sona"] = 1500.0000 ,["ARAMChaosTurretNexus"] = 1200.0000 ,["YellowTrinket"] = 1200.0000 ,["OrderTurretTutorial"] = 1200.0000 ,["Caitlyn"] = 2500.0000 ,["Trundle"] = 347.79999 ,["Malphite"] = 1000.0000 ,["Mordekaiser"] = math.huge ,["ZyraSeed"] = math.huge ,["Vi"] = 1000.0000 ,["Tutorial_Red_Minion_Wizard"] = 650.0000 ,["Renekton"] = math.huge ,["Anivia"] = 1400.0000 ,["Fizz"] = math.huge ,["Heimerdinger"] = 1500.0000 ,["Evelynn"] = 467.0000 ,["Rumble"] = 347.79999 ,["Leblanc"] = 1700.0000 ,["Darius"] = math.huge ,["OlafAxe"] = math.huge ,["Viktor"] = 2300.0000 ,["XinZhao"] = 20.0000 ,["Orianna"] = 1450.0000 ,["Vladimir"] = 1400.0000 ,["Nidalee"] = 1750.0000 ,["Tutorial_Red_Minion_Basic"] = math.huge ,["ZedShadow"] = 467.0000 ,["Syndra"] = 1800.0000 ,["Zac"] = 1000.0000 ,["Olaf"] = 347.79999 ,["Veigar"] = 1100.0000 ,["Twitch"] = 2500.0000 ,["Alistar"] = math.huge ,["Akali"] = 467.0000 ,["Urgot"] = 1300.0000 ,["Leona"] = 347.79999 ,["Talon"] = math.huge ,["Karma"] = 1500.0000 ,["Jayce"] = 347.79999 ,["Galio"] = 1000.0000 ,["Shaco"] = math.huge ,["Taric"] = math.huge ,["TwistedFate"] = 1500.0000 ,["Varus"] = 2000.0000 ,["Garen"] = 347.79999 ,["Swain"] = 1600.0000 ,["Vayne"] = 2000.0000 ,["Fiora"] = 467.0000 ,["Quinn"] = 2000.0000 ,["Kayle"] = math.huge ,["Blue_Minion_Basic"] = math.huge ,["Brand"] = 2000.0000 ,["Teemo"] = 1300.0000 ,["Amumu"] = 500.0000 ,["Annie"] = 1200.0000 ,["Odin_Blue_Minion_caster"] = 1200.0000 ,["Elise"] = 1600.0000 ,["Nami"] = 1500.0000 ,["Poppy"] = 500.0000 ,["AniviaEgg"] = 500.0000 ,["Tristana"] = 2250.0000 ,["Graves"] = 3000.0000 ,["Morgana"] = 1600.0000 ,["Gragas"] = math.huge ,["MissFortune"] = 2000.0000 ,["Warwick"] = math.huge ,["Cassiopeia"] = 1200.0000 ,["Tutorial_Blue_Minion_Wizard"] = 650.0000 ,["DrMundo"] = math.huge ,["Volibear"] = 467.0000 ,["Irelia"] = 467.0000 ,["Odin_Red_Minion_Caster"] = 650.0000 ,["Lucian"] = 2800.0000 ,["Yorick"] = math.huge ,["RammusPB"] = math.huge ,["Red_Minion_Basic"] = math.huge ,["Udyr"] = 467.0000 ,["MonkeyKing"] = 20.0000 ,["Tutorial_Blue_Minion_Basic"] = math.huge ,["Kennen"] = 1600.0000 ,["Nunu"] = 500.0000 ,["Ryze"] = 2400.0000 ,["Zed"] = 467.0000 ,["Nautilus"] = 1000.0000 ,["Gangplank"] = 1000.0000 ,["Lux"] = 1600.0000 ,["Sejuani"] = 500.0000 ,["Ezreal"] = 2000.0000 ,["OdinNeutralGuardian"] = 1800.0000 ,["Khazix"] = 500.0000 ,["Sion"] = math.huge ,["Aatrox"] = 347.79999 ,["Hecarim"] = 500.0000 ,["Pantheon"] = 20.0000 ,["Shyvana"] = 467.0000 ,["Zyra"] = 1700.0000 ,["Karthus"] = 1200.0000 ,["Rammus"] = math.huge ,["Zilean"] = 1200.0000 ,["Chogath"] = 500.0000 ,["Malzahar"] = 2000.0000 ,["YorickRavenousGhoul"] = 347.79999 ,["YorickSpectralGhoul"] = 347.79999 ,["JinxMine"] = 347.79999 ,["YorickDecayedGhoul"] = 347.79999 ,["XerathArcaneBarrageLauncher"] = 347.79999 ,["Odin_SOG_Order_Crystal"] = 347.79999 ,["TestCube"] = 347.79999 ,["ShyvanaDragon"] = math.huge ,["FizzBait"] = math.huge ,["Blue_Minion_MechMelee"] = math.huge ,["OdinQuestBuff"] = math.huge ,["TT_Buffplat_L"] = math.huge ,["TT_Buffplat_R"] = math.huge ,["KogMawDead"] = math.huge ,["TempMovableChar"] = math.huge ,["Lizard"] = 500.0000 ,["GolemOdin"] = math.huge ,["OdinOpeningBarrier"] = math.huge ,["TT_ChaosTurret4"] = 500.0000 ,["TT_Flytrap_A"] = 500.0000 ,["TT_NWolf"] = math.huge ,["OdinShieldRelic"] = math.huge ,["LuluSquill"] = math.huge ,["redDragon"] = math.huge ,["MonkeyKingClone"] = math.huge ,["Odin_skeleton"] = math.huge ,["OdinChaosTurretShrine"] = 500.0000 ,["Cassiopeia_Death"] = 500.0000 ,["OdinCenterRelic"] = 500.0000 ,["OdinRedSuperminion"] = math.huge ,["JarvanIVWall"] = math.huge ,["ARAMOrderNexus"] = math.huge ,["Red_Minion_MechCannon"] = 1200.0000 ,["OdinBlueSuperminion"] = math.huge ,["SyndraOrbs"] = math.huge ,["LuluKitty"] = math.huge ,["SwainNoBird"] = math.huge ,["LuluLadybug"] = math.huge ,["CaitlynTrap"] = math.huge ,["TT_Shroom_A"] = math.huge ,["ARAMChaosTurretShrine"] = 500.0000 ,["Odin_Windmill_Propellers"] = 500.0000 ,["TT_NWolf2"] = math.huge ,["OdinMinionGraveyardPortal"] = math.huge ,["SwainBeam"] = math.huge ,["Summoner_Rider_Order"] = math.huge ,["TT_Relic"] = math.huge ,["odin_lifts_crystal"] = math.huge ,["OdinOrderTurretShrine"] = 500.0000 ,["SpellBook1"] = 500.0000 ,["Blue_Minion_MechCannon"] = 1200.0000 ,["TT_ChaosInhibitor_D"] = 1200.0000 ,["Odin_SoG_Chaos"] = 1200.0000 ,["TrundleWall"] = 1200.0000 ,["HA_AP_HealthRelic"] = 1200.0000 ,["OrderTurretShrine"] = 500.0000 ,["OriannaBall"] = 500.0000 ,["ChaosTurretShrine"] = 500.0000 ,["LuluCupcake"] = 500.0000 ,["HA_AP_ChaosTurretShrine"] = 500.0000 ,["TT_NWraith2"] = 750.0000 ,["TT_Tree_A"] = 750.0000 ,["SummonerBeacon"] = 750.0000 ,["Odin_Drill"] = 750.0000 ,["TT_NGolem"] = math.huge ,["AramSpeedShrine"] = math.huge ,["OriannaNoBall"] = math.huge ,["Odin_Minecart"] = math.huge ,["Summoner_Rider_Chaos"] = math.huge ,["OdinSpeedShrine"] = math.huge ,["TT_SpeedShrine"] = math.huge ,["odin_lifts_buckets"] = math.huge ,["OdinRockSaw"] = math.huge ,["OdinMinionSpawnPortal"] = math.huge ,["SyndraSphere"] = math.huge ,["Red_Minion_MechMelee"] = math.huge ,["SwainRaven"] = math.huge ,["crystal_platform"] = math.huge ,["MaokaiSproutling"] = math.huge ,["Urf"] = math.huge ,["TestCubeRender10Vision"] = math.huge ,["MalzaharVoidling"] = 500.0000 ,["GhostWard"] = 500.0000 ,["MonkeyKingFlying"] = 500.0000 ,["LuluPig"] = 500.0000 ,["AniviaIceBlock"] = 500.0000 ,["TT_OrderInhibitor_D"] = 500.0000 ,["Odin_SoG_Order"] = 500.0000 ,["RammusDBC"] = 500.0000 ,["FizzShark"] = 500.0000 ,["LuluDragon"] = 500.0000 ,["OdinTestCubeRender"] = 500.0000 ,["TT_Tree1"] = 500.0000 ,["ARAMOrderTurretShrine"] = 500.0000 ,["Odin_Windmill_Gears"] = 500.0000 ,["ARAMChaosNexus"] = 500.0000 ,["TT_NWraith"] = 750.0000 ,["TT_OrderTurret4"] = 500.0000 ,["Odin_SOG_Chaos_Crystal"] = 500.0000 ,["OdinQuestIndicator"] = 500.0000 ,["JarvanIVStandard"] = 500.0000 ,["TT_DummyPusher"] = 500.0000 ,["OdinClaw"] = 500.0000 ,["EliseSpiderling"] = 2000.0000 ,["QuinnValor"] = math.huge ,["UdyrTigerUlt"] = math.huge ,["UdyrTurtleUlt"] = math.huge ,["UdyrUlt"] = math.huge ,["UdyrPhoenixUlt"] = math.huge ,["ShacoBox"] = 1500.0000 ,["HA_AP_Poro"] = 1500.0000 ,["AnnieTibbers"] = math.huge ,["UdyrPhoenix"] = math.huge ,["UdyrTurtle"] = math.huge ,["UdyrTiger"] = math.huge ,["HA_AP_OrderShrineTurret"] = 500.0000 ,["HA_AP_Chains_Long"] = 500.0000 ,["HA_AP_BridgeLaneStatue"] = 500.0000 ,["HA_AP_ChaosTurretRubble"] = 500.0000 ,["HA_AP_PoroSpawner"] = 500.0000 ,["HA_AP_Cutaway"] = 500.0000 ,["HA_AP_Chains"] = 500.0000 ,["ChaosInhibitor_D"] = 500.0000 ,["ZacRebirthBloblet"] = 500.0000 ,["OrderInhibitor_D"] = 500.0000 ,["Nidalee_Spear"] = 500.0000 ,["Nidalee_Cougar"] = 500.0000 ,["TT_Buffplat_Chain"] = 500.0000 ,["WriggleLantern"] = 500.0000 ,["TwistedLizardElder"] = 500.0000 ,["RabidWolf"] = math.huge ,["HeimerTGreen"] = 1599.3999 ,["HeimerTRed"] = 1599.3999 ,["ViktorFF"] = 1599.3999 ,["TwistedGolem"] = math.huge ,["TwistedSmallWolf"] = math.huge ,["TwistedGiantWolf"] = math.huge ,["TwistedTinyWraith"] = 750.0000 ,["TwistedBlueWraith"] = 750.0000 ,["TwistedYoungLizard"] = 750.0000 ,["Red_Minion_Melee"] = math.huge ,["Blue_Minion_Melee"] = math.huge ,["Blue_Minion_Healer"] = 1000.0000 ,["Ghast"] = 750.0000 ,["blueDragon"] = 800.0000 ,["Red_Minion_MechRange"] = 3000, 
            ["SRU_OrderMinionRanged"] = 650, ["SRU_ChaosMinionRanged"] = 650, ["SRU_OrderMinionSiege"] = 1200, ["SRU_ChaosMinionSiege"] = 1200, 
            ["SRUAP_Turret_Chaos1"]  = 1200, ["SRUAP_Turret_Chaos2"]  = 1200, ["SRUAP_Turret_Chaos3"] = 1200, ["SRUAP_Turret_Chaos3_Test"] = 1200, ["SRUAP_Turret_Chaos4"] = 1200, ["SRUAP_Turret_Chaos5"] = 500, 
            ["SRUAP_Turret_Order1"]  = 1200, ["SRUAP_Turret_Order2"]  = 1200, ["SRUAP_Turret_Order3"] = 1200, ["SRUAP_Turret_Order3_Test"] = math.huge, ["SRUAP_Turret_Order4"] = math.huge, ["SRUAP_Turret_Order5"] = 500,
            ["Kalista"] = 2600,
            ["BW_Ocklepod"] = 750, ["BW_Plundercrab"] = 1000,
            ["BW_AP_ChaosTurret"] = 1200, ["BW_AP_ChaosTurret2"] = 1200, ["BW_AP_ChaosTurret3"] = 1200,
            ["BW_AP_OrderTurret"] = 1200, ["BW_AP_OrderTurret2"] = 1200, ["BW_AP_OrderTurret3"] = 1200, 
        }
        self.ProjectileSpeed = self.VP:GetProjectileSpeed(myHero)
    end
    --[[if VIP_USER and FileExist(LIB_PATH.."Prodiction.lua") then 
        require "Prodiction" 
        table.insert(self.PredictionList, "Prodiction")
        self.Actives["Prodiction"] = true
    end ]]
    if FileExist(LIB_PATH.."HPrediction.lua") then
        table.insert(self.PredictionList, "HPrediction") 
        --PrintMessage("Temporary disabled HPrediction due to investigation about bugsplats, will be enabled soon.")
    end
    if VIP_USER and FileExist(LIB_PATH.."DivinePred.lua") and FileExist(LIB_PATH.."DivinePred.luac") then
        table.insert(self.PredictionList, "DivinePred") 
        self.BindedSpells = {}
        --PrintMessage("Temporary disabled DivinePred due to investigation about bugsplats, will be enabled soon.")
    end
    if FileExist(LIB_PATH.."SPrediction.lua") and FileExist(LIB_PATH.."Collision.lua") then
        table.insert(self.PredictionList, "SPrediction") 
        --PrintMessage("Temporary disabled SPrediction due of investigation about bugsplats, will be enabled soon.")
    end
    self.LastRequest = 0
    local ImmobileBuffs = {
        [5] = true,
        [11] = true,
        [29] = true,
        [24] = true,
    }
    --[[
    AddApplyBuffCallback(
        function(source, unit, buff)
            if unit and buff and buff.type then
                if ImmobileBuffs[buff.type] ~= nil then
                    for i = 1, unit.buffCount do
                        local buf = unit:getBuff(i)
                        if buf and buf.name ~= nil and buf.endT ~= nil and buf.startT ~= nil and type(buf.name) == "string" and type(buf.endT) == "number" and type(buf.startT) == "number" and buf.name == buff.name then
                            self.UnitsImmobile[unit.networkID] = {Time = os.clock() - Latency(), Duration = buf.endT - buf.startT}
                        end
                    end
                end
            end
        end
    )
    AddRemoveBuffCallback(
        function(unit, buff)
            if unit and buff and buff.type then
                if ImmobileBuffs[buff.type] ~= nil then
                    self.UnitsImmobile[unit.networkID] = nil
                end
            end
        end
    )]]
end

function _Prediction:LoadPrediction(TypeOfPrediction)
    if TypeOfPrediction == "VPrediction" then
    elseif TypeOfPrediction == "Prodiction" then
    elseif TypeOfPrediction == "DivinePred" then
        if self.DP == nil then
            require "DivinePred"
            self.Actives["DivinePred"] = true
            self.DP = DivinePred()
            _G.DP = self.DP
            DelayAction(function()
                PrintMessage("DivinePred is causing a lot of fps drops, take care!")
            end, 0.8)
        end
    elseif TypeOfPrediction == "HPrediction" then
        if self.HP == nil then
            require "HPrediction"
            self.Actives["HPrediction"] = true
            self.HP = HPrediction()
            _G.HP = self.HP
        end
    elseif TypeOfPrediction == "SPrediction" then
        if self.SP == nil then
            require "SPrediction"
            self.Actives["SPrediction"] = true
            self.SP = SPrediction()
            _G.SP = self.SP
        end
    end
end

function _Prediction:BindSpell(sp)
    if self.DP ~= nil and sp ~= nil then
        local delay = sp.Delay ~= nil and sp.Delay or 0
        local width = sp.Width ~= nil and sp.Width or 1
        local range = sp.Range ~= nil and sp.Range or math.huge
        local speed = sp.Speed ~= nil and sp.Speed or math.huge
        local skillshotType = sp.Type ~= nil and sp.Type or SPELL_TYPE.CIRCULAR
        local collision = sp.Collision ~= nil and sp.Collision or false
        local aoe = sp.Aoe ~= nil and sp.Aoe or false
        local accuracy = sp.Accuracy ~= nil and sp.Accuracy or 60
        local source = sp.Source ~= nil and sp.Source or myHero
        local name = sp.Name ~= nil and sp.Name or "Q"
        local col = collision and 0 or math.huge
        if self.BindedSpells[name] == nil then
            local spell = nil
            if skillshotType == SPELL_TYPE.LINEAR then
                spell = LineSS(speed, range, width, delay * 1000, col)
            elseif skillshotType == SPELL_TYPE.CIRCULAR then
                spell = CircleSS(speed, range, width, delay * 1000, col)
            elseif skillshotType == SPELL_TYPE.CONE then
                spell = ConeSS(speed, range, width, delay * 1000, col)
            end
            self.BindedSpells[name] = self.DP:bindSS(name, spell, 50)
        end
    end
end


function _Prediction:ValidRequest(TypeOfPrediction)
    if os.clock() - self.LastRequest < self:TimeRequest(TypeOfPrediction) then
        return false
    else
        self.LastRequest = os.clock()
        return true
    end
end

function _Prediction:AccuracyToHitChance(TypeOfPrediction, Accuracy)
    if TypeOfPrediction == "VPrediction" then
        if Accuracy >= 90 then
            return 3
        elseif Accuracy >= 60 then
            return 2
        elseif Accuracy >= 30 then
            return 1
        else
            return 0
        end
    elseif TypeOfPrediction == "Prodiction" then
        if Accuracy >= 90 then
            return 3
        elseif Accuracy >= 60 then
            return 2
        elseif Accuracy >= 30 then
            return 1
        else
            return 0
        end
    elseif TypeOfPrediction == "DivinePred" then
        if Accuracy >= 90 then
            return math.max((Accuracy / 2)/100 + 1 - 0, 1)
        elseif Accuracy >= 80 then
            return math.max((Accuracy / 2)/100 + 1 - 0.05, 1)
        elseif Accuracy >= 50 then
            return math.max((Accuracy / 2)/100 + 1 - 0.1, 1)
        elseif Accuracy >= 20 then
            return math.max((Accuracy / 2)/100 + 1 - 0.05, 1)
        else
            return math.max((Accuracy / 2)/100 + 1 - 0, 1)
        end
    elseif TypeOfPrediction == "HPrediction" then
        return (Accuracy/100) * 3
    elseif TypeOfPrediction == "SPrediction" then
        if Accuracy >= 90 then
            return 3
        elseif Accuracy >= 60 then
            return 2
        elseif Accuracy >= 30 then
            return 1
        else
            return 0
        end
    end
end

function _Prediction:TimeRequest(TypeOfPrediction)
    if TypeOfPrediction == "VPrediction" then
        return 0
    elseif TypeOfPrediction == "Prodiction" then
        return 0
    elseif TypeOfPrediction == "DivinePred" then
        return 0.15
    elseif TypeOfPrediction == "HPrediction" then
        return 0
    elseif TypeOfPrediction == "SPrediction" then
        return 0
    end
end

function _Prediction:IsImmobile(target, sp)
    if IsValidTarget(target) and self.UnitsImmobile[target.networkID] ~= nil then
        local delay = sp.Delay ~= nil and sp.Delay or 0
        local width = sp.Width ~= nil and sp.Width or 1
        local range = sp.Range ~= nil and sp.Range or math.huge
        local speed = sp.Speed ~= nil and sp.Speed or math.huge
        local skillshotType = sp.Type ~= nil and sp.Type or SPELL_TYPE.CIRCULAR
        local collision = sp.Collision ~= nil and sp.Collision or false
        local aoe = sp.Aoe ~= nil and sp.Aoe or false
        local accuracy = sp.Accuracy ~= nil and sp.Accuracy or 60
        local source = sp.Source ~= nil and sp.Source or myHero
        local ExtraDelay = speed == math.huge and 0 or (GetDistance(source, target) / speed)
        range = range + (skillshotType == SPELL_TYPE.CIRCULAR and width or 0)
        local ExtraDelay2 = skillshotType == SPELL_TYPE.CIRCULAR and 0 or (width / target.ms)
        if not collision and self.UnitsImmobile[target.networkID].Duration - (os.clock() + Latency() - self.UnitsImmobile[target.networkID].Time) + ExtraDelay2 >= delay + ExtraDelay and GetDistanceSqr(source, target) <= math.pow(range , 2) then
            return true
        end
    end
    return false
end

function _Prediction:GetPrediction(target, sp)
    assert(sp and type(sp) == "table", "Prediction:GetPrediction() Table is invalid!")
    local TypeOfPrediction = sp.TypeOfPrediction ~= nil and sp.TypeOfPrediction or "VPrediction"
    local CastPosition, WillHit, NumberOfHits, Position = nil, -1, 1, nil
    if target ~= nil and IsValidTarget(target, math.huge, target.team ~= myHero.team) and self:ValidRequest(TypeOfPrediction) then
        CastPosition = Vector(target)
        Position = Vector(target)
        local delay = sp.Delay ~= nil and sp.Delay or 0
        local width = sp.Width ~= nil and sp.Width or 1
        local range = sp.Range ~= nil and sp.Range or math.huge
        local speed = sp.Speed ~= nil and sp.Speed or math.huge
        local skillshotType = sp.Type ~= nil and sp.Type or SPELL_TYPE.CIRCULAR
        local collision = sp.Collision ~= nil and sp.Collision or false
        local aoe = sp.Aoe ~= nil and sp.Aoe or false
        local accuracy = sp.Accuracy ~= nil and sp.Accuracy or 60
        local source = sp.Source ~= nil and sp.Source or myHero
        local name = sp.Name ~= nil and sp.Name or "Q"
        TypeOfPrediction = (not target.type:lower():find("hero")) and "VPrediction" or TypeOfPrediction
        TypeOfPrediction = self.Actives[tostring(TypeOfPrediction)] == true and TypeOfPrediction or "VPrediction"
        -- VPrediction
        if TypeOfPrediction == "Prodiction" and self.Actives[TypeOfPrediction] then
            local aoe = false
            if aoe then
                if skillshotType == SPELL_TYPE.LINEAR then
                    local CastPosition1, info, objects = Prodiction.GetLineAOEPrediction(target, range, speed, delay, width, source)
                    local WillHit = collision and info.mCollision() and -1 or info.hitchance
                    NumberOfHits = #objects
                    CastPosition = CastPosition1
                    Position = CastPosition1
                elseif skillshotType == SPELL_TYPE.CIRCULAR then
                    local CastPosition1, info, objects = Prodiction.GetCircularAOEPrediction(target, range, speed, delay, width, source)
                    local WillHit = collision and info.mCollision() and -1 or info.hitchance
                    NumberOfHits = #objects
                    CastPosition = CastPosition1
                    Position = CastPosition1
                 elseif skillshotType == SPELL_TYPE.CONE then
                    local CastPosition1, info, objects = Prodiction.GetConeAOEPrediction(target, range, speed, delay, width, source)
                    local WillHit = collision and info.mCollision() and -1 or info.hitchance
                    NumberOfHits = #objects
                    CastPosition = CastPosition1
                    Position = CastPosition1
                end
            else
                local CastPosition1, info = Prodiction.GetPrediction(target, range, speed, delay, width, source)
                local WillHit = collision and info.mCollision() and -1 or info.hitchance
                CastPosition = CastPosition1
                Position = CastPosition1
            end
        elseif TypeOfPrediction == "DivinePred" and self.Actives[TypeOfPrediction] then
            local col = collision and 0 or math.huge
            if self.BindedSpells[name] == nil then
                self:BindSpell(sp)
            else
                self.BindedSpells[name].range = range
                self.BindedSpells[name].speed = speed
                self.BindedSpells[name].radius = width
                self.BindedSpells[name].delay = delay * 1000
                self.BindedSpells[name].allowedCollisionCount = col
                if skillshotType == SPELL_TYPE.LINEAR then
                    self.BindedSpells[name].type = "LineSS"
                elseif skillshotType == SPELL_TYPE.CIRCULAR then
                    self.BindedSpells[name].type = "CircleSS"
                elseif skillshotType == SPELL_TYPE.CONE then
                    self.BindedSpells[name].type = "ConeSS"
                end
            end
            local state, pos, perc = self.DP:predict(name, target, Vector(source))
            if state and pos and perc then
                --local hitchance = self:AccuracyToHitChance(TypeOfPrediction, accuracy)
                --local state, pos, perc = self.DP:predict(DPTarget(target), spell, hitchance, source)
                WillHit = ((state == SkillShot.STATUS.SUCCESS_HIT) or self:IsImmobile(target, sp)) 
                CastPosition = pos
                Position = pos
            end
        elseif TypeOfPrediction == "HPrediction" and self.Actives[TypeOfPrediction] then
            local tipo = "PromptCircle"
            local tab = {}
            range = GetDistance(source, myHero) + range
            local time = delay + range/speed
            if sp.IsVeryLowAccuracy ~= nil then
                tab.IsVeryLowAccuracy = sp.IsVeryLowAccuracy
            end
            if time > 1 and width <= 120 then
                tab.IsVeryLowAccuracy = true
            elseif time > 0.8 and width <= 100 then
                tab.IsVeryLowAccuracy = true
            elseif time > 0.6 and width <= 60 then
                tab.IsVeryLowAccuracy = true
            elseif width <= 40 then
                tab.IsVeryLowAccuracy = true
            end
            if skillshotType == SPELL_TYPE.LINEAR then
                width = 2 * width
                if speed ~= math.huge then 
                    tipo = "DelayLine"
                    tab.speed = speed
                else
                    tipo = "PromptLine"
                end
                if collision then
                    tab.collisionM = collision
                    tab.collisionH = collision
                end
                tab.width = width
            elseif skillshotType == SPELL_TYPE.CIRCULAR then
                tab.radius = width
                if speed ~= math.huge then 
                    tipo = "DelayCircle"
                    tab.speed = speed
                else
                    tipo = "PromptCircle"
                end
            elseif skillshotType == SPELL_TYPE.CONE then
                tab.angle = width
                tipo = "CircularArc"
                tab.speed = speed
                aoe = false
            end
            tab.range = range
            tab.delay = delay
            tab.type = tipo
            if aoe then
                CastPosition, WillHit, NumberOfHits = self.HP:GetPredict(HPSkillshot(tab), target, source, aoe)
                Position = CastPosition
            else
                CastPosition, WillHit = self.HP:GetPredict(HPSkillshot(tab), target, source)
                Position = CastPosition
            end
        elseif TypeOfPrediction == "SPrediction" and self.Actives[TypeOfPrediction] then
            CastPosition, WillHit, Position = self.SP:Predict(target, range, speed, delay, width, collision, source)
        elseif TypeOfPrediction == "VPrediction" and self.Actives[TypeOfPrediction] then
            if skillshotType == SPELL_TYPE.LINEAR then
                if aoe then
                    CastPosition, WillHit, NumberOfHits, Position = self.VP:GetLineAOECastPosition(target, delay, width, range, speed, source)
                else
                    CastPosition, WillHit, Position = self.VP:GetLineCastPosition(target, delay, width, range, speed, source, collision)
                end
            elseif skillshotType == SPELL_TYPE.CIRCULAR then
                if aoe then
                    CastPosition, WillHit, NumberOfHits, Position = self.VP:GetCircularAOECastPosition(target, delay, width, range, speed, source)
                else
                    CastPosition, WillHit, Position = self.VP:GetCircularCastPosition(target, delay, width, range, speed, source, collision)
                end
             elseif skillshotType == SPELL_TYPE.CONE then
                if aoe then
                    CastPosition, WillHit, NumberOfHits, Position = self.VP:GetConeAOECastPosition(target, delay, width, range, speed, source)
                else
                    CastPosition, WillHit, Position = self.VP:GetLineCastPosition(target, delay, width, range, speed, source, collision)
                end
            end
        end
        if WillHit then
            if type(WillHit) == "number" then
                WillHit = ((WillHit >= self:AccuracyToHitChance(TypeOfPrediction, accuracy)) or self:IsImmobile(target, sp))
            end
        else
            WillHit = false
        end
        if aoe then
            return CastPosition, WillHit, NumberOfHits, Position
        else
            return CastPosition, WillHit, Position
        end
    end
    return nil, false, nil
end

function _Prediction:GetPredictedPos(target, tab)
    if IsValidTarget(target, math.huge, target.team ~= myHero.team) then
        local delay = tab.Delay ~= nil and tab.Delay or 0
        local speed = tab.Speed or nil
        local from = tab.Source or nil
        local collision = tab.Collision or nil
        local TypeOfPrediction = tab.TypeOfPrediction ~= nil and tab.TypeOfPrediction or "VPrediction"
        local accuracy = tab.Accuracy ~= nil and tab.Accuracy or 60
        local CastPosition, HitChance, Position = self.VP:GetPredictedPos(target, delay, speed, from, collision)
        local WillHit = false
        if HitChance >= 0 then
            WillHit = true
        else
            WillHit = false
        end
        return CastPosition, WillHit, Position
    end
    return Vector(target), false, Vector(target)
end


--CLASS: _OrbwalkManager
function _OrbwalkManager:__init()
    self.OrbLoaded = ""
    self.OrbwalkList = {}
    self.KeyMan = _KeyManager()
    DelayAction(function()
        if _G.Reborn_Loaded or _G.Reborn_Initialised or _G.AutoCarry ~= nil then
            table.insert(self.OrbwalkList, "AutoCarry")
        end
        if _G.MMA_IsLoaded then
            table.insert(self.OrbwalkList, "MMA")
        end
        if FileExist(LIB_PATH .. "SxOrbWalk.lua") then
            table.insert(self.OrbwalkList, "SxOrbWalk")
        end
        if FileExist(LIB_PATH.."Nebelwolfi's Orb Walker.lua") then
            table.insert(self.OrbwalkList, "NOW")
        end
        if FileExist(LIB_PATH .. "Big Fat Orbwalker.lua") then
            table.insert(self.OrbwalkList, "Big Fat Walk")
        end
        if FileExist(LIB_PATH .. "SOW.lua") then
            table.insert(self.OrbwalkList, "SOW")
        end
        if _G.OrbwalkManagerMenu == nil then
            _G.OrbwalkManagerMenu = scriptConfig("SimpleLib - Orbwalk Manager", "OrbwalkManager".."24052015"..tostring(myHero.charName))
        end
        if #self.OrbwalkList > 0 then
            _G.OrbwalkManagerMenu:addParam("OrbwalkerSelected", "Orbwalker Selection", SCRIPT_PARAM_LIST, 1, self.OrbwalkList)
            local default = _G.OrbwalkManagerMenu.OrbwalkerSelected
            if #self.OrbwalkList > 1 then
                --_G.OrbwalkManagerMenu:addParam("info", "Requires 2x F9 when changing selection", SCRIPT_PARAM_INFO, "")
                _G.OrbwalkManagerMenu:setCallback("OrbwalkerSelected",
                    function(v)
                        if v and v ~= default then
                            if not self.Draw then
                                self.Draw = true
                                AddDrawCallback(
                                    function()
                                        local p = WorldToScreen(D3DXVECTOR3(myHero.x, myHero.y, myHero.z))
                                        if OnScreen(p.x, p.y) and _G.OrbwalkManagerMenu.OrbwalkerSelected ~= default then
                                            DrawText("Press 2x F9!", 25, p.x, p.y, ARGB(255, 255, 255, 255))
                                        end
                                    end
                                )
                            end
                        end
                    end
                    )
            end
        end
        DelayAction(function() self:OrbLoad() end, 1)
    end, 1)
    self.NoAttacks = { 
        jarvanivcataclysmattack = true, 
        monkeykingdoubleattack = true, 
        shyvanadoubleattack = true, 
        shyvanadoubleattackdragon = true, 
        zyragraspingplantattack = true, 
        zyragraspingplantattack2 = true, 
        zyragraspingplantattackfire = true, 
        zyragraspingplantattack2fire = true, 
        viktorpowertransfer = true, 
        sivirwattackbounce = true,
    }
    self.Attacks = {
        caitlynheadshotmissile = true, 
        frostarrow = true, 
        garenslash2 = true, 
        kennenmegaproc = true, 
        lucianpassiveattack = true, 
        masteryidoublestrike = true, 
        quinnwenhanced = true, 
        renektonexecute = true, 
        renektonsuperexecute = true, 
        rengarnewpassivebuffdash = true, 
        trundleq = true, 
        xenzhaothrust = true, 
        xenzhaothrust2 = true, 
        xenzhaothrust3 = true, 
        viktorqbuff = true,
    }
    self.Resets = {
        dariusnoxiantacticsonh = true,
        garenq = true,
        hecarimrapidslash = true, 
        jaxempowertwo = true, 
        jaycehypercharge = true,
        leonashieldofdaybreak = true, 
        luciane = true, 
        lucianq = true,
        monkeykingdoubleattack = true, 
        mordekaisermaceofspades = true, 
        nasusq = true, 
        nautiluspiercinggaze = true, 
        netherblade = true,
        parley = true, 
        poppydevastatingblow = true, 
        powerfist = true, 
        renektonpreexecute = true, 
        shyvanadoubleattack = true,
        sivirw = true, 
        takedown = true, 
        talonnoxiandiplomacy = true, 
        trundletrollsmash = true, 
        vaynetumble = true, 
        vie = true, 
        volibearq = true,
        xenzhaocombotarget = true, 
        yorickspectral = true,
        reksaiq = true,
        riventricleave = true,
        itemtiamatcleave = true,
        fioraflurry = true, 
        rengarq = true,
    }
    self.Attack = true
    self.Move = true
    self.KeysMenu = nil
    self.GotReset = false
    self.DataUpdated = false
    self.BaseWindUpTime = 3
    self.BaseAnimationTime = 0.665
    self.Mode = ORBWALK_MODE.NONE
    self.AfterAttackCallbacks = {}
    self.LastAnimationName = ""
    self.AA = {LastTime = 0, LastTarget = nil, IsAttacking = false, Object = nil}
    self.LastKeyAdded = os.clock()
    
    self.EnemyMinions = minionManager(MINION_ENEMY, myHero.range + myHero.boundingRadius + 500, myHero, MINION_SORT_HEALTH_ASC)
    self.JungleMinions = minionManager(MINION_JUNGLE, myHero.range + myHero.boundingRadius + 500, myHero, MINION_SORT_MAXHEALTH_DEC)

    AddCreateObjCallback(
        function(obj)
            if self.AA.Object == nil and tostring(obj.name):lower() == "missile" and self:GetTime() - self.AA.LastTime + self:Latency() < 1.2 * self:WindUpTime() and obj.spellOwner and obj.spellName and obj.spellOwner.isMe and self:IsAutoAttack(obj.spellName) then
                self:ResetMove()
                self.AA.Object = obj
            end
        end
    )

    AddDeleteObjCallback(
        function(obj)
            if obj and self.AA.Object ~= nil and obj.networkID == self.AA.Object.networkID then
                self.AA.Object = nil
            end
        end
    )
    AddAnimationCallback(function(unit, animation) self:OnAnimation(unit, animation) end)
    if AddProcessSpellCallback then
        AddProcessSpellCallback(function(unit, spell) self:OnProcessSpell(unit, spell) end)
    end
    if AddProcessAttackCallback then
        AddProcessAttackCallback(function(unit, spell) self:OnProcessAttack(unit, spell) end)
    end
    AddTickCallback(
        function()
            self.Mode = self.KeyMan:ModePressed()
            if not self:IsAttacking() then
                if self.AA.IsAttacking then
                    self:TriggerAfterAttackCallback(spell)
                    self.AA.IsAttacking = false
                    if self.GotReset then self.GotReset = false end
                end
            end
            if self.OrbLoaded == self:GetOrbwalkSelected() then
                if self.RegisterCommon and not self.RegisteredCommon then
                    self.RegisteredCommon = true
                    self.AddedCommon = true
                    self:AddKey({ Name = "Combo", Text = "Combo", Type = SCRIPT_PARAM_ONKEYDOWN, Key = 32, Mode = ORBWALK_MODE.COMBO})
                    self:AddKey({ Name = "Harass", Text = "Harass", Type = SCRIPT_PARAM_ONKEYDOWN, Key = string.byte("C"), Mode = ORBWALK_MODE.HARASS})
                    self:AddKey({ Name = "Clear", Text = "LaneClear or JungleClear", Type = SCRIPT_PARAM_ONKEYDOWN, Key = string.byte("V"), Mode = ORBWALK_MODE.CLEAR })
                    self:AddKey({ Name = "LastHit", Text = "LastHit", Type = SCRIPT_PARAM_ONKEYDOWN, Key = string.byte("X"), Mode = ORBWALK_MODE.LASTHIT})
                end
                if self.Register and os.clock() - self.LastKeyAdded > 0.15 then
                    self.Register = false
                    self.KeyMan:RegisterKeys()
                end
            end
        end
    )
end

function _OrbwalkManager:GetOrbwalkSelected()
    local int = _G.OrbwalkManagerMenu ~= nil and _G.OrbwalkManagerMenu.OrbwalkerSelected or 1
    return #self.OrbwalkList > 0 and tostring(self.OrbwalkList[int]) or nil
end

function _OrbwalkManager:IsAutoAttack(name)
    return name and ((tostring(name):lower():find("attack") and not self.NoAttacks[tostring(name):lower()]) or self.Attacks[tostring(name):lower()])
end

function _OrbwalkManager:IsReset(name)
    return name and self.Resets[tostring(name):lower()]
end

function _OrbwalkManager:LoadCommonKeys(m)
    local menu = nil
    if m == nil then
        if _G.OrbwalkManagerMenu ~= nil then
            _G.OrbwalkManagerMenu:addSubMenu(myHero.charName.." - Key Settings", "Keys")
            menu = _G.OrbwalkManagerMenu.Keys
        end
    else
        menu = m
    end
    self.KeysMenu = menu
    if self.KeysMenu ~= nil then
        self.KeysMenu:addParam("Common", "Use main keys from your Orbwalker", SCRIPT_PARAM_ONOFF, true)
        self.RegisterCommon = self.KeysMenu.Common == false
         self.KeysMenu:setCallback("Common",
            function(v)
                if v == false and not self.AddedCommon then
                    self.AddedCommon = true
                    self:AddKey({ Name = "Combo", Text = "Combo (Space)", Type = SCRIPT_PARAM_ONKEYDOWN, Key = 32, Mode = ORBWALK_MODE.COMBO})
                    self:AddKey({ Name = "Harass", Text = "Harass", Type = SCRIPT_PARAM_ONKEYDOWN, Key = string.byte("C"), Mode = ORBWALK_MODE.HARASS})
                    self:AddKey({ Name = "Clear", Text = "LaneClear or JungleClear", Type = SCRIPT_PARAM_ONKEYDOWN, Key = string.byte("V"), Mode = ORBWALK_MODE.CLEAR })
                    self:AddKey({ Name = "LastHit", Text = "LastHit", Type = SCRIPT_PARAM_ONKEYDOWN, Key = string.byte("X"), Mode = ORBWALK_MODE.LASTHIT})
                    --[[
                    if not self.Registered2 then
                        AddTickCallback(
                            function()
                                if self.OrbLoaded == self:GetOrbwalkSelected() then
                                    if not self.Registered2 then
                                        self.Registered2 = true
                                        self.KeyMan:RegisterKeys()
                                    end
                                end
                            end
                        )
                    end
                    ]]
                elseif v == true and self.AddedCommon then
                    self.KeysMenu:removeParam("Combo")
                    self.KeysMenu:removeParam("Combo".."TypeList")
                    self.KeysMenu:removeParam("Harass")
                    self.KeysMenu:removeParam("Harass".."TypeList")
                    self.KeysMenu:removeParam("Clear")
                    self.KeysMenu:removeParam("Clear".."TypeList")
                    self.KeysMenu:removeParam("LastHit")
                    self.KeysMenu:removeParam("LastHit".."TypeList")
                    self.AddedCommon = false
                end
            end
        )
    end
end

function _OrbwalkManager:OnAnimation(unit, animation)
    if unit and animation then
        if unit.isMe then
            if self:GetTime() - self.AA.LastTime + self:Latency() < 1 * self:WindUpTime() then
                if not animation:lower():find("attack") then
                    self:ResetMove()
                end
            else
                if animation:lower():find("attack") and self:GetTime() - self.AA.LastTime + self:Latency() >= 1 * self:AnimationTime() - 25/1000 then
                    self.AA.IsAttacking = true
                    self.AA.LastTime = self:GetTime() - self:Latency()
                end
            end
            self.LastAnimationName = animation
        end
    end
end

function _OrbwalkManager:OnProcessAttack(unit, spell)
    if unit and spell and unit.isMe and spell.name then
        if self:IsAutoAttack(spell.name) then
            if not self.DataUpdated then
                self.BaseAnimationTime = 1 / (spell.animationTime * myHero.attackSpeed)
                self.BaseWindUpTime = 1 / (spell.windUpTime * myHero.attackSpeed)
                self.DataUpdated = true
            end
            self.AA.LastTarget = spell.target
            self.AA.IsAttacking = false
            self.AA.LastTime = self:GetTime() - self:Latency() - self:WindUpTime()
        end
    end
end

function _OrbwalkManager:OnProcessSpell(unit, spell)
    if unit and unit.isMe and spell and spell.name then
        if self:IsReset(tostring(spell.name)) then
            self.GotReset = true
            DelayAction(
                function()
                    self:ResetAA()
                end
                ,2 * Latency())
        end
    end
end

function _OrbwalkManager:GetTime()
    return 1 * os.clock()
end

function _OrbwalkManager:Latency()
    return GetLatency() / 2000
end

function _OrbwalkManager:ExtraWindUp()
    return _G.OrbwalkManagerMenu ~= nil and _G.OrbwalkManagerMenu.ExtraWindUp ~= nil and _G.OrbwalkManagerMenu.ExtraWindUp/1000 or 0
end

function _OrbwalkManager:WindUpTime()
    return (1 / (myHero.attackSpeed * self.BaseWindUpTime)) + self:ExtraWindUp()
end

function _OrbwalkManager:AnimationTime()
    return (1 / (myHero.attackSpeed * self.BaseAnimationTime))
end

function _OrbwalkManager:CanAttack(ExtraTime)
    if self.OrbLoaded == "AutoCarry" then
        return _G.AutoCarry.Orbwalker:CanShoot()
    elseif self.OrbLoaded == "SxOrbWalk" then
        return _G.SxOrb:CanAttack()
    elseif self.OrbLoaded == "SOW" then
    elseif self.OrbLoaded == "Big Fat Walk" then
    elseif self.OrbLoaded == "MMA" then
        return _G.MMA_CanAttack()
    elseif self.OrbLoaded == "NOW" then
        return _G.NOWi:TimeToAttack()
    end
    return self:_CanAttack(ExtraTime)
end

function  _OrbwalkManager:_CanAttack(ExtraTime)
    local int = ExtraTime ~= nil and ExtraTime or 0
    return self:GetTime() - self.AA.LastTime + self:Latency() >= 1 * self:AnimationTime() - 25/1000 + int and not IsEvading()
end

function _OrbwalkManager:CanMove(ExtraTime)
    if self.OrbLoaded == "AutoCarry" then
        return _G.AutoCarry.Orbwalker:CanMove()
    elseif self.OrbLoaded == "SxOrbWalk" then
        return _G.SxOrb:CanMove()
    elseif self.OrbLoaded == "SOW" then
    elseif self.OrbLoaded == "Big Fat Walk" then
    elseif self.OrbLoaded == "MMA" then
        return _G.MMA_CanMove()
    elseif self.OrbLoaded == "NOW" then
        return _G.NOWi:TimeToMove()
    end
    return self:_CanMove(ExtraTime)
end

function _OrbwalkManager:_CanMove(ExtraTime)
    local int = ExtraTime ~= nil and ExtraTime or 0
    return self:GetTime() - self.AA.LastTime + self:Latency() >= 1 * self:WindUpTime() + int and not IsEvading()
end

function _OrbwalkManager:IsAttacking()
    return (not self:CanMove()) or (self.AA.Object ~= nil and self.AA.Object.valid)
end

function _OrbwalkManager:CanCast()
    return not self:IsAttacking()
end

function _OrbwalkManager:Evade()
    return _G.evade or _G.Evade
end

function _OrbwalkManager:MyRange(target)
    local int1 = 0
    if IsValidTarget(target) then int1 = target.boundingRadius end
    return myHero.range + myHero.boundingRadius + int1
end

function _OrbwalkManager:InRange(target, off)
    local offset = off ~= nil and off or 0
    return IsValidTarget(target, self:MyRange(target) + offset)
end

function _OrbwalkManager:IsCombo()
    return self.KeyMan.Combo
end
function _OrbwalkManager:IsHarass()
    return self.KeyMan.Harass
end
function _OrbwalkManager:IsClear()
    return self.KeyMan.Clear
end
function _OrbwalkManager:IsLastHit()
    return self.KeyMan.LastHit
end

function _OrbwalkManager:IsNone()
    return not (self:IsCombo() or self:IsHarass() or self:IsClear() or self:IsLastHit())
end

function _OrbwalkManager:TakeControl()
    _G.OrbwalkManagerMenu:addParam("ExtraWindUp","Extra WindUpTime", SCRIPT_PARAM_SLICE, 15, -40, 160, 1)
    AddTickCallback(function()
        if not self:IsAttacking() then
            self:EnableMovement() 
        else 
            self:DisableMovement() 
        end
        if self:CanAttack() then
            self:EnableAttacks()
        else 
            self:DisableAttacks()
        end
    end)
    if VIP_USER then 
        HookPackets()
        AddSendPacketCallback(
            function(p)
                p.pos = 2
                if _G.OrbwalkManagerMenu ~= nil and myHero.networkID == p:DecodeF() then
                    if self:GetTime() - self.AA.LastTime + self:Latency() < 1 * self:WindUpTime() * 1/2 and not IsEvading() then
                        Packet(p):block()
                    end
                end
            end
        ) 
    end
end

--boring part
function _OrbwalkManager:ShouldWait()
    if self.EnemyMinions ~= nil and _G.VP then
        self.EnemyMinions:update()
        if #self.EnemyMinions.objects > 0 and self:CanAttack() then
            for i, minion in pairs(self.EnemyMinions.objects) do
                if self:InRange(minion) and not minion.dead then
                    local delay = _G.SpellManagerMenu ~= nil and _G.SpellManagerMenu.FarmDelay ~= nil and _G.SpellManagerMenu.FarmDelay or 0
                    local ProjectileSpeed = _G.VP:GetProjectileSpeed(myHero)
                    local time = self:WindUpTime() + GetDistance(myHero.pos, minion.pos) / ProjectileSpeed + ExtraTime()
                    local predHealth = _G.VP:GetPredictedHealth(minion, time, delay)
                    local damage = _G.VP:CalcDamageOfAttack(myHero, minion, {name = "Basic"}, 0)
                    if predHealth > 0 then
                        if damage > predHealth * 0.9 and predHealth < minion.health then
                            return true
                        else
                            --[[
                            time = self:AnimationTime() + GetDistance(myHero.pos, minion.pos) / ProjectileSpeed + ExtraTime()
                            time = time * 2
                            predHealth = _G.VP:GetPredictedHealth2(minion, time)
                            if damage > predHealth and predHealth < minion.health then
                                return true
                            end]]
                        end
                    end
                end
            end
        end
    end
    return false
end

function _OrbwalkManager:ObjectInRange(off)
    local offset = off ~= nil and off or 0
    if self:IsCombo() then
        for i, enemy in ipairs(GetEnemyHeroes()) do
            if self:InRange(enemy, offset) then return enemy end
        end
    elseif self:IsHarass() then
        for i, enemy in ipairs(GetEnemyHeroes()) do
            if self:InRange(enemy, offset) then return enemy end
        end
        self.EnemyMinions:update()
        for i, object in ipairs(self.EnemyMinions.objects) do
            if self:InRange(object, offset) then return object end
        end
    elseif self:IsClear() then
        for i, enemy in ipairs(GetEnemyHeroes()) do
            if self:InRange(enemy, offset) then return enemy end
        end
        self.EnemyMinions:update()
        for i, object in ipairs(self.EnemyMinions.objects) do
            if self:InRange(object, offset) then return object end
        end
        self.JungleMinions:update()
        for i, object in ipairs(self.JungleMinions.objects) do
            if self:InRange(object, offset) then return object end
        end
    elseif self:IsLastHit() then
        self.EnemyMinions:update()
        for i, object in ipairs(self.EnemyMinions.objects) do
            if self:InRange(object, offset) then return object end
        end
    else
        for i, enemy in ipairs(GetEnemyHeroes()) do
            if self:InRange(enemy, offset) then return enemy end
        end
        self.EnemyMinions:update()
        for i, object in ipairs(self.EnemyMinions.objects) do
            if self:InRange(object, offset) then return object end
        end
        self.JungleMinions:update()
        for i, object in ipairs(self.JungleMinions.objects) do
            if self:InRange(object, offset) then return object end
        end
    end
    return nil
end

function _OrbwalkManager:GetClearMode()
    local bestMinion = nil
    self.EnemyMinions:update()
    self.JungleMinions:update()
    if #self.EnemyMinions.objects > #self.JungleMinions.objects then
        return "laneclear"
    elseif #self.EnemyMinions.objects < #self.JungleMinions.objects then
        return "jungleclear"
    end
    return nil
end

function _OrbwalkManager:RegisterAfterAttackCallback(func)
    table.insert(self.AfterAttackCallbacks, func)
end

function _OrbwalkManager:TriggerAfterAttackCallback(spell)
    for i, func in ipairs(self.AfterAttackCallbacks) do
        func(spell)
    end
end

function _OrbwalkManager:OrbLoad()
    if self:GetOrbwalkSelected() ~= nil then
        if _G.Reborn_Initialised then
            if self:GetOrbwalkSelected() == "AutoCarry" then
                self.OrbLoaded = self:GetOrbwalkSelected()
                self:EnableMovement()
                self:EnableAttacks()
                if _G.SxOrb ~= nil then
                    _G.SxOrb:DisableMove()
                    _G.SxOrb:DisableAttacks()
                    PrintMessage("Disabling Movement and Attacks from SxOrbWalk because you decided to use "..self:GetOrbwalkSelected()..".")
                end
                return
            else
                _G.AutoCarry.MyHero:MovementEnabled(false)
                _G.AutoCarry.MyHero:AttacksEnabled(false)
                PrintMessage("Disabling Movement and Attacks from SAC:R because you decided to use "..self:GetOrbwalkSelected()..".")
                return
            end
        end
        if _G.Reborn_Loaded and not _G.Reborn_Initialised then
            DelayAction(function() self:OrbLoad() end, 1)
        end
        if self.Loaded == nil then
            self.Loaded = true
            if self:GetOrbwalkSelected() == "MMA" then
                self.OrbLoaded = self:GetOrbwalkSelected()
                self:EnableMovement()
                self:EnableAttacks()
            elseif self:GetOrbwalkSelected() == "SxOrbWalk" then
                if _G.SxOrb == nil then
                    require 'SxOrbWalk'
                    _G.SxOrb:LoadToMenu()
                end
                self.OrbLoaded = self:GetOrbwalkSelected()
                self:EnableMovement()
                self:EnableAttacks()
            elseif self:GetOrbwalkSelected() == "SOW" then
                if _G.SOWi == nil then
                    require 'SOW'
                    _G.SOWi:LoadToMenu()
                end
                self.OrbLoaded = self:GetOrbwalkSelected()
                if _G.VP then
                    _G.SOWi = SOW(_G.VP)
                end
                self:EnableMovement()
                self:EnableAttacks()
            elseif self:GetOrbwalkSelected() == "Big Fat Walk" then
                require "Big Fat Orbwalker"
                self.OrbLoaded = self:GetOrbwalkSelected()
                self:EnableMovement()
                self:EnableAttacks()
            elseif self:GetOrbwalkSelected() == "NOW" then
                if _G.NOWi == nil then
                    require "Nebelwolfi's Orb Walker"
                    _G.NOWi = NebelwolfisOrbWalker()
                end
                self.OrbLoaded = self:GetOrbwalkSelected()
                self:EnableMovement()
                self:EnableAttacks()
            end
        end
    else
        _Required():Add({Name = "SxOrbWalk", Url = "raw.githubusercontent.com/Superx321/BoL/master/common/SxOrbWalk.lua"}):Check()
    end
end

function _OrbwalkManager:AddKey(t)
    assert(t and type(t) == "table", "OrbwalkManager: AddKey Table is invalid!")
    if self.KeysMenu ~= nil then
        local name = t.Name
        assert(name and type(name) == "string", "OrbwalkManager: AddKey Name is invalid!")
        local text = t.Text
        assert(text and type(text) == "string", "OrbwalkManager: AddKey Text is invalid!")
        local tipo = t.Type ~= nil and t.Type or SCRIPT_PARAM_ONKEYDOWN
        local key = t.Key
        assert(key and type(key) == "number", "OrbwalkManager: AddKey Key is invalid!")
        local mode = t.Mode 
        assert(mode and type(mode) == "number", "OrbwalkManager: AddKey Mode is invalid!")

        self.KeysMenu:addDynamicParam(name, text, tipo, false, key)
        self.KeysMenu[name] = false
        self.KeyMan:RegisterKey(self.KeysMenu, name, mode)
        self.Register = true
        self.LastKeyAdded = os.clock()
    end
end

function _OrbwalkManager:ResetMove()
    self.AA.LastTime = self:GetTime() + self:Latency() - self:WindUpTime()
    self.AA.Object = nil
end

function _OrbwalkManager:ResetAA()
    self.AA.LastTime = self:GetTime() + self:Latency() - self:AnimationTime()
    self.GotReset = true
    if self.OrbLoaded == "AutoCarry" then
        _G.AutoCarry.Orbwalker:ResetAttackTimer()
    elseif self.OrbLoaded == "SxOrbWalk" then
        _G.SxOrb:ResetAA()
    elseif self.OrbLoaded == "SOW" then
        _G.SOWi:resetAA()
    elseif self.OrbLoaded == "NOW" then
        _G.NOWi.orbTable.lastAA = os.clock() - GetLatency() / 2000 - _G.NOWi.orbTable.animation
    elseif self.OrbLoaded == "MMA" then
        _G.MMA_ResetAutoAttack()
    end
end

function _OrbwalkManager:DisableMovement()
    if self.Move then
        if self.OrbLoaded == "AutoCarry" then
            _G.AutoCarry.MyHero:MovementEnabled(false)
            self.Move = false
        elseif self.OrbLoaded == "SxOrbWalk" then
            _G.SxOrb:DisableMove()
            self.Move = false
        elseif self.OrbLoaded == "SOW" then
            _G.SOWi.Move = false
            self.Move = false
        elseif self.OrbLoaded == "Big Fat Walk" then
            _G["BigFatOrb_DisableMove"] = true
            self.Move = false
        elseif self.OrbLoaded == "MMA" then
            _G.MMA_AvoidMovement(true)
            self.Move = false
        elseif self.OrbLoaded == "NOW" then
            _G.NOWi:SetMove(false)
            self.Move = false
        end
    end
end

function _OrbwalkManager:EnableMovement()
    if not self.Move then
        if self.OrbLoaded == "AutoCarry" then
            _G.AutoCarry.MyHero:MovementEnabled(true)
            self.Move = true
        elseif self.OrbLoaded == "SxOrbWalk" then
            _G.SxOrb:EnableMove()
            self.Move = true
        elseif self.OrbLoaded == "SOW" then
            _G.SOWi.Move = true
            self.Move = true
        elseif self.OrbLoaded == "Big Fat Walk" then
            _G["BigFatOrb_DisableMove"] = false
            self.Move = true
        elseif self.OrbLoaded == "MMA" then
            _G.MMA_AvoidMovement(false)
            self.Move = true
        elseif self.OrbLoaded == "NOW" then
            _G.NOWi:SetMove(true)
            self.Move = true
        end
    end
end

function _OrbwalkManager:DisableAttacks()
    if self.Attack then
        if self.OrbLoaded == "AutoCarry" then
            _G.AutoCarry.MyHero:AttacksEnabled(false)
            self.Attack = false
        elseif self.OrbLoaded == "SxOrbWalk" then
            _G.SxOrb:DisableAttacks()
            self.Attack = false
        elseif self.OrbLoaded == "SOW" then
            _G.SOWi.Attacks = false
            self.Attack = false
        elseif self.OrbLoaded == "Big Fat Walk" then
            _G["BigFatOrb_DisableAttacks"] = true
            self.Attack = false
        elseif self.OrbLoaded == "MMA" then
            _G.MMA_StopAttacks(true)
            self.Attack = false
        elseif self.OrbLoaded == "NOW" then
            _G.NOWi:SetAA(false)
            self.Attack = false
        end
    end
end

function _OrbwalkManager:EnableAttacks()
    if not self.Attack then
        if self.OrbLoaded == "AutoCarry" then
            _G.AutoCarry.MyHero:AttacksEnabled(true)
            self.Attack = true
        elseif self.OrbLoaded == "SxOrbWalk" then
            _G.SxOrb:EnableAttacks()
            self.Attack = true
        elseif self.OrbLoaded == "SOW" then
            _G.SOWi.Attacks = true
            self.Attack = true
        elseif self.OrbLoaded == "Big Fat Walk" then
            _G["BigFatOrb_DisableAttacks"] = false
            self.Attack = true
        elseif self.OrbLoaded == "MMA" then
            _G.MMA_StopAttacks(false)
            self.Attack = true
        elseif self.OrbLoaded == "NOW" then
            _G.NOWi:SetAA(true)
            self.Attack = true
        end
    end
end

--CLASS INITIATOR
function _Initiator:__init(menu)
    self.Callbacks = {}
    self.ActiveSpells = {}
    assert(menu, "_Initiator: menu is invalid!")
    self.Menu = menu
    if #GetAllyHeroes() > 0 and self.Menu~=nil then
        for idx, ally in ipairs(GetAllyHeroes()) do
            self.Menu:addParam(ally.charName.."Q", ally.charName.." (Q)", SCRIPT_PARAM_ONOFF, false)
            self.Menu:addParam(ally.charName.."W", ally.charName.." (W)", SCRIPT_PARAM_ONOFF, false)
            self.Menu:addParam(ally.charName.."E", ally.charName.." (E)", SCRIPT_PARAM_ONOFF, false)
            self.Menu:addParam(ally.charName.."R", ally.charName.." (R)", SCRIPT_PARAM_ONOFF, false)
        end
        self.Menu:addParam("Time",  "Time Limit to Initiate", SCRIPT_PARAM_SLICE, 2.5, 0, 8, 0)
        if AddProcessSpellCallback then
            AddProcessSpellCallback(function(unit, spell) self:OnProcessSpell(unit, spell) end)
        end
        AddTickCallback(
            function()
                if #self.ActiveSpells > 0 then
                    for i = #self.ActiveSpells, 1, -1 do
                        local spell = self.ActiveSpells[i]
                        if os.clock() + Latency() - spell.Time <= self.Menu.Time then
                            self:TriggerCallbacks(spell.Unit)
                        else
                            table.remove(self.ActiveSpells, i)
                        end
                    end
                end
            end
        )
    end
end

function _Initiator:OnProcessSpell(unit, spell)
    if not myHero.dead and unit and spell and spell.name and not unit.isMe and unit.type and unit.team and GetDistanceSqr(myHero, unit) < 2000 * 2000 then
        if unit.type == myHero.type and unit.team == myHero.team and unit.charName then
            local spelltype = ""
            local spellName = tostring(spell.name)
            if tostring(unit:GetSpellData(_Q).name):find(spellName) then
                spelltype = "Q"
            elseif tostring(unit:GetSpellData(_W).name):find(spellName) then
                spelltype = "W"
            elseif tostring(unit:GetSpellData(_E).name):find(spellName) then
                spelltype = "E"
            elseif tostring(unit:GetSpellData(_R).name):find(spellName) then
                spelltype = "R"
            end
            if spelltype ~= "" then
                if self.Menu[tostring(unit.charName)..spelltype] then 
                    table.insert(self.ActiveSpells, {Time = os.clock() - Latency(), Unit = unit})
                end
            end
            --[[
            local spelltype, casttype = getSpellType(unit, spell.name)
            if spelltype == "Q" or spelltype == "W" or spelltype == "E" or spelltype == "R" then
                if self.Menu[unit.charName..spelltype] then 
                    table.insert(self.ActiveSpells, {Time = os.clock() - Latency(), Unit = unit})
                end
            end]]
        end
    end
end

function _Initiator:CheckChannelingSpells()
    if #GetAllyHeroes() > 0 then
        for idx, enemy in ipairs(GetEnemyHeroes()) do
            if CHANELLING_SPELLS[enemy.charName] then
                for i, spell in pairs(CHANELLING_SPELLS[enemy.charName]) do
                    self.Menu[enemy.charName..spell] = true
                end
            end
        end
    end
    return self
end

function _Initiator:CheckGapcloserSpells()
    if #GetAllyHeroes() > 0 then
        for idx, enemy in ipairs(GetEnemyHeroes()) do
            if GAPCLOSER_SPELLS[enemy.charName] then
                for i, spell in pairs(GAPCLOSER_SPELLS[enemy.charName]) do
                    self.Menu[enemy.charName..spell] = true
                end
            end
        end
    end
    return self
end

function _Initiator:AddCallback(cb)
    table.insert(self.Callbacks, cb)
    return self
end

function _Initiator:TriggerCallbacks(unit)
    for i, callback in ipairs(self.Callbacks) do
        callback(unit)
    end
end

--CLASS EVADER
function _Evader:__init(menu)
    assert(menu, "_Evader: menu is invalid!")
    self.Callbacks = {}
    self.ActiveSpells = {}
    self.Menu = menu
    if #GetEnemyHeroes() > 0 and self.Menu~=nil then
        for idx, enemy in ipairs(GetEnemyHeroes()) do
            self.Menu:addParam(enemy.charName.."Q", enemy.charName.." (Q)", SCRIPT_PARAM_ONOFF, false)
            self.Menu:addParam(enemy.charName.."W", enemy.charName.." (W)", SCRIPT_PARAM_ONOFF, false)
            self.Menu:addParam(enemy.charName.."E", enemy.charName.." (E)", SCRIPT_PARAM_ONOFF, false)
            self.Menu:addParam(enemy.charName.."R", enemy.charName.." (R)", SCRIPT_PARAM_ONOFF, false)
        end
        self.Menu:addParam("Time",  "Time Limit to Evade", SCRIPT_PARAM_SLICE, 0.7, 0, 4, 1)
        self.Menu:addParam("Humanizer",  "% of Humanizer", SCRIPT_PARAM_SLICE, 0, 0, 100)
        AddProcessSpellCallback(function(unit, spell) self:OnProcessSpell(unit, spell) end)
        AddTickCallback(
            function()
                if #self.ActiveSpells > 0 then
                    for i = #self.ActiveSpells, 1, -1 do
                        local sp = self.ActiveSpells[i]
                        if os.clock() + Latency() - sp.Time <= self.Menu.Time then
                            local unit = sp.Unit
                            local spell = sp.Spell
                            local spelltype = sp.SpellType
                            self:CheckHitChampion(unit, spell, spelltype)
                        else
                            table.remove(self.ActiveSpells, i)
                        end
                    end
                end
            end
        )
    end
    return self
end

function _Evader:OnProcessSpell(unit, spell)
    if not myHero.dead and unit and spell and spell.name and not unit.isMe and unit.type and unit.team and spell.windUpTime and GetDistanceSqr(myHero, unit) < 2000 * 2000 then
        if unit.type == myHero.type and unit.team ~= myHero.team and unit.charName then
            local spelltype = ""
            local spellName = tostring(spell.name)
            if tostring(unit:GetSpellData(_Q).name):find(spellName) then
                spelltype = "Q"
            elseif tostring(unit:GetSpellData(_W).name):find(spellName) then
                spelltype = "W"
            elseif tostring(unit:GetSpellData(_E).name):find(spellName) then
                spelltype = "E"
            elseif tostring(unit:GetSpellData(_R).name):find(spellName) then
                spelltype = "R"
            end
            if spelltype ~= "" then
                if self.Menu[tostring(unit.charName)..spelltype] then
                    if spell.windUpTime * self.Menu.Humanizer/100 > 0 then
                        DelayAction(
                            function(unit, spell) 
                                table.insert(self.ActiveSpells, {Time = os.clock() - Latency(), Unit = unit, Spell = spell, SpellType = spelltype})
                                self:CheckHitChampion(unit, spell, spelltype)
                            end
                        , 
                            spell.windUpTime * self.Menu.Humanizer/100
                        , 
                            {unit, spell}
                        )
                    else
                            table.insert(self.ActiveSpells, {Time = os.clock() - Latency(), Unit = unit, Spell = spell, SpellType = spelltype})
                            self:CheckHitChampion(unit, spell, spelltype)
                    end
                end
            end
            --[[
            local spelltype, casttype = getSpellType(unit, spell.name)
            if spelltype == "Q" or spelltype == "W" or spelltype == "E" or spelltype == "R" then
                if self.Menu[unit.charName..spelltype] then
                    DelayAction(
                        function() 
                            table.insert(self.ActiveSpells, {Time = os.clock() - Latency(), Unit = unit, Spell = spell, SpellType = spelltype})
                            self:CheckHitChampion(unit, spell, spelltype)
                        end
                    , 
                        math.max(spell.windUpTime * self.Menu.Humanizer/100 - 2 * Latency(), 0)
                    )
                end
            end]]
        end
    end
end

function _Evader:CheckHitChampion(unit, spell, spelltype, champion)
    if unit and unit.charName and spell and spelltype and unit.valid then
        local hitchampion = false
        local champion = champion ~= nil and champion or myHero
        local charName = tostring(unit.charName)
        if skillData[charName] ~= nil and skillData[charName][spelltype] ~= nil then
            local shottype  = skillData[charName][spelltype].type
            local radius    = skillData[charName][spelltype].radius
            local maxdistance = skillData[charName][spelltype].maxdistance
            if shottype == 0 then hitchampion = spell.target and spell.target.networkID == champion.networkID or false
            elseif shottype == 1 then hitchampion = checkhitlinepass(unit, spell.endPos, radius, maxdistance, champion, champion.boundingRadius)
            elseif shottype == 2 then hitchampion = checkhitlinepoint(unit, spell.endPos, radius, maxdistance, champion, champion.boundingRadius)
            elseif shottype == 3 then hitchampion = checkhitaoe(unit, spell.endPos, radius, maxdistance, champion, champion.boundingRadius)
            elseif shottype == 4 then hitchampion = checkhitcone(unit, spell.endPos, radius, maxdistance, champion, champion.boundingRadius)
            elseif shottype == 5 then hitchampion = checkhitwall(unit, spell.endPos, radius, maxdistance, champion, champion.boundingRadius)
            elseif shottype == 6 then hitchampion = checkhitlinepass(unit, spell.endPos, radius, maxdistance, champion, champion.boundingRadius) or checkhitlinepass(unit, Vector(unit)*2-spell.endPos, radius, maxdistance, champion, champion.boundingRadius)
            elseif shottype == 7 then hitchampion = checkhitcone(spell.endPos, unit, radius, maxdistance, champion, champion.boundingRadius)
            end
        else
            if spell.target ~= nil and spell.target.networkID == champion.networkID then hitchampion = true end
            if spell.endPos ~= nil then
                local pointSegment, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(Vector(unit), Vector(spell.endPos.x, unit.y, spell.endPos.y), champion)
                if isOnSegment and GetDistanceSqr(pointSegment, champion) < math.pow(300, 2)  then
                    hitchampion = true
                end
            end
        end
        if hitchampion then
            self:TriggerCallbacks(unit, spell)
        end
    end
end

function _Evader:CheckCC()
    if #GetEnemyHeroes() > 0 then
        for idx, enemy in ipairs(GetEnemyHeroes()) do
            if CC_SPELLS[enemy.charName] then
                for i, spell in pairs(CC_SPELLS[enemy.charName]) do
                    self.Menu[enemy.charName..spell] = true
                end
            end
        end
    end
    return self
end

function _Evader:CheckYasuoWall()
    if #GetEnemyHeroes() > 0 then
        for idx, enemy in ipairs(GetEnemyHeroes()) do
            if YASUO_WALL_SPELLS[enemy.charName] then
                for i, spell in pairs(YASUO_WALL_SPELLS[enemy.charName]) do
                    self.Menu[enemy.charName..spell] = true
                end
            end
        end
    end
    return self
end

function _Evader:AddCallback(cb)
    table.insert(self.Callbacks, cb)
    return self
end


function _Evader:TriggerCallbacks(unit, spell)
    for i, callback in ipairs(self.Callbacks) do
        callback(unit, spell)
    end
end

function _Interrupter:__init(menu)
    self.Callbacks = {}
    assert(menu, "_Interrupter: menu is invalid!")
    self.Menu = menu
    self.ActiveSpells = {}
    if #GetEnemyHeroes() > 0 and self.Menu~=nil then
        for idx, enemy in ipairs(GetEnemyHeroes()) do
            self.Menu:addParam(enemy.charName.."Q", enemy.charName.." (Q)", SCRIPT_PARAM_ONOFF, false)
            self.Menu:addParam(enemy.charName.."W", enemy.charName.." (W)", SCRIPT_PARAM_ONOFF, false)
            self.Menu:addParam(enemy.charName.."E", enemy.charName.." (E)", SCRIPT_PARAM_ONOFF, false)
            self.Menu:addParam(enemy.charName.."R", enemy.charName.." (R)", SCRIPT_PARAM_ONOFF, false)
        end
        self.Menu:addParam("Time",  "Time Limit to Interrupt", SCRIPT_PARAM_SLICE, 2.5, 0, 8, 1)
        if AddProcessSpellCallback then
            AddProcessSpellCallback(function(unit, spell) self:OnProcessSpell(unit, spell) end)
        end
        AddTickCallback(
            function()
                if #self.ActiveSpells > 0 then
                    for i = #self.ActiveSpells, 1, -1 do
                        local spell = self.ActiveSpells[i]
                        if os.clock() + Latency() - spell.Time <= self.Menu.Time then
                            self:TriggerCallbacks(spell.Unit, spell.Spell)
                        else
                            table.remove(self.ActiveSpells, i)
                        end
                    end
                end
            end
        )
    end
    return self
end

function _Interrupter:OnProcessSpell(unit, spell)
    if not myHero.dead and unit and spell and spell.name and not unit.isMe and unit.type and unit.team and GetDistanceSqr(myHero, unit) < 2000 * 2000 then
        if unit.type == myHero.type and unit.team ~= myHero.team and unit.charName then
            local spelltype = ""
            local spellName = tostring(spell.name)
            if tostring(unit:GetSpellData(_Q).name):find(spellName) then
                spelltype = "Q"
            elseif tostring(unit:GetSpellData(_W).name):find(spellName) then
                spelltype = "W"
            elseif tostring(unit:GetSpellData(_E).name):find(spellName) then
                spelltype = "E"
            elseif tostring(unit:GetSpellData(_R).name):find(spellName) then
                spelltype = "R"
            end
            if spelltype ~= "" then
                if self.Menu[tostring(unit.charName)..spelltype] then
                    table.insert(self.ActiveSpells, {Time = os.clock() - Latency(), Unit = unit, Spell = spell})
                end
            end
            --[[
            local spelltype, casttype = getSpellType(unit, spell.name)
            if spelltype == "Q" or spelltype == "W" or spelltype == "E" or spelltype == "R" then
                if self.Menu[unit.charName..spelltype] then 
                end
            end]]
        end
    end
end

function _Interrupter:CheckChannelingSpells()
    if #GetEnemyHeroes() > 0 then
        for idx, enemy in ipairs(GetEnemyHeroes()) do
            if CHANELLING_SPELLS[enemy.charName] then
                for i, spell in pairs(CHANELLING_SPELLS[enemy.charName]) do
                    self.Menu[enemy.charName..spell] = true
                end
            end
        end
    end
    return self
end

function _Interrupter:CheckGapcloserSpells()
    if #GetEnemyHeroes() > 0 then
        for idx, enemy in ipairs(GetEnemyHeroes()) do
            if GAPCLOSER_SPELLS[enemy.charName] then
                for i, spell in pairs(GAPCLOSER_SPELLS[enemy.charName]) do
                    self.Menu[enemy.charName..spell] = true
                end
            end
        end
    end
    return self
end

function _Interrupter:AddCallback(cb)
    table.insert(self.Callbacks, cb)
    return self
end

function _Interrupter:TriggerCallbacks(unit, spell)
    for i, callback in ipairs(self.Callbacks) do
        callback(unit, spell)
    end
end


-- CLASS: _ScriptUpdate
function _ScriptUpdate:__init(tab)
    assert(tab and type(tab) == "table", "_ScriptUpdate: table is invalid!")
    self.LocalVersion = tab.LocalVersion
    assert(self.LocalVersion and type(self.LocalVersion) == "number", "_ScriptUpdate: LocalVersion is invalid!")
    local UseHttps = tab.UseHttps ~= nil and tab.UseHttps or true
    local VersionPath = tab.VersionPath
    assert(VersionPath and type(VersionPath) == "string", "_ScriptUpdate: VersionPath is invalid!")
    local ScriptPath = tab.ScriptPath
    assert(ScriptPath and type(ScriptPath) == "string", "_ScriptUpdate: ScriptPath is invalid!")
    local SavePath = tab.SavePath
    assert(SavePath and type(SavePath) == "string", "_ScriptUpdate: SavePath is invalid!")
    self.VersionPath = '/BoL/TCPUpdater/GetScript'..(UseHttps and '5' or '6')..'.php?script='..self:Base64Encode(VersionPath)..'&rand='..math.random(99999999)
    self.ScriptPath = '/BoL/TCPUpdater/GetScript'..(UseHttps and '5' or '6')..'.php?script='..self:Base64Encode(ScriptPath)..'&rand='..math.random(99999999)
    self.SavePath = SavePath
    self.CallbackUpdate = tab.CallbackUpdate
    self.CallbackNoUpdate = tab.CallbackNoUpdate
    self.CallbackNewVersion = tab.CallbackNewVersion
    self.CallbackError = tab.CallbackError
    --AddDrawCallback(function() self:OnDraw() end)
    self:CreateSocket(self.VersionPath)
    self.DownloadStatus = 'Connect to Server for VersionInfo'
    AddTickCallback(function() self:GetOnlineVersion() end)
end

function _ScriptUpdate:print(str)
    print('<font color="#FFFFFF">'..os.clock()..': '..str)
end

function _ScriptUpdate:OnDraw()
    if self.DownloadStatus ~= 'Downloading Script (100%)' then
    end
end

function _ScriptUpdate:CreateSocket(url)
    if not self.LuaSocket then
        self.LuaSocket = require("socket")
    else
        self.Socket:close()
        self.Socket = nil
        self.Size = nil
        self.RecvStarted = false
    end
    self.Socket = self.LuaSocket.tcp()
    if not self.Socket then
        print('Socket Error')
    else
        self.Socket:settimeout(0, 'b')
        self.Socket:settimeout(99999999, 't')
        self.Socket:connect('sx-bol.eu', 80)
        self.Url = url
        self.Started = false
        self.LastPrint = ""
        self.File = ""
    end
end

function _ScriptUpdate:Base64Encode(data)
    local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    return ((data:gsub('.', function(x)
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end

function _ScriptUpdate:GetOnlineVersion()
    if self.GotScriptVersion then return end

    self.Receive, self.Status, self.Snipped = self.Socket:receive(1024)
    if self.Status == 'timeout' and not self.Started then
        self.Started = true
        self.Socket:send("GET "..self.Url.." HTTP/1.1\r\nHost: sx-bol.eu\r\n\r\n")
    end
    if (self.Receive or (#self.Snipped > 0)) and not self.RecvStarted then
        self.RecvStarted = true
        self.DownloadStatus = 'Downloading VersionInfo (0%)'
    end

    self.File = self.File .. (self.Receive or self.Snipped)
    if self.File:find('</s'..'ize>') then
        if not self.Size then
            self.Size = tonumber(self.File:sub(self.File:find('<si'..'ze>')+6,self.File:find('</si'..'ze>')-1))
        end
        if self.File:find('<scr'..'ipt>') then
            local _,ScriptFind = self.File:find('<scr'..'ipt>')
            local ScriptEnd = self.File:find('</scr'..'ipt>')
            if ScriptEnd then ScriptEnd = ScriptEnd - 1 end
            local DownloadedSize = self.File:sub(ScriptFind+1,ScriptEnd or -1):len()
            self.DownloadStatus = 'Downloading VersionInfo ('..math.round(100/self.Size*DownloadedSize,2)..'%)'
        end
    end
    if self.File:find('</scr'..'ipt>') then
        self.DownloadStatus = 'Downloading VersionInfo (100%)'
        local a,b = self.File:find('\r\n\r\n')
        self.File = self.File:sub(a,-1)
        self.NewFile = ''
        for line,content in ipairs(self.File:split('\n')) do
            if content:len() > 5 then
                self.NewFile = self.NewFile .. content
            end
        end
        local HeaderEnd, ContentStart = self.File:find('<scr'..'ipt>')
        local ContentEnd, _ = self.File:find('</sc'..'ript>')
        if not ContentStart or not ContentEnd then
            if self.CallbackError and type(self.CallbackError) == 'function' then
                self.CallbackError()
            end
        else
            self.OnlineVersion = (Base64Decode(self.File:sub(ContentStart + 1,ContentEnd-1)))
            if self.OnlineVersion ~= nil then
                self.OnlineVersion = tonumber(self.OnlineVersion)
                if self.OnlineVersion ~= nil and self.LocalVersion ~= nil and type(self.OnlineVersion) == "number" and type(self.LocalVersion) == "number" and self.OnlineVersion > self.LocalVersion then
                    if self.CallbackNewVersion and type(self.CallbackNewVersion) == 'function' then
                        self.CallbackNewVersion(self.OnlineVersion,self.LocalVersion)
                    end
                    self:CreateSocket(self.ScriptPath)
                    self.DownloadStatus = 'Connect to Server for ScriptDownload'
                    AddTickCallback(function() self:DownloadUpdate() end)
                else
                    if self.CallbackNoUpdate and type(self.CallbackNoUpdate) == 'function' then
                        self.CallbackNoUpdate(self.LocalVersion)
                    end
                end
            end
        end
        self.GotScriptVersion = true
    end
end

function _ScriptUpdate:DownloadUpdate()
    if self.GotScriptUpdate then return end
    self.Receive, self.Status, self.Snipped = self.Socket:receive(1024)
    if self.Status == 'timeout' and not self.Started then
        self.Started = true
        self.Socket:send("GET "..self.Url.." HTTP/1.1\r\nHost: sx-bol.eu\r\n\r\n")
    end
    if (self.Receive or (#self.Snipped > 0)) and not self.RecvStarted then
        self.RecvStarted = true
        self.DownloadStatus = 'Downloading Script (0%)'
    end

    self.File = self.File .. (self.Receive or self.Snipped)
    if self.File:find('</si'..'ze>') then
        if not self.Size then
            self.Size = tonumber(self.File:sub(self.File:find('<si'..'ze>')+6,self.File:find('</si'..'ze>')-1))
        end
        if self.File:find('<scr'..'ipt>') then
            local _,ScriptFind = self.File:find('<scr'..'ipt>')
            local ScriptEnd = self.File:find('</scr'..'ipt>')
            if ScriptEnd then ScriptEnd = ScriptEnd - 1 end
            local DownloadedSize = self.File:sub(ScriptFind+1,ScriptEnd or -1):len()
            self.DownloadStatus = 'Downloading Script ('..math.round(100/self.Size*DownloadedSize,2)..'%)'
        end
    end
    if self.File:find('</scr'..'ipt>') then
        self.DownloadStatus = 'Downloading Script (100%)'
        local a,b = self.File:find('\r\n\r\n')
        self.File = self.File:sub(a,-1)
        self.NewFile = ''
        for line,content in ipairs(self.File:split('\n')) do
            if content:len() > 5 then
                self.NewFile = self.NewFile .. content
            end
        end
        local HeaderEnd, ContentStart = self.NewFile:find('<sc'..'ript>')
        local ContentEnd, _ = self.NewFile:find('</scr'..'ipt>')
        if not ContentStart or not ContentEnd then
            if self.CallbackError and type(self.CallbackError) == 'function' then
                self.CallbackError()
            end
        else
            local newf = self.NewFile:sub(ContentStart+1,ContentEnd-1)
            local newf = newf:gsub('\r','')
            if newf:len() ~= self.Size then
                if self.CallbackError and type(self.CallbackError) == 'function' then
                    self.CallbackError()
                end
                return
            end
            local newf = Base64Decode(newf)
            if type(load(newf)) ~= 'function' then
                if self.CallbackError and type(self.CallbackError) == 'function' then
                    self.CallbackError()
                end
            else
                local f = io.open(self.SavePath,"w+b")
                f:write(newf)
                f:close()
                if self.CallbackUpdate and type(self.CallbackUpdate) == 'function' then
                    self.CallbackUpdate(self.OnlineVersion,self.LocalVersion)
                end
            end
        end
        self.GotScriptUpdate = true
    end
end

--CLASS: _KeyManager
function _KeyManager:__init()
    self.ComboKeys = {}
    self.Combo = false
    self.HarassKeys = {}
    self.Harass = false
    self.LastHitKeys = {}
    self.LastHit = false
    self.ClearKeys = {}
    self.Clear = false
    AddTickCallback(function() self:OnTick() end)
end

function _KeyManager:ModePressed()
    if self.Combo then return ORBWALK_MODE.COMBO
    elseif self.Harass then return ORBWALK_MODE.HARASS
    elseif self.Clear then return ORBWALK_MODE.CLEAR
    elseif self.LastHit then return ORBWALK_MODE.LASTHIT
    else return ORBWALK_MODE.NONE end
end

function _KeyManager:IsKeyPressed(list)
    if #list > 0 then
        for i = 1, #list do
            if list[i] then
                local key = list[i]
                if #key > 0 then
                    local menu = key[1]
                    local param = key[2]
                    if menu and param and menu[param] then
                        return true
                    end
                end
            end
        end
    end
    return false
end
function _KeyManager:IsComboPressed()
    if OrbwalkManager.KeysMenu and OrbwalkManager.KeysMenu.Common then
        if OrbwalkManager.OrbLoaded == "AutoCarry" then
            if _G.AutoCarry.Keys.AutoCarry then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "SxOrbWalk" then
            if _G.SxOrb.isFight then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "SOW" then
            if _G.SOWi.Menu.Mode0 then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "MMA" then
            if _G.MMA_IsOrbwalking() then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "Big Fat Walk" then
            if _G["BigFatOrb_Mode"] == "Combo" then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "NOW" then
            if _G.NOWi.Config.k.Combo then
                return true
            end
        end
    end
    return self:IsKeyPressed(self.ComboKeys)
end

function _KeyManager:IsHarassPressed()
    if OrbwalkManager.KeysMenu and OrbwalkManager.KeysMenu.Common then
        if OrbwalkManager.OrbLoaded == "AutoCarry" then
            if _G.AutoCarry.Keys.MixedMode then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "SxOrbWalk" then
            if _G.SxOrb.isHarass then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "SOW" then
            if _G.SOWi.Menu.Mode1 then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "MMA" then
            if _G.MMA_IsDualCarrying() then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "Big Fat Walk" then
            if _G["BigFatOrb_Mode"] == "Harass" then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "NOW" then
            if _G.NOWi.Config.k.Harass then
                return true
            end
        end
    end
    return self:IsKeyPressed(self.HarassKeys)
end

function _KeyManager:IsClearPressed()
    if OrbwalkManager.KeysMenu and OrbwalkManager.KeysMenu.Common then
        if OrbwalkManager.OrbLoaded == "AutoCarry" then
            if _G.AutoCarry.Keys.LaneClear then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "SxOrbWalk" then
            if _G.SxOrb.isLaneClear then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "SOW" then
            if _G.SOWi.Menu.Mode2 then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "MMA" then
            if _G.MMA_IsLaneClearing() then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "Big Fat Walk" then
            if _G["BigFatOrb_Mode"] == "LaneClear" then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "NOW" then
            if _G.NOWi.Config.k.LaneClear then
                return true
            end
        end
    end
    return self:IsKeyPressed(self.ClearKeys)
end

function _KeyManager:IsLastHitPressed()
    if OrbwalkManager.KeysMenu and OrbwalkManager.KeysMenu.Common then
        if OrbwalkManager.OrbLoaded == "AutoCarry" then
            if _G.AutoCarry.Keys.LastHit then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "SxOrbWalk" then
            if _G.SxOrb.isLastHit then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "SOW" then
            if _G.SOWi.Menu.Mode3 then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "MMA" then
            if _G.MMA_IsLastHitting() then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "Big Fat Walk" then
            if _G["BigFatOrb_Mode"] == "LastHit" then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "NOW" then
            if _G.NOWi.Config.k.LastHit then
                return true
            end
        end
    end
    return self:IsKeyPressed(self.LastHitKeys)
end

function _KeyManager:OnTick()
    self.Combo      = self:IsComboPressed()
    self.Harass     = self:IsHarassPressed()
    self.LastHit    = self:IsLastHitPressed()
    self.Clear      = self:IsClearPressed()
end

function _KeyManager:RegisterKey(menu, param, mode)
    if mode == ORBWALK_MODE.COMBO then
        table.insert(self.ComboKeys, {menu, param})
    elseif mode == ORBWALK_MODE.HARASS then
        table.insert(self.HarassKeys, {menu, param})
    elseif mode == ORBWALK_MODE.CLEAR then
        table.insert(self.ClearKeys, {menu, param})
    elseif mode == ORBWALK_MODE.LASTHIT then
        table.insert(self.LastHitKeys, {menu, param})
    end
end

function _KeyManager:RegisterKeys()
    local list = self.ComboKeys
    if #list > 0 then
        for i = 1, #list do
            if list[i] then
                local key = list[i]
                if #key > 0 then
                    local menu = key[1]
                    local param = key[2]
                    --menu._param[menu:getParamIndex(param)].listTable[v]
                    if menu and param then
                        if OrbwalkManager.OrbLoaded == "AutoCarry" then
                            _G.AutoCarry.Keys:RegisterMenuKey(menu, param, AutoCarry.MODE_AUTOCARRY)
                        elseif OrbwalkManager.OrbLoaded == "SxOrbWalk" then
                            _G.SxOrb:RegisterHotKey("fight",  menu, param)
                        elseif OrbwalkManager.OrbLoaded == "MMA" then
                            if menu._param[menu:getParamIndex(param)].key then
                                _G.MMA_AddKey(string.char(menu._param[menu:getParamIndex(param)].key), 'Orbwalking', menu._param[menu:getParamIndex(param)].pType)
                            end
                        end
                    end
                end
            end
        end
    end
    local list = self.HarassKeys
    if #list > 0 then
        for i = 1, #list do
            if list[i] then
                local key = list[i]
                if #key > 0 then
                    local menu = key[1]
                    local param = key[2]
                    if menu and param then
                        if OrbwalkManager.OrbLoaded == "AutoCarry" then
                            _G.AutoCarry.Keys:RegisterMenuKey(menu, param, AutoCarry.MODE_MIXEDMODE)
                        elseif OrbwalkManager.OrbLoaded == "SxOrbWalk" then
                            _G.SxOrb:RegisterHotKey("harass", menu, param)
                        elseif OrbwalkManager.OrbLoaded == "MMA" then
                            if menu._param[menu:getParamIndex(param)].key then
                                _G.MMA_AddKey(string.char(menu._param[menu:getParamIndex(param)].key), 'Orbwalking', menu._param[menu:getParamIndex(param)].pType)
                            end
                        end
                    end
                end
            end
        end
    end
    local list = self.ClearKeys
    if #list > 0 then
        for i = 1, #list do
            if list[i] then
                local key = list[i]
                if #key > 0 then
                    local menu = key[1]
                    local param = key[2]
                    if menu and param then
                        if OrbwalkManager.OrbLoaded == "AutoCarry" then
                            _G.AutoCarry.Keys:RegisterMenuKey(menu, param, AutoCarry.MODE_LANECLEAR)
                        elseif OrbwalkManager.OrbLoaded == "SxOrbWalk" then
                            _G.SxOrb:RegisterHotKey("laneclear", menu, param)
                        elseif OrbwalkManager.OrbLoaded == "MMA" then
                            if menu._param[menu:getParamIndex(param)].key then
                                _G.MMA_AddKey(string.char(menu._param[menu:getParamIndex(param)].key), 'Laneclearing', menu._param[menu:getParamIndex(param)].pType)
                            end
                        end
                    end
                end
            end
        end
    end
    local list = self.LastHitKeys
    if #list > 0 then
        for i = 1, #list do
            if list[i] then
                local key = list[i]
                if #key > 0 then
                    local menu = key[1]
                    local param = key[2]
                    if menu and param then
                        if OrbwalkManager.OrbLoaded == "AutoCarry" then
                            _G.AutoCarry.Keys:RegisterMenuKey(menu, param, AutoCarry.MODE_LASTHIT)
                        elseif OrbwalkManager.OrbLoaded == "SxOrbWalk" then
                            _G.SxOrb:RegisterHotKey("lasthit", menu, param)
                        elseif OrbwalkManager.OrbLoaded == "MMA" then
                            if menu._param[menu:getParamIndex(param)].key then
                                _G.MMA_AddKey(string.char(menu._param[menu:getParamIndex(param)].key), 'Lasthitting', menu._param[menu:getParamIndex(param)].pType)
                            end
                        end
                    end
                end
            end
        end
    end
end


--CLASS: _Required
function _Required:__init()
    self.requirements = {}
    self.downloading = {}
    return self
end

function _Required:Add(t)
    assert(t and type(t) == "table", "_Required: table is invalid!")
    local name = t.Name
    assert(name and type(name) == "string", "_Required: name is invalid!")
    local url = t.Url
    assert(url and type(url) == "string", "_Required: url is invalid!")
    local extension = t.Extension ~= nil and t.Extension or "lua"
    local usehttps = t.UseHttps ~= nil and t.UseHttps or true
    table.insert(self.requirements, {Name = name, Url = url, Extension = extension, UseHttps = usehttps})
    return self
end

function _Required:Check()
    for i, tab in pairs(self.requirements) do
        local name = tab.Name
        local url = tab.Url
        local extension = tab.Extension
        local usehttps = tab.UseHttps
        if not FileExist(LIB_PATH..name.."."..extension) then
            PrintMessage("Downloading a required library called "..name.. ". Please wait...")
            local d = _Downloader(tab)
            table.insert(self.downloading, d)
        end
    end
    
    if #self.downloading > 0 then
        for i = 1, #self.downloading, 1 do 
            local d = self.downloading[i]
            AddTickCallback(function() d:Download() end)
        end
        self:CheckDownloads()
    else
        for i, tab in pairs(self.requirements) do
            local name = tab.Name
            local url = tab.Url
            local extension = tab.Extension
            local usehttps = tab.UseHttps
            if FileExist(LIB_PATH..name.."."..extension) and extension == "lua" then
                require(name)
            end
        end
    end
    return self
end

function _Required:CheckDownloads()
    if #self.downloading == 0 then 
        PrintMessage("Required libraries downloaded. Please reload with 2x F9.")
    else
        for i = 1, #self.downloading, 1 do
            local d = self.downloading[i]
            if d.GotScript then
                table.remove(self.downloading, i)
                break
            end
        end
        DelayAction(function() self:CheckDownloads() end, 2) 
    end
    return self
end

function _Required:IsDownloading()
    return self.downloading ~= nil and #self.downloading > 0 or false
end

-- CLASS: _Downloader
function _Downloader:__init(t)
    local name = t.Name
    local url = t.Url
    local extension = t.Extension ~= nil and t.Extension or "lua"
    local usehttps = t.UseHttps ~= nil and t.UseHttps or true
    self.SavePath = LIB_PATH..name.."."..extension
    self.ScriptPath = '/BoL/TCPUpdater/GetScript'..(usehttps and '5' or '6')..'.php?script='..self:Base64Encode(url)..'&rand='..math.random(99999999)
    self:CreateSocket(self.ScriptPath)
    self.DownloadStatus = 'Connect to Server'
    self.GotScript = false
end

function _Downloader:CreateSocket(url)
    if not self.LuaSocket then
        self.LuaSocket = require("socket")
    else
        self.Socket:close()
        self.Socket = nil
        self.Size = nil
        self.RecvStarted = false
    end
    self.Socket = self.LuaSocket.tcp()
    if not self.Socket then
        print('Socket Error')
    else
        self.Socket:settimeout(0, 'b')
        self.Socket:settimeout(99999999, 't')
        self.Socket:connect('sx-bol.eu', 80)
        self.Url = url
        self.Started = false
        self.LastPrint = ""
        self.File = ""
    end
end

function _Downloader:Download()
    if self.GotScript then return end
    self.Receive, self.Status, self.Snipped = self.Socket:receive(1024)
    if self.Status == 'timeout' and not self.Started then
        self.Started = true
        self.Socket:send("GET "..self.Url.." HTTP/1.1\r\nHost: sx-bol.eu\r\n\r\n")
    end
    if (self.Receive or (#self.Snipped > 0)) and not self.RecvStarted then
        self.RecvStarted = true
        self.DownloadStatus = 'Downloading Script (0%)'
    end

    self.File = self.File .. (self.Receive or self.Snipped)
    if self.File:find('</si'..'ze>') then
        if not self.Size then
            self.Size = tonumber(self.File:sub(self.File:find('<si'..'ze>')+6,self.File:find('</si'..'ze>')-1))
        end
        if self.File:find('<scr'..'ipt>') then
            local _,ScriptFind = self.File:find('<scr'..'ipt>')
            local ScriptEnd = self.File:find('</scr'..'ipt>')
            if ScriptEnd then ScriptEnd = ScriptEnd - 1 end
            local DownloadedSize = self.File:sub(ScriptFind+1,ScriptEnd or -1):len()
            self.DownloadStatus = 'Downloading Script ('..math.round(100/self.Size*DownloadedSize,2)..'%)'
        end
    end
    if self.File:find('</scr'..'ipt>') then
        self.DownloadStatus = 'Downloading Script (100%)'
        local a,b = self.File:find('\r\n\r\n')
        self.File = self.File:sub(a,-1)
        self.NewFile = ''
        for line,content in ipairs(self.File:split('\n')) do
            if content:len() > 5 then
                self.NewFile = self.NewFile .. content
            end
        end
        local HeaderEnd, ContentStart = self.NewFile:find('<sc'..'ript>')
        local ContentEnd, _ = self.NewFile:find('</scr'..'ipt>')
        if not ContentStart or not ContentEnd then
            if self.CallbackError and type(self.CallbackError) == 'function' then
                self.CallbackError()
            end
        else
            local newf = self.NewFile:sub(ContentStart+1,ContentEnd-1)
            local newf = newf:gsub('\r','')
            if newf:len() ~= self.Size then
                if self.CallbackError and type(self.CallbackError) == 'function' then
                    self.CallbackError()
                end
                return
            end
            local newf = Base64Decode(newf)
            if type(load(newf)) ~= 'function' then
                if self.CallbackError and type(self.CallbackError) == 'function' then
                    self.CallbackError()
                end
            else
                local f = io.open(self.SavePath,"w+b")
                f:write(newf)
                f:close()
                if self.CallbackUpdate and type(self.CallbackUpdate) == 'function' then
                    self.CallbackUpdate(self.OnlineVersion,self.LocalVersion)
                end
            end
        end
        self.GotScript = true
    end
end

function _Downloader:Base64Encode(data)
    local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    return ((data:gsub('.', function(x)
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end

-- _SimpleTS
function _SimpleTargetSelector:__init(mode, range, damageType)
    self.TS = TargetSelector(mode, range, damageType)
    self.target = nil
    self.range = range
    self.Menu = nil
    self.multiplier = 1.2
    self.selected = nil
    AddTickCallback(function() self:update() end)
    AddMsgCallback(
        function(msg, key)
            if msg == WM_LBUTTONDOWN then
                local best = nil
                for i, enemy in ipairs(GetEnemyHeroes()) do
                    if IsValidTarget(enemy) then
                        if GetDistanceSqr(enemy, mousePos) < math.pow(150, 2) then
                            local p = WorldToScreen(D3DXVECTOR3(enemy.x, enemy.y, enemy.z))
                            if OnScreen(p.x, p.y) then
                                if best == nil then
                                    best = enemy
                                elseif GetPriority(best) > GetPriority(enemy) then
                                    best = enemy
                                end
                            end
                        end
                    end
                end
                if best then
                    if self.selected and self.selected.networkID == best.networkID then
                        print("<font color=\"#c30000\"><b>Target Selector:</b></font> <font color=\"#FFFFFF\">" .. "New target unselected: "..tostring(best.charName).. "</font>") 
                        self.selected = nil
                    else
                        print("<font color=\"#c30000\"><b>Target Selector:</b></font> <font color=\"#FFFFFF\">" .. "New target selected: "..tostring(best.charName).. "</font>") 
                        self.selected = best
                    end
                end
            end
        end
    )
end

function _SimpleTargetSelector:update()
    self.TS.range = self.range
    self.TS:update()
    self.target = self.TS.target
    if IsValidTarget(self.selected, self.range * self.multiplier) and self.selected.type == myHero.type then
        self.target = self.selected
    end
end

function _SimpleTargetSelector:AddToMenu(Menu)
    if Menu then
        Menu:addSubMenu(myHero.charName.." - Target Selector Settings", "TS")
        self.Menu = Menu.TS
        self.Menu:addTS(self.TS)
        _Circle({Menu = self.Menu, Name = "Draw", Text = "Draw circle on Target", Source = function() return self.target end, Range = 120, Condition = function() return ValidTarget(self.target) end, Color = {255, 255, 0, 0}, Width = 4})
        _Circle({Menu = self.Menu, Name = "Range", Text = "Draw circle for Range", Range = function() return self.range end, Color = {255, 255, 0, 0}, Enable = false})
    end
end

--CREDIT TO EXTRAGOZ
local spellsFile = LIB_PATH.."missedspells.txt"
local spellslist = {}
local textlist = ""
local spellexists = false
local spelltype = "Unknown"
 
function writeConfigsspells()
        local file = io.open(spellsFile, "w")
        if file then
                textlist = "return {"
                for i=1,#spellslist do
                        textlist = textlist.."'"..spellslist[i].."', "
                end
                textlist = textlist.."}"
                if spellslist[1] ~=nil then
                        file:write(textlist)
                        file:close()
                end
        end
end
if FileExist(spellsFile) then spellslist = dofile(spellsFile) end
 
local Others = {"Recall","recall","OdinCaptureChannel","LanternWAlly","varusemissiledummy","khazixqevo","khazixwevo","khazixeevo","khazixrevo","braumedummyvoezreal","braumedummyvonami","braumedummyvocaitlyn","braumedummyvoriven","braumedummyvodraven","braumedummyvoashe","azirdummyspell"}
local Items = {"RegenerationPotion","FlaskOfCrystalWater","ItemCrystalFlask","ItemMiniRegenPotion","PotionOfBrilliance","PotionOfElusiveness","PotionOfGiantStrength","OracleElixirSight","OracleExtractSight","VisionWard","SightWard","sightward","ItemGhostWard","ItemMiniWard","ElixirOfRage","ElixirOfIllumination","wrigglelantern","DeathfireGrasp","HextechGunblade","shurelyascrest","IronStylus","ZhonyasHourglass","YoumusBlade","randuinsomen","RanduinsOmen","Mourning","OdinEntropicClaymore","BilgewaterCutlass","QuicksilverSash","HextechSweeper","ItemGlacialSpike","ItemMercurial","ItemWraithCollar","ItemSoTD","ItemMorellosBane","ItemPromote","ItemTiamatCleave","Muramana","ItemSeraphsEmbrace","ItemSwordOfFeastAndFamine","ItemFaithShaker","OdynsVeil","ItemHorn","ItemPoroSnack","ItemBlackfireTorch","HealthBomb","ItemDervishBlade","TrinketTotemLvl1","TrinketTotemLvl2","TrinketTotemLvl3","TrinketTotemLvl3B","TrinketSweeperLvl1","TrinketSweeperLvl2","TrinketSweeperLvl3","TrinketOrbLvl1","TrinketOrbLvl2","TrinketOrbLvl3","OdinTrinketRevive","RelicMinorSpotter","RelicSpotter","RelicGreaterLantern","RelicLantern","RelicSmallLantern","ItemFeralFlare","trinketorblvl2","trinketsweeperlvl2","trinkettotemlvl2","SpiritLantern","RelicGreaterSpotter"}
local MSpells = {"JayceStaticField","JayceToTheSkies","JayceThunderingBlow","Takedown","Pounce","Swipe","EliseSpiderQCast","EliseSpiderW","EliseSpiderEInitial","elisespidere","elisespideredescent","gnarbigq","gnarbigw","gnarbige","GnarBigQMissile"}
local PSpells = {"CaitlynHeadshotMissile","RumbleOverheatAttack","JarvanIVMartialCadenceAttack","ShenKiAttack","MasterYiDoubleStrike","sonaqattackupgrade","sonawattackupgrade","sonaeattackupgrade","NocturneUmbraBladesAttack","NautilusRavageStrikeAttack","ZiggsPassiveAttack","QuinnWEnhanced","LucianPassiveAttack","SkarnerPassiveAttack","KarthusDeathDefiedBuff","AzirTowerClick","azirtowerclick","azirtowerclickchannel"}
 
local QSpells = {"TrundleQ","LeonaShieldOfDaybreakAttack","XenZhaoThrust","NautilusAnchorDragMissile","RocketGrabMissile","VayneTumbleAttack","VayneTumbleUltAttack","NidaleeTakedownAttack","ShyvanaDoubleAttackHit","ShyvanaDoubleAttackHitDragon","frostarrow","FrostArrow","MonkeyKingQAttack","MaokaiTrunkLineMissile","FlashFrostSpell","xeratharcanopulsedamage","xeratharcanopulsedamageextended","xeratharcanopulsedarkiron","xeratharcanopulsediextended","SpiralBladeMissile","EzrealMysticShotMissile","EzrealMysticShotPulseMissile","jayceshockblast","BrandBlazeMissile","UdyrTigerAttack","TalonNoxianDiplomacyAttack","LuluQMissile","GarenSlash2","VolibearQAttack","dravenspinningattack","karmaheavenlywavec","ZiggsQSpell","UrgotHeatseekingHomeMissile","UrgotHeatseekingLineMissile","JavelinToss","RivenTriCleave","namiqmissile","NasusQAttack","BlindMonkQOne","ThreshQInternal","threshqinternal","QuinnQMissile","LissandraQMissile","EliseHumanQ","GarenQAttack","JinxQAttack","JinxQAttack2","yasuoq","xeratharcanopulse2","VelkozQMissile","KogMawQMis","BraumQMissile","KarthusLayWasteA1","KarthusLayWasteA2","KarthusLayWasteA3","karthuslaywastea3","karthuslaywastea2","karthuslaywastedeada1","MaokaiSapling2Boom","gnarqmissile","GnarBigQMissile","viktorqbuff"}
local WSpells = {"KogMawBioArcaneBarrageAttack","SivirWAttack","TwitchVenomCaskMissile","gravessmokegrenadeboom","mordekaisercreepingdeath","DrainChannel","jaycehypercharge","redcardpreattack","goldcardpreattack","bluecardpreattack","RenektonExecute","RenektonSuperExecute","EzrealEssenceFluxMissile","DariusNoxianTacticsONHAttack","UdyrTurtleAttack","talonrakemissileone","LuluWTwo","ObduracyAttack","KennenMegaProc","NautilusWideswingAttack","NautilusBackswingAttack","XerathLocusOfPower","yoricksummondecayed","Bushwhack","karmaspiritbondc","SejuaniBasicAttackW","AatroxWONHAttackLife","AatroxWONHAttackPower","JinxWMissile","GragasWAttack","braumwdummyspell","syndrawcast","SorakaWParticleMissile"}
local ESpells = {"KogMawVoidOozeMissile","ToxicShotAttack","LeonaZenithBladeMissile","PowerFistAttack","VayneCondemnMissile","ShyvanaFireballMissile","maokaisapling2boom","VarusEMissile","CaitlynEntrapmentMissile","jayceaccelerationgate","syndrae5","JudicatorRighteousFuryAttack","UdyrBearAttack","RumbleGrenadeMissile","Slash","hecarimrampattack","ziggse2","UrgotPlasmaGrenadeBoom","SkarnerFractureMissile","YorickSummonRavenous","BlindMonkEOne","EliseHumanE","PrimalSurge","Swipe","ViEAttack","LissandraEMissile","yasuodummyspell","XerathMageSpearMissile","RengarEFinal","RengarEFinalMAX","KarthusDefileSoundDummy2"}
local RSpells = {"Pantheon_GrandSkyfall_Fall","LuxMaliceCannonMis","infiniteduresschannel","JarvanIVCataclysmAttack","jarvanivcataclysmattack","VayneUltAttack","RumbleCarpetBombDummy","ShyvanaTransformLeap","jaycepassiverangedattack", "jaycepassivemeleeattack","jaycestancegth","MissileBarrageMissile","SprayandPrayAttack","jaxrelentlessattack","syndrarcasttime","InfernalGuardian","UdyrPhoenixAttack","FioraDanceStrike","xeratharcanebarragedi","NamiRMissile","HallucinateFull","QuinnRFinale","lissandrarenemy","SejuaniGlacialPrisonCast","yasuordummyspell","xerathlocuspulse","tempyasuormissile","PantheonRFall"}
 
local casttype2 = {"blindmonkqtwo","blindmonkwtwo","blindmonketwo","infernalguardianguide","KennenMegaProc","sonawattackupgrade","redcardpreattack","fizzjumptwo","fizzjumpbuffer","gragasbarrelrolltoggle","LeblancSlideM","luxlightstriketoggle","UrgotHeatseekingHomeMissile","xeratharcanopulseextended","xeratharcanopulsedamageextended","XenZhaoThrust3","ziggswtoggle","khazixwlong","khazixelong","renektondice","SejuaniNorthernWinds","shyvanafireballdragon2","shyvanaimmolatedragon","ShyvanaDoubleAttackHitDragon","talonshadowassaulttoggle","viktorchaosstormguide","zedw2","ZedR2","khazixqlong","AatroxWONHAttackLife","viktorqbuff"}
local casttype3 = {"sonaeattackupgrade","bluecardpreattack","LeblancSoulShackleM","UdyrPhoenixStance","RenektonSuperExecute"}
local casttype4 = {"FrostShot","PowerFist","DariusNoxianTacticsONH","EliseR","JaxEmpowerTwo","JaxRelentlessAssault","JayceStanceHtG","jaycestancegth","jaycehypercharge","JudicatorRighteousFury","kennenlrcancel","KogMawBioArcaneBarrage","LissandraE","MordekaiserMaceOfSpades","mordekaisercotgguide","NasusQ","Takedown","NocturneParanoia","QuinnR","RengarQ","HallucinateFull","DeathsCaressFull","SivirW","ThreshQInternal","threshqinternal","PickACard","goldcardlock","redcardlock","bluecardlock","FullAutomatic","VayneTumble","MonkeyKingDoubleAttack","YorickSpectral","ViE","VorpalSpikes","FizzSeastonePassive","GarenSlash3","HecarimRamp","leblancslidereturn","leblancslidereturnm","Obduracy","UdyrTigerStance","UdyrTurtleStance","UdyrBearStance","UrgotHeatseekingMissile","XenZhaoComboTarget","dravenspinning","dravenrdoublecast","FioraDance","LeonaShieldOfDaybreak","MaokaiDrain3","NautilusPiercingGaze","RenektonPreExecute","RivenFengShuiEngine","ShyvanaDoubleAttack","shyvanadoubleattackdragon","SyndraW","TalonNoxianDiplomacy","TalonCutthroat","talonrakemissileone","TrundleTrollSmash","VolibearQ","AatroxW","aatroxw2","AatroxWONHAttackLife","JinxQ","GarenQ","yasuoq","XerathArcanopulseChargeUp","XerathLocusOfPower2","xerathlocuspulse","velkozqsplitactivate","NetherBlade","GragasQToggle","GragasW","SionW","sionpassivespeed"}
local casttype5 = {"VarusQ","ZacE","ViQ","SionQ"}
local casttype6 = {"VelkozQMissile","KogMawQMis","RengarEFinal","RengarEFinalMAX","BraumQMissile","KarthusDefileSoundDummy2","gnarqmissile","GnarBigQMissile","SorakaWParticleMissile"}
--,"PoppyDevastatingBlow"--,"Deceive" -- ,"EliseRSpider"
function getSpellType(unit, spellName)
        spelltype = "Unknown"
        casttype = 1
        if unit ~= nil and unit.type == "AIHeroClient" then
                if spellName == nil or unit:GetSpellData(_Q).name == nil or unit:GetSpellData(_W).name == nil or unit:GetSpellData(_E).name == nil or unit:GetSpellData(_R).name == nil then
                        return "Error name nil", casttype
                end
                if spellName:find("SionBasicAttackPassive") or spellName:find("zyrapassive") then
                        spelltype = "P"
                elseif (spellName:find("BasicAttack") and spellName ~= "SejuaniBasicAttackW") or spellName:find("basicattack") or spellName:find("JayceRangedAttack") or spellName == "SonaQAttack" or spellName == "SonaWAttack" or spellName == "SonaEAttack" or spellName == "ObduracyAttack" or spellName == "GnarBigAttackTower" then
                        spelltype = "BAttack"
                elseif spellName:find("CritAttack") or spellName:find("critattack") then
                        spelltype = "CAttack"
                elseif unit:GetSpellData(_Q).name:find(spellName) then
                        spelltype = "Q"
                elseif unit:GetSpellData(_W).name:find(spellName) then
                        spelltype = "W"
                elseif unit:GetSpellData(_E).name:find(spellName) then
                        spelltype = "E"
                elseif unit:GetSpellData(_R).name:find(spellName) then
                        spelltype = "R"
                elseif spellName:find("Summoner") or spellName:find("summoner") or spellName == "teleportcancel" then
                        spelltype = "Summoner"
                else
                        if spelltype == "Unknown" then
                                for i=1,#Others do
                                        if spellName:find(Others[i]) then
                                                spelltype = "Other"
                                        end
                                end
                        end
                        if spelltype == "Unknown" then
                                for i=1,#Items do
                                        if spellName:find(Items[i]) then
                                                spelltype = "Item"
                                        end
                                end
                        end
                        if spelltype == "Unknown" then
                                for i=1,#PSpells do
                                        if spellName:find(PSpells[i]) then
                                                spelltype = "P"
                                        end
                                end
                        end
                        if spelltype == "Unknown" then
                                for i=1,#QSpells do
                                        if spellName:find(QSpells[i]) then
                                                spelltype = "Q"
                                        end
                                end
                        end
                        if spelltype == "Unknown" then
                                for i=1,#WSpells do
                                        if spellName:find(WSpells[i]) then
                                                spelltype = "W"
                                        end
                                end
                        end
                        if spelltype == "Unknown" then
                                for i=1,#ESpells do
                                        if spellName:find(ESpells[i]) then
                                                spelltype = "E"
                                        end
                                end
                        end
                        if spelltype == "Unknown" then
                                for i=1,#RSpells do
                                        if spellName:find(RSpells[i]) then
                                                spelltype = "R"
                                        end
                                end
                        end
                end
                for i=1,#MSpells do
                        if spellName == MSpells[i] then
                                spelltype = spelltype.."M"
                        end
                end
                local spellexists = spelltype ~= "Unknown"
                if #spellslist > 0 and not spellexists then
                        for i=1,#spellslist do
                                if spellName == spellslist[i] then
                                        spellexists = true
                                end
                        end
                end
                if not spellexists then
                        table.insert(spellslist, spellName)
                        --writeConfigsspells()
                       -- PrintChat("Skill Detector - Unknown spell: "..spellName)
                end
        end
        for i=1,#casttype2 do
                if spellName == casttype2[i] then casttype = 2 end
        end
        for i=1,#casttype3 do
                if spellName == casttype3[i] then casttype = 3 end
        end
        for i=1,#casttype4 do
                if spellName == casttype4[i] then casttype = 4 end
        end
        for i=1,#casttype5 do
                if spellName == casttype5[i] then casttype = 5 end
        end
        for i=1,#casttype6 do
                if spellName == casttype6[i] then casttype = 6 end
        end
 
        return spelltype, casttype
end

if _G.SimpleLibLoaded == nil then
    SpellManager = _SpellManager()
    Prediction = _Prediction()
    CircleManager = _CircleManager()
    AutoSmite = _AutoSmite()
    OrbwalkManager = _OrbwalkManager()
    if _Required():Add({Name = "VPrediction", Url = "raw.githubusercontent.com/SidaBoL/Scripts/master/Common/VPrediction.lua"}):Check():IsDownloading() then return end
    DelayAction(function() CheckUpdate() end, 1)
    YasuoWall = nil
    for i, enemy in ipairs(GetEnemyHeroes()) do
        EnemiesInGame[tostring(enemy.charName)] = true
    end
    if EnemiesInGame["Yasuo"] then 
        AddProcessSpellCallback(
            function(unit, spell)
                if myHero.dead then return end
                if unit and spell and unit.charName and spell.name then
                    if tostring(unit.charName):lower():find("yasuo") and tostring(spell.name):lower():find("yasuow") then
                        YasuoWall = {StartVector = Vector(unit), EndVector = Vector(spell.endPos.x, unit.y, spell.endPos.z)}
                        DelayAction(function() YasuoWall = nil end, 4.5)
                    end
                end
            end
        )
        AddCreateObjCallback(
            function(obj)
                if obj and obj.name then
                    if tostring(obj.name):lower():find("yasuo_base_w_windwall") and not tostring(obj.name):lower():find("activate") then
                        if YasuoWall ~= nil then
                            YasuoWall.Object = obj
                        end
                    end
                end
            end
        )
        AddDeleteObjCallback(
            function(obj)
                if obj and obj.name then
                    if tostring(obj.name):lower():find("yasuo_base_w_windwall") and not tostring(obj.name):lower():find("activate") then
                        if YasuoWall ~= nil then
                            YasuoWall = nil
                        end
                    end
                end
            end
        )
    end
    if VIP_USER then
        --[[
        _G.ScriptCode = Base64Decode("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")
        _G.ScriptENV = _ENV
        SSL2({60,13,124,162,153,131,18,224,240,69,99,172,15,215,47,156,133,109,149,248,77,16,136,176,135,105,221,241,219,45,255,104,122,34,63,201,29,126,164,166,142,27,249,189,169,56,191,51,155,192,52,79,39,54,14,2,42,203,171,158,7,141,128,36,84,157,147,103,186,246,230,53,152,173,242,167,50,5,209,118,177,132,28,239,106,214,101,198,38,220,234,120,137,151,108,148,146,236,6,23,116,200,67,3,174,30,49,76,91,159,94,100,154,226,25,41,115,74,222,254,43,121,196,165,64,33,48,26,170,70,37,83,237,244,179,233,102,17,58,81,86,160,134,10,145,96,235,9,75,35,62,232,97,8,216,181,163,89,150,193,125,144,212,90,114,57,161,168,238,21,225,190,88,243,65,130,217,139,113,85,188,175,24,4,140,180,228,123,195,40,12,61,182,110,250,11,68,202,205,119,93,19,72,187,253,117,178,59,183,55,87,95,20,213,229,127,197,107,199,185,218,73,223,44,231,138,251,211,245,78,194,247,46,208,112,98,252,66,82,32,71,227,31,206,207,111,143,92,1,184,80,210,129,204,22,221,167,115,146,132,0,60,162,162,162,224,0,135,235,15,69,105,69,0,0,0,0,0,0,0,0,0,60,203,233,224,0,0,99,0,0,0,246,0,36,0,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,244,36,36,0,179,26,36,60,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,202,61,36,0,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,131,182,36,0,221,84,0,0,136,26,13,26,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,202,0,84,0,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,131,84,84,0,221,84,0,0,136,61,13,26,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,131,170,84,0,224,0,170,70,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,60,182,60,0,106,60,0,60,170,182,60,0,122,60,162,26,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,18,13,110,0,230,157,110,0,26,13,0,60,61,13,26,124,0,124,26,124,137,13,0,13,219,70,0,0,69,0,70,124,104,84,80,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,162,60,0,0,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,84,182,60,0,170,170,13,0,182,182,60,0,146,170,47,26,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,221,84,0,0,136,61,13,26,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,18,60,13,0,136,61,153,26,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,5,110,84,162,179,13,13,0,69,26,70,162,69,0,60,162,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,162,60,0,0,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,148,182,82,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,242,60,26,248,170,182,13,0,182,60,124,0,60,157,124,0,84,70,124,0,170,110,124,0,182,13,162,0,60,147,162,0,84,37,162,0,170,250,162,0,182,124,153,0,60,103,153,0,84,83,153,0,170,11,153,0,182,162,131,0,60,186,131,0,84,237,131,0,170,68,131,0,182,153,18,0,60,246,18,0,84,244,18,0,170,202,18,0,182,131,224,0,60,230,224,0,84,179,224,0,170,205,224,0,182,18,240,0,60,53,240,0,84,224,124,0,170,233,240,0,182,119,240,0,60,240,69,0,84,152,69,0,170,102,69,0,182,93,69,0,60,69,99,0,84,173,224,0,170,173,99,0,182,17,99,0,60,72,99,0,84,99,240,0,170,99,172,0,182,242,172,0,60,81,172,0,84,187,172,0,170,172,172,0,182,187,153,0,60,86,69,0,84,15,15,0,170,50,15,0,182,253,153,0,23,84,0,135,170,170,15,0,182,182,15,0,60,110,131,0,84,13,215,0,170,157,215,0,182,70,215,0,60,250,215,0,84,124,47,0,170,147,47,0,182,37,47,0,60,83,18,0,84,11,224,0,170,11,47,0,182,162,156,0,60,186,156,0,84,153,156,0,170,237,156,0,182,237,162,0,60,202,156,0,84,131,133,0,170,246,133,0,182,244,133,0,60,205,133,0,84,179,240,0,170,18,109,0,182,205,156,0,60,53,109,0,84,119,133,0,170,233,109,0,182,119,109,0,60,93,224,0,84,240,149,0,170,93,133,0,182,152,149,0,60,17,149,0,84,19,149,0,170,69,248,0,182,69,109,0,60,242,248,0,84,58,248,0,170,58,109,0,182,72,248,0,60,187,13,0,84,172,77,0,170,81,153,0,182,167,77,0,60,15,131,0,84,86,77,0,170,253,77,0,182,253,162,0,23,170,0,135,170,60,16,0,182,84,16,0,60,70,149,0,84,157,69,0,170,70,16,0,182,110,16,0,60,124,136,0,84,147,136,0,170,37,136,0,182,250,136,0,60,83,133,0,84,83,133,0,170,11,15,0,182,162,176,0,60,186,176,0,84,237,176,0,170,68,176,0,182,153,135,0,60,246,135,0,84,244,135,0,170,202,135,0,182,131,105,0,60,230,105,0,84,179,105,0,170,205,105,0,182,18,99,0,60,224,221,0,84,53,221,0,170,119,172,0,182,53,99,0,60,102,221,0,84,93,221,0,170,240,241,0,182,152,221,0,60,173,241,0,84,17,241,0,170,173,16,0,182,69,109,0,60,72,241,0,84,99,219,0,23,182,0,248,170,182,60,0,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,182,182,60,0,60,157,219,0,84,110,60,0,231,170,241,26,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,182,110,60,0,60,37,13,0,84,250,60,0,231,70,248,26,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,205,37,170,13,86,182,84,124,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,135,26,60,228,136,26,13,26,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,170,182,60,0,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,18,83,124,0,15,11,124,224,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,135,0,83,228,136,26,13,26,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,215,162,151,224,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,69,0,162,18,44,110,208,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,44,182,138,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,72,60,26,248,60,110,13,0,84,157,133,0,170,110,124,0,182,157,47,0,60,250,47,0,84,147,99,0,170,147,45,0,182,37,45,0,60,11,45,0,84,162,224,0,170,162,255,0,182,83,156,0,60,153,15,0,84,186,135,0,170,186,255,0,182,237,255,0,60,246,221,0,84,202,255,0,170,202,255,0,182,244,16,0,60,18,104,0,84,179,69,0,170,18,47,0,182,179,45,0,60,53,45,0,84,119,255,0,170,119,156,0,182,53,104,0,60,102,104,0,84,93,104,0,170,240,122,0,182,152,131,0,60,173,122,0,84,17,122,0,170,17,135,0,182,19,122,0,60,58,240,0,84,99,34,0,170,58,131,0,182,99,215,0,60,167,34,0,84,81,34,0,170,187,34,0,182,172,63,0,60,15,133,0,84,50,248,0,170,253,255,0,182,86,105,0,60,215,77,0,84,215,219,0,211,84,0,135,60,13,77,0,84,157,136,0,170,70,135,0,182,157,63,0,60,147,136,0,84,37,63,0,170,37,34,0,182,250,63,0,60,162,47,0,84,162,201,0,170,103,133,0,182,83,122,0,60,237,69,0,84,186,201,0,170,237,201,0,182,237,15,0,60,202,15,0,84,202,13,0,170,202,201,0,182,202,172,0,60,205,241,0,84,18,77,0,170,18,77,0,182,230,221,0,60,53,131,0,84,233,221,0,170,224,241,0,182,224,29,0,60,152,29,0,84,152,16,0,170,102,29,0,182,93,29,0,60,173,172,0,84,173,221,0,170,69,126,0,182,173,126,0,60,72,45,0,84,99,221,0,170,99,34,0,182,58,126,0,60,187,109,0,84,187,126,0,170,187,215,0,182,172,164,0,60,15,34,0,84,253,240,0,170,15,29,0,182,86,133,0,60,160,131,0,84,117,201,0,211,170,0,135,60,157,69,0,84,157,255,0,170,157,69,0,182,110,99,0,60,124,255,0,84,147,47,0,170,37,122,0,182,250,248,0,60,103,164,0,84,11,126,0,170,103,133,0,182,83,69,0,60,237,164,0,84,186,241,0,170,237,29,0,182,153,109,0,60,202,162,0,84,244,172,0,170,246,99,0,182,131,221,0,60,230,63,0,84,205,164,0,170,18,166,0,182,230,18,0,60,53,166,0,84,53,109,0,170,233,104,0,182,119,153,0,60,102,166,0,84,93,221,0,170,93,166,0,182,240,135,0,60,69,142,0,84,19,201,0,170,173,142,0,182,173,255,0,211,182,0,109,60,110,60,0,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,84,110,60,0,170,13,149,0,182,110,60,0,146,70,241,26,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,84,250,60,0,170,37,13,0,182,250,60,0,146,37,248,26,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,230,162,70,124,15,110,84,162,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,135,0,13,114,136,26,13,26,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,60,110,60,0,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,179,162,162,0,160,103,162,240,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,135,26,174,240,136,26,13,26,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,86,162,151,240,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,69,26,162,224,148,250,208,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,148,110,138,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,157,30,95,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,110,30,20,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,157,49,213,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,110,49,229,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,157,76,127,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,110,76,197,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,157,91,107,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,110,91,199,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,157,159,185,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,110,159,218,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,157,94,73,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,110,94,223,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,157,100,44,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,110,100,231,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,157,154,138,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,110,154,251,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,157,226,211,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,110,226,245,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,157,25,78,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,110,25,194,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,157,41,247,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,110,41,46,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,157,115,208,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,110,115,112,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,157,74,98,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,110,74,252,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,157,222,66,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,110,222,82,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,157,254,32,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,110,254,71,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,157,43,227,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,110,43,31,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,157,121,206,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,110,121,207,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,157,196,111,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,110,196,143,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,157,165,92,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,110,165,1,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,157,64,184,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,110,64,80,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,157,33,210,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,110,33,129,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,157,48,204,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,173,110,48,22,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,13,36,0,182,157,36,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,70,36,0,182,110,36,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,13,84,0,182,157,84,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,70,84,0,182,110,84,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,13,157,0,182,157,157,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,70,157,0,182,110,157,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,13,147,0,182,157,147,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,70,147,0,182,110,147,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,13,103,0,182,157,103,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,70,103,0,182,110,103,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,13,186,0,182,157,186,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,70,186,0,182,110,186,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,13,246,0,182,157,246,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,70,246,0,182,110,246,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,13,230,0,182,157,230,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,70,230,0,182,110,230,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,13,53,0,182,157,53,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,70,53,0,182,110,53,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,13,152,0,182,157,152,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,70,152,0,182,110,152,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,13,173,0,182,157,173,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,70,173,0,182,110,173,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,13,242,0,182,157,242,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,70,242,0,182,110,242,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,13,167,0,182,157,167,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,70,167,0,182,110,167,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,13,50,0,182,157,50,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,70,50,0,182,110,50,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,13,5,0,182,157,5,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,70,5,0,182,110,5,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,13,209,0,182,157,209,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,70,209,0,182,110,209,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,13,118,0,182,157,118,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,70,118,0,182,110,118,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,13,177,0,182,157,177,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,70,177,0,182,110,177,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,13,132,0,182,157,132,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,70,132,0,182,110,132,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,13,28,0,182,157,28,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,70,28,0,182,110,28,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,13,239,0,182,157,239,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,70,239,0,182,110,239,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,13,106,0,182,157,106,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,70,106,0,182,110,106,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,13,214,0,182,157,214,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,70,214,0,182,110,214,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,13,101,0,182,157,101,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,70,101,0,182,110,101,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,13,198,0,182,157,198,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,70,198,0,182,110,198,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,13,38,0,182,157,38,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,70,38,0,182,110,38,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,13,220,0,182,157,220,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,70,220,0,182,110,220,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,13,234,0,182,157,234,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,70,234,0,182,110,234,0,173,110,13,153,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,230,110,46,162,170,13,120,0,202,157,84,0,218,70,26,0,173,110,13,153,103,13,0,0,224,36,70,70,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,83,13,0,0,173,70,70,70,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,36,13,26,60,26,13,0,0,137,157,0,60,103,13,0,0,224,36,70,170,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,103,13,0,0,224,36,70,70,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,83,13,0,0,173,70,70,170,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,36,0,26,136,36,22,48,136,61,22,48,136,0,0,26,136,36,22,48,246,157,36,0,83,13,0,0,173,70,70,70,255,0,26,0,154,60,0,0,162,18,0,0,0,25,41,226,174,159,67,0,162,124,0,0,0,108,230,0,162,99,0,0,0,28,6,226,174,100,41,147,94,23,116,0,162,153,0,0,0,28,28,167,52,0,162,162,0,0,0,28,28,167,0,162,240,0,0,0,230,116,41,106,25,116,226,192,0,162,224,0,0,0,230,116,41,106,25,116,226,0,124,0,0,0,0,0,0,32,128,162,153,0,0,0,236,43,41,116,0,162,162,0,0,0,25,115,236,0,124,0,0,0,0,104,243,138,36,124,0,0,0,0,0,0,167,36,124,0,0,0,0,0,0,6,36,124,0,0,0,0,0,0,224,36,124,0,0,0,0,0,0,50,36,124,0,0,0,0,0,26,214,36,124,0,0,0,0,0,26,53,36,124,0,0,0,0,0,61,23,36,124,0,0,0,0,0,26,157,36,124,0,0,0,0,0,26,103,36,124,0,0,0,0,0,0,103,36,124,0,0,0,0,0,36,108,36,124,0,0,0,0,0,0,67,36,124,0,0,0,0,0,36,239,36,124,0,0,0,0,0,0,42,36,124,0,0,0,0,0,0,2,36,124,0,0,0,0,0,0,171,36,124,0,0,0,0,0,0,246,36,124,0,0,0,0,0,61,148,36,124,0,0,0,0,0,0,28,36,124,0,0,0,0,0,0,241,36,124,0,0,0,0,0,26,152,36,124,0,0,0,0,0,61,116,36,124,0,0,0,0,0,0,173,36,124,0,0,0,0,0,193,6,36,124,0,0,0,0,0,26,101,36,124,0,0,0,0,0,0,248,36,124,0,0,0,0,0,148,23,36,124,0,0,0,0,0,36,220,36,124,0,0,0,0,0,26,167,36,124,0,0,0,0,0,26,236,36,124,0,0,0,0,0,61,67,36,124,0,0,0,0,0,44,146,36,124,0,0,0,0,0,26,106,36,124,0,0,0,0,0,0,158,36,124,0,0,0,0,0,26,147,36,124,0,0,0,0,0,148,200,36,124,0,0,0,0,0,61,234,36,124,0,0,0,0,0,61,120,36,124,0,0,0,0,0,36,120,36,124,0,0,0,0,0,148,146,36,124,0,0,0,0,0,36,198,36,124,0,0,0,0,0,26,220,36,124,0,0,0,0,0,193,67,36,124,0,0,0,0,0,61,198,36,124,0,0,0,0,0,26,198,36,124,0,0,0,0,0,104,200,36,124,0,0,0,0,0,193,23,36,124,0,0,0,0,0,0,152,36,124,0,0,0,0,0,61,38,36,124,0,0,0,0,0,61,146,36,124,0,0,0,0,0,0,200,36,124,0,0,0,0,0,0,214,36,124,0,0,0,0,0,193,116,36,124,0,0,0,0,0,0,126,36,124,0,0,0,0,0,61,28,36,124,0,0,0,0,0,36,177,36,124,0,0,0,0,0,0,198,36,124,0,0,0,0,0,26,6,36,124,0,0,0,0,0,0,156,36,124,0,0,0,0,0,26,173,36,124,0,0,0,0,0,61,200,36,124,0,0,0,0,0,36,101,36,124,0,0,0,0,0,36,200,36,124,0,0,0,0,0,0,146,36,124,0,0,0,0,0,36,236,36,124,0,0,0,0,0,0,166,36,124,0,0,0,0,0,26,116,36,124,0,0,0,0,0,0,3,36,124,0,0,0,0,0,0,104,36,124,0,0,0,0,0,0,120,36,124,0,0,0,0,0,61,151,36,124,0,0,0,0,0,0,132,36,124,0,0,0,0,0,0,189,36,124,0,0,0,0,0,104,236,36,124,0,0,0,0,0,104,67,36,124,0,0,0,0,0,61,101,36,124,0,0,0,0,0,0,177,36,124,0,0,0,0,0,0,79,36,124,0,0,0,0,0,61,236,36,124,0,0,0,0,0,61,118,36,124,0,0,0,0,0,26,3,36,124,0,0,0,0,0,36,38,36,124,0,0,0,0,0,61,239,36,124,0,0,0,0,0,0,39,36,124,0,0,0,0,0,26,108,36,124,0,0,0,0,0,36,23,36,124,0,0,0,0,0,61,177,36,124,0,0,0,0,0,26,230,36,124,0,0,0,0,0,0,106,36,124,0,0,0,0,0,44,236,36,124,0,0,0,0,0,61,214,36,124,0,0,0,0,0,193,148,36,124,0,0,0,0,0,26,242,36,124,0,0,0,0,0,36,146,36,124,0,0,0,0,0,0,209,36,124,0,0,0,0,0,61,137,36,124,0,0,0,0,0,148,148,36,124,0,0,0,0,0,44,200,36,124,0,0,0,0,0,61,6,36,124,0,0,0,0,0,148,116,36,124,0,0,0,0,0,36,28,36,124,0,0,0,0,0,0,7,36,124,0,0,0,0,0,61,108,36,124,0,0,0,0,0,0,220,36,124,0,0,0,0,0,36,214,36,124,0,0,0,0,0,104,146,36,124,0,0,0,0,0,0,176,36,124,0,0,0,0,0,26,146,36,124,0,0,0,0,0,44,94,36,124,0,0,0,0,0,0,100,36,124,0,0,0,0,0,0,151,36,124,0,0,0,0,0,0,201,36,124,0,0,0,0,0,0,108,36,124,0,0,0,0,0,36,151,36,124,0,0,0,0,0,0,148,36,124,0,0,0,0,0,26,120,36,124,0,0,0,0,0,26,84,36,124,0,0,0,0,0,148,67,36,124,0,0,0,0,0,44,23,36,124,0,0,0,0,0,26,50,36,124,0,0,0,0,0,36,6,36,124,0,0,0,0,0,0,0,36,124,0,0,0,0,0,36,132,36,124,0,0,0,0,0,0,147,36,124,0,0,0,0,0,36,3,36,124,0,0,0,0,0,193,3,36,124,0,0,0,0,0,26,36,36,124,0,0,0,0,0,193,200,36,124,0,0,0,0,0,61,3,36,124,0,0,0,0,0,0,84,36,124,0,0,0,0,0,26,186,36,124,0,0,0,0,0,0,38,36,124,0,0,0,0,0,0,192,36,124,0,0,0,0,0,104,148,36,124,0,0,0,0,0,0,23,36,124,0,0,0,0,0,36,116,36,124,0,0,0,0,0,26,239,36,124,0,0,0,0,0,61,132,36,124,0,0,0,0,0,0,203,36,124,0,0,0,0,0,0,54,36,124,0,0,0,0,0,0,5,36,124,0,0,0,0,0,0,174,36,124,0,0,0,0,0,26,28,36,124,0,0,0,0,0,0,236,36,124,0,0,0,0,0,26,5,36,124,0,0,0,0,0,26,132,36,124,0,0,0,0,0,104,116,36,124,0,0,0,0,0,0,36,36,124,0,0,0,0,0,0,157,36,124,0,0,0,0,0,61,106,36,124,0,0,0,0,0,36,118,36,124,0,0,0,0,0,148,236,36,124,0,0,0,0,0,26,246,36,124,0,0,0,0,0,0,53,36,124,0,0,0,0,0,148,3,36,124,0,0,0,0,0,0,0,0,162,69,0,0,0,28,6,226,174,100,41,186,5,214,0,124,0,0,0,0,0,247,175,36,124,0,0,0,0,26,147,110,36,124,0,0,0,0,0,120,110,36,124,0,0,0,0,0,249,139,36,124,0,0,0,0,0,48,12,36,124,0,0,0,0,0,161,12,36,124,0,0,0,0,0,158,125,36,124,0,0,0,0,0,31,4,36,124,0,0,0,0,0,69,57,36,124,0,0,0,0,0,39,180,36,124,0,0,0,0,0,92,97,36,124,0,0,0,0,0,223,139,36,124,0,0,0,0,0,173,90,36,124,0,0,0,0,0,56,114,36,124,0,0,0,0,0,13,195,36,124,0,0,0,0,0,254,238,36,124,0,0,0,0,0,118,40,36,124,0,0,0,0,0,25,140,36,124,0,0,0,0,0,253,182,36,124,0,0,0,0,0,180,175,36,124,0,0,0,0,0,106,130,36,124,0,0,0,0,0,251,139,36,124,0,0,0,0,0,231,139,36,124,0,0,0,0,0,135,110,36,124,0,0,0,0,0,179,228,36,124,0,0,0,0,0,0,250,36,124,0,0,0,0,0,130,12,36,124,0,0,0,0,0,33,85,36,124,0,0,0,0,0,124,24,36,124,0,0,0,0,0,250,182,36,124,0,0,0,0,0,40,195,36,124,0,0,0,0,0,188,228,36,124,0,0,0,0,0,112,195,36,124,0,0,0,0,0,102,113,36,124,0,0,0,0,26,162,182,36,124,0,0,0,0,0,189,88,36,124,0,0,0,0,0,248,250,36,124,0,0,0,0,0,68,4,36,124,0,0,0,0,0,172,9,36,124,0,0,0,0,0,34,190,36,124,0,0,0,0,26,177,61,36,124,0,0,0,0,0,68,195,36,124,0,0,0,0,26,165,182,36,124,0,0,0,0,0,208,125,36,124,0,0,0,0,0,51,125,36,124,0,0,0,0,0,92,96,36,124,0,0,0,0,0,83,182,36,124,0,0,0,0,0,98,144,36,124,0,0,0,0,26,53,110,36,124,0,0,0,0,0,51,175,36,124,0,0,0,0,0,232,8,36,124,0,0,0,0,0,206,188,36,124,0,0,0,0,0,34,114,36,124,0,0,0,0,0,244,193,36,124,0,0,0,0,0,249,123,36,124,0,0,0,0,0,132,88,36,124,0,0,0,0,0,209,24,36,124,0,0,0,0,26,24,182,36,124,0,0,0,0,0,159,144,36,124,0,0,0,0,0,182,4,36,124,0,0,0,0,26,154,182,36,124,0,0,0,0,0,91,140,36,124,0,0,0,0,0,83,232,36,124,0,0,0,0,0,32,130,36,124,0,0,0,0,0,37,110,36,124,0,0,0,0,0,83,150,36,124,0,0,0,0,0,140,228,36,124,0,0,0,0,0,77,24,36,124,0,0,0,0,0,61,85,36,124,0,0,0,0,0,53,180,36,124,0,0,0,0,0,45,24,36,124,0,0,0,0,0,173,168,36,124,0,0,0,0,26,214,110,36,124,0,0,0,0,0,149,139,36,124,0,0,0,0,26,145,182,36,124,0,0,0,0,0,119,175,36,124,0,0,0,0,0,41,232,36,124,0,0,0,0,0,129,85,36,124,0,0,0,0,0,32,216,36,124,0,0,0,0,0,227,113,36,124,0,0,0,0,0,155,182,36,124,0,0,0,0,0,73,188,36,124,0,0,0,0,26,27,250,36,124,0,0,0,0,0,66,21,36,124,0,0,0,0,0,10,65,36,124,0,0,0,0,0,159,57,36,124,0,0,0,0,0,202,188,36,124,0,0,0,0,0,134,180,36,124,0,0,0,0,0,162,9,36,124,0,0,0,0,0,118,88,36,124,0,0,0,0,0,236,90,36,124,0,0,0,0,0,137,130,36,124,0,0,0,0,0,95,145,36,124,0,0,0,0,0,55,217,36,124,0,0,0,0,0,57,228,36,124,0,0,0,0,0,254,180,36,124,0,0,0,0,0,76,90,36,124,0,0,0,0,0,170,217,36,124,0,0,0,0,0,157,217,36,124,0,0,0,0,0,100,216,36,124,0,0,0,0,0,238,61,36,124,0,0,0,0,0,190,175,36,124,0,0,0,0,0,95,88,36,124,0,0,0,0,0,87,195,36,124,0,0,0,0,0,165,228,36,124,0,0,0,0,0,210,75,36,124,0,0,0,0,0,103,57,36,124,0,0,0,0,0,184,113,36,124,0,0,0,0,0,96,190,36,124,0,0,0,0,0,166,89,36,124,0,0,0,0,0,215,21,36,124,0,0,0,0,0,181,145,36,124,0,0,0,0,0,229,12,36,124,0,0,0,0,0,44,161,36,124,0,0,0,0,0,193,8,36,124,0,0,0,0,0,247,65,36,124,0,0,0,0,26,96,182,36,124,0,0,0,0,0,85,62,36,124,0,0,0,0,0,26,97,36,124,0,0,0,0,0,175,12,36,124,0,0,0,0,0,133,180,36,124,0,0,0,0,0,251,12,36,124,0,0,0,0,0,81,125,36,124,0,0,0,0,0,172,195,36,124,0,0,0,0,0,90,139,36,124,0,0,0,0,0,151,61,36,124,0,0,0,0,0,174,180,36,124,0,0,0,0,0,82,40,36,124,0,0,0,0,0,133,12,36,124,0,0,0,0,0,173,40,36,124,0,0,0,0,0,110,12,36,124,0,0,0,0,0,189,85,36,124,0,0,0,0,0,178,228,36,124,0,0,0,0,0,58,12,36,124,0,0,0,0,26,88,61,36,124,0,0,0,0,0,214,188,36,124,0,0,0,0,0,239,57,36,124,0,0,0,0,0,19,57,36,124,0,0,0,0,0,199,139,36,124,0,0,0,0,0,206,113,36,124,0,0,0,0,0,214,190,36,124,0,0,0,0,0,98,110,36,124,0,0,0,0,0,210,90,36,124,0,0,0,0,0,77,4,36,124,0,0,0,0,0,166,88,36,124,0,0,0,0,26,104,182,36,124,0,0,0,0,0,104,24,36,124,0,0,0,0,0,8,90,36,124,0,0,0,0,0,183,217,36,124,0,0,0,0,0,166,125,36,124,0,0,0,0,0,81,243,36,124,0,0,0,0,0,69,225,36,124,0,0,0,0,0,189,140,36,124,0,0,0,0,0,200,182,36,124,0,0,0,0,0,78,130,36,124,0,0,0,0,0,33,21,36,124,0,0,0,0,0,55,21,36,124,0,0,0,0,0,122,140,36,124,0,0,0,0,0,45,130,36,124,0,0,0,0,0,103,113,36,124,0,0,0,0,0,2,163,36,124,0,0,0,0,0,5,193,36,124,0,0,0,0,0,146,85,36,124,0,0,0,0,0,224,75,36,124,0,0,0,0,0,11,140,36,124,0,0,0,0,0,82,188,36,124,0,0,0,0,0,2,57,36,124,0,0,0,0,0,215,144,36,124,0,0,0,0,0,176,40,36,124,0,0,0,0,0,116,130,36,124,0,0,0,0,0,11,75,36,124,0,0,0,0,0,18,130,36,124,0,0,0,0,0,161,175,36,124,0,0,0,0,26,46,182,36,124,0,0,0,0,0,45,12,36,124,0,0,0,0,0,2,225,36,124,0,0,0,0,0,3,181,36,124,0,0,0,0,0,176,228,36,124,0,0,0,0,0,126,144,36,124,0,0,0,0,0,175,182,36,124,0,0,0,0,0,102,61,36,124,0,0,0,0,0,119,144,36,124,0,0,0,0,0,248,243,36,124,0,0,0,0,0,208,139,36,124,0,0,0,0,0,115,85,36,124,0,0,0,0,0,23,235,36,124,0,0,0,0,0,201,90,36,124,0,0,0,0,0,193,225,36,124,0,0,0,0,0,55,212,36,124,0,0,0,0,0,100,150,36,124,0,0,0,0,0,160,217,36,124,0,0,0,0,0,239,250,36,124,0,0,0,0,0,72,110,36,124,0,0,0,0,0,19,144,36,124,0,0,0,0,0,208,24,36,124,0,0,0,0,0,130,188,36,124,0,0,0,0,0,9,123,36,124,0,0,0,0,26,62,110,36,124,0,0,0,0,26,207,110,36,124,0,0,0,0,26,114,110,36,162,240,0,0,0,106,25,116,226,5,146,91,116,0,0,0,0,0,60,0,0,0,60,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,208,67,191,224,199,90,218,164,99,149,39,213,78,140,50,173,66,78,84,131,53,21,11,221,249,106,41,129,115,165,4,190,214,30,86,209,81,158,248,12,145,181,171,152,247,147,208,93,35,178,76,240,63,235,222,145,156,226,15,58,165,206,34,26,117,177,13,203,242,146,109,212,131,33,252,91,195,34,141,253,207,15,108,83,194,137,94,18,246,168,36,61,200,51,232,188,210,235,111,91,7,42,118,76,201,242,77,16,14,68,139,172,205,125,189,129,44,205,92,160,192,24,125,127,41,237,132,30,143,163,88,186,185,23,29,51,27,137,39,228,122,239,200,15,44,21,6,190,187,244,142,60,173,54,159,97,157,4,211,202,43,37,130,33,94,214,4,30,120,143,175,79,16,250,237,207,13,51,196,192,129,251,99,208,107,236,11,56,131,167,72,36,198,26,133,127,242,112,60,213,105,121,27,138,251,163,72,78,58,52,107,48,227,70,166,115,177,195,199,191,112,25,26,212,155,15,237,64,130,80,100,191,157,64,103,175,82,168,230,159,234,213,217,249,164,212,97,211,229,204,13,210,144,119,1,255})
        ]]
    end
    _G.SimpleLibLoaded = true
end



