
" Copy the name of the current file to the clipboard
function! s:CopyFileName()
  let @+ = expand("%")
endfunction

" Copy filename, line number range, and lines (with or without line numbers)
" to the clipboard
function! s:CopyLines(...) range
  if a:lastline <= a:firstline
    let l:lastline = a:firstline
    let l:lines = [expand("%") . ", line " . a:firstline . ":\n"]
  else
    let l:lastline = a:lastline
    let l:lines = [expand("%") . ", lines " . a:firstline . "-" . a:lastline . ":\n"]
  endif
  if a:0 > 0 && a:1
    let l:i = a:firstline
    while l:i <= l:lastline
      let l:lines = add(l:lines, printf("%" . strlen(l:lastline) . "d %s", l:i, getline(l:i)))
      let l:i += 1
    endwhile
  else
    let l:lines = extend(l:lines, getline(a:firstline, l:lastline))
  endif
  let @+ = join(l:lines, "\n")
endfunction

command! -range CopyLines <line1>,<line2>call s:CopyLines()
command! -range CopyLinesNumbered <line1>,<line2>call s:CopyLines(1)
command! CopyFileName call s:CopyFileName()

