""""""""""""""""""""""""""
" Ted's Very Cool vimrc "
""""""""""""""""""""""""""
" Assumes you have a version controlled .vim in %USERPROFILE%,
" using a small _vimrc to source this one. You should also use a Huge build with Python 3
" Use # on [BRACKETS] to jump to that section
" TOC
" - [SS] System Setup
"   * [SS_OS] OS/File System Settings
"   * [SS_PLUG] call plug#begin('~/.vim/bundle')
"   * Gobal Settings
"   * [SS_FT] File Type Settings
"   * [SS_SS] Session Options
"   * vimdiff Settings
" - Visual Effects
" - Keyboard Re-mappings
" - [PL] Plugin Settings
"   * ALE
"   * EasyAlign
"   * EasyMotion
"   * jedi-vim
"   * MRU
"   * NERDTree
"       > Main Settings
"       > git-plugin
"   * rust-vim
"   * spellrotate
"   * startify
"   * vim-markdown
"   * vim-markdown-composer
"   * vim-mucomplete
"   * vim-airline
"   * vim-json
"   * vim-opengrok
" Style Guide
" - Use <CR>, not <Enter> or <Return>
" - Everything should be as alphabetical as possible or match the order listed in the plugin's help

" - [SS] System Setup
"   * [SS_OS] OS/File System Settings
" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier.

if has('win32') || has('win64')
    set runtimepath=$HOME/.vim,$HOME/.vim/vimfiles,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
    let s:MYVIMFOLDER=$HOME . "/.vim"
    "Allows one to use dir instead of ls on windows
    command! -bar Dir !dir
elseif has('unix')
    "This is from a very specific way of mounting %USER_PROFILE% as "share"
    set runtimepath=$HOME/share/.vim,$HOME/share/.vim/vimfiles,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/share/.vim/after
    let s:MYVIMFOLDER=$HOME . "/share/.vim"
endif
let $MYVIMRC  =s:MYVIMFOLDER . "/.vimrc"
let &backupdir=s:MYVIMFOLDER . '/.backup//'
let &directory  =s:MYVIMFOLDER . '/.swap//'
let sessionsdir =s:MYVIMFOLDER . '/sessions//'
let &undodir  =s:MYVIMFOLDER . '/.undo//'

" Easy pasting to Windows and XWindows systems"
set clipboard=unnamed

"   * [SS_PLUG]
" Alphabetical by plugin name over author, whenever possible
call plug#begin('~/.vim/bundle')
Plug 'w0rp/ale'
Plug 'chrisbra/csv.vim'
Plug 'spolu/dwm.vim'
Plug 'othree/html5.vim'
Plug 'davidhalter/jedi-vim'
Plug 'yegappan/mru'

""""""""""""""""""""""""""""""""
" Must keep these in this order!
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
""""""""""""""""""""""""""""""""

Plug 'rust-lang/rust.vim'
Plug 'tweekmonster/spellrotate.vim'
Plug 'mkitt/tabline.vim'
Plug 'majutsushi/tagbar'
Plug 'tyru/transbuffer.vim'
Plug 'tpope/vim-abolish'
Plug 'bling/vim-airline'
Plug 'alvan/vim-closetag'
Plug 'chrisbra/vim-diff-enhanced'
Plug 'junegunn/vim-easy-align'
Plug 'easymotion/vim-easymotion'
Plug 'johngrib/vim-game-code-break'
Plug 'rhysd/vim-grammarous'
Plug 'ludovicchabant/vim-gutentags'
Plug 'elzr/vim-json'
Plug 'plasticboy/vim-markdown'

function! BuildComposer(info)
    if a:info.status != 'unchanged' || a:info.force
        if has('nvim')
            !cargo build --release
        else
            !cargo build --release --no-default-features --features json-rpc
        endif
    endif
endfunction

Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
Plug 'adelarsq/vim-matchit'
Plug 'lifepillar/vim-mucomplete'
" Plug 'beloglazov/vim-online-thesaurus'
Plug 'tngreene/vim-obj8'
Plug 'asenac/vim-opengrok'
Plug 'tngreene/vim-quickhelp'
Plug 'racer-rust/vim-racer'
Plug 'tpope/vim-repeat'
Plug 'kshenoy/vim-signature'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-surround'
Plug 'triglav/vim-visual-increment'

"Plug 'prabirshrestha/asyncomplete.vim'
"Plug 'prabirshrestha/async.vim'
"Plug 'prabirshrestha/vim-lsp'
"Plug 'prabirshrestha/asyncomplete-lsp.vim'
call plug#end()

"Set commandline history length
set history=700

"Stop showing "Press ENTER or type command to continue"
set cmdheight=2

set fileformat=unix
set fileformats=unix,dos
set encoding=utf-8


set cm=blowfish2
set tabpagemax=100
set nrformats=alpha,octal,hex
" Activate syntax highlighting.
syntax on


command! Q qall
" [SS_FT] File Type Settings
" Plugins may provide further customization for file types
filetype plugin indent on

" 2. File Type Settings
augroup VimRCFileTypeCmds
    autocmd!
    "C++
    "Swap between .cpp and .h
    autocmd VimRCFileTypeCmds FileType cpp nnoremap <buffer> <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
    "markdown
    autocmd VimRCFileTypeCmds FileType markdown setlocal spell
augroup END

" C++

" Markdown

" Python

" Rust

" viml

" [SS_SS] Session Options
set sessionoptions+=slash,unix
set sessionoptions-=options

" 1.c vimdiff Settings
"
set diffopt=filler,vertical

" Buffer Settings
command! BufOnly silent! execute "%bd|e#|bd#"

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
set tabstop=4 shiftwidth=4 expandtab

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

" Disable quitting all with ZQ
nnoremap ZQ :bdelete!<CR>

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
nnoremap <silent> <C-Tab> :bnext<CR>
nnoremap <silent> <C-S-Tab> :bprev<CR>

"Replace word under cursor
nnoremap <leader>rw :.,$s/<C-R><C-W>//gc<Left><Left><Left>

"Replace WORD under cursor
nnoremap <leader>rW :.,$s/<C-R><C-A>//gc<Left><Left><Left>

nnoremap <leader>py Oimport sys;sys.path.append(r'C:\Users\Ted\.p2\pool\plugins\org.python.pydev.core_6.5.0.201809011628\pysrc')<cr>import pydevd;pydevd.settrace()<esc>
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

"cd to current file
nnoremap <silent> <leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <silent> <leader>lcd :lcd %:p:h<CR>:pwd<CR>

"""""""""""""""""""""""""""""
" 3b. C/C++ mappings        "
"""""""""""""""""""""""""""""


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

" - [PL] Plugin Settings
    "ALE
    let g:ale_enable = 1
    let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
    let g:ale_javascript_eslint_use_global = 1
    let g:ale_linters = {
                        \'python':['pylint'],
                        \}
    "'rust':['rustc']

    " Enable completion where available.
    let g:ale_completion_enabled = 0

    "asyncomplete
    "imap <c-space> <Plug>(asyncomplete_force_refresh)
    "inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    "inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    "inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
    "autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

    "dwm.vim
    let g:dwm_map_keys = 0
    if !hasmapto('<Plug>DWMFocus')
        "nmap <C-@> <Plug>DWMFocus
        nmap <C-Space> <Plug>DWMFocus
    endif

    if !hasmapto('<Plug>DWMGrowMaster')
        nmap <C-L> <Plug>DWMGrowMaster
    endif
    if !hasmapto('<Plug>DWMShrinkMaster')
        nmap <C-H> <Plug>DWMShrinkMaster
    endif

    "gutentags"
    let g:gutentags_cache_dir = s:MYVIMFOLDER . "/plugin_dirs/gutentags/cache"
    let g:gutentags_define_advanced_commands = 1
    let g:gutentags_enable = 1

    "jedi-vim
    " Bug fix from https://github.com/davidhalter/jedi-vim/issues/870#issuecomment-413937942
    py3 import os; import sys; sys.executable=os.path.join(sys.prefix, 'python.exe')

    "set noshowmode "disable --INSERT--, helps with perforamnce
    let g:jedi#completions_enabled = 1

    let g:jedi#popup_on_dot = 1
    let g:jedi#popup_select_first = 0
    let g:jedi#use_tabs_not_buffers = 0

    let g:jedi#auto_vim_configuration = 0
    let g:jedi#auto_initialization = 1

    "Jedi Commands
    let g:jedi#completions_command = "<C-n>"
    let g:jedi#goto_command = "gd"
    let g:jedi#documentation_command = "K"
    let g:jedi#rename_command = "<leader>rn"
    let g:jedi#usages_command = "<C-G>"

    let g:jedi#show_call_signatures = "0"
    let g:jedi#show_call_signatures_delay = 0
    call jedi#configure_call_signatures()

    "MRU
    command! Mru MRU
    let MRU_File = s:MYVIMFOLDER . "/plugin_dirs/MRU/_vim_mru_files"
    let MRU_Max_Entries = 300

    "NERDTree
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
        \ "Renamed"   : "⇋",
        \ "Unmerged"  : "═",
        \ "Deleted"   : "✖",
        \ "Dirty"     : "✗",
        \ "Clean"     : "✔︎",
        \ 'Ignored'   : '☒',
        \ "Unknown"   : "?"
        \ }

    "racer-rust/vim-racer
    let g:racer_cmd = ""

    "rust-vim
    let g:rustc_path = $HOME.".cargo/bin/rustc"
    let g:rustc_makeprg_no_percent = 1
    let g:rust_conceal = 0
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

    "tagbar
    noremap  <silent> <special> <F12> :TagbarToggle<CR>
    noremap! <silent> <special> <F12> :TagbarToggle<CR>

    "vim-airline
    let g:airline_highlighting_cache = 1
    let g:airline#extensions#ale#enabled = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_mode_map = {
        \ '__' : '-',
        \ 'n'  : 'NORM',
        \ 'i'  : 'INS',
        \ 'R'  : 'REP',
        \ 'c'  : 'COM',
        \ 'v'  : 'VIS',
        \ 'V'  : 'VIS-L',
        \ '' : 'VIS-B',
        \ 's'  : 'SEL',
        \ 'S'  : 'SEL-L',
        \ '' : 'SEL-B',
        \ 't' : 'TERM'
        \ }
    "let g:airline_section_y = '%f'

    "vim-autopep8"
    "autocmd FileType python set equalprg=autopep8\ -

    "vim-easy-align
    " Start interactive EasyAlign in visual mode (e.g. vipga)
    xmap ga <Plug>(EasyAlign)
    " Start interactive EasyAlign for a motion/text object (e.g. gaip)
    nmap ga <Plug>(EasyAlign)

    "vim-json
    let g:vim_json_syntax_conceal = 0

    "vim-lsp
    "if executable('pyls')
        " pip install python-language-server
    "   au User lsp_setup call lsp#register_server({
    "       \ 'name': 'pyls',
    "       \ 'cmd': {server_info->['pyls']},
    "       \ 'whitelist': ['python'],
    "       \ })
    "endif

    "vim-markdown
    let g:vim_markdown_folding_disabled = 1

    autocmd! FileType Markdown setlocal spell
    autocmd! FileType Markdown setlocal expandtab

    "vim-markdown-composer

    "vim-mucomplete
    set completeopt+=menuone

    "and at least one of the following (choose the combination that best fits your taste):
    "set completeopt+=noselect
    set completeopt+=noinsert

    "Other recommended settings:
    set shortmess+=c   " Shut off completion messages
    "set belloff=all
    set belloff+=ctrlg " If Vim beeps during completion

    "No other configuration is needed. Just start pressing <tab> or <s-tab> to complete a word. If you want to enable automatic completion at startup, put
    let g:mucomplete#enable_auto_at_startup = 0
    let g:mucomplete#no_mappings = 1
    "let g:mucomplete#chains = 0

    "vim-opengrok"
    let g:opengrok_jar   = $OPENGROK_HOME . '/lib/opengrok.jar'
    "let g:opengrok_ctags = 'C:\Users\Ted\Desktop\Utilities\Programming\ctags\ctags.exe'
    let g:opengrok_config_file = '/var/opengrok/etc/configuration.xml'

    nnoremap <leader>re :g/addon\|Smart/normal dd<CR>

    "vim-signature
    let g:SignatureMap = {
        \ 'Leader'             :  "m",
        \ 'PlaceNextMark'      :  "m,",
        \ 'ToggleMarkAtLine'   :  "m.",
        \ 'PurgeMarksAtLine'   :  "m-",
        \ 'DeleteMark'         :  "dm",
        \ 'PurgeMarks'         :  "m<Space>",
        \ 'PurgeMarkers'       :  "m<BS>",
        \ 'GotoNextLineAlpha'  :  "']",
        \ 'GotoPrevLineAlpha'  :  "'[",
        \ 'GotoNextSpotAlpha'  :  "`]",
        \ 'GotoPrevSpotAlpha'  :  "`[",
        \ 'GotoNextLineByPos'  :  "]'",
        \ 'GotoPrevLineByPos'  :  "['",
        \ 'GotoNextSpotByPos'  :  "]`",
        \ 'GotoPrevSpotByPos'  :  "[`",
        \ 'GotoNextMarker'     :  "]-",
        \ 'GotoPrevMarker'     :  "[-",
        \ 'GotoNextMarkerAny'  :  "]=",
        \ 'GotoPrevMarkerAny'  :  "[=",
        \ 'ListBufferMarks'    :  "m/",
        \ 'ListBufferMarkers'  :  "m?"
        \ }

" 5.) Functions
