with_alpha = function(color, alpha)
	if alpha > 1.0 or alpha < 0.0 then
		return color
	end
	return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
end

return {
	black = 0xff181819,
	white = 0xffe2e2e3,
	red = 0xfffb4934,
	green = 0xff98971a,
	blue = 0xff83a598,
	yellow = 0xffe7c664,
	orange = 0xfff39660,
	magenta = 0xffb39df3,
	grey = 0xffa89984,
	transparent = 0x00000000,

	bar = {
		bg = with_alpha(0xff665c54, 0.9),
		border = 0xff2c2e34,
	},
	popup = {
		bg = with_alpha(0xff665c54, 0.9),
		border = 0xff7f8490,
	},
	bg1 = 0xff504945,
	bg2 = 0xff3c3836,

	with_alpha = with_alpha,
}
