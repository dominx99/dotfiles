augroup init
    autocmd!
    autocmd FocusLost * silent! :wa | echo "Files saved!"
    autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
    autocmd BufWritePost ~/.config/nvim/*.{vim,lua} so $MYVIMRC | filetype plugin indent on
    autocmd FileType fzf set laststatus=0 noshowmode noruler | autocmd BufLeave <buffer> set laststatus=2 showmode ruler
    autocmd BufWinEnter,WinEnter term://* startinsert
    autocmd BufEnter * set autoindent
augroup END

augroup packer_user_config
  autocmd!
  autocmd BufWritePost ~/.config/nvim/lua/plugins/init.lua so $MYVIMRC | PackerCompile
augroup end

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
