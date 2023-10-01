local map = require("helpers.keys").map

-- Blazingly fast way out of insert mode
--map("i", "jk", "<esc>")

-- Quick access to some common actions
-- map("n", "<leader>fw", "<cmd>w<cr>", "Write")
-- map("n", "<leader>fa", "<cmd>wa<cr>", "Write all")
-- map("n", "<leader>qq", "<cmd>q<cr>", "Quit")
-- map("n", "<leader>qa", "<cmd>qa!<cr>", "Quit all")
-- map("n", "<leader>dw", "<cmd>close<cr>", "Window")

-- Diagnostic keymaps
-- map('n', 'gx', vim.diagnostic.open_float, "Show diagnostics under cursor")

-- Easier access to beginning and end of lines
-- map("n", "<M-h>", "^", "Go to beginning of line")
-- map("n", "<M-l>", "$", "Go to end of line")

-- Better window navigation
map("n", "<C-h>", "<C-w><C-h>", "Navigate windows to the left")
map("n", "<C-j>", "<C-w><C-j>", "Navigate windows down")
map("n", "<C-k>", "<C-w><C-k>", "Navigate windows up")
map("n", "<C-l>", "<C-w><C-l>", "Navigate windows to the right")

-- Move with shift-arrows
--map("n", "<S-Left>", "<C-w><S-h>", "Move window to the left")
--map("n", "<S-Down>", "<C-w><S-j>", "Move window down")
--map("n", "<S-Up>", "<C-w><S-k>", "Move window up")
--map("n", "<S-Right>", "<C-w><S-l>", "Move window to the right")

-- Resize with arrows
map("n", "<C-Up>", ":resize +2<CR>")
map("n", "<C-Down>", ":resize -2<CR>")
map("n", "<C-Left>", ":vertical resize +2<CR>")
map("n", "<C-Right>", ":vertical resize -2<CR>")

-- Deleting buffers
-- local buffers = require("helpers.buffers")
-- map("n", "<leader>db", buffers.delete_this, "Current buffer")
-- map("n", "<leader>do", buffers.delete_others, "Other buffers")
-- map("n", "<leader>da", buffers.delete_all, "All buffers")

-- Navigate buffers
-- map("n", "<S-l>", ":bnext<CR>")
-- map("n", "<S-h>", ":bprevious<CR>")

-- Stay in indent mode
-- map("v", "<", "<gv")
-- map("v", ">", ">gv")

-- Switch between light and dark modes
-- map("n", "<leader>ut", function()
--	if vim.o.background == "dark" then
--		vim.o.background = "light"
--	else
--		vim.o.background = "dark"
--	end
-- end, "Toggle between light and dark themes")

-- Clear after search
-- map("n", "<leader>ur", "<cmd>nohl<cr>", "Clear highlights")
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
map('n', '<leader>C', '<Cmd>AutoCmpOn<CR>', opts)
map('n', '<leader>c', '<Cmd>AutoCmpOff<CR>', opts)
map('n', '<leader>nt', '<Cmd>botright split | resize 10 | term<CR>', opts)
map('t', '<ESC><ESC>', [[<C-\><C-n>]], opts)
map('n', '<leader>hh', '<Cmd>A<CR>', opts)
map('n', '<leader>tn', '<Cmd>tabnew<CR>', opts)
map('n', '<leader>tt', '<Cmd>tabnext<CR>', opts)
map('n', '<leader>td', '<Cmd>tabclose<CR>', opts)
map('n', '<C-p>', "<Cmd>lua require('fzf-lua').files()<CR>", opts)
map('n', '<C-g>', "<Cmd>lua require('fzf-lua').live_grep()<CR>", opts)
map('n', '<C-/>', "<Cmd>lua require('fzf-lua').grep_curbuf()<CR>", opts)
