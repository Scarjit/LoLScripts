using HesaEngine.SDK;

namespace FoxyAwareness
{
    internal class MenuHandler
    {
        public void AddSubMenu(Menu menu, string name)
        {
            menu.AddSubMenu(name);
        }

        public void AddCheckBox(Menu menu, MenuCheckbox item)
        {
            menu.Add(item);
        }

        public void AddSlider(Menu menu, MenuSlider slider)
        {
            menu.Add(slider);
        }

        public void AddColor(Menu menu, MenuColor color)
        {
            menu.Add(color);
        }

        public void AddSeparator(Menu menu, string name)
        {
            menu.AddSeparator(name);
        }

        public T GetValue<T>(Menu menu, string item)
        {
            return menu.Item(item).GetValue<T>();
        }
    }
}