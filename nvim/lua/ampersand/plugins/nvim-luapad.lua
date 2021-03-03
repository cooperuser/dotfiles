return function()
	local luapad = require("luapad")

	luapad.config {
		error_indicator = false
	}

	K.q {"L", luapad.init}
end
