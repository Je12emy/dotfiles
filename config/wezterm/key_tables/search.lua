local wezterm = require("wezterm")

local M = {}

M.search_mode = function(settings)
  return {
    {
      key = "j",
      action = wezterm.action.ScrollByLine(1),
    },
    {
      key = "k",
      action = wezterm.action.ScrollByLine(-1),
    },
    {
      key = "u",
      action = wezterm.action.ScrollByPage(-1),
    },
    {
      key = "d",
      action = wezterm.action.ScrollByPage(1),
    },
    settings.escape_pop_key,
    settings.enter_pop_key
  }
end

return M
