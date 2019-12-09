using FoxyXayah.Modes;
using HesaEngine.SDK;
using HesaEngine.SDK.Enums;
using HesaEngine.SDK.GameObjects;

namespace FoxyXayah
{
    public class Main : IScript
    {
        private readonly MenuHandler _menu = new MenuHandler();
        private readonly SpellManager _spellManager = new SpellManager();
        private Combo _combo;
        private Draws _draws;
        private FeatherManager _featherManager;
        private Harass _harass;
        private Killsteal _killsteal;
        private Laneclear _laneclear;
        private AntiCC _antiCC;
        private AutoShields _autoShields;
        private Menu _xayahMenu;
        private Orbwalker.OrbwalkerInstance _xayahOrbWalk;

        public AIHeroClient Player => ObjectManager.Player;

        public void OnInitialize()
        {
            Game.OnGameLoaded += OnGameLoaded;
        }

        public string Name => "FoxyXayah";
        public string Version => "1.0.1";
        public string Author => "FOXY.lab";

        private void OnGameLoaded()
        {
            if (Player.ChampionName != "Xayah")
                return;

            //FeatherManager
            _featherManager = new FeatherManager();

            //Spells init
            _spellManager.Q = new Spell(SpellSlot.Q, 1100f);
            _spellManager.Q.SetSkillshot(0.5f, 75f, 2000f, false, SkillshotType.SkillshotLine, Player.Position);
            _spellManager.W = new Spell(SpellSlot.W);
            _spellManager.E = new Spell(SpellSlot.E, 25000f);
            _spellManager.E.SetSkillshot(0.25f, 75f, 2000f, false, SkillshotType.SkillshotLine);
            _spellManager.R = new Spell(SpellSlot.R, 1050f);
            _spellManager.R.SetSkillshot(0.5f, 45f, 2000f, false, SkillshotType.SkillshotCone);
            _spellManager.LoadSummoners();

            //Menu init
            _xayahMenu = Menu.AddMenu("[FOXY.lab] Xayah");

            //Orbwalker init
            _menu.AddSeparator(_xayahMenu, "MAIN FUNCTIONS");
            _xayahOrbWalk = new Orbwalker.OrbwalkerInstance(_xayahMenu.AddSubMenu("Orbwalker"));

            _combo = new Combo(_xayahMenu, _xayahOrbWalk, _spellManager, _featherManager);
            _harass = new Harass(_xayahMenu, _xayahOrbWalk, _spellManager, _featherManager);
            _laneclear = new Laneclear(_xayahMenu, _xayahOrbWalk, _spellManager, _featherManager);
            _draws = new Draws(_xayahMenu, _spellManager, _featherManager);
            _killsteal = new Killsteal(_xayahMenu, _spellManager, _featherManager);
            _antiCC = new AntiCC(_xayahMenu, _spellManager);
            _autoShields = new AutoShields(_xayahMenu, _spellManager);

            //Notify callbacks
            AdvCallbacks.Init(_xayahMenu);

            //Team Credits
            _menu.AddSubMenu(_xayahMenu, " ");
            _menu.AddSeparator(_xayahMenu, "FoxyXayah by Foxy.Lab");
            _menu.AddSubMenu(_xayahMenu, "S1mple");
            _menu.AddSubMenu(_xayahMenu, "dDragon");
            _menu.AddSubMenu(_xayahMenu, "DrPhoenix");

            Utils.PrintChat("Welcome " + Player.Name);
        }
    }
}