using System;
using FoxyFiora.Modes;
using HesaEngine.SDK;

namespace FoxyFiora
{
    public class Main : IScript
    {
        public string Name => "FoxyFiora";
        public string Version => "0.0.1";
        public string Author => "S1mple";
        
        public void OnInitialize()
        {
            
            Game.OnGameLoaded += OnLoad;
        }

        private void OnLoad()
        {
            Menu _menu = new Menu("Foxy.Fiora");
            MenuHandler menuHandler = new MenuHandler();
            SpellManager spellManager = new SpellManager();
            
            Modes.Flee flee = new Modes.Flee(_menu, menuHandler, spellManager);
            Modes.Combo combo = new Modes.Combo(_menu, menuHandler, spellManager);
            Modes.Harass harass = new Modes.Harass(_menu, menuHandler, spellManager);
            Modes.Laneclear laneclear = new Modes.Laneclear(_menu, menuHandler, spellManager);
            Spellblock spellblock = new Spellblock(_menu, menuHandler, spellManager);
        }
    }
}