" TOC
" 1.) System Setup
"
" 2.) Visual Effects
" 3.) Keyboard Re-mappings
" 4.) Plugin Settings
" 	a. NERDTree
"
" 1.) System setup
" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier.
if has('win32') || has('win64')
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

" Easy pasting to Windows and XWindows systems"
set clipboard=unnamed

" Setup pathogen"
execute pathogen#infect()
filetype off

" Activate syntax highlighting.
syntax enable

"Stop showing "Press ENTER or type command to continue"
set cmdheight=2

filetype plugin indent on

:Helptags

" 2.) Visual Effects
" Set a nice theme.
color slate

" Column Settings 
" Create a columns on [80]
let &colorcolumn=80
highlight ColorColumn term=reverse ctermbg=8 guibg=DarkGrey

" Tab setting
" Always show the tab characters
set list!
set listchars=tab:>-
set tabstop=4 shiftwidth=4

" Display line and column number in bottom ruler.
set ruler

" Display the line numbers.
set number

if has("gui_running")
  " Set a nicer font.
  set guifont=Consolas:h11:cDEFAULT
  " Hide the toolbar.
  set guioptions-=T
endif

" 3.) Keyboard changes
" Explicityly set the mapleader(s)
let mapleader = "\\"
let maplocalleader = "\\"

" Change backspace behavior
set backspace=indent,eol,start

" Quick access to VIMRC
" Set $MYVIMRC to point to this file. Note: This may be a bad idea.
let $MYVIMRC="$HOME/.vim/.vimrc"
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
"Save and refresh the vimrc
nnoremap <leader>sv :w<cr>:source $MYVIMRC<cr>

" Quick esc using jk, an alternative to switching capslock
inoremap jk <esc>
inoremap kj <esc>

"Press esc to automatically close a help window
augroup quickhelpexit
	au!
	autocmd FileType help nnoremap <buffer> <esc> :q<CR>
	autocmd BufLeave help nunmap <buffer> <esc>
augroup END

" Disable the arrow keys so you can be a super professional vim user
noremap <Left>  <NOP>
noremap <Right> <NOP>
noremap <Up>    <NOP>
noremap <Down>  <NOP>

"3a.) NERDTree
noremap <leader>nn :NERDTreeToggle<cr>
noremap <leader>nb :NERDTreeFromBookmark 
noremap <leader>nf :NERDTreeFind<cr>

	"3b.) Tagbar
	noremap  <silent> <special> <F12> :TagbarToggle<RETURN> 
	noremap! <silent> <special> <F12> :TagbarToggle<RETURN>

" 4.) Plugin Settings
	"4a.) NerdTree settings
	let g:NERDTreeWinPos = "left"
