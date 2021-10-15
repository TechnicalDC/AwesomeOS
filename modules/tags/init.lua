
-- TAGS

local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")									-- Widget and layout library
local beautiful = require("beautiful")							-- Theme handling library
local naughty = require("naughty")								-- Notification library
local icon_path = "/home/dilip/.config/awesome/theme/icons/taglist"


awful.tag.add("1", {
	icon = icon_path .. "web.svg",
	layout =  awful.layout.layouts[1],
})

awful.tag.add("2", {
	icon = "",
	layout =  awful.layout.layouts[1],
})

awful.tag.add("3", {
	icon = "",
	layout =  awful.layout.layouts[1],
})

awful.tag.add("4", {
	icon = "",
	layout =  awful.layout.layouts[1],
})

awful.tag.add("5", {
	icon = "",
	layout =  awful.layout.layouts[1],
})

awful.tag.add("6", {
	icon = "",
	layout =  awful.layout.layouts[1],
})

awful.tag.add("7", {
	icon = "",
	layout =  awful.layout.layouts[1],
})

awful.tag.add("8", {
	icon = "",
	layout =  awful.layout.layouts[1],
})

awful.tag.add("9", {
	icon = "",
	layout =  awful.layout.layouts[1],
})
