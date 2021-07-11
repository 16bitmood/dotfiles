---------------------------------------------------------------------------------------
-- 
-- DONT USE THIS!? 
local USER_HOME       = os.getenv("HOME")
local WALLPAPER_DIR   = USER_HOME.."/main/media/wallpapers"
local CONFIG_DIR      = USER_HOME.."/.config/awesome"
local SCRIPT_DIR      = CONFIG_DIR.."/scripts"
local ICON_DIR        = CONFIG_DIR.."/assets/icons"
local CACHE_DIR       = CONFIG_DIR.."/cache"

local STARTUP_SCRIPT                = SCRIPT_DIR.."/startup.sh"
-- local EMACS_RELOAD_SCRIPT           = SCRIPT_DIR.."/emacs_reload.sh"
-- local PYWAL_THEME_AND_SET_SCRIPT    = SCRIPT_DIR.."/pywal_theme_and_set.sh"
local PYWAL_GENERATE_AND_SET_SCRIPT = SCRIPT_DIR.."/pywal_generate_and_set.sh"
-- local STORE_WALLPAPER               = CONFIG_DIR.."/store_wallpaper"

--
---------------------------------------------------------------------------------------
--
return {
   USER_HOME = USER_HOME,
   WALLPAPER_DIR = WALLPAPER_DIR,
   CONFIG_DIR = CONFIG_DIR,
   SCRIPT_DIR = SCRIPT_DIR,
   ICON_DIR = ICON_DIR,
   -- EMACS_RELOAD_SCRIPT = EMACS_RELOAD_SCRIPT,
   STARTUP_SCRIPT = STARTUP_SCRIPT,
   PYWAL_SCRIPT = PYWAL_SCRIPT,
   -- PYWAL_THEME_AND_SET_SCRIPT = PYWAL_THEME_AND_SET_SCRIPT,
   PYWAL_GENERATE_AND_SET_SCRIPT = PYWAL_GENERATE_AND_SET_SCRIPT,
   -- STORE_WALLPAPER = STORE_WALLPAPER,
   CACHE_DIR = CACHE_DIR
}
--
---------------------------------------------------------------------------------------
