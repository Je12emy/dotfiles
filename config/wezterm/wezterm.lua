local wezterm = require("wezterm")
local colors = require("colors")
local env = require("env")

local config = {}

config.enable_wayland = true
-- config.window_frame = {
-- 	inactive_titlebar_bg = colors.color2,
-- 	inactive_titlebar_fg = colors.background_color,
-- 	inactive_titlebar_border_bottom = colors.color1,
--
-- 	active_titlebar_bg = colors.color2,
-- 	active_titlebar_fg = colors.background_color,
-- 	active_titlebar_border_bottom = colors.background_color,
--
-- 	button_fg = colors.background_color,
-- 	button_bg = colors.color2,
--
-- 	button_hover_fg = colors.background_color,
-- 	button_hover_bg = colors.color2,
-- }
-- Font
config.font = wezterm.font "JetBrains Mono"
config.font_size = 14.0
config.line_height = 1.25
config.warn_about_missing_glyphs = false
local operating_system = env.getOS()
if operating_system == "Windows" then
	config.default_prog = { "powershell.exe" }
end
-- Tab bar
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 32
-- Scollbar
config.scrollback_lines = 3500
-- Solve ugly issues when zooming in
config.adjust_window_size_when_changing_font_size = false
-- Theming
config.command_palette_bg_color = colors.background_color
config.command_palette_fg_color = colors.text_color
config.colors = {
	tab_bar = {
		-- The color of the strip that goes along the top of the window
		-- (does not apply when fancy tab bar is in use)
		background = 'none',

		-- The active tab is the one that has focus in the window
		active_tab = {
			-- The color of the background area for the tab
			bg_color = colors.background_color,
			-- The color of the text for the tab
			fg_color = colors.text_color,

			-- Specify whether you want "Half", "Normal" or "Bold" intensity for the
			-- label shown for this tab.
			-- The default is "Normal"
			intensity = "Bold",

			-- Specify whether you want "None", "Single" or "Double" underline for
			-- label shown for this tab.
			-- The default is "None"
			underline = "None",

			-- Specify whether you want the text to be italic (true) or not (false)
			-- for this tab.  The default is false.
			italic = false,

			-- Specify whether you want the text to be rendered with strikethrough (true)
			-- or not for this tab.  The default is false.
			strikethrough = false,
		},

		-- Inactive tabs are the tabs that do not have focus
		inactive_tab = {
			bg_color = colors.background_color,
			fg_color = colors.text_color,
			-- Specify whether you want "Half", "Normal" or "Bold" intensity for the
			-- label shown for this tab.
			-- The default is "Normal"
			intensity = "Half",
			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `inactive_tab`.
		},

		-- You can configure some alternate styling when the mouse pointer
		-- moves over inactive tabs
		inactive_tab_hover = {
			bg_color = colors.background_color,
			fg_color = colors.color1,
			italic = false,

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `inactive_tab_hover`.
		},

		-- The new tab button that let you create new tabs
		new_tab = {
			bg_color = colors.background_color,
			fg_color = colors.color1,

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `new_tab`.
		},

		-- You can configure some alternate styling when the mouse pointer
		-- moves over the new tab button
		new_tab_hover = {
			bg_color = colors.color1,
			fg_color = colors.background_color,
			italic = false,
			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `new_tab_hover`.
		},
	},
}

-- Keybinds
local mode_timeout = 3000
local leader_timeout = 2000
config.disable_default_key_bindings = true
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = leader_timeout }

local escape_keybinds = {
	{ key = "Escape", action = "PopKeyTable" },
	{ key = "Enter",  action = "PopKeyTable" }
}

local function append_escape_keys(mode)
	for i = 1, #escape_keybinds do
		mode[#mode + 1] = escape_keybinds[i]
	end
	return mode
end

-- Modes
config.key_tables = {
	["Tab"] = append_escape_keys({
		{
			key = "n",
			action = wezterm.action.SpawnTab("DefaultDomain"),
		},
		{
			key = "}",
			action = wezterm.action.ActivateTabRelative(1),
		},
		{
			key = "{",
			action = wezterm.action.ActivateTabRelative(-1),
		},
		{
			key = "x",
			action = wezterm.action.CloseCurrentTab({ confirm = true }),
		},
		{
			key = "r",
			action = wezterm.action.PromptInputLine({
				description = "Enter new name for tab",
				action = wezterm.action_callback(function(window, _, line)
					-- line will be `nil` if they hit escape without entering anything
					-- An empty string if they just hit enter
					-- Or the actual line of text they wrote
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},
	}),
	["Pane"] = append_escape_keys({
		{
			key = "j",
			action = wezterm.action.ActivatePaneDirection("Down"),
		},
		{
			key = "k",
			action = wezterm.action.ActivatePaneDirection("Up"),
		},
		{
			key = "l",
			action = wezterm.action.ActivatePaneDirection("Right"),
		},
		{
			key = "h",
			action = wezterm.action.ActivatePaneDirection("Left"),
		},
		{
			key = "x",
			action = wezterm.action.CloseCurrentPane({ confirm = true }),
		},
		{
			key = "z",
			action = wezterm.action.TogglePaneZoomState,
		},
		{
			key = "r",
			action = wezterm.action.SplitPane({
				direction = "Right",
				size = { Percent = 50 },
			}),
		},
		{
			key = "d",
			action = wezterm.action.SplitPane({
				direction = "Down",
				size = { Percent = 50 },
			}),
		},
	}),
	["Resize"] = append_escape_keys({
		{
			key = "h",
			action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
		},
		{
			key = "l",
			action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
		},
		{
			key = "j",
			action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
		},
		{
			key = "k",
			action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
		},
	}),
	["Scroll"] = append_escape_keys({
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
		{
			key = "s",
			action = wezterm.action.Search("CurrentSelectionOrEmptyString")
		},
		{
			key = "p",
			action = wezterm.action.ActivateCopyMode
		},
	}),
	search_mode = {
		{ key = 'Escape', mods = 'NONE', action = wezterm.action.CopyMode 'Close' },
		{ key = 'n',      mods = 'CTRL', action = wezterm.action.CopyMode 'NextMatch' },
		{ key = 'p',      mods = 'CTRL', action = wezterm.action.CopyMode 'PriorMatch' },
	},
	copy_mode = {
		{ key = 'h', mods = 'NONE', action = wezterm.action.CopyMode 'MoveLeft' },
		{ key = 'j', mods = 'NONE', action = wezterm.action.CopyMode 'MoveDown' },
		{ key = 'k', mods = 'NONE', action = wezterm.action.CopyMode 'MoveUp' },
		{ key = 'l', mods = 'NONE', action = wezterm.action.CopyMode 'MoveRight' },
		{ key = 'w', mods = 'NONE', action = wezterm.action.CopyMode 'MoveForwardWord' },
		{
			key = 'b',
			action = wezterm.action.CopyMode 'MoveBackwardWord',
		},
		{
			key = 'd',
			mods = 'CTRL',
			action = wezterm.action.CopyMode { MoveByPage = 0.5 },
		},
		{
			key = 'u',
			mods = 'CTRL',
			action = wezterm.action.CopyMode { MoveByPage = -0.5 },
		},
		{
			key = 'y',
			mods = 'NONE',
			action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection',
		},
		{
			key = 'v',
			mods = 'NONE',
			action = wezterm.action.CopyMode { SetSelectionMode = 'Cell' },
		},
		{
			key = 'v',
			mods = 'CTRL',
			action = wezterm.action.CopyMode { SetSelectionMode = 'Block' },
		},
		{ key = 'Escape', mods = 'NONE', action = wezterm.action.CopyMode 'Close' },
	},
	["Move"] = append_escape_keys({
		{
			key = "g",
			action = wezterm.action.PaneSelect({}),
		},
		{
			key = "s",
			action = wezterm.action.PaneSelect({
				mode = "SwapWithActive",
			}),
		},
		{
			key = "}",
			action = wezterm.action.MoveTabRelative(1),
		},
		{
			key = "{",
			action = wezterm.action.MoveTabRelative(-1),
		}
	}),
}
-- Root keybinds
config.keys = {
	{
		mods = "LEADER",
		key = "o",
		action = wezterm.action.ActivateCommandPalette,
	},
	{
		mods = "LEADER",
		key = "p",
		action = wezterm.action.ActivateKeyTable({ name = "Pane", timeout_milliseconds = mode_timeout }),
	},
	{
		mods = "LEADER",
		key = "t",
		action = wezterm.action.ActivateKeyTable({ name = "Tab", timeout_milliseconds = mode_timeout }),
	},
	{
		mods = "LEADER",
		key = "r",
		action = wezterm.action.ActivateKeyTable({
			name = "Resize",
			timeout_milliseconds = mode_timeout,
			one_shot = false,
		}),
	},
	{
		mods = "LEADER",
		key = "m",
		action = wezterm.action.ActivateKeyTable({
			name = "Move",
			timeout_milliseconds = mode_timeout,
			one_shot = false,
		}),
	},
	{
		mods = "LEADER",
		key = "s",
		action = wezterm.action.ActivateKeyTable({ name = "Scroll", one_shot = false }),
	},
	{
		mods = "LEADER",
		key = "f",
		action = wezterm.action.Search('CurrentSelectionOrEmptyString'),
	},
	{
		mods = "LEADER",
		key = "Space",
		action = wezterm.action.QuickSelect,
	},
	{
		mods = "LEADER",
		key = "F5",
		action = wezterm.action.ReloadConfiguration,
	},
	{
		mods = "CTRL",
		key = "V",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
	{
		mods = "CTRL",
		key = "C",
		action = wezterm.action.CopyTo("Clipboard"),
	},
	{
		mods = "CTRL",
		key = "+",
		action = wezterm.action.IncreaseFontSize,
	},
	{
		mods = "CTRL",
		key = "-",
		action = wezterm.action.DecreaseFontSize,
	},
}

-- Status bar
config.status_update_interval = 1000
wezterm.on("update-right-status", function(window, _)
	local leader = ""
	local mode = ""
	if window:leader_is_active() then
		leader = " ☗ "
	end
	if window:active_key_table() then
		mode = "▶ " .. string.upper(window:active_key_table()) .. " "
	end
	window:set_right_status(wezterm.format({
		{ Background = { Color = colors.background_color } },
		{ Foreground = { Color = colors.text_color } },
		{ Text = leader },
		{ Background = { Color = colors.background_color } },
		{ Foreground = { Color = colors.text_color } },
		{ Text = mode },
		-- { Background = { Color = colors.background_color } },
		-- { Foreground = { Color = colors.text_color } },
		-- { Text = " " .. window:active_workspace() },
	}))
end)

wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
	local zoomed = ''
	if tab.active_pane.is_zoomed then
		zoomed = '[Z] '
	end

	local index = ''
	if #tabs > 1 then
		index = string.format('[%d/%d] ', tab.tab_index + 1, #tabs)
	end

	-- return zoomed .. index .. tab.active_pane.title
	return ""
end)

return config
