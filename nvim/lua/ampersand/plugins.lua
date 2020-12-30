vim.cmd [[packadd packer.nvim]]

Plugins = {}

vim.cmd("autocmd BufWritePost */nvim/lua/ampersand/plugins* PackerCompile")
local function strap(name) return require("ampersand.plugins." .. name) end

return require("packer").startup(function()
	local use = use or function() end
	use {"wbthomason/packer.nvim", opt = true}

	-- Library plugins {{{
	use "romgrk/lib.kom"
	use "nvim-lua/popup.nvim"
	use "nvim-lua/plenary.nvim"
	use "RishabhRD/popfix"
	-- }}}

	-- Utility plugins {{{
	use {"tpope/vim-commentary", config = strap("commentary")}
	use "tpope/vim-surround"
	use "tpope/vim-fugitive"
	use "junegunn/vim-peekaboo"
	use "junegunn/vim-easy-align"
	use "lewis6991/gitsigns.nvim"
	use {"AndrewRadev/switch.vim", config = strap("switch")}
	use {"nvim-treesitter/nvim-treesitter", config = strap("treesitter")}
	use "nvim-treesitter/playground"
	-- }}}

	-- Aesthetic plugins {{{
	use "itchyny/lightline.vim"
	use "kyazdani42/nvim-web-devicons"
	-- }}}

	-- Search plugins {{{
	use {"junegunn/fzf",
		dir = "~/.install/fzf",
		run = "./install --bin",
		config = strap("fzf")
	}
	use "junegunn/fzf.vim"
	use {"nvim-lua/telescope.nvim", config = strap("telescope")}
	-- }}}

	-- Completion plugins {{{
	use "neovim/nvim-lspconfig"
	use {"nvim-lua/completion-nvim", config = strap("completion")}
	use "RishabhRD/nvim-lsputils"
	use "tjdevries/nlua.nvim"
	use "SirVer/ultisnips"
	-- }}}

	-- Language plugins {{{
	use {"sheerun/vim-polyglot", config = strap("polyglot")}
	use {"lervag/vimtex", config = strap("vimtex")}
	use "skanehira/preview-uml.vim"
	-- }}}
	
	-- Colorschemes {{{
	use "~/GitHub/glowbeam.vim"
	use "~/Github/doom-two.vim"
	-- }}}
	
	-- Miscellaneous {{{
	-- use "machakann/vim-swap"
	-- use "voldikss/vim-floaterm"
	-- use "kyazdani42/nvim-tree.lua"
	-- }}}
	
	-- Temporary plugins {{{
	-- }}}
end)
