function classes
	set SELECTED_DIR (find ~/Classes -mindepth 3 -maxdepth 3 | fzf)
	set error $status
	if test $status -ne 130
		cd $SELECTED_DIR
	end
	return $error
end

