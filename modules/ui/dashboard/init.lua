local awful     = require("awful")
local wibox     = require("wibox")
-- local gears     = require("gears")
local beautiful = require("beautiful")
local dpi       = require("beautiful.xresources").apply_dpi

-- local naughty = require("naughty")

local apps = require("config.apps")

local drawBox    = require("modules.ui.dashboard.drawBox")
local leftdock   = require("modules.ui.dashboard.docks.left")
local rightdock  = require("modules.ui.dashboard.docks.right")
local avatar     = require("modules.ui.dashboard.avatar")
local calendar   = require("modules.ui.dashboard.calendar")
local time       = require("modules.ui.dashboard.time")
local storage    = require("modules.ui.dashboard.storage")
local volume     = require("modules.ui.dashboard.volume")
local brightness = require("modules.ui.dashboard.brightness")
local battery    = require("modules.ui.dashboard.battery")
local settings   = require("modules.ui.dashboard.settings")
local weather    = require("modules.ui.dashboard.weather")
local playerctl  = require("modules.ui.dashboard.playerctl")

local dashboard = wibox({
    visible = false,
    ontop = true,
    type = "dock",
    screen = screen.primary,
    x = 0,
    y = beautiful.bar_height,
    width = awful.screen.focused().geometry.width,
    height = awful.screen.focused().geometry.height - beautiful.bar_height,
})

require("modules.ui.dashboard.background")(dashboard)

local keygrabber
local function getKeygrabber()
    return awful.keygrabber {
        keypressed_callback = function(_, mod, key)
            if key == "Escape" then
                dashboard.visible = false
                keygrabber:stop()
                return
            end

            -- don't do anything for non-alphanumeric characters or stuff like F1, Backspace, etc
            if key:match("%W") or string.len(key) > 1 and key ~= "Escape" then
                return
            end

            local launchedAppWithLauncher = false
            -- spawn launcher with input arguments
            awful.spawn.with_line_callback(apps.launcher .. " " .. key, {
                stdout = function(line)
                    -- this line is emitted by debug rofi when an app is launched
                    if string.match(line, "Parsed command") then
                        launchedAppWithLauncher = true
                        dashboard.visible = false
                    end
                end,
                output_done = function()
                    -- restart the keygrabber when no app was launched
                    if not launchedAppWithLauncher then
                        keygrabber = getKeygrabber()
                        keygrabber:start()
                    end
                end
            })
            keygrabber:stop()
        end,
    }
end

keygrabber = getKeygrabber()

dashboard.toggle = function()
    calendar.reset()
    dashboard.visible = not dashboard.visible

    keygrabber:stop()

    if dashboard.visible then
        keygrabber = getKeygrabber()
        keygrabber:start()
    end
end

dashboard.close = function()
    calendar.reset()
    dashboard.visible = false
    keygrabber:stop()
end

-- listen to signal emitted by other modules.ui
awesome.connect_signal("dashboard::toggle", dashboard.toggle)
awesome.connect_signal("dashboard::close", dashboard.close)

dashboard:setup {
    {
        leftdock,
        {
            nil, {
                nil,
                {
                        {
                            playerctl,
                            settings,
                            layout = wibox.layout.fixed.vertical
                        },
                        {
                            drawBox({
                                volume,
                                brightness,
                                battery,
                                spacing = dpi(16),
                                widget = wibox.layout.fixed.vertical
                            }, 200, 114),
                            drawBox(storage(), 200, 114),
                            layout = wibox.layout.fixed.vertical
                        },
                        {
                            drawBox(time, 260, 48),
                            drawBox(calendar, 260, 180),
                            layout = wibox.layout.fixed.vertical
                        },
                        layout = wibox.layout.fixed.horizontal
                },
                expand = "none",
                layout = wibox.layout.align.vertical
            },
            expand = "none",
            layout = wibox.layout.align.horizontal
        },
        rightdock,
        layout = wibox.layout.align.horizontal
    },
    {
        nil,
        nil,
        {
            {
                weather,
                right = dpi(32),
                widget = wibox.container.margin
            },
            expand = "none",
            layout = wibox.layout.align.vertical
        },
        expand = "none",
        layout = wibox.layout.align.horizontal
    },
    {
        {
            drawBox(avatar, 180, 44),
            nil,
            nil,
            expand = "none",
            layout = wibox.layout.align.horizontal
        },
        nil,
        nil,
        expand = "none",
        layout = wibox.layout.align.vertical
    },
    layout = wibox.layout.stack
}

return dashboard
