using System.Collections.Generic;
using System.Linq;
using HesaEngine.SDK;
using HesaEngine.SDK.GameObjects;
using SharpDX;

namespace FoxyAshe
{
    internal class Utils
    {
        private static readonly AIHeroClient Player = ObjectManager.Player;

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

        public static void PrintChat(string msg)
        {
            Chat.Print("<font color = \"#b30cef\">[FOXY.lab Ashe]:</font> <font color = \"#ffffff\">" + msg +
                       "</font>");
        }

        public static float GetRealRange(Obj_AI_Base target)
        {
            return ObjectManager.Player.AttackRange + ObjectManager.Player.BoundingRadius + target.BoundingRadius;
        }

        public static bool IsWindingUp()
        {
            return HesaEngine.SDK.Utils.TickCount < Combo.lastAA + GetWindup();
        }

        public static bool IsReset()
        {
            if (!Combo.CanAttack) return true;

            var x = HesaEngine.SDK.Utils.TickCount - (Combo.lastAA + GetWindup());
            return x >= 0 && x <= 500;
        }

        private static float GetWindup()
        {
            return 1f / (Player.AttackSpeedMod * 2.9999997309538f) * 1000;
        }

        public static List<Obj_AI_Minion> GetNearbyMinions(float range)
        {
            return ObjectManager.MinionsAndMonsters.Enemy
                .Where(x => !x.IsDead)
                .Where(x => !x.IsInvulnerable)
                .Where(x => !x.IsPhysicalImmune)
                .Where(x => x.Distance3D(Player) < range).ToList();
        }

        public static List<Obj_AI_Minion> GetNearbyJungleMinions(float range)
        {
            return ObjectManager.MinionsAndMonsters.NeutralCamps
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
    }
}