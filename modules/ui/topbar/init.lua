local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local dpi = require("beautiful.xresources").apply_dpi

local apps = require("config.apps")

local color_solid = beautiful.bg_normal 

local button = require("lib.button")

local widget = function(inner_widget)
    return wibox.widget {
        widget = wibox.container.margin,
        top = dpi(beautiful.bar_item_padding + 2), 
        bottom = dpi(beautiful.bar_item_padding + 2),
        left = dpi(6),
        right = dpi(6),
        {
            inner_widget,
            layout = wibox.layout.fixed.horizontal
        }
    }
end

-- Init widgets
------------------------------------------------
local session   = require("modules.ui.topbar.session")
local taglist   = require("modules.ui.topbar.taglist")
local battery   = require("modules.ui.topbar.battery")
local clock     = require("modules.ui.topbar.clock")
--local spotify = require("modules.ui.topbar.spotify")
local tasklist  = require("modules.ui.topbar.tasklist")
local launcher  = require("modules.ui.topbar.launcher")

beautiful.systray_icon_spacing = dpi(12)
local systray = wibox.widget.systray()

------------------------------------------------
-- setup
------------------------------------------------
awful.screen.connect_for_each_screen(function(s)
    s.topbar = awful.wibar({
        screen = s,
        position = beautiful.bar_position, 
        height = beautiful.bar_height, 
        type = "dock",
        bg = color_solid,
    })

    local bar_taglist = taglist.init(s)
    local bar_tasklist = tasklist.init(s)

    s.topbar:setup {
        layout = wibox.layout.align.horizontal, 
        spacing = dpi(10),
        expand = "none",
        {   -- Left
            widget(session), 
            bar_taglist,
            spacing = dpi(6),
            layout = wibox.layout.fixed.horizontal, 
        }, 
        {   -- Middle
            --widget(spotify()),
            --bar_tasklist,
            layout = wibox.layout.fixed.horizontal, 
        },
        {   -- Right 
            widget(battery), 
            widget(wibox.widget {
                widget = wibox.container.margin,
                top = dpi(1), 
                bottom = dpi(1), 
                {
                    systray, 
                    layout = wibox.layout.fixed.horizontal, 
                }
            }),
            widget(clock), 
            widget(launcher),
            layout = wibox.layout.fixed.horizontal, 
        }
    }
end)
