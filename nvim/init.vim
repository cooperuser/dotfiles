set nocompatible

source ~/.config/nvim/config/plugins.vim
source ~/.config/nvim/config/settings.vim
source ~/.config/nvim/config/keybinds.vim

source ~/.config/nvim/config/statusline.vim
source ~/.config/nvim/config/bufline.vim

syntax on
set termguicolors
" Temporary loading two separate colorschemes to
" get the nvim-treesitter colors working properly
colorscheme glowbeam
colorscheme doom-two

lua <<EOF
require'nvim-web-devicons'.setup {
 default = true;
}
EOF

