vim.g.mapleader = " "
vim.keymap.set("n", "<S-l>", "<cmd>bnext<CR>zz")
vim.keymap.set("n", "<S-h>", "<cmd>bprev<CR>zz")
vim.keymap.set("n", "<leader>a", "ggVG")
vim.keymap.set('n', '<leader>td', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { silent = true, noremap = true })
vim.api.nvim_set_keymap('x', '<leader>y', '"+y', { noremap = true, silent = true, desc = 'Yank to system clipboard' })
vim.api.nvim_set_keymap('v', '<leader>c', ":s/^/#/g<CR>gv", { noremap = true, silent = true, desc = 'Toggle comment block (Simple)' })
