-- Miscelaneous fun stuff
return {

	-- Better buffer closing actions. Available via the buffers helper.
	{
		"kazhala/close-buffers.nvim",
		opts = {
			preserve_window_layout = { "this", "nameless" },
		},
	}, 
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	"tpope/vim-surround", -- Surround stuff with the ys-, cs-, ds- commands
	{
		"romgrk/barbar.nvim",
		dependencies = {
		  'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
		  'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
		},
		init = function() vim.g.barbar_auto_setup = false end,
		opts = {
		  -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
		  -- animation = true,
		  -- insert_at_start = true,
		  -- …etc.
		},
		version = '^1.0.0', -- optional: only update when a new 1.x version is released
	},
	'ojroques/nvim-hardline',
}
