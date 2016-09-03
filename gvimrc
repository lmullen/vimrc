" MacVim specific -----------------------------------------------------
set guioptions-=T                           " remove the toolbar
set guioptions-=l                           " remove scrollbars
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guifont=PragmataPro:h16

" Ctrl S for gui Vim
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" Ctrl Z undoes rather than minimizes
noremap <C-z> u

" Copying and pasting like you'd expect
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+

set background=dark

