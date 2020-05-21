set nocompatible

set rtp+=~/.install/fzf

call plug#begin('~/.config/nvim/plugged') " Begin vim-plug

" Main plugins
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'AndrewRadev/switch.vim'

" Completion plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Syntax plugins
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
set scrolloff=99 " Keep cursor centered on screen
autocmd InsertLeave * normal `^
set incsearch " Set autosearch highlighting
set splitbelow " Set new split to appear below instead of above
nnoremap <expr> h col(".") == 1 ? "hg$" : "h"
set path+=** " Set :find and :b autocomplete
set wildmenu
set cursorline " Show the line the cursor is on
set number " Show the line numbers
set relativenumber
nnoremap <space>n :set relativenumber!<cr>
set whichwrap+=<,>,h,l,[,] " h and l wrap lines
set vb t_vb=
set clipboard=unnamed " Clipboard settings
set backspace=2 " Backspace settings
set formatoptions-=cro
filetype indent on
filetype plugin on
set autoindent
set smartindent
set noexpandtab
set tabstop=4 shiftwidth=4
set shiftround
set selection=exclusive
set showcmd " Show keystrokes
set pumheight=10 " Set max height for autocomplete popup
" Show fzf in current directory with ctrl-t
noremap <C-t> :Files<CR>
" Add more fzf settings

" Key rebinds
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
inoremap <C-h> <left>
inoremap <C-l> <right>
inoremap <C-j> <down>
inoremap <C-k> <up>
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
nnoremap <silent> zz za
nnoremap <silent> zZ 0zf%
" Shift lines in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Airline settings with quick toggle
if 1
	" let useChevrons = 1
	" let g:airline_powerline_fonts = useChevrons
	let g:airline_theme='powerliner'
	let g:airline_skip_empty_sections = 1
	let g:airline#extentions#coc#enabled = 1
	call airline#parts#define_raw('percent', '%3p%%')
	call airline#parts#define_minwidth('percent', 1)
	let g:airline_section_x = airline#section#create_right(["filetype", "%{getfsize(expand(@%))}"])
	let g:airline_section_y = airline#section#create(["percent"])
	let g:airline_section_z = airline#section#create(["linenr", ":%2v"])
	let g:airline_symbols.linenr = ""
	let g:airline_symbols.branch = '⎇'
endif

" Set Coc tab and snippet navigation
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <Tab> pumvisible() ? "\<cr>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
let g:coc_snippet_next = "<C-l>"
let g:coc_snippet_prev = "<C-h>"
" Set Coc diagnostic keybinds
nmap <silent> g[ <Plug>(coc-diagnostic-prev)
nmap <silent> g] <Plug>(coc-diagnostic-next)
nmap <silent> ; <Plug>(coc-diagnostic-next)
nmap <silent> <space>k <Plug>(coc-diagnostic-prev)
nmap <silent> <space>j <Plug>(coc-diagnostic-next)
nmap <silent> <space>k <Plug>(coc-definition)
" nmap <silent> <space>r <Plug>(coc-references)
" nmap <silent> <space>f <Plug>(coc-fix-current)
" Set Coc format keybinds
nmap <leader>f  <Plug>(coc-format-selected)
xmap <leader>f  <Plug>(coc-format-selected)
" Set Coc list commands
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
nnoremap <silent> <space>r  :<C-u>CocRestart<CR>
nnoremap <silent> <space><space>  :<C-u>CocFix<CR>
autocmd FileType json syntax match Comment +\/\/.\+$+
" autocmd FileType json setlocal commentstring=//\ %s
" Fugitive preferences
autocmd VimEnter * noremap <silent> gs :G<CR>

" Rainbow Brackets enable
let g:rainbow_active = 1

" Set up custom switch.vim toggles
let g:switch_custom_definitions = [['0', '1'], ["on", "off"], ["#t", "#f"]]

" Trim whitespace on write
fun! TrimWhitespace()
	let l:save = winsaveview()
	keeppatterns %s/\s\+$//e
	call winrestview(l:save)
endfun

autocmd BufWritePre * :call TrimWhitespace()

syntax on
set background=dark
colorscheme tjay

