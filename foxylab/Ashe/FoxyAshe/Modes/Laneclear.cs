using System.Collections.Generic;
using System.Linq;
using HesaEngine.SDK;
using HesaEngine.SDK.GameObjects;

namespace FoxyAshe.Modes
{
    internal class Laneclear
    {
        private readonly MenuHandler _menu = new MenuHandler();
        private readonly Menu menu;
        private readonly Orbwalker.OrbwalkerInstance orbwalkerInstance;
        private readonly AIHeroClient Player = ObjectManager.Player;
        private readonly SpellManager spellM;

        public Laneclear(Menu asheMenu, Orbwalker.OrbwalkerInstance asheOrbWalk, SpellManager spellManager)
        {
            menu = asheMenu;
            orbwalkerInstance = asheOrbWalk;
            spellM = spellManager;

            //Farm menu
            _menu.AddSeparator(menu, "FARM FUNCTIONS");
            //Clear Menu
            _menu.AddSubMenu(menu, "Clear");
            _menu.AddCheckBox((Menu) menu.Item("Clear"), new MenuCheckbox("q", "Use Q", true));
            _menu.AddSlider((Menu) menu.Item("Clear"),
                new MenuSlider("minQ", "Min Minions for Q", 1, 5, 1));
            _menu.AddCheckBox((Menu) menu.Item("Clear"), new MenuCheckbox("w", "Use W", true));
            _menu.AddSlider((Menu) menu.Item("Clear"),
                new MenuSlider("minW", "Min Minions for W", 3, 10, 3));
            _menu.AddSlider((Menu) menu.Item("Clear"),
                new MenuSlider("maxWRange", "Max W Detection Range", 0, int.Parse(spellM.W.Range.ToString()),
                    int.Parse(spellM.W.Range.ToString()) / 2));
            _menu.AddSlider((Menu) menu.Item("Clear"),
                new MenuSlider("clearMana", "% Mana for harras", 0, 100, 50));
            //JClear Menu
            _menu.AddSubMenu(menu, "JClear");
            _menu.AddCheckBox((Menu) menu.Item("JClear"), new MenuCheckbox("q", "Use Q", true));
            _menu.AddSlider((Menu) menu.Item("JClear"),
                new MenuSlider("minQ", "Min Minions for Q", 1, 5, 1));
            _menu.AddCheckBox((Menu) menu.Item("JClear"), new MenuCheckbox("w", "Use W", true));
            _menu.AddSlider((Menu) menu.Item("JClear"),
                new MenuSlider("minW", "Min Minions for W", 3, 10, 3));
            _menu.AddSlider((Menu) menu.Item("JClear"),
                new MenuSlider("maxWRange", "Max W Detection Range", 0, int.Parse(spellM.W.Range.ToString()),
                    int.Parse(spellM.W.Range.ToString()) / 2));
            _menu.AddSlider((Menu) menu.Item("JClear"),
                new MenuSlider("clearMana", "% Mana for harras", 0, 100, 50));

            Game.OnTick += OnTick;
        }

        private void OnTick()
        {
            if (Player.IsDead)
                return;

            if ( /*orbwalkerInstance.ActiveMode == Orbwalker.OrbwalkingMode.LaneClear*/
                orbwalkerInstance.ActiveMode.ToString() == "LaneClear" &&
                !Utils.IsWindingUp()) //Fix till Hesa fixes his stuff
            {
                if (Player.ManaPercent < _menu.GetValue<int>((Menu) menu.Item("Clear"), "clearMana"))
                    return;


                if (_menu.GetValue<bool>((Menu) menu.Item("Clear"), "q"))
                    ConsiderQCast(Utils.GetNearbyMinions(Player.AttackRange),
                        _menu.GetValue<int>((Menu) menu.Item("Clear"), "minQ"));
                if (_menu.GetValue<bool>((Menu) menu.Item("Clear"), "w"))
                    ConsiderWCast(Utils.GetNearbyMinions(spellM.W.Range),
                        _menu.GetValue<int>((Menu) menu.Item("Clear"), "minW"),
                        _menu.GetValue<int>((Menu) menu.Item("Clear"), "maxWRange"));
            }

            if (orbwalkerInstance.ActiveMode != Orbwalker.OrbwalkingMode.JungleClear || Utils.IsWindingUp()) return;
            if (Player.ManaPercent < _menu.GetValue<int>((Menu) menu.Item("JClear"), "clearMana"))
                return;

            if (_menu.GetValue<bool>((Menu) menu.Item("JClear"), "q"))
                ConsiderQCast(Utils.GetNearbyJungleMinions(Player.AttackRange),
                    _menu.GetValue<int>((Menu) menu.Item("JClear"), "minQ"));
            if (_menu.GetValue<bool>((Menu) menu.Item("JClear"), "w"))
                ConsiderWCast(Utils.GetNearbyJungleMinions(spellM.W.Range),
                    _menu.GetValue<int>((Menu) menu.Item("JClear"), "minW"),
                    _menu.GetValue<int>((Menu) menu.Item("JClear"), "maxWRange"));
        }

        private void ConsiderQCast(List<Obj_AI_Minion> targets, int min)
        {
            if (spellM.Q.IsReady() && targets.Count >= min)
                spellM.Q.Cast();
        }

        private void ConsiderWCast(List<Obj_AI_Minion> targets, int min, float wrange)
        {
            var Ntargets = targets.Where(x => x.Distance3D(Player) <= wrange).ToList();
            if (spellM.W.IsReady() && Ntargets.Count >= min)
            {
                var mec = Utils.MECFromObjAIBaseList(Ntargets.Cast<Obj_AI_Base>().ToList());
                if (Player.Distance(mec.Center) < spellM.W.Range)
                    spellM.W.Cast(mec.Center);
            }
        }
    }
}