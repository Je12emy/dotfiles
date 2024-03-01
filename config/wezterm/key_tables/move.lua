local wezterm = require("wezterm")

local M = {}

M.move_mode = function(settings)
  return {
    {
      key = "g",
      action = wezterm.action.PaneSelect {}
    },
    {
      key = "s",
      action = wezterm.action.PaneSelect {
        mode = 'SwapWithActive',
      }
    },
    {
      key = "}",
      action = wezterm.action.MoveTabRelative(1)
    },
    {
      key = "{",
      action = wezterm.action.MoveTabRelative(-1)
    },
    settings.escape_pop_key,
    settings.enter_pop_key
  }
end

return M
