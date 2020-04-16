-------------------------------------------------------------------------
-- AwesomeWM Library
local gears     = require("gears")
local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local naughty   = require("naughty")
--
-------------------------------------------------------------------------
-- My Imports
local custom_clienticon = require("plugins.custom_clienticon")
--
-------------------------------------------------------------------------
-- Basic
mytextclock = wibox.widget.textclock(" ~ %I:%M %p ~ ");
modkey = "Mod4"
--
-------------------------------------------------------------------------
-- Wibar Widget Buttons
local taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1,
        function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
    awful.button({ }, 1,
        function (c)
            if c == client.focus then
                c.minimized = true
            else
                c.minimized = false
                if not c:isvisible() and c.first_tag then
                    c.first_tag:view_only()
                end
                client.focus = c
                c:raise()
            end
        end),
    awful.button({ }, 4, function () awful.client.focus.byidx( 1) end),
    awful.button({ }, 5, function () awful.client.focus.byidx(-1) end)
)
--
-------------------------------------------------------------------------
-- Wibar setup
awful.screen.connect_for_each_screen(function(s)
    -- Create a promptbox for each screen
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.noempty, taglist_buttons)
    s.mytasklist = awful.widget.tasklist {
        screen   = s,
        filter   = awful.widget.tasklist.filter.currenttags,
        buttons  = tasklist_buttons,
        layout   = {
            spacing_widget = {
                {
                    forced_height = 14,
                    thickness     = 1,
                    widget        = wibox.widget.separator
                },
                valign = 'center',
                halign = 'center',
                widget = wibox.container.place,
            },
            spacing = 5,
            layout  = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                wibox.widget.base.make_widget(),
                forced_height = 3,
                -- forced_width = 20,
                id            = 'background_role',
                widget        = wibox.container.background,
            },
            {
                {
                    id     = 'dummy1',
                    widget = wibox.widget.textbox,
                },
                {
                    id     = 'clienticon',
                    halign = 'center',
                    widget = custom_clienticon,
                },
                {
                    id     = 'dummy2',
                    widget = wibox.widget.textbox,
                },
                layout = wibox.layout.align.horizontal,
                widget  = wibox.container.margin
            },

            nil,
            create_callback = function(self, c, index, objects)
                self:get_children_by_id('clienticon')[1].client = c
                self:get_children_by_id('dummy1')[1].text = " "
                self:get_children_by_id('dummy2')[1].text = " "
            end,
            layout = wibox.layout.align.vertical,
        },
    }
    s.mypromptbox = awful.widget.prompt()

    s.memenu_search_left = wibox.widget{
        text = '',
        align  = 'center',
        valign = 'center',
        widget = wibox.widget.textbox
    }

    s.memenu_search_middle = wibox.widget{
        text = '',
        align  = 'center',
        valign = 'center',
        widget = wibox.widget.textbox
    }

    s.memenu_search_right = wibox.widget{
        text = '',
        align  = 'center',
        valign = 'center',
        widget = wibox.widget.textbox
    }

    s.mywibox = awful.wibar({ position = "top", screen = s })
    -- Layout of the widgets
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        expand = "none",
        { -- Left
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox,
            s.memenu_prompt_search,
            s.memenu_search_left,   
            {
                s.memenu_search_middle,
                bg     = beautiful.fg_normal,
                fg     = beautiful.bg_normal,
                widget = wibox.container.background
            },
            s.memenu_search_right,
        },
        { -- Middle
            layout = wibox.layout.fixed.horizontal,
            wibox.layout.margin(wibox.widget.systray(),12,12,12,12), -- FIXTHIS
            mytextclock,
            -- s.mylayoutbox, -- FIXTHIS
        },
        { -- Right
            layout = wibox.layout.fixed.horizontal,
            s.mytasklist,
        },
    }
end)
--
-------------------------------------------------------------------------