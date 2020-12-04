let mapleader =","

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif

call plug#begin('~/.vim-plugged')
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
	Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'godlygeek/tabular'
    Plug 'Yggdroot/indentLine'
    Plug 'itchyny/lightline.vim'
    Plug 'ntpeters/vim-better-whitespace'
	Plug 'tpope/vim-commentary'
    Plug 'posva/vim-vue'
    Plug 'dterei/VimCobaltColourScheme'
    Plug 'pangloss/vim-javascript'
    Plug 'mxw/vim-jsx'
    Plug 'chriskempson/base16-vim'
    Plug 'daviesjamie/vim-base16-lightline'
    Plug 'dart-lang/dart-vim-plugin'
    Plug 'natebosch/vim-lsc'
    Plug 'natebosch/vim-lsc-dart'
    Plug 'nelsyeung/twig.vim'

    Plug '~/.config/nvim/dev/phpbooster'
    Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh',
        \ }

    Plug 'rafi/awesome-vim-colorschemes'
call plug#end()

function! PlugLoaded(name)
    return (
        \ has_key(g:plugs, a:name) &&
        \ isdirectory(g:plugs[a:name].dir) &&
        \ stridx(&rtp, g:plugs[a:name].dir) >= 0)
endfunction

augroup init
    autocmd!
    autocmd FocusLost * silent! :wa | echo "Files saved!"
    autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
    autocmd BufWritePost $MYVIMRC so $MYVIMRC | filetype plugin indent on
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    autocmd  FileType fzf set laststatus=0 noshowmode noruler | autocmd BufLeave <buffer> set laststatus=2 showmode ruler
    autocmd BufWinEnter,WinEnter term://* startinsert
augroup END

command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!'
command! NvimSettings silent! execute "vsp $MYVIMRC"
command! GoSettings silent! execute "vsp $HOME/.config/nvim/ftplugin/go.vim"
command! PhpSettings silent! execute "vsp $HOME/.config/nvim/ftplugin/php.vim"
command! CppSettings silent! execute "vsp $HOME/.config/nvim/ftplugin/cpp.vim"
command! JavascriptSettings silent! execute "vsp $HOME/.config/nvim/ftplugin/javascript.vim"
command! ReloadNvim silent! execute "so $MYVIMRC" | echo "Nvim reloded"
command! -nargs=1 JumpToTag call JumpToTag(<f-args>, ['f', 'function', 'c', 'class', 'i', 'interface', 't', 'trait'])
command! FocusOnFile silent! NERDTreeFind
command! DeleteCurrentFile call delete(expand('%')) | bdelete!
" command! -nargs=0 OrganizeImport
" 		\ :call CocActionAsync('runCommand', 'tsserver.organizeImports')

" let g:fzf_action = { 'enter': 'tabedit' }

let g:indentLine_char = '¦'
let g:indentLine_color_gui = '#585D78'
let g:indentLine_first_char = '¦'
let g:indentLine_showFirstIndentLevel = 0

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

let g:nerdtree_tabs_autoclose = 0
let g:NERDTreeShowIgnoredStatus = 1
let g:NERDTreeQuitOnOpen = 1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | w | endif

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

nnoremap c "_c
set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
set number relativenumber
set wildmode=longest,list,full
set termguicolors
set background=dark
try
    " colorscheme 256_noir " total black
    " colorscheme onedark " generally nice scheme
    " colorscheme gruvbox " retro but looks very good
    " colorscheme base16-google-dark " very good contrast, one of the best
     colorscheme ayu " very nice dark scheme
    " colorscheme challenger_deep " space (violet) colors
catch
endtry
set go=a
set mouse=a
set confirm
set hidden
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set ignorecase
set smartcase
set autoindent
set smartindent
set nohlsearch
set clipboard=unnamedplus
set splitbelow
set splitright
set tags=tags,.git/tags
set noswapfile
set nobackup
set nowritebackup
set undofile
set undodir=$HOME/.vim-history
set shortmess+=c
set belloff+=ctrlg
set completeopt=menuone,noselect,noinsert
set signcolumn=yes
set nofoldenable

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
      \ 'colorscheme': 'base16',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ],
      \    'right':[
          \     [ 'blame', 'gitbranch', 'filetype', 'fileencoding', 'lineinfo', 'percent' ]
          \   ],
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction',
      \   'blame': 'LightlineGitBlame'
      \ },
      \ }

function! LightlineGitBlame() abort
  let blame = get(b:, 'coc_git_blame', '')
  " return blame
  return winwidth(0) > 120 ? blame : ''
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

map <F7> :setlocal spell! spelllang=en_us<CR>
map <F8> :setlocal spell! spelllang=pl<CR>
map ; :
map j gj
map k gk
imap jj <Esc>
inoremap <M-w> <Esc>:bd<CR>
nnoremap <M-w> :bd<CR>
inoremap <M-s> <Esc>:w<CR>
nnoremap <M-s> :w<CR>
map <silent> <expr> <M-p> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
map <M-o> :GFiles<CR>
nmap <silent> <Space><Space> :noh<CR>
map <M-e> :Buffers<CR>
" nnoremap <Tab> :tabnext<CR>
" nnoremap <S-Tab> :tabprevious<CR>

inoremap " ""<left>
inoremap ' ''<left>
inoremap ` ``<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Nerd tree
map <M-b> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" resize
map <silent> <M-=> :vertical resize +5<CR>
map <silent> <M--> :vertical resize -5<CR>

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" Copy selected text to system clipboard (requires gvim/nvim/vim-x11 installed):
vnoremap <C-c> "+y
map <C-p> "+P

" Align arrays
vnoremap <leader>a :Tabularize /=<CR>
vnoremap <space>a :Tabularize /=><CR>

nnoremap q' viw<Esc>`>a'<Esc>`<i'<Esc>
vnoremap q' <Esc>`>a'<Esc>`<i'<Esc>
nnoremap q" viw<Esc>`>a"<Esc>`<i"<Esc>
vnoremap q" <Esc>`>a"<Esc>`<i"<Esc>
nnoremap qd vaW<esc>:call StripWrap()<cr>
vnoremap qd <esc>:call StripWrap()<cr>
" nnoremap q" ciw""<Esc>P
" nnoremap q' ciw''<Esc>P
" nnoremap qd daW"=substitute(@@,"'\\\|\"","","g")<CR>P

function! StripWrap()
  normal `>x`<x
endfunction
" Automatically deletes all trailing whitespace on save.
"autocmd BufWritePre * %s/\s\+$//e
" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

function! FindTags(name, kinds)
  let tag_list = []

  for entry in taglist(a:name)
    if index(a:kinds, entry.kind) > -1
      call add(tag_list, entry)
    endif
  endfor

  return tag_list
endfunction

nnoremap <C-]> <Esc>:JumpToTag <C-r>=expand("<cword>")<CR><CR>
inoremap <C-T> <Esc>:JumpToTag<Space>
nnoremap <C-T> :JumpToTag<Space>
function! JumpToTag(name, kinds)
    let qflist = []
    for entry in FindTags(a:name, a:kinds)
        let filename = entry.filename
        let pattern  = substitute(entry.cmd, '^/\(.*\)/$', '\1', '')

        call add(qflist, {'filename': filename, 'pattern':  pattern})
    endfor

  if len(qflist) == 0
    echohl Error | echo "No tags found" | echohl NONE
  elseif len(qflist) == 1
    call setqflist(qflist)
    silent cfirst
  else
    call setqflist(qflist)
    copen
  endif
endfunction

nmap gs <Plug>(GitGutterPreviewHunk)
nmap gn <Plug>(GitGutterNextHunk)
nmap gp <Plug>(GitGutterPrevHunk)
nmap gu <Plug>(GitGutterUndoHunk)

nmap <leader>fr <PLug>(flutter.run)

set winblend=3
let $FZF_DEFAULT_OPTS=' --color=dark --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,prompt:15,pointer:1,marker:4,spinner:11,header:-1,border:0,gutter:-1 --layout=reverse  --margin=1,2'

" Using the custom window creation function
let g:fzf_layout = { 'window': 'call FloatingFZF(160, 26)' }

function! FloatingFZF(width, height)
    let width = a:width
    let height = a:height

    let top = 2
    let left = float2nr((&columns - width) / 2)

    let opts = {
        \ 'relative': 'editor',
        \ 'row': top,
        \ 'col': left,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }


    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"

    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)

    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)

    set winhl=Normal:Floating

    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4

    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)

    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction

" Function to create the custom floating window
function! FloatingFZF2(width, height)
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')
  call setbufvar(buf, '&number', 0)
  call setbufvar(buf, '&relativenumber', 0)
  call setbufvar(buf, '&cursorline', 0)

  let width = float2nr(a:width)
  let height = float2nr(a:height)
  let horizontal = float2nr((&columns - width) / 2)
  let vertical = 1

  let opts = {
        \ 'relative': 'editor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction

function! SearchInProject()
    let g:fzf_layout = { 'window': 'call FloatingFZF(190, 36)' }
    let term = input("Search term: ")

    if l:term != ""
        call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case "' . l:term . '"', 1,fzf#vim#with_preview('right:60%'))
    endif
    let g:fzf_layout = { 'window': 'call FloatingFZF(160, 26)' }
endfunction

map <M-F> :call SearchInProject()<CR>

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

function! s:format_qf_diags(item) abort
  let l:parsed = s:parse_error(a:item)
  return {'bufnr' : bufnr(l:parsed['bufnr']), 'lnum' : l:parsed['linenr'], 'col': l:parsed['colnr'], 'text' : l:parsed['text']}
endfunction

function! s:build_quickfix_list(lines)
  call setqflist(map(a:lines, 's:format_qf_diags(v:val)'),'r', "Diagnostics")
endfunc

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

let g:lsc_auto_map = v:true
let g:lsc_enable_autocomplete = v:false
let g:lsc_server_commands = {'dart': 'dart_language_server'}

autocmd FileType php setlocal iskeyword-=$
autocmd FileType javascript setlocal iskeyword+=$

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

imap cll console.log({});<Esc>==f{a 

" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
let g:ycm_clangd_binary_path = exepath("clangd")

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
    \ }

" note that if you are using Plug mapping you should not use `noremap` mappings.
" nmap <F5> <Plug>(lcn-menu)
" Or map each action separately
" nmap <silent>K <Plug>(lcn-hover)
" nmap <silent> gd <Plug>(lcn-definition)
" nmap <silent> <F2> <Plug>(lcn-rename)
