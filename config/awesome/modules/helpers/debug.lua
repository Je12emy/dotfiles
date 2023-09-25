local naughty = require("naughty")

local m = {}

m.dump_text = function(text)
    naughty.notify({ text = text, timeout = 0 })
end

m.debug_table = function(table)
    local tableString = "Table contents:\n"
    for key, value in pairs(table) do
        tableString = tableString .. key .. ": " .. tostring(value) .. "\n"
    end
    naughty.notify({ text = tableString, timeout = 0 })
end

return m
