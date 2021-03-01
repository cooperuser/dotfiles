local plugin = {name = "galaxyline"}
Plugins[plugin.name] = plugin
local buffer = nil

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

local filetypes = {
	TELESCOPE = {
		icon = "T ",
		name = "telescope"
	},
	UNDOTREE = {
		icon = "",
		name = "undotree"
	},
	NVIMTREE = {
		icon = "",
		name = "nvimtree"
	},
	PACKER = {
		icon = "",
		name = "packer"
	},
	HELP = {
		icon = "",
		name = "help"
	},
	FUGITIVE = {
		icon = "",
		name = "fugitive"
	},
	DASHBOARD = {
		icon = "",
		-- icon = "",
		name = "dashboard"
	}
}

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

local function is_file()
	return not filetypes[buffer.get_buffer_filetype()]
end

local function get_ft()
	return filetypes[buffer.get_buffer_filetype()]
end

local function min_width(width)
	return function() return vim.api.nvim_win_get_width(0) >= width end
end

local function max_width(width)
	return function() return vim.api.nvim_win_get_width(0) < width end
end

local function comp_and(a, b)
	return function() return a() and b() end
end

local function comp_or(a, b)
	return function() return a() or b() end
end

local visible = true
function plugin.toggle()
	if visible then
		require("galaxyline").disable_galaxyline()
	else
		require("galaxyline").load_galaxyline()
	end
	visible = not visible
end

function plugin.settings()
	local gl = require("galaxyline")
	local vcs = require('galaxyline.provider_vcs')
	local fileinfo = require('galaxyline.provider_fileinfo')
	local diagnostic = require('galaxyline.provider_diagnostic')
	buffer = require('galaxyline.provider_buffer')

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

	local statusline = {
		-- Active Left {{{
		left = {
			{"BubbleAOpen", {
					provider = function(hl)
						local mode = modes[vim.fn.mode():byte()]
						local color = colors.grey4
						if mode ~= nil then
							color = mode.color
						end
						hl({fg = color})
						return "   "
					end
			}},
			{"ViMode", {
					provider = function(hl)
						local ft = get_ft()
						local mode = modes[vim.fn.mode():byte()]
						local alias = vim.fn.mode():byte()
						local color = colors.red
						if mode ~= nil then
							alias = mode.alias
							color = mode.color
						end
						if ft then alias = ft.icon end
						hl({fg = colors.grey4, bg = color})
						return "  " .. alias .. "  "
					end
			}},
			{"FileIcon", {
					provider = function()
						return "   " .. fileinfo.get_file_icon()
					end,
					condition = is_file,
					highlight = {
						fileinfo.get_file_icon_color,
						colors.grey4
					}
			}},
			{"FileName", {
					provider = function()
						local ft = get_ft()
						if not ft then
							local file = vim.fn.expand('%:t')
							if vim.fn.empty(file) == 1 then return '' end
							return file .. ' '
						end
						return "   " .. ft.name .. " "
					end,
					highlight = {colors.grey7, colors.grey4},
					separator = " ",
					separator_highlight = {colors.grey4, colors.grey2}
			}},
			{"FileState", {
					provider = function(hl)
						local icon = " "
						if vim.bo.readonly then
							icon = ""
							hl({fg = colors.red})
						end
						if vim.bo.modifiable then
							if vim.bo.modified then icon = "" end
						end
						return icon .. " "
					end,
					condition = comp_and(is_file, min_width(54)),
					highlight = {colors.green, colors.grey2}
			}},
			{"Diagnostic", {
					provider = function(hl)
						local icon = "   "
						local color = colors.grey2
						local errors = diagnostic.get_diagnostic_error()
						if errors ~= "" then
							if errors ~= nil then
								icon = '  '
								color = colors.red
							elseif diagnostic.get_diagnostic_warn() ~= nil then
								icon = '  '
								color = colors.yellow
							elseif diagnostic.get_diagnostic_info() ~= nil then
								icon = '  '
								color = colors.blue
							elseif diagnostic.get_diagnostic_hint() ~= nil then
								icon = '  '
								color = colors.purple
							end
						end
						hl({fg = color})
						return icon
					end,
					condition = comp_and(is_file, min_width(60)),
					highlight = {colors.grey2, colors.grey2}
			}},
			{"Fill", {
					provider = function() return ' ' end,
					highlight = {colors.grey2, colors.grey2}
			}},
		},
		-- }}}
		-- Active Right {{{
		right = {
			{"HexCode", {
					provider = function()
						local line = vim.api.nvim_get_current_line()
						local cursor = vim.api.nvim_win_get_cursor(0)
						local char = line:sub(cursor[2] + 1, cursor[2] + 4)
						return "0x" .. vim.fn.printf("%04x", vim.fn.char2nr(char)) .. "  "
					end,
					condition = comp_and(is_file, min_width(64)),
					highlight = {colors.grey5, colors.grey2}
			}},
			{"Type", {
					provider = function()
						local ft = buffer.get_buffer_filetype()
						local lower = ft:lower()
						if lower == "typescriptreact" then lower = "react" end
						return lower .. "  "
					end,
					condition = comp_and(is_file, min_width(58)),
					highlight = {colors.grey6, colors.grey2}
			}},
			{"BubbleAOpen", {
					provider = function()
						return "█"
					end,
					condition = comp_and(is_file, min_width(48)),
					highlight = {colors.grey4, colors.grey2}
			}},
			{"DiffAdd", {
					provider = vcs.diff_add,
					condition = comp_and(is_file, min_width(52)),
					icon = '+',
					highlight = {colors.green, colors.grey4},
					separator =  ""
			}},
			{"DiffModified", {
					provider = vcs.diff_modified,
					condition = comp_and(is_file, min_width(52)),
					icon = '~',
					highlight = {colors.yellow, colors.grey4},
					separator =  ""
			}},
			{"DiffRemove", {
					provider = vcs.diff_remove,
					condition = comp_and(is_file, min_width(52)),
					icon = '-',
					highlight = {colors.red, colors.grey4},
					separator =  ""
			}},
			{"GitBranch", {
					provider = function()
						local branch = vcs.get_git_branch()
						if branch == nil then
							return "    "
						end
						return " " .. branch:gsub("%s+", "") .. " "
					end,
					condition = comp_and(is_file, min_width(48)),
					highlight = {colors.purple, colors.grey4}
			}},
			{"Percent", {
					provider = function ()
						local data = fileinfo.line_column()
						local column = data:sub(data:find(":") + 1)
						local pad = " "
						if #column > 2 then pad = "" end
						return "  " .. pad .. column .. string.rep(" ", 2 - #column)
					end,
					condition = comp_and(is_file, min_width(48)),
					highlight = {colors.grey4, colors.blue}
			}},
			{"BubbleBOpen", {
					provider = function()
						return ""
					end,
					condition = comp_or(get_ft, max_width(48)),
					highlight = {colors.blue}
			}},
			{"BubbleAClose", {
					provider = function()
						return "█  "
					end,
					highlight = {colors.blue}
			}}
		},
		-- }}}
		-- Inactive Left {{{
		short_line_left = {
			{"BubblebOpen", {
					provider = function() return "   " end,
					highlight = {colors.grey4}
			}},
			{"ViMode", {
					provider = function()
						local ft = get_ft()
						local icon = "•"
						if ft then icon = ft.icon end
						return "  " .. icon .. " ▕"
					end,
					highlight = {colors.grey6, colors.grey4}
			}},
			{"FileIcon", {
					provider = function() return "   " .. fileinfo.get_file_icon() end,
					condition = is_file,
					highlight = {
						colors.grey6,
						colors.grey4
					}
			}},
			{"FileName", {
					provider = function()
						local ft = get_ft()
						if not ft then
							local file = vim.fn.expand('%:t')
							if vim.fn.empty(file) == 1 then return '' end
							return file .. ' '
						end
						return "   " .. ft.name .. " "
					end,
					highlight = {colors.grey6, colors.grey4},
					separator = " ",
					separator_highlight = {colors.grey4, colors.grey2}
			}},
			{"FileState", {
					provider = function(hl)
						local icon = " "
						if vim.bo.readonly then
							icon = ""
							hl({fg = colors.red})
						end
						if vim.bo.modifiable then
							if vim.bo.modified then icon = "" end
						end
						return icon .. " "
					end,
					condition = min_width(54),
					highlight = {colors.green, colors.grey2}
			}},
		},
		-- }}}
		-- Inactive Right {{{
		short_line_right = {
			{"BubbleAOpen", {
					provider = function()
						local extra = ""
						if min_width(48)() then extra = "█" end
						return "" .. extra
					end,
					condition = is_file,
					highlight = {colors.grey4, colors.grey2}
			}},
			{"DiffAdd", {
					provider = vcs.diff_add,
					condition = comp_and(is_file, min_width(52)),
					icon = '+',
					highlight = {colors.grey6, colors.grey4},
					separator =  ""
			}},
			{"DiffModified", {
					provider = vcs.diff_modified,
					condition = comp_and(is_file, min_width(52)),
					icon = '~',
					highlight = {colors.grey6, colors.grey4},
					separator =  ""
			}},
			{"DiffRemove", {
					provider = vcs.diff_remove,
					condition = comp_and(is_file, min_width(52)),
					icon = '-',
					highlight = {colors.grey6, colors.grey4},
					separator =  ""
			}},
			{"GitBranch", {
					provider = function()
						local branch = vcs.get_git_branch()
						if branch == nil then
							return "    "
						end
						return " " .. branch:gsub("%s+", "") .. " "
					end,
					condition = comp_and(is_file, min_width(48)),
					highlight = {colors.grey6, colors.grey4}
			}},
			{"Percent", {
					provider = function ()
						local data = fileinfo.line_column()
						local column = data:sub(data:find(":") + 1)
						local pad = " "
						if #column > 2 then pad = "" end
						return "▏" .. pad .. column .. string.rep(" ", 2 - #column)
					end,
					condition = comp_and(is_file, min_width(48)),
					highlight = {colors.grey6, colors.grey4}
			}},
			{"BubbleBClose", {
					provider = function()
						return "█  "
					end,
					condition = is_file,
					highlight = {colors.grey4}
			}},
			{"BubbleCClose", {
					provider = function()
						return "█  "
					end,
					condition = get_ft,
					highlight = {colors.grey0}
			}}
		}
		-- }}}
	}

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

function plugin.keybinds()
	K.sp("S", "<cmd>lua Plugins.galaxyline.toggle()<CR>")
end

return function()
	Plugins.galaxyline.settings()
	K.plugin(Plugins.galaxyline)
end

