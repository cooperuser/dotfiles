local plugin = {name = "bufferline"}
Plugins[plugin.name] = plugin

local settings = {
	show_buffer_close_icons = false,
	separator_style = {"▕", "▊"},
	close_icon = '',
	modified_icon = "",
	tab_size = 0,
	enforce_regular_tabs = false,
	diagnostics = "nvim_lsp",
	diagnostics_indicator = function(count, level)
		return ''
	end,
	filter = function(buf_num)
		if not vim.t.is_help_tab then return nil end
		return vim.api.nvim_buf_get_option(buf_num, "buftype") == "help"
	end
}

local function getStatusNumbers()
	local error = vim.lsp.diagnostic.get_count(0, [[Error]])
	local warning = vim.lsp.diagnostic.get_count(0, [[Warning]])
	local information = vim.lsp.diagnostic.get_count(0, [[Information]])
	local hint = vim.lsp.diagnostic.get_count(0, [[Hint]])
	return {error, warning, information, hint}
end

function _G.nvim_copperline()
	-- @type string
	local bufferline = _G.nvim_bufferline()
	bufferline = string.sub(bufferline, 1, #bufferline - 26)
	local _, tabstart = string.find(bufferline, "#BufferLineFill#%%=")
	local tabline = string.sub(bufferline, tabstart + 1)
	bufferline = string.sub(bufferline, 1, tabstart)
	local status = getStatusNumbers()
	local theme = "%#TabLine"
	local separator = " "
	-- if #tabline ~= 0 then
	-- 	theme = "%#Tabline"
	-- 	separator = " %#Separator#▕"
	-- end
	local copperline = theme .. 'Separator# '
	if status[4] ~= 0 then
		copperline = copperline .. theme .. "Hint#  " .. status[4]
	end
	if status[3] ~= 0 then
		copperline = copperline .. theme .. "Info#  " .. status[3]
	end
	if status[2] ~= 0 then
		copperline = copperline .. theme .. "Warning#  " .. status[2]
	end
	if status[1] ~= 0 then
		copperline = copperline .. theme .. "Error#  " .. status[1]
	end
	if status[1] + status[2] + status[3] + status[4] == 0 then
		copperline = copperline .. theme .. "Success# "
	end
	return bufferline .. copperline .. separator .. tabline
end

function plugin.settings()
	local colors = require "bufferline/colors"

	local c = {
		fill_bg = colors.get_hex("TabLineFill", "bg"),
		selected_bg = colors.get_hex("Normal", "bg"),
		selected_fg = colors.get_hex("Ignore", "fg"),
		selected_sign = colors.get_hex("PmenuSel", "bg"),
		visible_bg = colors.get_hex("Normal", "bg"),
		visible_fg = colors.get_hex("StatusLine", "fg"),
		visible_sign = colors.get_hex("StatusLine", "fg"),
		inactive_bg = colors.get_hex("ColorColumn", "bg"),
		inactive_fg = colors.get_hex("Comment", "fg"),
		inactive_sign = colors.get_hex("StatusLineNC", "fg"),

		red = colors.get_hex("Error", "fg"),
		orange = colors.get_hex("Warning", "fg"),
		green = colors.get_hex("String", "fg"),
		purple = colors.get_hex("Keyword", "fg"),
	}

	local pick = "bold"
	require("bufferline").setup{
		options = settings,
		highlights = {
			fill = {
				guibg = c.fill_bg
			},
			background = {
				guifg = c.inactive_fg,
				guibg = c.inactive_bg,
				-- gui = "italic"
			},
			tab = {
				guifg = c.inactive_fg,
				guibg = c.selected_bg
			},
			tab_selected = {
				guifg = c.selected_sign,
				guibg = c.selected_bg
			},
			buffer_visible = {
				guifg = c.visible_fg,
				guibg = c.visible_bg
			},
			buffer_selected = {
				guifg = c.selected_fg,
				guibg = c.selected_bg,
				gui = "none"
			},
			indicator_selected = {
				guifg = c.selected_sign,
				guibg = c.selected_bg
			},
			separator = {
				guifg = c.fill_bg,
				guibg = c.selected_bg
			},
			separator_selected = {
				guifg = c.fill_bg,
				guibg = c.selected_bg
			},
			modified = {
				guifg = c.red,
				guibg = c.inactive_bg
			},
			modified_visible = {
				guifg = c.orange,
				guibg = c.visible_bg
			},
			modified_selected = {
				guifg = c.green,
				guibg = c.selected_bg
			},
			duplicate_selected = {
				guifg = c.selected_fg,
				guibg = c.selected_bg,
				gui = "none"
			},
			duplicate_visible = {
				guifg = c.visible_fg,
				guibg = c.visible_bg,
				gui = "none"
			},
			duplicate = {
				guifg = c.inactive_fg,
				guibg = c.inactive_bg,
				gui = "none"
			},
			pick_selected = {
				guifg = c.inactive_fg,
				guibg = c.selected_bg,
				gui = pick
			},
			pick_visible = {
				guifg = c.orange,
				guibg = c.visible_bg,
				gui = pick
			},
			pick = {
				guifg = c.red,
				guibg = c.inactive_bg,
				gui = pick
			},
			error = {
				guifg = c.inactive_fg,
				guibg = c.inactive_bg,
				gui = "none"
			},
			error_selected = {
				guifg = c.red,
				guibg = c.selected_bg,
				gui = "none"
			},
			error_visible = {
				guifg = c.red,
				guibg = c.visible_bg,
				gui = "none"
			},
			warning = {
				guifg = c.inactive_fg,
				guibg = c.inactive_bg,
				gui = "none"
			},
			warning_selected = {
				guifg = c.orange,
				guibg = c.selected_bg,
				gui = "none"
			},
			warning_visible = {
				guifg = c.orange,
				guibg = c.visible_bg,
				gui = "none"
			},
		}
	}

	vim.o.tabline = "%!v:lua.nvim_copperline()"
end

function plugin.keybinds()
	TEMPMAP.group([[Move between buffers using nvim-bufferline]], function()
		TEMPMAP.n("<C-j>", "<cmd>BufferLineCyclePrev<CR>")
		TEMPMAP.n("<C-k>", "<cmd>BufferLineCycleNext<CR>")
		TEMPMAP.sp("J", "<cmd>BufferLineMovePrev<CR>")
		TEMPMAP.sp("K", "<cmd>BufferLineMoveNext<CR>")
		TEMPMAP.n("<CR>", "<cmd>BufferLinePick<CR>")
	end)
end

return function()
	Plugins.bufferline.settings()
	TEMPMAP.plugin(Plugins.bufferline)
end

