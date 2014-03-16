" Vim configuration for
" Lincoln Mullen | lincoln@lincolnmullen.com | http://lincolnmullen.com

" Pathogen
" -------------------------------------------------------------------
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" General 
" -------------------------------------------------------------------
set nocompatible
set encoding=utf-8
set showmode
set showcmd
set hidden
set ruler
set backspace=indent,eol,start              " allow backspacing in insert mode
set showmatch                               " matching parentheses
set smarttab
set history=1000                            " remember commands and searches
set undolevels=100                          " use many levels of undo
set noerrorbells                            " don't beep
set mouse=a                                 " use mouse in console
filetype plugin indent on                   " detect filetypes
set nrformats-=octal
set shiftround
set ttimeout
set ttimeoutlen=50
set autoread
au FocusLost * :wa                          " save when losing focus (gVim)

" Display
" -------------------------------------------------------------------
set t_Co=16                                 " color terminal
syntax enable                               " syntax highlighting
set background=dark
colorscheme solarized
set display+=lastline                       " show partial last lines
set nolist                                  " don't display space chars
set listchars=tab:▸\ ,eol:¬,trail:·,nbsp:·  " TextMate style space chars
set scrolloff=5                             " cursor 5 lines from top or bottom
set number

" Status line
" -------------------------------------------------------------------
set laststatus=2                            " always show a status line
set statusline=""
set statusline+=%t                          " tail/filename
set statusline+=%m%r%h                      " modified/read only/help
set statusline+=\ [%{&ff}/%Y]               " line endings/type of file
set statusline+=\ %{fugitive#statusline()}  " Git status
set statusline+=\ [L\:%l\/%L,\%p%%\ C\:%c]  " line/total lines percentage/column

" Viminfo 
" -------------------------------------------------------------------
set viminfo='300,f1,<300,:500,/500,n~/.viminfo

" Functions 
" -------------------------------------------------------------------
source $HOME/.vim/functions.vim

" Search 
" -------------------------------------------------------------------
set incsearch                               " show search matches as you type
set ignorecase
set smartcase                               " smart about case sensitivity
" set hlsearch                                " highlight search terms
" clear search highlighting
" nmap <silent> <leader>/ :nohlsearch<CR>
" use very magic mode explicitly
cnoremap s/ s/\v
cnoremap %s/ %s/\v
nnoremap / /\v
vnoremap / /\v

" Folding
" -------------------------------------------------------------------
set nofoldenable
set foldcolumn=1                            " show where the folds are
nnoremap <space> za

" Keyboard shortcuts
" -------------------------------------------------------------------
nnoremap ~ K
nnoremap K ~
nmap E ge
" nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
" nnoremap <leader>lcd :lcd %:p:h<CR>:pwd<CR>
" reselect visual after indent
vnoremap < <gv
vnoremap > >gv
" move between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" disable arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
" move by display not logical lines
nnoremap j gj
nnoremap k gk
" paired keymappings
" nnoremap [q :cprev<CR>
" nnoremap ]q :cnext<CR>
" nnoremap [Q :cfirst<CR>
" nnoremap ]Q :clast<CR>
" nnoremap [l :lprev<CR>
" nnoremap ]l :lnext<CR>
" nnoremap [L :lfirst<CR>
" nnoremap ]L :llast<CR>
" nnoremap [b :bprev<CR>
" nnoremap ]b :bnext<CR>
" nnoremap ]t :tnext<CR>
" nnoremap [t <C-T>
" nnoremap [a :prev<CR>
" nnoremap ]a :next<CR>
" nnoremap [A :first<CR>
" nnoremap ]A :last<CR>
nnoremap [<space> O<ESC>j
nnoremap ]<space> o<ESC>k
nnoremap ]n /\V[^\d\+]<CR>
nnoremap [n ?\V[^\d\+]<CR>
" Ctrl-v for pasting in insert mode
imap <C-v> <C-r><C-o>+
imap <C-c> <CR><Esc>O

" Tab completion
" -------------------------------------------------------------------
if has('wildmenu')
  set wildmenu
  set wildignore+=*.aux,*.bak,*.bbl,*.blg,*.class,*.doc,*.docx,*.dvi,*.fdb_latexmk,*.fls,*.idx,*.ilg,*.ind,*.log,*.out,*.pdf,*.png,*.pyc,*.Rout,*.rtf,*.swp,*.synctex.gz,*.toc,*.zip,*/.hg/*,*/.svn/*,*.mp3,*/_site/*,*~,.DS_Store,*/public/*,*Session.vim*,*.jpeg,*.jpg,*.gif,*.svg
endif

" Word count
" -------------------------------------------------------------------
nmap <silent> <leader>wc g<C-G>
" nmap <silent> <leader>lwc :w<CR> :!detex % \| wc -w<CR>

" Spell check 
" -------------------------------------------------------------------
set spelllang=en_us                         " US English
set spell                                   " spell check on
set spellsuggest=10                         " only suggest 10 words

" Abbreviations 
" -------------------------------------------------------------------
source $HOME/.vim/abbreviations.vim         " load abbreviations list
command! -nargs=0 Abbr sp $HOME/.vim/abbreviations.vim

" Text formatting 
" -------------------------------------------------------------------
set wrap                                    " soft wrap long lines
set textwidth=78
set tabstop=2                               " a tab is four spaces
set softtabstop=2                           " soft tab is four spaces
set shiftwidth=2                            " # of spaces for autoindenting
set expandtab                               " insert spaces not tabs
set autoindent                              " always set autoindenting on
set copyindent                              " copy prev indentation
set shiftround                              " use shiftwidth when indenting
" Use Q to format paragraph
vnoremap Q gq
nnoremap Q gwap
set formatoptions=tqcwn                     " see :help fo-table

" Vimrc
" -------------------------------------------------------------------
command! -nargs=0 Evimrc e $MYVIMRC
command! -nargs=0 Svimrc source $MYVIMRC
command! -nargs=0 Efunctions e $HOME/.vim/functions.vim
set backup                                  " backups and swaps
set backupdir=$HOME/.cache/vim/backup/
set directory=$HOME/.cache/vim/swap/
" automatically reload vimrc
augroup reload_vimrc " {
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" Pandoc 
" -------------------------------------------------------------------
au BufNewFile,BufRead *.markdown,*.md,*.mkd,*.pd,*.pdc,*.pdk,*.pandoc,*.text,*.txt,*.page   set filetype=pandoc
" Find the space before Pandoc footnotes
nnoremap <leader><space> /\v^$\n[\^1\]:<CR>:let @/ = ""<CR>

" Formating file
" -------------------------------------------------------------------
" Run equalprg on the entire file
nnoremap <silent> <leader>= mpgg=G`p
" Run equalprg from the part of the file marked P to the end
" map <leader>p mc'p=G'c

" Commentary.vim 
" -------------------------------------------------------------------
autocmd FileType apache set commentstring=#\ %s   "comments for Apache
autocmd FileType r set commentstring=#\ %s        "comments for R
autocmd FileType pandoc set commentstring=<!--\ %s\ -->   "comments for pandoc
map <C-c> gcc<esc>
map <C-\> gcc
vnoremap <C-c> gcc<esc>

" UltiSnips
" -------------------------------------------------------------------
let g:UltiSnipsEditSplit = 'horizontal'
" let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" let g:UltiSnipsNoPythonWarning = 1
map <F4> :UltiSnipsEdit<CR>

" Syntastic 
" -------------------------------------------------------------------
let g:syntastic_always_populate_loc_list=1
let g:syntastic_javascript_checkers=['jshint']
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'

" Ctrl-P 
" -------------------------------------------------------------------
let g:ctrlp_open_new_file = 'r'             " open new files in same window
nmap <C-B> :CtrlPBuffer<CR>
let g:ctrlp_use_caching = 0
let g:ctrlp_clear_cache_on_exit = 1         
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
let g:ctrlp_dotfiles = 0                    " ignore dotfiles and dotdirs
let g:ctrlp_custom_ignore = { 'dir': '\.git$\|\_site$' }

" Airline
" -------------------------------------------------------------------
let g:airline_theme='solarized'
let g:airline_detect_paste=0
let g:airline_detect_whitespace=0
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '◀'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols_linenr = '␤'
let g:airline_symbols_branch = '⎇'

" NERDTree
" -------------------------------------------------------------------
" Automatically open NERDTree
" autocmd vimenter * if !argc() | NERDTree | endif
" Close Vim if NERDTree is the only open buffer
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Ignore certain files
" let NERDTreeIgnore=['\.pdf$','\.vim$', '\~$']
" let NERDTreeMinimalUI = 1
" map <F3> :NERDTreeToggle<CR>


" TagBar
" -------------------------------------------------------------------
map <F3> :TagbarToggle<CR>

" Run scripts from Vim
" from http://www.oinksoft.com/blog/view/6/
let ft_stdout_mappings = {
      \'applescript': 'osascript',
      \'bash': 'bash',
      \'bc': 'bc',
      \'haskell': 'runghc',
      \'javascript': 'node',
      \'lisp': 'sbcl',
      \'nodejs': 'node',
      \'ocaml': 'ocaml',
      \'perl': 'perl',
      \'php': 'php',
      \'python': 'python',
      \'ruby': 'ruby',
      \'scheme': 'scheme',
      \'sh': 'sh',
      \'sml': 'sml',
      \'spice': 'ngspice'
      \}

for ft_name in keys(ft_stdout_mappings)
  execute 'autocmd Filetype ' . ft_name . ' nnoremap <buffer> <C-x> :write !'
        \. ft_stdout_mappings[ft_name] . '<CR>'
endfor

let ft_execute_mappings = {
      \'c': 'gcc -o %:r -Wall -std=c99 % && ./%:r',
      \'erlang': 'escript %',
      \'pascal': 'fpc % && ./%:r',
      \'pandoc': 'pandoc -t html --standalone % -o /tmp/pandoc-temp.html && pandoc % -o /tmp/pandoc-temp.pdf'
      \}

for ft_name in keys(ft_execute_mappings)
  execute 'autocmd FileType ' . ft_name
        \. ' nnoremap <buffer> <C-x> :write \| !'
        \. ft_execute_mappings[ft_name] . '<CR>'
endfor

" Vim-JSON
" -------------------------------------------------------------------
let g:vim_json_syntax_conceal = 0

" Tabular
" -------------------------------------------------------------------
nnoremap <leader>t= :Tabularize /=<CR>
nnoremap <leader>t, :Tabularize /,<CR>
nnoremap <leader>t: :Tabularize /:\zs<CR>

" Temporary
" -------------------------------------------------------------------

autocmd FileChangedRO * echohl WarningMsg | echo "File changed RO." | echohl None
autocmd FileChangedShell * echohl WarningMsg | echo "File changed shell." | echohl None

" Resize the splits if the vim windows is resized
autocmd VimResized * :wincmd =

" nnoremap <C-p> "+p
" nnoremap <C-P> "+p
vnoremap <C-C> "+y

" Convert pandoc buffer to HTML and copy to system clipboard
autocmd FileType pandoc nnoremap <buffer> <C-S-x> :write \| let @+ = system("pandoc -t html " . shellescape(expand("%:p")))<CR>

" nnoremap <F6> "+
nnoremap <F7> "+p
vnoremap <F8> "+y

" Make YouCompleteMe and UltiSnips play nice
" -------------------------------------------------------------------
function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips_JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsExpandTrigger ="<c-e>"

"" YouCompleteMe
" let g:ycm_key_list_previous_completion=['<Up>']

"" Ultisnips
" let g:UltiSnipsExpandTrigger="<c-tab>"
" let g:UltiSnipsListSnippets="<c-s-tab>"
