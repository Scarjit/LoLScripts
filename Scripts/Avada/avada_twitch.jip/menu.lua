local menu = menuconfig("avadatwitch", "Hanbot Twitch")

menu:header('header_core', 'Core')
menu:boolean('e', 'Auto E', true)
menu:boolean('draw_e_range', 'Draw E Range', true)

return menu