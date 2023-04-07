return {
    {
        "catppuccin/nvim",
        lazy = false,
        priority = 1000,
        name = "catppuccin",
        config = function(_, opts)
            vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
            vim.cmd.colorscheme("catppuccin")
        end
    }, {"ellisonleao/gruvbox.nvim", lazy = true},
    {"rebelot/kanagawa.nvim", lazy = true}
}
