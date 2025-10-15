-- Example for lazy.nvim
return {
  'stevearc/conform.nvim',
  lazy = false, -- Load it early, or use an event like BufWritePre
  config = function()
    require("conform").setup({
      -- Define formatters for specific file types
      formatters_by_ft = {
        -- Use Black for Python files
        python = { "black" },
        -- You can combine formatters, e.g., isort followed by black
        -- python = { "isort", "black" },    
      },
      format_on_save = {
        -- This will run on BufWritePre for *all* files.
        -- The formatters_by_ft list ensures it only runs Black on Python.
        timeout_ms = 500,
        -- Set to true to force synchronous formatting if needed (can be slow)
        async = false,
      },
    })

  end,
}
