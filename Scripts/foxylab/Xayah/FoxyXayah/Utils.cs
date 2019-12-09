using System.Collections.Generic;
using System.Linq;
using HesaEngine.SDK;
using HesaEngine.SDK.GameObjects;
using SharpDX;

namespace FoxyXayah
{
    internal class Utils
    {
        private static readonly AIHeroClient Player = ObjectManager.Player;
        public static int lastAA;
        public static bool CanAttack;

        public static Dictionary<string, string[]> champList = new Dictionary<string, string[]>
        {
            {
                "Tank", new[]
                {
                    "Amumu", "Chogath", "DrMundo", "Galio", "Ivern", "Malphite", "Maokai", "Nasus", "Rammus", "Sejuani",
                    "Nautilus", "Nunu", "Shen", "Singed", "Sion", "Skarner",
                    "Volibear", "Warwick", "Zac", "Alistar", "Braum", "Leona", "TahmKench", "Garen", "Gnar", "Shyvana"
                }
            }
        };


        private Utils()
        {
            AdvCallbacks.OnAttackAnimation += AdvCallbacksOnOnAttackAnimation;
            AdvCallbacks.OnProcessAttack += AdvCallbacksOnOnProcessAttack;
        }

        private void AdvCallbacksOnOnProcessAttack(AttackableUnit unit, AttackableUnit target)
        {
            if (!unit.IsMe) return;
            CanAttack = false;
            Utility.DelayAction((int) (1f / (Player.AttackSpeedMod * 0.658f) * 1000f), () => { CanAttack = true; });
        }

        private void AdvCallbacksOnOnAttackAnimation(Obj_AI_Base aiBase, string name)
        {
            if (!aiBase.IsMe) return;
            lastAA = HesaEngine.SDK.Utils.TickCount;
        }

        public static void PrintChat(string msg)
        {
            Chat.Print("<font color = \"#b30cef\">[FOXY.lab xayah]:</font> <font color = \"#ffffff\">" + msg +
                       "</font>");
        }

        public static float GetRealRange(Obj_AI_Base target)
        {
            return ObjectManager.Player.AttackRange + ObjectManager.Player.BoundingRadius + target.BoundingRadius;
        }

        public static bool IsWindingUp()
        {
            return HesaEngine.SDK.Utils.TickCount < lastAA + GetWindup();
        }

        public static bool IsReset()
        {
            if (!CanAttack) return true;

            var x = HesaEngine.SDK.Utils.TickCount - (lastAA + GetWindup());
            return x >= 0 && x <= 500;
        }

        private static float GetWindup()
        {
            return 1f / (Player.AttackSpeedMod * 2.9999997309538f) * 1000;
        }

        public static List<Obj_AI_Minion> GetNearbyMinions(float range)
        {
            return ObjectManager.MinionsAndMonsters.Enemy
                .Where(x => x.IsValid())
                .Where(x => x.IsValidTarget())
                .Where(x => !x.IsDead)
                .Where(x => !x.IsInvulnerable)
                .Where(x => !x.IsPhysicalImmune)
                .Where(x => x.Distance3D(Player) < range).ToList();
        }

        public static List<Obj_AI_Minion> GetNearbyJungleMinions(float range)
        {
            return ObjectManager.MinionsAndMonsters.NeutralCamps
                .Where(x => x.IsValid())
                .Where(x => x.IsValidTarget())
                .Where(x => !x.IsDead)
                .Where(x => !x.IsInvulnerable)
                .Where(x => !x.IsPhysicalImmune)
                .Where(x => x.Distance3D(Player) < range).ToList();
        }

        public static MEC.MecCircle MECFromObjAIBaseList(List<Obj_AI_Base> points)
        {
            var x = new List<Vector2>();
            foreach (var objAiBase in points)
                x.Add(new Vector2(objAiBase.Position.X, objAiBase.Position.Z));

            return MEC.GetMec(x);
        }

        public static bool IsInvul(AIHeroClient target)
        {
            if (target == null) return false;

            return target.HasBuff("KindredRNoDeathBuff") || target.HasBuff("UndyingRage") ||
                   target.HasBuff("JudicatorIntervention") || target.HasBuff("VladimirSanguinePool") ||
                   target.HasBuff("ChronoShift") || target.HasBuff("SivirShield") ||
                   target.HasBuff("itemmagekillerveil") || target.HasBuff("ShroudofDarkness") ||
                   target.HasBuff("FioraW") || target.IsInvulnerable;
        }

        public static Obj_AI_Base ObjAiBaseFromAny(AIHeroClient client)
        {
            return ObjectManager.GetUnitByNetworkId<Obj_AI_Base>(client.NetworkId);
        }

        public static Obj_AI_Base ObjAiBaseFromAny(AttackableUnit client)
        {
            return ObjectManager.GetUnitByNetworkId<Obj_AI_Base>(client.NetworkId);
        }

        public static AIHeroClient AIHeroClientFromAny(AttackableUnit client)
        {
            return ObjectManager.GetUnitByNetworkId<AIHeroClient>(client.NetworkId);
        }
    }
}