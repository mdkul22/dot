-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here
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
    require("cmp").setup.buffer { enabled = true }
    --require("cmp").setup({
    --    completion = {
    --        autocomplete = { require('cmp.types').cmp.TriggerEvent.TextChanged }
    --    }
    --})
  else
    require("cmp").setup.buffer { enabled = false }
    --require("cmp").setup({
    --    completion = {
    --        autocomplete = false
    --    }
    --})
  end
end

-- enable automatic completion popup on typing
vim.cmd "command AutoCmpOn lua SetAutoCmp(true)"
-- disable automatic competion popup on typing
vim.cmd "command AutoCmpOff lua SetAutoCmp(false)"

vim.keymap.set("n", "<leader>ld", function()
  --require("lsp_signature").toggle_float_win()
  vim.lsp.buf.signature_help()
end, { desc = "Show Signature Help" })
