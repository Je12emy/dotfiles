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
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- You can use a sub-list to tell conform to run *until* a formatter
				-- is found.
				-- See: https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters

				-- Stylua is available in your package manager or you could download the binary
				-- see: https://github.com/JohnnyMorganz/StyLua?tab=readme-ov-file#installation
				lua = { "stylua" },

				-- Prettier can be installed with npm:
				-- $ npm install -g prettier
				javascript = { { "prettierd", "prettier" } },
				astro = { { "prettierd", "prettier" } },
				markdown = { { "prettierd", "prettier" } },
				css = { { "prettierd", "prettier" } },

				-- C Sharpier can be installed with dotnet
				-- $ dotnet tool install csharpier -g
				-- see: https://github.com/belav/csharpier
				csharp = { { "csharpier", format_on_save = false } },

				-- Gofmt should be included with your go installation, make sure "go/bin" is in your path
				go = { { "gofmt" } },

				-- Rustfmt  can be installed it with rustup
				-- $ rustup component add rustfmt
				-- see: https://github.com/rust-lang/rustfmt?tab=readme-ov-file#quick-start
				rust = { { "rustfmt" } },
			},
		},
	},
}
