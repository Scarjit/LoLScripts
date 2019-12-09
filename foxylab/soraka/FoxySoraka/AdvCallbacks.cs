using System;
using System.Collections.Generic;
using HesaEngine.SDK;
using HesaEngine.SDK.Args;
using HesaEngine.SDK.GameObjects;
using GameObjectProcessSpellCastEventArgs = HesaEngine.SDK.Data.GameObjectProcessSpellCastEventArgs;

namespace FoxySoraka
{
    public delegate void OnVisionChanced(bool visible, AIHeroClient whom);

    public delegate void OnAttackAnimation(Obj_AI_Base obj, string name);

    public delegate void OnAttack(Obj_AI_Base sender, GameObjectProcessSpellCastEventArgs args);

    public delegate void OnProcessAttack(AttackableUnit unit, AttackableUnit target);

    public delegate void OnProcessSpell(Obj_AI_Base sender,
        HesaEngine.SDK.Args.GameObjectProcessSpellCastEventArgs args);

    public delegate void OnRecall(AIHeroClient whom, bool is_recalling);

    internal static class AdvCallbacks
    {
        private static readonly List<Tuple<AIHeroClient, bool>> VisionHeroesTuple =
            new List<Tuple<AIHeroClient, bool>>();

        private static readonly Dictionary<int, bool> isRecallingList = new Dictionary<int, bool>();

        private static readonly MenuHandler _menuHandler = new MenuHandler();
        private static Menu _menu;
        public static event OnVisionChanced OnVisionChanged;
        public static event OnAttackAnimation OnAttackAnimation;
        public static event OnAttack OnBasicAttack;
        public static event OnProcessAttack OnProcessAttack;
        public static event OnProcessSpell OnProcessSpell;
        public static event OnRecall OnRecall;

        public static void Init(Menu Menu)
        {
            InitVision();
            InitRecall();
            Obj_AI_Base.OnPlayAnimation += OnAnim;
            Obj_AI_Base.OnBasicAttack += OnAttack;
            Orbwalker.AfterAttack += AfterAttack;
            Obj_AI_Base.OnProcessSpellCast += OnProcessSpellCast;
            Game.OnTick += OnTick;

#if DEBUG
            SubscriberTest(Menu); //Only included in debug Builds
#endif
        }

        private static void InitRecall()
        {
#if DEBUG
            foreach (var aiHeroClient in ObjectManager.Heroes.All)
#else
            foreach (AIHeroClient aiHeroClient in ObjectManager.Heroes.Enemies)
#endif

                isRecallingList.Add(aiHeroClient.NetworkId, false);
        }

        private static void OnProcessSpellCast(Obj_AI_Base sender,
            HesaEngine.SDK.Args.GameObjectProcessSpellCastEventArgs args)
        {
            if (sender == null) return;
            OnProcessSpell?.Invoke(sender, args);
        }

        private static void AfterAttack(AttackableUnit unit, AttackableUnit target)
        {
            if (unit != null && target != null)
                OnProcessAttack?.Invoke(unit, target);
        }

        private static void OnAttack(Obj_AI_Base sender, GameObjectProcessSpellCastEventArgs args)
        {
            if (sender != null && args.Target != null)
                OnBasicAttack?.Invoke(sender, args);
        }

        private static void OnAnim(Obj_AI_Base obj, GameObjectPlayAnimationEventArgs args)
        {
            if (obj != null && args.Animation != null &&
                (args.Animation.Contains("Crit") || args.Animation.Contains("Attack")))
                OnAttackAnimation?.Invoke(obj, args.Animation);
        }

        private static void OnTick()
        {
            CheckVisionChanged();
            CheckRecall();
        }

        private static void CheckRecall()
        {
            foreach (var unit in ObjectManager.Heroes.All)
            {
                var is_recalling = false;
                foreach (var buffInstance in unit.Buffs)
                    if (buffInstance.DisplayName.ToLower().Contains("recall"))
                    {
                        is_recalling = true;
                        break;
                    }

                is_recalling = is_recalling || unit.IsRecalling();

                if (is_recalling != isRecallingList[unit.NetworkId])
                {
                    OnRecall?.Invoke(unit, is_recalling);
                    isRecallingList[unit.NetworkId] = is_recalling;
                    break;
                }
            }
        }


        private static void InitVision()
        {
            foreach (var aiHeroClient in ObjectManager.Heroes.All)
                VisionHeroesTuple.Add(new Tuple<AIHeroClient, bool>(aiHeroClient, aiHeroClient.IsVisible));
        }

        private static void CheckVisionChanged()
        {
            for (var i = 0; i < VisionHeroesTuple.Count; i++)
            {
                var tuple = VisionHeroesTuple[i];
                if (tuple.Item1.IsVisible != tuple.Item2)
                {
                    OnVisionChanged?.Invoke(tuple.Item1.IsVisible, tuple.Item1);
                    VisionHeroesTuple[i] = new Tuple<AIHeroClient, bool>(tuple.Item1, tuple.Item1.IsVisible);
                }
            }
        }

#if DEBUG //Test Subscriber to all Advanced Callbacks
        private static void SubscriberTest(Menu menu)
        {
            _menu = menu;
            _menuHandler.AddSeparator(menu, "AdvCallback [DEBUG ONLY]");
            _menuHandler.AddSubMenu(menu, "AdvCallbacks");

            _menuHandler.AddCheckBox((Menu) menu.Item("AdvCallbacks"),
                new MenuCheckbox("OnAttackAnimation", "OnAttackAnimation", false));
            _menuHandler.AddCheckBox((Menu) menu.Item("AdvCallbacks"),
                new MenuCheckbox("OnBasicAttack", "OnBasicAttack", false));
            _menuHandler.AddCheckBox((Menu) menu.Item("AdvCallbacks"),
                new MenuCheckbox("OnProcessAttack", "OnProcessAttack", false));
            _menuHandler.AddCheckBox((Menu) menu.Item("AdvCallbacks"),
                new MenuCheckbox("OnProcessSpell", "OnProcessSpell", false));
            _menuHandler.AddCheckBox((Menu) menu.Item("AdvCallbacks"),
                new MenuCheckbox("OnVisionChanged", "OnVisionChanged", false));

            _menuHandler.AddCheckBox((Menu) menu.Item("AdvCallbacks"),
                new MenuCheckbox("OnRecall", "OnRecall", false));

            Logger.Log("Subscribing to AdvCallbacks");
            OnAttackAnimation += OnOnAttackAnimation;
            OnBasicAttack += OnOnBasicAttack;
            OnProcessAttack += OnOnProcessAttack;
            OnProcessSpell += OnOnProcessSpell;
            OnVisionChanged += OnOnVisionChanged;
            OnRecall += OnOnRecall;
        }

        private static void OnOnRecall(AIHeroClient whom, bool isRecalling)
        {
            if (_menuHandler.GetValue<bool>((Menu) _menu.Item("AdvCallbacks"), "OnRecall"))
                Logger.Log("Recalling:" + whom + " => " + isRecalling);
        }

        private static void OnOnVisionChanged(bool visible, AIHeroClient whom)
        {
            if (_menuHandler.GetValue<bool>((Menu) _menu.Item("AdvCallbacks"), "OnVisionChanged"))
                Logger.Log("VisionChanged: " + whom + " => " + visible);
        }

        private static void OnOnProcessSpell(Obj_AI_Base sender,
            HesaEngine.SDK.Args.GameObjectProcessSpellCastEventArgs args)
        {
            if (_menuHandler.GetValue<bool>((Menu) _menu.Item("AdvCallbacks"), "OnProcessSpell"))
                Logger.Log("ProcessSpell: " + sender + " => " + args);
        }

        private static void OnOnProcessAttack(AttackableUnit unit, AttackableUnit target)
        {
            if (_menuHandler.GetValue<bool>((Menu) _menu.Item("AdvCallbacks"), "OnProcessAttack"))
                Logger.Log("ProcessAttack: " + unit + " => " + target);
        }

        private static void OnOnBasicAttack(Obj_AI_Base sender, GameObjectProcessSpellCastEventArgs args)
        {
            if (_menuHandler.GetValue<bool>((Menu) _menu.Item("AdvCallbacks"), "OnBasicAttack"))
                Logger.Log("BasicAttack: " + sender + " => " + args);
        }

        private static void OnOnAttackAnimation(Obj_AI_Base objAiBase, string name)
        {
            if (_menuHandler.GetValue<bool>((Menu) _menu.Item("AdvCallbacks"), "OnAttackAnimation"))
                Logger.Log("AttackAnimation: " + objAiBase + " => " + name);
        }
#endif
    }
}