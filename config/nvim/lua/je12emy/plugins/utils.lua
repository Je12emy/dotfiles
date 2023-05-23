return {
    {
        "numToStr/Comment.nvim",
        opts = {
            padding = true,
            sticky = true,
            ignore = nil,
            toggler = { line = 'gcc', block = 'gbc' },
            opleader = { line = 'gc', block = 'gb' },
            mappings = { basic = true, extra = true, extended = false },
            pre_hook = nil,
            post_hook = nil
        }
    },
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = { "nvim-treesitter/nvim-treesitter-context" },
        build = ':TSUpdate',
        config = function()
            local treesiter = require("nvim-treesitter.configs")
            local context = require("treesitter-context")
            treesiter.setup { highlight = { enable = true } }
            context.setup {}
        end,
    },
    "nvim-treesitter/playground",
    "nvim-treesitter/nvim-treesitter-context",
    {
        "alexghergh/nvim-tmux-navigation",
        lazy = true,
        opts = {
            disable_when_zoomed = true
        },
        keys = {
            {
                "<c-h>",
                "<cmd>NvimTmuxNavigateLeft<cr>",
                desc = "Focus left"
            },
            {
                "<c-l>",
                "<cmd>NvimTmuxNavigateRight<cr>",
                desc = "Focus right"
            },
            {
                "<c-j>",
                "<cmd>NvimTmuxNavigateDown<cr>",
                desc = "Focus down"
            },
            {
                "<c-k>",
                "<cmd>NvimTmuxNavigateUp<cr>",
                desc = "Focus up"
            },
        },
        cmd = { "NvimTmuxNavigateLeft", "NvimTmuxNavigateRight", "NvimTmuxNavigateUp", "NvimTmuxNavigateDown" }
    }, -- "github/copilot.vim",
    {
        "mbbill/undotree",
        keys = { { "<a-u>", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" } },
        cmd = "UndoTreeToggle"
    },
    {
        "epwalsh/obsidian.nvim",
        lazy = true,
        event = { "BufReadPre " .. vim.fn.expand "~" .. "/notes/**.md" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
            "nvim-telescope/telescope.nvim",
            "godlygeek/tabular",
            "preservim/vim-markdown",
        },
        opts = {
            dir = "~/notes", -- no need to call 'vim.fn.expand' here
            daily_notes = {
                folder = "/dailies",
            },
            completion = {
                nvim_cmp = true
            },
            disable_frontmatter = true,
            follow_url_func = function(url)
                vim.fn.jobstart({ "xdg-open", url }) -- linux
            end,
            use_advanced_uri = false,
            open_app_foreground = true,
            finder = "telescope.nvim",
        },
        config = function(_, opts)
            vim.g.vim_markdown_folding_disabled = 1
            require("obsidian").setup(opts)
            -- Optional, override the 'gf' keymap to utilize Obsidian's search functionality.
            -- see also: 'follow_url_func' config option above.
            vim.keymap.set("n", "gf", function()
                if require("obsidian").util.cursor_on_markdown_link() then
                    return "<cmd>ObsidianFollowLink<CR>"
                else
                    return "gf"
                end
            end, { noremap = false, expr = true })
        end,
    },
}
