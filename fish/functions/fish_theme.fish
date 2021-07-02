set customRed    (set_color ff6c6b)
set customOrange (set_color f2c68a)
set customYellow (set_color cae682)
set customGreen  (set_color 95e454)
set customBlue   (set_color 87afff)
set customPurple (set_color B7D)
set customCopper (set_color FFAA22)
set customMuted  (set_color aaa)

set customWordRed    "#ff6c6b"
set customWordOrange "#f2c68a"
set customWordYellow "#cae682"
set customWordGreen  "#95e454"
set customWordBlue   "#87afff"
set customWordPurple "#B7D"
set customWordCopper "#FFAA22"
set customWordGrey  "#aaa"
set customWordDark  "#3f444a"
set customWordMuted  "#aaa"
set customWordCancel "#73797e"

function fish_theme
	set -u fish_color_autosuggestion $customWordGrey #555\x1ebrblack
	set -u fish_color_cancel $customWordCancel
	set -u fish_color_command $customWordPurple #005fd7
	set -u fish_color_comment $customWordGrey #990000
	# set -u fish_color_cwd $customWordMuted #green
	# set -u fish_color_cwd_root $customWordMuted #red
	set -u fish_color_end $customWordGreen #009900
	set -u fish_color_error $customWordRed #ff0000
	set -u fish_color_escape $customWordRed #00a6b2
	# set -u fish_color_history_current "--bold" #\x2d\x2dbold
	set -u fish_color_history_current $customWordRed #\x2d\x2dbold
	set -u fish_color_host $customWordMuted #normal
	set -u fish_color_host_remote $customWordMuted #yellow
	# set -u fish_color_match "--bold" #\x2d\x2dbackground\x3dbrblue
	set -u fish_color_match #\x2d\x2dbackground\x3dbrblue
	set -u fish_color_normal "normal" #normal
	set -u fish_color_operator $customWordOrange #00a6b2
	set -u fish_color_param $customWordBlue #00afff
	set -u fish_color_quote $customWordYellow #999900
	set -u fish_color_redirection $customWordCopper #00afff
	set -u fish_color_search_match "--background=$customWordDark" #bryellow\x1e\x2d\x2dbackground\x3dbrblack
	set -u fish_color_selection "--background=$customWordDark" #white\x1e\x2d\x2dbold\x1e\x2d\x2dbackground\x3dbrblack
	set -u fish_color_status $customWordRed #red
	# set -u fish_color_user $customWordMuted #brgreen
	set -u fish_color_valid_path "--underline" #\x2d\x2dunderline
	set -u fish_pager_color_completion $customWordGrey #\x1d
	set -u fish_pager_color_description $customWordYellow #B3A06D\x1eyellow
	set -u fish_pager_color_prefix $customWordRed #white\x1e\x2d\x2dbold\x1e\x2d\x2dunderline
	set -u fish_pager_color_progress $customWordPurple #brwhite\x1e\x2d\x2dbackground\x3dcyan
end

