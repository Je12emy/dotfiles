return {
    "cbochs/grapple.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    enabled = false,
    keys = function()
        return {
            { "<leader>m",  function() require("grapple").toggle() end,     desc = "Toggle grapple mark", },
            { "<leader>tm", function() require("grapple").popup_tags() end, desc = "Open grappgle marks" },
        }
    end,
}
