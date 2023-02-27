-- STANDARD AWESOME LIBRARY {{{
pcall(require, "luarocks.loader")
require("awful.autofocus")
local gears                      = require("gears")
local awful                      = require("awful")
local wibox                      = require("wibox")									-- Widget and layout library
local beautiful                  = require("beautiful")							-- Theme handling library
local naughty                    = require("naughty")								-- Notification library
-- local menubar                    = require("menubar")
local hotkeys_popup              = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- local debian = require("debian.menu")							-- Load Debian menu entries
-- local has_fdo, freedesktop = pcall(require, "freedesktop")
-- }}}

-- REQUIRE {{{
local app = require('modules.applications')
require('modules.keybindings')
require('modules.rules')
require('modules.ui.notification')
-- }}}

-- AUTOSTART {{{
awful.util.spawn("wal -R")
awful.util.spawn("./.fehbg")
-- awful.util.spawn("conky -c ~/.config/conky/conky-day")
awful.util.spawn("mpv --no-video ~/audio/SoundEffects/Computer_Magic-Microsift-1901299923.mp3")
awful.util.spawn("nm-applet")
awful.util.spawn("blueman-applet")
-- awful.util.spawn("nitrogen --restore")
awful.util.spawn("kdeconnect-indicator")
awful.util.spawn("/usr/libexec//polkit-gnome-authentication-agent-1")
awful.util.spawn("volumeicon")
awful.util.spawn("picom")
-- }}}

--  ERROR HANDLING {{{
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

--  VARIABLE DEFINITIONS {{{
-- Themes define colours, icons, font and wallpapers.
local dpi = beautiful.xresources.apply_dpi
beautiful.init("/home/dilip/.config/awesome/theme/theme.lua")

-- Default modkey.
modkey = "Mod4"
altkey = "Mod1"
-- }}}

-- LAYOUTS {{{
awful.layout.layouts = {
   awful.layout.suit.tile,
   awful.layout.suit.tile.left,
   awful.layout.suit.tile.bottom,
   awful.layout.suit.tile.top,
   awful.layout.suit.fair,
   awful.layout.suit.fair.horizontal,
   awful.layout.suit.max,
   awful.layout.suit.max.fullscreen,
	awful.layout.suit.floating,
   awful.layout.suit.magnifier,
   -- awful.layout.suit.corner.nw,
   -- awful.layout.suit.corner.ne,
   -- awful.layout.suit.corner.sw,
   -- awful.layout.suit.corner.se,
}
-- }}}

--  WIBAR {{{
-- Create a textclock widget
mytextclock = wibox.widget.textclock("<span size='large'> %d %b, %a %H:%M</span>")

-- Create a systray and make it vertical
mysystray = wibox.widget.systray()
mysystray.set_horizontal(true)

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
	awful.button({ }, 1, function(t) t:view_only() end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({ }, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
	awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
	)


awful.screen.connect_for_each_screen(function(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
	-- addtags(s)

    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))

    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
		layout = wibox.layout.fixed.horizontal,
        buttons = taglist_buttons,
		align = wibox.layout.align.centered
    }

	-- calendar.create(s)

    -- Create the wibox
    s.mywibox = awful.wibar({position = "top", 
							 screen = s,
							 widht = 500,
							 height = 25,
							 x = 10,
							 y = 10})

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
		nil,
        { -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			wibox.container.place(s.mytaglist,{halign = 'center'}),
			-- s.mytaglist
        },
        { -- Right widgets
			{
				layout = wibox.layout.fixed.horizontal,
				wibox.container.place(mytextclock,{halign = 'center'}),
				wibox.container.place(mysystray,{halign = 'center'}),
				s.mylayoutbox,
				spacing = 2
			},
			margins = 4,
			widget = wibox.container.margin,
        },
    }
end)
-- }}}

--  MOUSE BINDINGS {{{
root.buttons(gears.table.join(
    -- awful.button({ }, 3, function () logout_popup.launch() end)
    -- awful.button({ }, 4, awful.tag.viewnext),
    -- awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

--  RULES {{{
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
					 size_hints_honor = false,
					 placement = awful.placement.centered+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
		  "filechooser"
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin", 
          "Wpa_gui",
          "veromix",
		  "Nm-connection-editor",
		  "SimpleScreenRecorder",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",
        },
        role = {
          "AlarmWindow",  
          "ConfigManager", 
          "pop-up",      
        }
      }, properties = { 
			floating = true,
		}},

	{ rule_any = { class = {"SimpleScreenRecorder"}},
		properties = {tag = "9", switchtotag = true}},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false } 
    },

	{ rule = { class = "conky" },
		properties = { border_width = 0, placement = nil }
	}

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "mpv" },
    --   properties = { 
			-- titlebars_enabled = false,
			-- placement = awful.placement.bottom_right,
			-- sticky = true,
			-- ontop = true,
			-- width = 445,
			-- height = 250,
			-- floating = true
	  -- } },
}
-- }}}

--  SIGNALS {{{
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end
	-- c.shape = function(cr, w, h)
	-- 	gears.shape.rounded_rect(cr, w, h, 10)
	-- end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)
-- }}}
