-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:

---@type LazySpec
return {
  {
    "stevearc/aerial.nvim",
    version = "v3.1.0",
  },
  {
    "RRethy/vim-illuminate",
    opts = {
      filetype_overrides = {
        c = { providers = { "lsp", "regex" } },
        h = { providers = { "lsp", "regex" } },
        cpp = { providers = { "lsp", "regex" } },
      },
    },
  },

  -- == Examples of Adding Plugins ==
  {
    "ray-x/lsp_signature.nvim",
    event = "LspAttach",
    opts = {
      bind = true,
      floating_window = false,
      hint_enable = false,
    },
    config = function(_, opts) require("lsp_signature").setup(opts) end,
  },
  -- == Examples of Overriding Plugins ==

  -- customize dashboard options
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = table.concat({
            "███████████████████████████████████████████████████████████",
            "█▌                                                       ▐█",
            "█▌                                                       ▐█",
            "█▌  ███╗   ██╗██╗   ██╗██╗   ██╗██╗   ██╗██╗███╗   ███╗  ▐█",
            "█▌  ████╗  ██║██║   ██║██║   ██║██║   ██║██║████╗ ████║  ▐█",
            "█▌  ██╔██╗ ██║██║   ██║██║   ██║██║   ██║██║██╔████╔██║  ▐█",
            "█▌  ██║╚██╗██║██║   ██║██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║  ▐█",
            "█▌  ██║ ╚████║╚██████╔╝╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║  ▐█",
            "█▌  ╚═╝  ╚═══╝ ╚═════╝  ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝  ▐█",
            "█▌                                                       ▐█",
            "█▌                                                       ▐█",
            "███████████████████████████████████████████████████████████",
          }, "\n"),
          footer = table.concat({
            "	  - Nothing matters, take bold choices fearlessly -		",
            "			            - Question Everything -				        ",
          }, "\n"),
        },
      },
    },
  },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
}
