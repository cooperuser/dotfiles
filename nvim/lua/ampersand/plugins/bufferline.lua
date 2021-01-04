local plugin = {name = "bufferline"}
Plugins[plugin.name] = plugin

local colors = require "bufferline/colors"

local settings = {
	show_buffer_close_icons = false,
	separator_style = {"▕", "▊"},
	close_icon = '',
	modified_icon = "",
	tab_size = 0,
	enforce_regular_tabs = false
}

function plugin.settings()
	local c = {
		fill_bg = colors.get_hex("TabLineFill", "bg"),
		selected_bg = colors.get_hex("Normal", "bg"),
		selected_fg = colors.get_hex("Ignore", "fg"),
		selected_sign = colors.get_hex("InfoMsg", "fg"),
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
				guibg = c.inactive_bg
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
				gui = ""
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
			}
		}
	}
end

function plugin.keybinds()
	-- TODO: Document these keybinds

	K.n("<C-j>", "<cmd>BufferLineCyclePrev<CR>")
	K.n("<C-k>", "<cmd>BufferLineCycleNext<CR>")
	K.sp("J", "<cmd>BufferLineMovePrev<CR>")
	K.sp("K", "<cmd>BufferLineMoveNext<CR>")
	K.n("<CR>", "<cmd>BufferLinePick<CR>")
end

return function()
	Plugins.bufferline.settings()
	K.plugin(Plugins.bufferline)
end

