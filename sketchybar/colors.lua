local with_alpha = function(color, alpha)
	if alpha > 1.0 or alpha < 0.0 then
		return color
	end
	return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
end

return {
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

	with_alpha = with_alpha,
}
