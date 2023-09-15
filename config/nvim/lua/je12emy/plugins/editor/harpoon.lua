return {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("telescope").load_extension('harpoon')
    end,
    keys = function()
        return {
            {
                "<leader>m",
                function()
                    local mark = require('harpoon.mark')
                    local i = mark.get_current_index()
                    mark.toggle_file(i)
                end,
                desc = "Toggle grapple mark",
            },
            {
                "<leader>tm",
                "<cmd>Telescope harpoon marks theme=dropdown previewer=false<cr>",
                desc = "Open grappgle marks"
            },
        }
    end
}
