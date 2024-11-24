local wezterm = require("wezterm")
local env = require("env")
local config = {}

config.enable_wayland = true
-- Font
config.font = wezterm.font "JetBrains Mono"
config.font_size = 14.0
config.line_height = 1.25
config.warn_about_missing_glyphs = false
local operating_system = env.getOS()
if operating_system == "Windows" then
	config.default_prog = { "powershell.exe" }
end
-- Tab bar
config.hide_tab_bar_if_only_one_tab = true
-- Solve ugly issues when zooming in
config.adjust_window_size_when_changing_font_size = false
-- Theme
local theme_name = 'Catppuccin Mocha'
config.color_scheme = theme_name
local theme = wezterm.color.get_builtin_schemes()[theme_name]
-- First color is the same as the BG color
-- see: https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/wezterm/tokyonight.toml
local random_theme_accent = theme.ansi[math.random(2, #theme.ansi)]
-- NOTE:
-- see https://wezfurlong.org/wezterm/config/appearance.html#defining-your-own-colors
-- see: https://wezfurlong.org/wezterm/config/lua/wezterm.color/load_base16_scheme.html
config.colors = {
	split = theme.ansi[5],
	tab_bar = {
		background = theme.background,
		active_tab = {
			bg_color = random_theme_accent,
			fg_color = theme.background
		},
		inactive_tab = {
			bg_color = theme.background,
			fg_color = theme.foreground
		},

	}
}
config.disable_default_key_bindings = true

config.keys = {
	{
		mods = "CTRL",
		key = "V",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
	{
		mods = "CTRL",
		key = "C",
		action = wezterm.action.CopyTo("Clipboard"),
	},
	{
		mods = "CTRL",
		key = "+",
		action = wezterm.action.IncreaseFontSize,
	},
	{
		mods = "CTRL",
		key = "-",
		action = wezterm.action.DecreaseFontSize,
	},
}

config.window_frame = {
	font_size = 10.0,
}

return config
