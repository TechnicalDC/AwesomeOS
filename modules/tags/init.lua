
-- TAGS

local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")			
local beautiful = require("beautiful")	
local naughty = require("naughty")		
local icon_path = "/home/dilip/.config/awesome/theme/icons/taglist"

function addtags(s)
	awful.tag.add("1", {
		icon = icon_path .. "web.svg",
		layout =  awful.layout.layouts[1],
		screen = s,
	})

	awful.tag.add("2", {
		icon = icon_path .. "dev.svg",
		layout =  awful.layout.layouts[1],
		screen = s,
	})

	awful.tag.add("3", {
		icon = icon_path .. "sys.svg",
		layout =  awful.layout.layouts[1],
		screen = s,
	})

	awful.tag.add("4", {
		icon = icon_path .. "chat.svg",
		layout =  awful.layout.layouts[1],
		screen = s,
	})

	awful.tag.add("5", {
		icon = icon_path .. "",
		layout =  awful.layout.layouts[1],
		screen = s,
	})

	awful.tag.add("6", {
		icon = icon_path .. "",
		layout =  awful.layout.layouts[1],
		screen = s,
	})

	awful.tag.add("7", {
		icon = icon_path .. "",
		layout =  awful.layout.layouts[1],
		screen = s,
	})

	awful.tag.add("8", {
		icon = icon_path .. "",
		layout =  awful.layout.layouts[1],
		screen = s,
	})

	awful.tag.add("9", {
		icon = icon_path .. "",
		layout =  awful.layout.layouts[1],
		screen = s,
	})

end
