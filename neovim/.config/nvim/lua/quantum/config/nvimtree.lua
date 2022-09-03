require("nvim-tree").setup({
    sort_by = "case_sensitive",
    renderer = {
        group_empty = true,
    },
    view = {
        mappings = {
            list = {
                { key = "s", action = "vsplit" },
            }
        }
    }
})
