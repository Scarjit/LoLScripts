using HesaEngine.SDK;
using HesaEngine.SDK.Args;
using HesaEngine.SDK.Enums;
using HesaEngine.SDK.GameObjects;

namespace FoxyXayah.Modes
{
    internal class AntiCC
    {
        private readonly MenuHandler _menu = new MenuHandler();
        private readonly ItemHandler _items = new ItemHandler();
        private readonly Menu _antiCCMenu;
        private readonly Menu _menuInstance;
        private readonly SpellManager _spellManager;


        public AntiCC(Menu xayahMenu, SpellManager spellManager)
        {
            //Init
            _menuInstance = xayahMenu;
            _spellManager = spellManager;

            //AntiCC menu
            _menu.AddSubMenu(_menuInstance, "AntiCC");
            _antiCCMenu = (Menu) _menuInstance.Item("AntiCC");
            _menu.AddSeparator(_antiCCMenu, "SPELLS TO USE");
            _menu.AddCheckBox(_antiCCMenu, new MenuCheckbox("cleanse", "Use Cleanse", true));
            _menu.AddSeparator(_antiCCMenu, "ITEMS TO USE");
            _menu.AddCheckBox(_antiCCMenu, new MenuCheckbox("qss", "Use QSS", true));
            _menu.AddCheckBox(_antiCCMenu, new MenuCheckbox("mercurial", "Use Mercurial", true));
            _menu.AddSeparator(_antiCCMenu, "BUFF TYPES");
            _menu.AddCheckBox(_antiCCMenu, new MenuCheckbox("stun", "on Stun", true));
            _menu.AddCheckBox(_antiCCMenu, new MenuCheckbox("silence", "on Silence", false));
            _menu.AddCheckBox(_antiCCMenu, new MenuCheckbox("taunt", "on Taunt", true));
            _menu.AddCheckBox(_antiCCMenu, new MenuCheckbox("polymorph", "on Polymorph", true));
            _menu.AddCheckBox(_antiCCMenu, new MenuCheckbox("snare", "on Snare", false));
            _menu.AddCheckBox(_antiCCMenu, new MenuCheckbox("sleep", "on Sleep", true));
            _menu.AddCheckBox(_antiCCMenu, new MenuCheckbox("fear", "on Fear", true));
            _menu.AddCheckBox(_antiCCMenu, new MenuCheckbox("charm", "on Charm", true));
            _menu.AddCheckBox(_antiCCMenu, new MenuCheckbox("suppression", "on Suppression", true));
            _menu.AddCheckBox(_antiCCMenu, new MenuCheckbox("blind", "on Blind", false));
            _menu.AddCheckBox(_antiCCMenu, new MenuCheckbox("disarm", "on Disarm", true));

            //Tick
            Obj_AI_Base.OnBuffGained += OnAddBuff;
        }

        private void OnAddBuff(Obj_AI_Base sender, Obj_AI_BaseBuffGainedEventArgs args)
        {
            if (!args.Buff.Target.IsMe) return;

            if (_menu.GetValue<bool>(_antiCCMenu, "cleanse") && _spellManager.Cleanse != null &&
                _spellManager.Cleanse.IsReady() &&
                (_menu.GetValue<bool>(_antiCCMenu, "stun") && args.Buff.Type == BuffType.Stun ||
                 _menu.GetValue<bool>(_antiCCMenu, "silence") && args.Buff.Type == BuffType.Silence ||
                 _menu.GetValue<bool>(_antiCCMenu, "taunt") && args.Buff.Type == BuffType.Taunt ||
                 _menu.GetValue<bool>(_antiCCMenu, "polymorph") && args.Buff.Type == BuffType.Polymorph ||
                 _menu.GetValue<bool>(_antiCCMenu, "snare") && args.Buff.Type == BuffType.Snare ||
                 _menu.GetValue<bool>(_antiCCMenu, "sleep") && args.Buff.Type == BuffType.Sleep ||
                 _menu.GetValue<bool>(_antiCCMenu, "fear") && args.Buff.Type == BuffType.Fear ||
                 _menu.GetValue<bool>(_antiCCMenu, "charm") && args.Buff.Type == BuffType.Charm ||
                 _menu.GetValue<bool>(_antiCCMenu, "blind") && args.Buff.Type == BuffType.Blind ||
                 _menu.GetValue<bool>(_antiCCMenu, "disarm") && args.Buff.Type == BuffType.Disarm))
            {
                _spellManager.Cleanse.Cast(ObjectManager.Player);
                return;
            }

            if (!_items.GetQssState()) return;
            if (_menu.GetValue<bool>(_antiCCMenu, "stun") && args.Buff.Type == BuffType.Stun ||
                _menu.GetValue<bool>(_antiCCMenu, "silence") && args.Buff.Type == BuffType.Silence ||
                _menu.GetValue<bool>(_antiCCMenu, "taunt") && args.Buff.Type == BuffType.Taunt ||
                _menu.GetValue<bool>(_antiCCMenu, "polymorph") && args.Buff.Type == BuffType.Polymorph ||
                _menu.GetValue<bool>(_antiCCMenu, "snare") && args.Buff.Type == BuffType.Snare ||
                _menu.GetValue<bool>(_antiCCMenu, "sleep") && args.Buff.Type == BuffType.Sleep ||
                _menu.GetValue<bool>(_antiCCMenu, "fear") && args.Buff.Type == BuffType.Fear ||
                _menu.GetValue<bool>(_antiCCMenu, "charm") && args.Buff.Type == BuffType.Charm ||
                _menu.GetValue<bool>(_antiCCMenu, "suppression") && args.Buff.Type == BuffType.Suppression ||
                _menu.GetValue<bool>(_antiCCMenu, "blind") && args.Buff.Type == BuffType.Blind ||
                _menu.GetValue<bool>(_antiCCMenu, "disarm") && args.Buff.Type == BuffType.Disarm)
            {
                CastQSS();
            }
        }

        private void CastQSS()
        {
            if (_menu.GetValue<bool>(_antiCCMenu, "qss"))
            {
                _items.CastQSS();
            }
            if (_menu.GetValue<bool>(_antiCCMenu, "mercurial"))
            {
                _items.CastMercurial();
            }
        }
    }
}