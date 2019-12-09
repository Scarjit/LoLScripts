using HesaEngine.SDK;
using HesaEngine.SDK.Enums;
using HesaEngine.SDK.GameObjects;

namespace FoxyXayah
{
    internal class ItemHandler
    {
        //Defensive Items
        //TODO: Find ID, Item EdgeOfNight = new Item();
        private static Item _qss;
        private static Item _mercurial;

        //Offensive Items
        private static Item _botrk;
        private static Item _cutlass;
        private static Item _gunblade;
        private static Item _youmu;

        public ItemHandler()
        {
            _qss = new Item(ItemId.Quicksilver_Sash, 0f);
            _mercurial = new Item(ItemId.Mercurial_Scimitar, 0f);
            _botrk = new Item(ItemId.Blade_of_the_Ruined_King, 550f);
            _cutlass = new Item(ItemId.Bilgewater_Cutlass, 550f);
            _gunblade = new Item(ItemId.Hextech_Gunblade, 700f);
            _youmu = new Item(ItemId.Youmuus_Ghostblade, 0f);
        }

        public void CastItem(Item i, Obj_AI_Base target)
        {
            if (ObjectManager.Player.Distance(target) <= i.Range && i.IsOwned() && i.IsReady())
            {
                i.Cast(target);
            }
        }

        public void CastNonTargetItem(Item i)
        {
            if (i.IsOwned() && i.IsReady())
            {
                i.Cast();
            }
        }

        public void CastQSS()
        {
            CastNonTargetItem(_qss);
        }

        public void CastMercurial()
        {
            CastNonTargetItem(_mercurial);
        }

        public void CastBOTRK(Obj_AI_Base target)
        {
            CastItem(_botrk, target);
        }

        public void CastCutlass(Obj_AI_Base target)
        {
            CastItem(_cutlass, target);
        }

        public void CastGunblade(Obj_AI_Base target)
        {
            CastItem(_gunblade, target);
        }

        public void CastYoumu()
        {
            CastNonTargetItem(_youmu);
        }

        public bool GetQssState()
        {
            return _qss.IsOwned() && _qss.IsReady() || _mercurial.IsOwned() && _mercurial.IsReady();
        }
    }
}