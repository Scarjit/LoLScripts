using System;
using System.Collections.Generic;
using HesaEngine.SDK;
using HesaEngine.SDK.Enums;
using HesaEngine.SDK.GameObjects;
using SharpDX;

namespace FoxyAwareness.Heroes
{
    internal class GankAlert
    {
        private readonly Menu _Mainmenu;
        private readonly Menu _menu;
        private readonly MenuHandler _menuhandler = new MenuHandler();
        private readonly ColorBGRA deep_green = new ColorBGRA(0, 128, 0, 255);

        private readonly ColorBGRA deep_red = new ColorBGRA(128, 0, 0, 255);
        private readonly int init_time = Game.GameTimeTickCount;
        private readonly Dictionary<int, int> last_seen = new Dictionary<int, int>();

        public GankAlert(Menu menu)
        {
            _Mainmenu = menu;
            _menu = menu.AddSubMenu("Gank Alert");
            _menuhandler.AddSeparator(_menu, "Enable Gank Alert for:");
            foreach (var enemy in ObjectManager.Heroes.Enemies)
                _menuhandler.AddCheckBox(_menu,
                    new MenuCheckbox(enemy.ChampionName, enemy.ChampionName, false));
            _menuhandler.AddSeparator(_menu, "Settings");
            _menuhandler.AddSlider(_menu, new MenuSlider("detection_range", "Max Detection Range", 0, 6000, 10000));
            _menuhandler.AddSlider(_menu, new MenuSlider("time", "Display time", 0, 5, 10));
            _menuhandler.AddCheckBox(_menu, new MenuCheckbox("ping", "Ping Enemy"));

            foreach (var aiHeroClient in ObjectManager.Heroes.Enemies)
                last_seen.Add(aiHeroClient.NetworkId, 0);

            AdvCallbacks.OnVisionChanged += OnVisionChanged;
            Drawing.OnDraw += OnDraw;
        }

        private void OnDraw(EventArgs args)
        {
            if (!_menuhandler.GetValue<bool>((Menu) _Mainmenu.Item("Global Switches"), "gank_alert"))
                return;

            if (Game.GameTimeTickCount < init_time + 5000)
                Drawing.DrawText(Drawing.Width / 2 - 250, 20, "Please select the Enemy Jungler in the Gank Alert Menu",
                    deep_green);


            var offset = 0;
            foreach (var keyValuePair in last_seen)
                if (Game.GameTimeTickCount - keyValuePair.Value <
                    _menuhandler.GetValue<int>(_menu, "time") * 1000)
                {
                    //TODO Add beautiful draws
                    Drawing.DrawText(Drawing.Width / 2 - 250, 20 + offset,
                        "[WARNING] " + ObjectManager.GetUnitByNetworkId<AIHeroClient>(keyValuePair.Key).ChampionName +
                        " is ganking",
                        deep_red);

                    offset += 25;
                }
        }

        private void OnVisionChanged(bool visible, AIHeroClient whom)
        {
            if (!_menuhandler.GetValue<bool>((Menu) _Mainmenu.Item("Global Switches"), "gank_alert"))
                return;

            if (whom.Team == ObjectManager.Me.Team)
                return;

            if (visible == false)
                return;

            if (_menuhandler.GetValue<bool>(_menu, whom.ChampionName))
                if (whom.Distance3D(ObjectManager.Me) < _menuhandler.GetValue<int>(_menu, "detection_range"))
                {
                    last_seen[whom.NetworkId] = Game.GameTimeTickCount;

                    if (_menuhandler.GetValue<bool>(_menu, "ping"))
                        TacticalMap.SendPing(PingCategory.Danger, whom.Position);
                }
        }
    }
}