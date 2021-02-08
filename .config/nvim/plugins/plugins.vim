if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif

call plug#begin('~/.vim-plugged')
    Plug 'neovim/nvim-lspconfig',
    Plug 'hrsh7th/nvim-compe'
   " Plug 'nvim-lua/completion-nvim' " Propably slower than hrsh7th/nvim-compe
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/completion-treesitter'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'

    " Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } } " Browser input nvim

    " Old plugins
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'

    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'godlygeek/tabular'
    Plug 'Yggdroot/indentLine'
    Plug 'itchyny/lightline.vim'
    Plug 'ntpeters/vim-better-whitespace'
	Plug 'tpope/vim-commentary'
    Plug 'daviesjamie/vim-base16-lightline'
    Plug 'nelsyeung/twig.vim'
    Plug 'rafi/awesome-vim-colorschemes'
call plug#end()

function! PlugLoaded(name)
    return (
        \ has_key(g:plugs, a:name) &&
        \ isdirectory(g:plugs[a:name].dir) &&
        \ stridx(&rtp, g:plugs[a:name].dir) >= 0)
endfunction
