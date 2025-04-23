return {
  'zk-org/zk-nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('zk').setup {
      -- Can be "telescope", "fzf", "fzf_lua", "minipick", "snacks_picker",
      -- or select" (`vim.ui.select`). It's recommended to use "telescope",
      -- "fzf", "fzf_lua", "minipick", or "snacks_picker".
      picker = 'telescope',

      lsp = {
        -- `config` is passed to `vim.lsp.start_client(config)`
        config = {
          cmd = { 'zk', 'lsp' },
          name = 'zk',
          -- on_attach = ...
          -- etc, see `:h vim.lsp.start_client()`
        },

        -- automatically attach buffers in a zk notebook that match the given filetypes
        auto_attach = {
          enabled = true,
          filetypes = { 'markdown' },
        },
      },
    }

    -- Mappings
    vim.keymap.set('n', '<leader>zl', ':ZkInsertLink<CR>', { desc = 'Insert link', noremap = true, silent = false })
  end,
}
