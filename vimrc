
set autoindent
set smartindent

set ts=4
set shiftwidth=4
set softtabstop=4
set noexpandtab

set nowrap
set incsearch
set hlsearch
set smartcase

set showmatch

syntax on
filetype on

set nobackup

set tags=tags;/

:map <Down> gj
:map <Up> gk

noremap j gj
noremap k gk

" https://vi.stackexchange.com/a/2285
" Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
nnoremap <F6> :let _s=@/<Bar>:%s///e<Bar>:let @/=_s<Bar><CR>

