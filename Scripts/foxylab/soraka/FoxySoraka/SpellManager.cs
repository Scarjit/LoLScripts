using HesaEngine.SDK;
using HesaEngine.SDK.GameObjects;
using SharpDX;

namespace FoxySoraka
{
    public class SpellManager
    {
        public Spell Q;
        public Spell W;
        public Spell E;
        public Spell R;

        public Spell Summoner1;
        public Spell Summoner2;

        public SpellManager()
        {
            Q = new Spell(HesaEngine.SDK.Enums.SpellSlot.Q, 800,TargetSelector.DamageType.Magical);
            Q.SetSkillshot(0.5f, 235, int.MaxValue, false, SkillshotType.SkillshotCircle);
            W = new Spell(HesaEngine.SDK.Enums.SpellSlot.W, 550);
            E = new Spell(HesaEngine.SDK.Enums.SpellSlot.E, 925, TargetSelector.DamageType.Magical);
            E.SetSkillshot(1.5f, 250, int.MaxValue, false, SkillshotType.SkillshotCircle);
            R = new Spell(HesaEngine.SDK.Enums.SpellSlot.R);
        }

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
    }
}