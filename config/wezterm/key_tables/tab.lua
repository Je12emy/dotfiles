local wezterm = require("wezterm")
local M = {}

M.table_mode = function()
  return {

    {
      key = "n",
      action = wezterm.action.SpawnTab "DefaultDomain"
    },
    {
      key = "}",
      action = wezterm.action.ActivateTabRelative(1)
    },
    {
      key = "{",
      action = wezterm.action.ActivateTabRelative(-1)
    },
    {
      key = "x",
      action = wezterm.action.CloseCurrentTab { confirm = true }
    },
    {
      key = "r",
      action = wezterm.action.PromptInputLine {
        description = 'Enter new name for tab',
        action = wezterm.action_callback(function(window, _, line)
          -- line will be `nil` if they hit escape without entering anything
          -- An empty string if they just hit enter
          -- Or the actual line of text they wrote
          if line then
            window:active_tab():set_title(line)
          end
        end),
      },
    }
  }
end

return M
