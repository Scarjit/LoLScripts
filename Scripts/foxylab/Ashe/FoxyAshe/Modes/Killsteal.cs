using System.Linq;
using HesaEngine.SDK;
using HesaEngine.SDK.GameObjects;

namespace FoxyAshe.Modes
{
    internal class Killsteal
    {
        private readonly MenuHandler _menu = new MenuHandler();
        private readonly Menu menu;
        private readonly SpellManager spellM;

        public Killsteal(Menu asheMenu, SpellManager spellManager)
        {
            spellM = spellManager;
            menu = asheMenu;

            //Auto menu
            _menu.AddSeparator(asheMenu, "AUTO FUNCTIONS");
            _menu.AddSubMenu(asheMenu, "Killsteal");
            _menu.AddCheckBox((Menu) asheMenu.Item("Killsteal"), new MenuCheckbox("w", "Use W", true));
            _menu.AddCheckBox((Menu) asheMenu.Item("Killsteal"), new MenuCheckbox("r", "Use R", true));

            Game.OnTick += OnTick;
        }

        private AIHeroClient Player => ObjectManager.Player;

        private void OnTick()
        {
            AutoW();
            AutoR();
        }

        private void AutoR()
        {
            if (!spellM.R.IsReady() || !_menu.GetValue<bool>((Menu) menu.Item("Killsteal"), "r"))
                return;

            var targets = ObjectManager.Heroes.Enemies.Where(x => !Utils.IsInvul(x))
                .Where(x => x.Health < spellM.GetRealDamage(spellM.R, x))
                .Where(x => spellM.R.GetPrediction(x).Hitchance >= HitChance.High).ToList();

            if (targets.Count >= 1)
                spellM.R.Cast(targets.First().Position);
        }

        private void AutoW()
        {
            if (!spellM.W.IsReady() || !_menu.GetValue<bool>((Menu) menu.Item("Killsteal"), "w"))
                return;

            var targets = ObjectManager.Heroes.Enemies.Where(x => !Utils.IsInvul(x))
                .Where(x => x.Health < spellM.GetRealDamage(spellM.W, x))
                .Where(x => x.Distance3D(Player) < spellM.W.Range)
                .Where(x => spellM.W.GetPrediction(x).Hitchance >= HitChance.High).ToList();

            switch (targets.Count)
            {
                case 0:
                    return;
                case 1:
                    spellM.W.Cast(targets.First().Position);
                    break;
                default:
                    var MEC = Utils.MECFromObjAIBaseList(targets.Cast<Obj_AI_Base>().ToList());
                    spellM.W.Cast(MEC.Center);
                    break;
            }
        }
    }
}