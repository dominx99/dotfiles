vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'vim-utils/vim-man'
  use 'wbthomason/packer.nvim'
  use 'francoiscabrol/ranger.vim'
  use 'Shatur/neovim-ayu'
  use 'wakatime/vim-wakatime'
  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-ui-select.nvim'
  use 'sharkdp/fd'
  use 'tpope/vim-eunuch'
  use 'tpope/vim-fugitive'
  use 'airblade/vim-gitgutter'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'mattn/emmet-vim'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'ntpeters/vim-better-whitespace'
  use 'numToStr/Comment.nvim'
  use 'nelsyeung/twig.vim'
  use {'SergioRibera/vim-screenshot', run = 'npm install --prefix Renderizer'}
  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install'}
  use {'junegunn/fzf.vim'}
  use {'phpactor/phpactor', ft = {'php'}, tag = '*', run = 'composer install --no-dev -o'}
  use 'dense-analysis/ale'
  use {'vim-vdebug/vdebug', branch = 'master' }

  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp-document-symbol'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'petertriho/cmp-git'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
end)
