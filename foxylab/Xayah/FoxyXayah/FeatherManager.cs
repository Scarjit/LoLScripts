using System;
using System.Collections.Generic;
using HesaEngine.SDK;
using HesaEngine.SDK.GameObjects;

namespace FoxyXayah
{
    internal class FeatherManager
    {
        public List<Obj_AI_Base> Feathers = new List<Obj_AI_Base>();

        public FeatherManager()
        {
            Obj_AI_Base.OnCreate += OnCreateObj;
            Game.OnUpdate += OnUpdate;
        }


        private void OnUpdate()
        {
            foreach (var feather in Feathers)
                if (!feather.IsValid())
                {
                    Feathers.Remove(feather);
                    break;
                }
        }

        private void OnCreateObj(Obj_AI_Base objAiBase, EventArgs args)
        {
            if (objAiBase?.Name == "Feather")
                Feathers.Add(objAiBase);
        }
    }
}