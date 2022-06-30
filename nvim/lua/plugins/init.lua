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
    -- Rooter plugins mostly cause issues for me
    -- use 'notjedi/nvim-rooter.lua'
    use 'kyazdani42/nvim-web-devicons'

    -- Telescope
    use 'nvim-lua/popup.nvim'
    use 'nvim-telescope/telescope.nvim'
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- UI
    -- Nice but I want a more minimalist config so these 2 arent needed
    -- use "hoob3rt/lualine.nvim"
    -- use {'akinsho/bufferline.nvim', 
    --      tag = "v2.*",
    --      requires = 'kyazdani42/nvim-web-devicons'
    -- }
    -- This is a nice minimalist statusline
    use 'strash/everybody-wants-that-line.nvim'

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
    use 'mbbill/undotree'
    use 'gyim/vim-boxdraw'

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
    -- use 'leoluz/nvim-dap-go'

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
    use 'simrat39/rust-tools.nvim'

    -- Journaling
    use 'vimwiki/vimwiki'
end)

-- Plugin Configuration
-- require('plugins/bufferline')
require('plugins/colorizer')
require('plugins/comment')
require('plugins/dap')
require('plugins/gitsigns')
require('plugins/harpoon')
require('plugins/kanagawa')
require('plugins/lsp-kind')
require("everybody-wants-that-line")
-- require('plugins/lualine')
require('plugins/luasnip')
require('plugins/neoformat')
-- require('plugins/nvim-rooter')
require('plugins/nvim-cmp')
require('plugins/nvimtree')
require('plugins/rust-tools')
require('plugins/telescope')
require('plugins/undotree')
require('plugins/vimwiki')
