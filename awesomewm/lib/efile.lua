------------------------------------------------------------------------------------
-- Imports
local json = require("lib.json")
------------------------------------------------------------------------------------
local readall = function (path_of_file)
    local opened_file = assert(io.open(path_of_file,"r"))
    local file_as_string = opened_file:read("all")
    io.close(opened_file)
    return file_as_string
end

local saveall = function (path_of_file,string_to_write)
    local opened_file = io.open(path_of_file,"w")
    opened_file:write(string_to_write)
    opened_file:close()
end

local readjson = function (path_of_file)
    file_as_string = readall(path_of_file)
    return json.decode(file_as_string)
end

local savejson = function (path_of_file,table_to_write)
    local opened_file = io.open(path_of_file,"w")
    opened_file:write(json.encode(table_to_write))
    opened_file:close()
    -- TODO: json.lua doesn't support "pretty" formatting,
    -- find a way to do that
end

local readlines = function (path_of_file) -- TODO: add seperator option
    local opened_file = io.open(path_of_file,"r")
    local arr = {}
    for line in opened_file:lines() do
       table.insert (arr, line)
    end
    opened_file:close()
    return arr
end
------------------------------------------------------------------------------------
return {
    readfull = readfull,
    saveall = saveall,
    readjson = readjson,
    savejson = savejson,
    readlines = readlines,
}