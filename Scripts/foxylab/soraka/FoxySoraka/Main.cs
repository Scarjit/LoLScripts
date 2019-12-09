using FoxySoraka.Modes;
using HesaEngine.SDK;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoxySoraka
{
    public class Main : IScript
    {
        private readonly MenuHandler _menuhandler = new MenuHandler();
        private Menu _menu;
        private SpellManager sm;
        private Orbwalker.OrbwalkerInstance orb;

        public void OnInitialize()
        {
            Game.OnGameLoaded += OnLoad;
        }

#if DEBUG
        public string Name => "Foxy Soraka [DEBUG]";
        public string Version => "DEBUG VERSION";
#else
        public string Name => "Foxy Soraka";
        public string Version => "0.0.5";

#endif
        public string Author => "S1mple";

        private void OnLoad()
        {
            sm = new SpellManager();
            _menu = new Menu(Name);
            orb = Core.Orbwalker;

            AdvCallbacks.Init(_menu);

            Modes.Combo combo = new Combo(_menu, sm, orb);
            Modes.Harass harass = new Harass(_menu, sm, orb);
            Modes.Laneclear laneclear = new Laneclear(_menu, sm, orb);
            Modes.AutoHeal autoheal = new AutoHeal(_menu, sm, orb);
            Drawings drawings = new Drawings(_menu, sm, orb);
        }
        
    }
}
