local ok, catpuccin = pcall(require, 'catppuccin')
if not ok then return end
vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
catpuccin.setup({
    transparent_background = false,
    term_colors = false,
    compile = {enabled = false, path = vim.fn.stdpath("cache") .. "/catppuccin"},
    dim_inactive = {enabled = false, shade = "dark", percentage = 0.15},
    styles = {
        comments = {"italic"},
        conditionals = {"italic"},
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {}
    },
    integrations = {
        -- For various plugins integrations see https://github.com/catppuccin/nvim#integrations
        indent_blankline = {enabled = true, colored_indent_levels = false}
    },
    color_overrides = {},
    highlight_overrides = {}
})
vim.cmd("colorscheme catppuccin")
