return function()
	local illuminate = require("illuminate")

	vim.g.Illuminate_highlightUnderCursor = 1

	local function next()
		illuminate.next_reference {wrap = true}
	end

	local function prev()
		illuminate.next_reference {reverse = true, wrap = true}
	end

	K.n {'<M-n>', next}
	K.n {'<M-N>', prev}
	K.n {'<M-p>', prev}
end
