function lazygit
	set OLD_TERM $TERM
	export TERM="xterm-256color"
	/usr/bin/lazygit
	set TERM $OLD_TERM
end
