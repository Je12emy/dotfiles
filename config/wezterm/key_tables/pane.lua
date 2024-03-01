local wezterm = require("wezterm")

local M = {}

M.pane_mode = function()
  return {
    {
      key = "j",
      action = wezterm.action.ActivatePaneDirection 'Down'
    },
    {
      key = "k",
      action = wezterm.action.ActivatePaneDirection 'Up'
    },
    {
      key = "l",
      action = wezterm.action.ActivatePaneDirection 'Right'
    },
    {
      key = "h",
      action = wezterm.action.ActivatePaneDirection 'Left'
    },
    {
      key = "x",
      action = wezterm.action.CloseCurrentPane { confirm = true },
    },
    {
      key = "z",
      action = wezterm.action.TogglePaneZoomState,
    },
    {
      key = "r",
      action = wezterm.action.SplitPane {
        direction = 'Right',
        size = { Percent = 50 },
      },
    },
    {
      key = "d",
      action = wezterm.action.SplitPane {
        direction = 'Down',
        size = { Percent = 50 },
      }
    },
  }
end

return M
