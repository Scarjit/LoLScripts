using System;
using HesaEngine.SDK;
using HesaEngine.SDK.GameObjects;
using SharpDX;

namespace FoxyAwareness.Heroes
{
    internal class AdditionalAwareness
    {
        private readonly Menu _Mainmenu;
        private readonly Menu _menu;
        private readonly MenuHandler _menuhandler = new MenuHandler();
        private readonly ColorBGRA grey = new ColorBGRA(128, 128, 128, 255);
        private readonly ColorBGRA white = new ColorBGRA(255, 255, 255, 255);
        private readonly AIHeroClient player = ObjectManager.Player;

        public AdditionalAwareness(Menu menu)
        {
            _Mainmenu = menu;
            _menu = menu.AddSubMenu("Additional Awareness");
            _menuhandler.AddSeparator(_menu, "Snap Lines");
            _menuhandler.AddCheckBox(_menu, new MenuCheckbox("snaplines", "Show Snap Lines"));
            _menuhandler.AddSlider(_menu, new MenuSlider("snaplines_min_distance", "Min Distance", 0, 4000, 200));
            _menuhandler.AddSlider(_menu, new MenuSlider("snaplines_max_distance", "Max Distance", 0, 16000, 4000));
            _menuhandler.AddSlider(_menu, new MenuSlider("snaplines_lenght", "Snapline lenghts", 0, 1000, 400));
            _menuhandler.AddCheckBox(_menu, new MenuCheckbox("snaplines_names", "Show Names"));
            _menuhandler.AddSeparator(_menu, "Tower Ranges");
            _menuhandler.AddCheckBox(_menu, new MenuCheckbox("tower", "Show Tower Range"));
            _menuhandler.AddSeparator(_menu, "Other");
            _menuhandler.AddCheckBox(_menu, new MenuCheckbox("realtime", "Real Time", true));
            _menuhandler.AddSlider(_menu, new MenuSlider("time_x_off", "X Offset", -500, 500, 0));
            _menuhandler.AddSlider(_menu, new MenuSlider("time_y_off", "Y Offset", -500, 500, 0));

            Drawing.OnEndScene += OnEndScene;
        }

        private void OnEndScene(EventArgs args)
        {
            if (!_menuhandler.GetValue<bool>((Menu) _Mainmenu.Item("Global Switches"), "additional"))
                return;

            SnapLines();
            TowerRanges();
            Other();
        }

        private void Other()
        {
            if (_menuhandler.GetValue<bool>(_menu, "realtime"))
                Drawing.DrawText(Drawing.Width - 200 + _menuhandler.GetValue<int>(_menu, "time_x_off"),
                    40 + _menuhandler.GetValue<int>(_menu, "time_y_off"), grey, DateTime.Now.ToShortTimeString());
        }

        private void TowerRanges()
        {
            if (!_menuhandler.GetValue<bool>(_menu, "tower"))
                return;

            foreach (var objAiTurret in ObjectManager.Turrets.Enemy)
                if (objAiTurret.IsVisibleOnScreen)
                    Drawing.DrawCircle(objAiTurret.Position, objAiTurret.AttackRange, white, 2);
        }

        private void SnapLines()
        {
            if (!_menuhandler.GetValue<bool>(_menu, "snaplines"))
            {
                return;
                
            }

            foreach (var enemy in ObjectManager.Heroes.Enemies)
                if (enemy.IsVisible)
                {
                    var distance = enemy.Distance3D(player);
                    if (distance >= _menuhandler.GetValue<int>(_menu, "snaplines_min_distance") && distance <=
                        _menuhandler.GetValue<int>(_menu, "snaplines_max_distance"))
                    {
                        var vectorEP = enemy.Position - player.Position;
                        vectorEP.Normalize();

                        vectorEP = vectorEP * Math.Min(distance, _menuhandler.GetValue<int>(_menu, "snaplines_lenght"));
                        var fin = player.Position + vectorEP;
                        Drawing.DrawLine(player.Position, fin, 1, white);

                        if (_menuhandler.GetValue<bool>(_menu, "snaplines_names"))
                            Drawing.DrawText(fin.WorldToScreen(), white, enemy.ChampionName);
                    }
                }
        }
    }
}