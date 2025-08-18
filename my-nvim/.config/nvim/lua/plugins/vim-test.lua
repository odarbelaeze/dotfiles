return {
  'vim-test/vim-test',
  event = 'VimEnter',
  keys = {
    { '<leader>tn', '<cmd>TestNearest<cr>', desc = 'Test nearest' },
    { '<leader>tf', '<cmd>TestFile<cr>', desc = 'Test file' },
    { '<leader>ts', '<cmd>TestSuite<cr>', desc = 'Test suite' },
    { '<leader>tl', '<cmd>TestLast<cr>', desc = 'Test last' },
  },
  config = function()
    vim.cmd [[
      let test#strategy = "neovim"
      let test#python#pytest#options = {
        \ 'nearest': '--pdb',
      \}
    ]]
  end,
}
