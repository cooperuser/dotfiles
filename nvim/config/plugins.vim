set rtp+=~/.install/fzf

call plug#begin('~/.config/nvim/plugged') " Begin vim-plug

" Main plugins
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'AndrewRadev/switch.vim'
Plug 'benmills/vimux'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'npxbr/glow.nvim'
Plug 'rrethy/vim-hexokinase', {'do': 'make hexokinase'}
Plug 'itchyny/lightline.vim'
Plug 'josa42/vim-lightline-coc'
Plug 'machakann/vim-swap'
Plug 'kana/vim-textobj-user'
Plug 'sgur/vim-textobj-parameter'

" Completion plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Syntax plugins
Plug 'sheerun/vim-polyglot'

" Colorschemes
Plug 'cooper-anderson/tjay.vim'
Plug 'morhetz/gruvbox'
Plug 'balanceiskey/vim-framer-syntax'
Plug 'Iron-E/nvim-highlite'
Plug '~/GitHub/better'
Plug 'trusktr/seti.vim'

call plug#end() " Initialize vim-plug system and plugins

" Configurations

" AndrewRadev/switch.vim
let g:switch_custom_definitions = [['0', '1'], ["on", "off"], ["#t", "#f"]]

" junegunn/fzf
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }

" rrethy/vim-hexokinase
let g:Hexokinase_highlighters = [ 'backgroundfull' ]

" neoclide/coc.vim'
let g:coc_snippet_next = "<C-l>"
let g:coc_snippet_prev = "<C-h>"

" sgur/vim-textobj-parameter
let g:vim_textobj_parameter_mapping = 'a'

" nvim-treesitter/nvim-treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
	ensure_installed = {"javascript", "jsdoc"},     -- one of "all", "language", or a list of languages
	highlight = {
		enable = true              -- false will disable the whole extension
	},
}
EOF

