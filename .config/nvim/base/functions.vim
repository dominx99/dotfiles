function! FindTags(name, kinds)
  let tag_list = []

  for entry in taglist(a:name)
    if index(a:kinds, entry.kind) > -1
      call add(tag_list, entry)
    endif
  endfor

  return tag_list
endfunction

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
