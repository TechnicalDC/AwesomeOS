
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")			
local beautiful = require("beautiful")	
local naughty = require("naughty")		
local dpi = beautiful.xresources.apply_dpi

calendar = {}

calendar.create = function(s)
	-- Text clock widget for panel
	mytextclock = wibox.widget.textclock("<span size='large'>%H\n%M</span>")

	awful.tooltip({
		objects = {mytextclock},
		mode = "outside",
		align = "right",
		timer_function = function()
			return os.date(" %B %d, %Y ")
		end,
		preferred_positions = {"right", "left", "top", "bottom"},
		margin_leftright = dpi(8),
		margin_topbottom = dpi(8)
   })

	mycalendar = wibox.widget.calendar.month(os.date("*t"))

	cal_margin = wibox.container.margin(mycalendar, {margins = 5})

	mycalendar_popup = awful.popup {
		widget = cal_margin,
		border_color = '#00ff00',
		border_width = 2,
		placement    = awful.placement.top_left(mycalendar_popup, { top = 10,}),
		shape        = gears.shape.rounded_rect,
		visible      = true,
	}

	mytextclock.connect_signal("button::press",function()
		if button == 1 then
			mycalendar_popup.visible = not mycalendar_popup.visible
		end
	end)

	return mytextclock
end

-- return calendar
