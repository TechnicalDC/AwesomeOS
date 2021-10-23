
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")			
local beautiful = require("beautiful")	
local naughty = require("naughty")		

local calendar = {}

mycalendar = wibox.widget.calendar.month
mycalendar.date = os.date("*t")

mycalendar_popup = awful.popup {
	mycalendar,
}

local calendar.toggle = function()

end
