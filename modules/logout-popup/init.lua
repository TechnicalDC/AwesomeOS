
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")									-- Widget and layout library
local beautiful = require("beautiful")							-- Theme handling library
local naughty = require("naughty")								-- Notification library
local theme = require("theme.theme")
local dpi = beautiful.xresources.apply_dpi
local xresources = require("beautiful.xresources")
local x = xresources.get_current_theme()

function setbutton (args) 
	local text_size = args.text_size or 10
	local color = args.color or tBg
	local fg_color = tFg
	local text = args.text
    local onclick = args.command or function() end

	local result = wibox.widget{
			{
				{
					markup = '<span size="' .. text_size .. '000" foreground="'
						.. fg_color .. '">' .. text ..'</span>',

					widget = wibox.widget.textbox
				},
				top = 4, bottom = 4, left = 8, right = 8,
				widget = wibox.container.margin
			},
			bg = color,
			shape = function(cr, width, height) gears.shape.rounded_rect(cr, width, height, 4) end,
			widget = wibox.container.background
		}

	local old_cursor, old_wibox
    result:connect_signal("mouse::enter", function(c)
		c:set_bg(tPurple)
        local wb = mouse.current_wibox
        old_cursor, old_wibox = wb.cursor, wb
        wb.cursor = "hand1"
    end)
    result:connect_signal("mouse::leave", function(c)
		c:set_bg(color)
        if old_wibox then
            old_wibox.cursor = old_cursor
            old_wibox = nil
        end
    end)

    result:connect_signal("button::press", function() onclick() end)

    return result
end

local format = "<span size='30000' foreground='" .. tFg .. "' background='" .. tBg ..  "'>%H\n%M</span>"

textclock = wibox.widget.textclock(format)

local dashboard = awful.popup {
    widget = {
		{
			layout = wibox.layout.fixed.vertical,
			textclock
		},
        margins = 10,
        widget  = wibox.container.margin
    },
    border_color = tPurple,
    border_width = theme.border_width,
	ontop = true,
	bg = tBg,
    placement    = awful.placement.centered,
    visible      = false,
}

local onlogout = function () awesome.quit() end
local onlock = function() awful.spawn.with_shell("mantablockscreen -cc") end
local onreboot = function() awful.spawn.with_shell("systemctl reboot") end
local onreload = function() awesome.restart() end
local onpoweroff = function() awful.spawn.with_shell("systemctl poweroff") end

local menu_items = {
	{ text = ' Log out',  command = onlogout },
	{ text = ' Lock', command = onlock },
	{ text = ' Reboot',  command = onreboot },
	{ text = ' Reload', command = onreload },
	{ text = ' Power off', command = onpoweroff },
}

for _, item in ipairs(menu_items) do
end


function dashboard_toggle()
	dashboard.visible = not dashboard.visible
end
