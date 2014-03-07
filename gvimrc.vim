" MacVim specific -----------------------------------------------------
set guioptions-=T                           " remove the toolbar
set guioptions-=l                           " remove scrollbars
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guifont=PragmataPro\ 12

" Ctrl S for gui Vim
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>
