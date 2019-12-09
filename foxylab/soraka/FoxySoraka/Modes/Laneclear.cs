using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HesaEngine.SDK;
using HesaEngine.SDK.GameObjects;
using System.Collections;
using SharpDX;

namespace FoxySoraka.Modes
{
    class Laneclear
    {
        SpellManager spm;
        MenuHandler _menuhandler = new MenuHandler();
        Menu _menu;
        Orbwalker.OrbwalkerInstance orb;
        public Laneclear(Menu m, SpellManager spm_instance, Orbwalker.OrbwalkerInstance orb_instance)
        {
            _menu = m;
            spm = spm_instance;
            orb = orb_instance;

            _menuhandler.AddSubMenu(_menu, "Laneclear");


            _menuhandler.AddCheckBox((Menu)_menu.Item("Laneclear"), new MenuCheckbox("q", "Use Q", true));
            _menuhandler.AddSlider((Menu)_menu.Item("Laneclear"), new MenuSlider("minQHits", "Min Q Hits", 1, 7, 4));


            Game.OnTick += OnTick;
        }

        private void OnTick()
        {
            if (orb.ActiveMode != Orbwalker.OrbwalkingMode.LaneClear)
            {
                return;
            }

            CastQ();
        }
      
        private void CastQ()
        {
            if (!_menuhandler.GetValue<bool>((Menu)_menu.Item("Laneclear"), "q"))
            {
                return;
            }

            if (!spm.Q.IsReady())
            {
                return;
            }
            var x = spm.Q.GetCircularFarmLocation(ObjectManager.MinionsAndMonsters.Enemy);

            if (x.MinionsHit > _menuhandler.GetValue<int>((Menu)_menu.Item("Laneclear"), "minQHits"))
            {
                spm.Q.Cast(x.Position);
            }
          
        }
    }
}
