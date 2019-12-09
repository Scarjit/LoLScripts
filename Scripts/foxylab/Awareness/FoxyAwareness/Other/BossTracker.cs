using System;
using HesaEngine.SDK;
using HesaEngine.SDK.Args;
using HesaEngine.SDK.GameObjects;
using SharpDX;

namespace FoxyAwareness.Other
{
    internal class BossTracker
    {
        private readonly Menu _mainmenu;
        private readonly Menu _menu;
        private readonly MenuHandler _menuhandler = new MenuHandler();

        private readonly Vector3 _baronPos = new Vector3(5007.124f, 24.39014f, 10471.45f);
        private readonly int baron_respawn_time = 420;

        private readonly int barons_spawn_time = 1200;
        private readonly ColorBGRA _deepGreen = new ColorBGRA(0, 128, 0, 255);
        private readonly ColorBGRA _deepRed = new ColorBGRA(128, 0, 0, 255);
        private readonly int dragon_respawn_time = 360;
        private readonly int dragon_spawn_time = 150;
        private readonly Vector3 _drakePos = new Vector3(9866.148f, -69.7511f, 4414.014f);
        private readonly int rift_herald_spawn_time = 600;

        private readonly ColorBGRA _white = new ColorBGRA(255, 255, 255, 255);

        private Obj_AI_Base _baronInstance;

        private float _baronUnderAttack;
        private Obj_AI_Base _dragonInstance;
        private float _dragonUnderAttack;
        private Obj_AI_Base _heraldInstance;
        private bool _heraldIsKilled;
        private float _heraldUnderAttack;

        private int _lastBaronKill;
        private int _lastDrakeKill;

        public BossTracker(Menu menu)
        {
            _mainmenu = menu;
            _menu = menu.AddSubMenu("Boss Tracker");
            _menuhandler.AddSlider(_menu, new MenuSlider("time", "Min Time to display (sec)", 0, 120, 600));
            _menuhandler.AddCheckBox(_menu, new MenuCheckbox("baron", "Track Baron", true));
            _menuhandler.AddCheckBox(_menu, new MenuCheckbox("dragon", "Track Dragon", true));
            _menuhandler.AddCheckBox(_menu, new MenuCheckbox("herald", "Track Herald", true));

            _menuhandler.AddCheckBox(_menu, new MenuCheckbox("attack_warnings", "Show Attack Warnings", true));

            Drawing.OnEndScene += OnDraw;

            GameObject.OnCreate += OnCreateObj;

            Obj_AI_Base.OnPlayAnimation += OnAnimation;

            Game.OnTick += OnTick;
        }

        private void OnTick()
        {
            if (Game.Time > 1173)
                _heraldIsKilled = true;
        }

        private void OnAnimation(Obj_AI_Base objAiBase, GameObjectPlayAnimationEventArgs args)
        {
#if DEBUG
            /*
            if (objAiBase != null && !objAiBase.Name.Contains("Minion") && !objAiBase.Name.Contains("Plant") &&
                !objAiBase.Name.Contains("Turret") && !objAiBase.Name.Contains("Crab") && !objAiBase.IsMe)
                Console.WriteLine(objAiBase.Name + " => " + objAiBase.ObjectType + " @ " + objAiBase.Position +
                                  " Anim: " + args.Animation);
                                  */
#endif

            if (args.Animation.Contains("Spell") || args.Animation.Contains("Run") ||
                args.Animation.Contains("Death") || args.Animation.Contains("Attack"))
            {
                if (objAiBase.Name.Contains("SRU_Dragon"))
                {
                    _dragonUnderAttack = (int) Math.Round(Game.Time);
                    _dragonInstance = objAiBase;
                }

                if (objAiBase.Name.Contains("SRU_Baron"))
                {
                    _baronUnderAttack = (int) Math.Round(Game.Time);
                    _baronInstance = objAiBase;
                }

                if (objAiBase.Name.Contains("SRU_RiftHerald"))
                {
                    _heraldUnderAttack = (int) Math.Round(Game.Time);
                    _heraldInstance = objAiBase;
                }
            }

            if (args.Animation.Contains("Death"))
            {
                if (objAiBase.Name.Contains("SRU_Dragon"))
                    _lastDrakeKill = (int) Math.Round(Game.Time);

                if (objAiBase.Name.Contains("SRU_Baron"))
                    _lastBaronKill = (int) Math.Round(Game.Time);
            }
        }

        private void OnCreateObj(GameObject sender, EventArgs args)
        {
#if DEBUG
            if (sender != null && sender.IsValid() && sender.Distance(ObjectManager.Player.Position) < 2500 &&
                !sender.Name.Contains("missile"))
                Console.WriteLine(sender.Name + " => " + sender.ObjectType + " @ " + sender.Position);
#endif


            if (sender != null && sender.IsValid())
            {
                if (sender.Name.Contains("SRU_Baron")) //Set Cooldown to 0
                    _lastBaronKill = 0;

                if (sender.Name.Contains("SRU_Dragon")) //Set Cooldown to 0
                    _lastDrakeKill = 0;


                if (sender.Name.Contains("CampRespawn")) //Check which one //FALLBACK FOR ANIMATIONS
                {
                    var pos = sender.Position;
                    if (pos == _baronPos)
                        _lastBaronKill = (int) Math.Round(Game.Time);
                    else if (pos == _drakePos)
                        _lastDrakeKill = (int) Math.Round(Game.Time);
                }
            }
        }

        private void OnDraw(EventArgs args)
        {
            if (!_menuhandler.GetValue<bool>((Menu) _mainmenu.Item("Global Switches"), "bosscooldown_tracker"))
                return;

            DrawTimer();
            DrawAttackWarning();
        }

        private void DrawAttackWarning()
        {
            if (!_menuhandler.GetValue<bool>(_menu, "attack_warnings"))
                return;

            if (Game.Time - _baronUnderAttack < 10)
            {
                Drawing.DrawText(150, 20, _deepRed,
                    "Baron is under Attack !");

                Drawing.DrawCircle(_baronInstance.Position, 80, _deepRed, 3);
                Drawing.DrawText(_baronInstance.Position.WorldToScreen(), _deepRed,
                    _baronInstance.Name + " is under attack");
            }

            if (Game.Time - _dragonUnderAttack < 10)
            {
                Drawing.DrawText(150, 40, _deepRed,
                    "Dragon is under Attack !");

                Drawing.DrawCircle(_dragonInstance.Position, 80, _deepRed, 3);
                Drawing.DrawText(_dragonInstance.Position.WorldToScreen(), _deepRed,
                    _dragonInstance.Name + " is under attack");
            }

            if (Game.Time - _heraldUnderAttack < 10)
            {
                Drawing.DrawText(150, 60, _deepRed,
                    "Herald is under Attack !");

                Drawing.DrawCircle(_heraldInstance.Position, 80, _deepRed, 3);
                Drawing.DrawText(_heraldInstance.Position.WorldToScreen(), _deepRed,
                    _heraldInstance.Name + " is under attack");
            }
        }

        private void DrawTimer()
        {
            var next_baron =
                Math.Max((_lastBaronKill == 0 ? barons_spawn_time : _lastBaronKill + baron_respawn_time) - Game.Time,
                    0);
            var next_baron_formated = TimeSpan.FromSeconds(next_baron);

            var next_dragon =
                Math.Max((_lastDrakeKill == 0 ? dragon_spawn_time : _lastDrakeKill + dragon_respawn_time) - Game.Time,
                    0);
            var next_dragon_formated = TimeSpan.FromSeconds(next_dragon);

            var herald = Math.Max(rift_herald_spawn_time - Game.Time, 0);
            var herald_formated = TimeSpan.FromSeconds(herald);

            var i = 20;
            if (_menuhandler.GetValue<bool>(_menu, "baron") && next_baron < _menuhandler.GetValue<int>(_menu, "time"))
            {
                if (next_baron == 0)
                    Drawing.DrawText(20, i, _deepGreen,
                        "Baron is up !");
                else
                    Drawing.DrawText(20, i, _white,
                        "Next Baron: " + next_baron_formated.Minutes + ":" + next_baron_formated.Seconds);
                i += 20;
            }
            if (_menuhandler.GetValue<bool>(_menu, "dragon") && next_dragon < _menuhandler.GetValue<int>(_menu, "time"))
            {
                if (next_dragon == 0)
                    Drawing.DrawText(20, i, _deepGreen,
                        "Dragon is up !");
                else
                    Drawing.DrawText(20, i, _white,
                        "Next Dragon: " + next_dragon_formated.Minutes + ":" + next_dragon_formated.Seconds);
                i += 20;
            }
            if (_menuhandler.GetValue<bool>(_menu, "herald") && herald < _menuhandler.GetValue<int>(_menu, "time") &&
                !_heraldIsKilled)
                if (herald == 0)
                {
                    Drawing.DrawText(20, i, _deepGreen,
                        "Herald is up !");
                }
                else
                {
                    Drawing.DrawText(20, i, _white,
                        "Next Herald: " + herald_formated.Minutes + ":" + herald_formated.Seconds);
                    i += 20;
                }
        }
    }
}