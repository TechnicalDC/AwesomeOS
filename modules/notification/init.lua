
local gears = require("gears")
local wibox = require("wibox")									-- Widget and layout library
local beautiful = require("beautiful")							-- Theme handling library
local naughty = require("naughty")								-- Notification library
local theme = require("theme.theme")
local dpi = beautiful.xresources.apply_dpi
local xresources = require("beautiful.xresources")
local x = xresources.get_current_theme()

-- Defaults
naughty.config.defaults.ontop = true
naughty.config.defaults.icon_size = dpi(32)
naughty.config.defaults.timeout = 5
naughty.config.defaults.title = "System Notification"
naughty.config.defaults.margin = dpi(10)
naughty.config.defaults.border_width = 2
naughty.config.defaults.border_color = tPurple
naughty.config.defaults.position = "top_right"
naughty.config.defaults.shape = function(cr, w, h)
		gears.shape.rounded_rect(cr, w, h, dpi(0))
end

--
naughty.config.padding = dpi(10)
naughty.config.spacing = dpi(5)
naughty.config.icon_dirs = {
	'/home/dilip/.icons/Fluent-purple-dark',
	'/home/dilip/.icons/Qogir-dark'
}
naughty.config.icon_format = {'svg', 'png', 'jpg'}

local default_icon = ""
local urgency_color = {
    ['low'] = x.color2,
    ['normal'] = x.color4,
    ['critical'] = x.color11,
}

local app_config = {
    -- ['battery'] = { icon = "", title = false },
    -- ['charger'] = { icon = "", title = false },
    -- ['volume'] = { icon = "", title = false },
    -- ['brightness'] = { icon = "", title = false },
    ['screenshot'] = { icon = "", title = false },
    ['Telegram Desktop'] = { icon = "切", title = true },
    -- ['night_mode'] = { icon = "", title = false },
    ['NetworkManager'] = { icon = "", title = true },
    -- ['youtube'] = { icon = "", title = true },
    -- ['mpd'] = { icon = "", title = true },
    -- ['mpv'] = { icon = "", title = true },
    -- ['keyboard'] = { icon = "", title = false },
    -- ['email'] = { icon = "", title = true },
}

-- TEMPLATE
-- naughty.connect_signal("request::display", function(n)

--     local custom_notification_icon = wibox.widget {
--         font = "SauceCode Pro Nerd Font Mono 18",
--         -- font = "icomoon bold 40",
--         align = "center",
--         valign = "center",
--         widget = wibox.widget.textbox
--     }

--     local icon, title_visible
--     local color = urgency_color[n.urgency]
--     if app_config[n.app_name] then
--         icon = app_config[n.app_name].icon
--         title_visible = app_config[n.app_name].title
--     else
--         icon = default_icon
--         title_visible = true
--     end

-- 	local actions = wibox.widget {
-- 		notification = n,
-- 		base_layout = wibox.widget {
-- 			spacing = dpi(3),
-- 			layout = wibox.layout.flex.horizontal
-- 		},
-- 		widget_template = {
-- 			{
-- 				{
-- 					{
-- 						id = 'text_role',
-- 						font = beautiful.notification_font,
-- 						widget = wibox.widget.textbox
-- 					},
-- 					left = dpi(6),
-- 					right = dpi(6),
-- 					widget = wibox.container.margin
-- 				},
-- 				widget = wibox.container.place
-- 			},
-- 			bg = x.color8.."32",
-- 			forced_height = dpi(25),
-- 			forced_width = dpi(70),
-- 			widget = wibox.container.background
-- 		},
-- 		style = {
-- 			underline_normal = false,
-- 			underline_selected = true
-- 		},
-- 		widget = naughty.list.actions
-- 	}

-- end)
