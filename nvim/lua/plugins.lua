-- Bootstrap packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

-- Plugins list
require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    -- Tree Explorer, might just remove it soon
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons'
    }
    use 'airblade/vim-rooter'
    use 'kyazdani42/nvim-web-devicons'

    -- Telescope
    use 'nvim-lua/popup.nvim'
    use 'nvim-telescope/telescope.nvim'
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- UI
    use "hoob3rt/lualine.nvim"

    -- Themes
    use 'rebelot/kanagawa.nvim'

    -- Utils
    use 'tpope/vim-surround'
    use 'numToStr/Comment.nvim'
    use 'sheerun/vim-polyglot'
    use {'nvim-treesitter/nvim-treesitter',
          run=':TSUpdate',
          config = function()
            require'nvim-treesitter.configs'.setup {
              highlight = { enable = true }
            }
          end
    }
    use 'nvim-treesitter/playground'
    use 'nvim-lua/plenary.nvim'
    use 'norcalli/nvim-colorizer.lua'
    use 'ThePrimeagen/harpoon'
    use 'sbdchd/neoformat'

    -- Git
    use {
      'lewis6991/gitsigns.nvim',
      requires = {
        'nvim-lua/plenary.nvim'
      },
    }
    use 'tpope/vim-fugitive'

    -- LSP
    use {
      'neovim/nvim-lspconfig', 
    }

    -- DAP
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
    use 'leoluz/nvim-dap-go'

    -- Completition + Snippets
    use 'onsails/lspkind-nvim'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use "rafamadriz/friendly-snippets"
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lua'

    -- Language Specific Plugins

    -- Journaling
    use 'vimwiki/vimwiki'
end)

---- Configurations
require('plugins/colorizer')
require('plugins/comment')
require('plugins/gitsigns')
require('plugins/harpoon')
require('plugins/kanagawa')
require('plugins/lsp-kind')
require('plugins/lualine')
require('plugins/luasnip')
require('plugins/neoformat')
require('plugins/nvim-cmp')
require('plugins/nvim-dap')
require('plugins/nvimtree')
require('plugins/telescope')
require('plugins/vimwiki')
