using HesaEngine.SDK;

namespace FoxyStats
{
    public class Main : IScript

    {
        public void OnInitialize()
        {
            Game.OnGameLoaded += OnLoad;
        }
        
        public string Name => "FoxyStats";

        public string Version => "1.0.0";
        public string Author => "Foxy.lab";

        private void OnLoad()
        {
            var b = new Build();
            var ps = new PlayerStats();
        }
    }
}