return function()
	local snippets = require("snippets")
	local u = require("snippets.utils")

	snippets.snippets = {
		_global = {
			-- If you aren't inside of a comment, make the line a comment.
			copyright = u.force_comment [[Copyright (C) Cooper b. Anderson ${=os.date("%Y")}]];
		};
	}
end
