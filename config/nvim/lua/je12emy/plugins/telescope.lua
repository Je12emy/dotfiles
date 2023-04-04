return {
    {
        'nvim-telescope/telescope.nvim',
        name = "Telescope",
        cmd = "Telescope",
        config = function() require('telescope').load_extension('fzf') end,
        opts = {
            file_ignore_patterns = {
                "dist/*", "node_modules/*", "target/*", "*.png", "*.svg"
            },
            shorten_path = true,
            color_devicons = true,
            extensions = {
                fzf = {
                    fuzzy = true, -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    case_mode = "smart_case" -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                }
            },
            pickers = {}
        },
        keys = {
            {
                "<c-p>",
                "<cmd>Telescope find_files<cr>",
                mode = "n",
                desc = "Find files"
            },
            {
                "<leader>fb",
                "<cmd>Telescope buffers<cr>",
                mode = "n",
                desc = "Find buffers"
            }, {
                "<leader>fs",
                "<cmd>Telescope current_buffer_fuzzy_find<cr>",
                mode = "n",
                desc = "Find string"
            }, {
                "<leader>fg",
                "<cmd>Telescope live_grep<cr>",
                mode = "n",
                desc = "Find with grep"
            },
            {
                "<leader>fk",
                "<cmd>Telescope keymaps<cr>",
                mode = "n",
                desc = "Find keymaps"
            }
        }
    }, {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        lazy = true,
        cmd = "Telescope"
    }
}
