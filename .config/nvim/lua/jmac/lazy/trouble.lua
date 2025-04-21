return {
    "folke/trouble.nvim",
    config = function()
        require("trouble").setup()
    end,
    cmd = "Trouble",
    keys = {
        {
            "<leader>xx",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
        },
    },
    modes = {
        test = {
            mode = "diagnostics",
            preview = {
            type = "split",
            relative = "win",
            position = "right",
            size = 0.3,
            },
        },
    },
}

