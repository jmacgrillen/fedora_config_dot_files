vim.g.mapleader = " "
vim.keymap.set("n", "<S-l>", "<cmd>bnext<CR>zz")
vim.keymap.set("n", "<S-h>", "<cmd>bprev<CR>zz")
vim.keymap.set("n", "<leader>a", "ggVG", { noremap = true, silent = true, desc = "Select entire file" })
vim.keymap.set({"v", "n"}, "<leader>y", '"+y', {noremap = true, silent = true, desc = "Yank to System Clipboard"})
