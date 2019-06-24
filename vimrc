" Formatting
set smartindent
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
syntax on
:command GoogleStyle set tabstop=2 shiftwidth=2

" Input
set mouse=a
set backspace=2

" Visual cues
set cursorline
set nu
set relativenumber
set cc=100

" RegEx
set gdefault
set incsearch

" No delay on <Esc>
set timeoutlen=1000
set ttimeoutlen=0

" Theme
let g:molokai_original = 1
let g:rehash256 = 1
colo monokai

" <F5> behavior
au FileType python map <F5> :!clear && python2 -i %<CR>
au FileType python map <F6> :!clear && python3 -i %<CR>
au FileType tex map <F5> :!clear && pdflatex -shell-escape % && latexmk -c %<CR>
au FileType javascript map <F5> :!clear && node %<CR>

" Paste behavior
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

" Remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e
