let mapleader = "\<Space>"
let maplocalleader = "\<Space>"

execute pathogen#infect()
syntax on
filetype plugin indent on

set t_ut=
set binary
set eol

" Maintain undo history between sessions
set undofile

set conceallevel=2

set linebreak
set nolist
let &showbreak = '↳ '
set path=.,,*
set wildignore+=*/tmp/*,*.swp,*.un~,*/vendor/*,*/cache/*,*/node_modules/*,.git/*
set tabstop=2
set shiftwidth=2
set expandtab

" show whitespace chars
set listchars=tab:>-,trail:~
set list

" highlight code issues
" long lines
match ErrorMsg '\%>120v.\+'
" whitespace line endings
match ErrorMsg '\s\+$'

" window stuff
" size changes
nnoremap <Leader>w> :5winc ><CR>
nnoremap <Leader>w< :5winc <<CR>
nnoremap <Leader>w- :5winc -<CR>
nnoremap <Leader>w+ :5winc +<CR>
nnoremap <Leader>w> :5winc ><CR>
nnoremap <Leader>w< :5winc <<CR>
nnoremap <Leader>w- :5winc -<CR>
nnoremap <Leader>w+ :5winc +<CR>

" disable Ex mode
nnoremap Q <nop>

" no more arrow keys <gasp>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" don't copy overwritten selection when pasting
vnoremap p "_dP
