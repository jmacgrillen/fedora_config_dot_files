return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = { 
                theme = 'nord',
                icons_enabled = true
            }
        })
    end,
}
