---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = "/home/dilip/.config/awesome/theme/"

local theme = {}

theme.font          = "Roboto 8"

theme.titlebar_size = 20
theme.wibar_width = 30

theme.bg_normal     = "#282A36"
theme.bg_focus      = "#BD93F9"
theme.bg_urgent     = "#FF5555"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#F8F8F2"
theme.fg_focus      = "#F8F8F2"
theme.fg_urgent     = "#F8F8F2"
theme.fg_minimize   = "#F8F8F2"

theme.useless_gap   = dpi(8)
theme.border_width  = dpi(2)
theme.border_normal = "#FF79C6"
theme.border_focus  = "#BD93F9"
theme.border_marked = "#91231c"

theme.titlebar_bg_normal = "#282A36"
theme.titlebar_bg_focus = "#282A36"
theme.titlebar_fg_focus = "#F8F8F2"
theme.titlebar_fg_normal = "#F8F8F2"

theme.taglist_bg_focus = theme.bg_focus
theme.taglist_fg_focus = theme.fg_focus
theme.taglist_bg_occupied = theme.bg_normal 
theme.taglist_fg_occupied = theme.border_normal

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
local taglist_square_size = dpi(1)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]
theme.notification_font = "Roboto 8"
theme.notification_width = 200
theme.notification_height = 70
theme.notification_margin = dpi(20)

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(20)
theme.menu_width  = dpi(150)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path.."icons/titlebar/close_normal.svg"
theme.titlebar_close_button_focus  = themes_path.."icons/titlebar/close_focus.svg"

theme.titlebar_minimize_button_normal = themes_path.."icons/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."icons/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."icons/titlebar/ontop_normal.svg"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."icons/titlebar/ontop_focus.svg"
theme.titlebar_ontop_button_normal_active = themes_path.."icons/titlebar/ontop_normal.svg"
theme.titlebar_ontop_button_focus_active  = themes_path.."icons/titlebar/ontop_focus.svg"

theme.titlebar_sticky_button_normal_inactive = themes_path.."icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."icons/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."icons/titlebar/floating_normal.svg"
theme.titlebar_floating_button_focus_inactive  = themes_path.."icons/titlebar/floating_focus.svg"
theme.titlebar_floating_button_normal_active = themes_path.."icons/titlebar/floating_normal.svg"
theme.titlebar_floating_button_focus_active  = themes_path.."icons/titlebar/floating_focus.svg"

theme.titlebar_maximized_button_normal_inactive = themes_path.."icons/titlebar/maximize_normal.svg"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."icons/titlebar/maximize_focus.svg"
theme.titlebar_maximized_button_normal_active = themes_path.."icons/titlebar/maximize_normal.svg"
theme.titlebar_maximized_button_focus_active  = themes_path.."icons/titlebar/maximize_focus.svg"

theme.wallpaper = themes_path .."background.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."icons/layouts/fairwide.svg"
theme.layout_fairv = themes_path.."icons/layouts/fair.svg"
theme.layout_floating  = themes_path.."icons/layouts/floating.svg"
-- theme.layout_magnifier = themes_path.."icons/layouts/magnifierw.svg"
theme.layout_max = themes_path.."icons/layouts/max.svg"
theme.layout_fullscreen = themes_path.."icons/layouts/full.svg"
theme.layout_tilebottom = themes_path.."icons/layouts/tilebottom.svg"
theme.layout_tileleft   = themes_path.."icons/layouts/tileleft.svg"
theme.layout_tile = themes_path.."icons/layouts/tile.svg"
theme.layout_tiletop = themes_path.."icons/layouts/tiletop.svg"
theme.layout_spiral  = themes_path.."icons/layouts/spiral.svg"
theme.layout_dwindle = themes_path.."icons/layouts/dwindle.svg"
-- theme.layout_cornernw = themes_path.."icons/layouts/cornernww.svg"
-- theme.layout_cornerne = themes_path.."icons/layouts/cornernew.svg"
-- theme.layout_cornersw = themes_path.."icons/layouts/cornersww.svg"
-- theme.layout_cornerse = themes_path.."icons/layouts/cornersew.svg"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
