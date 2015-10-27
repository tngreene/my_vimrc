" TOC
" 1.) System Setup
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
set backspace=indent,eol,start
