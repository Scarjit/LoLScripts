using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HesaEngine.SDK;
using HesaEngine.SDK.GameObjects;
using System.Collections;
using SharpDX;

namespace FoxySoraka.Modes
{
    class Harass
    {
        SpellManager spm;
        MenuHandler _menuhandler = new MenuHandler();
        Menu _menu;
        Orbwalker.OrbwalkerInstance orb;
        public Harass(Menu m, SpellManager spm_instance, Orbwalker.OrbwalkerInstance orb_instance)
        {
            _menu = m;
            spm = spm_instance;
            orb = orb_instance;

            _menuhandler.AddSubMenu(_menu, "Harass");


            _menuhandler.AddCheckBox((Menu)_menu.Item("Harass"), new MenuCheckbox("q", "Use Q", true));
            _menuhandler.AddSlider((Menu)_menu.Item("Harass"), new MenuSlider("minQHs", "Min Q Hitchance", 1, 3, 3));


            _menuhandler.AddCheckBox((Menu)_menu.Item("Harass"), new MenuCheckbox("e", "Use E", true));
            _menuhandler.AddSlider((Menu)_menu.Item("Harass"), new MenuSlider("minEHs", "Min W Hitchance", 1, 3, 3));


            Game.OnTick += OnTick;
        }

        private void OnTick()
        {
            if (orb.ActiveMode != Orbwalker.OrbwalkingMode.Harass)
            {
                return;
            }

            CastQ();
            CastE();
        }
        private void CastE()
        {

            if (!_menuhandler.GetValue<bool>((Menu)_menu.Item("Harass"), "e"))
            {
                return;
            }

            if (!spm.E.IsReady())
            {
                return;
            }

            var reqHs = HitChance.High;
            switch (_menuhandler.GetValue<int>((Menu)_menu.Item("Harass"), "minEHs"))
            {
                case 1:
                    reqHs = HitChance.Low;
                    break;
                case 2:
                    reqHs = HitChance.Medium;
                    break;
                case 3:
                    reqHs = HitChance.High;
                    break;
            }

            var enemies = EnemiesInRange(spm.E.Range, reqHs, spm.E);

            AIHeroClient best = null;
            PredictionOutput bestPred = null;
            foreach (var item in enemies)
            {
                if (bestPred == null || item.Value.Hitchance > bestPred.Hitchance)
                {
                    best = item.Key;
                    bestPred = item.Value;
                }
            }

            if (best != null)
            {
                spm.E.Cast(bestPred.CastPosition);
            }
        }

        private Dictionary<AIHeroClient, PredictionOutput> EnemiesInRange(float range, HitChance minHS, Spell sp)
        {
            Dictionary<AIHeroClient, PredictionOutput> enemies = new Dictionary<AIHeroClient, PredictionOutput>();
            foreach (var e in ObjectManager.Heroes.Enemies)
            {
                if (e != null && e.IsValid() && e.IsVisible && !e.IsDead && e.Distance3D(ObjectManager.Me) <= range)
                {
                    var pred = sp.GetPrediction(e);
                    if (pred.Hitchance > minHS)
                    {
                        enemies.Add(e, pred);
                    }
                }
            }
            return enemies;
        }

        private void CastQ()
        {
            if (!_menuhandler.GetValue<bool>((Menu)_menu.Item("Harass"), "q"))
            {
                return;
            }

            if (!spm.Q.IsReady())
            {
                return;
            }

            var reqHs = HitChance.High;
            switch (_menuhandler.GetValue<int>((Menu)_menu.Item("Harass"), "minQHs"))
            {
                case 1:
                    reqHs = HitChance.Low;
                    break;
                case 2:
                    reqHs = HitChance.Medium;
                    break;
                case 3:
                    reqHs = HitChance.High;
                    break;
            }

            var enemies = EnemiesInRange(spm.Q.Range, reqHs, spm.Q);

            AIHeroClient best = null;
            PredictionOutput bestPred = null;
            foreach (var item in enemies)
            {
                if (bestPred == null || item.Value.Hitchance > bestPred.Hitchance)
                {
                    best = item.Key;
                    bestPred = item.Value;
                }
            }

            if (best != null)
            {
                spm.Q.Cast(bestPred.CastPosition);
            }
        }
    }
}
