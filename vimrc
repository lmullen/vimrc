" Vim configuration for Lincoln Mullen <http://lincolnmullen.com>

" Vundle plugins
" -------------------------------------------------------------------
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
let g:vundle_default_git_proto = 'git'
call vundle#begin()

Plugin 'SirVer/ultisnips'
Plugin 'altercation/vim-colors-solarized'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'gmarik/Vundle.vim'
Plugin 'honza/vim-snippets'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/syntastic'
Plugin 'sheerun/vim-polyglot'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-obsession'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-vinegar'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'wincent/terminus'

call vundle#end()
filetype plugin indent on

" General 
" -------------------------------------------------------------------
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
set nrformats-=octal
set shiftround
set timeoutlen=250
set ttimeoutlen=100
set autoread
au FocusLost * :wa                          " save when losing focus (gVim)

" Display
" -------------------------------------------------------------------
set t_Co=16                                " color terminal
syntax enable                               " syntax highlighting
let g:solarized_termcolors=16
set background=dark
colorscheme solarized
set display+=lastline                       " show partial last lines
set nolist                                  " don't display space chars
set listchars=tab:▸\ ,eol:¬,trail:·,nbsp:·  " TextMate style space chars
set scrolloff=0
set number
" Resize the splits if the vim windows is resized
autocmd VimResized * :wincmd =

" Status line
" -------------------------------------------------------------------
set laststatus=2                            " always show a status line
set statusline=""
set statusline+=%t                          " tail/filename
set statusline+=%m%r%h                      " modified/read only/help
set statusline+=\ [%Y]                      " line endings/type of file
set statusline+=\ %{fugitive#statusline()}  " Git status
set statusline+=%=                          " left/right separator
" Syntastic warning
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*
" display a warning if the line endings aren't unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*
" display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*
" progress through file
set statusline+=C:%02c,                       " cursor column
set statusline+=L:%03l/%03L                   " cursor line/total lines
set statusline+=\ %P                        " percent through file

" Viminfo 
" -------------------------------------------------------------------
set viminfo='300,f1,<300,:500,/500,n~/.viminfo

" Functions 
" -------------------------------------------------------------------
source $HOME/.vim/functions.vim

" Search 
" -------------------------------------------------------------------
set incsearch
set ignorecase
set smartcase

" Folding
" -------------------------------------------------------------------
set nofoldenable
set foldcolumn=1
nnoremap <space> za

" Keyboard shortcuts
" -------------------------------------------------------------------
nnoremap ~ K
nnoremap K ~
nmap E ge
" reselect visual after indent
vnoremap < <gv
vnoremap > >gv
" move between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap j gj
nnoremap k gk
nnoremap [<space> O<ESC>j
nnoremap ]<space> o<ESC>k
nnoremap ]N /\V[^\d\+]<CR>
nnoremap [N ?\V[^\d\+]<CR>
" Copying and pasting
imap <C-v> <C-r><C-o>+
imap <C-c> <CR><Esc>O

" Tab completion
" -------------------------------------------------------------------
if has('wildmenu')
  set wildmenu
  set wildignore+=*.aux,*.bak,*.bbl,*.blg,*.class,*.doc,*.docx,*.dvi,*.fdb_latexmk,*.fls,*.idx,*.ilg,*.ind,*.out,*.png,*.pyc,*.Rout,*.rtf,*.swp,*.synctex.gz,*.toc,*/.hg/*,*/.svn/*,*.mp3,*/_site/*,*/_site-preview/*,*/_site-deploy/*,*~,.DS_Store,*/public/*,*Session.vim*,*.jpeg,*.jpg,*.gif,*.svg,*.log,*.lof,*.zip,*.pdf,*.md.tex,*/node_modules/*,*/lib/*,*data-raw/*,*legal-codes-split/*
  set suffixes+=*.log,*.zip,*.pdf
endif

" Spell check 
" -------------------------------------------------------------------
set spelllang=en_us                         " US English
set spell                                   " spell check on
set spellsuggest=10                         " only suggest a few words

" Abbreviations 
" -------------------------------------------------------------------
source $HOME/.vim/abbreviations.vim         " load abbreviations list
command! -nargs=0 Abbr sp $HOME/.vim/abbreviations.vim

" Text formatting 
" -------------------------------------------------------------------
set wrap                                    " soft wrap long lines
set linebreak
set textwidth=78
set tabstop=2                               " a tab is two spaces
set softtabstop=2                           " soft tab is two spaces
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
set nobackup                                  " backups and swaps
set noswapfile
set backupdir=$HOME/.cache/vim/backup/
set directory=$HOME/.cache/vim/swap/

" Solarized
" -------------------------------------------------------------------
let g:solarized_menu=0

" Pandoc 
" -------------------------------------------------------------------
au BufNewFile,BufFilePRe,BufRead *.markdown,*.md,*.mkd,*.pd,*.pdc,*.pdk,*.pandoc,*.text,*.txt,*.Rmd   set filetype=markdown.pandoc
" Find the space before Pandoc footnotes
nnoremap <leader><space> /\v^$\n[\^1\]:<CR>:let @/ = ""<CR>
" Convert pandoc buffer to HTML and copy to system clipboard
autocmd FileType markdown nnoremap <buffer> <C-S-x> :write \| let @+ = system("pandoc -t html " . shellescape(expand("%:p")))<CR>
let g:pandoc#syntax#conceal#use = 0

" CSVs
" -------------------------------------------------------------------
au BufNewFile,BufRead *.csv set filetype=CSV
autocmd FileType CSV set nowrap textwidth=0 wrapmargin=0

" Formating file
" -------------------------------------------------------------------
" Run equalprg on the entire file
nnoremap <silent> <leader>= mpgg=G`p

" Commentary.vim 
" -------------------------------------------------------------------
autocmd FileType apache set commentstring=#\ %s   "comments for Apache
autocmd FileType make set commentstring=#\ %s   "comments for Makefile
autocmd FileType r set commentstring=#\ %s        "comments for R
autocmd FileType pandoc set commentstring=<!--\ %s\ -->   "comments for pandoc
nmap <C-c> gcc

" UltiSnips
" -------------------------------------------------------------------
let g:UltiSnipsEditSplit = 'horizontal'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Syntastic 
" -------------------------------------------------------------------
let g:syntastic_always_populate_loc_list=1
let g:syntastic_javascript_checkers=['jshint']
let g:syntastic_cpp_compiler_options = ' -std=c++11'

" Ctrl-P 
" -------------------------------------------------------------------
let g:ctrlp_open_new_file = 'r'             " open new files in same window
nnoremap <C-B> :CtrlPBuffer<CR>
let g:ctrlp_use_caching = 0
let g:ctrlp_clear_cache_on_exit = 1         
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
let g:ctrlp_dotfiles = 0                    " ignore dotfiles and dotdirs
let g:ctrlp_custom_ignore = { 'dir': '\.git$\|\_site$' }

" Ag
" -------------------------------------------------------------------
let g:ag_prg="ag --column --smart-case"


