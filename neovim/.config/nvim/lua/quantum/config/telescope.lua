require('telescope').setup({
    defaults = {
        prompt_prefix = ' > ',
        initial_mode = 'insert',
        sorting_strategy = 'ascending',
        layout_config = {
            prompt_position = 'top',
        },
        theme = 'dropdown',
    },
})
