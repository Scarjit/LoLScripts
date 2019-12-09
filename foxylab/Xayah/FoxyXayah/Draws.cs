using System;
using HesaEngine.SDK;
using SharpDX;

namespace FoxyXayah
{
    internal class Draws
    {
        private readonly FeatherManager _featherManager;
        private readonly MenuHandler _menu = new MenuHandler();
        private readonly SpellManager _spellManager;
        private readonly Menu _xayahMenu;

        public Draws(Menu xayahMenu, SpellManager spellManager, FeatherManager featherManager)
        {
            _xayahMenu = xayahMenu;
            _spellManager = spellManager;
            _featherManager = featherManager;

            //Draw menu
            _menu.AddSeparator(xayahMenu, "DRAW FUNCTIONS");
            _menu.AddSubMenu(xayahMenu, "Draw");
            var drawMenu = (Menu) xayahMenu.Item("Draw");
            _menu.AddCheckBox(drawMenu, new MenuCheckbox("q", "Draw Q range", true));
            _menu.AddCheckBox(drawMenu, new MenuCheckbox("r", "Draw R range", false));
            _menu.AddCheckBox(drawMenu, new MenuCheckbox("e", "Draw Feathers", true));

            Drawing.OnDraw += OnDraw;
        }

        private void OnDraw(EventArgs args)
        {
            if (_menu.GetValue<bool>((Menu) _xayahMenu.Item("Draw"), "q"))
                Drawing.DrawCircle(ObjectManager.Player.Position, _spellManager.Q.Range, Color.DarkGray, 2);
            if (_menu.GetValue<bool>((Menu) _xayahMenu.Item("Draw"), "r"))
                Drawing.DrawCircle(ObjectManager.Player.Position, _spellManager.R.Range, Color.DarkGray, 2);
            if (_menu.GetValue<bool>((Menu) _xayahMenu.Item("Draw"), "e"))
                foreach (var feather in _featherManager.Feathers)
                    if (feather != null)
                        Drawing.DrawCircle(feather.Position, 60, Color.DarkGray, 2);
        }
    }
}