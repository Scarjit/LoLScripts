using System;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using HesaEngine.SDK;
using Microsoft.Win32;
using Newtonsoft.Json.Linq;
using SharpDX;
using SharpDX.Direct3D9;

namespace FoxyStats
{
    internal class PlayerStats
    {
        private ColorBGRA _contains = new ColorBGRA(0, 255, 0, 255);
        private ColorBGRA _other = new ColorBGRA(255, 255, 0, 255);
        private readonly ColorBGRA _white = new ColorBGRA(255, 255, 255, 255);
        private Texture background_texture;
        private JObject playerdata;
        private int start_tick;

        private readonly int x_offset = 300;
        private readonly int y_offset = 320;

        public PlayerStats()
        {
            if (!TryGetPlayerData())
            {
                Logger.Log("Could not retrive the PlayerStats, aborting.", ConsoleColor.Red);
                return;
            }
            start_tick = Game.GameTimeTickCount;

            background_texture = Drawing.BitmapToTexture(new Bitmap(sprites.stats_bg_50));
            Drawing.OnDraw += OnDraw;
            Drawing.OnEndScene += OnEndScene;
            Drawing.OnPreReset += OnPreReset;
        }

        private void OnEndScene(EventArgs args)
        {
            if (GetElapsedSecounds() > 10)
                return;
            DrawPlayerStats();
        }

        private bool TryGetPlayerData()
        {
            var tries = 0;
            while (tries < 2)
                if (GetPlayerData())
                    tries = 42;
                else
                    tries++;
            return tries == 42;
        }

        private int GetElapsedSecounds()
        {
            return 0;
            //return (int) Math.Round(((Game.GameTimeTickCount - (float) start_tick) / 1000));
        }

        private void OnDraw(EventArgs args)
        {
            if (GetElapsedSecounds() > 10)
                return;
            DrawBG();
        }

        private void OnPreReset(EventArgs args)
        {
            background_texture.Dispose();
            background_texture = null;
        }

        private void DrawBG()
        {
            for (var index = 0; index < playerdata.Count; index++)
                if (index >= playerdata.Count / 2)
                    Drawing.DrawTexture(background_texture,
                        new Vector2(220 + (index - playerdata.Count / 2) * x_offset, 100 + y_offset));
                else
                    Drawing.DrawTexture(background_texture, new Vector2(220 + index * x_offset, -100 + y_offset));
        }

        private void DrawPlayerStats()
        {
            var i = 0;
            var n = 80;

            foreach (var keyValuePair in playerdata)
            {
                var current = keyValuePair.Value;

                if (current["name"].ToString() == ObjectManager.Player.Name)
                    Drawing.DrawText(230 + i * x_offset, 150 + n, WebUtility.HtmlDecode(current["name"].ToString()),
                        new ColorBGRA(0, 255, 0, 255));
                else
                    Drawing.DrawText(230 + i * x_offset, 150 + n, WebUtility.HtmlDecode(current["name"].ToString()),
                        _white);
                Drawing.DrawText(230 + i * x_offset, 180 + n, WebUtility.HtmlDecode(current["champ"].ToString()),
                    _white);
                Drawing.DrawText(230 + i * x_offset, 195 + n, current["rank"].ToString(), _white);
                Drawing.DrawText(230 + i * x_offset, 210 + n, "Ranked Winrate: " + current["rate"],
                    ColorFromWinRate(current["rate"].ToString()));
                Drawing.DrawText(230 + i * x_offset, 225 + n, "Champion Winrate: " + current["crate"],
                    ColorFromWinRate(current["crate"].ToString()));
                Drawing.DrawText(230 + i * x_offset, 240 + n, current["summoners"][0].ToString(), _white);
                Drawing.DrawText(230 + i * x_offset, 255 + n, current["summoners"][1].ToString(), _white);

                i++;
                if (i == playerdata.Count / 2)
                {
                    n += (int) Math.Floor(y_offset * 0.63);
                    i = 0;
                }
            }
        }

        private ColorBGRA ColorFromWinRate(string rate)
        {
            var perc_index = rate.IndexOf("%");
            if (perc_index <= 0)
                return _white;

            var r = rate.Substring(0, perc_index);
            var intrate = int.Parse(r);
            var green = (int) Math.Round(255 * (intrate * 0.01));
            var red = (int) Math.Round(255 - 255 * (intrate * 0.01));

            return new ColorBGRA(red, green, 0, 255);
        }

        public bool GetPlayerData()
        {
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12 | SecurityProtocolType.Tls11 |
                                                   SecurityProtocolType.Tls;

            var region = "";
            var found_region = GetRegion(out region);
            if (!found_region)
            {
                Logger.Log("Could not find Player region !");
                playerdata = new JObject();
                return false;
            }
#if DEBUG
            var request =
                WebRequest.Create(
                        "https://s1mplescripts.de/S1mple/api.champion.gg_parser/get_matchup_data.php?player_name=reggadam&region=euw")
                    as HttpWebRequest;
#else
            HttpWebRequest request =
                WebRequest.Create(
                    "https://s1mplescripts.de/S1mple/api.champion.gg_parser/get_matchup_data.php?player_name=" + ObjectManager.Player.Name + "&region="+ region) as HttpWebRequest;
#endif
            using (var response = request.GetResponse() as HttpWebResponse)
            {
                if (response.StatusCode != HttpStatusCode.OK)
                {
                    playerdata = new JObject();
                    return false;
                }

                var readStream = new StreamReader(response.GetResponseStream());
                var response_str = readStream.ReadToEnd();
                if (response_str.Contains("NOT INGAME") || response_str.Contains("404 Not Found"))
                {
                    Logger.Log("Player appears not to be ingame !");
                    playerdata = new JObject();
                    return false;
                }

                playerdata = JObject.Parse(response_str);
            }
            return true;
        }


        private bool GetRegion(out string region)
        {
            //Credits to RaINi
            region = "";
            var ret = false;
            using (var RegKey =
                Registry.ClassesRoot.OpenSubKey("VirtualStore\\MACHINE\\SOFTWARE\\WOW6432Node\\Riot Games\\Rads"))
            {
                var _Temp = RegKey?.GetValue("LocalRootFolder").ToString().Replace("/", @"\") + "\\system\\system.cfg";
                if (File.Exists(_Temp))
                {
                    ret = true;
                    region = File.ReadAllLines(_Temp).Skip(2).Take(1).First().ToLower();
                }
            }
            return ret;
        }
    }
}