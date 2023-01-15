set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=2               " number of columns occupied by a tab 
set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=2            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set relativenumber
set wildmode=longest,list   " get bash-like tab completions
set cc=80                  " set an 80 column border for good coding style
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
" set spell                 " enable spell check (may need to download language package)
" set noswapfile            " disable creating swap file
" set backupdir=~/.cache/vim " Directory to store backup files
set rtp+=/opt/homebrew/opt/fzf
set noswapfile
" copies filepath to clipboard by pressing yf
:nnoremap <silent> yf :let @+=expand('%:p')<CR>
" copies pwd to clipboard by pressing yd
:nnoremap <silent> yf :let @+=expand('%:p:h')<CR>
"vim jump to last position when reopening a file

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif
endif
" fzf remaps
nnoremap <silent> <C-p> :Files<cr>
nnoremap <silent> <C-f> :Rg<cr>
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_action = {
      \ 'ctrl-t': 'tab-split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \}

call plug#begin()
" Plugin Section
  Plug 'dracula/vim'
  Plug 'ryanoasis/vim-devicons'
  Plug 'mileszs/ack.vim'
  Plug 'EdenEast/nightfox.nvim'
  Plug 'windwp/nvim-autopairs'
"  Plug 'SirVer/ultisnips'
"  Plug 'honza/vim-snippets'
" Plug 'scrooloose/nerdtree'
" Plug 'preservim/nerdcommenter'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'mhinz/vim-startify'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()
lua << EOF
require("nvim-autopairs").setup {}
EOF
" color schemes
if (has("termguicolors"))
 set termguicolors
endif
syntax enable
" colorscheme evening
colorscheme nordfox
