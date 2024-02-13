local function on_attach(client, bufnr)
	local keymap = require "je12emy.utils.map"

	keymap.nmap("K", vim.lsp.buf.hover,
		{ buffer = 0, desc = "Show documentation" })
	keymap.nmap("<leader>cr", vim.lsp.buf.rename,
		{ buffer = 0, desc = "Rename symbol" })
	keymap.nmap("<leader>ca", vim.lsp.buf.code_action,
		{ buffer = 0, desc = "Show code actions" })
	keymap.nmap("<leader>ci", vim.lsp.buf.implementation,
		{ buffer = 0, desc = "Show implementations" })
	keymap.nmap("<leader>cd", vim.lsp.buf.definition,
		{ buffer = 0, desc = "Show definitions" })
	keymap.nmap("[d", vim.diagnostic.goto_prev,
		{ buffer = 0, desc = "Go to previous diagnostic" })
	keymap.nmap("]d", vim.diagnostic.goto_next,
		{ buffer = 0, desc = "Go to next diagnostic" })
	keymap.nmap("<leader><leader>f", vim.lsp.buf.format,
		{ buffer = 0, desc = "Format buffer" })
	keymap.imap("<c-k>", vim.lsp.buf.signature_help,
		{ buffer = 0, desc = "Show completition item" })
end

return {
	"neovim/nvim-lspconfig",
	"williamboman/mason.nvim",
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			require("mason").setup()
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name) -- default handler (optional)
						require("lspconfig")[server_name].setup {
							on_attach = on_attach,
							capabilities = capabilities
						}
					end,
					csharp_ls = function()
						require 'lspconfig'.csharp_ls.setup {
							on_attach = on_attach,
							handlers = {
								["textDocument/definition"] = require('csharpls_extended').handler,
								["textDocument/typeDefinition"] = require('csharpls_extended').handler,
							},
						}
					end,
				}
			})
		end,
		dependencies = {
			'neovim/nvim-lspconfig',
			{
				'hrsh7th/nvim-cmp',
				config = function()
					local cmp = require 'cmp'
					cmp.setup({
						snippet = {
							expand = function(args)
								require('luasnip').lsp_expand(args.body)
							end,
						},
						mapping = cmp.mapping.preset.insert({
							['<C-b>'] = cmp.mapping.scroll_docs(-4),
							['<C-f>'] = cmp.mapping.scroll_docs(4),
							['<C-Space>'] = cmp.mapping.complete(),
							['<C-e>'] = cmp.mapping.abort(),
							['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
						}),
						sources = cmp.config.sources({
							{ name = 'nvim_lsp' },
							{ name = 'luasnip' },
						}, {
							{ name = 'buffer' },
						})
					})
				end,
				dependencies = {
					'hrsh7th/cmp-nvim-lsp',
					'hrsh7th/cmp-buffer',
					'hrsh7th/cmp-path',
					'hrsh7th/cmp-cmdline',
					'L3MON4D3/LuaSnip',
					{
						'saadparwaiz1/cmp_luasnip',
						version = "v2.*",
						build = "make install_jsregexp",
						enabled = false
					},
				}
			},
		},
	},
}
