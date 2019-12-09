using FoxyUtility.Awareness;
using HesaEngine.SDK;
using HesaEngine.SDK.GameObjects;

namespace FoxyUtility {
    public class Main : IScript {
        public string Name => "FoxyUtility";
        public string Version => "1.0.1";
        public string Author => "FOXY.lab";

        private readonly MenuHandler _menu = new MenuHandler();

        public AIHeroClient Player => ObjectManager.Player;

        private Menu _utilityMenu;
        private Hud _hud;

        public void OnInitialize() {
            Game.OnGameLoaded += OnGameLoaded;
        }

        private void OnGameLoaded() {
            //Menu init
            _utilityMenu = Menu.AddMenu("[FOXY.lab] Utility");
            
            _hud = new Hud(_utilityMenu);
            
            //Team Credits
            _menu.AddSubMenu(_utilityMenu, " ");
            _menu.AddSeparator(_utilityMenu, "FoxyUtility by Foxy.Lab");
            _menu.AddSubMenu(_utilityMenu, "dDragon");
            _menu.AddSubMenu(_utilityMenu, "DrPhoenix");
            _menu.AddSubMenu(_utilityMenu, "S1mple");

            Utils.PrintChat("Welcome " + Player.Name);
        }
    }
}