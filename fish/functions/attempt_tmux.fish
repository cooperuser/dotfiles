function attempt_tmux
	tmux has-session 2> /dev/null;
	if test $status -eq 0
		tmux a;
	else
		tmux;
	end
end

