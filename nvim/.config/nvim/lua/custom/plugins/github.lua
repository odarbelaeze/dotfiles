return {
  'Almo7aya/openingh.nvim',
  event = 'VeryLazy',
  config = function()
    vim.api.nvim_set_keymap('n', '<Leader>gr', ':OpenInGHRepo <CR>', { silent = true, noremap = true })
    vim.api.nvim_set_keymap('n', '<Leader>gf', ':OpenInGHFile <CR>', { silent = true, noremap = true })
    vim.api.nvim_set_keymap('v', '<Leader>gf', ':OpenInGHFileLines <CR>', { silent = true, noremap = true })
  end,
}
