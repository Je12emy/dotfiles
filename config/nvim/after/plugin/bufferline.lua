local ok, bufferline = pcall(require, 'bufferline')
if not ok then return end
bufferline.setup {
    options = {
        mode = "tabs",
        show_close_icon = false,
        separator_style = "thin",
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "left",
                separator = true
            }
        }
    }
}
