using HesaEngine.SDK;
using HesaEngine.SDK.GameObjects;

namespace FoxyAshe.Modes
{
    internal class AutoShields
    {
        private readonly MenuHandler _menu = new MenuHandler();
        private readonly Menu _shieldsMenu;
        private readonly Menu _menuInstance;
        private readonly SpellManager _spellManager;
        private bool _underAttack;
        private AIHeroClient Player => ObjectManager.Player;
        private float _lastTickHealth = float.MaxValue;
        private int _lastTick;

        public AutoShields(Menu asheMenu, SpellManager spellManager)
        {
            //Init
            _menuInstance = asheMenu;
            _spellManager = spellManager;
            _underAttack = false;
            _lastTick = 0;

            //AutoShields menu
            _menu.AddSubMenu(_menuInstance, "Lifesave");
            _shieldsMenu = (Menu) _menuInstance.Item("Lifesave");
            _menu.AddSeparator(_shieldsMenu, "SPELLS TO USE");
            _menu.AddCheckBox(_shieldsMenu, new MenuCheckbox("heal", "Use Heal", true));
            _menu.AddCheckBox(_shieldsMenu, new MenuCheckbox("barrier", "Use Barrier", true));
            _menu.AddSeparator(_shieldsMenu, "SETTINGS");
            _menu.AddSlider(_shieldsMenu, new MenuSlider("healthPercent", "% Health", 1, 100, 35));

            //Tick
            Game.OnTick += OnTick;
        }

        private void OnTick()
        {
            if (_spellManager.Heal == null) return;
            if (_spellManager.Heal.IsReady() && HesaEngine.SDK.Utils.TickCount - this._lastTick > 500)
            {
                if (Player.Health < _lastTickHealth && Player.HealthPercent <=
                    _menu.GetValue<int>(_shieldsMenu, "healthPercent"))
                {
                    _spellManager.Heal.Cast(Player);
                    _lastTickHealth = Player.Health;
                    _lastTick = HesaEngine.SDK.Utils.TickCount;
                    return;
                }
            }

            if (_spellManager.Barrier == null) return;
            if (!_spellManager.Barrier.IsReady() || HesaEngine.SDK.Utils.TickCount - this._lastTick <= 500) return;
            if (!(Player.Health < _lastTickHealth) || !(Player.HealthPercent <=
                                                        _menu.GetValue<int>(_shieldsMenu, "healthPercent"))) return;
            _spellManager.Barrier.Cast(Player);
            _lastTickHealth = Player.Health;
            _lastTick = HesaEngine.SDK.Utils.TickCount;
        }
    }
}