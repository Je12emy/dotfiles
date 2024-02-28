local wezterm = require("wezterm")

local M = {}

local mode_timeout = 3000
local leader_timeout = 2000

local escape_pop_key = { key = "Escape", action = 'PopKeyTable' }
local enter_pop_key = { key = "Enter", action = 'PopKeyTable' }

M.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = leader_timeout }

M.key_tables = {
  tab_mode = {
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
  },
  pane_mode = {
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
  },
  resize_mode = {
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
    escape_pop_key,
    enter_pop_key
  },
  move_mode = {
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
    escape_pop_key,
    enter_pop_key
  },
  workspace_mode = {
    {
      key = "f",
      action = wezterm.action.ShowLauncherArgs { flags = 'WORKSPACES' },
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
  },
  search_mode = {
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
    escape_pop_key,
    enter_pop_key
  }
}


M.maps = {
  {
    mods = "LEADER",
    key = "o",
    action = wezterm.action.ActivateCommandPalette,
  },
  {
    mods = "LEADER",
    key = "p",
    action = wezterm.action.ActivateKeyTable { name = "pane_mode", timeout_milliseconds = mode_timeout },
  },
  {
    mods = "LEADER",
    key = "t",
    action = wezterm.action.ActivateKeyTable { name = "tab_mode", timeout_milliseconds = mode_timeout },
  },
  {
    mods = "LEADER",
    key = "r",
    action = wezterm.action.ActivateKeyTable { name = "resize_mode", timeout_milliseconds = mode_timeout, one_shot = false },
  },
  {
    mods = "LEADER",
    key = "m",
    action = wezterm.action.ActivateKeyTable { name = "move_mode", timeout_milliseconds = mode_timeout, one_shot = false },
  },
  {
    mods = "LEADER",
    key = "s",
    action = wezterm.action.ActivateKeyTable { name = "search_mode", timeout_milliseconds = mode_timeout, one_shot = false },
  },
  {
    mods = "LEADER",
    key = "q",
    action = wezterm.action.QuickSelect
  },
  {
    mods = "LEADER",
    key = 'w',
    action = wezterm.action.ActivateKeyTable { name = "workspace_mode", timeout_milliseconds = mode_timeout },
  },
  {
    mods = "LEADER",
    key = "F5",
    action = wezterm.action.ReloadConfiguration
  },
  {
    mods = "CTRL",
    key = "V",
    action = wezterm.action.PasteFrom "Clipboard"
  },
  {
    mods = "CTRL",
    key = "C",
    action = wezterm.action.CopyTo "Clipboard"
  }
}

return M
