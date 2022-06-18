require'nvim-tree'.setup {
  filters = {
    dotfiles = true,
    custom = { ".git" }
  },
  view = {
    width = '15%',
    side = 'right',
  }
}

vim.keymap.set( 'n',   '<c-t>', ':NvimTreeToggle<CR>')
