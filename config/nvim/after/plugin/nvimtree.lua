local ok, nvimtree = pcall(require, 'nvim-tree')
if not ok then return end
-- Vim-like mappings I guess
local mappings = {
    {key = "o", action = "edit"}, {key = "l", action = "cd"},
    {key = "h", action = "dir_up"}, {key = "K", action = "toggle_file_info"},
    {key = "r", action = "rename"}, {key = "a", action = "create"},
    {key = "d", action = "remove"}, {key = "I", action = "toggle_git_ignored"},
    {key = "H", action = "toggle_dotfiles"}, {key = "R", action = "refresh"},
    {key = "y", action = "copy_name"}, {key = "Y", action = "copy_path"},
    {key = "gy", action = "copy_absolute_path"},
    {key = "U", action = "toggle_custom"}
}

nvimtree.setup {
    update_cwd = true,
    diagnostics = {enable = true, show_on_dirs = false},
    hijack_cursor = true,
    filters = {
        dotfiles = true,
        custom = {"node_modules", "dist", "target"}
    },
    view = {
        width = '20%',
        side = 'right',
        mappings = {custom_only = true, list = mappings}
    }
}

vim.keymap.set('n', '<a-t>', ':NvimTreeToggle<CR>')
