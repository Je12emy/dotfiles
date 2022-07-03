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
  window_padding = padding,
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,
  force_reverse_video_cursor = true,
  color_scheme = "kanagawa",
  use_dead_keys = false,
  unix_domains = {
      {
        name = "unix",
      }
    },
  -- This causes `wezterm` to act as though it was started as
  -- `wezterm connect unix` by default, connecting to the unix
  -- domain on startup.
  -- If you prefer to connect manually, leave out this line.
  -- default_gui_startup_args = {"connect", "unix"},
  -- timeout_milliseconds defaults to 1000 and can be omitted
  leader = { key="a", mods="CTRL", timeout_milliseconds=1001 },
  keys = {
      { key = "s", mods = "LEADER", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" }})},
      { key = "v", mods = "LEADER", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" }})},
      { key = "h", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Left" })},
	  { key = "j", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Down" })},
	  { key = "k", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
	  { key = "l", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Right" })},
      { key = "H", mods = "LEADER", action = wezterm.action({ AdjustPaneSize = { "Left", 5 } }) },
      { key = "L", mods = "LEADER", action = wezterm.action({ AdjustPaneSize = { "Right", 5 } }) },
      { key = "K", mods = "LEADER", action = wezterm.action({ AdjustPaneSize = { "Up", 5 } }) },
      { key = "J", mods = "LEADER", action = wezterm.action({ AdjustPaneSize = { "Down", 5 } }) },
      { key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
      { key = "x", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = true }})},
      { key = "q", mods = 'LEADER', action = wezterm.action({ CloseCurrentTab = { confirm=true }})},
      { key = "{", mods = "LEADER", action = wezterm.action{ ActivateTabRelative=-1 }},
      { key = "}", mods = "LEADER", action = wezterm.action{ ActivateTabRelative=1 }},
      { key = "n", mods = "LEADER", action = wezterm.action{ SpawnTab="CurrentPaneDomain" }},
      { key = "+", mods = "CTRL", action = "IncreaseFontSize" },
      { key = "-", mods = "CTRL", action = "DecreaseFontSize" },
      { key = "0", mods = "CTRL", action = "ResetFontSize" },
  },
}
