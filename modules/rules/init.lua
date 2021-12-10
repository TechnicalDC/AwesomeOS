
-- RULES

local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")									-- Widget and layout library
local beautiful = require("beautiful")							-- Theme handling library
local naughty = require("naughty")								-- Notification library
local menubar = require("menubar")

--  RULES {{{
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{ rule = { },
		properties = { 
			border_width = beautiful.border_width,
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
			"xtightvncviewer"
		},
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
	}, 
	properties = { 
		floating = true,
		placement = awful.placement.centered + awful.placement.no_offscreen
	}},
	-- Add titlebars to normal clients and dialogs
	{ rule_any = {
		type = { "normal", "dialog" }
	}, properties = { titlebars_enabled = true }
	},
	{ rule = { class = "conky" },
		properties = { border_width = 0, placement = nil }
	}
	-- Set Firefox to always map on the tag named "2" on screen 1.
	-- { rule = { class = "mpv" },
	-- properties = { 
	-- 	titlebars_enabled = false,
	-- 	placement = awful.placement.bottom_right,
	-- 	sticky = true,
	-- 	ontop = true,
	-- 	width = 445,
	-- 	height = 250,
	-- 	floating = true
	-- } },
}
