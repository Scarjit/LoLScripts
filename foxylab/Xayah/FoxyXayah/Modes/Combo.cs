using System;
using System.Linq;
using HesaEngine.SDK;
using HesaEngine.SDK.GameObjects;

namespace FoxyXayah.Modes
{
    internal class Combo
    {
        private readonly FeatherManager _featherManager;
        private readonly MenuHandler _menu = new MenuHandler();
        private readonly Menu _menuInstance;
        private readonly Orbwalker.OrbwalkerInstance _orbwalkerInstance;
        private readonly SpellManager _spellManager;
        private readonly AIHeroClient Player = ObjectManager.Player;
        private readonly Menu _comboMenu;
        private readonly ItemHandler _items = new ItemHandler();

        public Combo(Menu xayahMenu, Orbwalker.OrbwalkerInstance xayahOrbWalk, SpellManager spellManager,
            FeatherManager featherManager)
        {
            //Init
            _orbwalkerInstance = xayahOrbWalk;
            _spellManager = spellManager;
            _menuInstance = xayahMenu;
            _featherManager = featherManager;

            //Combo Menu
            _menu.AddSubMenu(_menuInstance, "Combo");
            _comboMenu = (Menu) _menuInstance.Item("Combo");
            _menu.AddCheckBox(_comboMenu, new MenuCheckbox("useQ", "Use Q", true));
            _menu.AddSlider(_comboMenu, new MenuSlider("minQHS", "Min Q HitChance", 1, 3, 2));
            _menu.AddCheckBox(_comboMenu, new MenuCheckbox("useW", "Use W", true));
            _menu.AddSlider(_comboMenu, new MenuSlider("minW", "Min #Enemies for W", 1, 5, 1));
            _menu.AddCheckBox(_comboMenu, new MenuCheckbox("useE", "Use E", true));
            _menu.AddSlider(_comboMenu, new MenuSlider("minE", "Min E Hits", 1, 5, 1));
            _menu.AddCheckBox(_comboMenu,
                new MenuCheckbox("overrideEifStun", "Always use, if enemy will be rooted", true));

            //R Options
            _menu.AddCheckBox(_comboMenu, new MenuCheckbox("useR", "Use R aggressively", true));
            _menu.AddCheckBox(_comboMenu,
                new MenuCheckbox("onlykill", "Only use R, if enemy is Killable", false));
            _menu.AddSlider(_comboMenu,
                new MenuSlider("minRAgressiveHS", "Min R HitChance (Agressive)", 1, 3, 2));
            _menu.AddSlider(_comboMenu,
                new MenuSlider("alwaysR", "Always use, if X can be hit", 1, ObjectManager.Heroes.Enemies.Count+1, 3));

            //Items
            _menu.AddSeparator(_comboMenu, "ITEM USAGE");
            _menu.AddCheckBox(_comboMenu, new MenuCheckbox("botrk", "Use BOTRK", true));
            _menu.AddCheckBox(_comboMenu, new MenuCheckbox("cutlass", "Use Bilgewater Cutlass", true));
            _menu.AddCheckBox(_comboMenu, new MenuCheckbox("gunblade", "Use Hextech Gunblade", true));
            _menu.AddCheckBox(_comboMenu, new MenuCheckbox("youmu", "Use Youmu's Blade", true));

            Game.OnTick += OnTick;
        }

        private void OnTick()
        {
            if (_orbwalkerInstance.ActiveMode != Orbwalker.OrbwalkingMode.Combo &&
                _orbwalkerInstance.ActiveMode.ToString() != "Combo" || Player.IsWindingUp)
                return;

            var target = TargetSelector.GetTarget(Player, _spellManager.Q.Range, TargetSelector.DamageType.Physical);
            if (target == null || Utils.IsInvul(target)) return;

            ItemCast(target);

            //Combo start
            var lHits = 0;

            //Handle E
            if (_menu.GetValue<bool>(_comboMenu, "useE") && _spellManager.E.IsReady())
            {
                var count = _featherManager.Feathers
                    .Select(feather => Math.Abs((feather.Position.Z - Player.Position.Z) * target.Position.X -
                                                (feather.Position.X - Player.Position.X) * target.Position.Z +
                                                feather.Position.X * Player.Position.Z -
                                                feather.Position.Z * Player.Position.X) /
                                       Math.Sqrt((feather.Position.Z - Player.Position.Z) *
                                                 (feather.Position.Z - Player.Position.Z) +
                                                 (feather.Position.X - Player.Position.X) *
                                                 (feather.Position.X - Player.Position.X)))
                    .Count(pVab => (int) pVab <= target.BoundingRadius + _spellManager.E.Width / 2);
                lHits += count;

                if (lHits >= 3 || _spellManager.GetEDamage(target, lHits) >= target.Health)
                {
                    _spellManager.E.Cast();
                }
            }

            //Handle Q
            if (_menu.GetValue<bool>(_comboMenu, "useQ") && _spellManager.Q.IsReady())
            {
                if (!(Player.Distance(target) <= Utils.GetRealRange(target)))
                {
                    if (!_menu.GetValue<bool>(_comboMenu, "useE") || !_spellManager.E.IsReady() || lHits < 1) return;
                    CastQ(target);
                }
                else
                {
                    CastQ(target);
                }
            }

            //Handle W
            if (_menu.GetValue<bool>(_comboMenu, "useW") && _spellManager.W.IsReady() &&
                Player.Distance(target) <= Utils.GetRealRange(target))
                _spellManager.W.Cast(Player);

            //Handle R
            if (_menu.GetValue<bool>(_comboMenu, "useR") && _spellManager.R.IsReady())
            {
                if (GetComboDamage(target, lHits + 3) >= target.Health * 0.8f)
                {
                    CastR(target);
                }
            }

            if (!_menu.GetValue<bool>(_comboMenu, "onlykill") || !_spellManager.R.IsReady()) return;
            if (GetComboDamage(target, lHits + 3) >= target.Health)
            {
                CastR(target);
            }


            if (_menu.GetValue<int>(_comboMenu, "alwaysR") <= ObjectManager.Heroes.Enemies.Count)
            {
                var mec = Utils.MECFromObjAIBaseList(ObjectManager.Heroes.Enemies.Where(x => x.Distance3D(Player) < _spellManager.R.Range).Where(x => _spellManager.R.GetPrediction(x,true).Hitchance >= HitChance.Medium).Cast<Obj_AI_Base>().ToList());
                _spellManager.R.Cast(mec.Center);
            }
        }

        private void ItemCast(Obj_AI_Base target)
        {
            if (_menu.GetValue<bool>((Menu) _menuInstance.Item("Combo"), "botrk"))
                _items.CastBOTRK(target);
            if (_menu.GetValue<bool>((Menu) _menuInstance.Item("Combo"), "cutlass"))
                _items.CastCutlass(target);
            if (_menu.GetValue<bool>((Menu) _menuInstance.Item("Combo"), "gunblade"))
                _items.CastGunblade(target);
            if (_menu.GetValue<bool>((Menu) _menuInstance.Item("Combo"), "youmu"))
                _items.CastYoumu();
        }


        private int GetComboDamage(Obj_AI_Base target, int eHits)
        {
            var dmg = (int) Player.GetAutoAttackDamage(target) * 3;
            if (_spellManager.Q.IsReady())
                dmg += (int) _spellManager.GetQDamage(target);
            if (_spellManager.E.IsReady())
                dmg += (int) _spellManager.GetEDamage(target, eHits);
            if (_spellManager.R.IsReady())
                dmg += (int) _spellManager.GetRDamage((AIHeroClient) target);

            return dmg;
        }

        private void CastQ(AIHeroClient target)
        {
            var qPred = _spellManager.Q.GetPrediction(target);
            if (qPred != null && qPred.Hitchance >= HitChance.High)
                _spellManager.Q.Cast(qPred.CastPosition);
        }

        private void CastR(AIHeroClient target)
        {
            var rPred = _spellManager.R.GetPrediction(target);
            if (rPred != null && rPred.Hitchance >= HitChance.Medium)
                _spellManager.R.Cast(rPred.CastPosition);
        }
    }
}