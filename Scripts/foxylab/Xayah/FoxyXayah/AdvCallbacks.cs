using System;
using System.Collections.Generic;
using HesaEngine.SDK;
using HesaEngine.SDK.Args;
using HesaEngine.SDK.GameObjects;
using GameObjectProcessSpellCastEventArgs = HesaEngine.SDK.Data.GameObjectProcessSpellCastEventArgs;

namespace FoxyXayah
{
    public delegate void OnVisionChanced(bool visible, AIHeroClient whom);

    public delegate void OnAttackAnimation(Obj_AI_Base obj, string name);

    public delegate void OnAttack(Obj_AI_Base sender, GameObjectProcessSpellCastEventArgs args);

    public delegate void OnProcessAttack(AttackableUnit unit, AttackableUnit target);

    public delegate void OnProcessSpell(Obj_AI_Base sender,
        HesaEngine.SDK.Args.GameObjectProcessSpellCastEventArgs args);

    internal static class AdvCallbacks
    {
        private static readonly List<Tuple<AIHeroClient, bool>> VisionHeroesTuple =
            new List<Tuple<AIHeroClient, bool>>();

        private static readonly MenuHandler _menu = new MenuHandler();
        private static Menu xayahMenu;
        public static event OnVisionChanced OnVisionChanged;
        public static event OnAttackAnimation OnAttackAnimation;
        public static event OnAttack OnBasicAttack;
        public static event OnProcessAttack OnProcessAttack;
        public static event OnProcessSpell OnProcessSpell;

        public static void Init(Menu xayahMenu)
        {
            InitVision();
            Obj_AI_Base.OnPlayAnimation += OnAnim;
            Obj_AI_Base.OnBasicAttack += OnAttack;
            Orbwalker.AfterAttack += AfterAttack;
            Obj_AI_Base.OnProcessSpellCast += OnProcessSpellCast;
            Game.OnTick += OnTick;

#if DEBUG
            SubscriberTest(xayahMenu); //Only included in debug Builds
#endif
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
        private static void SubscriberTest(Menu xayahMenu)
        {
            AdvCallbacks.xayahMenu = xayahMenu;
            _menu.AddSeparator(xayahMenu, "AdvCallback [DEBUG ONLY]");
            _menu.AddSubMenu(xayahMenu, "AdvCallbacks");

            _menu.AddCheckBox((Menu) xayahMenu.Item("AdvCallbacks"),
                new MenuCheckbox("OnAttackAnimation", "OnAttackAnimation", false));
            _menu.AddCheckBox((Menu) xayahMenu.Item("AdvCallbacks"),
                new MenuCheckbox("OnBasicAttack", "OnBasicAttack", false));
            _menu.AddCheckBox((Menu) xayahMenu.Item("AdvCallbacks"),
                new MenuCheckbox("OnProcessAttack", "OnProcessAttack", false));
            _menu.AddCheckBox((Menu) xayahMenu.Item("AdvCallbacks"),
                new MenuCheckbox("OnProcessSpell", "OnProcessSpell", false));
            _menu.AddCheckBox((Menu) xayahMenu.Item("AdvCallbacks"),
                new MenuCheckbox("OnVisionChanged", "OnVisionChanged", false));

            Logger.Log("Subscribing to AdvCallbacks");
            OnAttackAnimation += OnOnAttackAnimation;
            OnBasicAttack += OnOnBasicAttack;
            OnProcessAttack += OnOnProcessAttack;
            OnProcessSpell += OnOnProcessSpell;
            OnVisionChanged += OnOnVisionChanged;
        }

        private static void OnOnVisionChanged(bool visible, AIHeroClient whom)
        {
            if (_menu.GetValue<bool>((Menu) xayahMenu.Item("AdvCallbacks"), "OnVisionChanged"))
                Logger.Log("VisionChanged: " + whom + " => " + visible);
        }

        private static void OnOnProcessSpell(Obj_AI_Base sender,
            HesaEngine.SDK.Args.GameObjectProcessSpellCastEventArgs args)
        {
            if (_menu.GetValue<bool>((Menu) xayahMenu.Item("AdvCallbacks"), "OnProcessSpell"))
                Logger.Log("ProcessSpell: " + sender + " => " + args);
        }

        private static void OnOnProcessAttack(AttackableUnit unit, AttackableUnit target)
        {
            if (_menu.GetValue<bool>((Menu) xayahMenu.Item("AdvCallbacks"), "OnProcessAttack"))
                Logger.Log("ProcessAttack: " + unit + " => " + target);
        }

        private static void OnOnBasicAttack(Obj_AI_Base sender, GameObjectProcessSpellCastEventArgs args)
        {
            if (_menu.GetValue<bool>((Menu) xayahMenu.Item("AdvCallbacks"), "OnBasicAttack"))
                Logger.Log("BasicAttack: " + sender + " => " + args);
        }

        private static void OnOnAttackAnimation(Obj_AI_Base objAiBase, string name)
        {
            if (_menu.GetValue<bool>((Menu) xayahMenu.Item("AdvCallbacks"), "OnAttackAnimation"))
                Logger.Log("AttackAnimation: " + objAiBase + " => " + name);
        }
#endif
    }
}