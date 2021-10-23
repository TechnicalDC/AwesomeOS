
-- TAGS

local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")			
local beautiful = require("beautiful")	
local naughty = require("naughty")		
local icon_path = "/home/dilip/.config/awesome/theme/icons/taglist/"

addtags = function(s)
	tag_names = { "1","2","3","4","5","6","7","8","9",}

	tag_icons = {
		icon_path .. "web.png",		-- 1 --
		icon_path .. "fav.png",		-- 2 --
		icon_path .. "sys.png",		-- 3 --
		icon_path .. "mail.png",	-- 4 --
		icon_path .. "files.png",	-- 5 --
		icon_path .. "games.png",	-- 6 --
		icon_path .. "docs.png",	-- 7 --
		icon_path .. "music.png",	-- 8 --
		icon_path .. "video.png",	-- 9 --
	}

	local layouts = awful.layout.suit

	tag_layouts = {
		layouts.tile,		-- 1 --
		layouts.tile,		-- 2 --
		layouts.tile,		-- 3 --
		layouts.tile,		-- 4 --
		layouts.tile,		-- 5 --
		layouts.tile,		-- 6 --
		layouts.tile,		-- 7 --
		layouts.tile,		-- 8 --
		layouts.tile,		-- 9 --
	}

    for i, tag in pairs(tag_names) do
		awful.tag.add(
			i,
			{
				icon = tag_icons[i],
				icon_only = true,
				layout = tag_layouts[i],
				screen = s,
				selected = i == 1
			}
		)

	end
end

return addtags
