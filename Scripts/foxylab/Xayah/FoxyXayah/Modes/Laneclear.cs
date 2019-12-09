using System;
using System.Collections.Generic;
using System.Linq;
using HesaEngine.SDK;
using HesaEngine.SDK.GameObjects;

namespace FoxyXayah.Modes
{
    internal class Laneclear
    {
        private readonly MenuHandler _menu = new MenuHandler();
        private readonly Menu _menuInstance;
        private readonly Orbwalker.OrbwalkerInstance _orbwalkerInstance;
        private readonly SpellManager _spellManager;
        private readonly AIHeroClient Player = ObjectManager.Player;
        private readonly FeatherManager _featherManager;

        public Laneclear(Menu xayahMenu, Orbwalker.OrbwalkerInstance xayahOrbWalk, SpellManager spellManager,
            FeatherManager featherManager)
        {
            //Init
            _orbwalkerInstance = xayahOrbWalk;
            _spellManager = spellManager;
            _menuInstance = xayahMenu;
            _featherManager = featherManager;

            //Farm menu
            _menu.AddSeparator(_menuInstance, "FARM FUNCTIONS");
            //Clear Menu
            _menu.AddSubMenu(_menuInstance, "Clear");
            _menu.AddCheckBox((Menu) _menuInstance.Item("Clear"), new MenuCheckbox("useQ", "Use Q", true));
            _menu.AddCheckBox((Menu) _menuInstance.Item("Clear"), new MenuCheckbox("useW", "Use W", true));
            _menu.AddSlider((Menu) _menuInstance.Item("Clear"), new MenuSlider("minW", "Min #Minions for W", 1, 8, 4));
            _menu.AddCheckBox((Menu) _menuInstance.Item("Clear"), new MenuCheckbox("useE", "Use E", true));
            _menu.AddSlider((Menu) _menuInstance.Item("Clear"), new MenuSlider("minE", "Min E Hits", 0, 7, 3));
            _menu.AddSlider((Menu) _menuInstance.Item("Clear"),
                new MenuSlider("clearMana", "% Mana for Laneclear", 0, 100, 60));

            //JClear Menu
            _menu.AddSubMenu(_menuInstance, "JClear");
            _menu.AddCheckBox((Menu) _menuInstance.Item("JClear"), new MenuCheckbox("useQ", "Use Q", true));
            _menu.AddCheckBox((Menu) _menuInstance.Item("JClear"), new MenuCheckbox("useW", "Use W", true));
            _menu.AddSlider((Menu) _menuInstance.Item("JClear"), new MenuSlider("minW", "Min #Minions for W", 1, 7, 3));
            _menu.AddCheckBox((Menu) _menuInstance.Item("JClear"), new MenuCheckbox("useE", "Use E", true));
            _menu.AddSlider((Menu) _menuInstance.Item("JClear"), new MenuSlider("minE", "Min E Hits", 0, 7, 3));
            _menu.AddSlider((Menu) _menuInstance.Item("JClear"),
                new MenuSlider("clearMana", "% Mana for Jungleclear", 0, 100, 30));

            Game.OnTick += OnTick;
        }

        private void OnTick()
        {
            LaneClear();
            JungleClear();
        }

        private void JungleClear()
        {
            if (_orbwalkerInstance.ActiveMode.ToString() != "JungleClear" || Player.IsWindingUp)
                return;

            if (Player.ManaPercent < _menu.GetValue<int>((Menu) _menuInstance.Item("JClear"), "clearMana"))
                return;

            if (_menu.GetValue<bool>((Menu) _menuInstance.Item("JClear"), "useQ") && _spellManager.Q.IsReady())
                ConsiderQ(Utils.GetNearbyJungleMinions(_spellManager.Q.Range));

            if (_menu.GetValue<bool>((Menu) _menuInstance.Item("JClear"), "useW") && _spellManager.W.IsReady())
                ConsiderW(Utils.GetNearbyJungleMinions(_spellManager.W.Range));

            if (_menu.GetValue<bool>((Menu) _menuInstance.Item("JClear"), "useE") && _spellManager.E.IsReady())
                ConsiderE(Utils.GetNearbyJungleMinions(_spellManager.E.Range));
        }

        private void LaneClear()
        {
            if (_orbwalkerInstance.ActiveMode.ToString() != "LaneClear" || Player.IsWindingUp)
                return;

            if (Player.ManaPercent < _menu.GetValue<int>((Menu) _menuInstance.Item("Clear"), "clearMana"))
                return;

            if (_menu.GetValue<bool>((Menu) _menuInstance.Item("Clear"), "useQ") && _spellManager.Q.IsReady())
                ConsiderQ(Utils.GetNearbyMinions(_spellManager.Q.Range));

            if (_menu.GetValue<bool>((Menu) _menuInstance.Item("Clear"), "useW") && _spellManager.W.IsReady())
                ConsiderW(Utils.GetNearbyMinions(_spellManager.W.Range));

            if (_menu.GetValue<bool>((Menu) _menuInstance.Item("Clear"), "useE") && _spellManager.E.IsReady())
                ConsiderE(Utils.GetNearbyMinions(_spellManager.E.Range));
        }

        private void ConsiderE(List<Obj_AI_Minion> nearbyMinions)
        {
            var lHits = (from target in nearbyMinions
                from feather in _featherManager.Feathers
                let pVab =
                Math.Abs((feather.Position.Z - Player.Position.Z) * target.Position.X -
                         (feather.Position.X - Player.Position.X) * target.Position.Z +
                         feather.Position.X * Player.Position.Z - feather.Position.Z * Player.Position.X) /
                Math.Sqrt((feather.Position.Z - Player.Position.Z) * (feather.Position.Z - Player.Position.Z) +
                          (feather.Position.X - Player.Position.X) * (feather.Position.X - Player.Position.X))
                where pVab < target.BoundingRadius + _spellManager.E.Width / 2
                select target).Count();


            if (lHits > _menu.GetValue<int>((Menu) _menuInstance.Item("Clear"), "minE"))
                _spellManager.E.Cast();
        }

        private void ConsiderW(List<Obj_AI_Minion> nearbyMinions)
        {
            if (nearbyMinions.Count > _menu.GetValue<int>((Menu) _menuInstance.Item("Clear"), "minW"))
                _spellManager.W.Cast();
        }

        private void ConsiderQ(List<Obj_AI_Minion> nearbyMinions)
        {
            var targets = nearbyMinions.Where(x => _spellManager.GetQDamage(x) >= x.Health).ToList();
            if (targets.Count > 0)
                _spellManager.Q.Cast(targets.First());
        }
    }
}