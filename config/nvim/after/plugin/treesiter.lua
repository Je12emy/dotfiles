local ok, treesiter = pcall(require, 'nvim-treesitter.configs')
if not ok then return end

local ok, context = pcall(require, 'treesitter-context')
if not ok then return end

treesiter.setup {highlight = {enable = true}}
context.setup {}
