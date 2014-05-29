" convert smart typographical symbols to Markdown standards
nnoremap _md :silent! call CleanMarkdown()<CR>
function! CleanMarkdown()
  :%s/—/---/ge 
  :%s/–/--/ge
  :%s/…/.../ge
  :%s/’/'/ge
  :%s/“/"/ge
  :%s/‘/'/ge
  :%s/”/"/ge
  :%s///ge
  " :%s/``/"/ge
  " :%s/''/"/ge
endfunction

" put an en dash between number ranges
nnoremap _en :call EnDashRange()<CR>
function! EnDashRange()
  :%s/\v(\d)-(\d)/\1--\2/ge
endfunction

function! CleanJSRFootnotes()
  :%s/\v\^\[\[(\d+)\]\]\(\#ftnt\d+\)\^/[^\1]/ge
  :%s/\v\[\[(\d+)\]\]\(\#ftnt_ref\d+\)/[^\1]: /ge
endfunction

nnoremap _jsr :call CleanJSR()<CR>
function! CleanJSR()
  " replace non-breaking spaces with regular spaces
  :%s/ / /ge
  :%s/^\s\+//e
  " remove problems with * , in footnotes
  :%s/\V* ,/*,/ge
  " remove problems with *( in footnotes and titles
  :%s/\V*(/* (/ge
  call CleanJSRFootnotes()
  call CleanMarkdown()
  call EnDashRange()
endfunction

function! CleanT2()
  :%s/\v\’/'/ge
  :%s/\v\“/``/ge
  :%s/\v\‘/`/ge
  :%s/\v\”/''/ge
  :%s/\v```/``\\,`/ge
  :%s/\v'''/'\\,''/ge
  :%s/\v(\d)-(\d)/\1--\2/ge
  :%s/\v\—/---/ge
  :%s/\v\–/--/ge
  :%s/\v\•/\\item/ge
  :%s/\v\…/\\dots/ge
endfunction

function! Patristics()
  :%s/\vDecember/Dec./ge
  :%s/\vJanuary/Jan./ge
  :%s/\vFebruary/Feb./ge
  :%s/\vMarch/Mar./ge
  :%s/\vApril/Apr./ge
  :%s/\vAugust/Aug./ge
  :%s/\vSeptember/Sept./ge
  :%s/\vOctober/Oct./ge
  :%s/\vNovember/Nov./ge
  " :%s/\V<td class="hd">\n<p style='height:16px;'>.<\/p>\n<\/td>\n// 
  " :%s/\V dir='ltr' class='s\d'//
  " :%s/\V<td><\/td>\n//
  " :%s/\V class='s2'//
  " :%s/\v\&lt\;/</ge
  " :%s/\v\&gt\;/>/ge
endfunction

" Commit all changes in research wiki
command! -nargs=0 WikiCommit call CommitToWiki()
function! CommitToWiki()
  :silent !cd ~/acad/research && rake wiki
  :redraw!
endfunction

" Push all changes in research wiki
command! -nargs=0 WikiPush call PushWiki()
function! PushWiki()
  :silent !cd ~/acad/research && rake pushwiki
  :redraw!
endfunction

command! -nargs=0 BG call ToggleBackground()
function! ToggleBackground()
  if &background == "dark"
    set background=light
  else
    set background=dark
  endif
endfunction

" Add Omeka's tags
command! -nargs=0 Omeka call OmekaSetup()
function! OmekaSetup()
  set tags+=~/dev/Omeka/.git/tags
endfunction

" Open the current note file in the browser
command! -nargs=0 Wo call OpenCurrentNoteInWiki()
function! OpenCurrentNoteInWiki()
  silent !xdg-open "http://localhost:5001/%:r"
endfunction

command! -nargs=0 DeleteEveryBuffer call DeleteEveryBuffer()
function! DeleteEveryBuffer()
  :1,10000bd
endfunction

command! -nargs=0 DeleteCurrentBuffer call DeleteCurrentBuffer()
function! DeleteCurrentBuffer()
  :bp|bd #
endfunction

" Open the current file in the browser with the file system
command! -nargs=0 OpenInChromeWithFileSystem call OpenInChromeWithFileSystem()
function! OpenInChromeWithFileSystem()
  silent !google-chrome "%:p"
endfunction
"
" Open the current note file in the browser with localhost
command! -nargs=0 OpenInChromeWithLocalhost call OpenInChromeWithLocalhost()
function! OpenInChromeWithLocalhost()
  silent !google-chrome "http://localhost:4000/%"
endfunction

