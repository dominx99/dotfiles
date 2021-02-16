let mapleader =","

source $HOME/.config/nvim/plugins/plugins.vim

lua require('base/functions')

source $HOME/.config/nvim/base/auto-commands.vim
source $HOME/.config/nvim/base/commands.vim
source $HOME/.config/nvim/base/functions.vim

source $HOME/.config/nvim/plugins/config.vim

source $HOME/.config/nvim/base/settings.vim
source $HOME/.config/nvim/base/colorscheme.vim
source $HOME/.config/nvim/base/mappings.vim

lua require('plugins/neovim/nvim-lspconfig')
lua require('plugins/hrsh7th/nvim-compe')
lua require('plugins/hrsh7th/vim-vsnip')
lua require('plugins/nvim-treesitter/nvim-treesitter')
lua require('plugins/nvim-telescope/telescope')

autocmd FileType php setlocal iskeyword-=$

