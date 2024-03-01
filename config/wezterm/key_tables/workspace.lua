local wezterm = require("wezterm")

local M = {}

M.workspace = function()
  return {
    {
      key = "f",
      action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
    },
    {
      key = "s",
      action = wezterm.action.PromptInputLine {
        description = wezterm.format {
          { Attribute = { Intensity = 'Bold' } },
          { Foreground = { AnsiColor = 'Fuchsia' } },
          { Text = 'Enter name for new workspace' },
        },
        action = wezterm.action_callback(function(window, pane, line)
          -- line will be `nil` if they hit escape without entering anything
          -- An empty string if they just hit enter
          -- Or the actual line of text they wrote
          if line then
            if line ~= "" then
              window:perform_action(
                wezterm.action.SwitchToWorkspace {
                  name = line,
                },
                pane
              )
            else
              window:perform_action(
                wezterm.action.SwitchToWorkspace {
                  name = "default",
                },
                pane
              )
            end
          end
        end),
      },
    },
    {
      key = "n",
      action = wezterm.action.PromptInputLine {
        description = wezterm.format {
          { Attribute = { Intensity = 'Bold' } },
          { Foreground = { AnsiColor = 'Fuchsia' } },
          { Text = 'Enter name for new workspace' },
        },
        action = wezterm.action_callback(function(window, pane, line)
          -- line will be `nil` if they hit escape without entering anything
          -- An empty string if they just hit enter
          -- Or the actual line of text they wrote
          if line then
            window:perform_action(
              wezterm.action.SwitchToWorkspace {
                name = line,
              },
              pane
            )
          end
        end),
      },
    },

  }
end

return M
