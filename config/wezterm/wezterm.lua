local wezterm = require("wezterm")
local colors = require("colors")
local env = require("env")

local config = {}

config.enable_wayland = false
-- Font
config.font = wezterm.font("JetBrains Mono")
config.font_size = 14.0
config.line_height = 1.25
config.warn_about_missing_glyphs = false
-- I hate stacking windows
local operating_system = env.getOS()
if operating_system == "Windows" then
	config.default_prog = { "powershell.exe" }
	config.window_background_opacity = 1
else
	config.window_background_opacity = 0.9
end
-- Tab bar
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = false
config.tab_max_width = 32
-- Scollbar
config.scrollback_lines = 3500
config.enable_scroll_bar = false
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
			bg_color = colors.color1,
			-- The color of the text for the tab
			fg_color = colors.background_color,

			-- Specify whether you want "Half", "Normal" or "Bold" intensity for the
			-- label shown for this tab.
			-- The default is "Normal"
			intensity = "Normal",

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

local escape_pop_key = { key = "Escape", action = "PopKeyTable" }
local enter_pop_key = { key = "Enter", action = "PopKeyTable" }

-- Modes
config.key_tables = {
	tab_mode = {
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
	},
	pane_mode = {
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
	},
	resize_mode = {
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
		escape_pop_key,
		enter_pop_key,
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
		enter_pop_key,
	},
	move_mode = {
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
		},
		escape_pop_key,
		enter_pop_key,
	},
	workspace_mode = {
		{
			key = "w",
			action = wezterm.action_callback(function(window, pane)
				-- Here you can dynamically construct a longer list if needed
				local home = wezterm.home_dir
				local workspaces = {
					{ id = home .. "/default", label = "default" },
					{ id = home .. "/notes", label = "notes" },
					{ id = home .. "/work", label = "work" },
					{ id = home .. "/personal", label = "personal" },
					{ id = home .. "/.config", label = "config" },
				}

				window:perform_action(
					wezterm.action.InputSelector({
						action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
							if not id and not label then
								wezterm.log_info("cancelled")
							else
								wezterm.log_info("id = " .. id)
								wezterm.log_info("label = " .. label)
								inner_window:perform_action(
									wezterm.action.SwitchToWorkspace({
										name = label,
										spawn = {
											label = "Workspace: " .. label,
											cwd = id,
										},
									}),
									inner_pane
								)
							end
						end),
						title = "Choose Workspace",
						choices = workspaces,
						fuzzy = true,
						fuzzy_description = "Fuzzy find and/or make a workspace",
					}),
					pane
				)
			end),
		},
		{
			key = "f",
			action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
		},
		{
			key = "s",
			action = wezterm.action.PromptInputLine({
				description = wezterm.format({
					{ Attribute = { Intensity = "Bold" } },
					{ Foreground = { AnsiColor = "Fuchsia" } },
					{ Text = "Enter name for new workspace" },
				}),
				action = wezterm.action_callback(function(window, pane, line)
					-- line will be `nil` if they hit escape without entering anything
					-- An empty string if they just hit enter
					-- Or the actual line of text they wrote
					if line then
						if line ~= "" then
							window:perform_action(
								wezterm.action.SwitchToWorkspace({
									name = line,
								}),
								pane
							)
						else
							window:perform_action(
								wezterm.action.SwitchToWorkspace({
									name = "default",
								}),
								pane
							)
						end
					end
				end),
			}),
		},
		{
			key = "n",
			action = wezterm.action.PromptInputLine({
				description = wezterm.format({
					{ Attribute = { Intensity = "Bold" } },
					{ Foreground = { AnsiColor = "Fuchsia" } },
					{ Text = "Enter name for new workspace" },
				}),
				action = wezterm.action_callback(function(window, pane, line)
					-- line will be `nil` if they hit escape without entering anything
					-- An empty string if they just hit enter
					-- Or the actual line of text they wrote
					if line then
						window:perform_action(
							wezterm.action.SwitchToWorkspace({
								name = line,
							}),
							pane
						)
					end
				end),
			}),
		},
	},
}
-- Base keybinds
config.keys = {
	{
		mods = "LEADER",
		key = "o",
		action = wezterm.action.ActivateCommandPalette,
	},
	{
		mods = "LEADER",
		key = "p",
		action = wezterm.action.ActivateKeyTable({ name = "pane_mode", timeout_milliseconds = mode_timeout }),
	},
	{
		mods = "LEADER",
		key = "t",
		action = wezterm.action.ActivateKeyTable({ name = "tab_mode", timeout_milliseconds = mode_timeout }),
	},
	{
		mods = "LEADER",
		key = "r",
		action = wezterm.action.ActivateKeyTable({
			name = "resize_mode",
			timeout_milliseconds = mode_timeout,
			one_shot = false,
		}),
	},
	{
		mods = "LEADER",
		key = "m",
		action = wezterm.action.ActivateKeyTable({
			name = "move_mode",
			timeout_milliseconds = mode_timeout,
			one_shot = false,
		}),
	},
	{
		mods = "LEADER",
		key = "s",
		action = wezterm.action.ActivateKeyTable({ name = "search_mode", one_shot = false }),
	},
	{
		mods = "LEADER",
		key = "q",
		action = wezterm.action.QuickSelect,
	},
	{
		mods = "LEADER",
		key = "w",
		action = wezterm.action.ActivateKeyTable({ name = "workspace_mode", timeout_milliseconds = mode_timeout }),
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
		leader = " LDR"
	end
	if window:active_key_table() then
		mode = " " .. string.upper(window:active_key_table())
	end
	window:set_right_status(wezterm.format({
		{ Background = { Color = colors.color1 } },
		{ Foreground = { Color = colors.background_color } },
		{ Text = leader },
		{ Background = { Color = colors.color1 } },
		{ Foreground = { Color = colors.background_color } },
		{ Text = mode },
		{ Background = { Color = colors.color1 } },
		{ Foreground = { Color = colors.background_color } },
		{ Text = " " .. window:active_workspace() },
	}))
end)

return config
