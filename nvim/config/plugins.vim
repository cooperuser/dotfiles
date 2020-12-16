set rtp+=~/.install/fzf

call plug#begin('~/.config/nvim/plugged') " Begin vim-plug

" Main plugins
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-easy-align'
Plug 'AndrewRadev/switch.vim'
Plug 'benmills/vimux'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/playground', { 'on': 'TSPlaygroundToggle' }
" Plug 'p00f/nvim-ts-rainbow'
Plug 'itchyny/lightline.vim'
Plug 'josa42/vim-lightline-coc'
Plug 'machakann/vim-swap'
Plug 'voldikss/vim-floaterm'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'lervag/vimtex'

" Searching
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'

" Buffer bar
Plug 'romgrk/lib.kom'
" Plug 'romgrk/barbar.nvim'

" Completion plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'nvim-lua/completion-nvim'
" Plug 'neovim/nvim-lspconfig' ", {'for': ['vim', 'lua', 'rust']}
" Plug 'nvim-lua/diagnostic-nvim'
" Plug 'tjdevries/nlua.nvim'

" Syntax plugins
Plug 'sheerun/vim-polyglot'

" Text objects
Plug 'kana/vim-textobj-user'
Plug 'sgur/vim-textobj-parameter'
Plug 'glts/vim-textobj-comment'
Plug 'Julian/vim-textobj-variable-segment'

" Colorschemes
Plug 'cooper-anderson/tjay.vim'
Plug 'morhetz/gruvbox'
Plug 'Iron-E/nvim-highlite'
Plug '~/GitHub/glowbeam.vim'
Plug '~/Github/doom-two.vim'
Plug 'tomasiser/vim-code-dark'
Plug 'romgrk/doom-one.vim'

call plug#end() " Initialize vim-plug system and plugins

" source ~/.config/nvim/config/plugin-settings/completion-nvim.vim

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

" Floaterm
let g:floaterm_winblend = 10
let g:fern#renderer = "nerdfont"

" nvim-treesitter/nvim-treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
	ensure_installed = {"javascript", "jsdoc"},     -- one of "all", "language", or a list of languages
	use_languagetree = true,
	highlight = {
		enable = true              -- false will disable the whole extension
	},
}

require "nvim-treesitter.configs".setup {
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false -- Whether the query persists across vim sessions
  },
  --[[rainbow = {
    enable = true,
    disable = {'lua'} -- please disable lua for now
  }--]]
}

require "nvim-treesitter.highlight"
local hlmap = vim.treesitter.highlighter.hl_map
hlmap["parameter"] = "Parameter"
hlmap["parameter.arrow_function"] = "Parameter"
EOF

" Telescope
lua require('telescope').setup({defaults = {file_sorter = require('telescope.sorters').get_fzy_sorter}})
let g:dashboard_default_executive ='telescope'

" nvim-tree-lua
let g:lua_tree_indent_markers = 1
let g:lua_tree_git_hl = 1
let g:lua_tree_ignore = [
	\ '.git',
	\ 'node_modules',
	\ '.cache',
	\ '.idea',
	\ '.firebase'
\ ]
let g:lua_tree_show_icons = {
	\ 'git': 0,
	\ 'folders': 1,
	\ 'files': 1,
\ }
let g:lua_tree_icons = {
	\ 'folder': {
		\ 'default': '',
		\ 'open': '',
	\ }
\ }

" Vimtex
let g:vimtex_view_method = 'skim'

