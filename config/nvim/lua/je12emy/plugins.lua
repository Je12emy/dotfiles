local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        'git', 'clone', '--depth', '1',
        'https://github.com/wbthomason/packer.nvim', install_path
    })
    vim.cmd 'packadd packer.nvim'
end
-- Plugins list
require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    -- Lodaash Section
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'sheerun/vim-polyglot'
    -- Telescope stuff
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
    -- UI
    use 'hoob3rt/lualine.nvim'
    use 'mkitt/tabline.vim'
    -- use {'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons'}
    -- Themes
    use 'rebelot/kanagawa.nvim'
    use 'ellisonleao/gruvbox.nvim'
    use 'catppuccin/nvim'
    -- Utils
    use 'tpope/vim-surround'
    use 'numToStr/Comment.nvim'
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-treesitter/playground'
    use 'nvim-treesitter/nvim-treesitter-context'
    -- use 'norcalli/nvim-colorizer.lua'
    use 'sbdchd/neoformat'
    use 'mbbill/undotree'
    -- Git
    use 'lewis6991/gitsigns.nvim'
    -- LSP
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'neovim/nvim-lspconfig'
    -- Snippets
    use 'L3MON4D3/LuaSnip'
    use 'rafamadriz/friendly-snippets'
    -- Completition
    use 'hrsh7th/nvim-cmp' -- Completition Engine
    use 'onsails/lspkind-nvim' -- Cool symbols
    use 'hrsh7th/cmp-nvim-lsp' -- Sources
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-path'
    use 'saadparwaiz1/cmp_luasnip'
    -- Language Specific Plugins
    -- use 'simrat39/rust-tools.nvim'
    use 'jose-elias-alvarez/typescript.nvim'
    -- DAP
    -- use {"rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"}}
    -- use "theHamsta/nvim-dap-virtual-text"
    -- use 'leoluz/nvim-dap-go'
end)
