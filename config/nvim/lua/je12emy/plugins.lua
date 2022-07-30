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
    -- Tree Explorer, might just remove it soon
    use {'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons'}
    -- Telescope
    use 'nvim-lua/popup.nvim'
    use 'nvim-telescope/telescope.nvim'
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
    -- UI
    use "hoob3rt/lualine.nvim"
    -- Themes
    use 'rebelot/kanagawa.nvim'
    -- Utils
    use 'tpope/vim-surround'
    use 'numToStr/Comment.nvim'
    use 'sheerun/vim-polyglot'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require'nvim-treesitter.configs'.setup {highlight = {enable = true}}
        end
    }
    use 'nvim-treesitter/playground'
    use 'nvim-lua/plenary.nvim'
    use 'norcalli/nvim-colorizer.lua'
    use 'sbdchd/neoformat'
    use 'mbbill/undotree'
    -- Git
    use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}
    use 'tpope/vim-fugitive'
    use 'sindrets/diffview.nvim'
    -- LSP
    use {
        "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim",
        'neovim/nvim-lspconfig'
    }
    -- DAP
    use {"rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"}}
    use "theHamsta/nvim-dap-virtual-text"
    -- use 'leoluz/nvim-dap-go'
    -- Snippets
    use 'L3MON4D3/LuaSnip'
    use "rafamadriz/friendly-snippets"
    -- Completition
    use 'hrsh7th/nvim-cmp'
    -- Completition sources
    use 'onsails/lspkind-nvim' -- Cool symbols
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-path'
    use 'davidsierradz/cmp-conventionalcommits'
    use 'saadparwaiz1/cmp_luasnip'
    -- Language Specific Plugins
    -- use 'simrat39/rust-tools.nvim'
    -- Journaling
    use 'vimwiki/vimwiki'
    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function() vim.g.mkdp_filetypes = {"markdown"} end,
        ft = {"markdown"}
    })
end)
