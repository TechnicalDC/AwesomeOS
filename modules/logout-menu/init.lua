
local gears = require("gears")
local wibox = require("wibox")									-- Widget and layout library
local beautiful = require("beautiful")							-- Theme handling library
local awful = require("awful")
local naughty = require("naughty")								-- Notification library
local theme = require("theme.theme")
local dpi = beautiful.xresources.apply_dpi
local xresources = require("beautiful.xresources")
local x = xresources.get_current_theme()

local logout_menu_widget = wibox.widget {
    {
        {
			text = "",
			font = icon_font,
            resize = true,
            widget = wibox.widget.textbox,
        },
        margins = 4,
        layout = wibox.container.margin
    },
    widget = wibox.container.background,
}


local popup = awful.popup {
    ontop = true,
    visible = false,
    -- shape = function(cr, width, height)
    --     gears.shape.rounded_rect(cr, width, height, 4)
    -- end,
    border_width = 2,
    -- border_color = beautiful.bg_focus,
    maximum_width = 400,
    offset = { y = 5 },
    widget = {}
}

local function worker(user_args)

end

return setmetatable(logout_menu_widget, { __call = function(_, ...) return worker(...) end })
