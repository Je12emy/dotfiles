return {
    {
        'stevearc/oil.nvim',
        lazy = false,
        config = function()
            require("oil").setup {
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
            }
            local keymap = require "je12emy.utils.map"
            keymap.nmap('<a-e>', '<cmd>Oil<CR>', { desc = "Open Oil" })
            -- Disable netrw
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
        end,
        dependencies = { "nvim-tree/nvim-web-devicons" },
    }
}
