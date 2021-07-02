vim.cmd [[packadd packer.nvim]]
local packer = require("packer")
local use = packer.use

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

local function pack(cmd) return function() vim.cmd("Packer" .. cmd) end end
K.q {'PI', pack("Install")}
K.q {'PX', pack("Clean")}
K.q {'PC', pack("Compile")}
K.q {'PU', pack("Update")}

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
	-- wrap "tpope/vim-fugitive"
	wrap "junegunn/vim-easy-align"
	wrap {"lewis6991/gitsigns.nvim"}
	wrap {"AndrewRadev/switch.vim"}
	wrap {"nvim-treesitter/nvim-treesitter"}
	wrap {"nvim-treesitter/nvim-treesitter-textobjects"}
	wrap "nvim-treesitter/playground"
	wrap {"psliwka/vim-smoothie"}
	-- wrap {"voldikss/vim-floaterm"}
	-- wrap {"pwntester/octo.nvim", disabled=true}
	wrap {"metakirby5/codi.vim"}
	wrap "qpkorr/vim-bufkill"
	wrap "dstein64/vim-startuptime"
	-- wrap {"glepnir/dashboard-nvim", as = "nvim-dashboard"}
	wrap {"kyazdani42/nvim-tree.lua"}
	-- wrap {"mbbill/undotree"}
	wrap {"~/git/undotree", as = "undotree"}
	-- wrap {"cohama/lexima.vim"}
	-- }}}

	-- Aesthetic plugins {{{
	wrap {"glepnir/galaxyline.nvim"}
	-- wrap {"~/git/galaxyline.nvim"}
	wrap "kyazdani42/nvim-web-devicons"
	wrap {"akinsho/nvim-bufferline.lua", as = "bufferline", commit = "a7d82020f743cbe0489406a0d333c4bfc860696c"}
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
	-- wrap {"kosayoda/nvim-lightbulb", disabled=true}
	wrap {"hrsh7th/vim-vsnip"}
	-- }}}

	-- Language plugins {{{
	wrap {"lervag/vimtex"}
	wrap {"sheerun/vim-polyglot"}
	-- }}}

	-- Colorschemes {{{
	wrap {"rktjmp/lush.nvim"}
	wrap {"~/git/glowbeam.nvim", as = "glowbeam"}
	wrap {"folke/tokyonight.nvim"}
	-- }}}

	-- Miscellaneous {{{
	wrap {"glacambre/firenvim",
		 run = function() vim.fn["firenvim#install"](0) end
	}
--	wrap {"jbyuki/instant.nvim"}
	-- }}}

	-- Runner plugins {{{
	wrap {"iamcco/markdown-preview.nvim", run = "cd app && yarn install"}
	wrap {"rafcamlet/nvim-luapad"}
	-- }}}

	-- Temporary plugins {{{
	-- wrap {"~/git/tabi.nvim", as = "tabi.nvim"}
	wrap {"~/git/telescope-packer.nvim", as = "telescope-packer"}
	-- wrap {"glepnir/indent-guides.nvim", as = "indent-guides"}
	wrap {"~/git/indent-guides.nvim", as = "indent-guides"}
	wrap {"nvim-telescope/telescope-ghq.nvim"}
	-- wrap {"norcalli/snippets.nvim"}
	-- wrap {"SirVer/ultisnips"}
	wrap {"akinsho/nvim-toggleterm.lua"}
	wrap {"windwp/nvim-ts-autotag"}
	wrap {"wadackel/nvim-syntax-info"}
	wrap {"tversteeg/registers.nvim", as = "registers"}
	wrap {"mfussenegger/nvim-dap"}
	wrap {"theHamsta/nvim-dap-virtual-text"}
	wrap {"p00f/nvim-ts-rainbow"}
	wrap {"ray-x/lsp_signature.nvim"}
	wrap {"steelsojka/pears.nvim"}
	-- wrap {"vimwiki/vimwiki"}
	wrap {"oberblastmeister/neuron.nvim"}
	wrap {"folke/lsp-trouble.nvim"}
	wrap {"RRethy/vim-illuminate"}
	wrap {"kevinhwang91/nvim-bqf"}
	wrap {"AndrewRadev/splitjoin.vim"}
	wrap {"dstein64/nvim-scrollview"}
	wrap {"folke/todo-comments.nvim"}
	wrap {"folke/lua-dev.nvim"}
	wrap {"simrat39/symbols-outline.nvim"}
	wrap {"dkarter/bullets.vim"}
	-- wrap {"Julian/lean.nvim"}
	-- wrap {"GoldsteinE/compe-latex-symbols"}
	-- }}}
	-- luacheck: pop
end, {
		display = {
			open_fn = require('packer.util').float,
		}
	}
)
