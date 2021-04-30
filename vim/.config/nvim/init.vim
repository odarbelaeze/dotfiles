set nocompatible

runtime vimrc

let g:python_host_prog  = '~/.venvs/nvim-py2/bin/python'
let g:python3_host_prog  = '~/.venvs/nvim-py3/bin/python'

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/bundle')

Plug 'ap/vim-css-color'
Plug 'bronson/vim-trailing-whitespace'
Plug 'christoomey/vim-sort-motion'
Plug 'itchyny/lightline.vim'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-user'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'sheerun/vim-polyglot'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } | Plug 'junegunn/fzf.vim'

call plug#end()

" Settings

syntax enable
set ttyfast
set mouse=a
set nowrap
set number
set backupcopy=yes
set noshowmode
set fillchars+=vert:\ 
highlight LineNr ctermbg=8
highlight VertSplit ctermbg=8 cterm=NONE

" Mappgings

let mapleader=','

nnoremap <leader>w :w <CR>
nnoremap <leader>x :x <CR>
nnoremap <leader>nh :nohlsearch <CR>
nnoremap <leader>nu :set invnumber <CR>
nnoremap <leader>nt :NERDTreeToggle <CR>
nnoremap <leader>pd :read! date +'\%y-\%m-\%d' <CR>
nnoremap Y y$
vnoremap <leader>y "+y
nnoremap <leader>y "+y
nnoremap <leader>p "+p

inoremap jj <ESC>
inoremap kk <ESC>
inoremap jk <ESC>

nnoremap <leader>ev :e ~/.config/nvim/init.vim <CR>
nnoremap <leader>sv :so ~/.config/nvim/init.vim <CR>

nnoremap <C-p> :GFiles<CR>
nnoremap <C-t> :Rg<CR>
nnoremap <silent> <leader>rg :Rg <C-R><C-W><CR>
nnoremap <silent> <leader>gd :call CocAction('jumpDefinition')<CR>
nnoremap <silent> <leader>gr :call CocAction('jumpReferences')<CR>
nnoremap <silent> <leader>dn :call CocAction('diagnosticNext')<CR>

" Wild stuff
set suffixes+=.a,.o,.pyc
set wildignore+=*.o,*.a,*.so,*.pyc,.git,.git/*
set wildignore+=node_modules,node_modules/*
set wildignore+=__pycache__,__pycache__/*
set wildignore+=.idea,.idea/*
set wildignore+=.vscode,.vscode/*

" NERDTree
let NERDTreeQuitOnOpen=1
let NERDTreeAutoDeleteBuffer=1
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
let NERDTreeMapOpenInTab='\t'
let NERDTreeShowHidden=1
let NERDTreeRespectWildIgnore=1

" coc extensions
let g:coc_global_extensions = ['coc-json', 'coc-pyright', 'coc-tsserver', 'coc-prettier', 'coc-go', 'coc-lua', 'coc-rls']
hi! CocErrorSign guifg=#4C0593

" Ligthline
let g:lightline = { 'colorscheme': 'seoul256', 'active': { 'left': [['mode', 'paste'], ['readonly', 'relativepath', 'modified']], },  }
