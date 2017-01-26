" MacVim specific -----------------------------------------------------
set guioptions-=T                           " remove the toolbar
set guioptions-=l                           " remove scrollbars
set guioptions-=L
set guioptions-=r
set guioptions-=R
" set guifont=PragmataPro:h16
if has("gui_running")
  if has("gui_gtk2") || has("gui_gtk3")
    set guifont=PragmataPro\ 16
  elseif has("gui_photon")
    set guifont=PragmataPro:s16
  " elseif has("gui_kde")
    " set guifont=Courier\ New/11/-1/5/50/0/0/0/1/0
  " elseif has("x11")
    " set guifont=-*-courier-medium-r-normal-*-*-180-*-*-m-*-*
  else
    set guifont=PragmataPro:h16:cDEFAULT
  endif
endif

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

