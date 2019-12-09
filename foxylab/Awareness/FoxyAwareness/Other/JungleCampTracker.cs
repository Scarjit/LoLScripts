using System;
using System.Collections.Generic;
using HesaEngine.SDK;
using HesaEngine.SDK.Args;
using HesaEngine.SDK.GameObjects;
using SharpDX;

namespace FoxyAwareness.Other
{
    internal class JungleCampTracker
    {
        private readonly Menu _Mainmenu;
        private readonly Menu _menu;
        private readonly MenuHandler _menuhandler = new MenuHandler();

        private readonly ColorBGRA deep_red = new ColorBGRA(128, 0, 0, 255);

        private readonly List<string> jungleMobNames = new List<string>
        {
            "SRU_Krug",
            "SRU_Red",
            "SRU_Razorbreak",
            "SRU_Blue",
            "SRU_Gromp",
            "SRU_Murkwolf"
        };

        private readonly Dictionary<int, float> last_attack = new Dictionary<int, float>();

        public JungleCampTracker(Menu menu)
        {
            _Mainmenu = menu;
            _menu = menu.AddSubMenu("Jungle Camp Tracker");
            foreach (var jungleMobName in jungleMobNames)
                _menuhandler.AddCheckBox(_menu, new MenuCheckbox(jungleMobName, "Track " + jungleMobName.Substring(4)));


            Obj_AI_Base.OnPlayAnimation += OnAnimation;
            Drawing.OnEndScene += OnDraw;
        }

        private void OnDraw(EventArgs args)
        {
            foreach (var keyValuePair in last_attack)
                if (Game.Time - keyValuePair.Value < 10)
                {
                    var unit = ObjectManager.GetUnitByNetworkId<Obj_AI_Base>(keyValuePair.Key);
                    if (unit != null && unit.IsValid())
                    {
                        Drawing.DrawCircle(unit.Position, 80, deep_red, 3);
                        Drawing.DrawText(unit.Position.WorldToScreen(), deep_red, unit.Name + " is under attack");
                    }
                }
        }

        private void OnAnimation(Obj_AI_Base obj, GameObjectPlayAnimationEventArgs args)
        {
            if (args.Animation.Contains("Spell") || args.Animation.Contains("Run") ||
                args.Animation.Contains("Death") || args.Animation.Contains("Attack"))
                foreach (var jungleMobName in jungleMobNames)
                    if (_menuhandler.GetValue<bool>(_menu, jungleMobName) && obj.Name.Contains(jungleMobName))
                        last_attack[obj.NetworkId] = Game.Time;
        }
    }
}