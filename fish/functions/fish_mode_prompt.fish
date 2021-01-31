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

	echo -n -s \
		$colorArrow┌\  \
		$colorTime (date "+%H:%M")\  \
		$colorPath (prompt_pwd)\ \
		(get_mode_indicator);
end

function get_mode_indicator
	switch $fish_bind_mode
		case default
			echo $customGreen
			echo ' '
		case insert
			echo $customBlue
			# echo ' '
			echo '  '
		case replace_one
			echo $customRed
			echo '•'
			# echo ' '
		case visual
			echo $customOrange
			echo ' '
		case '*'
			echo $customRed
			echo '? '
	end
	set_color normal
end

