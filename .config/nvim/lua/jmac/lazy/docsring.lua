-- ~/.config/nvim/lua/plugins/neogen.lua
return {
  "danymat/neogen",
  cmd = "Neogen",
  keys = {
    { "<leader>fn", function() require("neogen").generate() end, desc = "Generate Docstring (Neogen)" },
  },
  opts = {
    -- You can set your preferred snippet engine here.
    -- LazyVim typically integrates with 'luasnip'.
    -- The default configuration in LazyVim is smart enough to detect your snippet engine.
    -- For example:
    -- snippet_engine = "luasnip", 
  },
}
