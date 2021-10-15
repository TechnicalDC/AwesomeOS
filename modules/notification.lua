
local gears = require("gears")
local wibox = require("wibox")									-- Widget and layout library
local beautiful = require("beautiful")							-- Theme handling library
local naughty = require("naughty")								-- Notification library
local dpi = beautiful.xresources.apply_dpi

-- Defaults
naughty.config.defaults.ontop = true
naughty.config.defaults.icon_size = dpi(32)
naughty.config.defaults.timeout = 5
naughty.config.defaults.title = "System Notification"
naughty.config.defaults.margin = dpi(10)
naughty.config.defaults.border_width = 2
naughty.config.defaults.position = "top_right"
naughty.config.defaults.shape = function(cr, w, h)
		gears.shape.rounded_rect(cr, w, h, dpi(8))
end

--
naughty.config.padding = dpi(10)
naughty.config.spacing = dpi(5)
naughty.config.icon_dirs = {
	'/home/dilip/.icons/Fluent-purple-dark',
	'/home/dilip/.icons/Qogir-dark'
}
naughty.config.icon_format = {'svg', 'png', 'jpg'}
