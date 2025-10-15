-- lua/config/diagnostics.lua

-- Define the custom icons
local signs = {
  Error = '❌', -- Icon for errors
  Warn = '⚠️',  -- Icon for warnings
  Info = 'ℹ️',  -- Icon for info
  Hint = '💡',  -- Icon for hints
}

-- 1. Setup the highlight groups for color differentiation (optional but recommended)
-- Remove the comment markers below if you want to use custom colors as well
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextError', { fg = '#bf616a' })
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextWarn', { fg = '#ebcb8b' })
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextInfo', { fg = '#a3be8c' })
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextHint', { fg = '#b48ead' })
vim.api.nvim_set_hl(0, 'LspDiagnosticsVirtualText', { link = 'DiagnosticVirtualText' })


-- 2. Configure the built-in diagnostics
vim.diagnostic.config({
  virtual_text = {
    -- Enable virtual text for inline messages, and customize it
    enabled = true,
    -- The prefix key is a function that returns an icon based on severity
    prefix = function(diagnostic)
      local severity = diagnostic.severity
      
      -- The numerical constants ensure you correctly check the severity level
      if severity == vim.diagnostic.severity.ERROR then
        return signs.Error
      elseif severity == vim.diagnostic.severity.WARN then
        return signs.Warn
      elseif severity == vim.diagnostic.severity.INFO then
        return signs.Info
      elseif severity == vim.diagnostic.severity.HINT then
        return signs.Hint
      else
        return ' ' -- Fallback
      end
    end,
  },
  signs = true,             -- Also show icons in the sign column
  underline = true,         -- Underline the problematic text
  update_in_insert = false, -- Only update when leaving insert mode
})
