let mapleader = "\<Space>"
let maplocalleader = "\<Space>"

execute pathogen#infect()
syntax on
filetype plugin indent on

" set the Terminal StatusLine colors to be more readable
hi StatusLineTerm cterm=bold,reverse ctermfg=NONE ctermbg=NONE
hi StatusLineTermNC cterm=reverse ctermfg=NONE ctermbg=NONE

set t_ut=
set binary
set eol

" Maintain undo history between sessions
set noundofile
set undodir=/tmp//,.

set conceallevel=2

set linebreak
set nolist
let &showbreak = '↳ '
set path=.,,*
set wildignore+=*/tmp/*,*.swp,*.un~,*/vendor/*,*/cache/*,*/node_modules/*,.git/*
set tabstop=2
set shiftwidth=2
set expandtab
set laststatus=0

" show whitespace chars
set listchars=tab:>-,trail:~
set list

" highlight code issues
" long lines
match ErrorMsg '\%>120v.\+'
" whitespace line endings
match ErrorMsg '\s\+$'

" file explorer stuff
" at directory of current file
nnoremap <Leader>ee :Ex<CR>
" in split at directory of current file
nnoremap <Leader>es :Se<CR>
" in vertical split at directory of current file
nnoremap <Leader>ev :Vex<CR>

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

let g:LanguageClient_serverCommands = {
      \ 'reason': ['/root/reason-language-server']
      \ }

function LC_maps()
  if has_key(g:LanguageClient_serverCommands, &filetype)
    set completefunc=LanguageClient#complete
    set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()
    nnoremap <Leader>fr :call LanguageClient_textDocument_references()<CR>
    nnoremap <Leader>fc :call LanguageClient_textDocument_formatting()<CR>
    vnoremap <Leader>fc :call LanguageClient_textDocument_rangeFormatting()<CR>
    nnoremap <Leader>fh :call LanguageClient_textDocument_hover()<CR>
    vnoremap <Leader>fh :call LanguageClient_textDocument_hover()<CR>
    nnoremap <Leader>fd :call LanguageClient_textDocument_definition()<CR>
    vnoremap <Leader>fd :call LanguageClient_textDocument_definition()<CR>
  endif
endfunction

autocmd FileType * call LC_maps()
