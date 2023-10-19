return {
	{
		"catppuccin/nvim",
		lazy = false,
		priority = 1000,
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				custom_highlights = function(colors)
					return {
						TabLineSel = { bg = colors.base },
						TabLine = { bg = colors.base },
						TabLineFill = { bg = colors.base },
					}
				end,
			})
			vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
		end,
	},
}
