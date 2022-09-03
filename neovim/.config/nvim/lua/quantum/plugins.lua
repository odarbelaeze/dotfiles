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
        use('wbthomason/packer.nvim')
        use('nvim-lua/plenary.nvim')
        use('nvim-lua/popup.nvim')

        -- Colors
        use {
            'folke/tokyonight.nvim',
            config = function ()
                vim.cmd[[colorscheme tokyonight]]
            end
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
        use('ap/vim-css-color')
        use('christoomey/vim-sort-motion')
        use('psliwka/vim-smoothie')
        use('tommcdo/vim-exchange')
        use('tpope/vim-commentary')
        use({
            'tpope/vim-surround',
            event = 'BufRead',
            requires = {
                {
                    'tpope/vim-repeat',
                    event = 'BufRead',
                },
            },
        })

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
            setup = [[require('quantum.setup.telescope')]],
            config = [[require('quantum.config.telescope')]],
            cmd = 'Telescope',
            module = 'telescope',
        }

        -- File tree
        use {
            'kyazdani42/nvim-tree.lua',
            requires = {
                'kyazdani42/nvim-web-devicons', -- optional, for file icons
            },
            config = [[require('quantum.config.nvimtree')]],
            setup = [[require('quantum.setup.nvimtree')]],
            -- tag = 'nightly' -- optional, updated every week. (see issue #1193)
        }

        -- The code
        use {
            'nvim-treesitter/nvim-treesitter',
            config = [[require('quantum.config.treesitter')]],
        }

        -- More text objects
        -- use {
        --     ''
        -- }
        use {
            'kana/vim-textobj-user',
            {
                'kana/vim-textobj-indent',
                requires = {
                    'kana/vim-textobj-user',
                },
                wants = {
                    'vim-textobj-user',
                },
            },
            {
                'kana/vim-textobj-line',
                requires = {
                    'kana/vim-textobj-user',
                },
                wants = {
                    'vim-textobj-user',
                },
            }
        }

        -- The lsp stuffs
        use {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            {
                'neovim/nvim-lspconfig',
                config = function ()
                    print('lsps loaded')
                    require('mason-lspconfig').setup({
                        ensure_installed = {
                            'sumneko_lua',
                            'rust_analyzer',
                            'pyright',
                            'tsserver'
                        }
                    })
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
