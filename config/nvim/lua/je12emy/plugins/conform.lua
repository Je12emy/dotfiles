return {
	{ -- Autoformat
		"stevearc/conform.nvim",
		opts = {
			notify_on_error = false,
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				-- See: https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters
				lua = { "stylua" },
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- You can use a sub-list to tell conform to run *until* a formatter
				-- is found.
				javascript = { { "prettierd", "prettier" } },
				astro = { { "prettierd", "prettier" } },
				css = { { "prettierd", "prettier" } },
				go = { { "gofmt" } },
				rust = { { "rustfmt" } },
			},
		},
	},
}
