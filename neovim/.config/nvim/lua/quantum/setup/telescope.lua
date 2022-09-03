local silent = { silent = true, noremap = true }

vim.keymap.set('n', '<leader>f', [[<cmd>Telescope find_files<cr>]], silent)
vim.keymap.set('n', '<leader>b', [[<cmd>Telescope buffers<cr>]], silent)
vim.keymap.set('n', '<leader>r', [[<cmd>Telescope live_grep<cr>]], silent)
