------------------------------------------------------------------------------------
-- AwesomeWM Library
local gears     = require("gears")
local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local naughty   = require("naughty")

------------------------------------------------------------------------------------
-- Basic
local titlebars = {}
awful.titlebar.enable_tooltip = false -- Disable popup tooltip on titlebar button hover
--
------------------------------------------------------------------------------------
-- Mouse buttons
titlebars.buttons = {}
------------------------------------------------------------------------------------
-- Add a titlebar
client.connect_signal("request::titlebars", function(c)
    local buttons = titlebars.buttons
    awful.titlebar(c, {font = beautiful.titlebar_font, position = beautiful.titlebar_position, size = beautiful.titlebar_size}) : setup {
        -- Titlebar items
        { -- Left
            -- layout  = titlebar_item_layout
            layout = wibox.layout.fixed.horizontal()
        },
        { -- Middle
            layout  = wibox.layout.flex.horizontal()
        },
        { -- Right
            layout = wibox.layout.fixed.horizontal()
        },
        -- layout = titlebar_layout
        layout = wibox.layout.align.horizontal
    }
end)
return titlebars
--
------------------------------------------------------------------------------------