return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<leader>sf', '<CMD>FzfLua files<CR>', desc = 'Search files' },
    { '<leader>sb', '<CMD>FzfLua buffers<CR>', desc = 'Search buffers' },
    { '<leader>sr', '<CMD>FzfLua live_grep<CR>', desc = 'Search live grep' },
  },
}
