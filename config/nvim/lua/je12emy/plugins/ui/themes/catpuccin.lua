return {
	{
		"catppuccin/nvim",
		lazy = false,
		priority = 1000,
		name = "catppuccin",
		config = function()
			vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
