local wezterm = require("wezterm")
local env = require("env")
local config = {}

config.enable_wayland = false
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
config.hide_tab_bar_if_only_one_tab = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 32
-- Scollbar
config.scrollback_lines = 3500
-- Solve ugly issues when zooming in
config.adjust_window_size_when_changing_font_size = false
config.inactive_pane_hsb = {
	saturation = 1,
	brightness = 1,
}
local theme_name = 'Tokyo Night'
config.color_scheme = theme_name
local theme = wezterm.color.get_builtin_schemes()[theme_name]
-- First color is the same as the BG color
-- see: https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/wezterm/tokyonight.toml
local random_theme_accent = theme.ansi[math.random(2, #theme.ansi)]
-- NOTE:
-- see https://wezfurlong.org/wezterm/config/appearance.html#defining-your-own-colors
-- see: https://wezfurlong.org/wezterm/config/lua/wezterm.color/load_base16_scheme.html
config.colors = {
	split = theme.ansi[5],
	tab_bar = {
		background = theme.background,
		active_tab = {
			bg_color = random_theme_accent,
			fg_color = theme.background
		},
		inactive_tab = {
			bg_color = theme.background,
			fg_color = theme.foreground
		},

	}
}

-- Plugins
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
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

local tab_mode = {
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
	}
}

for i = 1, 9 do
	table.insert(tab_mode, {
		key = tostring(i),
		action = wezterm.action.ActivateTab(i - 1)
	})
end

-- Modes
config.key_tables = {
	["Tab"] = append_escape_keys(tab_mode),
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
	["Workspace"] = append_escape_keys({

		{ key = 'n', action = wezterm.action.SwitchToWorkspace },
		{
			key = "c",
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
		{
			key = "f",
			action = wezterm.action.ShowLauncherArgs {
				flags = 'FUZZY|WORKSPACES',
			},

		},
		{
			key = "r",
			action = wezterm.action.PromptInputLine {
				description = wezterm.format {
					{ Attribute = { Intensity = 'Bold' } },
					{ Foreground = { AnsiColor = 'Fuchsia' } },
					{ Text = 'Enter a new name for current workspace' },
				},
				action = wezterm.action_callback(function(_, _, line)
					if line then
						wezterm.mux.rename_workspace(
							wezterm.mux.get_active_workspace(),
							line
						)
					end
				end)
			}
		}
	})
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
		key = "w",
		action = wezterm.action.ActivateKeyTable({ name = "Workspace", one_shot = true }),
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
	{
		mods = "LEADER",
		key = "z",
		action = wezterm.action_callback(function(win, pane)
			resurrect.save_state(resurrect.workspace_state.get_workspace_state())
		end),
	},
	{
		key = "T",
		mods = "ALT",
		action = resurrect.tab_state.save_tab_action(),
	},
	{
		mods = "ALT",
		key = "r",
		action = wezterm.action_callback(function(win, pane)
			resurrect.fuzzy_load(win, pane, function(id, label)
				local type = string.match(id, "^([^/]+)") -- match before '/'
				id = string.match(id, "([^/]+)$") -- match after '/'
				id = string.match(id, "(.+)%..+$") -- remove file extention
				local opts = {
					relative = true,
					restore_text = true,
					on_pane_restore = resurrect.tab_state.default_on_pane_restore,
				}
				if type == "workspace" then
					local state = resurrect.load_state(id, "workspace")
					resurrect.workspace_state.restore_workspace(state, opts)
				elseif type == "window" then
					local state = resurrect.load_state(id, "window")
					resurrect.window_state.restore_window(pane:window(), state, opts)
				elseif type == "tab" then
					local state = resurrect.load_state(id, "tab")
					resurrect.tab_state.restore_tab(pane:tab(), state, opts)
				end
			end)
		end),
	}
}

-- Status bar
local icons = { "", "", "", "", "", "", "󰌽", "", "", "󰢚" }
local random_icon = icons[math.random(0, #icons)]
config.status_update_interval = 1000
wezterm.on("update-right-status", function(window, _)
	local leader = ""
	local mode = ""
	-- Show this simbol when LEADER is pressed
	if window:leader_is_active() then
		leader = " ☗ "
	end
	-- Prepend this simbol to the keytable
	if window:active_key_table() then
		local key_table = string.upper(window:active_key_table())
		if key_table == "SEARCH_MODE" then
			key_table = "SEARCH"
		elseif key_table == "COPY_MODE" then
			key_table = "COPY"
		end
		mode = "▶ " .. key_table .. " "
	end

	local active_workspace = string.upper(window:active_workspace())
	if active_workspace == "DEFAULT" then
		active_workspace = ""
	else
		active_workspace = " " .. random_icon .. " " .. active_workspace
	end

	-- Display the content
	window:set_right_status(wezterm.format({
		{ Text = leader },
		{ Text = mode },
		{ Foreground = { Color = theme.background } },
		{ Background = { Color = random_theme_accent } },
		{ Text = active_workspace },
	}))
end)

config.window_frame = {
	font_size = 10.0,
}

return config
