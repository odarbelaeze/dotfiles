set nocompatible

let mapleader = ","
" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Skip upgrade of oh-my-vim itself during upgrades
" let g:ohmyvim_skip_upgrade=1

" Use :OhMyVim profiles to list all available profiles with a description
" let profiles = ['defaults', 'django', 'erl', 'friendpaste', 'git',
"                 'makefile', 'map', 'pyramid', 'python', 'ranger',
"                 'tmpl', 'utf8']

let profiles = ['defaults', 'python', 'utf8', 'django', 'git', 'makefile']

" Path to oh-my-vim binary (take care of it if you are using a virtualenv)
let g:ohmyvim="/home/oscar/.virtualenvs/ohmyvimenv/bin/oh-my-vim"

" load oh-my-vim
source /home/oscar/.vim/ohmyvim/ohmyvim.vim

" End of oh-my-vim required stuff

" Put your custom stuff bellow

" Paste mode
set pastetoggle=<F2>

set rtp+=/usr/local/lib/python3.4/dist-packages/powerline/bindings/vim/

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
if $COLORTERM == 'gnome-terminal'
  set t_Co=16
endif

syntax enable
set background=dark
let g:solarized_termcolors=16
colorscheme solarized


" Wild ignoring some files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*__pycache__*,*.egg/*
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

" Syntastic c++11 support
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'
let g:syntastic_cpp_include_dirs = ['hdr', 'include', 'inc', '/home/oscar/Projects/gtest-1.7.0/build/include']

" Syntastic Python3 support
let g:syntastic_python_checkers = ['flake8']

" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Python mode preferences
let g:pymode_python = 'python3'
let g:pymode_folding = 0
let g:pymode_run = 0

" Custom stuff that feels right
nnoremap <leader>w :w<CR>
inoremap jj <ESC>
nnoremap <leader>t :! py.test <CR>
nnoremap <leader>r :! python % <CR>
