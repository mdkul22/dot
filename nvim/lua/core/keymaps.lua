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

vim.api.nvim_create_user_command("DiagnosticToggle", function()
    local config = vim.diagnostic.config
    local vt = config().virtual_text
    config {
        virtual_text = not vt,
        underline = not vt,
        --signs = not vt,
    }
end, { desc = "toggle diagnostic" })

function SetAutoCmp(mode)
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
vim.cmd('command AutoCmpOn lua SetAutoCmp(true)')
-- disable automatic competion popup on typing
vim.cmd('command AutoCmpOff lua SetAutoCmp(false)')
map('n', '<leader>dt', '<Cmd>DiagnosticToggle<CR>', 'Diagnostics Toggle')
map('n', '<leader>co', '<Cmd>AutoCmpOn<CR>', "Auto Complete On")
map('n', '<leader>cO', '<Cmd>AutoCmpOff<CR>', "Auto Complete Off")
-- map('n', '<leader>nt', '<Cmd>botright split | resize 10 | term<CR>', opts)
map('t', '<ESC><ESC>', [[<C-\><C-n>]], "?")
map('n', '<leader>hh', '<Cmd>A<CR>', "header toggle")
map('n', '<leader>b.', '<Cmd>BufferNext<CR>', "Next buffer")
map('n', '<leader>b,', '<Cmd>BufferPrevious<CR>', "Previous buffer")
map('n', '<leader>bc', '<Cmd>BufferCloseAllButCurrentOrPinned<CR>', "Close all buffers")
map('n', '<leader>bp', '<Cmd>BufferPin<CR>', "Pin buffer")
map('n', '<leader>bx', '<Cmd>BufferClose<CR>', "Close buffer")
map('n', '<leader>bs', '<Cmd>Telescope buffers<CR>', "Search buffers")
map('n', '<leader>bn', '<Cmd>echo expand(\'%:p:h\')<CR>', "Get buffer directory")
-- map('n', '<C-p>', "<Cmd>lua require('fzf-lua').files()<CR>", opts)
map('n', '<C-p>', "<Cmd>Telescope find_files<CR>", "Find Files")
-- map('n', '<C-g>', "<Cmd>lua require('fzf-lua').live_grep()<CR>", opts)
map('n', '<C-g>', "<Cmd>Telescope live_grep<CR>", "Live Grep")
-- map('n', '<C-/>', "<Cmd>lua require('fzf-lua').buffers()<CR>", opts)
-- map('n', '<C-/>', "<Cmd>Telescope <CR>", opts)
vim.api.nvim_del_keymap('n', ';is')
vim.api.nvim_del_keymap('n', ';ih')
vim.api.nvim_del_keymap('i', ';is')
vim.api.nvim_del_keymap('i', ';ih')
vim.api.nvim_del_keymap('i', ';ihn')
vim.api.nvim_del_keymap('n', ';ihn')
-- Create a new note after asking for its title.
map("n", "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", "New note with title")
-- Open notes.
map("n", "<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", "Inspect notes")
-- Open notes associated with the selected tags.
map("n", "<leader>zt", "<Cmd>ZkTags<CR>", "Open Notes with selected tags")
-- Search for the notes matching a given query.
map("n", "<leader>zf", "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>", "Search notes via query")
-- Search for the notes matching the current visual selection.
map("v", "<leader>zf", ":'<,'>ZkMatch<CR>", "Notes fzf search")
