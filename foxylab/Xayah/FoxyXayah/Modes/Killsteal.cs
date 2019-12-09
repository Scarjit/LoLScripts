using System;
using System.Linq;
using HesaEngine.SDK;
using HesaEngine.SDK.GameObjects;

namespace FoxyXayah.Modes
{
    internal class Killsteal
    {
        private readonly FeatherManager _featherManager;
        private readonly MenuHandler _menu = new MenuHandler();
        private readonly Menu _menuInstance;
        private readonly SpellManager _spellManager;
        private readonly AIHeroClient Player = ObjectManager.Player;

        public Killsteal(Menu xayahMenu, SpellManager spellManager, FeatherManager featherManager)
        {
            //Init
            _spellManager = spellManager;
            _menuInstance = xayahMenu;
            _featherManager = featherManager;

            //Auto menu
            _menu.AddSeparator(_menuInstance, "AUTO FUNCTIONS");
            _menu.AddSubMenu(_menuInstance, "Killsteal");
            _menu.AddCheckBox((Menu) _menuInstance.Item("Killsteal"), new MenuCheckbox("useQ", "Use Q", true));
            _menu.AddCheckBox((Menu) _menuInstance.Item("Killsteal"), new MenuCheckbox("useE", "Use E", true));

            Game.OnTick += OnTick;
        }

        private void OnTick()
        {
            if (_menu.GetValue<bool>((Menu) _menuInstance.Item("Killsteal"), "useQ") && _spellManager.Q.IsReady())
                ConsiderQ();
            if (_menu.GetValue<bool>((Menu) _menuInstance.Item("Killsteal"), "useE") && _spellManager.Q.IsReady())
                ConsiderE();
        }

        private void ConsiderE()
        {
            foreach (var target in ObjectManager.Heroes.Enemies)
                if (!Utils.IsInvul(target))
                {
                    var lHits = _featherManager.Feathers
                        .Select(feather => Math.Abs((feather.Position.Z - Player.Position.Z) * target.Position.X -
                                                    (feather.Position.X - Player.Position.X) * target.Position.Z +
                                                    feather.Position.X * Player.Position.Z -
                                                    feather.Position.Z * Player.Position.X) /
                                           Math.Sqrt((feather.Position.Z - Player.Position.Z) *
                                                     (feather.Position.Z - Player.Position.Z) +
                                                     (feather.Position.X - Player.Position.X) *
                                                     (feather.Position.X - Player.Position.X)))
                        .Count(pVab => pVab < target.BoundingRadius + _spellManager.E.Width / 2);

                    var dmg = _spellManager.GetEDamage(target, lHits);
                    if (dmg > target.Health)
                        _spellManager.E.Cast();
                }
        }

        private void ConsiderQ()
        {
            foreach (var aiHeroClient in ObjectManager.Heroes.Enemies)
                if (aiHeroClient != null && aiHeroClient.IsValid() && !Utils.IsInvul(aiHeroClient) &&
                    aiHeroClient.Distance3D(Player) < _spellManager.Q.Range &&
                    _spellManager.GetRealDamage2(_spellManager.GetQDamage(aiHeroClient), aiHeroClient) >
                    aiHeroClient.Health)
                {
                    var QPred = _spellManager.Q.GetPrediction(aiHeroClient);
                    if (QPred.Hitchance >= HitChance.High)
                        _spellManager.Q.Cast(QPred.CastPosition);
                }
        }
    }
}