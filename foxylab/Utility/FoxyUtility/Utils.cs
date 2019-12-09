using HesaEngine.SDK;

namespace FoxyUtility {
    internal class Utils {
        public static void PrintChat(string msg) {
            Chat.Print("<font color=\"#e55400\"><b>[</b></font><font color=\"#ff8c00\"><b>FOXY.lab Utility</b></font><font color=\"#e55400\"><b>]</b></font> <font color=\"#ffc76d\">" + msg + "</font>");
        }
    }
}