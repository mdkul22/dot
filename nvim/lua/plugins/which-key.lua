return {
	{
		"folke/which-key.nvim",
		config = function()
			-- vim.o.timeout = true
			--vim.o.timeoutlen = 500
			local wk = require("which-key")
			wk.register(
				{
					["<leader>"] = {
						f = { name = "File" },
						--d = { name = "Delete/Close" },
						q = { name = "Quit" },
						-- s = { name = "Search" },
						l = { name = "LSP" },
						-- u = { name = "UI" },
						b = { name = "Debugging" },
						g = { name = "Git" },
					},
				}
			)
			wk.setup {
			    plugins = {
				marks = true, -- shows a list of your marks on ' and `
				registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
				-- the presets plugin, adds help for a bunch of default keybindings in Neovim
				-- No actual key bindings are created
				spelling = {
				    enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
				    suggestions = 20, -- how many suggestions should be shown in the list?
				},
			    presets = {
			      operators = false, -- adds help for operators like d, y, ...
			      motions = false, -- adds help for motions
			      text_objects = false, -- help for text objects triggered after entering an operator
			      windows = false, -- default bindings on <c-w>
			      nav = false, -- misc bindings to work with windows
			      z = false, -- bindings for folds, spelling and others prefixed with z
			      g = false, -- bindings for prefixed with g
			    },
			  },
			}
		end
	}
}
