using System;
using HesaEngine.SDK;
using SharpDX;

namespace FoxyAshe
{
    internal class Draws
    {
        private readonly MenuHandler _menu = new MenuHandler();
        private readonly Menu _asheMenu;
        private readonly SpellManager _spellManager;

        public Draws(Menu asheMenu, SpellManager spellManager)
        {
            _asheMenu = asheMenu;
            _spellManager = spellManager;

            //Draw menu
            _menu.AddSeparator(asheMenu, "DRAW FUNCTIONS");
            _menu.AddSubMenu(asheMenu, "Draw");
            _menu.AddCheckBox((Menu) asheMenu.Item("Draw"), new MenuCheckbox("w", "Draw W range", true));

            Drawing.OnDraw += OnDraw;
        }

        private void OnDraw(EventArgs args)
        {
            if (_menu.GetValue<bool>((Menu) _asheMenu.Item("Draw"), "w"))
            {
                Drawing.DrawCircle(ObjectManager.Player.Position, _spellManager.W.Range, Color.DarkGray, 2);
            }
        }
    }
}