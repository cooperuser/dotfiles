set charPrompt "&"
set charArrowPass "‣"
set charArrowFail "×"
set charArrowTerm "■"

set charGitBehind "◒"
set charGitAhead "◓"
set charGitBoth "●"

set customRed    (set_color ff6c6b)
set customOrange (set_color f2c68a)
set customYellow (set_color cae682)
set customGreen  (set_color 95e454)
set customBlue   (set_color 87afff)
set customPurple (set_color B7D)
set customCopper (set_color FFAA22)
set customMuted  (set_color aaa)
set customTime  (set_color 73797e)

set modeBack (set_color -r --background=3f444a)
set modeColor $customMuted
set modeIcon " "
set modeLeft ""
set modeRight ""

function fish_mode_prompt
	set error $status

	set colorTime   $customOrange
	set colorPath   $customBlue
	set colorArrow  $customGreen
	set colorError  $customRed
	set charArrow   $charArrowPass

	set branch (git branch ^/dev/null | grep \* | sed 's/* //')

	if test $error -eq 130
		set error
		set colorArrow $colorError
		set charArrow $charArrowTerm
	else if test $error -ne 0
		set error $error\ ;
		set colorArrow $customRed
		if test $error -ne 130
			set charArrow $charArrowFail
		end
	else if test -n "$branch"
		set error
		if test -n "$git_changes"
			set colorArrow $customBlue
		end
	else
		set error
	end

	set_mode_indicator

	echo -n -s \
		$modeColor $modeLeft \
		$modeBack $modeIcon \
		(set_color normal) \
		$modeColor $modeRight \
		(get_cmd_timer);
end

function set_mode_indicator
	switch $fish_bind_mode
		case default
			set modeColor $customGreen
			set modeIcon '  '
		case insert
			set modeColor $customBlue
			set modeIcon '  '
		case replace_one
			set modeColor $customRed
			set modeIcon ' • '
		case replace
			set modeColor $customRed
			set modeIcon ' × '
		case visual
			set modeColor $customOrange
			set modeIcon '  '
		case '*'
			set modeColor $customMuted
			set modeIcon '   '
	end
end

function get_cmd_timer
	if test $CMD_DURATION -gt 9
		echo $customTime └○ "$CMD_DURATION ms"
	end
end

