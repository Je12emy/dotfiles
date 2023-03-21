local list_files = function(path)
    local handle = io.popen("ls " .. path)
    local result = handle:read("*a")
    handle:close()
    return result
end

local split_string = function(input_string, separator)
    if separator == nil then separator = "%s" end
    local t = {}
    for str in string.gmatch(input_string, "([^" .. separator .. "]+)") do
        table.insert(t, str)
    end
    return t
end

local pick_random = function(options_table)
    math.randomseed(os.time())
    local random_index = math.random(1, #options_table)
    local random_element = options_table[random_index]
    return random_element
end

local pick_wallpaper = function(path, name)
    if name == nil then
        local files = list_files(path)
        local wallpapers = split_string(files, "\n")
        local selected_wallpaper = pick_random(wallpapers)
        return path .. "/" .. selected_wallpaper
    end
    return name
end

local M = {pick_wallpaper = pick_wallpaper}

return M
