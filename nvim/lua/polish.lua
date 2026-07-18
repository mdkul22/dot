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
  vim.g.autocmp_enabled = mode

  pcall(function() require("cmp").setup.buffer { enabled = mode } end)

  pcall(function()
    if not mode then require("blink.cmp").hide() end
  end)
end

-- enable automatic completion popup on typing
vim.cmd "command AutoCmpOn lua SetAutoCmp(true)"
-- disable automatic competion popup on typing
vim.cmd "command AutoCmpOff lua SetAutoCmp(false)"

vim.keymap.set("n", "<leader>ld", function()
  --require("lsp_signature").toggle_float_win()
  vim.lsp.buf.signature_help()
end, { desc = "Show Signature Help" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "objc", "objcpp" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.autoindent = true
    vim.opt_local.cindent = true
    vim.opt_local.cinkeys:append "<CR>"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function(args)
    vim.opt_local.wrap = true
    pcall(vim.treesitter.stop, args.buf)
    vim.bo[args.buf].syntax = "markdown"
  end,
})
