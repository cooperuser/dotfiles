vim.cmd [[packadd packer.nvim]]

Plugins = {}

vim.cmd("autocmd BufWritePost */nvim/lua/ampersand/plugins* PackerCompile")
local function strap(name) return require("ampersand.plugins." .. name) end

return require("packer").startup(function()
	-- luacheck: push globals use
	use {"wbthomason/packer.nvim", opt = true}

	-- Library plugins {{{
	use "romgrk/lib.kom"
	use "nvim-lua/popup.nvim"
	use "nvim-lua/plenary.nvim"
	use "RishabhRD/popfix"
	-- }}}

	-- Utility plugins {{{
	use {"tpope/vim-commentary", config = strap("commentary")}
	use "machakann/vim-sandwich"
	use "tpope/vim-fugitive"
	use "junegunn/vim-peekaboo"
	use "junegunn/vim-easy-align"
	use {"lewis6991/gitsigns.nvim", config = strap("gitsigns")}
	use {"AndrewRadev/switch.vim", config = strap("switch")}
	use {"nvim-treesitter/nvim-treesitter", config = strap("treesitter")}
	use "nvim-treesitter/playground"
	use {"psliwka/vim-smoothie", config = strap("smoothie")}
	use {"voldikss/vim-floaterm", config = strap("floaterm")}
	use {"pwntester/octo.nvim"}
	use {"oberblastmeister/neuron.nvim", config = strap("neuron")}
	use {"metakirby5/codi.vim", config = strap("codi")}
	use "qpkorr/vim-bufkill"
	use "dstein64/vim-startuptime"
	use {"glepnir/dashboard-nvim", config = strap("dashboard")}
	use {"kyazdani42/nvim-tree.lua", config = strap("nvimtree")}
	-- use {"mbbill/undotree", config = strap("undotree")}
	use {"~/git/undotree", config = strap("undotree")}
	use {"cohama/lexima.vim"}
	-- }}}

	-- Aesthetic plugins {{{
	-- use "itchyny/lightline.vim"
	use {"glepnir/galaxyline.nvim", config = strap("galaxyline")}
	-- use {"~/git/galaxyline.nvim", config = strap("galaxyline")}
	use "kyazdani42/nvim-web-devicons"
	use {"akinsho/nvim-bufferline.lua", config = strap("bufferline")}
	-- use {"romgrk/barbar.nvim", config = strap("barbar")}
	use {"junegunn/goyo.vim", config = strap("goyo")}
	-- }}}

	-- Search plugins {{{
	use {"junegunn/fzf",
		dir = "~/.install/fzf",
		run = "./install --bin",
		config = strap("fzf")
	}
	use "junegunn/fzf.vim"
	use {"nvim-lua/telescope.nvim", config = strap("telescope")}
	use "nvim-telescope/telescope-fzy-native.nvim"
	use {"unblevable/quick-scope", config = strap("quickscope")}
	-- }}}

	-- Completion plugins {{{
	use {"neovim/nvim-lspconfig", config = strap("lspconfig")}
	use {"hrsh7th/nvim-compe", config = strap("compe")}
	use {"glepnir/lspsaga.nvim", config = strap("lspsaga")}
	use {"kosayoda/nvim-lightbulb", config = strap("lightbulb")}
	use {"hrsh7th/vim-vsnip", config = strap("vsnip")}
	-- }}}

	-- Language plugins {{{
	use {"sheerun/vim-polyglot", config = strap("polyglot")}
	use {"lervag/vimtex", config = strap("vimtex")}
	use "mattn/emmet-vim"
	-- }}}

	-- Colorschemes {{{
	use {"rktjmp/lush.nvim"}
	use "~/GitHub/glowbeam.vim"
	-- }}}

	-- Miscellaneous {{{
	use {"glacambre/firenvim",
		config = strap("firenvim"),
		run = function() vim.fn["firenvim#install"](0) end
	}
	use {"jbyuki/instant.nvim", config = strap("instant")}
	-- }}}

	-- Runner plugins {{{
	use {"iamcco/markdown-preview.nvim", run = "cd app && yarn install", config = strap("markdownpreview")}
	use {"rafcamlet/nvim-luapad", config = strap("luapad")}
	-- }}}

	-- Temporary plugins {{{
	use {"~/git/tabi.nvim", config = strap("tabi")}
	use {"~/git/telescope-packer.nvim"}
	use {"~/git/indent-guides.nvim"}
	use {"dbeniamine/cheat.sh-vim"}
	-- }}}
	-- luacheck: pop
end)

