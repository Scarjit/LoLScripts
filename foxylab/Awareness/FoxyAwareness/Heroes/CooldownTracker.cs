using System;
using HesaEngine.SDK;
using HesaEngine.SDK.Data;
using HesaEngine.SDK.Enums;
using SharpDX;

namespace FoxyAwareness.Heroes
{
    internal class CooldownTracker
    {
        private readonly Menu _Mainmenu;
        private readonly Menu _menu;
        private readonly MenuHandler _menuhandler = new MenuHandler();
        private readonly ColorBGRA blue = new ColorBGRA(0, 0, 255, 255);
        private readonly ColorBGRA red = new ColorBGRA(255, 0, 0, 255);

        private readonly ColorBGRA white = new ColorBGRA(255, 255, 255, 255);

        public CooldownTracker(Menu menu)
        {
            _Mainmenu = menu;
            _menu = menu.AddSubMenu("Cooldown Tracker");
            _menuhandler.AddCheckBox(_menu, new MenuCheckbox("allys", "Display Ally cooldowns"));


            Drawing.OnDraw += OnDraw;
        }

        private void OnDraw(EventArgs args)
        {
            if (!_menuhandler.GetValue<bool>((Menu) _Mainmenu.Item("Global Switches"), "cooldown_tracker"))
                return;

            foreach (var client in ObjectManager.Heroes.All)
                if (client.Team == ObjectManager.Me.Team && _menuhandler.GetValue<bool>(_menu, "allys") ||
                    client.Team != ObjectManager.Me.Team)
                {
                    var spell_Q = client.GetSpell(SpellSlot.Q);
                    var spell_W = client.GetSpell(SpellSlot.W);
                    var spell_E = client.GetSpell(SpellSlot.E);
                    var spell_R = client.GetSpell(SpellSlot.R);

                    Drawing.DrawText(20, 20, white, "Cooldown: " + spell_Q.State);
                    Drawing.DrawText(20, 40, white, "Cooldown: " + GetCooldown(spell_Q));

                    Drawing.DrawText(220, 20, white, "Cooldown: " + spell_W.State);
                    Drawing.DrawText(220, 40, white, "Cooldown: " + GetCooldown(spell_W));

                    Drawing.DrawText(420, 20, white, "Cooldown: " + spell_E.State);
                    Drawing.DrawText(420, 40, white, "Cooldown: " + GetCooldown(spell_E));

                    Drawing.DrawText(620, 20, white, "Cooldown: " + spell_R.State);
                    Drawing.DrawText(620, 40, white, "Cooldown: " + GetCooldown(spell_R));

                    var hpBarPosition = client.HPBarPosition;
                    var hpBarXOffset = client.HPBarXOffset;
                    var hpBarYOffset = client.HPBarYOffset;

                    var realPos = new Vector2(hpBarPosition.X + hpBarXOffset, hpBarPosition.Y + hpBarYOffset);
                    Drawing.DrawText(realPos, white,
                        hpBarXOffset + " : " + hpBarYOffset + " : (" + hpBarPosition + ") (" +
                        client.Position.WorldToScreen() + ")");
                    //TODO Wait for Hesa to fix
                }
        }


        private double GetCooldown(SpellDataInst ce)
        {
            return Math.Max(Math.Floor(ce.CooldownExpires - Game.Time) + 1, 0);
        }
    }
}