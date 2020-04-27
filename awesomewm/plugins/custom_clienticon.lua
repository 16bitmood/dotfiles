--- Container showing the icon of a client.
-- @author Uli Schlachter
-- @copyright 2017 Uli Schlachter
-- @widgetmod awful.widget.clienticon

-- edited the original 'clienticon' widget --

-- A Really 'hacky' way of setting custom client icons
-- beacuse I don't know how widgets work :p

local base = require("wibox.widget.base")
local surface = require("gears.surface")
local gtable = require("gears.table")

local clienticon = {}
local instances = setmetatable({}, { __mode = "k" })

-- My Imports
local helpers = require("helpers")
local theme = require("theme")
local gears = require("gears")

function clienticon:draw(_, cr, width, height)
    local c = self._private.client
    if not c or not c.valid then
        return
    end
    local aspect_w = width / 640
    local aspect_h = height / 640
    local aspect = math.min(aspect_w, aspect_h)
    cr:scale(aspect, aspect)
    s = surface(helpers.get_icon_path(c.class))
    -- s=surface(gears.color.recolor_image(helpers.get_icon_path(c.class), theme.fg_color))
    -- ToDo: fix ^
    cr:set_source_surface(s, 0, 0)
    cr:paint()
end

function clienticon:fit(_, width, height)
    local c = self._private.client
    if not c or not c.valid then
        return 0, 0
    end
    -- don't know how this works
    local w, h = 1000,1000

    local aspect = math.min(width / w, height / h)
    return w * aspect, h * aspect
end

--- The widget's @{client}.
--
-- @property client
-- @param client
-- @propemits true false

function clienticon:get_client()
    return self._private.client
end

function clienticon:set_client(c)
    if self._private.client == c then return end
    self._private.client = c
    self:emit_signal("widget::layout_changed")
    self:emit_signal("widget::redraw_needed")
    self:emit_signal("property::client", c)
end

--- Returns a new clienticon.
-- @tparam client c The client whose icon should be displayed.
-- @treturn widget A new `widget`
-- @constructorfct awful.widget.clienticon
local function new(c)
    local ret = base.make_widget(nil, nil, {enable_properties = true})

    gtable.crush(ret, clienticon, true)

    ret._private.client = c

    instances[ret] = true

    return ret
end

client.connect_signal("property::icon", function(c)
    for obj in pairs(instances) do
        if obj._private.client.valid and obj._private.client == c then
            obj:emit_signal("widget::layout_changed")
            obj:emit_signal("widget::redraw_needed")
        end
    end
end)

--@DOC_widget_COMMON@

--@DOC_object_COMMON@

return setmetatable(clienticon, {
    __call = function(_, ...)
        return new(...)
    end
})

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
