using System.Linq;
using HesaEngine.SDK;
using HesaEngine.SDK.Args;
using HesaEngine.SDK.GameObjects;

namespace FoxyAshe
{
    internal class Combo
    {
        public static int lastAA;
        public static bool CanAttack = true;
        private readonly Menu _comboMenu;
        private readonly MenuHandler _menu = new MenuHandler();
        private readonly Menu _menuInstance;
        private readonly Orbwalker.OrbwalkerInstance _orbwalkerInstance;
        private readonly SpellManager _spellManager;
        private readonly ItemHandler _items = new ItemHandler();

        public Combo(Menu asheMenu, Orbwalker.OrbwalkerInstance asheOrbWalk, SpellManager spellManager)
        {
            //Init
            _orbwalkerInstance = asheOrbWalk;
            _spellManager = spellManager;
            _menuInstance = asheMenu;
            lastAA = 0;

            //Combo Menu
            _menu.AddSubMenu(asheMenu, "Combo");
            _comboMenu = (Menu) asheMenu.Item("Combo");
            _menu.AddCheckBox(_comboMenu, new MenuCheckbox("q", "Use Q", true));
            _menu.AddCheckBox(_comboMenu, new MenuCheckbox("w", "Use W", true));
            _menu.AddCheckBox(_comboMenu, new MenuCheckbox("e", "Use E", true));
            _menu.AddSlider(_comboMenu, new MenuSlider("maxEAllyRange", "Max E Ally Range", 1, 2500, 1500));
            _menu.AddCheckBox(_comboMenu, new MenuCheckbox("r", "Use R", true));

            _menu.AddSeparator(_comboMenu, "[R] CAST SETTINGS");
            _menu.AddSubMenu(_comboMenu, "Whitelist");
            _menu.AddSubMenu(_comboMenu, "Forcecast");
            var targetsForR = ObjectManager.Heroes.Enemies;
            foreach (var enemy in targetsForR)
            {
                var name = enemy.ChampionName;
                var isTank = Utils.champList["Tank"].Any(name.Contains);
                _menu.AddCheckBox((Menu) _comboMenu.Item("Whitelist"),
                    new MenuCheckbox("" + name, "Use R on " + name, !isTank));
                _menu.AddCheckBox((Menu) _comboMenu.Item("Forcecast"),
                    new MenuCheckbox("" + name, "Force R on " + name, false));
            }

            _menu.AddSeparator(_comboMenu, "ITEM USAGE");
            _menu.AddCheckBox(_comboMenu, new MenuCheckbox("botrk", "Use BOTRK", true));
            _menu.AddCheckBox(_comboMenu, new MenuCheckbox("cutlass", "Use Bilgewater Cutlass", true));
            _menu.AddCheckBox(_comboMenu, new MenuCheckbox("gunblade", "Use Hextech Gunblade", true));
            _menu.AddCheckBox(_comboMenu, new MenuCheckbox("youmu", "Use Youmu's Blade", true));

            //Misc
            Game.OnTick += OnTick;
            AdvCallbacks.OnAttackAnimation += OnAttackAnimation;
            AdvCallbacks.OnProcessAttack += OnAfterAttack;
            AdvCallbacks.OnProcessSpell += OnProcessSpellCast;
            AdvCallbacks.OnVisionChanged += AdvCallbacksOnVisionChanged;
        }

        private void AdvCallbacksOnVisionChanged(bool gained, AIHeroClient whom)
        {
            ConsiderE(gained, whom);
        }

        private void ConsiderE(bool gained, AIHeroClient whom)
        {
            if (!_menu.GetValue<bool>(_comboMenu, "e"))
                return;


            if (!_spellManager.E.IsReady() || gained || whom.Team == Player.Team) return;
            if (ObjectManager.Heroes.Allies.Any(x => x.Distance(whom.Position) <
                                                     _menu.GetValue<int>(_comboMenu,
                                                         "maxEAllyRange")))
                _spellManager.E.Cast(whom.ServerPosition);
        }

        private static AIHeroClient Player => ObjectManager.Player;

        private static void OnProcessSpellCast(Obj_AI_Base sender, GameObjectProcessSpellCastEventArgs args)
        {
            if (sender.IsMe && args?.SData?.Name != null && args.SData.Name.Equals("AsheQ"))
            {
                Orbwalker.ResetAutoAttackTimer();
                CanAttack = true;
            }
        }

        private static void OnAfterAttack(AttackableUnit source, AttackableUnit target)
        {
            if (!source.IsMe) return;
            CanAttack = false;
            Utility.DelayAction((int) (1f / (Player.AttackSpeedMod * 0.658f) * 1000f), () => { CanAttack = true; });
        }

        private static void OnAttackAnimation(Obj_AI_Base objAiBase, string name)
        {
            if (!objAiBase.IsMe) return;
            lastAA = HesaEngine.SDK.Utils.TickCount;
        }

        public void OnTick()
        {
            if (_orbwalkerInstance.ActiveMode != Orbwalker.OrbwalkingMode.Combo)
                return;

            var target = TargetSelector.GetTarget(_spellManager.W.Range, TargetSelector.DamageType.Physical,
                false);
            if (target == null || !target.IsValidTarget() || Utils.IsInvul(target)) return;

            if (Player.Distance(target) <= Utils.GetRealRange(target))
            {
                ItemCast(target);

                // Q Handle
                if (_menu.GetValue<bool>((Menu) _menuInstance.Item("Combo"), "q") && Utils.IsReset() &&
                    _spellManager.Q.IsReady())
                    _spellManager.Q.Cast(Player);
            }

            // W handle
            if (_menu.GetValue<bool>((Menu) _menuInstance.Item("Combo"), "w") &&
                (Utils.IsReset() || Player.Distance(target) >= Utils.GetRealRange(target)) &&
                _spellManager.W.IsReady())
            {
                var wPred = _spellManager.W.GetPrediction(target);
                if (wPred != null && wPred.Hitchance >= HitChance.High)
                    _spellManager.W.Cast(wPred.CastPosition);
            }

            // R handle
            if (target.Distance(Player) > 1200) return;
            if (!_menu.GetValue<bool>((Menu) _menuInstance.Item("Combo"), "r") || Utils.IsReset() ||
                !_menu.GetValue<bool>((Menu) _comboMenu.Item("Forcecast"), target.ChampionName) &&
                (!_menu.GetValue<bool>((Menu) _comboMenu.Item("Whitelist"), target.ChampionName) ||
                 !(AsheGetComboDamage(target) >= target.Health) &&
                 (!(target.HealthPercent <= 40) || Player.CountAlliesInRange(1200f) < 1)) ||
                !_spellManager.R.IsReady() || !(target.Distance(Player) >= Utils.GetRealRange(target)) &&
                (!(target.Distance(Player) < Utils.GetRealRange(target)) ||
                 !(Player.GetAutoAttackDamage(target) * 2f < target.Health))) return;

            var rPred = _spellManager.R.GetPrediction(target);
            if (rPred != null && rPred.Hitchance >= HitChance.High)
                _spellManager.R.Cast(rPred.CastPosition);
        }

        public float AsheGetComboDamage(AIHeroClient target)
        {
            var damage = 0f;

            damage = Player.CritChancePercent >= 55f
                ? (float) Player.GetAutoAttackDamage(target) * 5f
                : (float) Player.GetAutoAttackDamage(target) * 3f;

            if (_spellManager.W.IsReady())
                damage += _spellManager.GetRealDamage(_spellManager.W, target);

            if (_spellManager.R.IsReady())
                damage += _spellManager.GetRealDamage(_spellManager.R, target);

            return damage;
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
    }
}