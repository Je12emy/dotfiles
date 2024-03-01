local wezterm = require("wezterm")

local tab = require("key_tables.tab")
local pane = require("key_tables.pane")
local resize = require("key_tables.resize")
local move = require("key_tables.move")
local workspace = require("key_tables.workspace")
local search = require("key_tables.search")

local M = {}

local mode_timeout = 3000
local leader_timeout = 2000

local mode_settings = {}
mode_settings.escape_pop_key = { key = "Escape", action = 'PopKeyTable' }
mode_settings.enter_pop_key = { key = "Enter", action = 'PopKeyTable' }

M.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = leader_timeout }

M.key_tables = {
  tab_mode = tab.table_mode(),
  pane_mode = pane.pane_mode(),
  resize_mode = resize.resize_mode(mode_settings),
  move_mode = move.move_mode(mode_settings),
  workspace_mode = workspace.workspace(),
  search_mode = search.search_mode(mode_settings)
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
    action = wezterm.action.ActivateKeyTable { name = "search_mode", one_shot = false },
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
  },
  {
    mods = "CTRL",
    key = "+",
    action = wezterm.action.IncreaseFontSize
  },
  {
    mods = "CTRL",
    key = "-",
    action = wezterm.action.DecreaseFontSize
  }
}

return M
