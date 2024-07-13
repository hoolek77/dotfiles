local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.enable_tab_bar = false -- remove tab bar
config.window_decorations = "RESIZE" -- remove window decorations
config.window_background_opacity = 0.97
config.macos_window_background_blur = 10

-- config.color_scheme = "Tokyo Night"
config.color_scheme = "Gruvbox Dark (Gogh)"
config.audible_bell = "Disabled" -- disable sounds when at the end of doc

config.font = wezterm.font_with_fallback({ "Fira Code", "Symbols Nerd Font" })
config.font_size = 16

config.cursor_blink_rate = 800

config.keys = {
	-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
	{ key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
	-- Make Option-Right equivalent to Alt-f; forward-word
	{ key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },
}

return config
