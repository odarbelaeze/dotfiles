local map = vim.api.nvim_set_keymap

local silent = { silent = true, noremap = true }

map('n', '<leader>f', [[<cmd>Telescope find_files theme=get_dropdown<cr>]], silent)
