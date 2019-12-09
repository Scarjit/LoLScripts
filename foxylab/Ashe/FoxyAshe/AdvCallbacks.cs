using System;
using System.Collections.Generic;
using HesaEngine.SDK;
using HesaEngine.SDK.Args;
using HesaEngine.SDK.GameObjects;

namespace FoxyAshe
{
    public delegate void OnVisionChanced(bool visible, AIHeroClient whom);

    public delegate void OnAttackAnimation(Obj_AI_Base obj, string name);

    public delegate void OnProcessAttack(AttackableUnit unit, AttackableUnit target);

    public delegate void OnProcessSpell(Obj_AI_Base sender,
        GameObjectProcessSpellCastEventArgs args);

    internal static class AdvCallbacks
    {
        public static event OnVisionChanced OnVisionChanged;
        public static event OnAttackAnimation OnAttackAnimation;
        public static event OnProcessAttack OnProcessAttack;
        public static event OnProcessSpell OnProcessSpell;

        private static readonly List<Tuple<AIHeroClient, bool>> VisionHeroesTuple =
            new List<Tuple<AIHeroClient, bool>>();

        private static MenuHandler _menu = new MenuHandler();
        private static Menu asheMenu;

        public static void Init(Menu asheMenu)
        {
            InitVision();
            Obj_AI_Base.OnPlayAnimation += OnAnim;
            Orbwalker.AfterAttack += AfterAttack;
            Obj_AI_Base.OnProcessSpellCast += OnProcessSpellCast;
            Game.OnTick += OnTick;

#if DEBUG
            SubscriberTest(asheMenu); //Only included in debug Builds
#endif
        }

        private static void OnProcessSpellCast(Obj_AI_Base sender, GameObjectProcessSpellCastEventArgs args)
        {
            if (sender == null) return;
            OnProcessSpell?.Invoke(sender, args);
        }


        private static void AfterAttack(AttackableUnit unit, AttackableUnit target)
        {
            if (unit != null && target != null)
                OnProcessAttack?.Invoke(unit, target);
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
        private static void SubscriberTest(Menu asheMenu)
        {
            AdvCallbacks.asheMenu = asheMenu;
            _menu.AddSeparator(asheMenu, "AdvCallback [DEBUG ONLY]");
            _menu.AddSubMenu(asheMenu, "AdvCallbacks");

            _menu.AddCheckBox((Menu) asheMenu.Item("AdvCallbacks"),
                new MenuCheckbox("OnAttackAnimation", "OnAttackAnimation", false));
            _menu.AddCheckBox((Menu) asheMenu.Item("AdvCallbacks"),
                new MenuCheckbox("OnProcessAttack", "OnProcessAttack", false));
            _menu.AddCheckBox((Menu) asheMenu.Item("AdvCallbacks"),
                new MenuCheckbox("OnProcessSpell", "OnProcessSpell", false));
            _menu.AddCheckBox((Menu) asheMenu.Item("AdvCallbacks"),
                new MenuCheckbox("OnVisionChanged", "OnVisionChanged", false));

            Logger.Log("Subscribing to AdvCallbacks");
            OnAttackAnimation += OnOnAttackAnimation;
            OnProcessAttack += OnOnProcessAttack;
            OnProcessSpell += OnOnProcessSpell;
            OnVisionChanged += OnOnVisionChanged;
        }

        private static void OnOnVisionChanged(bool visible, AIHeroClient whom)
        {
            if (_menu.GetValue<bool>((Menu) asheMenu.Item("AdvCallbacks"), "OnVisionChanged"))
            {
                Logger.Log("VisionChanged: " + whom + " => " + visible);
            }
        }

        private static void OnOnProcessSpell(Obj_AI_Base sender,
            HesaEngine.SDK.Args.GameObjectProcessSpellCastEventArgs args)
        {
            if (_menu.GetValue<bool>((Menu) asheMenu.Item("AdvCallbacks"), "OnProcessSpell"))
            {
                Logger.Log("ProcessSpell: " + sender + " => " + args);
            }
        }

        private static void OnOnProcessAttack(AttackableUnit unit, AttackableUnit target)
        {
            if (_menu.GetValue<bool>((Menu) asheMenu.Item("AdvCallbacks"), "OnProcessAttack"))
            {
                Logger.Log("ProcessAttack: " + unit + " => " + target);
            }
        }

        private static void OnOnAttackAnimation(Obj_AI_Base objAiBase, string name)
        {
            if (_menu.GetValue<bool>((Menu) asheMenu.Item("AdvCallbacks"), "OnAttackAnimation"))
            {
                Logger.Log("AttackAnimation: " + objAiBase + " => " + name);
            }
        }
#endif
    }
}