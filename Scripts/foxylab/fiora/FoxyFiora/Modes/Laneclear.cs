using System;
using System.Linq;
using HesaEngine.SDK;
using HesaEngine.SDK.GameObjects;

namespace FoxyFiora.Modes
{
    public class Laneclear
    {
        private Menu _menu;
        private MenuHandler _menuHandler;
        private SpellManager _spellManager;

        public Laneclear(Menu menu, MenuHandler menuHandler, SpellManager spellManager)
        {
            _menu = menu;
            _menuHandler = menuHandler;
            _spellManager = spellManager;
            _menuHandler.AddSubMenu(_menu, "Laneclear");
            _menuHandler.AddCheckBox((Menu)_menu.Item("Laneclear"), new MenuCheckbox("q", "Use Q", true));
            _menuHandler.AddCheckBox((Menu)_menu.Item("Laneclear"), new MenuCheckbox("w", "Use W", true));
            _menuHandler.AddCheckBox((Menu)_menu.Item("Laneclear"), new MenuCheckbox("savew", "Save W if enemies are around", true));
            _menuHandler.AddCheckBox((Menu)_menu.Item("Laneclear"), new MenuCheckbox("e", "Use E", true));
            
            Game.OnTick += OnTick;
        }
        

        private void OnTick()
        {
            if (Core.Orbwalker.ActiveMode != Orbwalker.OrbwalkingMode.LaneClear)
            {
                return;
            }

            CastQ();
            CastW();
            CastE();
        }
        
        private void CastQ()
        {
            if (!_menuHandler.GetValue<bool>((Menu) _menu.Item("Laneclear"), "q") || !_spellManager.Q.IsReady())
            {
                return;
            }

            var lowest_minions =
                ObjectManager.MinionsAndMonsters.Enemy.Where(x =>
                    x.IsValid() && !x.IsDead && x.IsVisible &&
                    x.Health < _spellManager.GetRealDamage(_spellManager.Q, x) && x.Distance3D(ObjectManager.Me) < _spellManager.Q.Range || !x.IsUnderEnemyTurret()
                    );

            Obj_AI_Minion lowest = null;
            foreach (Obj_AI_Minion objAiMinion in lowest_minions)
            {
                lowest = lowest == null ? objAiMinion : (lowest.Health > objAiMinion.Health ? objAiMinion : lowest);
            }

            if (lowest != null && lowest.Distance3D(ObjectManager.Me) < _spellManager.Q.Range)
            {
                _spellManager.Q.Cast(lowest.Position);
            }
        }

        private void CastW()
        {
            
            if (!_menuHandler.GetValue<bool>((Menu) _menu.Item("Laneclear"), "w") || !_spellManager.W.IsReady())
            {
                return;
            }
            
            int enemies_in_range = ObjectManager.Heroes.Enemies.Count(x =>
                x.IsValid() && !x.IsDead && x.IsVisible && x.Distance3D(ObjectManager.Me) < 1000 && x.IsVisible && x.IsValid() && !x.IsDead);

            if (enemies_in_range > 0 && _menuHandler.GetValue<bool>((Menu) _menu.Item("Laneclear"), "savew"))
            {
                return;
            }

            
            var farm_pos = _spellManager.W.GetLineFarmLocation(ObjectManager.MinionsAndMonsters.Enemy);
            if (farm_pos.MinionsHit > 2 && farm_pos.Position.To3DWorld().Distance(ObjectManager.Me) < _spellManager.W.Range)
            {
                _spellManager.W.Cast(farm_pos.Position);
            }
        }

        private void CastE()
        {if (!_menuHandler.GetValue<bool>((Menu) _menu.Item("Laneclear"), "e") || !_spellManager.E.IsReady())
            {
                return;
            }
            
            int minions_in_range =
                ObjectManager.MinionsAndMonsters.Enemy.Count(x => x.IsValid() && x.IsVisible && !x.IsDead);
            if (minions_in_range > 4)
            {
                _spellManager.E.Cast();
            }
        }

    }
}