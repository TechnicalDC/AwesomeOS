
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")									-- Widget and layout library
local beautiful = require("beautiful")							-- Theme handling library
local naughty = require("naughty")								-- Notification library
local theme = require("theme.theme")
local dpi = beautiful.xresources.apply_dpi
local xresources = require("beautiful.xresources")
local x = xresources.get_current_theme()

local logout_popup = awful.popup {
    widget = {
        {
            {
                text   = 'foobar',
                widget = wibox.widget.textbox
            },
            {
                {
                    text   = 'foobar',
                    widget = wibox.widget.textbox
                },
                bg     = '#ff00ff',
                clip   = true,
                shape  = gears.shape.rounded_bar,
                widget = wibox.widget.background
            },
            {
                value         = 0.5,
                forced_height = 30,
                forced_width  = 100,
                widget        = wibox.widget.progressbar
            },
            layout = wibox.layout.fixed.horizontal,
        },
        margins = 10,
        widget  = wibox.container.margin
    },
    border_color = tPurple,
    border_width = theme.border_width,
	ontop = true,
    placement    = awful.placement.centered,
    visible      = false,
}

local onlogout = function () awesome.quit() end
local onlock = function() awful.spawn.with_shell("mantablockscreen -cc") end
local onreboot = function() awful.spawn.with_shell("systemctl reboot") end
local onreload = function() awesome.restart() end
local onpoweroff = function() awful.spawn.with_shell("systemctl poweroff") end

local menu_items = {
	{ name = ' Log out',  command = onlogout },
	{ name = ' Lock', command = onlock },
	{ name = ' Reboot',  command = onreboot },
	{ name = ' Reload', command = onreload },
	{ name = ' Power off', command = onpoweroff },
}

function popup_toggle()
	logout_popup.visible = not logout_popup.visible
end
