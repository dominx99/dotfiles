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
lua require('ftplugin')

let g:vim_php_refactoring_auto_validate_sg = 1
let g:vim_php_refactoring_auto_validate_g = 1

let g:nvim_tree_quit_on_open = 1

lua << EOF
vim.lsp.set_log_level("debug")
EOF
