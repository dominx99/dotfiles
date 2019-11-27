if exists('g:loaded_phpbooster')
    finish
endif

let g:loaded_phpbooster = 1

function! s:RequirePhpbooster(host) abort
    return jobstart(['phpbooster'], {'rpc': v:true})
endfunction

call remote#host#Register('phpbooster', 'x', function('s:RequirePhpbooster'))
call remote#host#RegisterPlugin('phpbooster', '0', [
    \ {'type': 'function', 'name': 'PHPInsertDocblock', 'sync': 1, 'opts': {}},
    \ {'type': 'function', 'name': 'PHPInsertProperty', 'sync': 1, 'opts': {}},
    \ {'type': 'function', 'name': 'PHPInsertMethod', 'sync': 1, 'opts': {}}
    \ ])

function! PhpboosterCopySelectedText(command)
    execute 'normal! ' . a:command . '"*y'
    return @*
endfunction

nnoremap <space>d :call PHPInsertDocblock()<CR>
nnoremap <F10> :call PHPInsertProperty()<CR>
nnoremap <F11> :call PHPInsertMethod()<CR>

" vim:ts=4:sw=4:et
