---------------------------------------------------------------------------------

local Version = 0.1

---------------------------------------------------------------------------------

function ScriptMsg(msg)
  print("<font color=\"#B1B8E3\"><b>[S1Stream Overlay]</b></font>  <font color=\"#FFB3B3\">".. msg .."</font>")
end

function ErrorMsg(msg)
  print("<font color=\"#448DA6\"><b>[S1Stream Overlay]</b></font>  <font color=\"#F55F5F\">".. msg .."</font>")
end

---------------------------------------------------------------------------------

---------------------------------------------------------------------------------

--[[function InitSprites()

  if not DirectoryExist(SPRITE_PATH.."S1StreamOverlay") then
    
    CreateDirectory(SPRITE_PATH.."S1StreamOverlay//")
    
    ScriptMsg("Downloading Stream Overlays...")

      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/K61920x1080.png", SPRITE_PATH.."S1StreamOverlay/K61920x1080.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/K61600x900.png", SPRITE_PATH.."S1StreamOverlay/K61600x900.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/K61360x720.png", SPRITE_PATH.."S1StreamOverlay/K61360x720.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/K61280x720.png", SPRITE_PATH.."S1StreamOverlay/K61280x720.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/LISS1920x1080.png", SPRITE_PATH.."S1StreamOverlay/LISS1920x1080.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/LISS1600x900.png", SPRITE_PATH.."S1StreamOverlay/LISS1600x900.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/LISS1360x720.png", SPRITE_PATH.."S1StreamOverlay/LISS1360x720.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/LISS1280x720.png", SPRITE_PATH.."S1StreamOverlay/LISS1280x720.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/PPGRAVES1920x1080.png", SPRITE_PATH.."S1StreamOverlay/PPGRAVES1920x1080.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/PPGRAVES1600x900.png", SPRITE_PATH.."S1StreamOverlay/PPGRAVES1600x900.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/PPGRAVES1360x720.png", SPRITE_PATH.."S1StreamOverlay/PPGRAVES1360x720.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/PPGRAVES1280x720.png", SPRITE_PATH.."S1StreamOverlay/PPGRAVES1280x720.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/PRFIORA1920x1080.png", SPRITE_PATH.."S1StreamOverlay/PRFIORA1920x1080.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/PRFIORA1600x900.png", SPRITE_PATH.."S1StreamOverlay/PRFIORA1600x900.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/PRFIORA1360x720.png", SPRITE_PATH.."S1StreamOverlay/PRFIORA1360x720.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/PRFIORA1280x720.png", SPRITE_PATH.."S1StreamOverlay/PRFIORA1280x720.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/PRZED1920x1080.png", SPRITE_PATH.."S1StreamOverlay/PRZED1920x1080.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/PRZED1600x900.png", SPRITE_PATH.."S1StreamOverlay/PRZED1600x900.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/PRZED1360x720.png", SPRITE_PATH.."S1StreamOverlay/PRZED1360x720.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/PRZED1280x720.png", SPRITE_PATH.."S1StreamOverlay/PRZED1280x720.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/PSAHRI1920x1080.png", SPRITE_PATH.."S1StreamOverlay/PSAHRI1920x1080.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/PSAHRI1600x900.png", SPRITE_PATH.."S1StreamOverlay/PSAHRI1600x900.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/PSAHRI1360x720.png", SPRITE_PATH.."S1StreamOverlay/PSAHRI1360x720.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/PSAHRI1280x720.png", SPRITE_PATH.."S1StreamOverlay/PSAHRI1280x720.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/RDWU1920x1080.png", SPRITE_PATH.."S1StreamOverlay/RDWU1920x1080.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/RDWU1600x900.png", SPRITE_PATH.."S1StreamOverlay/RDWU1600x900.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/RDWU1360x720.png", SPRITE_PATH.."S1StreamOverlay/RDWU1360x720.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/RDWU1280x720.png", SPRITE_PATH.."S1StreamOverlay/RDWU1280x720.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/S1PURPLE1920x1080.png", SPRITE_PATH.."S1StreamOverlay/S1PURPLE1920x1080.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/S1PURPLE1600x900.png", SPRITE_PATH.."S1StreamOverlay/S1PURPLE1600x900.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/S1PURPLE1360x720.png", SPRITE_PATH.."S1StreamOverlay/S1PURPLE1360x720.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/S1PURPLE1280x720.png", SPRITE_PATH.."S1StreamOverlay/S1PURPLE1280x720.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/S1RED1920x1080.png", SPRITE_PATH.."S1StreamOverlay/S1RED1920x1080.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/S1RED1600x900.png", SPRITE_PATH.."S1StreamOverlay/S1RED1600x900.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/S1RED1360x720.png", SPRITE_PATH.."S1StreamOverlay/S1RED1360x720.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/S1RED1280x720.png", SPRITE_PATH.."S1StreamOverlay/S1RED1280x720.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/SBRAND1920x1080.png", SPRITE_PATH.."S1StreamOverlay/SBRAND1920x1080.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/SBRAND1600x900.png", SPRITE_PATH.."S1StreamOverlay/SBRAND1600x900.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/SBRAND1360x720.png", SPRITE_PATH.."S1StreamOverlay/SBRAND1360x720.png",function()end)
      DownloadFile("http://s1mplescripts.de/Izsha/BoL/S1StreamOverlay/Sprites/SBRAND1280x720.png", SPRITE_PATH.."S1StreamOverlay/SBRAND1280x720.png",function()end)

    ScriptMsg("Stream Overlays have been downloaded, please press 2x F9.")
    end
end]]

---------------------------------------------------------------------------------

function OnLoad()

  --InitSprites()

  DelayAction(function() ScriptMsg("S1 Stream Overlay has been loaded. Please remember that you are required to reload the script when you change the overlay. This is to save any FPS drops.") end, 3)
  DelayAction(function() ScriptMsg("Please change your Minimap size to 85 and HUD size to 25.") end, 4)

  Menu = scriptConfig("S1Stream Overlay", "S1")

    Menu:addSubMenu("S1: Overlay", "Overlay")
      Menu.Overlay:addParam("Type", "Type of Overlay", SCRIPT_PARAM_SLICE, 0,0,10,0)
      Menu.Overlay:addParam("TypeINFO", "Name of Overlay: ", SCRIPT_PARAM_INFO, "")
  
    Menu:addSubMenu("S1: Sizes", "Size")
      Menu.Size:addParam("Size", "Resolution", SCRIPT_PARAM_SLICE, 1,1,4,0)
      Menu.Size:addParam("SizeINFO", "Resolution Value: ", SCRIPT_PARAM_INFO, "")
  
  if Menu.Overlay.Type == 1 then
    Menu.Overlay.TypeINFO = "S1 Purple"
    if Menu.Size.Size == 1 then
      Menu.Size.SizeINFO = "1280x720"
      sprite = GetSprite("\\S1StreamOverlay\\S1PURPLE1280x720.png")
    elseif Menu.Size.Size == 2 then
      Menu.Size.SizeINFO = "1360x720"
      sprite = GetSprite("\\S1StreamOverlay\\S1PURPLE1360x720.png")
    elseif Menu.Size.Size == 3 then
      Menu.Size.SizeINFO = "1600x900"
      sprite = GetSprite("\\S1StreamOverlay\\S1PURPLE1600x900.png")
    elseif Menu.Size.Size == 4 then
      Menu.Size.SizeINFO = "1920x1080"
      sprite = GetSprite("\\S1StreamOverlay\\S1PURPLE1920x1080.png")
    else
      Menu.Size.SizeINFO = "N/A"
    end
  elseif Menu.Overlay.Type == 2 then
    Menu.Overlay.TypeINFO = "S1 Red"
    if Menu.Size.Size == 1 then
      Menu.Size.SizeINFO = "1280x720"
      sprite = GetSprite("\\S1StreamOverlay\\S1RED1280x720.png")
    elseif Menu.Size.Size == 2 then
      Menu.Size.SizeINFO = "1360x720"
      sprite = GetSprite("\\S1StreamOverlay\\S1RED1360x720.png")
    elseif Menu.Size.Size == 3 then
      Menu.Size.SizeINFO = "1600x900"
      sprite = GetSprite("\\S1StreamOverlay\\S1RED1600x900.png")
    elseif Menu.Size.Size == 4 then
      Menu.Size.SizeINFO = "1920x1080"
      sprite = GetSprite("\\S1StreamOverlay\\S1RED1920x1080.png")
    else
      Menu.Size.SizeINFO = "N/A"
    end
  elseif Menu.Overlay.Type == 3 then
    Menu.Overlay.TypeINFO = "Project: Zed"
    if Menu.Size.Size == 1 then
      Menu.Size.SizeINFO = "1280x720"
      sprite = GetSprite("\\S1StreamOverlay\\PRZED1280x720.png")
    elseif Menu.Size.Size == 2 then
      Menu.Size.SizeINFO = "1360x720"
      sprite = GetSprite("\\S1StreamOverlay\\PRZED1360x720.png")
    elseif Menu.Size.Size == 3 then
      Menu.Size.SizeINFO = "1600x900"
      sprite = GetSprite("\\S1StreamOverlay\\PRZED1600x900.png")
    elseif Menu.Size.Size == 4 then
      Menu.Size.SizeINFO = "1920x1080"
      sprite = GetSprite("\\S1StreamOverlay\\PRZED1920x1080.png")
    else
      Menu.Size.SizeINFO = "N/A"
    end
  elseif Menu.Overlay.Type == 4 then
    Menu.Overlay.TypeINFO = "Project: Fiora"
    if Menu.Size.Size == 1 then
      Menu.Size.SizeINFO = "1280x720"
      sprite = GetSprite("\\S1StreamOverlay\\PRFIORA1280x720.png")
    elseif Menu.Size.Size == 2 then
      Menu.Size.SizeINFO = "1360x720"
      sprite = GetSprite("\\S1StreamOverlay\\PRFIORA1360x720.png")
    elseif Menu.Size.Size == 3 then
      Menu.Size.SizeINFO = "1600x900"
      sprite = GetSprite("\\S1StreamOverlay\\PRFIORA1600x900.png")
    elseif Menu.Size.Size == 4 then
      Menu.Size.SizeINFO = "1920x1080"
      sprite = GetSprite("\\S1StreamOverlay\\PRFIORA1920x1080.png")
    else
      Menu.Size.SizeINFO = "N/A"
    end
  elseif Menu.Overlay.Type == 5 then
    Menu.Overlay.TypeINFO = "Lissandra"
    if Menu.Size.Size == 1 then
      Menu.Size.SizeINFO = "1280x720"
      sprite = GetSprite("\\S1StreamOverlay\\LISS1280x720.png")
    elseif Menu.Size.Size == 2 then
      Menu.Size.SizeINFO = "1360x720"
      sprite = GetSprite("\\S1StreamOverlay\\LISS1360x720.png")
    elseif Menu.Size.Size == 3 then
      Menu.Size.SizeINFO = "1600x900"
      sprite = GetSprite("\\S1StreamOverlay\\LISS1600x900.png")
    elseif Menu.Size.Size == 4 then
      Menu.Size.SizeINFO = "1920x1080"
      sprite = GetSprite("\\S1StreamOverlay\\LISS1920x1080.png")
    else
      Menu.Size.SizeINFO = "N/A"
    end
  elseif Menu.Overlay.Type == 6 then
    Menu.Overlay.TypeINFO = "Kha'Zix"
    if Menu.Size.Size == 1 then
      Menu.Size.SizeINFO = "1280x720"
      sprite = GetSprite("\\S1StreamOverlay\\K61280x720.png")
    elseif Menu.Size.Size == 2 then
      Menu.Size.SizeINFO = "1360x720"
      sprite = GetSprite("\\S1StreamOverlay\\K61360x720.png")
    elseif Menu.Size.Size == 3 then
      Menu.Size.SizeINFO = "1600x900"
      sprite = GetSprite("\\S1StreamOverlay\\K61600x900.png")
    elseif Menu.Size.Size == 4 then
      Menu.Size.SizeINFO = "1920x1080"
      sprite = GetSprite("\\S1StreamOverlay\\K61920x1080.png")
    else
      Menu.Size.SizeINFO = "N/A"
    end
  elseif Menu.Overlay.Type == 7 then
    Menu.Overlay.TypeINFO = "Pool Party Graves"
    if Menu.Size.Size == 1 then
      Menu.Size.SizeINFO = "1280x720"
      sprite = GetSprite("\\S1StreamOverlay\\PPGRAVES1280x720.png")
    elseif Menu.Size.Size == 2 then
      Menu.Size.SizeINFO = "1360x720"
      sprite = GetSprite("\\S1StreamOverlay\\PPGRAVES1360x720.png")
    elseif Menu.Size.Size == 3 then
      Menu.Size.SizeINFO = "1600x900"
      sprite = GetSprite("\\S1StreamOverlay\\PPGRAVES1600x900.png")
    elseif Menu.Size.Size == 4 then
      Menu.Size.SizeINFO = "1920x1080"
      sprite = GetSprite("\\S1StreamOverlay\\PPGRAVES1920x1080.png")
    else
      Menu.Size.SizeINFO = "N/A"
    end
  elseif Menu.Overlay.Type == 8 then
    Menu.Overlay.TypeINFO = "Pop-Star Ahri"
    if Menu.Size.Size == 1 then
      Menu.Size.SizeINFO = "1280x720"
      sprite = GetSprite("\\S1StreamOverlay\\PSAHRI1280x720.png")
    elseif Menu.Size.Size == 2 then
      Menu.Size.SizeINFO = "1360x720"
      sprite = GetSprite("\\S1StreamOverlay\\PSAHRI1360x720.png")
    elseif Menu.Size.Size == 3 then
      Menu.Size.SizeINFO = "1600x900"
      sprite = GetSprite("\\S1StreamOverlay\\PSAHRI1600x900.png")
    elseif Menu.Size.Size == 4 then
      Menu.Size.SizeINFO = "1920x1080"
      sprite = GetSprite("\\S1StreamOverlay\\PSAHRI1920x1080.png")
    else
      Menu.Size.SizeINFO = "N/A"
    end
  elseif Menu.Overlay.Type == 9 then
    Menu.Overlay.TypeINFO = "Radiant Wukong"
    if Menu.Size.Size == 1 then
      Menu.Size.SizeINFO = "1280x720"
      sprite = GetSprite("\\S1StreamOverlay\\RDWU1280x720.png")
    elseif Menu.Size.Size == 2 then
      Menu.Size.SizeINFO = "1360x720"
      sprite = GetSprite("\\S1StreamOverlay\\RDWU1360x720.png")
    elseif Menu.Size.Size == 3 then
      Menu.Size.SizeINFO = "1600x900"
      sprite = GetSprite("\\S1StreamOverlay\\RDWU1600x900.png")
    elseif Menu.Size.Size == 4 then
      Menu.Size.SizeINFO = "1920x1080"
      sprite = GetSprite("\\S1StreamOverlay\\RDWU1920x1080.png")
    else
      Menu.Size.SizeINFO = "N/A"
    end
  elseif Menu.Overlay.Type == 10 then
    Menu.Overlay.TypeINFO = "Spirit Fire Brand"
    if Menu.Size.Size == 1 then
      Menu.Size.SizeINFO = "1280x720"
      sprite = GetSprite("\\S1StreamOverlay\\SBRAND1280x720.png")
    elseif Menu.Size.Size == 2 then
      Menu.Size.SizeINFO = "1360x720"
      sprite = GetSprite("\\S1StreamOverlay\\SBRAND1360x720.png")
    elseif Menu.Size.Size == 3 then
      Menu.Size.SizeINFO = "1600x900"
      sprite = GetSprite("\\S1StreamOverlay\\SBRAND1600x900.png")
    elseif Menu.Size.Size == 4 then
      Menu.Size.SizeINFO = "1920x1080"
      sprite = GetSprite("\\S1StreamOverlay\\SBRAND1920x1080.png")
    else
      Menu.Size.SizeINFO = "N/A"
    end
  else
    Menu.Overlay.TypeINFO = "N/A"
    Menu.Size.SizeINFO = "N/A"
  end
end

---------------------------------------------------------------------------------

function OnTick()
  
  if Menu.Overlay.Type == 1 then
    Menu.Overlay.TypeINFO = "S1 Purple"
    if Menu.Size.Size == 1 then
      Menu.Size.SizeINFO = "1280x720"
    elseif Menu.Size.Size == 2 then
      Menu.Size.SizeINFO = "1360x720"
    elseif Menu.Size.Size == 3 then
      Menu.Size.SizeINFO = "1600x900"
    elseif Menu.Size.Size == 4 then
      Menu.Size.SizeINFO = "1920x1080"
    else
      Menu.Size.SizeINFO = "N/A"
    end
  elseif Menu.Overlay.Type == 2 then
    Menu.Overlay.TypeINFO = "S1 Red"
    if Menu.Size.Size == 1 then
      Menu.Size.SizeINFO = "1280x720"
    elseif Menu.Size.Size == 2 then
      Menu.Size.SizeINFO = "1360x720"
    elseif Menu.Size.Size == 3 then
      Menu.Size.SizeINFO = "1600x900"
    elseif Menu.Size.Size == 4 then
      Menu.Size.SizeINFO = "1920x1080"
    else
      Menu.Size.SizeINFO = "N/A"
    end
  elseif Menu.Overlay.Type == 3 then
    Menu.Overlay.TypeINFO = "Project: Zed"
    if Menu.Size.Size == 1 then
      Menu.Size.SizeINFO = "1280x720"
    elseif Menu.Size.Size == 2 then
      Menu.Size.SizeINFO = "1360x720"
    elseif Menu.Size.Size == 3 then
      Menu.Size.SizeINFO = "1600x900"
    elseif Menu.Size.Size == 4 then
      Menu.Size.SizeINFO = "1920x1080"
    else
      Menu.Size.SizeINFO = "N/A"
    end
  elseif Menu.Overlay.Type == 4 then
    Menu.Overlay.TypeINFO = "Project: Fiora"
    if Menu.Size.Size == 1 then
      Menu.Size.SizeINFO = "1280x720"
    elseif Menu.Size.Size == 2 then
      Menu.Size.SizeINFO = "1360x720"
    elseif Menu.Size.Size == 3 then
      Menu.Size.SizeINFO = "1600x900"
    elseif Menu.Size.Size == 4 then
      Menu.Size.SizeINFO = "1920x1080"
    else
      Menu.Size.SizeINFO = "N/A"
    end
  elseif Menu.Overlay.Type == 5 then
    Menu.Overlay.TypeINFO = "Lissandra"
    if Menu.Size.Size == 1 then
      Menu.Size.SizeINFO = "1280x720"
    elseif Menu.Size.Size == 2 then
      Menu.Size.SizeINFO = "1360x720"
    elseif Menu.Size.Size == 3 then
      Menu.Size.SizeINFO = "1600x900"
    elseif Menu.Size.Size == 4 then
      Menu.Size.SizeINFO = "1920x1080"
    else
      Menu.Size.SizeINFO = "N/A"
    end
  elseif Menu.Overlay.Type == 6 then
    Menu.Overlay.TypeINFO = "Kha'Zix"
    if Menu.Size.Size == 1 then
      Menu.Size.SizeINFO = "1280x720"
    elseif Menu.Size.Size == 2 then
      Menu.Size.SizeINFO = "1360x720"
    elseif Menu.Size.Size == 3 then
      Menu.Size.SizeINFO = "1600x900"
    elseif Menu.Size.Size == 4 then
      Menu.Size.SizeINFO = "1920x1080"
    else
      Menu.Size.SizeINFO = "N/A"
    end
  elseif Menu.Overlay.Type == 7 then
    Menu.Overlay.TypeINFO = "Pool Party Graves"
    if Menu.Size.Size == 1 then
      Menu.Size.SizeINFO = "1280x720"
    elseif Menu.Size.Size == 2 then
      Menu.Size.SizeINFO = "1360x720"
    elseif Menu.Size.Size == 3 then
      Menu.Size.SizeINFO = "1600x900"
    elseif Menu.Size.Size == 4 then
      Menu.Size.SizeINFO = "1920x1080"
    else
      Menu.Size.SizeINFO = "N/A"
    end
  elseif Menu.Overlay.Type == 8 then
    Menu.Overlay.TypeINFO = "Pop-Star Ahri"
    if Menu.Size.Size == 1 then
      Menu.Size.SizeINFO = "1280x720"
    elseif Menu.Size.Size == 2 then
      Menu.Size.SizeINFO = "1360x720"
    elseif Menu.Size.Size == 3 then
      Menu.Size.SizeINFO = "1600x900"
    elseif Menu.Size.Size == 4 then
      Menu.Size.SizeINFO = "1920x1080"
    else
      Menu.Size.SizeINFO = "N/A"
    end
  elseif Menu.Overlay.Type == 9 then
    Menu.Overlay.TypeINFO = "Radiant Wukong"
    if Menu.Size.Size == 1 then
      Menu.Size.SizeINFO = "1280x720"
    elseif Menu.Size.Size == 2 then
      Menu.Size.SizeINFO = "1360x720"
    elseif Menu.Size.Size == 3 then
      Menu.Size.SizeINFO = "1600x900"
    elseif Menu.Size.Size == 4 then
      Menu.Size.SizeINFO = "1920x1080"
    else
      Menu.Size.SizeINFO = "N/A"
    end
  elseif Menu.Overlay.Type == 10 then
    Menu.Overlay.TypeINFO = "Spirit Fire Brand"
    if Menu.Size.Size == 1 then
      Menu.Size.SizeINFO = "1280x720"
    elseif Menu.Size.Size == 2 then
      Menu.Size.SizeINFO = "1360x720"
    elseif Menu.Size.Size == 3 then
      Menu.Size.SizeINFO = "1600x900"
    elseif Menu.Size.Size == 4 then
      Menu.Size.SizeINFO = "1920x1080"
    else
      Menu.Size.SizeINFO = "N/A"
    end
  else
    Menu.Overlay.TypeINFO = "N/A"
    Menu.Size.SizeINFO = "N/A"
  end
end

---------------------------------------------------------------------------------

function OnDraw()
    if sprite then
        sprite:Draw(0,0,0xFF)
    end
end

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------