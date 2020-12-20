set nocompatible

source ~/.config/nvim/config/plugins.vim
source ~/.config/nvim/config/settings.vim
source ~/.config/nvim/config/keybinds.vim

source ~/.config/nvim/config/statusline.vim
source ~/.config/nvim/config/bufline.vim
source ~/.config/nvim/config/terminal.vim

syntax on
set termguicolors
colorscheme glowbeam

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

