return {
    "tpope/vim-surround", "numToStr/Comment.nvim",
    {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
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
