" TOC
" - System Setup
"	* OS Settings
"	* Gobal Settings
"	* File Types
"	* vimdiff Settings
" - Visual Effects
" - Keyboard Re-mappings
" - Plugin Settings
"	* ALE
"	* EasyAlign
"	* EasyMotion
"	* MRU
"	* NERDTree
"		> Main Settings
"		> git-plugin
"	* python-mode
"	* rust-vim
"	* spellrotate
"	* startify
"	* mucomplete
"	* YouCompleteMe
"	* vim-json
"	* vim-opengrok
" - Functions

" - System setup
"	* OS Settings
" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier.
if has('win32') || has('win64')
	set runtimepath=$HOME/.vim,$HOME/.vim/vimfiles,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
	"To ensure NERDTree doesn't start in system32 or something
	"cd $HOME
	let s:MYVIMFOLDER=$HOME . "/.vim"
	" Quick access to VIMRC
	" Set $MYVIMRC to point to this file. Note: This may be a bad idea.
	let $MYVIMRC=s:MYVIMFOLDER . "/.vimrc"
	" source $VIMRUNTIME/mswin.vim
elseif has('unix')
	set ffs=unix,dos,mac
	set runtimepath=$HOME/share/.vim,$HOME/share/.vim/vimfiles,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/share/.vim/after

	cd $HOME
	let s:MYVIMFOLDER="$HOME/shared/.vim"
	
	" Quick access to VIMRC
	" Set $MYVIMRC to point to this file. Note: This may be a bad idea.
	let $MYVIMRC="$HOME/shared/.vim/.vimrc"
endif

" Easy pasting to Windows and XWindows systems"
set clipboard=unnamed

" Setup pathogen"
"execute pathogen#infect()

call plug#begin('~/.vim/bundle')

Plug 'chrisbra/csv.vim'
Plug 'easymotion/vim-easymotion'
Plug 'spolu/dwm.vim'
Plug 'yegappan/mru'
"Plug 'shougo/neocomplete.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'w0rp/ale'
Plug 'majutsushi/tagbar'
Plug 'tyru/transbuffer.vim'
" Plug 'beloglazov/vim-online-thesaurus'
Plug 'adelarsq/vim-matchit'
Plug 'asenac/vim-opengrok'
Plug 'bling/vim-airline'
Plug 'davidhalter/jedi-vim'
Plug 'elzr/vim-json'
Plug 'johngrib/vim-game-code-break'
Plug 'junegunn/vim-easy-align'
Plug 'kshenoy/vim-signature'
Plug 'lifepillar/vim-mucomplete'
Plug 'ludovicchabant/vim-gutentags'
Plug 'mhinz/vim-startify'
Plug 'othree/html5.vim'
Plug 'plasticboy/vim-markdown'
Plug 'racer-rust/vim-racer'
Plug 'rhysd/vim-grammarous'
Plug 'rust-lang/rust.vim'
Plug 'tngreene/vim-obj8'
Plug 'tngreene/vim-quickhelp'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'triglav/vim-visual-increment'
Plug 'tweekmonster/spellrotate.vim'

call plug#end()
filetype off

"Set commandline history length
set history=700

"Stop showing "Press ENTER or type command to continue"
set cmdheight=2

filetype plugin indent on

set fileformat=unix
set fileformats=unix,dos
set encoding=utf-8
let &backupdir=s:MYVIMFOLDER . '/.backup//'
let &directory=s:MYVIMFOLDER . '/.swap//'
let &undodir  =s:MYVIMFOLDER . '/.undo//'

set cm=blowfish2
set tabpagemax=100
set nrformats=alpha,octal,hex
" Activate syntax highlighting.
syntax on 

"Allows one to use dir instead of ls on windows
if has('win32') || has('win64')
	command! -bar Dir !dir
endif

command! Q qall
" 1.c File Type Settings

" 1.c vimdiff Settings
"
set diffopt=filler,vertical
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

" Fold settings
set foldmethod=marker

" 3. Keyboard changes
"
"""""""""""""""""""""""""""""
" 3a. Global, all the time  "
"""""""""""""""""""""""""""""

" Explicitly set the mapleader(s)
let mapleader = "\\"
let maplocalleader = "\\"

" Change backspace behavior
set backspace=indent,eol,start

" Disable going into Ex mode
nnoremap Q <nop>
nnoremap <c-z> <nop>

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

"Replace word under cursor
nnoremap <leader>rw :.,$s/<C-R><C-W>//gc<Left><Left><Left>

"Replace WORD under cursor
nnoremap <leader>rW :.,$s/<C-R><C-A>//gc<Left><Left><Left>

" Thanks bryankennedy's vimrc!
" https://github.com/bryankennedy/vimrc/blob/master/vimrc
" Escape special characters in a string for exact matching.
" This is useful to copying strings from the file to the search tool
" Based on this - http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim
function! EscapeString (string)
  let string=a:string
  " Escape regex characters
  let string = escape(string, '^$.*\/~[]')
  " Escape the line endings
  let string = substitute(string, '\n', '\\n', 'g')
  return string
endfunction

" Get the current visual block for search and replaces
" This function passed the visual block through a string escape function
" Based on this - http://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
function! GetVisual() range
  " Save the current register and clipboard
  let reg_save = getreg('"')
  let regtype_save = getregtype('"')
  let cb_save = &clipboard
  set clipboard&

  " Put the current visual selection in the " register
  normal! ""gvy
  let selection = getreg('"')

  " Put the saved registers and clipboards back
  call setreg('"', reg_save, regtype_save)
  let &clipboard = cb_save

  "Escape any special characters in the selection
  let escaped_selection = EscapeString(selection)

  return escaped_selection
endfunction

" Start the find and replace command across the entire file
vnoremap <leader>rw <Esc>:.,$s/<c-r>=GetVisual()<cr>/

"Swap CTRL-I/O, so older is the leftward key, and newer is on the rightward key
nnoremap <C-I> <C-O>
nnoremap <C-O> <C-I>

"Copy all
nnoremap <leader>all :%y<CR>

"Thanks drchip! http://www.drchip.org/astronaut/vim/index.html#MATH
"Insert Date&time mappings
inoremap <Leader>ymd   <C-R>=strftime("%y%m%d")<CR>
inoremap <Leader>mdy   <C-R>=strftime("%m/%d/%y")<CR>
inoremap <Leader>ndy   <C-R>=strftime("%b %d, %Y")<CR>
inoremap <Leader>hms   <C-R>=strftime("%T")<CR>
inoremap <Leader>ynd   <C-R>=strftime("%Y %b %d")<CR>
com! YMD :norm! i<C-R>=strftime("%y%m%d")<CR>
com! MDY :norm! i<C-R>=strftime("%m/%d/%y")<CR>
com! NDY :norm! i<C-R>=strftime("%b %d, %Y")<CR>
com! HMS :norm! i<C-R>=strftime("%T")<CR>

"Split current line based on character under cursor
"nnoremap <A-J> :exe ":.s/" . getline(".")[col(".")-1] . "/" . getline(".")[col(".")-1] . "\r/cg"<CR>
"""""""""""""""""""""""""""""
" 3b. C/C++ mappings        "
"""""""""""""""""""""""""""""

"Swap between .cpp and .h
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
set tags+=~/.vim/tags/*
" build tags of your own project with Ctrl-F12
" map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

nnoremap <C-]> <Esc>:exe "ptjump " . expand("<cword>")<Esc>
"3c.) Tagbar
noremap  <silent> <special> <F12> :TagbarToggle<RETURN> 
noremap! <silent> <special> <F12> :TagbarToggle<RETURN>

" 4.) Plugin Settings
	"ALE
	let g:ale_enable = 1
	let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
	let g:ale_javascript_eslint_use_global = 1
	let g:ale_linters = {
						\'python':['pylint'],
						\'rust':['rustc']
						\}

	" Enable completion where available.
	let g:ale_completion_enabled = 0

	"4a.) EasyAlign
	" Start interactive EasyAlign in visual mode (e.g. vipga)
	xmap ga <Plug>(EasyAlign)
	" Start interactive EasyAlign for a motion/text object (e.g. gaip)
	nmap ga <Plug>(EasyAlign)

	"4a.) MRU Settings
	command! Mru MRU
	let MRU_File = s:MYVIMFOLDER . "/plugin_dirs/MRU/_vim_mru_files"
	let MRU_Max_Entries = 200

	"4a.) NerdTree settings
	noremap <silent> <F2> :execute 'NERDTreeToggle ' . getcwd()<CR>
	noremap <silent> <F3> :NERDTreeFind<CR>

	let g:NERDTreeWinPos = "left"
	let g:NERDTreeMapActivateNode="<F3>"
	let g:NERDTreeMapPreview="<F4>"
	let g:NERDTreeBookmarksFile=s:MYVIMFOLDER . "/plugin_dirs/NERDTree/.NERDTreeBookmarks"
	let g:NERDTreeDirArrows=0
	let g:NERDTreeMouseMode=2
	let g:NERDTreeShowHidden=1

	"NERDTree git plugin
	let g:NERDTreeIndicatorMapCustom = {
		\ "Modified"  : "✹",
		\ "Staged"    : "✚",
		\ "Untracked" : "✭",
		\ "Renamed"   : "➜",
		\ "Unmerged"  : "═",
		\ "Deleted"   : "✖",
		\ "Dirty"     : "✗",
		\ "Clean"     : "✔︎",
		\ 'Ignored'   : '☒',
		\ "Unknown"   : "?"
		\ }

	"racer-rust/vim-racer

	"rust-vim
	let g:rustc_path = $HOME.".cargo/bin/rustc"
	let g:rustc_makeprg_no_percent = 1
	let g:rust_conceal = 1
	let g:rust_conceal_mod_path = 0
	let g:rust_fold = 1
	let g:ftplugin_rust_source_path = $RUST_SRC_PATH

	"let g:rustfmt_autosave = 1

	"*startify
    let g:startify_disable_at_vimenter = 1

	"*spellrotate
	nmap <silent> zn <Plug>(SpellRotateForward)
	nmap <silent> zp <Plug>(SpellRotateBackward)
	vmap <silent> zn <Plug>(SpellRotateForwardV)
	vmap <silent> zp <Plug>(SpellRotateBackwardV)
 " automatically open and close the popup menu / preview window
 "au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
 "set completeopt=menuone,menu,longest,preview
 
	 "gutentags"
	 let g:gutentags_cache_dir = s:MYVIMFOLDER . "/plugin_dirs/gutentags/cache"
	 let g:gutentags_define_advanced_commands = 1
	 let g:gutentags_enable = 1

	"4b.) Vim JDE
	let g:vjde_completion_key = "<c-space>"

	"4c.) vim-markdown
	let g:vim_markdown_folding_disabled = 1

	"vim-json
	let g:vim_json_syntax_conceal = 0

	
	"vim-mucomplete
	set completeopt+=menuone

	"For automatic completion, you also need to put these in your vimrc:
	inoremap <expr> <c-e> mucomplete#popup_exit("\<c-e>")
	inoremap <expr> <c-y> mucomplete#popup_exit("\<c-y>")
	inoremap <expr>  <cr> mucomplete#popup_exit("\<cr>")

	"and at least one of the following (choose the combination that best fits your taste):
	"set completeopt+=noselect
	set completeopt+=noinsert

	"Other recommended settings:

	set shortmess+=c   " Shut off completion messages
	set belloff+=ctrlg " If Vim beeps during completion

	"No other configuration is needed. Just start pressing <tab> or <s-tab> to complete a word. If you want to enable automatic completion at startup, put
	let g:mucomplete#enable_auto_at_startup = 1
	let g:mucomplete#no_mappings = 1
	"let g:mucomplete#chains = 0
	"vim-jedi"
	let g:jedi#auto_vim_configuration = 0
	let g:jedi#auto_initialization = 1
	
	"vim-opengrok"
	let g:opengrok_jar   = $OPENGROK_HOME . '/lib/opengrok.jar'
	"let g:opengrok_ctags = 'C:\Users\Ted\Desktop\Utilities\Programming\ctags\ctags.exe'
	let g:opengrok_config_file = '/var/opengrok/etc/configuration.xml'

	"vim-markdown"
	autocmd! FileType Markdown setlocal spell
	autocmd! FileType Markdown setlocal expandtab

" 5.) Functions
