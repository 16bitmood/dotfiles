---------------------------------------------------------------------------------------
-- AwesomeWM Library
local gears     = require("gears")
local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local naughty   = require("naughty")
-- Alias
local dpi = beautiful.xresources.apply_dpi
local xrdb = beautiful.xresources.get_current_theme()
--
---------------------------------------------------------------------------------------
-- My Imports
local vars = require("vars")
local helpers = require("helpers")

-- Initialize default theme
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
local theme = beautiful.get()
--
---------------------------------------------------------------------------------------
-- Basic
theme.name          = "my_theme"
theme.wallpaper     = helpers.get_current_wallpaper()
theme.font          = "Ubuntu Mono 12"
theme.useless_gap   = dpi(16)
theme.icon_theme    = nil

--
---------------------------------------------------------------------------------------
-- Getting Colors

----------------------------
-- Normal      Bright     --
----------------------------
-- 0 Black      8 Black   --
-- 1 Red        9 Red     --
-- 2 Yellow    10 Yellow  --
-- 3 Green     11 Green   --
-- 4 Blue      12 Blue    --
-- 5 Magenta   13 Magenta --
-- 6 Cyan      14 Cyan    --
-- 7 White     15 White   --
----------------------------
-- Defining Colors
theme.normal_colors = {
    black   = xrdb.color0,
    red     = xrdb.color1,
    yellow  = xrdb.color2,
    green   = xrdb.color3,
    blue    = xrdb.color4,
    magenta = xrdb.color5,
    cyan    = xrdb.color6,
    white   = xrdb.color7,
}

theme.bright_colors = {
    black   = xrdb.color8,
    red     = xrdb.color9,
    yellow  = xrdb.color10,
    green   = xrdb.color11,
    blue    = xrdb.color12,
    magenta = xrdb.color13,
    cyan    = xrdb.color14,
    white   = xrdb.color15,
}

theme.bg_dark       = theme.normal_colors.black
theme.bg_normal     = theme.normal_colors.black
theme.bg_focus      = theme.normal_colors.black
theme.bg_urgent     = theme.normal_colors.red
theme.bg_minimize   = theme.normal_colors.black
theme.bg_systray    = theme.normal_colors.black

theme.fg_normal     = theme.normal_colors.white
theme.fg_focus      = theme.normal_colors.white
theme.fg_urgent     = theme.normal_colors.white
theme.fg_minimize   = theme.normal_colors.white
--
---------------------------------------------------------------------------------------
-- Titlebars
theme.titlebars_enabled      = false
theme.titlebar_size          = dpi(30)
theme.titlebar_position      = "top"
theme.titlebar_title_enabled = false
theme.titlebar_title_align   = "center"
theme.titlebar_bg            = theme.fg_normal -- Inverted Colors
theme.titlebar_fg            = theme.bg_normal
theme.titlebar_fg_normal     = theme.fg_normal -- Not Inverted Colors
theme.titlebar_bg_normal     = theme.bg_normal -- 
--
---------------------------------------------------------------------------------------
-- Notifications
theme.notification_position = "top_right"
theme.notification_border_color  = theme.fg_normal
-- theme.notification_border_width  = 20 --FIXTHIS (doesn't work)
-- theme.notification_border_radius = dpi(0)
theme.notification_bg = theme.bg_normal
theme.notification_fg = theme.fg_normal
theme.notification_crit_bg = theme.bright_colors.red
theme.notification_crit_fg = theme.fg_normal
-- theme.notification_margin       = dpi(50) --FIXTHIS (doesn't work)
theme.notification_icon_size    = dpi(0)
-- theme.notification_height       = dpi(50)
theme.notification_width        = dpi(500)
theme.notification_max_width    = dpi(500)
-- theme.notification_max_height   = nil
theme.notification_font         = theme.font
--
---------------------------------------------------------------------------------------
-- Basic Wibar Settings
theme.wibar_position = "top"
theme.wibar_height = dpi(36)
theme.wibar_fg = theme.fg_normal
theme.wibar_bg = theme.bg_normal
-- theme.wibar_opacity = 0.5
theme.wibar_border_color = theme.bg_normal
theme.wibar_border_width = 3
--
---------------------------------------------------------------------------------------
 --Tasklist
theme.tasklist_font             = theme.font
theme.tasklist_disable_icon     = true
theme.tasklist_plain_task_name  = true
theme.tasklist_bg_focus         = theme.fg_normal -- color "background_role" widget
theme.tasklist_fg_focus         = theme.fg_normal
theme.tasklist_bg_normal        = theme.bg_normal
theme.tasklist_fg_normal        = theme.fg_normal
theme.tasklist_bg_minimize      = theme.bright_colors.black
theme.tasklist_fg_minimize      = theme.fg_normal
theme.tasklist_bg_urgent        = theme.bg_normal
theme.tasklist_fg_urgent        = theme.bright_colors.red
theme.tasklist_shape_border_width = dpi(2)
theme.tasklist_shape_border_color = xbg
-- theme.tasklist_spacing          = dpi(50) -- Doesn't work
-- theme.tasklist_align            = "center" -- Doesn't work
---------------------------------------------------------------------------------------
-- Taglist
theme.tagnames={" 一 "," 二 "," 三 " ," 四 "," 五 "," 六 "," 七 "," 八 "," 九 "}
theme.taglist_font = theme.font
theme.taglist_bg_focus           = theme.fg_normal
theme.taglist_fg_focus           = theme.bg_normal
theme.taglist_bg_occupied        = theme.bg_normal
theme.taglist_fg_occupied        = theme.fg_normal
theme.taglist_disable_icon       = true
theme.taglist_spacing            = dpi(0)   --This works
theme.taglist_shape              = gears.shape.rectangle
theme.taglist_shape_border_color = theme.bg_normal
theme.taglist_shape_border_width = dpi(0)
theme.taglist_squares_sel = nil
theme.taglist_squares_unsel = nil
--
---------------------------------------------------------------------------------------
-- Misc
---- Prompt
theme.prompt_fg = theme.fg_normal
theme.prompt_bg = theme.bg_normal
---- Edge snap
theme.snap_bg = theme.fg_normal
theme.snap_border_width = dpi(0)
--
-- Widget separator -- Not using rn
-- theme.separator_text =":" 
-- theme.separator_fg = theme.fg_normal
--
---------------------------------------------------------------------------------------
-- Finalize
beautiful.init(theme)
return theme
--
---------------------------------------------------------------------------------------