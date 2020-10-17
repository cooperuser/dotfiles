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
nnoremap <C-j> "_ciw<C-o>P<ESC>

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
" Set Coc list commands
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
nnoremap <silent> <space>R  :<C-u>CocRestart<CR>
nnoremap <silent> <space>f  :<C-u>GFiles<CR>
nnoremap <silent> <space>F  :<C-u>Files<CR>
nnoremap <silent> <c-f>  :<C-u>GFiles<CR>
nnoremap <silent> <space><space>  :<C-u>CocFix<CR>
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

" Set Coc tab and snippet navigation
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <Tab> pumvisible() ? "\<cr>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()

" Shifting items in a list
nmap <S-h> <Plug>(swap-prev)
nmap <S-l> <Plug>(swap-next)

