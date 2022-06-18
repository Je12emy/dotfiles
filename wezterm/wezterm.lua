local wezterm = require 'wezterm';

local padding = {
	left = "1cell",
	right = "1cell",
	top = "0.5cell",
	bottom = "0.5cell",
}

return {
  font = wezterm.font("JetBrains Mono", { weight="Regular" }),
  line_height = 1.25,
  bold_brightens_ansi_colors = false,
  hide_tab_bar_if_only_one_tab = true,
  padding = padding,
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,
  force_reverse_video_cursor = true,
  color_scheme = "kanagawa",
  use_dead_keys = false,
  -- timeout_milliseconds defaults to 1000 and can be omitted
  leader = { key="a", mods="CTRL", timeout_milliseconds=1000 },
  unix_domains = {
      {
        name = "unix",
      }
    },
  -- This causes `wezterm` to act as though it was started as
  -- `wezterm connect unix` by default, connecting to the unix
  -- domain on startup.
  -- If you prefer to connect manually, leave out this line.
  default_gui_startup_args = {"connect", "unix"},
}
