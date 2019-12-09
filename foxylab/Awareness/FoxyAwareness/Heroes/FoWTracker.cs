using System;
using System.Collections.Generic;
using System.Drawing;
using HesaEngine.SDK;
using SharpDX;
using SharpDX.Direct3D9;

namespace FoxyAwareness.Heroes
{
    internal class FoWTracker
    {
        private readonly Menu _Mainmenu;
        private readonly Menu _menu;
        private readonly MenuHandler _menuhandler = new MenuHandler();
        private readonly ColorBGRA blue = new ColorBGRA(0, 0, 255, 255);
        private readonly ColorBGRA red = new ColorBGRA(255, 0, 0, 255);

        private readonly ColorBGRA white = new ColorBGRA(255, 255, 255, 255);
        private readonly Dictionary<int, float> last_seen = new Dictionary<int, float>();
        private readonly Dictionary<int, Texture> symbols = new Dictionary<int, Texture>();

        public FoWTracker(Menu menu)
        {
            _Mainmenu = menu;
            _menu = menu.AddSubMenu("FoW Tracker");
            _menuhandler.AddCheckBox(_menu, new MenuCheckbox("draw_waypoints", "Show Waypoints"));
            _menuhandler.AddSlider(_menu, new MenuSlider("max_shown", "Max Waypoints Shown", 0, 5, 10));
            _menuhandler.AddCheckBox(_menu, new MenuCheckbox("time", "Show estimated arival Time"));
            _menuhandler.AddCheckBox(_menu, new MenuCheckbox("lines", "Show Lines"));
            _menuhandler.AddSeparator(_menu, "");
            _menuhandler.AddCheckBox(_menu, new MenuCheckbox("draw_mia_symbols", "Show MIA Symbols [Broken]"));
            _menuhandler.AddCheckBox(_menu, new MenuCheckbox("draw_mia_text", "Show MIA Text"));
            _menuhandler.AddCheckBox(_menu, new MenuCheckbox("draw_mia_range", "Show MIA Range [NYI]"));


            InitVision();
            Drawing.OnDraw += OnDraw;
            Drawing.OnEndScene += OnEndScene;
            Drawing.OnPreReset += OnPreReset;
            Game.OnTick += OnTick;
        }


        private void OnPreReset(EventArgs args)
        {
            foreach (var keyValuePair in symbols)
                keyValuePair.Value.Dispose();
            symbols.Clear();
        }

        private void OnTick()
        {
            foreach (var enemy in ObjectManager.Heroes.Enemies)
                if (enemy.IsVisible &&! enemy.IsDead)
                    last_seen[enemy.NetworkId] = Game.GameTimeTickCount;
        }

        private void InitVision()
        {
            foreach (var enemy in ObjectManager.Heroes.Enemies)
            {
                Console.WriteLine(enemy.ChampionName);
                last_seen.Add(enemy.NetworkId, enemy.IsVisible ? Game.GameTimeTickCount : 0);
                Bitmap bmp;
                try
                {
                    bmp = (Bitmap) ChampIcons.ResourceManager.GetObject(enemy.ChampionName);
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message);
                    bmp = new Bitmap(0, 0);
                }
                var tex = Drawing.BitmapToTexture(bmp);
                symbols.Add(enemy.NetworkId, tex);
            }
        }

        private void OnEndScene(EventArgs args)
        {
            if (!_menuhandler.GetValue<bool>((Menu)_Mainmenu.Item("Global Switches"), "fow_tracker"))
                return;
            DrawMIASymbols();
        }
        private void OnDraw(EventArgs args)
        {
            if (!_menuhandler.GetValue<bool>((Menu)_Mainmenu.Item("Global Switches"), "fow_tracker"))
                return;
            DrawWayPoints();
        }

        /*
             bei HesaEngine.SDK.Drawing.TriggerOnDraw(EventArgs args)
            System.Reflection.TargetInvocationException: Ein Aufrufziel hat einen Ausnahmefehler verursacht. ---> SharpDX.SharpDXException: HRESULT: [0x8876086C], Module: [SharpDX.Direct3D9], ApiCode: [D3DERR_INVALIDCALL/InvalidCall], Message: Unknown
               bei SharpDX.Result.CheckError()
               bei SharpDX.Direct3D9.Sprite.Draw(Texture textureRef, IntPtr srcRectRef, IntPtr centerRef, IntPtr positionRef, ColorBGRA color)
               bei SharpDX.Direct3D9.Sprite.Draw(Texture textureRef, ColorBGRA color, Nullable`1 srcRectRef, Nullable`1 centerRef, Nullable`1 positionRef)
               bei HesaEngine.Internals.EndScene.DrawTexture(Texture texture, Vector2 position, ColorBGRA color)
               bei HesaEngine.Internals.EndScene.DrawTexture(Texture texture, Vector2 position)
               bei HesaEngine.SDK.Drawing.DrawTexture(Texture texture, Vector2 position)
               bei FoxyAwareness.Heroes.FoWTracker.DrawMIASymbols()
               bei FoxyAwareness.Heroes.FoWTracker.OnDraw(EventArgs args)
               --- Ende der internen Ausnahmestapelüberwachung ---
               bei System.RuntimeMethodHandle.InvokeMethod(Object target, Object[] arguments, Signature sig, Boolean constructor)
               bei System.Reflection.RuntimeMethodInfo.UnsafeInvokeInternal(Object obj, Object[] parameters, Object[] arguments)
               bei System.Delegate.DynamicInvokeImpl(Object[] args)
               bei HesaEngine.SDK.Drawing.TriggerOnDraw(EventArgs args)
         */
   
        private void DrawMIASymbols()
        {
            

            foreach (var enemy in ObjectManager.Heroes.Enemies)
            {
                int mia_time = (int)Math.Round((last_seen[enemy.NetworkId] - Game.GameTimeTickCount) / 1000)*-1;

                if (mia_time > 0)
                {
                    if (_menuhandler.GetValue<bool>(_menu, "draw_mia_symbols"))
                    {

                        Texture s = symbols[enemy.NetworkId];
                        if (s != null && s.IsDisposed == false && s.Device != null)
                        {
                            //Drawing.DrawTexture(symbols[enemy.NetworkId], enemy.Position.WorldToScreen());
                            //Hesa pls fix
                        }
                    }

                    if (_menuhandler.GetValue<bool>(_menu, "draw_mia_text"))
                    {
                        Drawing.DrawText(enemy.ChampionName + " : " + mia_time, TacticalMap.WorldToMinimap(enemy.Position));
                    }

                    if (_menuhandler.GetValue<bool>(_menu, "draw_mia_range"))
                    {
                        //Drawing.DrawCircle(TacticalMap.WorldToMinimap(enemy.Position).To3D(), enemy.MovementSpeed * mia_time);
                        //Needing DrawCircle2d
                    }

                }

            }
        }
        

        private void DrawWayPoints()
        {
            if (!_menuhandler.GetValue<bool>(_menu, "draw_waypoints"))
                return;
            foreach (var enemy in ObjectManager.Heroes.Enemies)
            {
                var waypoints = enemy.GetWaypoints();
                var movement_speed = enemy.MovementSpeed;
                double distance = 0;

                var nearest_waypoint = new Vector2();


                for (var i = 2; i < waypoints.Count; i++)
                {
                    var vector2 = waypoints[i];
                    if (nearest_waypoint == null || enemy.Distance(vector2.To3DWorld()) <
                        enemy.Distance(nearest_waypoint))
                        nearest_waypoint = vector2;
                }

                var max = Math.Min(_menuhandler.GetValue<int>(_menu, "max_shown"), waypoints.Count);
                for (var i = 2; i < max; i++)
                {
                    var current = waypoints[i];
                    var prev = waypoints[i - 1];
                    if (i == 2)
                        distance += nearest_waypoint.To3DWorld().Distance(enemy);
                    else
                        distance += prev.To3DWorld().Distance(current.To3DWorld());


                    var time = distance / movement_speed;
                    if (time > 0.3)
                    {
                        if (i == max - 1)
                            Drawing.DrawCircle(current.To3DWorld(), 30, red, 2);
                        else
                            Drawing.DrawCircle(current.To3DWorld(), 20, 1);

                        if (i % 2 == 0 || i + 2 == max)
                        {
                            if (_menuhandler.GetValue<bool>(_menu, "time"))
                                Drawing.DrawText(current.To3DWorld().WorldToScreen(), white,
                                    enemy.ChampionName + " : " + Math.Round(time));
                            else
                                Drawing.DrawText(current.To3DWorld().WorldToScreen(), white,
                                    enemy.ChampionName);
                        }
                        else
                        {
                            if (_menuhandler.GetValue<bool>(_menu, "time"))
                                Drawing.DrawText(current.To3DWorld().WorldToScreen(), white,
                                    Math.Round(time).ToString());
                        }
                        if (_menuhandler.GetValue<bool>(_menu, "lines"))
                            if (i == 2)
                                Drawing.DrawLine(enemy.Position, nearest_waypoint.To3DWorld(), 1, white);
                            else
                                Drawing.DrawLine(prev.To3DWorld(), current.To3DWorld(), 1, white);
                    }
                }
            }
        }
    }
}
 