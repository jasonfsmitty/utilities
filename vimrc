"
" Taken from various places over the years.
"
" Some sources:
"   http://gergap.wordpress.com/2009/05/29/minimal-vimrc-for-cc-developers/
"

set nocompatible " disable vi compatibility (emulation of old bugs)
set autoindent   " use indentation of previous line
set smartindent  " intelligent indention for C

set tabstop=4      " set tab width
set shiftwidth=4   " ?
set softtabstop=4  " indent is same size
set noexpandtab    " must use tabs for indentation

set nowrap         " disable line wrapping
set incsearch      " search as you type
set hlsearch       " highlight all matches to a search

set bsdir=last     " last accessed dir set as working dir

syntax on          " enable syntax highlighting
"set number         " turn line numbers on
set showmatch      " show matching braces

set mat=5          " ??
filetype on        " ??

set ruler          " show status/ruler at bottom
set cindent        " default to c indentation

set background=dark

" 'intelligent' comments
"set comments=sl:/*,mb:\ *,elx:\ */

" Function folding... can never remember keyboard shortcuts
"set fmr={,}
"set fdm=indent
"set fdn=1

set mouse=        " Turn off the mouse support
set nobackup      " I'm not a fan of the backup files
set tags=tags;/   " Search recursively in parent folders for tags file

:map <Down> gj
:map <Up> gk


" OmniCppComplete support
"   http://vim.wikia.com/wiki/C++_code_completion
"set tags+=~/.vim/tags/cpp
"set tags+=~/.vim/tags/gl
"set tags+=~/.vim/tags/sdl
"set tags+=~/.vim/tags/qt4


"------------------------------------------------------------------
" These allow us to return to the same position in a file
" when it's reopened.
"autocmd BufReadPost *
"  \ if expand("<afile>:p:h") !=? $TEMP |
"  \   if line("'\"") > 0 && line("'\"") <= line("$") |
"  \     exe "normal g`\"" |
"  \     let b:doopenfold = 1 |
"  \   endif |
"  \ endif
" Need to postpone using "zv" until after reading the modelines.
"autocmd BufWinEnter *
"  \ if exists("b:doopenfold") |
"  \   unlet b:doopenfold |
"  \   exe "normal zv" |
"  \ endif

augroup filetype
  au! BufRead,BufNewFile *.proto setfiletype proto
augroup end

