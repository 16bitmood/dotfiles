------------------------------------------------------------------------------------
-- AwesomeWM Library
local gears     = require("gears")
local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local naughty   = require("naughty")
local wibox = require("wibox")
local menubar = require("menubar")
--
------------------------------------------------------------------------------------
-- Basics
local keys = {}
modkey   = "Mod4"
altkey   = "Mod1"
ctrlkey  = "Control"
shiftkey = "Shift"
terminal = "urxvt"
--
------------------------------------------------------------------------------------
-- on-desktop mouse bindings
keys.desktopbuttons = gears.table.join(
    awful.button({modkey}, 3, function () menubar.show() end)
)
--
------------------------------------------------------------------------------------
-- Global Key bindings
keys.globalkeys = gears.table.join(
    -- Tiling movement
    awful.key({ modkey,}, "j",
        function ()
            awful.client.focus.bydirection("down")
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,}, "k",
        function ()
            awful.client.focus.bydirection("up")
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,}, "h",
        function ()
            awful.client.focus.bydirection("left")
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,}, "l",
        function ()
            awful.client.focus.bydirection("right")
        end,
        {description = "focus previous by index", group = "client"}
    ),
    -- Tiling Resize
    ---- awful.key({ modkey,  "Control"    }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    -- Tiling layout manipulation
    awful.key({ modkey, "Shift"   }, "j", 
        function () 
            awful.client.swap.bydirection("down")
        end,
        {description = "swap with next client by index", group = "client"}
    ),
    awful.key({ modkey, "Shift"   }, "k", 
        function () 
            awful.client.swap.bydirection("up")
        end,
        {description = "swap with previous client by index", group = "client"}
    ),    
    awful.key({ modkey, "Shift"   }, "h", 
        function () 
            awful.client.swap.bydirection("left")
        end,
        {description = "swap with next client by index", group = "client"}
    ),
    awful.key({ modkey, "Shift"   }, "l", 
        function () 
            awful.client.swap.bydirection("right")
        end,
        {description = "swap with previous client by index", group = "client"}
    ),
    -- Tag to cycle through Clients
    awful.key({ modkey,}, "Tab",
        function ()
            awful.client.focus.byidx(1)
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "Cycle Next Client", group = "client"}),

    awful.key({ modkey, "Shift"   }, "Tab",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "Cycle Previous Client", group = "client"}),
    -- Reload rc.lua
    awful.key({ modkey, "Control" }, "r", 
                function ()
                    awesome.restart() 
                end,
              {description = "reload awesome", group = "awesome"}),
    
    awful.key({ modkey,}, "space", function () awful.layout.inc( 1)                end,
              {description = "Switch between Floating and Tiling", group = "layout"}),

    awful.key({ modkey, "Shift" }, "n",
              function ()
                  local c = awful.client.restore()
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),
    -- Prompt
    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code:  ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"}),
    -- Shortcut Programs
    awful.key({ modkey, }, "Return", function () awful.spawn(terminal .. " -g 65x18") end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey,  "Shift"  }, "Return", function () awful.spawn("xfce4-terminal" .. " --geometry=65x18") end,
              {description = "open secondary terminal", group = "launcher"}),
    awful.key({ modkey, }, "a",      function () awful.spawn("thunar /home/gts/main/") end,
              {description = "Open File Manager", group = "launcher"}),
    awful.key({ modkey, }, "=",      function () awful.spawn("pactl -- set-sink-volume 0 +5%") end,
              {description = "Volume Increase 5%", group = "media-controls"}),
    awful.key({ modkey, }, "-",      function () awful.spawn("pactl -- set-sink-volume 0 -5%") end,
              {description = "Volume Decrease 5%", group = "media-controls"})
)
--
------------------------------------------------------------------------------------
-- Client Specific Key Bindings
keys.clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "q",      function (c) c:kill() end,
        {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle,
        {description = "toggle single client floating", group = "client"}),
    awful.key({ modkey, }, "t",      function (c) c.ontop = not c.ontop end,
        {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey, }, "n", function (c) c.minimized = true end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,}, "z",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "toggle maximize", group = "client"}),
    awful.key({ modkey,}, "c", awful.placement.centered,
        {description="center client",group="client"})
)
--
------------------------------------------------------------------------------------
-- Tag Specific Key Bindings
for i = 1, 9 do
    keys.globalkeys = gears.table.join(keys.globalkeys,
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
                  {description = "move focused client to tag #"..i, group = "tag"})
    )
end
--
------------------------------------------------------------------------------------
-- Mouse keys bind on full window (not just titlebars!)
keys.clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 2, awful.mouse.client.resize))
--
------------------------------------------------------------------------------------
-- Set keys
root.keys(keys.globalkeys)
root.buttons(keys.desktopbuttons)
return keys
--
------------------------------------------------------------------------------------