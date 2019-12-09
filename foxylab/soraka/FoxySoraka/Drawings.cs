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
    class Drawings
    {
        SpellManager spm;
        MenuHandler _menuhandler = new MenuHandler();
        Menu _menu;
        Orbwalker.OrbwalkerInstance orb;
        
        public Drawings(Menu m, SpellManager spm_instance, Orbwalker.OrbwalkerInstance orb_instance)
        {
            _menu = m;
            spm = spm_instance;
            orb = orb_instance;

            _menuhandler.AddSubMenu(_menu, "Drawings");


            _menuhandler.AddCheckBox((Menu)_menu.Item("Drawings"), new MenuCheckbox("q", "Draw Q Range", true));

            _menuhandler.AddCheckBox((Menu)_menu.Item("Drawings"), new MenuCheckbox("w", "Draw W Range", true));

            _menuhandler.AddCheckBox((Menu)_menu.Item("Drawings"), new MenuCheckbox("e", "Draw E Range", true));

            Drawing.OnDraw += OnDraw;
        }

        private void OnDraw(EventArgs args)
        {
            DrawQ();
            DrawW();
            DrawE();
        }

        private void DrawQ()
        {

            if (!_menuhandler.GetValue<bool>((Menu)_menu.Item("Drawings"), "q"))
            {
                return;
            }

            Drawing.DrawCircle(ObjectManager.Me.Position, spm.Q.Range);
        }
        private void DrawW()
        {

            if (!_menuhandler.GetValue<bool>((Menu)_menu.Item("Drawings"), "w"))
            {
                return;
            }

            Drawing.DrawCircle(ObjectManager.Me.Position, spm.W.Range);
        }
        private void DrawE()
        {

            if (!_menuhandler.GetValue<bool>((Menu)_menu.Item("Drawings"), "e"))
            {
                return;
            }

            Drawing.DrawCircle(ObjectManager.Me.Position, spm.E.Range);
        }
    }
}
