return function()
	print("test")
	require("indent_guides").setup {
		exclude_filetypes = {
			"help";
			"dashboard";
			"dashpreview";
			"NvimTree";
			"vista";
			"sagahover";
			"packer";
		};
	}
end
