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
    class AutoHeal
    {
        SpellManager spm;
        MenuHandler _menuhandler = new MenuHandler();
        Menu _menu;
        Orbwalker.OrbwalkerInstance orb;
        public AutoHeal(Menu m, SpellManager spm_instance, Orbwalker.OrbwalkerInstance orb_instance)
        {
            _menu = m;
            spm = spm_instance;
            orb = orb_instance;

            _menuhandler.AddSubMenu(_menu, "AutoHeal");


            _menuhandler.AddCheckBox((Menu)_menu.Item("AutoHeal"), new MenuCheckbox("w", "Use W", true));
            _menuhandler.AddSlider((Menu)_menu.Item("AutoHeal"), new MenuSlider("minManaQ", "Min Q Mana", 0, 100, 25));
            _menuhandler.AddSlider((Menu)_menu.Item("AutoHeal"), new MenuSlider("minHealthQ", "Min Q Health", 0, 100, 10));


            _menuhandler.AddCheckBox((Menu)_menu.Item("AutoHeal"), new MenuCheckbox("r", "Use R", true));
            _menuhandler.AddSlider((Menu)_menu.Item("AutoHeal"), new MenuSlider("minManaR", "Min R Mana", 0, 100, 25));
            _menuhandler.AddSlider((Menu)_menu.Item("AutoHeal"), new MenuSlider("maxAllyHealthPR", "Max Ally Health Percentage", 0, 100, 25));


            Game.OnTick += OnTick;
        }

        private void OnTick()
        {
            CastW();
            CastR();
        }

        int last_announce = Game.GameTimeTickCount;
        private void CastR()
        {

            if (!_menuhandler.GetValue<bool>((Menu)_menu.Item("AutoHeal"), "r"))
            {
                return;
            }

            if (_menuhandler.GetValue<int>((Menu)_menu.Item("AutoHeal"), "minManaR") > ObjectManager.Me.ManaPercent)
            {
                return;
            }

            if (!spm.R.IsReady())
            {
                return;
            }

            foreach (var ally in ObjectManager.Heroes.Allies)
            {
                if (ally != null && ally.IsValid() && !ally.IsDead && !ally.InFountain() && ally != ObjectManager.Me)
                {
                    if(ally.HealthPercent < _menuhandler.GetValue<int>((Menu)_menu.Item("AutoHeal"), "maxAllyHealthPR"))
                    {
                        spm.R.Cast();
                        if (last_announce + 10 < Game.GameTimeTickCount)
                        {
                            Chat.Print("Casted Heal for " + ally.ChampionName);
                            last_announce = Game.GameTimeTickCount;
                        }
                    }
                }
            }
        }

        private void CastW()
        {
            if (!_menuhandler.GetValue<bool>((Menu)_menu.Item("AutoHeal"), "w"))
            {
                return;
            }

            if (_menuhandler.GetValue<int>((Menu)_menu.Item("AutoHeal"), "minManaQ") > ObjectManager.Me.ManaPercent || _menuhandler.GetValue<int>((Menu)_menu.Item("AutoHeal"), "minHealthQ") >  ObjectManager.Me.HealthPercent)
            {
                return;
            }

            if (!spm.W.IsReady())
            {
                return;
            }
            AIHeroClient bestAlly = null;
            var heal = (spm.W.Level * 30 + 50) + (ObjectManager.Me.BaseAbilityDamage + ObjectManager.Me.BonusAbilityPower) * 0.6;

            foreach (var ally in ObjectManager.Heroes.Allies)
            {
                if(ally != null && ally.IsValid() && !ally.IsDead && ally.Distance3D(ObjectManager.Me) < spm.W.Range && ! ally.InFountain() && ally != ObjectManager.Me)
                {

                    if (heal < ally.MaxHealth - ally.Health)
                    {
                        if(bestAlly == null || ally.HealthPercent < bestAlly.HealthPercent)
                        {
                            bestAlly = ally;
                        }
                    }
                }
            }

            if(bestAlly != null)
            {
                spm.W.Cast(bestAlly);
            }
        }
    }
}
