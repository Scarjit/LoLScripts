using System;
using System.Collections.Generic;
using HesaEngine.SDK;
using HesaEngine.SDK.GameObjects;
using SharpDX;

namespace FoxyAwareness.Other
{
    internal class WardTracker
    {
        private readonly Menu _Mainmenu;
        private readonly Menu _menu;
        private readonly MenuHandler _menuhandler = new MenuHandler();
        private readonly ColorBGRA blue = new ColorBGRA(0, 0, 255, 255);
        private readonly ColorBGRA red = new ColorBGRA(255, 0, 0, 255);

        private readonly List<WardType> wards = new List<WardType>();


        private readonly ColorBGRA white = new ColorBGRA(255, 255, 255, 255);

        public WardTracker(Menu menu)
        {
            _Mainmenu = menu;
            _menu = menu.AddSubMenu("Ward Tracker");
            _menuhandler.AddCheckBox(_menu, new MenuCheckbox("allys", "Display Ally Wards"));
            _menuhandler.AddCheckBox(_menu, new MenuCheckbox("name", "Display Ward/Trap Name"));
            _menuhandler.AddCheckBox(_menu, new MenuCheckbox("teemo", "Track Teemo Shrooms"));
            _menuhandler.AddCheckBox(_menu,
                new MenuCheckbox("zyra", "Track Zyra Plants (Do not use, while Syndra is ingame)"));
            _menuhandler.AddCheckBox(_menu, new MenuCheckbox("maokai", "Track Maokai Plants"));
            _menuhandler.AddCheckBox(_menu, new MenuCheckbox("caitlyn", "Track Caitlyn Traps"));

            GameObject.OnCreate += OnCreateObject;
            Drawing.OnEndScene += OnEndScene;
        }

        private void OnEndScene(EventArgs args)
        {
            foreach (var ward in wards)
                if (ward.ward.IsValid() && ward.ward.Health > 0)
                    if (ward.ward.Team == ObjectManager.Me.Team && _menuhandler.GetValue<bool>(_menu, "allys") ||
                        ward.ward.Team != ObjectManager.Me.Team)
                    {
                        var time = 0f;
                        if (ward.override_time != -1)
                            time = Math.Max(0, ward.override_time - (Game.Time - ward.placement_time));
                        else
                            time = Math.Max(0, ward.ward.MaxMana - (Game.Time - ward.placement_time));
                        var name = "";
                        if (_menuhandler.GetValue<bool>(_menu, "name"))
                            name += ward.ward.Name + " : ";
                        if (!ward.ward.Name.Contains("JammerWard"))
                            Drawing.DrawText(ward.ward.Position.WorldToScreen(), white, name + time);
                        else
                            Drawing.DrawText(ward.ward.Position.WorldToScreen(), white, name);
                        Drawing.DrawCircle(ward.ward.Position, 50);
                    }
        }

        private void OnCreateObject(GameObject sender, EventArgs args)
        {
            if (!_menuhandler.GetValue<bool>((Menu) _Mainmenu.Item("Global Switches"), "ward_tracker"))
                return;
            if (sender != null && sender.IsValid() &&
                (sender.Name.Contains("Ward") || sender.Name.Contains("JammerDevice") ||
                 sender.Name.Contains("DoABarrelRoll") && _menuhandler.GetValue<bool>(_menu, "maokai") ||
                 sender.Name.Contains("Noxious") && _menuhandler.GetValue<bool>(_menu, "teemo") ||
                 sender.Name.Contains("Seed") && _menuhandler.GetValue<bool>(_menu, "zyra") ||
                 sender.Name.Contains("Cupcake") && _menuhandler.GetValue<bool>(_menu, "caitlyn")))
            {
                if (sender.Name != "WardCorpse")
                {
                    var x = new WardType(sender, Game.Time);
                    if (sender.Name.Contains("DoABarrelRoll")) //Maokai
                        x.override_time = 30;
                    if (sender.Name.Contains("Seed")) //Maokai
                        x.override_time = 60;
                    if (sender.Name.Contains("Cupcake")) //Caitlyn
                        x.override_time = 90;
                    wards.Add(x);
                }
            }
            else
            {
                foreach (var ward in wards)
                    if (!ward.ward.IsValid() || ward.ward.Health == 0 || ward.ward.Position == sender.Position)
                    {
                        wards.Remove(ward);
                        break;
                    }
            }
        }

        private struct WardType

        {
            public readonly Obj_AI_Minion ward;
            public readonly float placement_time;
            public int override_time;

            public WardType(GameObject sender, float gameTimeTickCount)
            {
                ward = (Obj_AI_Minion) sender;
                placement_time = gameTimeTickCount;
                override_time = -1;
            }
        }
    }
}