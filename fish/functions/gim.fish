function gim
	cd ~/git/glowbeam.vim;
	nvim lua/glowbeam.lua -c "lua require('glowbeam.helper').setup()"
end
