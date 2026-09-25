" ---------------------------------------------
" VIM OPTIONS
" ---------------------------------------------

" avoid side-effects when nocompatible has already been set
if &compatible
	set nocompatible	" use Vim defaults instead of 100% vi compatibility
endif

set backspace=indent,eol,start	" typical backspace behavior

"set relativenumber		" show relative line numbers
set number              " show absolute line number for current line

set scrolloff=5         " keep set lines visible above or below cursor

set autoindent          " automatically indent new lines
set smartindent			" automatically indent lines based on file syntax

set tabstop=4			" tab as set number of spaces (C language standard)
set softtabstop=4		" tab behavior consistent with set number of spaces
set shiftwidth=4		" each step of indentation as set number of spaces
set expandtab			" insert spaces instead of actual Tab characters

set ruler			    " enable ruler (display cursor line and column)
set showmode			" show current mode in status line
set showcmd			    " show partial command in status line
set title			    " show filename and status in the window title

set showmatch			" show matching brackets

set ignorecase          " search is case-insensitive ...
set smartcase           " ... unless pattern has uppercase letter
set incsearch			" highlight search matches in real time
set hlsearch			" highlight search results

set nostartofline		" don't jump to 1st non-blank char w/ page commands

"set formatoptions-=t		" don't autowrap text using 'textwidth'
set textwidth=80		" max width of the text
set colorcolumn=80		" enable colored column at the 80th character mark

set hidden              " allow unsaved background buffers

set wildmenu            " enable completion menu


" ---------------------------------------------
" COLOR SCHEME
" ---------------------------------------------

syntax on				" enable syntax highlighting

colorscheme default
hi Search ctermbg=238 ctermfg=NONE	" search results color
highlight ColorColumn ctermbg=236  " subtle colorcolumn color

" highlight redundant whitespaces
highlight RedundantWhitespace ctermbg=green guibg=green
match RedundantWhitespace /\s\+$\| \+\ze\t/


" ---------------------------------------------
" KEY REMAPPINGS
" ---------------------------------------------

" exit Insert mode with 'jj'
inoremap jj <ESC>

" clear search highlights in Normal mode
nnoremap <ESC> <CMD>nohlsearch<CR>
nnoremap <C-l> <CMD>nohlsearch<CR><C-l>

" ---------------------------------------------
" /><>/ 42 /><>/
" ---------------------------------------------

" configure user and email for 42 Porto
let g:user42 = 'nd-abreu'
let g:mail42 = 'nd-abreu@student.42porto.com'
