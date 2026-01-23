" Confirm completion with <C-CR> if the popup menu is visible.
" Otherwise, break the undo chain and trigger coc#on_enter() (typically for formatting).
inoremap <silent><expr> <C-CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Navigate the completion list using <C-j> (next item) and <C-k> (previous item).
inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
inoremap <silent><expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"
