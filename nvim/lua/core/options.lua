-- Create the undo directory if it doesn't exist
local undodir = vim.fn.stdpath('config') .. '/undodir'
if not vim.fn.isdirectory(undodir) then
  vim.fn.mkdir(undodir, 'p')
end

local opts = {
	tabstop = 4,
	softtabstop = 4,
	shiftwidth = 4,
	expandtab = true,
	wrap = false,
	termguicolors = true,
	number = true,
	relativenumber = true,
    undofile = true,
    undodir = undodir,
}

-- Set options from table
for opt, val in pairs(opts) do
	vim.o[opt] = val
end

-- Set other options
local colorscheme = require("helpers.colorscheme")
vim.cmd.colorscheme(colorscheme)
vim.g.neotree_open_after_n_toggle = 1
