return {
    {
        "alexghergh/nvim-tmux-navigation",
        lazy = true,
        opts = {
            disable_when_zoomed = true
        },
        keys = {
            {
                "<c-h>",
                "<cmd>NvimTmuxNavigateLeft<cr>",
                desc = "Focus left"
            },
            {
                "<c-l>",
                "<cmd>NvimTmuxNavigateRight<cr>",
                desc = "Focus right"
            },
            {
                "<c-j>",
                "<cmd>NvimTmuxNavigateDown<cr>",
                desc = "Focus down"
            },
            {
                "<c-k>",
                "<cmd>NvimTmuxNavigateUp<cr>",
                desc = "Focus up"
            },
        },
        cmd = { "NvimTmuxNavigateLeft", "NvimTmuxNavigateRight", "NvimTmuxNavigateUp", "NvimTmuxNavigateDown" }
    }
}
