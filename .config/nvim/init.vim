let mapleader = ","

source $HOME/.config/nvim/plugins/plugins.vim

source $HOME/.config/nvim/base/auto-commands.vim
source $HOME/.config/nvim/base/commands.vim
source $HOME/.config/nvim/base/functions.vim

source $HOME/.config/nvim/plugins/config.vim

source $HOME/.config/nvim/base/settings.vim
source $HOME/.config/nvim/base/mappings.vim

lua require('plugins/hrsh7th/nvim-cmp')
lua require('plugins/hrsh7th/vim-vsnip')
lua require('plugins/nvim-treesitter/nvim-treesitter')
lua require('plugins/nvim-telescope/telescope')
lua require('plugins/nvim-tree')
lua require('plugins/numToStr-Comment')
lua require('settings')
lua require('base/mappings')
lua require('plugins/neovim/nvim-lspconfig')

let g:perl_host_prog = '/usr/bin/perl'
