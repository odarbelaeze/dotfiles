" General settings

set expandtab
set shiftwidth=4
set tabstop=4
set hidden " let's just try this one
set signcolumn=yes:2
set relativenumber
set number
set termguicolors
set undofile
set spell
set title
set smartcase
set wildmode=longest:full,full
set nowrap
set list
set listchars=tab:▸\ ,trail:·
set mouse=a
set scrolloff=8
set sidescrolloff=8
set nojoinspaces
set splitright
set confirm
set exrc
set backup
set backupdir=~/.local/share/nvim/backup/
set updatetime=300 "reduce time for highlighting other references
set redrawtime=10000 "allow more time for loading syntax on large files

" Key maps

let mapleader = ","
nmap <leader>ev :edit ~/.config/nvim/init.vim<cr>
nmap <leader>ec :edit ~/.config/nvim/coc-setings.json<cr>
nmap <leader>sv :source ~/.config/nvim/init.vim<cr>

nmap <leader>k :nohlsearch<cr>
nmap <leader>Q :bufdo bdelete<cr>
map gf :edit <cfile><cr>

nmap <silent> <C-h> <C-w>h
nmap <silent> <C-j> <C-w>j
nmap <silent> <C-k> <C-w>k
nmap <silent> <C-l> <C-w>l

vnoremap y myy`y
vnoremap Y myy`Y
nnoremap Y y$
nnoremap <leader>p "+p
nnoremap <leader>y "+y

nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

imap jj <esc>
imap kk <esc>

imap ;; <esc>A;<esc>
imap ,, <esc>A,<esc>
cmap w!! %!sudo tee > /dev/null %

nmap <leader>w :w<cr>
nmap <leader>x :x<cr>

" Plugins

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(data_dir . '/plugins')

source ~/.config/nvim/plugins/nerdtree.vim
source ~/.config/nvim/plugins/lightline.vim
source ~/.config/nvim/plugins/fzf.vim
source ~/.config/nvim/plugins/coc.vim
source ~/.config/nvim/plugins/text-objects.vim
source ~/.config/nvim/plugins/goodies.vim
source ~/.config/nvim/plugins/fugitive.vim
source ~/.config/nvim/plugins/editorconfig.vim
source ~/.config/nvim/plugins/polyglot.vim
source ~/.config/nvim/plugins/vim-test.vim
source ~/.config/nvim/plugins/floaterm.vim
source ~/.config/nvim/plugins/dracula.vim

call plug#end()

doautocmd User PlugLoaded " Allow plugin files to hook up to after plug is loaded

" Miscellaneous

augroup FileTypeOverrides
    autocmd!
    autocmd TermOpen * setlocal nospell
augroup END
