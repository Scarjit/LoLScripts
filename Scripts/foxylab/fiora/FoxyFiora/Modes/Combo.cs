using System;
using System.Linq;
using HesaEngine.SDK;
using HesaEngine.SDK.Data;
using HesaEngine.SDK.GameObjects;

namespace FoxyFiora.Modes
{
    public class Combo
    {

        private Menu _menu;
        private MenuHandler _menuHandler;
        private SpellManager _spellManager;
        private AIHeroClient _player;
        public Combo(Menu menu, MenuHandler menuHandler, SpellManager spellManager)
        {
            _menu = menu;
            _menuHandler = menuHandler;
            _spellManager = spellManager;

            _player = ObjectManager.Me;
            _menuHandler.AddSubMenu(_menu, "Combo");
            _menuHandler.AddCheckBox((Menu)_menu.Item("Combo"), new MenuCheckbox("q", "Use Q", true));
            //_menuHandler.AddCheckBox((Menu)_menu.Item("Combo"), new MenuCheckbox("qv", "Jump to Vitals", true));
            _menuHandler.AddCheckBox((Menu)_menu.Item("Combo"), new MenuCheckbox("w", "Use W (Not recommended)", false));
            _menuHandler.AddSlider((Menu)_menu.Item("Combo"), new MenuSlider("wHS", "Min W HitChance", 1,3,3));
            _menuHandler.AddCheckBox((Menu)_menu.Item("Combo"), new MenuCheckbox("e", "Use E", true));
            _menuHandler.AddCheckBox((Menu)_menu.Item("Combo"), new MenuCheckbox("r", "Use R", true));
            _menuHandler.AddCheckBox((Menu)_menu.Item("Combo"), new MenuCheckbox("rsaveself", "Save self", true));
            _menuHandler.AddCheckBox((Menu)_menu.Item("Combo"), new MenuCheckbox("rsaveally", "Save ally", true));
            _menuHandler.AddSlider((Menu)_menu.Item("Combo"), new MenuSlider("rminally", "Min Allies in Range", 0,5,0));
            _menuHandler.AddSlider((Menu)_menu.Item("Combo"), new MenuSlider("rminhppercself", "Min HP (self) %", 1,100,50));
            _menuHandler.AddSlider((Menu)_menu.Item("Combo"), new MenuSlider("rminhppercally", "Min HP (ally) %", 1,100,50));
            _menuHandler.AddSlider((Menu)_menu.Item("Combo"), new MenuSlider("rmaxhppercenemy", "Max HP (enemy) %", 1,100,50));
            
            Game.OnTick += OnTick;
            
        }


        private void OnTick()
        {
            if (Core.Orbwalker.ActiveMode != Orbwalker.OrbwalkingMode.Combo)
            {
                return;
            }

            CastQ();
            CastW();
            CastE();
            CastR();

            
        }

        private void CastR()
        {            
            if (!_menuHandler.GetValue<bool>((Menu) _menu.Item("Combo"), "r") || !_spellManager.R.IsReady())
            {
                return;
            }

            if (_menuHandler.GetValue<int>((Menu) _menu.Item("Combo"), "rminally") > ObjectManager.Heroes.Allies.Count(x => x.IsValid() && x.Distance3D(_player) < _spellManager.R.Range && !x.IsDead))
            {
                return;
            }
            
            //Do i need to save self/ally ?
            int enemies_in_range = ObjectManager.Heroes.Enemies.Count(x =>
                x.IsValid() && !x.IsDead && x.IsVisible && x.Distance3D(ObjectManager.Me) < 1000 && x.IsVisible && x.IsValid() && !x.IsDead);
            if (enemies_in_range == 0)
            {
                return;
            }
            
            bool save_self = _player.HealthPercent < _menuHandler.GetValue<int>((Menu) _menu.Item("Combo"), "rminhppercself");
            bool save_ally = ObjectManager.Heroes.Allies.Any(x => x.HealthPercent < _menuHandler.GetValue<int>((Menu) _menu.Item("Combo"), "rminhppercally") && !x.IsDead);

            if (!save_ally && !save_ally)
            {
                return;
            }

            var potential_targets = ObjectManager.Heroes.Enemies.Where(x =>
                x.IsValid() && !x.IsDead && x.IsVisible && x.Distance3D(ObjectManager.Me) < _spellManager.R.Range &&
                x.IsVisible && x.IsValid() && !x.IsDead && x.HealthPercent < _menuHandler.GetValue<int>((Menu) _menu.Item("Combo"), "rmaxhppercenemy"));

            AIHeroClient target = null;
            foreach (AIHeroClient potentialTarget in potential_targets)
            {
                if (target == null || target.Health > potentialTarget.Health)
                {
                    target = potentialTarget;
                }
            }

            if (target != null)
            {
                _spellManager.R.Cast(target);
            }
        }


        private void CastW()
        {
            if (!_menuHandler.GetValue<bool>((Menu) _menu.Item("Combo"), "w") || !_spellManager.W.IsReady())
            {
                return;
            }
            
            
            var target = TargetSelector.GetTarget(_spellManager.W.Range);
            if (target == null)
            {
                return;
            }
            
            var reqHs = HitChance.High;
            switch (_menuHandler.GetValue<int>((Menu)_menu.Item("Combo"), "wHS"))
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
            if (!_menuHandler.GetValue<bool>((Menu) _menu.Item("Combo"), "e") || !_spellManager.E.IsReady())
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
            if (!_menuHandler.GetValue<bool>((Menu) _menu.Item("Combo"), "q") || !_spellManager.Q.IsReady())
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