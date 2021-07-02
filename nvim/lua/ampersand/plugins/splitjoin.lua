return function()
	vim.g.splitjoin_split_mapping = ''
	vim.g.splitjoin_join_mapping = ''
	K.n { '<M-J>', function() vim.cmd [[SplitjoinSplit]] end }
	K.n { '<M-K>', function() vim.cmd [[SplitjoinJoin]] end }
end
