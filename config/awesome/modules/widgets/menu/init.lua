xdg_menu = require("modules.widgets.menu.arch_menu")

local m = {}

local function build_awesome_menu(variables)
	return {
		" Awesome",
		{
			{
				"󰌌 Hotkeys",
				function()
					hotkeys_popup.show_help(nil, awful.screen.focused())
				end,
			},
			{ " Manual", variables.terminal .. " -e man awesome" },
			{ "󱞁 Edit Config", variables.editor_cmd .. " " .. awesome.conffile, },
			{ "󰜉 Restart", awesome.restart },
			{
				"󰗼 Quit",
				function()
					awesome.quit()
				end,
			},
		},
	}
end

local function build_terminal_menu(variables)
	return {
		" Open terminal",
		variables.terminal,
	}
end

local function build_applications_menu()
	return {
		" Applications",
		xdgmenu
	}
end

m.setup = function(variables)
	local entries = {}
	entries.terminal = build_terminal_menu(variables)
	entries.awesome = build_awesome_menu(variables)
	entries.applications = build_applications_menu()
	return entries
end

return m
