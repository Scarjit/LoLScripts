using System.Linq;
using HesaEngine.SDK;
using HesaEngine.SDK.GameObjects;

namespace FoxyAshe
{
    internal class Harass
    {
        private readonly MenuHandler _menu = new MenuHandler();
        private readonly Menu menu;
        private readonly Orbwalker.OrbwalkerInstance orbwalkerInstance;
        private readonly AIHeroClient Player = ObjectManager.Player;
        private readonly SpellManager spellM;

        public Harass(Menu asheMenu, Orbwalker.OrbwalkerInstance asheOrbWalk, SpellManager spellManager)
        {
            menu = asheMenu;
            orbwalkerInstance = asheOrbWalk;
            spellM = spellManager;

            //Harras Menu
            _menu.AddSubMenu(asheMenu, "Harras");
            _menu.AddCheckBox((Menu) asheMenu.Item("Harras"), new MenuCheckbox("q", "Use Q", true));
            _menu.AddCheckBox((Menu) asheMenu.Item("Harras"), new MenuCheckbox("w", "Use W", true));
            _menu.AddSlider((Menu) asheMenu.Item("Harras"), new MenuSlider("minWHS", "Min W HitChance", 1, 3, 3));
            _menu.AddCheckBox((Menu) asheMenu.Item("Harras"), new MenuCheckbox("e", "Use E", true));
            _menu.AddSlider((Menu) asheMenu.Item("Harras"),
                new MenuSlider("maxEAllyRange", "Max E Ally Range", 1, 2500, 1500));
            _menu.AddSlider((Menu) asheMenu.Item("Harras"),
                new MenuSlider("harrasMana", "% Mana for harras", 0, 100, 50));

            Game.OnTick += OnTick;
            AdvCallbacks.OnVisionChanged += AdvCallbacksOnVisionChanged;
        }

        private void AdvCallbacksOnVisionChanged(bool gained, AIHeroClient whom)
        {
            ConsiderE(gained, whom);
        }

        private void ConsiderE(bool gained, AIHeroClient whom)
        {
            if (!_menu.GetValue<bool>((Menu) menu.Item("Harras"), "e"))
                return;


            if (spellM.E.IsReady() && !gained && whom.Team != Player.Team)
                if (ObjectManager.Heroes.Allies.Any(x => x.Distance(whom.Position) <
                                                         _menu.GetValue<int>((Menu) menu.Item("Harras"),
                                                             "maxEAllyRange")))
                    spellM.E.Cast(whom.ServerPosition);
        }

        private void OnTick()
        {
            if (Player.IsDead)
                return;

            if ( /*orbwalkerInstance.ActiveMode != Orbwalker.OrbwalkingMode.Harass*/
                orbwalkerInstance.ActiveMode.ToString() != "Harass" || Utils.IsWindingUp()
            ) //Fix until Hesa fixes his Enums
                return;


            if (Player.ManaPercent < _menu.GetValue<int>((Menu) menu.Item("Harras"), "harrasMana"))
                return;

            var target = TargetSelector.GetTarget(spellM.W.Range, TargetSelector.DamageType.Physical, false);

            ConsiderQ(target);
            ConsiderW(target);
        }


        private void ConsiderW(AIHeroClient target)
        {
            if (!_menu.GetValue<bool>((Menu) menu.Item("Harras"), "w") || target == null)
                return;

            if (spellM.W.IsReady() && !Player.IsWindingUp && !Orbwalker.CanAttack() &&
                target.Distance3D(Player) < Player.AttackRange)
            {
                var wPred = spellM.W.GetPrediction(target);
                var reqHS = HitChance.High;
                switch (_menu.GetValue<int>((Menu) menu.Item("Harras"), "minWHS"))
                {
                    case 1:
                        reqHS = HitChance.Low;
                        break;
                    case 2:
                        reqHS = HitChance.Medium;
                        break;
                    case 3:
                        reqHS = HitChance.High;
                        break;
                }

                if (wPred != null && wPred.Hitchance >= reqHS)
                    spellM.W.Cast(wPred.CastPosition);
            }
        }

        private void ConsiderQ(AIHeroClient target)
        {
            if (!_menu.GetValue<bool>((Menu) menu.Item("Harras"), "q") || target == null)
                return;

            if (spellM.Q.IsReady() && !Player.IsWindingUp && !Orbwalker.CanAttack())
                spellM.Q.Cast();
        }
    }
}