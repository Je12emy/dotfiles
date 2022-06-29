-- Vim-like mappings I guess
local mappings = {
    { key = "o", action = "edit" },
    { key = "l", action = "cd" },
    { key = "h", action = "dir_up" },
    { key = "K", action = "toggle_file_info" },
    { key = "r", action = "rename" },
    { key = "a", action = "create" },
    { key = "d", action = "remove" },
    { key = "I", action = "toggle_git_ignored" },
    { key = "H", action = "toggle_dotfiles" },
    { key = "R", action = "refresh" },
    { key = "y", action = "copy_name" },
    { key = "Y", action = "copy_path" },
    { key = "gy", action = "copy_absolute_path" }
}

require'nvim-tree'.setup {
  update_cwd = true,
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  hijack_cursor = true,
  filters = {
    dotfiles = true,
    custom = { "node_modules" }
  },
  view = {
    width = '20%',
    side = 'right',
    mappings = {
      custom_only = true,
      list = mappings,
    },
  }
}

vim.keymap.set( 'n',   '<a-t>', ':NvimTreeToggle<CR>')
