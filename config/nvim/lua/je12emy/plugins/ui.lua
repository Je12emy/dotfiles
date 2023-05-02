return {
    { "mkitt/tabline.vim", lazy = true }, {
    "prichrd/netrw.nvim",
    lazy = false,
    cmd = { "Ex", "Sex" },
    keys = { { "<a-e>", vim.cmd.Ex, desc = "Open Netrw" } },
    config = function()
        require("netrw").setup {
            use_devicons = true -- Uses nvim-web-devicons if true, otherwise use the file icon specified above
        }
        local g = vim.g
        g.netrw_banner = 0
        -- 1 - open files in a new horizontal split
        -- 2 - open files in a new vertical split
        -- 3 - open files in a new tab
        -- 4 - open in previous window
        g.netrw_browse_split = 0
    end
}
}
