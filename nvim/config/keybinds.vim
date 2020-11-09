" Keybinds

" Movement
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
inoremap <C-h> <left>
inoremap <C-l> <right>
inoremap <C-j> <down>
inoremap <C-k> <up>

inoremap <C-c> <ESC>

" Remap change to assign register
nnoremap c "_c
vnoremap c "_c

" Stop the terrible Q mistake
nnoremap Q <Space>

" Remap ctrl-j to replace word with clipboard
nnoremap <C-p> "_ciw<C-o>P<ESC>

" Set switch.vim key
nnoremap <silent> <C-s> :Switch<CR>

" Allow scrolling with scroll wheel
set mouse=a

" nnoremap <silent> zz za
" nnoremap <silent> zZ 0zf%

" Shift lines in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Show fzf in current directory with ctrl-t
noremap <C-t> :Files<CR>

" Set Coc diagnostic keybinds
nmap <silent> g[ <Plug>(coc-diagnostic-prev)
nmap <silent> g] <Plug>(coc-diagnostic-next)
" nmap <silent> ; <Plug>(coc-diagnostic-next)
nmap <silent> <space>k <Plug>(coc-diagnostic-prev)
nmap <silent> <space>j <Plug>(coc-diagnostic-next)
nmap <silent> <space>gd <Plug>(coc-definition)
nmap <silent> <space>gi <Plug>(coc-implementation)
" nmap <silent> <space>f <Plug>(coc-fix-current)
" Set Coc format keybinds
nmap <leader>f  <Plug>(coc-format-selected)
xmap <leader>f  <Plug>(coc-format-selected)
" Set easy-align keybinds
nmap <space>ga <Plug>(EasyAlign)
xmap <space>ga <Plug>(EasyAlign)
" Set Coc list commands
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent> <space>e  :<C-u>CocList marketplace<cr>
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
nnoremap <silent> <space>R  :<C-u>CocRestart<CR>
nnoremap <silent> <space>f  :<C-u>GFiles<CR>
nnoremap <silent> <space>F  :<C-u>Files<CR>
nnoremap <silent> <space>b  :<C-u>ene<CR>
nnoremap <silent> <space>B  :<C-u>bd<CR>
nnoremap <silent> <space><space>  :<C-u>BufferPick<CR>
nnoremap <silent> <cr> :<C-u>BufferPick<CR>
nnoremap <silent> <c-f>  :<C-u>GFiles<CR>
nnoremap <silent> <space><cr>  :<C-u>CocFix<CR>
nnoremap <silent> <space>gg  :<C-u>CocCommand git.chunkInfo<CR>

let g:shg = 0
function! ToggleShowHighlightGroup()
	if g:shg == 1
		let g:shg = 0
	else
		let g:shg = 1
	end
endfunction
function! ShowHighlightGroup()
	if g:shg == 1
		TSHighlightCapturesUnderCursor
	end
endfunction
autocmd CursorHold * call ShowHighlightGroup()
nnoremap <silent> <space>gh :call ToggleShowHighlightGroup()<CR>

" nnoremap <silent> <space>h  :<C-u>BufferPrevious<CR>
" nnoremap <silent> <space>l  :<C-u>BufferNext<CR>

nnoremap <silent> <space>h  :<C-u>bprevious<CR>
nnoremap <silent> <space>l  :<C-u>bnext<CR>
nnoremap <silent> <c-j> :<C-u>bprevious<CR>
nnoremap <silent> <c-k> :<C-u>bnext<CR>

" autocmd FileType json setlocal commentstring=//\ %s
" Fugitive preferences autocmd VimEnter * noremap <silent> gs :G<CR>

nmap <silent> <space>r :w<CR>:call VimuxRunCommand("make")<CR>
nmap <silent> <space>m :w<CR>:make<CR>
nmap <silent> <space>Q :so ~/.config/nvim/init.vim<CR>
nmap <silent> <space>q :call VimuxInterruptRunner()<CR>
nmap <silent> <space>vc :call VimuxCloseRunner()<CR>
nmap <silent> <space>vo :call VimuxOpenRunner()<CR>
nmap <silent> <space>vo :call VimuxOpenRunner()<CR>
nmap <silent> <space>p :Glow<CR>
nmap <silent> <space>z zf%
nmap <silent> <space>t :tabnew<CR>
nmap <silent> <space>T :tabclose<CR>
nmap <silent> <space>/ :nohlsearch<CR>

" Set Coc tab and snippet navigation
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <c-space> coc#refresh()

inoremap <silent><expr> <Tab> pumvisible() ? coc#_select_confirm() : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
inoremap <silent><expr> <c-l> pumvisible() ? coc#_select_confirm() . "." : "<right>"
" inoremap <silent><expr> <c-h> pumvisible() ? "<c-o>dv2F.." : "<left>"
inoremap <silent><expr> <c-h> pumvisible() ? "<c-o>dv2b." : "<left>"
" inoremap <silent><expr> . pumvisible() ? "\<cr>." : "."
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Shifting items in a list
nmap <S-h> <Plug>(swap-prev)
nmap <S-l> <Plug>(swap-next)

" Floaterm
noremap <silent> <C-\> :FloatermToggle<CR>
tnoremap <silent> <C-\> <C-\><C-n>:FloatermToggle<CR>

" Telescope
nnoremap <Space>f <cmd>lua require'telescope.builtin'.git_files({windblend = 10})<CR>
nnoremap <Space>F <cmd>lua require'telescope.builtin'.find_files({windblend = 10})<CR>

