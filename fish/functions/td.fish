#!/usr/bin/fish

function td
	set CURRENT_DIRECTORY (pwd);
	cd ~/git;
	set SELECTED_REPO (/bin/ls | fzf --preview="exa -T --color=always --git-ignore --ignore-glob='node_modules|build|out|dist|doc|bin|obj' {}");
	set error $status;
	if test $error -ne 130
		if test -n $TMUX
			set TMUX_OLD $TMUX
			set -e TMUX
			tmux switch -t $SELECTED_REPO || tmux new -d -s $SELECTED_REPO;
			set TMUX $TMUX_OLD
			set -e TMUX_OLD
		else
			tmux new -A -s $SELECTED_REPO;
		end
	end
	cd $CURRENT_DIRECTORY;
	return $error
end

