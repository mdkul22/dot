-- Telescope fuzzy finding (all the things)
return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
		},
		config = function()
			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							['<C-p>'] = require('telescope.actions.layout').toggle_preview,
							['<C-g>'] = require('telescope.actions.layout').toggle_preview,
							["<C-u>"] = false,
							["<C-d>"] = false,
						},
					},
					preview = {                                                                                                                                                                          
						hide_on_startup = true,-- hide previewer when picker starts
					},
				},
			})

			-- Enable telescope fzf native, if installed
			pcall(require("telescope").load_extension, "fzf")

			local map = require("helpers.keys").map
			--map("n", "<leader>fr", require("telescope.builtin").oldfiles, "Recently opened")
			--map("n", "<leader><space>", require("telescope.builtin").buffers, "Open buffers")
			map("n", "<leader>/", function()
				-- You can pass additional configuration to telescope to change theme, layout, etc.
				require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_ivy({
					winblend = 15,
					previewer = false,
				}))
			end, "Search in current buffer")
			map("n", "<C-p>", function()
				-- You can pass additional configuration to telescope to change theme, layout, etc.
				require("telescope.builtin").find_files(require("telescope.themes").get_ivy({
					winblend = 15,
					previewer = false,
				}))
			end, "Search files in current directory")
			map("n", "<C-g>", function()
				-- You can pass additional configuration to telescope to change theme, layout, etc.
				require("telescope.builtin").live_grep(require("telescope.themes").get_ivy({
					winblend = 20,
					previewer = false,
				}))
			end, "live grep")

--			map("n", "<C-p>", require("telescope.builtin").find_files, "Files")
--			map("n", "<leader>sh", require("telescope.builtin").help_tags, "Help")
--			map("n", "<leader>sw", require("telescope.builtin").grep_string, "Current word")
--			map("n", "<C-g>", require("telescope.builtin").live_grep, "Grep")
			map("n", "<leader>sd", require("telescope.builtin").diagnostics, "Diagnostics")

			map("n", "<C-K>", require("telescope.builtin").keymaps, "Search keymaps")
			-- toggle func 
		end,
	},
}
