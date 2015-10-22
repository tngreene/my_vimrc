" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier.
if has('win32') || has('win64')
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

"Setup pathogen"
execute pathogen#infect()
filetype off

" Activate syntax highlighting.
syntax enable

filetype plugin indent on

:Helptags

"Easy pasting to Windows and XWindows systems"
set clipboard=unnamed
set colorcolumn=80
set tabstop=4 shiftwidth=4

" Display line and column number in bottom ruler.
set ruler

" Display the line numbers.
set number

" Set a nice theme.
color slate

if has("gui_running")
  " Set a nicer font.
  set guifont=Consolas:h11:cDEFAULT
  " Hide the toolbar.
  set guioptions-=T
endif