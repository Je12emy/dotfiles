return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'}, -- Required
            { -- Optional
                'williamboman/mason.nvim',
                build = function() pcall(vim.cmd, 'MasonUpdate') end
            }, {'williamboman/mason-lspconfig.nvim'}, -- Optional
            -- Autocompletion
            {'hrsh7th/nvim-cmp'}, -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'L3MON4D3/LuaSnip'} -- Required
        },
        config = function()
            local lsp = require('lsp-zero').preset({})
            local tools = require 'je12emy.lsp.lsp-tools'

            lsp.on_attach(tools.on_attach)

            require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

            lsp.setup()
        end
    }
}
