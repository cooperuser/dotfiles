return function()
	local gl = require("galaxyline")
	local buffer = require('galaxyline.provider_buffer')
	gl.short_line_list = {'NvimTree', 'vista', 'dbui', 'packer', 'tagbar'}

	-- Options {{{
	local edge = { left = "", right = "" }
	local ids = {
		normal = 110,
		insert = 105,
		command = 99,
		terminal = 116,
		visual = 118,
		v_block = 22,
		v_line = 86,
		replace = 82,
		select = 115,
		s_line = 83
	}

	local colors = {
		red = "#ff6c6b",
		orange = "",
		yellow = "#f2c68a",
		green = "#95e454",
		blue = "#87afff",
		purple = "#c678dd",

		grey0 = "#1b2229",
		grey1 = "#1c1f24",
		grey2 = "#202328",
		grey3 = "#23272e",
		grey4 = "#3f444a",
		grey5 = "#5b6268",
		grey6 = "#73797e",
		grey7 = "#9ca0a4",
		grey8 = "#b1b1b1",
		grey9 = "#e6e6e6"
	}

	local modes = {
		[ids.normal] = {alias = "", color = colors.green},
		[ids.insert] = {alias = "", color = colors.blue},
		[ids.command] = {alias = "", color = colors.grey8},
		[ids.terminal] = {alias = "", color = colors.purple},
		[ids.visual] = {alias = "", color = colors.yellow},
		[ids.v_block] = {alias = "", color = colors.yellow},
		[ids.v_line] = {alias = "", color = colors.yellow},
		[ids.replace] = {alias = "", color = colors.red},
		[ids.select] = {alias = "", color = colors.purple},
		[ids.s_line] = {alias = "", color = colors.purple}
	}

	local filetypes = {}

	local function get_ft()
		return filetypes[buffer.get_buffer_filetype()]
	end
	-- }}}

	local statusline = {
		left = {
			{"ModeStart", {
				provider = function(hl)
					local mode = modes[vim.fn.mode():byte()]
					local color = colors.grey4
					if mode ~= nil then color = mode.color end
					hl({fg = color})
					return "   " .. edge.left
				end
			}},
			{"ModeMid", {
				provider = function(hl)
					local ft = get_ft()
					local alias = vim.fn.mode():byte()
					local mode = modes[alias]
					local color = colors.red
					if mode ~= nil then
						alias = mode.alias
						color = mode.color
					end
					if ft then alias = vim.b.toggle_number or ft.icon end
					hl({fg = colors.grey4, bg = color})
					return "  " .. alias .. "  "
				end
			}},
		},
		short_line_left = {
			{"BubbleBOpen", {
					provider = function() return "   " end,
					highlight = {colors.grey4}
			}},
		}
	}
	-- local statusline = {
	-- 	left = {
	-- 		{"ModeStart", {
	-- 			provider = function(hl)
	-- 				local mode = modes[vim.fn.mode():byte()]
	-- 				local color = colors.grey4
	-- 				if mode ~= nil then color = mode.color end
	-- 				hl({fg = color})
	-- 				return "   " .. edge.left
	-- 			end
	-- 		}},
	-- 		{"ModeMid", {
	-- 			provider = function(hl)
	-- 				local ft = get_ft()
	-- 				local mode = modes[vim.fn.mode():byte()]
	-- 				local alias = vim.fn.mode():byte()
	-- 				local color = colors.red
	-- 				if mode ~= nil then
	-- 					alias = mode.alias
	-- 					color = mode.color
	-- 				end
	-- 				if ft then alias = vim.b.toggle_number or ft.icon end
	-- 				hl({fg = colors.grey4, bg = color})
	-- 				return "  " .. alias .. "  "
	-- 			end
	-- 		}},
	-- 		{"FileIcon", {
	-- 			provider = function()
	-- 				return "   " .. fileinfo.get_file_icon()
	-- 			end,
	-- 			condition = is_file,
	-- 			highlight = {
	-- 				fileinfo.get_file_icon_color,
	-- 				colors.grey4
	-- 			}
	-- 		}},
	-- 		{"FileName", {
	-- 			provider = function()
	-- 				if vim.g.started_by_firenvim then return "" end
	-- 				local ft = get_ft()
	-- 				if not ft then
	-- 					local file = vim.fn.expand('%:t')
	-- 					if vim.fn.empty(file) == 1 then return '' end
	-- 					return file .. ' '
	-- 				end
	-- 				return "   " .. ft.name .. " "
	-- 			end,
	-- 			highlight = {colors.grey7, colors.grey4},
	-- 			separator = edge.right .. " ",
	-- 			separator_highlight = {colors.grey4, colors.grey2}
	-- 		}},
	-- 		{"FileState", {
	-- 			provider = function(hl)
	-- 				local icon = " "
	-- 				if vim.bo.readonly then
	-- 					icon = ""
	-- 					hl({fg = colors.red})
	-- 				end
	-- 				if vim.bo.modifiable then
	-- 					if vim.bo.modified then icon = "" end
	-- 				end
	-- 				return icon .. " "
	-- 			end,
	-- 			condition = comp_and(is_file, min_width(54)),
	-- 			highlight = {colors.green, colors.grey2}
	-- 		}},
	-- 	}
	-- }

	local function new_hl(area, section)
		return function(colors)
			colors = colors or {}
			local highlight = ""
			if colors.fg then highlight = highlight .. " guifg=" .. colors.fg end
			if colors.bg then highlight = highlight .. " guibg=" .. colors.bg end
			if highlight == "" then return end
			vim.cmd('hi Galaxy' .. area .. section .. highlight)
		end
	end

	local function convert(area, area_name, section, index, original)
		local hl = new_hl(area_name, section[1])
		section[2].provider = function() return original(hl) end
		area[index] = {[area_name .. section[1]] = section[2]}
	end

	for area_name, sections in pairs(statusline) do
		local area = gl.section[area_name]
		if area then
			for index, section in ipairs(sections) do
				local original = section[2].provider
				local t = type(original)
				if t == "function" then
					convert(area, area_name, section, index, original)
				end
			end
		end
	end
end
