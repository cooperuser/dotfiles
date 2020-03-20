set nocompatible

set rtp+=~/.fzf

call plug#begin('~/.config/nvim/plugged') " Begin vim-plug

" Main plugins
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
" Plug 'Shougo/deoplete.nvim', { 'do': 'UpdateRemotePlugins' }
" Plug 'Shougo/neco-vim'
Plug 'AndrewRadev/switch.vim'

" Syntax Plugins
Plug 'dag/vim-fish'

" Colorschemes
Plug 'cooper-anderson/tjay.vim'
Plug 'dracula/vim'

call plug#end() " Initialize vim-plug system and plugins

" General settings
set laststatus=2 " Always show statusline
set noshowmode " Hide current mode
set timeoutlen=1000 " Escape
set ttimeoutlen=0
set virtualedit=onemore " Allow selecting the \n character
set scrolloff=3 " Keep the cursor away from the edges
autocmd InsertLeave * normal `^ " Stop the cursor from moving when leaving insert
set incsearch " Set autosearch highlighting
set splitbelow " Set new split to appear below instead of above
nnoremap <expr> h col(".") == 1 ? "hg$" : "h" " Hacky line moving fix
set path+=** " Set :find and :b autocomplete
set wildmenu
set cursorline " Show the line the cursor is on
set number " Show the line numbers
set whichwrap+=<,>,h,l,[,] " h and l wrap lines
set vb t_vb=
set clipboard=unnamed " Clipboard settings
set backspace=2 " Backspace settings
filetype indent on
filetype plugin on
autocmd VimEnter * set autoindent smartindent noexpandtab tabstop=4 shiftwidth=4 shiftround
set selection=exclusive
set showcmd " Show keystrokes
set pumheight=10 " Set max height for autocomplete popup
noremap <C-t> :Files<CR> " Show fzf in current directory with ctrl-t
" Add more fzf settings

" Key rebinds
map <up> <nop> " Disable arrow keys in normal mode
map <down> <nop>
map <left> <nop>
map <right> <nop>
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>l
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
" Remap change to not copy
nnoremap c "_c
vnoremap c "_c
nnoremap Q <Space>
" Remap ctrl-j to replace word with clipboard
nnoremap <C-j> "_ciw<C-o>P<ESC>
" Set switch.vim key
nnoremap <silent> <C-s> :Switch<CR>
" Allow scrolling with scroll wheel
set mouse=a

" deoplete configurations
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0

" Airline settings with quick toggle
if 1
	let useChevrons = 1
	let g:airline_powerline_fonts = useChevrons
	let g:airline_theme='powerliner'
	let g:airline_skip_empty_sections = 1
	call airline#parts#define_raw('percent', '%3p%%')
	call airline#parts#define_minwidth('percent', 1)
	let g:airline_section_x = airline#section#create_right(["filetype", "%{getfsize(expand(@%))}"])
	let g:airline_section_y = airline#section#create(["percent"])
	let g:airline_section_z = airline#section#create(["linenr", ":%2v"])
	if useChevrons == 1
		let g:airline_symbols.linenr = ''
	else
		let g:airline_symbols.linenr = ""
	endif
endif

" Rainbow Brackets enable
let g:rainbow_active = 1

" Set up custom switch.vim toggles
let g:switch_custom_definitions = [['0', '1'], ["on", "off"], ["#t", "#f"]]

syntax on
set background=dark
colorscheme tjay

