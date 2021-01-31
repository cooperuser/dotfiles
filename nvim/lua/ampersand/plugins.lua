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
	use "lewis6991/gitsigns.nvim"
	use {"AndrewRadev/switch.vim", config = strap("switch")}
	use {"nvim-treesitter/nvim-treesitter", config = strap("treesitter")}
	use "nvim-treesitter/playground"
	use "nvim-treesitter/nvim-treesitter-textobjects"
	use {"psliwka/vim-smoothie", config = strap("smoothie")}
	use {"voldikss/vim-floaterm", config = strap("floaterm")}
	use {"pwntester/octo.nvim"}
	-- use {"oberblastmeister/neuron.nvim", config = strap("neuron")}
	-- }}}

	-- Aesthetic plugins {{{
	use "itchyny/lightline.vim"
	use "kyazdani42/nvim-web-devicons"
	use {"akinsho/nvim-bufferline.lua", config = strap("bufferline")}
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
	use "neovim/nvim-lspconfig"
	use {"nvim-lua/completion-nvim", config = strap("completion")}
	use "RishabhRD/nvim-lsputils"
	-- use "tjdevries/nlua.nvim"
	use "SirVer/ultisnips"
	-- use {"glepnir/lspsaga.nvim", config = strap("lspsaga")} -- TODO: Follow development
	-- }}}

	-- Language plugins {{{
	use {"sheerun/vim-polyglot", config = strap("polyglot")}
	use {"lervag/vimtex", config = strap("vimtex")}
	use "skanehira/preview-uml.vim"
	-- }}}

	-- Colorschemes {{{
	use "~/GitHub/glowbeam.vim"
	-- }}}

	-- Miscellaneous {{{
	-- use "machakann/vim-swap"
	use {"skywind3000/asynctasks.vim",
		config = strap("asynctasks"),
		requires = {"skywind3000/asyncrun.vim"}
	}
	use {"glacambre/firenvim",
		config = strap("firenvim"),
		run = function() vim.fn["firenvim#install"](0) end
	}
	-- use "kyazdani42/nvim-tree.lua"
	-- }}}

	-- Runner plugins {{{
	use {"iamcco/markdown-preview.nvim", run = "cd app && yarn install", config = strap("markdownpreview")}
	-- }}}

	-- Temporary plugins {{{
	-- }}}
	-- luacheck: pop
end)

