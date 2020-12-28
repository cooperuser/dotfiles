" Keybinds

" Movement
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

inoremap <C-c> <ESC>

" Remap change to assign register
nnoremap c "_c
nnoremap C "_C
vnoremap c "_c

" Stop the terrible Q mistake
nnoremap Q <Space>

" Remap ctrl-j to replace word with clipboard
nnoremap <C-p> "_ciw<C-o>P<ESC>

" Set switch.vim key
nnoremap <silent> <C-s> :Switch<CR>

" Allow scrolling with scroll wheel
set mouse=a

" Shift lines in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Show fzf in current directory with ctrl-t
noremap <C-t> :Files<CR>

nmap <silent> <space>k :lua vim.lsp.diagnostic.goto_prev()<CR>
nmap <silent> <space>j :lua vim.lsp.diagnostic.goto_next()<CR>

" Set easy-align keybinds
nmap <space>ga <Plug>(EasyAlign)
xmap <space>ga <Plug>(EasyAlign)

nnoremap <silent> <space>b  :<C-u>ene<CR>
nnoremap <silent> <space>B  :<C-u>bd<CR>

nnoremap <silent> <space>lc :VimtexCompileSS<CR>
nnoremap <silent> <space>lv :VimtexView<CR>

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

nnoremap <silent> <c-j> :<C-u>bprevious<CR>
nnoremap <silent> <c-k> :<C-u>bnext<CR>

" autocmd FileType json setlocal commentstring=//\ %s
" Fugitive preferences autocmd VimEnter * noremap <silent> gs :G<CR>

nmap <silent> <space>m :w<CR>:make<CR>
nmap <silent> <space>Q :so ~/.config/nvim/init.vim<CR>
nmap <silent> <space>q :call VimuxInterruptRunner()<CR>
nmap <silent> <space>vc :call VimuxCloseRunner()<CR>
nmap <silent> <space>vo :call VimuxOpenRunner()<CR>
nmap <silent> <space>vo :call VimuxOpenRunner()<CR>
nmap <silent> <space>p :LuaTreeToggle<CR>
nmap <silent> <space>z zf%
nmap <silent> <space>/ :nohlsearch<CR>

inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-h> <left>
inoremap <C-l> <right>

" Shifting items in a list
nmap <S-h> <Plug>(swap-prev)
nmap <S-l> <Plug>(swap-next)

" Telescope
nnoremap <Space>f <cmd>lua require'telescope.builtin'.git_files({windblend = 10})<CR>
nnoremap <Space>F <cmd>lua require'telescope.builtin'.find_files({
	\ file_ignore_patterns = {"node_modules/*", ".git/*"}
  \ })<CR>

" Duplicate line and comment
nmap gcn "0yygcc"0p
nmap gcp "0yygcc"0P

nnoremap <silent> <space>PI :PlugInstall<CR>
nnoremap <silent> <space>PU :PlugUpdate<CR>
nnoremap <silent> <space>PC :PlugClean<CR>

nnoremap <C-z> <C-^>
inoremap <C-z> <C-o><C-^>
tnoremap <C-z> <C-\><C-n><C-^>
tnoremap <C-w> <C-\><C-n><C-w>
tnoremap <C-w><C-w> <C-w>
tnoremap <C-u> <C-\><C-n><C-u>

nnoremap <c-i> <Cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <space><space> <Cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <C-space> <Cmd>lua vim.lsp.buf.code_action()<CR>
inoremap <C-space> <Cmd>lua vim.lsp.buf.code_action()<CR>

