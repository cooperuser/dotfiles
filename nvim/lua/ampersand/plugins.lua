vim.cmd [[packadd packer.nvim]]
local packer = require("packer")
local use = packer.use
local map = require("ampersand.keymap")

Plugins = {}

local function wrap(opts)
	if type(opts) == "string" then opts = {opts} end
	opts = opts or {""}

	if not opts.as then
		local success, index = string.find(opts[1], "/")
		if not success then
			print("error")
			return
		end
		opts.as = string.sub(opts[1], index + 1)
		success, index = string.find(opts.as, "%.")
		if success then
			opts.as = string.sub(opts.as, 1, index - 1)
		end
	end

	if not opts.config then
		local path = "ampersand.plugins." .. opts.as
		local exists = vim._load_package(path)
		if exists then opts.config = require(path) end
	end

	use(opts)
end

vim.cmd("autocmd BufWritePost */nvim/lua/ampersand/plugins* PackerCompile")
local function strap(name) return require("ampersand.plugins." .. name) end

packer.init {
	display = {
		error_sym = "";
		done_sym = "";
	}
}

return packer.startup(function()
	-- luacheck: push globals use
	use {"wbthomason/packer.nvim", opt = true}

	-- Library plugins {{{
	wrap "romgrk/lib.kom"
	wrap "nvim-lua/popup.nvim"
	wrap "nvim-lua/plenary.nvim"
	wrap "RishabhRD/popfix"
	-- }}}

	-- Utility plugins {{{
	wrap {"tpope/vim-commentary", as = "commentary"}
	wrap "machakann/vim-sandwich"
	wrap "tpope/vim-fugitive"
	wrap "junegunn/vim-peekaboo"
	wrap "junegunn/vim-easy-align"
	wrap {"lewis6991/gitsigns.nvim"}
	wrap {"AndrewRadev/switch.vim"}
	wrap {"nvim-treesitter/nvim-treesitter"}
	wrap "nvim-treesitter/playground"
	wrap {"psliwka/vim-smoothie"}
	wrap {"voldikss/vim-floaterm"}
	wrap {"pwntester/octo.nvim"}
	wrap {"metakirby5/codi.vim"}
	wrap "qpkorr/vim-bufkill"
	wrap "dstein64/vim-startuptime"
	wrap {"glepnir/dashboard-nvim", as = "nvim-dashboard"}
	wrap {"kyazdani42/nvim-tree.lua"}
	-- wrap {"mbbill/undotree"}
	wrap {"~/git/undotree", as = "undotree"}
	wrap {"cohama/lexima.vim"}
	-- }}}

	-- Aesthetic plugins {{{
	wrap {"glepnir/galaxyline.nvim"}
	-- wrap {"~/git/galaxyline.nvim"}
	wrap "kyazdani42/nvim-web-devicons"
	wrap {"akinsho/nvim-bufferline.lua", as = "bufferline"}
	-- wrap {"romgrk/barbar.nvim"}
	wrap {"junegunn/goyo.vim"}
	-- }}}

	-- Search plugins {{{
	-- use {"junegunn/fzf",
	-- 	dir = "~/.install/fzf",
	-- 	run = "./install --bin",
	-- }
	-- use "junegunn/fzf.vim"
	wrap {"nvim-lua/telescope.nvim"}
	wrap "nvim-telescope/telescope-fzy-native.nvim"
	wrap {"unblevable/quick-scope"}
	-- }}}

	-- Completion plugins {{{
	wrap {"neovim/nvim-lspconfig"}
	wrap {"hrsh7th/nvim-compe"}
	wrap {"glepnir/lspsaga.nvim"}
	wrap {"kosayoda/nvim-lightbulb"}
	-- wrap {"hrsh7th/vim-vsnip"}
	-- }}}

	-- Language plugins {{{
	wrap {"sheerun/vim-polyglot"}
--	wrap {"lervag/vimtex"}
	wrap "mattn/emmet-vim"
	-- }}}

	-- Colorschemes {{{
	wrap {"rktjmp/lush.nvim"}
	wrap {"~/git/glowbeam.nvim", as = "glowbeam"}
	-- }}}

	-- Miscellaneous {{{
--	wrap {"glacambre/firenvim",
		-- run = function() vim.fn["firenvim#install"](0) end
	-- }
--	wrap {"jbyuki/instant.nvim"}
	-- }}}

	-- Runner plugins {{{
	wrap {"iamcco/markdown-preview.nvim", run = "cd app && yarn install"}
	wrap {"rafcamlet/nvim-luapad"}
	-- }}}

	-- Temporary plugins {{{
	wrap {"~/git/tabi.nvim", as = "tabi.nvim"}
	wrap {"~/git/telescope-packer.nvim", as = "telescope-packer"}
	wrap {"~/git/indent-guides.nvim", as = "indent-guides"}
	wrap {"dbeniamine/cheat.sh-vim"}
	wrap {"nvim-telescope/telescope-ghq.nvim"}
	-- wrap {"norcalli/snippets.nvim"}
	-- wrap {"SirVer/ultisnips"}
	-- }}}
	-- luacheck: pop
end)

