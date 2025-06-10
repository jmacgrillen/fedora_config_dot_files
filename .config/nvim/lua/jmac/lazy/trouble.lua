return {
    "folke/trouble.nvim",
    config = function()
        require("trouble").setup()
    end,
    cmd = "Trouble",
    keys = {
        {
            "<leader>xx",
            "<cmd>Trouble diagnostics toggle win.type=split win.position=right<cr>",
            desc = "Diagnostics (Trouble)",
        },
    },
}

