#!/usr/bin/fish

set -U EDITOR nvim
set fish_greeting

export NETHACKOPTIONS=@$HOME/.config/nethack/nethackrc;
export MANPAGER='nvim +Man!'

# Setup command aliases
. ~/.config/fish/aliases.fish

# Vi mode {{{
bind --mode insert --sets-mode default \cc force-repaint;
bind --mode default --sets-mode insert \cc kill-whole-line force-repaint;
bind --mode default \cd kill-whole-line delete-or-exit;

bind --mode insert \cp history-search-backward
bind --mode insert \cn history-search-forward

bind --mode insert \ch backward-char;
bind --mode insert \cj backward-word;
bind --mode insert \eh beginning-of-line;
bind --mode insert \eJ backward-bigword;

bind --mode insert \cl forward-char;
bind --mode insert \ck forward-word forward-char;
bind --mode insert \el end-of-line;
bind --mode insert \eK forward-bigword forward-char;

bind --mode default dw kill-word delete-char
# }}}

set fish_cursor_default 'block'
set fish_cursor_insert 'line'
set fish_cursor_visual 'line'

# Setup pyenv configurations
if test -d ~/.install/pyenv
	# set PYENV_ROOT "$HOME/.install/pyenv";
	export PYENV_ROOT="$HOME/.install/pyenv";
	export RUST_ROOT="$HOME/.cargo";
	set -gx PATH $PYENV_ROOT/bin $PYENV_ROOT/shims $RUST_ROOT/bin $PATH;
end

set -gx PATH ~/.local/bin $PATH;

if test ! -n "$TMUX"
	bind --mode insert \ca "attempt_tmux;fish_prompt";
end

set_git_changes
set fish_command_timer_enabled 0

