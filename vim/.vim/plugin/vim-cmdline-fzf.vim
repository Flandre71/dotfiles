" ── FZF command-line completion ───────────────────────────────────────────────
let s:saved_cmd = ''
let s:prefix    = ''

" Find the end of cmd which match to the completion, return the prefix which don't need replacement
function! s:GetPrefix(cmd, completions)
  let first = a:completions[0]
  for i in range(0, len(a:cmd))
    let suffix = a:cmd[i :]
    if stridx(first, suffix) == 0
      return i == 0 ? '' : a:cmd[: i - 1]
    endif
  endfor
  return a:cmd
endfunction

function! s:FzfCmdlineTab()
  if getcmdtype() !=# ':'
    return "\<C-t>"
  endif

  let cmd = getcmdline()
  let completions = getcompletion(cmd, 'cmdline')

  if empty(completions)
    return "\<C-t>"
  endif

  let s:saved_cmd = cmd
  let s:prefix    = s:GetPrefix(cmd, completions)

  call timer_start(1, {-> s:RunFzf(completions)})
  return "\<C-c>"
endfunction

function! s:RunFzf(items)
  call fzf#run(fzf#wrap({
    \ 'source':  a:items,
    \ 'sink*':   function('s:Sink'),
    \ 'options': [
    \   '--prompt=>> ',
    \   '--bind=ctrl-j:down,ctrl-k:up',
    \   '--expect=esc',
    \   '--no-multi',
    \ ],
    \ 'down': '30%',
    \ }))
endfunction

function! s:Sink(lines)
  if get(a:lines, 0, '') ==# 'esc' || len(a:lines) < 2
    call feedkeys(':' . s:saved_cmd, 'nt')
    return
  endif
  call feedkeys(':' . s:prefix . a:lines[1], 'nt')
endfunction

cnoremap <expr> <Tab> <SID>FzfCmdlineTab()
" ─────────────────────────────────────────────────────────────────────────────
