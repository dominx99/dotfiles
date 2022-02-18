let mapleader =","

source $HOME/.config/nvim/plugins/plugins.vim

source $HOME/.config/nvim/base/auto-commands.vim
source $HOME/.config/nvim/base/commands.vim
source $HOME/.config/nvim/base/functions.vim

source $HOME/.config/nvim/plugins/config.vim

source $HOME/.config/nvim/base/settings.vim
source $HOME/.config/nvim/base/mappings.vim

lua require('plugins/neovim/nvim-lspconfig')
lua require('plugins/hrsh7th/nvim-compe')
lua require('plugins/hrsh7th/vim-vsnip')
lua require('plugins/nvim-treesitter/nvim-treesitter')
lua require('plugins/nvim-telescope/telescope')
lua require('plugins/nvim-tree')

source $HOME/.config/nvim/base/colorscheme.vim

autocmd FileType php setlocal iskeyword-=$

lua require('base/custom')
lua require('base/mappings')
lua require('ftplugin')

lua << EOF
vim.lsp.set_log_level("debug")
EOF
