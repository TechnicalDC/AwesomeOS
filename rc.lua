-- STANDARD AWESOME LIBRARY {{{
pcall(require, "luarocks.loader")
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")									-- Widget and layout library
local beautiful = require("beautiful")							-- Theme handling library
local naughty = require("naughty")								-- Notification library
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

local debian = require("debian.menu")							-- Load Debian menu entries
local has_fdo, freedesktop = pcall(require, "freedesktop")
-- }}}

-- MY {{{
require('defaults')
require('modules.tags')
require('widgets.calendar')
-- require('modules.right-click-menu')
require('modules.notification')
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
    awful.layout.suit.max,
    awful.layout.suit.floating,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
}
-- }}}

--  WIBAR {{{
-- Create a textclock widget
mytextclock = wibox.widget.textclock("<span size='large'>%H\n%M</span>")
-- mytextclock.connect_signal("button::press", function(button)
-- 	if button == 1 then
-- 		awful.util.spawn("notify-send 'asdf' 'sfds'")
-- 	end
-- end)

-- Create a systray and make it vertical
mysystray = wibox.widget.systray()
mysystray.set_horizontal(false)

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

-- local mybutton = 


local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)

    -- Each screen has its own tag table.
    -- awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
	addtags(s)

    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))

    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
		layout = wibox.layout.fixed.vertical,
        buttons = taglist_buttons,
    }

	-- calendar.create(s)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "left", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.vertical,
		nil,
        { -- Left widgets
			layout = wibox.layout.fixed.vertical,
			s.mytaglist
        },
        { -- Right widgets
			{
				layout = wibox.layout.fixed.vertical,
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
    -- awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

--  KEY BINDINGS {{{
globalkeys = gears.table.join(
	-- Application keys
	awful.key({modkey,			 }, "d", 
		function ()
			awful.util.spawn("rofi -show drun")
		end,
		{description = "Launcg rofi", group = "apps"}),

	awful.key({modkey,			 }, "w", 
		function ()
			awful.util.spawn("rofi -show window")
		end,
		{description = "Launch list open windows", group = "apps"}),

	awful.key({modkey,			 }, "r", 
		function ()
			awful.util.spawn("rofi -show run")
		end,
		{description = "Launch commands", group = "apps"}),

	awful.key({modkey,			 }, "e", 
		function ()
			awful.util.spawn("/home/dilip/.scripts/rofi-configmenu.sh")
		end,
		{description = "Launch config menu", group = "apps"}),

	awful.key({modkey, altkey}, "q", 
		function ()
			awful.util.spawn("/home/dilip/.scripts/rofi-quickmarks.sh")
		end,
		{description = "Launch quickmarks menu", group = "apps"}),

	awful.key({}, "Print", 
		function ()
			awful.util.spawn("/home/dilip/.scripts/rofi-scrotmenu.sh")
		end,
		{description = "Launch scrot menu", group = "apps"}),

	awful.key({modkey, altkey}, "p",
		function ()
			awful.util.spawn("/home/dilip/.scripts/poly-picom.sh")
		end,
		{description = "Toggle picom", group = "apps"}),

	awful.key({modkey, altkey}, "r", 
		function ()
			awful.util.spawn(default.terminal .. " -e " .. default.filemanager)
		end,
		{description = "Launch ranger", group = "apps"}),

	awful.key({modkey, altkey}, "n", 
		function ()
			awful.util.spawn(default.terminal .. " -e " .. default.text_editor)
		end,
		{description = "Launcg ranger", group = "apps"}),

	awful.key({modkey, altkey}, "s", 
		function ()
			awful.util.spawn(default.image_viewer .. " -rt .")
		end,
		{description = "Launcg ranger", group = "apps"}),


	-- Other Keys
    awful.key({ modkey,           }, "F1",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "[",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "]",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    -- awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
    --           {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),

    awful.key({ modkey, altkey}, "j", function () awful.client.incwfact(0.05)    end,
              {description = "swap with next client by index", group = "client"}),

    awful.key({ modkey, altkey}, "k", function () awful.client.incwfact(-0.05)    end,
              {description = "swap with previous client by index", group = "client"}),

    -- awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
    --           {description = "focus the next screen", group = "screen"}),
    -- awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
    --           {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(default.terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Shift" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),

    awful.key({ modkey, }, "q",      function (c) c:kill() end,
              {description = "Quit window", group = "client"}),
    awful.key({ modkey, }, "s",  awful.client.floating.toggle                     ,
              {description = "Toggle floating", group = "client"}),

	awful.key({modkey, "Shift"}, "s", 
			function(c)
				c.sticky = not c.sticky
			end, {description = "Toggle sticky", group = "client"}),

    awful.key({ modkey, "Shift" }, "m", function (c) c:swap(awful.client.getmaster()) end,
              {description = "Move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "Move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "Toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "Toggle (un)maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- set keys
root.keys(globalkeys)
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
					 placement = awful.placement.centered + awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
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
			placement = awful.placement.centered + awful.placement.no_offscreen
		}},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = true }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    { rule = { class = "mpv" },
      properties = { 
			titlebars_enabled = false,
			placement = awful.placement.bottom_right,
			sticky = true,
			ontop = true,
			width = 445,
			height = 250,
			floating = true
	  } },
}
-- }}}

--  SIGNALS {{{
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end
	c.shape = function(cr, w, h)
		gears.shape.rounded_rect(cr, w, h, 10)
	end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)
-- }}}

-- TITLEBAR {{{
-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

	if c.type == "dialog" then
		awful.titlebar(c, {position = 'left', size = dpi(35)}) : setup {
			{ -- Right
				{
					awful.titlebar.widget.closebutton    (c),
					spacing = dpi(3),
					layout = wibox.layout.fixed.vertical
				},
				margins = 8,
				widget = wibox.container.margin
			},
			{
				buttons = buttons,
				layout = wibox.layout.align.vertical
			},
			nil,
			-- {
			-- 	{
			-- 		awful.titlebar.widget.ontopbutton(c),
			-- 		spacing = dpi(3),
			-- 		layout = wibox.layout.fixed.vertical
			-- 	},
			-- 	margins = 8,
			-- 	widget = wibox.container.margin
			-- },
			layout = wibox.layout.fixed.vertical
		}
	else
		awful.titlebar(c, {position = 'left', size = dpi(35)}) : setup {
			{ -- Right
				{
					awful.titlebar.widget.closebutton    (c),
					awful.titlebar.widget.maximizedbutton(c),
					awful.titlebar.widget.floatingbutton (c),
					-- awful.titlebar.widget.stickybutton   (c),
					spacing = dpi(3),
					layout = wibox.layout.fixed.vertical
				},
				margins = 8,
				widget = wibox.container.margin
			},
			{
				buttons = buttons,
				layout = wibox.layout.align.vertical
			},
			nil,
			-- {
			-- 	{
			-- 		awful.titlebar.widget.ontopbutton(c),
			-- 		spacing = dpi(3),
			-- 		layout = wibox.layout.fixed.vertical
			-- 	},
			-- 	margins = 8,
			-- 	widget = wibox.container.margin
			-- },
			layout = wibox.layout.fixed.vertical
		}
	end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- AUTOSTART {{{

awful.util.spawn("nm-applet")
-- awful.util.spawn("nitrogen --restore")
awful.util.spawn("feh --bg-fill /home/dilip/.config/awesome/theme/background/wallpaper.jpg")
awful.util.spawn("kdeconnect-indicator")
awful.util.spawn("/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1")
-- awful.util.spawn("volumeicon")
awful.util.spawn("picom --experimental-backends")
-- awful.util.spawn("picom --config $HOME/.config/picom/picom-noblur.conf --experimental-backends")

-- }}}
