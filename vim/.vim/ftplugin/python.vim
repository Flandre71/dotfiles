"Set 4 spaces for tabs and indentation
au FileType python setlocal shiftwidth=4 tabstop=4 expandtab softtabstop=4

"<leader>+r to save and run current file
noremap <buffer> <leader>r :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
