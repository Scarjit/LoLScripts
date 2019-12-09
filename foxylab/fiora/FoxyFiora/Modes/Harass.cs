using System;
using System.Linq;
using HesaEngine.SDK;
using HesaEngine.SDK.GameObjects;

namespace FoxyFiora.Modes
{
    public class Harass
    {

        private Menu _menu;
        private MenuHandler _menuHandler;
        private SpellManager _spellManager;
        private AIHeroClient _player;
        public Harass(Menu menu, MenuHandler menuHandler, SpellManager spellManager)
        {
            _menu = menu;
            _menuHandler = menuHandler;
            _spellManager = spellManager;

            _player = ObjectManager.Me;
            _menuHandler.AddSubMenu(_menu, "Harass");
            _menuHandler.AddCheckBox((Menu)_menu.Item("Harass"), new MenuCheckbox("q", "Use Q", true));
            //_menuHandler.AddCheckBox((Menu)_menu.Item("Harass"), new MenuCheckbox("qv", "Jump to Vitals", true));
            _menuHandler.AddCheckBox((Menu)_menu.Item("Harass"), new MenuCheckbox("w", "Use W (Not recommended)", false));
            _menuHandler.AddSlider((Menu)_menu.Item("Harass"), new MenuSlider("wHS", "Min W HitChance", 1,3,3));
            _menuHandler.AddCheckBox((Menu)_menu.Item("Harass"), new MenuCheckbox("e", "Use E", true));
            
            Game.OnTick += OnTick;
        }

        private void OnTick()
        {
            
            if (Core.Orbwalker.ActiveMode != Orbwalker.OrbwalkingMode.Harass)
            {
                return;
            }

            CastQ();
            CastW();
            CastE();
        }

        
        
        private void CastW()
        {
            if (!_menuHandler.GetValue<bool>((Menu) _menu.Item("Harass"), "w") || !_spellManager.W.IsReady())
            {
                return;
            }
            
            
            var target = TargetSelector.GetTarget(_spellManager.W.Range);
            if (target == null)
            {
                return;
            }
            
            var reqHs = HitChance.High;
            switch (_menuHandler.GetValue<int>((Menu)_menu.Item("Harass"), "wHS"))
            {
                case 1:
                    reqHs = HitChance.Low;
                    break;
                case 2:
                    reqHs = HitChance.Medium;
                    break;
                case 3:
                    reqHs = HitChance.High;
                    break;
            }
            

            var predOut = _spellManager.W.GetPrediction(target);
            if (predOut.Hitchance > reqHs)
            {
                _spellManager.W.Cast(predOut.CastPosition);
            }
        }

        private void CastE()
        {
            if (!_menuHandler.GetValue<bool>((Menu) _menu.Item("Harass"), "e") || !_spellManager.E.IsReady())
            {
                return;
            }

            int c = ObjectManager.Heroes.Enemies.Count(
                x => x.IsValid() && x.IsVisible && x.IsValidTarget() && !x.IsDead && x.Distance3D(_player) <  _player.AttackRange + _player.BoundingRadius);
            if (c > 0)
            {
                _spellManager.E.Cast();
            }
        }

        private void CastQ()
        {
            if (!_menuHandler.GetValue<bool>((Menu) _menu.Item("Harass"), "q") || !_spellManager.Q.IsReady())
            {
                return;
            }

            var target = TargetSelector.GetTarget(_spellManager.Q.Range);

            if (target?.Distance3D(_player) > _player.AttackRange + _player.BoundingRadius && !target.IsUnderEnemyTurret())
            {
                _spellManager.Q.Cast(target);
            }
        }
    }
}