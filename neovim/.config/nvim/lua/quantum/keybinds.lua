local map = vim.keymap.set

-- Fix * (Keep the cursor position, don't move to next match)
map('n', '*', '*N')

-- Fix n and N. Keeping cursor in center
map('n', 'n', 'nzzzv', { noremap = true })
map('n', 'N', 'Nzzzv', { noremap = true })
map('n', 'J', 'mzJ`z', { noremap = true })

-- Quickly save the current buffer or all buffers
map('n', '<leader>w', '<CMD>update<CR>')
map('n', '<leader>W', '<CMD>wall<CR>')
map('n', '<leader>x', ':x<CR>')

-- Edit and reload
map('n', '<leader>ev', ':edit ~/.config/nvim/init.lua<CR>')
map('n', '<leader>sv', ':source ~/.config/nvim/init.lua<CR>')
map('', 'gf', ':edit <cfile><CR>')

-- Clear search selection
map('n', '<leader>k', ':nohlsearch<CR>')

-- Navigation
map('n', '<C-h>', '<C-w>h', { silent = true })
map('n', '<C-j>', '<C-w>j', { silent = true })
map('n', '<C-k>', '<C-w>k', { silent = true })
map('n', '<C-l>', '<C-w>l', { silent = true })

-- Copy shenanigans
map('v', 'y', 'myy`y', { noremap = true })
map('v', 'Y', 'myy`Y', { noremap = true })
map('n', 'Y', 'y$', { noremap = true })
map('n', '<leader>p', '"+p', { noremap = true })
map('n', '<leader>y', '"+y', { noremap = true })
map('v', '<leader>p', '"+p', { noremap = true })
map('v', '<leader>y', '"+y', { noremap = true })

-- Easy escape
map('i', 'jj', '<ESC>')
map('i', 'kk', '<ESC>')
