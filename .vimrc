" TOC
" 1.) System Setup
" 2.) Visual Effects
" 3.) Keyboard Re-mappings
" 4.) Plugin Settings
"	a. MRU
"	b. NERDTree
"	c. NeoComplete
"	d. YouCompleteMe
" 5.) Functions

" 1.) System setup
" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier.
if has('win32') || has('win64')
	set runtimepath=$HOME/.vim,$HOME/.vim/vimfiles,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
	"To ensure NERDTree doesn't start in system32 or something
	cd $HOME
	"let $MYVIMFOLDER="$HOME/.vim"
	" Quick access to VIMRC
	" Set $MYVIMRC to point to this file. Note: This may be a bad idea.
	let $MYVIMRC="$HOME/.vim/.vimrc"
	" source $VIMRUNTIME/mswin.vim
elseif has('unix')
	set ffs=unix,dos,mac
	set runtimepath=$HOME/share/.vim,$HOME/share/.vim/vimfiles,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/share/.vim/after

	cd $HOME
	"let $MYVIMFOLDER="$HOME/shared/.vim"

	" Quick access to VIMRC
	" Set $MYVIMRC to point to this file. Note: This may be a bad idea.
	let $MYVIMRC="$HOME/shared/.vim/.vimrc"
endif

" Easy pasting to Windows and XWindows systems"
set clipboard=unnamed

" Setup pathogen"
execute pathogen#infect()
filetype off

"Stop showing "Press ENTER or type command to continue"
set cmdheight=2

filetype plugin indent on

set tabpagemax=100
set nrformats=alpha,octal,hex
" Activate syntax highlighting.
syntax on 

" 2.) Visual Effects
" Set a nice theme.
colorscheme molokai 

" Column Settings 
" Create a columns on [80]
let &colorcolumn=120
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

" Move lines up and down
nnoremap <C-J> :m .+1<CR>==
nnoremap <C-K> :m .-2<CR>==
inoremap <C-J> <Esc>:m .+1<CR>==gi
inoremap <C-K> <Esc>:m .-2<CR>==gi
vnoremap <C-J> :m '>+1<CR>gv=gv
vnoremap <C-K> :m '<-2<CR>gv=gv

" Switch ; and :
nnoremap : ;
nnoremap ; :

vnoremap : ;
vnoremap ; :

"Switch between tabs
nnoremap <silent> <C-Tab> :tabnext<CR>
nnoremap <silent> <C-S-Tab> :tabprev<CR>
"""""""""""""""""""""""""""""
" 3b. C/C++ mappings        "
"""""""""""""""""""""""""""""
nnoremap <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

"""""""""""""""""""""""""""""
" 3c. Normal mode changes   "
"""""""""""""""""""""""""""""
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
"Save and refresh the vimrc
nnoremap <leader>sv :w<cr>:source $MYVIMRC<cr>
nnoremap <special><C-W><C-Q> <C-W><C-C>

nnoremap dd "_dd

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

" Open a new line without entering insert mode
nnoremap <A-o> o<esc>
nnoremap <A-O> O<esc>

" Stop that annoying auto comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Disable the arrow keys so you can be a super professional vim user
noremap <Left>  <NOP>
noremap <Right> <NOP>
noremap <Up>    <NOP>
noremap <Down>  <NOP>

""""""""""""""""""""""""""""""""
" General Tags Settings
""""""""""""""""""""""""""""""""
" configure tags - add additional tags here or comment out not-used ones
" set tags+=~/.vim/tags/cpp
" set tags+=~/.vim/tags/sfml
" set tags+=~/.vim/tags/box2d
" set tags+=~/.vim/tags/xptools
" build tags of your own project with Ctrl-F12
" map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

nnoremap <C-]> <Esc>:exe "ptjump " . expand("<cword>")<Esc>
"3c.) Tagbar
noremap  <silent> <special> <F12> :TagbarToggle<RETURN> 
noremap! <silent> <special> <F12> :TagbarToggle<RETURN>

" 4.) Plugin Settings
	"4a.) MRU Settings
	let MRU_File = "C:\\Users\\ted\\.vim\\plugin_dirs\\MRU\\_vim_mru_files"
	"/.vim/plugin_dirs/MRU/_vim_mru_files"

	"4a.) NerdTree settings
	noremap <silent> <F2> :execute 'NERDTreeToggle ' . getcwd()<CR>
	noremap <silent> <F3> :NERDTreeFind<CR>

	let g:NERDTreeWinPos = "left"
	let g:NERDTreeMapActivateNode="<F3>"
	let g:NERDTreeMapPreview="<F4>"
	"let g:NERDTreeBookmarksFile="$MYVIMFOLDER/plugin_dirs/NERDTree/.NERDTreeBookmarks"
	let g:NERDTreeDirArrows=0
	let g:NERDTreeMouseMode=2
	let g:NERDTreeShowHidden=1

	"4b.) NeoComplete settings
	"let g:neocomplete#data_directory = "$MYVIMFOLDER/plugin_dirs/neocomplete"

	" Disable AutoComplPop.
	let g:acp_enableAtStartup = 0
	" Use neocomplete.
	let g:neocomplete#enable_at_startup = 1
	" Use smartcase.
	let g:neocomplete#enable_smart_case = 1
	" Set minimum syntax keyword length.
	let g:neocomplete#sources#syntax#min_keyword_length = 3
	let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

	" Define dictionary.
	let g:neocomplete#sources#dictionary#dictionaries = {
		\ 'default' : '',
		\ 'vimshell' : $HOME.'/.vimshell_hist',
		\ 'scheme' : $HOME.'/.gosh_completions'
			\ }

	" Define keyword.
	if !exists('g:neocomplete#keyword_patterns')
		let g:neocomplete#keyword_patterns = {}
	endif
	let g:neocomplete#keyword_patterns['default'] = '\h\w*'

	" Plugin key-mappings.
	inoremap <expr><C-g>     neocomplete#undo_completion()
	inoremap <expr><C-l>     neocomplete#complete_common_string()

	" Recommended key-mappings.
	" <CR>: close popup and save indent.
	inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
	function! s:my_cr_function()
	  "return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
	  " For no inserting <CR> key.
	  return pumvisible() ? "\<C-y>" : "\<CR>"
	endfunction
	" <TAB>: completion.
	inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
	" <C-h>, <BS>: close popup and delete backword char.
	"inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
	inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
	" Close popup by <Space>.
	"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

	" AutoComplPop like behavior.
	"let g:neocomplete#enable_auto_select = 1

	" Shell like behavior(not recommended).
	"set completeopt+=longest
	"let g:neocomplete#enable_auto_select = 1
	"let g:neocomplete#disable_auto_complete = 1
	"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

	" Enable omni completion.
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

	" Enable heavy omni completion.
	if !exists('g:neocomplete#sources#omni#input_patterns')
	  let g:neocomplete#sources#omni#input_patterns = {}
	endif
	"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
	let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
	let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

	" For perlomni.vim setting.
	" https://github.com/c9s/perlomni.vim
	"let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

 " automatically open and close the popup menu / preview window
 au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
 set completeopt=menuone,menu,longest,preview
 
	"4b.) Vim JDE
	let g:vjde_completion_key = "<c-space>"

	"4c.) vim-markdown
	let g:vim_markdown_folding_disabled = 1

	"4d.) YouCompleteME
	"if(!(has('win32') || has('win64')))
	  
	"endif
" 5.) Functions
