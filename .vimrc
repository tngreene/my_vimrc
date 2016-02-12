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
	set runtimepath=$HOME/.vim,$HOME/.vim/vimfiles,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
	"To ensure NERDTree doesn't start in system32 or something
	cd $HOME

	" Quick access to VIMRC
	" Set $MYVIMRC to point to this file. Note: This may be a bad idea.
	let $MYVIMRC="$HOME/.vim/.vimrc"
elseif has('unix')
	set ffs=unix,dos,mac
	set runtimepath=$HOME/shared/dot/.vim,$HOME/.vim/vimfiles,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/shared/dot/.vim/after

	cd $HOME

	" Quick access to VIMRC
	" Set $MYVIMRC to point to this file. Note: This may be a bad idea.
	let $MYVIMRC="$HOME/shared/dot/.vim/.vimrc"
endif

" Easy pasting to Windows and XWindows systems"
set clipboard=unnamed

" Setup pathogen"
execute pathogen#infect()
filetype off

"Stop showing "Press ENTER or type command to continue"
set cmdheight=2

filetype plugin indent on

" Activate syntax highlighting.
syntax on 

" 2.) Visual Effects
" Set a nice theme.
colorscheme molokai 

" Column Settings 
" Create a columns on [80]
let &colorcolumn=80
highlight ColorColumn ctermbg=8 guibg=DarkGrey

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

" 3. Keyboard changes
"
"""""""""""""""""""""""""""""
" 3a. Global, all the time  "
"""""""""""""""""""""""""""""

" Explicityly set the mapleader(s)
let mapleader = "\\"
let maplocalleader = "\\"

" Change backspace behavior
set backspace=indent,eol,start

"""""""""""""""""""""""""""""
" 3c. Normal mode changes   "
"""""""""""""""""""""""""""""
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
"Save and refresh the vimrc
nnoremap <leader>sv :w<cr>:source $MYVIMRC<cr>

nnoremap : ;
nnoremap ; :
""""""""""""""""""""""""""""
" 3c. Insert mode changes  "
""""""""""""""""""""""""""""

" Quick esc using jk, an alternative to switching capslock
inoremap jk <esc>
inoremap kj <esc>

" Ctrl_v in insert mode pastes, use Ctrl-q instead
inoremap <C-v> <C-r>+
"Press esc to automatically close a help window
augroup quickhelpexit
	au!
	autocmd FileType help nnoremap <buffer> <esc> :q<CR>
	autocmd BufLeave help nunmap <buffer> <esc>
augroup END

"Open a new line without entering insert mode
nnoremap <A-o> o<esc>
nnoremap <A-O> O<esc>

" Disable the arrow keys so you can be a super professional vim user
noremap <Left>  <NOP>
noremap <Right> <NOP>
noremap <Up>    <NOP>
noremap <Down>  <NOP>

""""""""""""""""""""""""""""""""
" General Tags Settings
""""""""""""""""""""""""""""""""
" configure tags - add additional tags here or comment out not-used ones
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/sfml
set tags+=~/.vim/tags/box2d

 " build tags of your own project with Ctrl-F12
 map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

"3c.) Tagbar
noremap  <silent> <special> <F12> :TagbarToggle<RETURN> 
noremap! <silent> <special> <F12> :TagbarToggle<RETURN>

" 4.) Plugin Settings
	"4a.) NerdTree settings
	let g:NERDTreeWinPos = "left"

	noremap <leader>nn :NERDTreeToggle<cr>
	noremap <leader>nb :NERDTreeFromBookmark 
	noremap <leader>nf :NERDTreeFind<cr>
	
" OmniCppComplete
 let OmniCpp_NamespaceSearch = 1
 let OmniCpp_GlobalScopeSearch = 1
 let OmniCpp_ShowAccess = 1
 let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
 let OmniCpp_MayCompleteDot = 1 " autocomplete after .
 let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
 let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
 let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
 " automatically open and close the popup menu / preview window
 au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
 set completeopt=menuone,menu,longest,preview
	"4b.) Vim JDE
	let g:vjde_completion_key = "<c-space>"

	"4c.) vim-markdown
	let g:vim_markdown_folding_disabled = 1
