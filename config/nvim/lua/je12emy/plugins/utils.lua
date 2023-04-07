return {
    "tpope/vim-surround", {
        "numToStr/Comment.nvim",
        opts = {
            padding = true,
            sticky = true,
            ignore = nil,
            toggler = {line = 'gcc', block = 'gbc'},
            opleader = {line = 'gc', block = 'gb'},
            mappings = {basic = true, extra = true, extended = false},
            pre_hook = nil,
            post_hook = nil
        }
    }, {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {"nvim-treesitter/nvim-treesitter-context"},
        build = ':TSUpdate',
        config = function()
            local treesiter = require("nvim-treesitter.configs")
            local context = require("treesitter-context")
            treesiter.setup {highlight = {enable = true}}
            context.setup {}
        end,
    }, "nvim-treesitter/playground", "nvim-treesitter/nvim-treesitter-context",
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
        cmd = {"NvimTmuxNavigateLeft","NvimTmuxNavigateRight", "NvimTmuxNavigateUp", "NvimTmuxNavigateDown"}
    }, -- "github/copilot.vim",
    {
        "sbdchd/neoformat",
        cmd = "Neoformat",
        lazy = true,
        keys = {
            {"<leader><leader>f", "<cmd>Neoformat<cr>", desc = "Format buffer"}
        }
    }, {
        "mbbill/undotree",
        keys = {{"<a-u>", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree"}},
        cmd = "UndoTreeToggle"
    }
}
