return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            { 'neovim/nvim-lspconfig' },
            {
                -- Optional
                'williamboman/mason.nvim',
                build = function() pcall(vim.cmd, 'MasonUpdate') end
            }, { 'williamboman/mason-lspconfig.nvim' },
            -- Autocompletion
            {
                'hrsh7th/nvim-cmp',
                dependencies = {
                    "onsails/lspkind.nvim", "rafamadriz/friendly-snippets"
                }
            },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'saadparwaiz1/cmp_luasnip' },
            {
                'L3MON4D3/LuaSnip',
                version = "1.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
                -- install jsregexp (optional!).
                build = "make install_jsregexp"
            }

        },
        config = function()
            local lsp = require('lsp-zero').preset({})
            local tools = require 'je12emy.utils.lsp-tools'

            lsp.on_attach(function(client, bufnr)
                tools.on_attach(client, bufnr)
                lsp.buffer_autoformat()
            end)

            require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

            lsp.setup()

            local cmp = require('cmp')
            require('luasnip.loaders.from_vscode').lazy_load()

            cmp.setup({
                completion = { autocomplete = false },
                mapping = {
                    ['<C-Space>'] = cmp.mapping.complete(),
                },
                sources = { { name = 'nvim_lsp' }, { name = 'luasnip', keyword_length = 2 } },
                formatting = {
                    fields = { 'abbr', 'kind', 'menu' },
                    format = require('lspkind').cmp_format({
                        mode = 'symbol_text',
                        maxwidth = 50, -- prevent the popup from showing more than provided characters
                        ellipsis_char =
                        '...'          -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
                    })
                }
            })
        end
    }
}
