using FoxyAshe.Modes;
using HesaEngine.SDK;
using HesaEngine.SDK.Enums;
using HesaEngine.SDK.GameObjects;

namespace FoxyAshe
{
    public class Main : IScript
    {
        private readonly MenuHandler _menu = new MenuHandler();
        private readonly SpellManager _spellManager = new SpellManager();
        private Menu _asheMenu;
        private Orbwalker.OrbwalkerInstance _asheOrbWalk;
        private Combo _combo;
        private Draws _draws;
        private Harass _harass;
        private Killsteal _killsteal;
        private Laneclear _laneclear;
        private AntiCC _antiCC;
        private AutoShields _autoShields;

        public bool CanAttack = true;

        public AIHeroClient Player => ObjectManager.Player;
        public string Name => "FoxyAshe";
        public string Version => "1.1.0";
        public string Author => "FOXY.lab";

        public void OnInitialize()
        {
            Game.OnGameLoaded += OnGameLoaded;
        }

        private void OnGameLoaded()
        {
            if (Player.ChampionName != "Ashe")
                return;


            //Spells init
            _spellManager.Q = new Spell(SpellSlot.Q);
            _spellManager.W = new Spell(SpellSlot.W, 1200f);
            _spellManager.W.SetSkillshot(0.25f, 57.5f, 2000f, true, SkillshotType.SkillshotCone, Player.Position);
            _spellManager.E = new Spell(SpellSlot.E, 25000f);
            _spellManager.R = new Spell(SpellSlot.R, 1600f);
            _spellManager.R.SetSkillshot(0.25f, 100f, 1600f, false, SkillshotType.SkillshotLine);

            //SSpells init
            _spellManager.LoadSummoners();

            //Menu init
            _asheMenu = Menu.AddMenu("[FOXY.lab] Ashe");

            //Orbwalker init
            _menu.AddSeparator(_asheMenu, "MAIN FUNCTIONS");
            _asheOrbWalk = new Orbwalker.OrbwalkerInstance(_asheMenu.AddSubMenu("Orbwalker"));

            _combo = new Combo(_asheMenu, _asheOrbWalk, _spellManager);
            _harass = new Harass(_asheMenu, _asheOrbWalk, _spellManager);
            _laneclear = new Laneclear(_asheMenu, _asheOrbWalk, _spellManager);
            _draws = new Draws(_asheMenu, _spellManager);
            _killsteal = new Killsteal(_asheMenu, _spellManager);
            _antiCC = new AntiCC(_asheMenu, _spellManager);
            _autoShields = new AutoShields(_asheMenu, _spellManager);

            //Notify callbacks
            AdvCallbacks.Init(_asheMenu);

            //Team Credits
            _menu.AddSubMenu(_asheMenu, " ");
            _menu.AddSeparator(_asheMenu, "FoxyAshe by Foxy.Lab");
            _menu.AddSubMenu(_asheMenu, "S1mple");
            _menu.AddSubMenu(_asheMenu, "dDragon");
            _menu.AddSubMenu(_asheMenu, "DrPhoenix");

            Utils.PrintChat("Welcome " + Player.Name);
        }
    }
}