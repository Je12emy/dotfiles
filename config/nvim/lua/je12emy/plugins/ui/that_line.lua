return
{
    "strash/everybody-wants-that-line.nvim",
    enabled = false,
    config = function()
        require("everybody-wants-that-line").setup({
            buffer = {
                enabled = false,
                prefix = "B:",
                -- Placeholder before buffer number, e.g. "00001".
                -- If you don't want additional symbols to be displayed,
                -- set `symbol = ""` or `max_symbols = 0`.
                symbol = "0",
                -- Maximum number of symbols including buffer number.
                max_symbols = 5,
            },
            diagnostics = {
                enabled = true,
            },
            quickfix_list = {
                enabled = true,
            },
            git_status = {
                enabled = true,
            },
            filepath = {
                enabled = true,
                -- `path` can be one of these:
                -- "tail" - file name only
                -- "relative" - relative to working directory
                -- "full" - full path to the file
                path = "relative",
                -- If `true` a path will be shortened, e.g. "/a/b/c/filename.lua".
                -- It only works if `path` is "relative" or "full".
                shorten = false,
            },
            filesize = {
                enabled = true,
                -- `metric` can be:
                -- "decimal" - 1000 bytes == 1 kilobyte
                -- "binary" - 1024 bytes == 1 kibibyte
                metric = "decimal"
            },
            ruller = {
                enabled = true,
            },
            -- Filename is a separate widget that is located
            -- in the upper right corner of each open window.
            filename = {
                enabled = true,
            },
            -- Separator between components, e.g. " ... │ ... │ ... "
            separator = "│",
        })
    end
}
