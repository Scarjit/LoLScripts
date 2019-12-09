local draw = {}
local string, game, setmetatable, math, objmanager, myHero, print, tostring, type, enum= string, game, setmetatable, math, objmanager, objmanager.player, print, tostring, type, enum

function draw.GetDistanceSqr(p1,p2)
    if(not p1 or not p2)then 
        return math.huge 
    end 
    local xSqr = (p1.x - p2.x) * (p1.x - p2.x)
    local ySqr = (p1.y - p2.y) * (p1.y - p2.y)
    local zSqr = (p1.z - p2.z) * (p1.z - p2.z)
    return xSqr + ySqr + zSqr
end

function draw.GetDistance(p1,p2)
    return math.sqrt(draw.GetDistanceSqr(p1,p2))
end

function draw.vec2IsOnScreen(pos)
	if pos.x > glx.screenX then
		return false
	end
	if pos.y > glx.screenY then
		return false
	end
  if(pos.x < 0 or pos.y < 0)then
    return false
  end
	return true
end

function draw.vec3IsOnScreen(pos)
	return draw.vec2IsOnScreen(glx.world.toscreen(pos))
end

function draw.text(str, size, x, y, c, h, v)
	local color, dx, dy = c or draw.color.white, glx.textArea(str, size)
	if h then
		if h == "center" then
			x = x - (dx / 2)
		elseif h == "right" then
			x = x - dx
		end
		if v and v ~= "middle" then
			if v == "top" then
				y = y + (dy / 2)
			elseif v == "bottom" then
				y = y - (dy / 2)
			end
		end
	end
	glx.screen.drawText(str, size, x, y, color)
end


draw.color = {
	alice_blue = glx.argb(255,240,248,255),
	antique_white = glx.argb(255,250,235,215),
	aqua = glx.argb(255,0,255,255),
	aqua_marine = glx.argb(255,127,255,212),
	azure = glx.argb(255,240,255,255),
	beige = glx.argb(255,245,245,220),
	bisque = glx.argb(255,255,228,196),
	black = glx.argb(255,0,0,0),
	blanched_almond = glx.argb(255,255,235,205),
	blue = glx.argb(255,0,0,255),
	blue_violet = glx.argb(255,138,43,226),
	brown = glx.argb(255,165,42,42),
	burly_wood = glx.argb(255,222,184,135),
	cadet_blue = glx.argb(255,95,158,160),
	chart_reuse = glx.argb(255,127,255,0),
	chocolate = glx.argb(255,210,105,30),
	coral = glx.argb(255,255,127,80),
	corn_flower_blue = glx.argb(255,100,149,237),
	corn_silk = glx.argb(255,255,248,220),
	crimson = glx.argb(255,220,20,60),
	cyan = glx.argb(255,0,255,255),
	dark_blue = glx.argb(255,0,0,139),
	dark_cyan = glx.argb(255,0,139,139),
	dark_golden_rod = glx.argb(255,184,134,11),
	dark_gray = glx.argb(255,169,169,169),
	dark_green = glx.argb(255,0,100,0),
	dark_khaki = glx.argb(255,189,183,107),
	dark_magenta = glx.argb(255,139,0,139),
	dark_olive_green = glx.argb(255,85,107,47),
	dark_orange = glx.argb(255,255,140,0),
	dark_orchid = glx.argb(255,153,50,204),
	dark_red = glx.argb(255,139,0,0),
	dark_salmon = glx.argb(255,233,150,122),
	dark_sea_green = glx.argb(255,143,188,143),
	dark_slate_blue = glx.argb(255,72,61,139),
	dark_slate_gray = glx.argb(255,47,79,79),
	dark_turquoise = glx.argb(255,0,206,209),
	dark_violet = glx.argb(255,148,0,211),
	deep_pink = glx.argb(255,255,20,147),
	deep_sky_blue = glx.argb(255,0,191,255),
	dim_gray = glx.argb(255,105,105,105),
	dodger_blue = glx.argb(255,30,144,255),
	firebrick = glx.argb(255,178,34,34),
	floral_white = glx.argb(255,255,250,240),
	forest_green = glx.argb(255,34,139,34),
	gainsboro = glx.argb(255,220,220,220),
	ghost_white = glx.argb(255,248,248,255),
	gold = glx.argb(255,255,215,0),
	golden_rod = glx.argb(255,218,165,32),
	gray = glx.argb(255,128,128,128),
	green = glx.argb(255,0,128,0),
	green_yellow = glx.argb(255,173,255,47),
	honeydew = glx.argb(255,240,255,240),
	hot_pink = glx.argb(255,255,105,180),
	indian_red = glx.argb(255,205,92,92),
	indigo = glx.argb(255,75,0,130),
	ivory = glx.argb(255,255,255,240),
	khaki = glx.argb(255,240,230,140),
	lavender = glx.argb(255,230,230,250),
	lavender_blush = glx.argb(255,255,240,245),
	lawn_green = glx.argb(255,124,252,0),
	lemon_chiffon = glx.argb(255,255,250,205),
	light_blue = glx.argb(255,173,216,230),
	light_coral = glx.argb(255,240,128,128),
	light_cyan = glx.argb(255,224,255,255),
	light_golden_rod_yellow = glx.argb(255,250,250,210),
	light_gray = glx.argb(255,211,211,211),
	light_green = glx.argb(255,144,238,144),
	light_pink = glx.argb(255,255,182,193),
	light_salmon = glx.argb(255,255,160,122),
	light_sea_green = glx.argb(255,32,178,170),
	light_sky_blue = glx.argb(255,135,206,250),
	light_slate_gray = glx.argb(255,119,136,153),
	light_steel_blue = glx.argb(255,176,196,222),
	light_yellow = glx.argb(255,255,255,224),
	lime = glx.argb(255,0,255,0),
	lime_green = glx.argb(255,50,205,50),
	linen = glx.argb(255,250,240,230),
	magenta = glx.argb(255,255,0,255),
	maroon = glx.argb(255,128,0,0),
	medium_aqua_marine = glx.argb(255,102,205,170),
	medium_blue = glx.argb(255,0,0,205),
	medium_orchid = glx.argb(255,186,85,211),
	medium_purple = glx.argb(255,147,112,219),
	medium_sea_green = glx.argb(255,60,179,113),
	medium_slate_blue = glx.argb(255,123,104,238),
	medium_spring_green = glx.argb(255,0,250,154),
	medium_turquoise = glx.argb(255,72,209,204),
	medium_violet_red = glx.argb(255,199,21,133),
	midnight_blue = glx.argb(255,25,25,112),
	mint_cream = glx.argb(255,245,255,250),
	misty_rose = glx.argb(255,255,228,225),
	moccasin = glx.argb(255,255,228,181),
	navajo_white = glx.argb(255,255,222,173),
	navy = glx.argb(255,0,0,128),
	old_lace = glx.argb(255,253,245,230),
	olive = glx.argb(255,128,128,0),
	olive_drab = glx.argb(255,107,142,35),
	orange = glx.argb(255,255,165,0),
	orange_red = glx.argb(255,255,69,0),
	orchid = glx.argb(255,218,112,214),
	pale_golden_rod = glx.argb(255,238,232,170),
	pale_green = glx.argb(255,152,251,152),
	pale_turquoise = glx.argb(255,175,238,238),
	pale_violet_red = glx.argb(255,219,112,147),
	papaya_whip = glx.argb(255,255,239,213),
	peach_puff = glx.argb(255,255,218,185),
	peru = glx.argb(255,205,133,63),
	pink = glx.argb(255,255,192,203),
	plum = glx.argb(255,221,160,221),
	powder_blue = glx.argb(255,176,224,230),
	purple = glx.argb(255,128,0,128),
	red = glx.argb(255,255,0,0),
	rosy_brown = glx.argb(255,188,143,143),
	royal_blue = glx.argb(255,65,105,225),
	saddle_brown = glx.argb(255,139,69,19),
	salmon = glx.argb(255,250,128,114),
	sandy_brown = glx.argb(255,244,164,96),
	sea_green = glx.argb(255,46,139,87),
	sea_shell = glx.argb(255,255,245,238),
	sienna = glx.argb(255,160,82,45),
	silver = glx.argb(255,192,192,192),
	sky_blue = glx.argb(255,135,206,235),
	slate_blue = glx.argb(255,106,90,205),
	slate_gray = glx.argb(255,112,128,144),
	snow = glx.argb(255,255,250,250),
	spring_green = glx.argb(255,0,255,127),
	steel_blue = glx.argb(255,70,130,180),
	tan = glx.argb(255,210,180,140),
	teal = glx.argb(255,0,128,128),
	thistle = glx.argb(255,216,191,216),
	tomato = glx.argb(255,255,99,71),
	turquoise = glx.argb(255,64,224,208),
	violet = glx.argb(255,238,130,238),
	wheat = glx.argb(255,245,222,179),
	white = glx.argb(255,255,255,255),
	white_smoke = glx.argb(255,245,245,245),
	yellow = glx.argb(255,255,255,0),
	yellow_green = glx.argb(255,154,205,50),
}


return draw