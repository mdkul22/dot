local map = require("helpers.keys").map

-- Better window navigation
map("n", "<C-h>", "<C-w><C-h>", "Navigate windows to the left")
map("n", "<C-j>", "<C-w><C-j>", "Navigate windows down")
map("n", "<C-k>", "<C-w><C-k>", "Navigate windows up")
map("n", "<C-l>", "<C-w><C-l>", "Navigate windows to the right")
-- Resize with arrows
map("n", "<C-Up>", ":resize +2<CR>")
map("n", "<C-Down>", ":resize -2<CR>")
map("n", "<C-Left>", ":vertical resize +2<CR>")
map("n", "<C-Right>", ":vertical resize -2<CR>")

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.api.nvim_create_user_command("DiagnosticToggle", function()
	local config = vim.diagnostic.config
	local vt = config().virtual_text
	config {
		virtual_text = not vt,
		underline = not vt,
		--signs = not vt,
	}
end, { desc = "toggle diagnostic" })

function setAutoCmp(mode)
	if mode then
		require('cmp').setup.buffer { enabled = true }
		--require("cmp").setup({
		--    completion = {
		--        autocomplete = { require('cmp.types').cmp.TriggerEvent.TextChanged }
		--    }
		--})
	else
		require('cmp').setup.buffer { enabled = false }
		--require("cmp").setup({
		--    completion = {
		--        autocomplete = false
		--    }
		--})
	end
end

-- enable automatic completion popup on typing
vim.cmd('command AutoCmpOn lua setAutoCmp(true)')
-- disable automatic competion popup on typing
vim.cmd('command AutoCmpOff lua setAutoCmp(false)')
map('n', '<leader>Co', '<Cmd>AutoCmpOn<CR>', opts)
map('n', '<leader>CO', '<Cmd>AutoCmpOff<CR>', opts)
-- map('n', '<leader>nt', '<Cmd>botright split | resize 10 | term<CR>', opts)
map('t', '<ESC><ESC>', [[<C-\><C-n>]], opts)
map('n', '<leader>hh', '<Cmd>A<CR>', opts)
map('n', '<leader>tn', '<Cmd>tabnew<CR>', opts)
map('n', '<leader>tt', '<Cmd>tabnext<CR>', opts)
map('n', '<leader>td', '<Cmd>tabclose<CR>', opts)
-- map('n', '<C-p>', "<Cmd>lua require('fzf-lua').files()<CR>", opts)
map('n', '<C-p>', "<Cmd>Telescope find_files<CR>", opts)
-- map('n', '<C-g>', "<Cmd>lua require('fzf-lua').live_grep()<CR>", opts)
map('n', '<C-g>', "<Cmd>Telescope live_grep<CR>", opts)
-- map('n', '<C-/>', "<Cmd>lua require('fzf-lua').buffers()<CR>", opts)
-- map('n', '<C-/>', "<Cmd>Telescope <CR>", opts)
map('n', '<leader>sv', "<Cmd>source $MYVIMRC<CR>", opts)
map('n', '<leader>bp', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<leader>bn', '<Cmd>BufferNext<CR>', opts)
