using FoxyAwareness.Heroes;
using FoxyAwareness.Other;
using HesaEngine.SDK;
using System;

namespace FoxyAwareness
{
    public class Main : IScript
    {
        private readonly MenuHandler _menuhandler = new MenuHandler();
        private Menu _menu;

        public void OnInitialize()
        {
            Game.OnGameLoaded += OnLoad;
        }

#if DEBUG
        public string Name => "Foxy Awareness [DEBUG]";
        public string Version => "DEBUG VERSION";
#else
        public string Name => "Foxy Awareness";
        public string Version => "0.0.4";

#endif
        public string Author => "S1mple";

        private void OnLoad()
        {
            MainMenu();
            AdvCallbacks.Init(_menu);
            var cdt = new CooldownTracker(_menu);
            var fT = new FoWTracker(_menu);
            var ga = new GankAlert(_menu);
            var rt = new RecallTracker(_menu);
            var bct = new BossTracker(_menu);
            var jct = new JungleCampTracker(_menu);
            var wt = new WardTracker(_menu);
            var aw = new AdditionalAwareness(_menu);
        }

        private void MainMenu()
        {
#if DEBUG
            var _default = false;
#else
            bool _default = true;
#endif

            _menu = Menu.AddMenu(Name);

            var switches = _menu.AddSubMenu("Global Switches");
            _menuhandler.AddSeparator(switches, "Hero Trackers");
            _menuhandler.AddCheckBox(switches, new MenuCheckbox("cooldown_tracker", "Enable Cooldown", _default));
            _menuhandler.AddCheckBox(switches, new MenuCheckbox("fow_tracker", "Enable FoW Tracker", _default));
            _menuhandler.AddCheckBox(switches, new MenuCheckbox("gank_alert", "Enable Gank Alert", _default));
            _menuhandler.AddCheckBox(switches, new MenuCheckbox("recall_tracker", "Enable Recall Tracker", _default));
            _menuhandler.AddCheckBox(switches, new MenuCheckbox("additional", "Enable Additional Awareness", _default));


            _menuhandler.AddSeparator(switches, "Other Features");
            _menuhandler.AddCheckBox(switches,
                new MenuCheckbox("bosscooldown_tracker", "Enable Boss Tracker", _default));
            _menuhandler.AddCheckBox(switches,
                new MenuCheckbox("junglecooldown_tracker", "Enable Jungle Cooldown Tracker", _default));
            _menuhandler.AddCheckBox(switches, new MenuCheckbox("ward_tracker", "Enable Ward Tracker", _default));
        }
    }
}