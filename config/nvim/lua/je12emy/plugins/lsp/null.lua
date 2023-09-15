return {
	{
		"jose-elias-alvarez/null-ls.nvim",
		enabled = false,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"jay-babu/mason-null-ls.nvim",
			opts = {
				ensure_installed = { "prettier", "eslint", "stylua" },
				automatic_installation = true,
			},
		},
		opts = function()
			local null_ls = require("null-ls")
			return {
				sources = {
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.pint,
					null_ls.builtins.formatting.stylua,
					-- null_ls.builtins.diagnostics.eslint,
					null_ls.builtins.completion.spell,
				},
			}
		end,
	},
}
