set nocompatible

source ~/.config/nvim/config/plugins.vim
source ~/.config/nvim/config/settings.vim
source ~/.config/nvim/config/keybinds.vim

source ~/.config/nvim/config/statusline.vim
source ~/.config/nvim/config/bufline.vim
source ~/.config/nvim/config/terminal.vim

luafile ~/.config/nvim/lua/configuration.lua
set completeopt=menuone,noinsert
set shortmess+=c

nnoremap <space>gr :lua Telescope.lsp_references{}<CR>
nnoremap <space>go :lua Telescope.lsp_document_symbols{}<CR>
nnoremap <space>i :lua vim.lsp.buf.hover{}<CR>
inoremap <C-space> <C-n><C-p>
" inoremap <expr> ( pumvisible() ? "\<C-y>()<left>" : "\("
" imap <expr> <Tab> pumvisible() ? "\<C-y>" : "\<tab>"
imap <C-x><C-f> <Plug>(completion_next_source)
nnoremap <space>gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <space>gD <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <space>gf <cmd>lua vim.lsp.buf.references()<CR>
let g:completion_trigger_on_delete = 1
let g:completion_enable_snippet = 'UltiSnips'
let g:UltiSnipsJumpForwardTrigger="<C-l>"
let g:UltiSnipsJumpBackwardTrigger="<C-h>"
" let g:completion_enable_auto_paren = 1
" let g:completion_confirm_key = "\<tab>"
command! -nargs=0 W w
command! -nargs=0 Wq wq

set cc=80

" setlocal spell
" set spelllang=en_us
" inoremap <C-f> <c-g>u<Esc>[s1z=`]a<c-g>u

" let g:completion_customize_lsp_label = {'Text' : '...', 'Function': '...'}

syntax on
set termguicolors
colorscheme glowbeam

let g:vimtex_indent_lists = ['itemize', 'description', 'enumerate', 'thebibliography', 'steps']
let g:completion_matching_strategy_list = ['fuzzy', 'exact', 'substring', 'all']
let g:completion_sorting = "length"

lua <<EOF
require'nvim-web-devicons'.setup {
 default = true;
}
EOF

function! StartVimtex(n)
	let b:vimtex_main = a:n . "/" . a:n . ".tex"
	:VimtexReloadState
	:VimtexCompile
endfunction

