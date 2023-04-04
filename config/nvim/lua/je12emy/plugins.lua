-- Bootstrap Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Generally required plugins
    'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim', 'sheerun/vim-polyglot',
    -- Telescope for all the things
    'nvim-telescope/telescope.nvim',
    {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'}, -- UI Plugins
    "hoob3rt/lualine.nvim", "mkitt/tabline.vim", "prichrd/netrw.nvim",
    -- Themes
    "catppuccin/nvim",
    "rebelot/kanagawa.nvim",
    "ellisonleao/gruvbox.nvim",
    -- Utilities
    "tpope/vim-surround",
    "numToStr/Comment.nvim",
    {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
    "nvim-treesitter/playground",
    "nvim-treesitter/nvim-treesitter-context",
    "alexghergh/nvim-tmux-navigation",
    "ThePrimeagen/harpoon",
    -- "github/copilot.vim",
    "sbdchd/neoformat",
    "mbbill/undotree",
    -- Git plugins
    "lewis6991/gitsigns.nvim",
    "tpope/vim-fugitive",
    {'sindrets/diffview.nvim', requires = 'nvim-tree/nvim-web-devicons'},
    -- LSP
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    -- Completition
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
    -- Completition
    "hrsh7th/nvim-cmp",
    "onsails/lspkind-nvim", 
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    -- Language Specific Plugins
    "simrat39/rust-tools.nvim",
    "jose-elias-alvarez/typescript.nvim",
    "wuelnerdotexe/vim-astro",
})
