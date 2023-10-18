return {
	"bluz71/vim-nightfly-guicolors",
	priority = 1000, -- load before all other plugins.
	config = function()
		vim.cmd([[colorscheme nightfly]])
	end,
}
