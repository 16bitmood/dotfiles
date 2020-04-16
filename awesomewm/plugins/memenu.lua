-------------------------------------------------------------------------
-- dmenu/rofi like functionality
-------------------------------------------------------------------------
-- AwesomeWM Library
local gears     = require("gears")
local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local naughty   = require("naughty")
--
-------------------------------------------------------------------------
-- Other Imports
local inspect = require("inspect")
-- My Imports
local efile = require("lib.efile")
local vars  = require("vars")
--
-------------------------------------------------------------------------
-- Variables
local binaries_in_path = efile.readlines(vars.CACHE_DIR .. "/listbinaries","\n")
local current_matches = {}
local current_position = 1

local search_text = {
    left = "",
    middle = "",
    right = "", 
}
--
-------------------------------------------------------------------------
-- Helpers
local function clear_text_widgets()
    search_text.left = ""
    search_text.middle = ""
    search_text.right = ""
end

local function set_text_widgets()
    s = awful.screen.focused()
    s.memenu_search_left.text   = search_text.left
    s.memenu_search_middle.text = search_text.middle
    s.memenu_search_right.text  = search_text.right
end
--
-------------------------------------------------------------------------
-- Main Functions
local find_matching_options = function(text)
    local matching_options = {}
    for i, cmd in ipairs(binaries_in_path) do
        if string.match(cmd,text) then
            table.insert(matching_options, cmd)
        end
    end
    current_matches =  matching_options
end

local refresh_options
refresh_options = function(cmd,key)
    if key == "Right" then
        if #current_matches ~= current_position then
            current_position = current_position + 1
        end
    elseif key == "Left" then
        if current_position > 1 then
            current_position = current_position - 1
        end
    elseif key == "BackSpace" then
        if #cmd == 0 then 
            return 
        elseif #cmd == 1 then
            clear_text_widgets()
            set_text_widgets()
            return
        end
        find_matching_options(string.sub(cmd,1,#cmd-1))
        refresh_options(string.sub(cmd,1,#cmd-1),nil)
    elseif key == "Return" then
        awful.spawn(search_text.middle)
    elseif key == "Escape" then
        clear_text_widgets()
        set_text_widgets()
        return
    end

    clear_text_widgets()
    for i,_cmd in ipairs(current_matches) do
        if i < current_position then
            search_text.left = search_text.left.."    ".._cmd
        elseif i == current_position then
            search_text.middle = "  ".._cmd.."  " or "  "
        elseif i > current_position then
            search_text.right = search_text.right.."    ".._cmd
        end
    end
    set_text_widgets()
end
--
-------------------------------------------------------------------------
-- Exposed Function
local run = function(widget)
    awful.prompt.run {
        prompt       = " >>  ",
        textbox      = widget,
        exe_callback = function(text)
                clear_text_widgets()
                set_text_widgets()
            end,
            completion_callback = function(command_before_comp,cur_pos_before_comp,ncomp)
            find_matching_options(search_text.middle:gsub("%s+", ""))
            refresh_options(search_text.middle:gsub("%s+", ""),nil)
            return search_text.middle,1+#search_text.middle
        end,
        history_path = awful.util.get_cache_dir() .. "/history_eval",
        keypressed_callback  = function(mod, key, cmd)
            if #key == 1 then
                find_matching_options(cmd..key)
                refresh_options(cmd,key)
            else
                refresh_options(cmd,key)
            end
        end
    }
end

return {
    run = run
}
--
-------------------------------------------------------------------------
