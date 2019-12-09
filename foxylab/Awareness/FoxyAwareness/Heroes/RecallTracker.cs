using HesaEngine.SDK;
using HesaEngine.SDK.GameObjects;

namespace FoxyAwareness.Heroes
{
    internal class RecallTracker
    {
        private readonly Menu _Mainmenu;
        private readonly Menu _menu;
        private readonly MenuHandler _menuhandler = new MenuHandler();

        public RecallTracker(Menu menu)
        {
            _Mainmenu = menu;
            _menu = menu.AddSubMenu("Recall Tracker");
            AdvCallbacks.OnRecall += OnRecall;
        }


        private void OnRecall(AIHeroClient whom, bool isRecalling)
        {
            if (!_menuhandler.GetValue<bool>((Menu) _Mainmenu.Item("Global Switches"), "recall_tracker"))
                return;
#if DEBUG
            if (true)
#else
            if(whom.Team != ObjectManager.Me.Team)
#endif
                if (isRecalling)
                    Chat.Print(whom.ChampionName + " is recalling");
                else
                    Chat.Print(whom.ChampionName + " stoped recalling");
        }
    }
}