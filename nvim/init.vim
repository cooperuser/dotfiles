set nocompatible

set rtp+=~/.fzf

let useAirline = has("nvim")

" Begin vim-plug with set directory
call plug#begin('~/.config/nvim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'benmills/vimux'
Plug 'Valloric/ListToggle'
Plug 'lilydjwg/colorizer'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf.vim'
Plug 'vim-scripts/npm.vim'
Plug 'junegunn/vim-xmark', { 'do': 'make' }
Plug 'machakann/vim-highlightedyank'
Plug 'Townk/vim-autoclose'
" Plug 'jiangmiao/auto-pairs'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'mitsuse/autocomplete-swift'
Plug 'zchee/deoplete-jedi'
Plug 'Shougo/neco-vim'
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx', 'screeps'] }
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx', 'screeps'] }
Plug 'artur-shaik/vim-javacomplete2', { 'for': ['java'] }
Plug 'racer-rust/vim-racer', { 'for': ['rust'] }
if useAirline == 1 || has("nvim")
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
else
" Plug 'Valloric/YouCompleteMe', { 'for': ['python', 'javascript', 'cs'] }
" Plug 'jerrymarino/iCompleteMe', { 'for': ['swift'] }
endif
Plug 'mklabs/grunt.vim'
Plug 'justinmk/vim-gtfo'
Plug 'bfredl/nvim-miniyank'
Plug 'jeetsukumaran/vim-indentwise'
Plug 'neomake/neomake'
Plug 'AndrewRadev/switch.vim'
" Plug 'timonv/vim-cargo'

" Syntax Plugins
Plug 'pangloss/vim-javascript'
Plug 'vim-scripts/brainfuck-syntax'
Plug 'keith/swift.vim'

" Colorschemes
Plug 'aliou/moriarty.vim'
Plug 'tomasiser/vim-code-dark'
Plug 'josuegaleas/jay'
Plug 'dracula/vim'
Plug 'sjl/badwolf'
Plug 'cooper-anderson/tjay.vim'

" Initialize vim-plug system
call plug#end()

set encoding=utf-8
set termencoding=utf-8
set fillchars+=stl:\ ,stlnc:\
set listchars=tab:│\ ,trail:•

" if 0
" 	if empty($TMUX)
" 		set term=xterm-256color
" 	else
" 		set term=screen-256color
" 	endif
" 	set t_Co=256
" 	set t_ut=
" endif

if has("gui_running")
	let s:uname = system("uname")
	if s:uname == "Darwin\n"
		set guifont=Hasklig:h13
	endif
endif

autocmd BufNewFile,BufRead */screeps/src/*.js :set syntax=screeps
autocmd FileType java setlocal omnifunc=javacomplete#Complete
" autocmd BufWrite */screeps/src/*.js :silent exec "!(grunt &) > /dev/null"

" Load Powerline or Airline
if useAirline == 1
	let g:airline_powerline_fonts = 1
	let g:airline_theme='powerliner'
	let g:airline_skip_empty_sections = 1
	call airline#parts#define_raw('percent', '%3p%%')
	call airline#parts#define_minwidth('percent', 1)
	let g:airline_section_x = airline#section#create_right(["filetype", "%{getfsize(expand(@%))}"])
	let g:airline_section_y = airline#section#create(['percent'])
	let g:airline_section_z = airline#section#create(['linenr', ':%2v'])
	let g:airline_symbols.linenr = ''
	" call g:airline#extensions#tabline#autoshow#on()
	" let g:airline#extensions#tabline#enabled = 1
else
	set rtp+=/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages/powerline/bindings/vim
endif

" set omnifunc=syntaxcomplete#Complete
" Always show statusline
set laststatus=2
" Hide current mode
set noshowmode
" Something about hitting escape?
set timeoutlen=1000
set ttimeoutlen=0
" Allow selecting \n character
set virtualedit=onemore
" Keep cursor away from top and bottom edges
set scrolloff=1
" No moving the cursor when leaving insert mode
autocmd InsertLeave * normal `^
" Set autosearch highlighting
set incsearch
" Set new split to appear below instead of above
set splitbelow
" Who's 'fix' to use when pressing 'h' at the beginning of a line
let lineFix = 1
" function Test()
" 	if col(".") == 1
" 		norm hg$
" 	else
" 		norm h
" 	endif
" endfunction
if lineFix == 1 " Cooper
	nnoremap <expr> h col(".") == 1 ? "hg$" : "h"
elseif lineFix == 2 " Grady
	nnoremap <expr> <End> col([line("."), "$"]) == col(".") ? "<Esc>" : (col	([line("."), "$"]) - col(".")) . "l"
	nmap $ <End>
	" noremap <F99> h
	nmap <expr> h col(".") == 1 && col([line(".") - 1, "$"]) > 1 ? "k<End>" : "h"
	nmap <Backspace> h
endif

" miniyank block paste fix
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)

" Vimux control commands
nnoremap <F5> :w<CR>:call VimuxOpenRunner()<CR>:call VimuxRunCommand("clear; ./" . bufname("."))<CR>:<BACKSPACE>
autocmd Filetype javascript,html,css :nnoremap <F5> :call VimuxOpenRunner()<CR>:call VimuxRunCommand("clear; npm start")<CR>:<BACKSPACE>
autocmd Filetype rust :nnoremap <F5> :call VimuxOpenRunner()<CR>:call VimuxRunCommand("clear; cargo run -q")<CR>:<BACKSPACE>
nnoremap <F6> :call VimuxCloseRunner()<CR>
" nnoremap <F5> <ESC>:w<CR>:silent exec "!(grunt) > /dev/null"<CR>:echo "Grunt Finished."<CR>

command! -nargs=1 Silent
\   execute 'silent !' . <q-args>
\ | execute 'redraw!'

" Set :find and :b autocompelte
set path+=**
set wildmenu

" if (empty($TMUX)) && 0
"   if (has("nvim"))
"     let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"   endif
"   if (has("termguicolors"))
"     set termguicolors
"   endif
" endif

set cursorline
set number
set whichwrap+=<,>,h,l,[,]
set vb t_vb=
set clipboard=unnamed
set backspace=2

set mouse=a
filetype indent on
filetype plugin on
autocmd VimEnter * set autoindent smartindent noexpandtab tabstop=4 shiftwidth=4 shiftround
set selection=exclusive
" Disable arrow keys in normal mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
" Disable Arrow keys in Insert mode
" imap <up> <nop>
" imap <down> <nop>
" imap <left> <nop>
" imap <right> <nop>
" Allow Ctrl-hjlk to move in insert mode
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>a
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-^> <C-o><C-^>
" Highlight search results
set hlsearch
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
noremap <silent> <F10> :NERDTreeToggle<Bar>:echo<CR>
" Make NERDTree open on directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" Stop copy on change motion
nnoremap c "_c
vnoremap c "_c
" Show keystrokes
set showcmd
" Set max height for autocomplete popup
set pumheight=10
" Set ListToggle height
let g:lt_height = 4
" Show fzf in current directory with ctrl-t
noremap <C-t> :Files<CR>
" Show fzf preview
let g:fzf_files_options = '--preview "(coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'
" Hide npm output
let g:npm_background = 1
" Remove MacVim scrollbars, if I ever decide to use MacVim
set guioptions=
" Setup vim-highlightedyank options
map y <Plug>(highlightedyank)
let g:highlightedyank_highlight_duration = 250
" Hide NERDTree help line
let NERDTreeMinimalUI=1
" Use deoplete.
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
let g:deoplete#sources = {}
let g:deoplete#sources['javascript.jsx'] = ['file', 'ultisnips', 'ternjs']
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']
" Jump to the first placeholder by typing `<C-k>`.
autocmd FileType swift imap <buffer> <C-k> <Plug>(autocomplete_swift_jump_to_placeholder)
" Stop deoplete from showing documentation
	" set completeopt-=preview
" Set Jedi to use python 3
let g:deoplete#sources#jedi#python_path='/Users/cooper-anderson/.config/pyenv/shims/python' " /Library/Frameworks/Python.framework/Versions/3.6/bin/python3
" Set Rust configurations
set hidden
au FileType rust nmap gd <Plug>(rust-def-split)
au FileType rust nmap <leader>gd <Plug>(rust-doc)
" Full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 1s; no delay when writing).
call neomake#configure#automake('nrwi', 500)
let g:neomake_error_sign = {'text': 'E','texthl': 'ErrorMsg'}
let g:neomake_warning_sign = {'text': '!','texthl': 'WarningMsg'}
let g:neomake_message_sign = {'text': '>','texthl': 'Normal'}
let g:neomake_info_sign = {'text': 'i','texthl': 'MoreMsg'}


" Switch iTerm Cursor mode in Insert mode
let &t_SI = "\<Esc>]1337;CursorShape=1\x7"
let &t_EI = "\<Esc>]1337;CursorShape=2\x7"
" Set nvim cursor options
set guicursor=n-c-ci:hor20-iCursor-blinkwait1-blinkon250-blinkoff250,i:ver20-iCursor-blinkwait1-blinkon250-blinkoff250


syntax on
set background=dark
colorscheme tjay

