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
    }, {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
    "nvim-treesitter/playground", "nvim-treesitter/nvim-treesitter-context",
    "alexghergh/nvim-tmux-navigation", "ThePrimeagen/harpoon",
    -- "github/copilot.vim",
    {
        "sbdchd/neoformat",
        cmd = "Neoformat",
        lazy = true,
        keys = {
            {"<leader><leader>f", "<cmd>Neoformat<cr>", desc = "Format buffer"}
        }
    }, "mbbill/undotree"
}
