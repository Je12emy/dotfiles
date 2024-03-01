local wezterm = require("wezterm")

local colors = require("colors")
local tab_bar = require("tab")
local keys = require("keys")
local env = require("env")
local status = require("status")

local config = {}
local operating_system = env.getOS()

config.status_update_interval = 1000
status.set_status_right()

config.font = wezterm.font 'JetBrains Mono'
config.font_size = 14.0
config.line_height = 1.25
config.warn_about_missing_glyphs = false

if operating_system == "Windows" then
  config.default_prog = { 'powershell.exe' }
  config.window_background_opacity = 1
else
  config.window_background_opacity = 0.9
end

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = false
config.tab_max_width = 32

config.command_palette_bg_color = colors.background_color
config.command_palette_fg_color = colors.text_color

config.scrollback_lines = 3500
config.enable_scroll_bar = false

config.colors = {
  tab_bar = tab_bar,
}

config.disable_default_key_bindings = true
config.leader = keys.leader
config.key_tables = keys.key_tables
config.keys = keys.maps

return config
