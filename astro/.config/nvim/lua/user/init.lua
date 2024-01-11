--              AstroNvim Configuration Table
-- All configuration changes should go inside of the table below

-- You can think of a Lua "table" as a dictionary like data structure the
-- normal format is "key = value". These also handle array like data structures
-- where a value with no key simply has an implicit numeric key
local config = {
        -- set vim options here (vim.<first_key>.<second_key> =  value)
        options = {
                opt = {
                        -- set to true or false etc.
                        relativenumber = false, -- sets vim.opt.relativenumber
                        number = true, -- sets vim.opt.number
                        signcolumn = "yes", -- sets vim.opt.signcolumn to auto
                        showtabline = 0,
                },
                g = {
                        mapleader = ",", -- sets vim.g.mapleader
                },
        },

        -- Increase lsp timeout
        lsp = {
                formatting = {
                        timeout_ms = 5000,
                }
        },

        -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
        diagnostics = {
                virtual_text = true,
                underline = true,
        },

        -- Mapping data with "desc" stored directly by vim.keymap.set().
        --
        -- Please use this mappings table to set keyboard mapping since this is the
        -- lower level configuration and more robust one. (which-key will
        -- automatically pick-up stored data by this setting.)
        mappings = {
                [""] = {
                        ["<Space>"] = false
                },
                -- first key is the mode
                n = {
                        ["<leader>x"] = { "<cmd>x<cr>", desc = "Save and Quit" },
                        ["<leader>tn"] = { "<cmd>TestNearest<cr>", desc = "Test nearest" },
                        ["<leader>tl"] = { "<cmd>TestLast<cr>", desc = "Test last" },
                        ["<leader>tf"] = { "<cmd>TestFile<cr>", desc = "Test file" },
                        ["<leader>ts"] = { "<cmd>TestSuite<cr>", desc = "Test suite" },
                        ["<leader>tv"] = { "<cmd>TestVisit<cr>", desc = "Visit test" },
                },
        },

        -- Configure plugins
        plugins = {
                {"akinsho/toggleterm.nvim", enabled = false},
                {"Shatur/neovim-session-manager", enabled = false},
                {"tpope/vim-surround", event = "BufRead"},
                {"tpope/vim-fugitive", event = "BufRead"},
                {"tpope/vim-rhubarb", event = "BufRead"},
                {"tpope/vim-repeat", event = "BufRead"},
                {"christoomey/vim-sort-motion", event = "BufRead"},
                {
                        "vim-test/vim-test",
                        event = "BufRead",
                        config = function() 
                                vim.g["test#python#pytest#options"] = "--disable-warnings --pdb"
                        end,
                        
                },
                "AstroNvim/astrocommunity",
                {
                        import = "astrocommunity.completion.copilot-lua-cmp",
                }

        },

        -- CMP Source Priorities
        -- modify here the priorities of default cmp sources
        -- higher value == higher priority
        -- The value can also be set to a boolean for disabling default sources:
        -- false == disabled
        -- true == 1000
        cmp = {
                source_priority = {
                        nvim_lsp = 1000,
                        luasnip = 750,
                        buffer = 500,
                        path = 250,
                },
        },

        -- Modify which-key registration (Use this with mappings table in the above.)
        ["which-key"] = {
                -- Add bindings which show up as group name
                register = {
                        -- first key is the mode, n == normal mode
                        n = {
                                -- second key is the prefix, <leader> prefixes
                                ["<leader>"] = {
                                        -- third key is the key to bring up next level and its displayed
                                        -- group name in which-key top level menu
                                        ["t"] = { name = "Test" },
                                },
                        },
                },
        },

        -- This function is run last and is a good place to configuring
        -- augroups/autocommands and custom filetypes also this just pure lua so
        -- anything that doesn't fit in the normal config locations above can go here
        polish = function()
                vim.filetype.add {
                        extension = {
                                astro = "astro",
                                mdx = "markdown",
                        },
                }
        end,
}

return config
