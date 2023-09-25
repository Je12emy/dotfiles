local files = require("modules.helpers.files")
local xresources = require("beautiful.xresources")
local gears = require("gears")
local fs = require("gears.filesystem")
local dpi = xresources.apply_dpi
local beautiful = require("beautiful")
local _ = require("modules.helpers.debug")

local font_name = "JetBrainsMonoNerdFontPropo"
local font_size = 12
local font = font_name .. " " .. font_size

local function get_theme_variables(name)
    local require_path = "modules.themes." .. name
    local ok, theme_variables = pcall(require, require_path)
    if not ok then
        local _, default_theme_variables = pcall(require, "default")
        return default_theme_variables
    end
    return theme_variables
end

local function init_theme(theme, colors, assets_path)
    -- Wibox: https://awesomewm.org/doc/api/classes/wibox.html#Theme_variables
    theme.bg_focus = colors.bg
    theme.bg_urgent = colors.urgent
    theme.bg_minimize = colors.primary
    theme.bg_normal = colors.bg
    theme.fg_normal = colors.fg
    theme.fg_focus = colors.fg
    theme.fg_urgent = colors.urgent
    theme.fg_minimize = colors.bg
    -- Systray: https://awesomewm.org/doc/api/classes/wibox.widget.systray.html#Methods
    theme.bg_systray = colors.bg
    theme.systray_icon_spacing = dpi(2.5)
    -- Beautiful: https://awesomewm.org/doc/api/libraries/beautiful.html#Theme_variables
    theme.border_normal = colors.bg
    theme.border_focus = colors.primary
    theme.border_marked = colors.urgent
    theme.useless_gap = dpi(1)
    theme.border_width = dpi(2)
    -- Tag List: https://awesomewm.org/doc/api/classes/awful.widget.taglist.html#Theme_variables
    theme.taglist_bg_focus = colors.primary
    theme.taglist_fg_focus = colors.bg
    theme.taglist_bg_urgent = colors.urgent
    theme.taglist_fg_urgent = colors.bg
    -- Task List: https://awesomewm.org/doc/api/classes/awful.widget.tasklist.html#Theme_variables
    theme.tasklist_disable_icon = true
    theme.tasklist_bg_focus = colors.primary
    theme.tasklist_fg_focus = colors.bg
    theme.tasklist_bg_minimize = colors.bg
    theme.tasklist_fg_minimize = colors.fg
    theme.tasklist_bg_urgent = colors.urgent
    theme.tasklist_fg_urgent = colors.fg
    theme.tasklist_plain_task_name = true
    -- Tooltip: https://awesomewm.org/doc/api/classes/awful.tooltip.html#Theme_variables
    theme.notification_width = dpi(448)
    theme.notification_icon_size = dpi(64)
    theme.tooltip_bg = colors.bg
    theme.tooltip_fg = colors.fg
    -- Menu: https://awesomewm.org/doc/api/libraries/awful.menu.html
    theme.menu_height = dpi(15)
    theme.menu_width = dpi(100)
    theme.menu_submenu_icon = assets_path .. "submenu.png"
    -- Icon
    -- theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)
    -- theme.menu_icon = assets_path .. "menu_icon.png"
    -- Layout icons
    theme.layout_fairh = assets_path .. "layouts/fairhw.png"
    theme.layout_fairv = assets_path .. "layouts/fairvw.png"
    theme.layout_floating = assets_path .. "layouts/floatingw.png"
    theme.layout_magnifier = assets_path .. "layouts/magnifierw.png"
    theme.layout_max = assets_path .. "layouts/maxw.png"
    theme.layout_fullscreen = assets_path .. "layouts/fullscreenw.png"
    theme.layout_tilebottom = assets_path .. "layouts/tilebottomw.png"
    theme.layout_tileleft = assets_path .. "layouts/tileleftw.png"
    theme.layout_tile = assets_path .. "layouts/tilew.png"
    theme.layout_tiletop = assets_path .. "layouts/tiletopw.png"
    theme.layout_spiral = assets_path .. "layouts/spiralw.png"
    theme.layout_dwindle = assets_path .. "layouts/dwindlew.png"
    theme.layout_cornernw = assets_path .. "layouts/cornernww.png"
    theme.layout_cornerne = assets_path .. "layouts/cornernew.png"
    theme.layout_cornersw = assets_path .. "layouts/cornersww.png"
    theme.layout_cornerse = assets_path .. "layouts/cornersew.png"
    -- Titlebar
    theme.titlebar_close_button_normal = assets_path .. "titlebar/close_normal.png"
    theme.titlebar_close_button_focus = assets_path .. "titlebar/close_focus.png"
    theme.titlebar_minimize_button_normal = assets_path .. "titlebar/minimize_normal.png"
    theme.titlebar_minimize_button_focus = assets_path .. "titlebar/minimize_focus.png"
    theme.titlebar_ontop_button_normal_inactive = assets_path .. "titlebar/ontop_normal_inactive.png"
    theme.titlebar_ontop_button_focus_inactive = assets_path .. "titlebar/ontop_focus_inactive.png"
    theme.titlebar_ontop_button_normal_active = assets_path .. "titlebar/ontop_normal_active.png"
    theme.titlebar_ontop_button_focus_active = assets_path .. "titlebar/ontop_focus_active.png"
    theme.titlebar_sticky_button_normal_inactive = assets_path .. "titlebar/sticky_normal_inactive.png"
    theme.titlebar_sticky_button_focus_inactive = assets_path .. "titlebar/sticky_focus_inactive.png"
    theme.titlebar_sticky_button_normal_active = assets_path .. "titlebar/sticky_normal_active.png"
    theme.titlebar_sticky_button_focus_active = assets_path .. "titlebar/sticky_focus_active.png"
    theme.titlebar_floating_button_normal_inactive = assets_path .. "titlebar/floating_normal_inactive.png"
    theme.titlebar_floating_button_focus_inactive = assets_path .. "titlebar/floating_focus_inactive.png"
    theme.titlebar_floating_button_normal_active = assets_path .. "titlebar/floating_normal_active.png"
    theme.titlebar_floating_button_focus_active = assets_path .. "titlebar/floating_focus_active.png"
    theme.titlebar_maximized_button_normal_inactive = assets_path .. "titlebar/maximized_normal_inactive.png"
    theme.titlebar_maximized_button_focus_inactive = assets_path .. "titlebar/maximized_focus_inactive.png"
    theme.titlebar_maximized_button_normal_active = assets_path .. "titlebar/maximized_normal_active.png"
    theme.titlebar_maximized_button_focus_active = assets_path .. "titlebar/maximized_focus_active.png"
end

local m = {}

m.available_themes = {
    catpuccin = { name = "catpuccin", dir = "/catpuccin" },
    default = { name = "default", dir = "/default" }
}

m.get_theme = function(name)
    local theme = {}
    local home_dir = os.getenv("HOME")
    local themes_dir = home_dir .. "/.config/awesome/modules/themes"
    local base_assets_dir = themes_dir .. "/base_assets/"
    local selected_theme_dir = themes_dir .. m.available_themes[name].dir
    local theme_variables = get_theme_variables(name)
    local wallpaper_path = selected_theme_dir .. "/wallpapers"
    local has_wallpapers = fs.dir_readable(selected_theme_dir .. "/wallpapers")
    theme.font = font
    if not (has_wallpapers) then
        local shared_wallpapers_dir = home_dir .. "/Pictures/wallpapers"
        theme.wallpaper = files.pick_wallpaper(shared_wallpapers_dir)
    else
        theme.wallpaper = files.pick_wallpaper(wallpaper_path)
    end
    init_theme(theme, theme_variables.colors, base_assets_dir)
    return theme
end

m.set_wallpaper = function(screen)
	-- Wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(screen)
		end
		gears.wallpaper.maximized(wallpaper, screen, true)
	end
end
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", m.set_wallpaper)

return m
