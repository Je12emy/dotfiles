-- vim.filetype.add({
--     extension = {
--         astro = "astro"
--     }
-- })

vim.cmd([[
    augroup _astro
    autocmd!
    autocmd BufRead,BufEnter *.astro set filetype=astro
    augroup end
]])
