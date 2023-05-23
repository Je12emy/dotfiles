return {
    { "mkitt/tabline.vim",           lazy = true },
    { 'nvim-tree/nvim-web-devicons', lazy = false },
    {
        "prichrd/netrw.nvim",
        enabled = false,
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
    },
    {
        'stevearc/oil.nvim',
        opts = {
            keymaps = {
                ["g?"] = "actions.show_help",
                ["l"] = "actions.select",
                ["h"] = "actions.parent",
                ["g."] = "actions.toggle_hidden",
                ["<CR>"] = "actions.select",
                ["<C-t>"] = "actions.select_tab",
                ["<C-c>"] = "actions.close",
                ["<C-l>"] = "actions.refresh",
                ["<C-v>"] = "actions.preview",
                ["_"] = "actions.open_cwd",
                ["<c-<CR>>"] = "actions.cd",
            },
            use_default_keymaps = false,
            default_file_explorer = true,
        },
        keys = { "<a-e>", "<cmd>Oil<CR>", mode = "n", desc = "Open Oil" },
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
    }
}
