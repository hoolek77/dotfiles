local with_alpha = function(color, alpha)
	if alpha > 1.0 or alpha < 0.0 then
		return color
	end
	return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
end

---@diagnostic disable-next-line: unused-local
local catppuccin = {
	black = 0xff181819,
	white = 0xffcad3f5,
	red = 0xfff38ba8,
	green = 0xffa6e3a1,
	blue = 0xff89b4fa,
	yellow = 0xfff9e2af,
	orange = 0xfffab387,
	magenta = 0xffeba0ac,
	grey = 0xff9399b2,
	transparent = 0x00000000,

	bar = {
		bg = with_alpha(0xff494d64, 0.9),
		border = 0xfff5e0dc,
	},
	popup = {
		bg = with_alpha(0xff494d64, 0.9),
		border = 0xfff5e0dc,
	},
	bg1 = 0xff24273a,
	bg2 = 0xff1e2030,
	border = 0xff1e2030,

	with_alpha = with_alpha,
}

local kanagawa = {
	black = 0xff181819,
	white = 0xffDCD7BA,
	red = 0xffFF5D62,
	green = 0xff76946A,
	blue = 0xffA3D4D5,
	yellow = 0xffFF9E3B,
	orange = 0xffFFA066,
	magenta = 0xffD27E99,
	grey = 0xff727169,
	transparent = 0x00000000,

	bar = {
		bg = with_alpha(0xff16161D, 0.8),
		border = 0xffDCD7BA,
	},
	popup = {
		bg = with_alpha(0xff16161D, 0.8),
		border = 0xffDCD7BA,
	},
	bg1 = with_alpha(0xff363646, 0.8),
	bg2 = with_alpha(0xff2A2A37, 0.8),
	border = with_alpha(0xff54546D, 0.8),
	test = "dsadasd",

	with_alpha = with_alpha,
}

return kanagawa
