return {
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/playground",
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = { "nvim-treesitter/nvim-treesitter-context" },
        build = ':TSUpdate',
        config = function()
            local treesiter = require("nvim-treesitter.configs")
            local context = require("treesitter-context")
            treesiter.setup {
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = { "markdown" },
                } }
            context.setup {}
        end,
    }
}
