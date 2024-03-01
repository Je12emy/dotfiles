return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local treesiter = require("nvim-treesitter.configs")
			treesiter.setup({
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = { "markdown" },
					indent = { enable = true },
				},
			})
		end,
	},
}
