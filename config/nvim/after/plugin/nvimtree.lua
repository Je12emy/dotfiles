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
    hijack_unnamed_buffer_when_opening = true,
    update_cwd = true,
    hijack_cursor = true,
    filters = {dotfiles = false, custom = {"node_modules", "dist", "target"}},
    git = {enable = false},
    view = {
        adaptive_size = true,
        side = 'right',
        mappings = {custom_only = true, list = mappings},
        hide_root_folder = false,
    },
    renderer = {highlight_opened_files = "all"}
}

vim.keymap.set('n', '<a-t>', ':NvimTreeToggle<CR>')
