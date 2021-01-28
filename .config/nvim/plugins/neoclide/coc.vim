if PlugLoaded('coc.nvim')
    let g:coc_global_extensions = [
            \'coc-snippets',
            \'coc-pairs',
            \'coc-json',
            \'coc-yaml',
            \'coc-html',
            \'coc-lists',
            \'coc-tsserver',
            \'coc-vetur',
            \'coc-git',
            \'coc-docker',
            \'coc-vimlsp',
            \]
endif

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:format_qf_diags(item) abort
  let l:parsed = s:parse_error(a:item)
  return {'bufnr' : bufnr(l:parsed['bufnr']), 'lnum' : l:parsed['linenr'], 'col': l:parsed['colnr'], 'text' : l:parsed['text']}
endfunction

function! s:build_quickfix_list(lines)
  call setqflist(map(a:lines, 's:format_qf_diags(v:val)'),'r', "Diagnostics")
endfunc

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

function! s:error_handler(err) abort
   
  let l:Cmd = s:action_for(a:err[0])

  if !empty(l:Cmd) && type(l:Cmd) == s:TYPE.string && stridx('edit', l:Cmd) < 0
    execute 'silent' l:Cmd
  elseif !empty(l:Cmd) && type(l:Cmd) == s:TYPE.funcref
    call l:Cmd(a:err[1:])
    return
  endif
  let l:parsed = s:parse_error(a:err[1:])
  execute 'buffer' bufnr(l:parsed["bufnr"])
  mark '
  call cursor(l:parsed["linenr"], l:parsed["colnr"])
  normal! zvzz

endfunction

function! s:parse_error(err) abort
  let l:match = matchlist(a:err, '\v^([^|]*)\|(\d+)?%(\scol\s(\d+))?.*\|(.*)')[1:4]
  if empty(l:match) || empty(l:match[0])
    return
  endif

  if empty(l:match[1]) && (bufnr(l:match[0]) == bufnr('%'))
    return
  endif

  let l:line_number = empty(l:match[1]) ? 1 : str2nr(l:match[1])
  let l:col_number = empty(l:match[2]) ? 1 : str2nr(l:match[2])
  let l:error_msg = l:match[3]

  return ({'bufnr' : l:match[0],'linenr' : l:line_number, 'colnr':l:col_number, 'text': l:error_msg})
endfunction

let s:TYPE = {'dict': type({}), 'funcref': type(function('call')), 'string': type(''), 'list': type([])}

let s:default_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

function! s:action_for(key, ...)
  let default = a:0 ? a:1 : ''
  if a:key == 'ctrl-q'
    let l:Cmd = function('s:build_quickfix_list')
  else
    let l:Cmd = get(get(g:, 'fzf_action', s:default_action), a:key, default)
  endif
  return l:Cmd
endfunction

function! s:syntax() abort
  if has('syntax') && exists('g:syntax_on')
    syntax match FzfQuickFixFileName '^[^|]*' nextgroup=FzfQuickFixSeparator
    syntax match FzfQuickFixSeparator '|' nextgroup=FzfQuickFixLineNumber contained
    syntax match FzfQuickFixLineNumber '[^|]*' contained contains=FzfQuickFixError
    syntax match FzfQuickFixError 'error' contained

    highlight default link FzfQuickFixFileName Directory
    highlight default link FzfQuickFixLineNumber LineNr
    highlight default link FzfQuickFixError Error
  endif
endfunction

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <M-r>  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <M-R>  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

function! s:format_coc_diagnostic(item) abort
  return (has_key(a:item,'file')  ? bufname(a:item.file) : '')
        \ . '|' . (a:item.lnum  ? a:item.lnum : '')
        \ . (a:item.col ? ' col ' . a:item.col : '')
        \ . '| ' . a:item.severity
        \ . ': ' . a:item.message 
endfunction

function! s:get_current_diagnostics() abort
  " Remove entries not belonging to the current file.
  let l:diags = filter(copy(CocAction('diagnosticList')), {key, val -> val.file ==# expand('%:p')})
  return map(l:diags, 's:format_coc_diagnostic(v:val)')
endfunction

function! GetFzfDiags() abort
  let l:diags = CocAction('diagnosticList')
  if !empty(l:diags)
    let expect_keys = join(keys(get(g:, 'fzf_action', s:default_action)), ',')
    let l:opts = {
          \ 'source': s:get_current_diagnostics(),
          \ 'sink*': function('s:error_handler'),
          \ 'options': ['--multi','--expect=ctrl-q,'.expect_keys,'--ansi', '--prompt=Coc Diagnostics> '],
          \ }
    call fzf#run(fzf#wrap(l:opts))
    call s:syntax()
  endif
endfunction

nmap <leader>rn <Plug>(coc-rename)

xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

command! -nargs=0 Prettier :CocCommand prettier.formatFile

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
