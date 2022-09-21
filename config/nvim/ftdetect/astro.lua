vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*.astro",
    command = "set filetype=astro"
})
