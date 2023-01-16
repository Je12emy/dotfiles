local naughty = require("naughty")

local dump_text = function(text)
    naughty.notify({
        text = text,
        timeout = 0,
        hover_timeout = 0.5,
        width = 500,
    })
end

local M = {
    dump_text = dump_text,
}

return M
