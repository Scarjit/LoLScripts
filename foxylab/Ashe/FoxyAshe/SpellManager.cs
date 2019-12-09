using System.Linq;
using HesaEngine.SDK;
using HesaEngine.SDK.GameObjects;
using SharpDX;

namespace FoxyAshe
{
    public class SpellManager
    {
        public Spell Q;
        public Spell W;
        public Spell E;
        public Spell R;

        public Spell Summoner1;
        public Spell Summoner2;

        public Spell Cleanse;
        public Spell Heal;
        public Spell Barrier;

        private static Obj_AI_Base Player => ObjectManager.Player;

        public bool CanHit(Spell s, Obj_AI_Base target, bool aoe = false, float range = 0,
            HitChance minHitChance = HitChance.High)
        {
            return s.GetPrediction(target,
                           aoe == false
                               ? aoe
                               : s.Type == SkillshotType.SkillshotCircle || s.Type == SkillshotType.SkillshotCone,
                           range > 0 ? range : s.Range, null)
                       .Hitchance >= minHitChance;
        }

        public void CastSpell(Spell s, Obj_AI_Base target)
        {
            s.Cast(target.ServerPosition);
        }

        public void CastSpell(Spell s, Vector3 targetPos)
        {
            s.Cast(targetPos);
        }

        public float GetRealDamage(Spell s, Obj_AI_Base target)
        {
            var damage = 0f;
            damage += s.GetDamage(target);

            if (target.HasBuff("BlitzcrankManaBarrierCD") && target.HasBuff("ManaBarrier")) damage -= target.Mana / 2f;
            if (Player.HasBuff("SummonerExhaust")) damage *= 0.6f;
            if (target.HasBuff("GarenW")) damage *= 0.7f;
            if (target.HasBuff("ferocioushowl")) damage *= 0.7f;
            if (target.CharDataInst.ChampionName == "Mordekaiser") damage -= target.Mana;
            //TODO: add banshee and cloth magic shield

            return damage;
        }

        private void LoadCleanse()
        {
            var slot =
                ObjectManager.Player.Spellbook.Spells.FirstOrDefault(x => x.SpellData.Name.ToLower()
                    .Contains("summonerboost"));
            if (slot != null)
                Cleanse = new Spell(slot.Slot);
        }

        private void LoadHeal()
        {
            var slot =
                ObjectManager.Player.Spellbook.Spells.FirstOrDefault(x => x.SpellData.Name.ToLower()
                    .Contains("heal"));
            if (slot != null)
                Heal = new Spell(slot.Slot);
        }

        private void LoadBarrier()
        {
            var slot =
                ObjectManager.Player.Spellbook.Spells.FirstOrDefault(x => x.SpellData.Name.ToLower()
                    .Contains("barrier"));
            if (slot != null)
                Barrier = new Spell(slot.Slot);
        }

        public void LoadSummoners()
        {
            LoadCleanse();
            LoadHeal();
            LoadBarrier();
        }
    }
}