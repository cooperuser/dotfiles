#!/usr/bin/fish

set -U EDITOR nvim
set fish_greeting

export TERM="tmux-256color";

export NETHACKOPTIONS=@$HOME/.config/nethack/nethackrc;
# export LS_COLORS='di=0;163:ex=0;163:ln=0;163:cd=0;163:bd=0;163:';
# export LS_COLORS=$LS_COLORS'di=0;34:ex=0;92:ln=0;96:cd=0;93:bd=0;93:';
# export LS_COLORS=$LS_COLORS:'di=0;34:ex=0;163:ln=0;96:cd=0;93:bd=0;93:';
# export PAGER="/bin/sh -c \"unset PAGER;col -b -x | nvim -R -c 'set ft=man nomod nolist nonumber linebreak' -c 'map q :q<CR>' -c 'map <SPACE> <C-D>' -c 'map b <C-U>' -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\"";

# Setup command aliases
. ~/.config/fish/aliases.fish

bind \cw "aww";
bind \cf "vim -c 'GFiles'";
bind \cv "vim ~/.config/nvim/init.vim ~/.config/nvim/config/plugins.vim ~/.config/nvim/config/settings.vim ~/.config/nvim/config/keybinds.vim ~/.config/nvim/config/statusline.vim ~/.config/nvim/config/bufline.vim";
bind \cs "echo;git status;echo;";
bind \cg "gh_dirs";

# Setup pyenv configurations
if test -d ~/.install/pyenv
	# set PYENV_ROOT "$HOME/.install/pyenv";
	export PYENV_ROOT="$HOME/.install/pyenv";
	export RUST_ROOT="$HOME/.cargo";
	set -gx PATH $PYENV_ROOT/bin $PYENV_ROOT/shims $RUST_ROOT/bin $PATH;
end

# if test (tty) = /dev/tty1
	# If not running fbterm, run fbterm
	# fbterm;
	# exit;
# else if test ! -n "$TMUX"
	# If not running tmux, run tmux
	# bind \ca "attempt_tmux;fish_prompt";
	# tmux;
	# exit;
# end

if test ! -n "$TMUX"
	bind \ca "attempt_tmux;fish_prompt";
end

