-- Automatically install packer if not installed
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
end

-- Automatically run :PackerCompile whenever plugins.lua is updated with an autocommand:
vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('PACKER', { clear = true }),
    pattern = 'plugins.lua',
    command = 'source <afile> | PackerCompile',
})

return require('packer').startup({
    function(use)
        -- Essentials
        use 'wbthomason/packer.nvim'
        use 'nvim-lua/plenary.nvim'
        use 'nvim-lua/popup.nvim'

        -- Colors
        use {
            'folke/tokyonight.nvim',
            config = function ()
                vim.cmd[[colorscheme tokyonight]]
            end,
        }
        use {
            'nvim-lualine/lualine.nvim',
            requires = { 'kyazdani42/nvim-web-devicons', opt = true },
            config = function ()
                require('lualine').setup {
                    options = {
                        component_separators = { left = '', right = ''},
                        section_separators = { left = '', right = ''},
                        theme = 'tokyonight'
                    }
                }
            end
        }


        -- Goodies
        use {
            'ap/vim-css-color',
            'christoomey/vim-sort-motion',
            'psliwka/vim-smoothie',
            'tommcdo/vim-exchange',
            'tpope/vim-commentary'
        }

        -- Surround
        use {
            'tpope/vim-surround',
            event = 'BufRead',
            requires = {
                {
                    'tpope/vim-repeat',
                    event = 'BufRead',
                },
            },
        }

        -- Telescope
        use {
            'nvim-telescope/telescope.nvim',
            requires = {
                'nvim-lua/popup.nvim',
                'nvim-lua/plenary.nvim',
            },
            wants = {
                'popup.nvim',
                'plenary.nvim',
            },
            setup = function ()
                local silent = { silent = true, noremap = true }
                vim.keymap.set('n', '<leader>f', [[<cmd>Telescope find_files<cr>]], silent)
                vim.keymap.set('n', '<leader>b', [[<cmd>Telescope buffers<cr>]], silent)
                vim.keymap.set('n', '<leader>r', [[<cmd>Telescope live_grep<cr>]], silent)
            end,
            config = function ()
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
            end,
            cmd = 'Telescope',
            module = 'telescope',
        }

        -- File tree
        use {
            'kyazdani42/nvim-tree.lua',
            requires = {
                'kyazdani42/nvim-web-devicons', -- optional, for file icons
            },
            config = function ()
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
                local silent = { silent = true, noremap = true }
                vim.keymap.set('n', '<leader>nt', [[<cmd>NvimTreeFindFileToggle<cr>]], silent)
            end,
        }

        -- The code
        use {
            'nvim-treesitter/nvim-treesitter',
            config = function ()
                require('nvim-treesitter.configs').setup {
                    auto_install = true,
                    ensure_installed = {
                        "rust",
                        "python",
                        "css",
                        "typescript",
                        "json",
                    },
                    highlight = { enable = true },
                    indent = { enable = true },
                }
            end,
            run = function()
                require('nvim-treesitter.install').update({ with_sync = true })
            end,
        }

        -- More text objects
        use {
            'kana/vim-textobj-user',
            {
                'kana/vim-textobj-indent',
                after = 'vim-textobj-user',
            },
            {
                'kana/vim-textobj-line',
                after = 'vim-textobj-user',
            },
        }

        -- The lsp stuffs
        use {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            {
                'neovim/nvim-lspconfig',
                after = { 'mason.nvim', 'mason-lspconfig.nvim' },
                config = function ()
                    print('lsps loading')

                    -- Get the autoinstaller going
                    require('mason').setup({})

                    -- Get the lspconfig connected to mason
                    require('mason-lspconfig').setup({
                        ensure_installed = {
                            'sumneko_lua',
                            'rust_analyzer',
                            'pyright',
                            'tsserver'
                        }
                    })

                    -- Mappings.
                    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
                    local opts = { noremap = true, silent = true }
                    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
                    vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, opts)
                    vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, opts)
                    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

                    -- Use an on_attach function to only map the following keys
                    -- after the language server attaches to the current buffer
                    local on_attach = function(_, bufnr)
                        -- Mappings.
                        -- See `:help vim.lsp.*` for documentation on any of the below functions
                        local bufopts = { noremap = true, silent = true, buffer = bufnr }
                        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
                        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
                        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
                        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
                        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
                        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
                        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
                        vim.keymap.set('n', '<leader>wl', function()
                            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                        end, bufopts)
                        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
                        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
                        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
                        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
                        -- vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)
                    end

                    local lsp_flags = {
                        -- This is the default in Nvim 0.7+
                        debounce_text_changes = 150,
                    }

                    require('lspconfig')['sumneko_lua'].setup({
                        on_attach = on_attach,
                        flags = lsp_flags,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { 'vim', 'awesome' }
                                },
                            }
                        }
                    })
                    require('lspconfig')['pyright'].setup({
                        on_attach = on_attach,
                        flags = lsp_flags,
                    })
                    require('lspconfig')['tsserver'].setup({
                        on_attach = on_attach,
                        flags = lsp_flags,
                    })
                    require('lspconfig')['rust_analyzer'].setup({
                        on_attach = on_attach,
                        flags = lsp_flags,
                    })
                    require('lspconfig')['astro'].setup({
                        on_attach = on_attach,
                        flags = lsp_flags,
                    })

                    -- this is for diagnositcs signs on the line number column
                    -- use this to beautify the plain E W signs to more fun ones
                    -- !important nerdfonts needs to be setup for this to work in your terminal
                    local signs = { Error = "", Warn = "", Hint = "", Info = "" }
                    for type, icon in pairs(signs) do
                        local hl = "DiagnosticSign" .. type
                        vim.fn.sign_define(hl, { text = icon, texthl= hl, numhl = hl })
                    end
                end
            }
        }

        -- Automatically set up your configuration after cloning packer.nvim
        -- Put this at the end after all plugins
        if packer_bootstrap then
            require('packer').sync()
        end
    end,
})
