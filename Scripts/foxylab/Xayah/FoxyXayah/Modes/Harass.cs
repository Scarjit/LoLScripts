using System;
using System.Linq;
using HesaEngine.SDK;
using HesaEngine.SDK.GameObjects;

namespace FoxyXayah.Modes
{
    internal class Harass
    {
        private readonly FeatherManager _featherManager;
        private readonly MenuHandler _menu = new MenuHandler();
        private readonly Menu _menuInstance;
        private readonly Orbwalker.OrbwalkerInstance _orbwalkerInstance;
        private readonly SpellManager _spellManager;
        private readonly AIHeroClient Player = ObjectManager.Player;

        public Harass(Menu xayahMenu, Orbwalker.OrbwalkerInstance xayahOrbWalk, SpellManager spellManager,
            FeatherManager featherManager)
        {
            //Init
            _orbwalkerInstance = xayahOrbWalk;
            _spellManager = spellManager;
            _menuInstance = xayahMenu;
            _featherManager = featherManager;

            //Harras Menu
            _menu.AddSubMenu(_menuInstance, "Harras");
            _menu.AddCheckBox((Menu) _menuInstance.Item("Harras"), new MenuCheckbox("useQ", "Use Q", true));
            _menu.AddSlider((Menu) _menuInstance.Item("Harras"), new MenuSlider("minQHS", "Min Q HitChance", 1, 3, 2));
            _menu.AddCheckBox((Menu) _menuInstance.Item("Harras"), new MenuCheckbox("useW", "Use W", true));
            _menu.AddSlider((Menu) _menuInstance.Item("Harras"), new MenuSlider("minW", "Min #Enemies for W", 1, 5, 2));
            _menu.AddCheckBox((Menu) _menuInstance.Item("Harras"), new MenuCheckbox("useE", "Use E", true));
            _menu.AddSlider((Menu) _menuInstance.Item("Harras"), new MenuSlider("minE", "Min E Hits", 1, 5, 3));
            _menu.AddCheckBox((Menu) _menuInstance.Item("Harras"),
                new MenuCheckbox("overrideEifStun", "Always use, if enemy will be rooted", true));
            _menu.AddSlider((Menu) _menuInstance.Item("Harras"),
                new MenuSlider("clearMana", "% Mana for Harras", 0, 100, 25));

            Game.OnTick += OnTick;
        }

        private void OnTick()
        {
            if (_orbwalkerInstance.ActiveMode != Orbwalker.OrbwalkingMode.Harass &&
                _orbwalkerInstance.ActiveMode.ToString() != "Harass" || Player.IsWindingUp)
                return;

            if (Player.ManaPercent < _menu.GetValue<int>((Menu) _menuInstance.Item("Harras"), "clearMana"))
                return;

            if (_menu.GetValue<bool>((Menu) _menuInstance.Item("Harras"), "useQ") && _spellManager.Q.IsReady())
                ConsiderQ();

            if (_menu.GetValue<bool>((Menu) _menuInstance.Item("Harras"), "useW") && _spellManager.W.IsReady())
                ConsiderW();

            if (_menu.GetValue<bool>((Menu) _menuInstance.Item("Harras"), "useE") && _spellManager.E.IsReady())
                ConsiderE();
        }

        private void ConsiderQ()
        {
            var orbtarget = _orbwalkerInstance.GetTarget();
            if (orbtarget == null)
                return;


            var target = Utils.ObjAiBaseFromAny(orbtarget);
            if (target == null || Utils.IsInvul(Utils.AIHeroClientFromAny(orbtarget)))
                return;


            var QPred = _spellManager.Q.GetPrediction(target);
            var reqHS = HitChance.High;
            switch (_menu.GetValue<int>((Menu) _menuInstance.Item("Harras"), "minQHS"))
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


            if (QPred.Hitchance >= reqHS)
                _spellManager.Q.Cast(QPred.CastPosition);
        }

        private void ConsiderW()
        {
            if (ObjectManager.Heroes.Enemies.Where(x => !Utils.IsInvul(x))
                    .Count(x => x.Distance3D(Player) < Player.AttackRange) >=
                _menu.GetValue<int>((Menu) _menuInstance.Item("Harras"), "minW"))
                _spellManager.W.Cast();
        }

        private void ConsiderE()
        {
            var hits = 0;
            var advHits = 0;
            foreach (var target in ObjectManager.Heroes.Enemies)
                if (!Utils.IsInvul(target))
                {
                    var lHits = (from Obj_AI_Minion feather in _featherManager.Feathers
                            select Math.Abs((feather.Position.Z - Player.Position.Z) * target.Position.X -
                                            (feather.Position.X - Player.Position.X) * target.Position.Z +
                                            feather.Position.X * Player.Position.Z -
                                            feather.Position.Z * Player.Position.X) /
                                   Math.Sqrt((feather.Position.Z - Player.Position.Z) *
                                             (feather.Position.Z - Player.Position.Z) +
                                             (feather.Position.X - Player.Position.X) *
                                             (feather.Position.X - Player.Position.X)))
                        .Count(pVab => pVab < target.BoundingRadius + _spellManager.E.Width / 2);
                    hits += lHits;
                    if (lHits > 3)
                        advHits++;
                }


            if (hits >= _menu.GetValue<int>((Menu) _menuInstance.Item("Harras"), "minE") || advHits >= 1 &&
                _menu.GetValue<bool>((Menu) _menuInstance.Item("Harras"), "overrideEifStun"))
                _spellManager.E.Cast();
        }
    }
}