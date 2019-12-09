using HesaEngine.SDK;

namespace FoxyFiora.Modes
{
    public class Flee
    {
        private Menu _menu;
        private MenuHandler _menuHandler;
        private SpellManager _spellManager;

        public Flee(Menu menu, MenuHandler menuHandler, SpellManager spellManager)
        {
            _menu = menu;
            _menuHandler = menuHandler;
            _spellManager = spellManager;
            _menuHandler.AddSubMenu(_menu, "Flee");
            _menuHandler.AddCheckBox((Menu)_menu.Item("Flee"), new MenuCheckbox("activeq", "Activate Q usage ?", true));
            
            Game.OnTick += OnTick;
        }

        private void OnTick()
        {
            if (Core.Orbwalker.ActiveMode != Orbwalker.OrbwalkingMode.Flee)
            {
                return;
            }

            if (_menuHandler.GetValue<bool>((Menu) _menu.Item("Flee"), "activeq"))
            {
                if (_spellManager.Q.IsReady() && ObjectManager.Me.GetWaypoints().Count > 2)
                {
                    _spellManager.Q.Cast(ObjectManager.Me.GetWaypoints()[2]);
                }
            }
        }
    }
}