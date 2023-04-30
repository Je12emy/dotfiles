return {
    {
        "simrat39/rust-tools.nvim",
        lazy = true,
        ft = "rs",
        --[[ config = function()
            local tools = require 'je12emy.utils.lsp-tools'
            local capabilities = tools.get_capabilities()
            require("rust_tools").setup({
                dap = {
                    adapter = {
                        type = 'executable',
                        command = 'lldb-vscode-14', -- sudo apt-get install lldb
                        name = "rt_lldb"
                    }
                },
                server = {
                    on_attach = tools.on_attach,
                    capabilities = capabilities
                }
            })
        end ]]
    }, {
    "jose-elias-alvarez/typescript.nvim",
    ft = { "ts", "js", "tsx", "jsx" },
    lazy = true,
    config = function()
        local tools = require 'je12emy.utils.lsp-tools'
        require("typescript").setup({
            disable_commands = false, -- prevent the plugin from creating Vim commands
            debug = false,            -- enable debug logging for commands
            go_to_source_definition = {
                fallback = true       -- fall back to standard LSP definition on failure
            },
            server = {                -- pass options to lspconfig's setup method
                on_attach = tools.on_attach
            }
        })
    end
}, {
    "wuelnerdotexe/vim-astro",
    config = function() vim.g.astro_typescript = 'enable' end
}
}
