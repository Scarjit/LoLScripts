using System;
using System.Drawing;
using System.IO;
using System.Net;
using HesaEngine.SDK;
using HesaEngine.SDK.GameObjects;
using Newtonsoft.Json.Linq;
using SharpDX;
using SharpDX.Direct3D9;

namespace FoxyStats
{
    internal class Build
    {
        private readonly ColorBGRA _contains = new ColorBGRA(0, 255, 0, 255);
        private readonly ColorBGRA _other = new ColorBGRA(255, 255, 0, 255);
        private readonly ColorBGRA _white = new ColorBGRA(255, 255, 255, 255);
        private Texture background_texture;
        private readonly Vector2 bg_pos = new Vector2(10, 10);
        private JObject build;
        private JObject itemdata;
        private readonly AIHeroClient Player = ObjectManager.Player;

        public Build()
        {
            if (!TryGetItemList())
            {
                Logger.Log("Could not retrive the LoLItemList, aborting.", ConsoleColor.Red);
                return;
            }
            if (!TryGetPlayerBuild())
            {
                Logger.Log("Could not retrive the best Build for " + Player.ChampionName + ", aborting.",
                    ConsoleColor.Red);
                return;
            }


            background_texture = Drawing.BitmapToTexture(new Bitmap(sprites.stats_bg_60));

            Drawing.OnDraw += OnDraw;
            Drawing.OnEndScene += OnEndScene;
            Drawing.OnPreReset += OnPreReset;
        }

        private void OnPreReset(EventArgs args)
        {
            background_texture.Dispose();
            background_texture = null;
        }

        private void OnEndScene(EventArgs args)
        {
            DrawShoppingList();
        }


        private void OnDraw(EventArgs args)
        {
            if (background_texture != null && ObjectManager.Player.InShop())
                Drawing.DrawTexture(background_texture, bg_pos);
        }

        private void DrawShoppingList()
        {
            var x_offset = 20;
            var y_offset = 20;
            if (ObjectManager.Player.InShop())
            {
                Drawing.DrawText(10 + x_offset, 10 + y_offset,
                    "[Foxy.lab Stats :: " + ObjectManager.Player.ChampionName + "]", _white);
                Drawing.DrawText(10 + x_offset, 25 + y_offset,
                    "[" + build["games"] + " Games / " + build["winPercent"] + "% WinRate / " + build["role"] + "]",
                    _white);

                var n = 0;
                foreach (var jToken in build["items"])
                {
                    var _current_item = itemdata[jToken.ToString()];
                    var display_str = _current_item["name"] + " : " + _current_item["gold"]["total"];
                    ColorBGRA x;
                    if (InventoryContains(int.Parse(jToken.ToString())))
                        x = _contains;
                    else
                        x = _other;
                    Drawing.DrawText(10 + x_offset, 60 + y_offset + n * 15, display_str, x);
                    n++;
                }
            }
        }

        private static bool InventoryContains(int id)
        {
            var contains = false;
            foreach (var playerInventoryItem in ObjectManager.Player.InventoryItems)
                if (playerInventoryItem.Id == id)
                {
                    contains = true;
                    break;
                    ;
                }
            return contains;
        }

        private bool TryGetPlayerBuild()
        {
            var tries = 0;
            while (tries < 2)
                if (GetBestBuild())
                    tries = 42;
                else
                    tries++;
            return tries == 42;
        }

        public bool GetBestBuild()
        {
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12 | SecurityProtocolType.Tls11 |
                                                   SecurityProtocolType.Tls;

            var request =
                WebRequest.Create(
                    "https://s1mplescripts.de/S1mple/api.champion.gg_parser/get_best_build.php?champion=" +
                    ObjectManager.Player.ChampionName) as HttpWebRequest;
            using (var response = request.GetResponse() as HttpWebResponse)
            {
                if (response.StatusCode != HttpStatusCode.OK)
                {
                    build = new JObject();
                    return false;
                }

                var readStream = new StreamReader(response.GetResponseStream());
                var response_str = readStream.ReadToEnd();

                build = JObject.Parse(response_str);
            }
            return true;
        }

        private bool TryGetItemList()
        {
            var tries = 0;
            while (tries < 2)
                if (GetItemList())
                    tries = 42;
                else
                    tries++;
            return tries == 42;
        }

        private bool GetItemList()
        {
            ServicePointManager.SecurityProtocol =
                SecurityProtocolType.Tls12 | SecurityProtocolType.Tls11 | SecurityProtocolType.Tls;

            var request =
                WebRequest.Create("https://s1mplescripts.de/S1mple/api.champion.gg_parser/get_items.php") as
                    HttpWebRequest;
            using (var response = request.GetResponse() as HttpWebResponse)
            {
                if (response.StatusCode != HttpStatusCode.OK)
                {
                    itemdata = new JObject();
                    return false;
                }

                var readStream = new StreamReader(response.GetResponseStream());
                var responseStr = readStream.ReadToEnd();

                itemdata = JObject.Parse(responseStr);
            }
            return true;
        }
    }
}