return function()
	require("indent_guides").setup {
		even_colors = {fg = "#1c1f24", bg = "#1c1f24"};
		odd_colors = {fg = "#202328", bg = "#202328"};
		exclude_filetypes = {
			'help';
			"man";
			'dashboard';
			'dashpreview';
			'NvimTree';
			'vista';
			'sagahover';
			'sagasignature';
			'packer';
			'log';
			'lspsagafinder';
			'lspinfo';
			"TelescopePrompt";
			"toggleterm";
		};
		-- exclude_filetypes = {
		-- 	"help";
		-- 	"dashboard";
		-- 	"dashpreview";
		-- 	"NvimTree";
		-- 	"vista";
		-- 	"sagahover";
		-- 	"lspsagafinder";
		-- 	"LspSagaCodeAction";
		-- 	"packer";
		-- 	"man";
		-- 	"floaterm";
		-- 	"toggleterm";
		-- 	"git";
		-- 	"TelescopePrompt";
		-- 	"c";
		-- 	"h";
		-- 	"undotree";
		-- 	"lua";
		-- 	"";
		-- };
	}
end
