-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "markdown",
      "markdown_inline",
      "bash",
      "c",
      "cpp",
      "python",
      "vim",
      "yaml",
    },
    highlight = {
      enable = true,
      disable = { "markdown", "markdown_inline" },
      additional_vim_regex_highlighting = { "markdown" },
    },
    indent = {
      enable = true,
      disable = { "markdown" },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<c-space>",
        node_incremental = "<c-space>",
        scope_incremental = "<c-s>",
        node_decremental = "<c-S-space>",
      },
    },
  },
}
