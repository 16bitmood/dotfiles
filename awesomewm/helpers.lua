local gears     = require("gears")
local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local naughty   = require("naughty")
local inspect   = require("inspect")


local vars      = require("vars")
local efile     = require("lib.efile")

local function run_script(script_path)
    os.execute(script_path)
end

local function set_pywal_wallpaper(wallpaper_path)
    os.execute(vars.PYWAL_SCRIPT.." "..wallpaper_path)
end

local function get_current_wallpaper()
    local my_config = efile.readjson(vars.CONFIG_DIR.."/config.json")
    return vars.WALLPAPER_DIR .. "/" .. my_config.wallpaper
end

local function get_config()
    local my_config = efile.readjson(vars.CONFIG_DIR.."/config.json")
    return my_config
end

local function get_icon_path(class_name)
    local my_config = get_config()
    local t = my_config.apps[class_name]
    if t ~= nil then
        return vars.ICON_DIR .. "/" .. t.icon_name
    else
        return vars.ICON_DIR .. "/" .. "unknown.png"
    end
end

local function set_current_wallpaper(new_wallpaper)
    local my_config = efile.readjson(vars.CONFIG_DIR.."/config.json")
    my_config.wallpaper = new_wallpaper
    efile.savejson(vars.CONFIG_DIR.."/config.json",my_config)
end
return {
    debug_print =  debug_print,
    run_script =  run_script,
    set_pywal_wallpaper =  set_pywal_wallpaper,
    get_config = get_config,
    get_icon_path =  get_icon_path,
    get_current_wallpaper =  get_current_wallpaper,

    set_current_wallpaper =  set_current_wallpaper,
}