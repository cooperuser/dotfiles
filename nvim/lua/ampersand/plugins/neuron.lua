local plugin = {name = "neuron"}
Plugins[plugin.name] = plugin

function plugin.settings()
	require'neuron'.setup {
		virtual_titles = true,
		mappings = true,
		run = nil, -- function to run when in neuron dir
		neuron_dir = "~/temp/neuron", -- the directory of all of your notes, expanded by default (currently supports only one directory for notes, find a way to detect neuron.dhall to use any directory)
		leader = "gz", -- the leader key to for all mappings, remember with 'go zettel'
	}
end

function plugin.keybinds()

end

return function()
	Plugins.neuron.settings()
	K.plugin(Plugins.neuron)
end

