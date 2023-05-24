return {
    {
        "catppuccin/nvim",
        lazy = false,
        priority = 1000,
        name = "catppuccin",
        config = function()
            vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
            vim.cmd.colorscheme("catppuccin")
            require("catppuccin").setup {
                custom_highlights = function(colors)
                    return {
                        StatusLine = { bg = colors.none },
                    }
                end
            }
        end
    }
}