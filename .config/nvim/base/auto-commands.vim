augroup init
    autocmd!
    autocmd FocusLost * silent! :wa | echo "Files saved!"
    autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
    autocmd BufWritePost $MYVIMRC so $MYVIMRC | filetype plugin indent on
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    autocmd  FileType fzf set laststatus=0 noshowmode noruler | autocmd BufLeave <buffer> set laststatus=2 showmode ruler
    autocmd BufWinEnter,WinEnter term://* startinsert
augroup END

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Automatically deletes all trailing whitespace on save.
"autocmd BufWritePre * %s/\s\+$//e
" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

