------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--[[

d888   .d8888b.  888      d8b 888                                         888 
d8888  d88P  Y88b 888      Y8P 888                                         888 
  888  888        888          888                                         888 
  888  888d888b.  88888b.  888 888888 88888b.d88b.   .d88b.   .d88b.   .d88888 
  888  888P "Y88b 888 "88b 888 888    888 "888 "88b d88""88b d88""88b d88" 888 
  888  888    888 888  888 888 888    888  888  888 888  888 888  888 888  888 
  888  Y88b  d88P 888 d88P 888 Y88b.  888  888  888 Y88..88P Y88..88P Y88b 888 
8888888 "Y8888P"  88888P"  888  "Y888 888  888  888  "Y88P"   "Y88P"   "Y88888 
]]
------------------------------------------------------------------------------------
-- https://github.com/16bitmood/
------------------------------------------------------------------------------------
-- AwesomeWM Library
local gears     = require("gears")
local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local naughty   = require("naughty")
require("awful.autofocus") -- When close window autofocus to last focused

-- Other imports
local inspect = require("inspect")
--
------------------------------------------------------------------------------------
-- Global debugging function
function debug_print(s,timeout,title)
    s = assert(s)
    timeout = timeout or 5
    title = tile or "[debug]"
    -- TODO: add support for inbuilt debug library
    naughty.notify({
        timeout = timeout,
        title = title,
        text = inspect(s)
    })
end
--
------------------------------------------------------------------------------------
-- My Imports
local helpers   = require("helpers")   -- helper functions
local vars      = require("vars")      -- variables
local efile     = require("lib.efile") -- Easy file access
local theme     = require("theme")     -- Initializes theme variables
local bars      = require("bars")      -- loads taskbar
local keys      = require("keys")      -- set keybinds
local titlebars = require("titlebars") -- load titlebars
-- Initialize
helpers.run_script(vars.STARTUP_SCRIPT)
helpers.set_pywal_wallpaper(helpers.get_current_wallpaper())
--
------------------------------------------------------------------------------------
-- Notifications
naughty.config.defaults['icon_size']    = beautiful.notification_icon_size
naughty.config.defaults.timeout         = 5
naughty.config.presets.low.timeout      = 2
naughty.config.presets.critical.timeout = 20
--
------------------------------------------------------------------------------------
-- Layouts
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile
}
--
------------------------------------------------------------------------------------
-- Setup all screens (Floating by default)
awful.screen.connect_for_each_screen(function(s)
      awful.tag(beautiful.tagnames, s, awful.layout.layouts[1])
end)
--
------------------------------------------------------------------------------------
-- Rules for clients
awful.rules.rules = {
    -- On new client connect
    { rule = { },
        properties = {                     
            raise        = true,
            keys         = keys.clientkeys,
            buttons      = keys.clientbuttons,
            screen       = awful.screen.preferred,
            placement    = awful.placement.no_overlap+awful.placement.no_offscreen,
            size_hints_honor  = false,
            titlebars_enabled = false,
            border_width = 0
     },
     callback = awful.client.setslave
    },
    { rule = { class = "URxvt"},
    properties = {titlebars_enabled = true}
    },
}
--
------------------------------------------------------------------------------------
-- Signals
local function signal_manage(c)
    client.focus = c
    c:raise()
end

local function signal_geometry(s)
    -- On resolution change
    helpers.set_pywal_wallpaper(helpers.get_current_wallpaper())
end

-- Client signals 
client.connect_signal("manage",signal_manage)
-- client.connect_signal("focus", signal_focus)
-- client.connect_signal("unfocus", signal_unfocus)
-- client.connect_signal("property::maximized",signal_maximized)
-- Screen signals 
screen.connect_signal("property::geometry", signal_geometry)
--
---------------------------------------------------------------------------------------
-- Manage Errors
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "~you dun goofed~",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true
        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "~you dun goofed~",
                         text = inspect(err) })
        in_error = false
    end)
end
--
---------------------------------------------------------------------------------------
-- TODO:
-- On maximized window, set taskbar to blackand white
-- Use this: "property::floating_geometry The last geometry when client was floating."
-- helpers.set_current_wallpaper("keyboards/06.jpg") -- TODO:Make this interactive
-- FIX custom_clienticon
---------------------------------------------------------------------------------------
-- TESTING ZONE:
-- debug_print(helpers.get_current_wallpaper())
-- helpers.get_icon_path("code-oss")
--
---------------------------------------------------------------------------------------