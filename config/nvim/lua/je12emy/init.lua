require('je12emy.keymaps')
require('je12emy.settings')
require('je12emy.plugins')
require('je12emy.lsp')
require('je12emy.config')
-- Bootstrap Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("je12emy/plugins")
