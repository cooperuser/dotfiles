-- luacheck: globals BGToggle BGApply

local active = true

local function BGTurnOn()
	vim.opt.cursorline = true
	vim.cmd("colorscheme glowbeam")
end

local function BGTurnOff()
	vim.opt.cursorline = false
	vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
end

function BGToggle()
	if active then
		BGTurnOff()
		active = false
	else
		BGTurnOn()
		active = true
	end
end

function BGApply()
	if active then
		BGTurnOn()
	else
		BGTurnOff()
	end
end

K.sp('X', "<cmd>lua BGToggle()<CR>")

return {toggle = BGToggle, apply = BGApply}

