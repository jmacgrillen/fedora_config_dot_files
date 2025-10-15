require("jmac.options")
require("jmac.remap")
--require("jmac.diagnostics")
require("jmac.lazy_init")

vim.cmd [[colorscheme nord]]

vim.g.lightline = {
    colorscheme = 'nord'
    -- in lua, the above line is syntactic sugar for:
    -- ['colorscheme'] = 'catppuccin'
    -- this may be helpful if the option name has a reserved symbol in it like + or -
    -- ['key-here'] = 'value'
}

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
