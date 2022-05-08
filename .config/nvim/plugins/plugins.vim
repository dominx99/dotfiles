if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif

call plug#begin('~/.vim-plugged')
    Plug 'Shatur/neovim-ayu'

    " Plug 'vim-vdebug/vdebug' "Support for XDebug
    Plug 'dense-analysis/ale' " Asynchronous Lint Engine
    Plug 'SergioRibera/vim-screenshot', { 'do': 'npm install --prefix Renderizer' }

    Plug 'wakatime/vim-wakatime'

    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'kyazdani42/nvim-tree.lua'

    Plug 'phpactor/phpactor', {'for': 'php', 'tag': '*', 'do': 'composer install --no-dev -o'}

    Plug 'neovim/nvim-lspconfig',

    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/cmp-nvim-lua'
    Plug 'hrsh7th/cmp-nvim-lsp-document-symbol'
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'
    Plug 'hrsh7th/cmp-nvim-lsp-signature-help'

    Plug 'petertriho/cmp-git'

    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    " Plug 'nvim-treesitter/completion-treesitter'

    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'

    Plug 'nvim-telescope/telescope.nvim'
    Plug 'sharkdp/fd'

    Plug 'tpope/vim-eunuch'
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'mattn/emmet-vim'

    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    Plug 'lukas-reineke/indent-blankline.nvim'

    Plug 'ntpeters/vim-better-whitespace'
    Plug 'numToStr/Comment.nvim'
    Plug 'nelsyeung/twig.vim'
call plug#end()

function! PlugLoaded(name)
    return (
        \ has_key(g:plugs, a:name) &&
        \ isdirectory(g:plugs[a:name].dir) &&
        \ stridx(&rtp, g:plugs[a:name].dir) >= 0)
endfunction
