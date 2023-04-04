return {
    {'nvim-telescope/telescope.nvim', cmd = "Telescope", lazy = true}, {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        lazy = true,
        cmd = "Telescope"
    }
}
