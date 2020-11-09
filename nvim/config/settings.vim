" General settings
set laststatus=2 " Always show statusline
set noshowmode " Hide current mode
set timeoutlen=1000 " Escape
set ttimeoutlen=0
" set virtualedit=onemore " Allow selecting the \n character
set scrolloff=99 " Keep cursor centered on screen
autocmd InsertLeave * normal `^
set incsearch " Set autosearch highlighting
set splitbelow " Set new split to appear below instead of above
" nnoremap <expr> h col(".") == 1 ? "hg$" : "h"
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
" Stop comment continuation on new line
autocmd FileType * set formatoptions-=cro
filetype indent on
filetype plugin on
set autoindent
set smartindent
set noexpandtab
set tabstop=4 shiftwidth=4
set hidden
set shiftround
set selection=exclusive
set showcmd " Show keystrokes
set pumheight=16 " Set max height for autocomplete popup
set pumblend=15 " Set transparency for popup
set winblend=15 " Set transparency for floating window
" set signcolumn=number " Show lint signs in the number column
set signcolumn=yes:1
set list
set listchars=tab:▏\ ,trail:~
set colorcolumn=+0
set nowrap
	
set foldtext=MyFoldText()
function MyFoldText()
	let line = getline(v:foldstart + 1)
	" let sub = substitute(line, '\*\|\*/\|{{{\d\=\|\t* ', '', 'g')
	let sub = substitute(line, '\t* \* ', '', 'g')
	" return v:folddashes . "/** " . sub . " ...*/"
	return "    /** " . sub . " ...*/"
endfunction
set foldcolumn=0
set fillchars=fold:\ " Remove dots after fold

" Trim whitespace on write
fun! TrimWhitespace()
	let l:save = winsaveview()
	keeppatterns %s/\s\+$//e
	call winrestview(l:save)
endfun
" autocmd BufWritePre * :call TrimWhitespace()

autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd User CocDiagnosticChange redrawtabline

