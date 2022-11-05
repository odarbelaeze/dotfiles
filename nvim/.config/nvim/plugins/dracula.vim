" Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

" augroup DraculaOverrides
"     autocmd!
"     autocmd ColorScheme dracula highlight DraculaBoundary guibg=none
"     autocmd ColorScheme dracula highlight DraculaDiffDelete ctermbg=none guibg=none
"     autocmd ColorScheme dracula highlight DraculaComment cterm=italic gui=italic
"     autocmd ColorScheme dracula highlight DraculaWinSeparator guibg=none ctermbg=none
"     autocmd User PlugLoaded ++nested colorscheme dracula
" augroup end

autocmd User PlugLoaded ++nested colorscheme tokyonight-storm
