filetype plugin on
syntax on
set nocompatible
set encoding=utf-8
set number
set wildmode=longest,list,full
set termguicolors
set background=dark
set go=a
set mouse=a
set confirm
set hidden
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set ignorecase
set smartcase
set autoindent
set ai
set smartindent
set nohlsearch
set clipboard=unnamedplus
set splitbelow
set splitright
set tags=tags,.git/tags
set noswapfile
set nobackup
set nowritebackup
set undofile
set undodir=$HOME/.vim-history
set shortmess+=c
set belloff+=ctrlg
set completeopt=menuone,noselect,noinsert
set signcolumn=yes
set nofoldenable
set winblend=3
"coc.nvim
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

filetype plugin indent on
