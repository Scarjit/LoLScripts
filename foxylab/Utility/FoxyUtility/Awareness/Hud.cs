using HesaEngine.SDK;
using System;
using System.Collections.Generic;
using HesaEngine.SDK.GameObjects;

namespace FoxyUtility.Awareness {
    internal class Hud {
        private readonly Menu _awarenessMenu;
        private readonly MenuHandler _menu = new MenuHandler();
        private List<AIHeroClient> enemies = ObjectManager.Heroes.Enemies;

        public Hud(Menu hudMenu) {
            Drawing.OnDraw += OnDraw;
        }

        private void OnDraw(EventArgs args) {
            foreach (AIHeroClient enemy in enemies) {
                Utils.PrintChat(enemy.Name);
            }
        }
    }
}
