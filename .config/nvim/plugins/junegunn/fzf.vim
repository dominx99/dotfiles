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
        call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case --no-ignore -g "!tags" "' . l:term . '"', 1,fzf#vim#with_preview('right:60%'))
    endif
    let g:fzf_layout = { 'window': 'call FloatingFZF(160, 26)' }
endfunction
