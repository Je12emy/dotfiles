return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			{
				"saadparwaiz1/cmp_luasnip",
				version = "v2.*",
				build = "make install_jsregexp",
				enabled = false,
			},
		},
	},
	"Decodetalkers/csharpls-extended-lsp.nvim",
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = event.buf, desc = "Show documentation" })
					vim.keymap.set(
						"n",
						"<leader>cr",
						vim.lsp.buf.rename,
						{ buffer = event.buf, desc = "[C]ode [R]ename symbol" }
					)
					vim.keymap.set(
						"n",
						"<leader>ca",
						vim.lsp.buf.code_action,
						{ buffer = event.buf, desc = "[C]ode [A]ction" }
					)
					vim.keymap.set(
						"n",
						"gi",
						require("telescope.builtin").lsp_implementations,
						{ buffer = event.buf, desc = "[G]oto [I]implementation" }
					)
					vim.keymap.set(
						"n",
						"gr",
						require("telescope.builtin").lsp_references,
						{ buffer = event.buf, desc = "[G]oto [R]eferences" }
					)
					vim.keymap.set(
						"n",
						"gd",
						require("telescope.builtin").lsp_definitions,
						{ buffer = event.buf, desc = "[G]oto [D]efinition" }
					)
					vim.keymap.set(
						"n",
						"[d",
						vim.diagnostic.goto_prev,
						{ buffer = event.buf, desc = "Prev [D]iagnostic" }
					)
					vim.keymap.set(
						"n",
						"]d",
						vim.diagnostic.goto_next,
						{ buffer = event.buf, desc = "Next [D]iagnostic" }
					)
					vim.keymap.set(
						"n",
						"<leader>f",
						vim.lsp.buf.format,
						{ buffer = event.buf, desc = "[F]ormat buffer" }
					)
					vim.keymap.set(
						"n",
						"<c-k>",
						vim.lsp.buf.signature_help,
						{ buffer = event.buf, desc = "Show signature" }
					)
				end,
			})
			-- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				settings = {
					["rust-analyzer"] = {
						diagnostics = {
							enable = false,
						},
					},
				},
			})
			lspconfig.gopls.setup({
				capabilities = capabilities,
			})
			lspconfig.tsserver.setup({
				capabilities = capabilities,
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.csharp_ls.setup({
				capabilities = capabilities,
				handlers = {
					["textDocument/definition"] = pcall(require("csharpls_extended").handler),
					["textDocument/typeDefinition"] = pcall(require("csharpls_extended").handler),
				},
			})
			lspconfig.astro.setup({
				capabilities = capabilities,
			})
		end,
	},
}
