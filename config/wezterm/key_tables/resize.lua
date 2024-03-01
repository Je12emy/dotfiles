local wezterm = require("wezterm")

local M = {}

M.resize_mode = function(settings)
  return {
    {
      key = "h",
      action = wezterm.action.AdjustPaneSize { "Left", 5 },
    },
    {
      key = "l",
      action = wezterm.action.AdjustPaneSize { "Right", 5 },
    },
    {
      key = "j",
      action = wezterm.action.AdjustPaneSize { "Down", 5 },
    },
    {
      key = "k",
      action = wezterm.action.AdjustPaneSize { "Up", 5 },
    },
    settings.escape_pop_key,
    settings.enter_pop_key
  }
end

return M
