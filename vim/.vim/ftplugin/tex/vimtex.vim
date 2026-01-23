"let mapleader=" "
let g:tex_flavor='latex'
let g:vimtex_view_method='skim'
let g:vimtex_quickfix_mode=0
nmap <leader>c :VimtexCompile<CR>
nnoremap <leader>w :w<CR>
nmap <leader>v <plug>(vimtex-view)

augroup LatexAutoSave
    autocmd!
" set auto-update time from default(4000ms) to 500ms
    set updatetime=500
" save after cursor holds longer than updatetime or loose focus
    autocmd CursorHold,FocusLost,InsertLeave *.tex silent! update
augroup END
