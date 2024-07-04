-- Nicer filetree than NetRW
return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				open_on_setup = true,
				event_handlers = {
					{
						event = "neo_tree_buffer_enter",
						handler = function(arg)
							vim.cmd [[
                          setlocal relativenumber
                        ]]
						end,
					}
				},
				filesystem = {
					filtered_items = {
						visible = true, -- when true, they will just be displayed differently than normal items
						hide_dotfiles = true,
						hide_gitignored = true,
						hide_hidden = true, -- only works on Windows for hidden files/directories
						hide_by_name = {
							--"node_modules"
						},
					},

				},
			})
			require("helpers.keys").map(
				{ "n", "v" },
				"<leader>e",
				"<cmd>Neotree toggle<cr>set relativenumber<cr>",
				"Toggle file explorer"
			)
			-- Function to toggle hidden files in NeoTree
			local function toggle_neo_tree_hidden_files()
				local visible = require("neo-tree").config.filesystem.filtered_items.visible
				require("neo-tree").config.filesystem.filtered_items.visible = not visible
				-- Replace 'NeoTreeRefresh' with the appropriate command if needed
				vim.cmd("Neotree toggle")
				vim.cmd("Neotree toggle")
				--                vim.cmd('Neotree toggle')
			end

			-- Create a NeoVim command that calls the Lua function
			vim.api.nvim_create_user_command('ToggleHiddenFiles', toggle_neo_tree_hidden_files, {})

			-- Function to toggle hidden files in NeoTree
		end,

	},
}
