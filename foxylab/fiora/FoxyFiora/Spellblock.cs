using HesaEngine.SDK;
using HesaEngine.SDK.Data;
using HesaEngine.SDK.GameObjects;

namespace FoxyFiora
{
    public class Spellblock
    {
        private Menu _menu;
        private MenuHandler _menuHandler;
        private SpellManager _spellManager;
        private AIHeroClient _player;
        public Spellblock(Menu menu, MenuHandler menuHandler, SpellManager spellManager)
        {
            _menu = menu;
            _menuHandler = menuHandler;
            _spellManager = spellManager;

            _player = ObjectManager.Me;
            _menuHandler.AddSubMenu(_menu, "Spellblock");
            _menuHandler.AddCheckBox((Menu)_menu.Item("Spellblock"), new MenuCheckbox("w", "Use W", true));

            foreach (AIHeroClient aiHeroClient in ObjectManager.Heroes.Enemies)
            {
                _menuHandler.AddSubMenu((Menu)_menu.Item("Spellblock"), aiHeroClient.ChampionName);

                foreach (SpellDataInst spellDataInst in aiHeroClient.Spells)
                {
                    _menuHandler.AddCheckBox((Menu)((Menu)_menu.Item("Spellblock")).Item(aiHeroClient.ChampionName), new MenuCheckbox(spellDataInst.ToString(), spellDataInst.ToString()));
                }
            }
            
            
        }
    }
}