local g = vim.g

g.vimwiki_list = {{path = '~/Nextcloud/Notes', syntax = 'markdown', ext = '.md'}}
g.vimwiki_autochdir = 1
g.vimwiki_global_ext = 0

-- When navigating, this will autosave
vim.cmd('autocmd FileType markdown set autowriteall')
-- Some settings for note taking
vim.cmd('autocmd FileType markdown set wrap')
vim.cmd('autocmd FileType markdown set linebreak')
vim.cmd('autocmd FileType markdown set cc=0')
