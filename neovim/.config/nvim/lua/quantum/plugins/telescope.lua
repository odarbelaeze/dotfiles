local finders = require('telescope.builtin')

require('telescope').setup({
    defaults = {
        prompt_prefix = ' 🔍 ',
        initial_mode = 'insert',
        sorting_strategy = 'ascending',
        layout_config = {
            prompt_position = 'top',
        },
    },
})

-- ,f = fuzzy finder
vim.keymap.set('n', '<leader>f', function()
    finders.find_files({
        find_command = { 'rg', '--ignore', '--hidden', '--files' }
    })
end)

