-- Miscelaneous fun stuff
return {

    -- Better buffer closing actions. Available via the buffers helper.
    -- for better tag management for projects
    'ludovicchabant/vim-gutentags',
    -- provides better statusline messages
    'ojroques/nvim-hardline',
    'folke/neodev.nvim',
    'vim-scripts/a.vim',     -- go to header file directly
    'roxma/vim-tmux-clipboard', -- copy between panes
    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
            -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
            -- animation = true,
            -- insert_at_start = true,
            -- …etc.
        },
        version = '^1.0.0', -- optional: only update when a new 1.x version is released
    },
    'rcarriga/nvim-notify', -- notify gui
    {
        "chentoast/marks.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        }
    },
    -- better status-line
    {
        'nvim-lualine/lualine.nvim',
        opts = {
            themes = 'everforest',
        },
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    -- everforest colorschemes extra
    {
        "neanias/everforest-nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("everforest").setup({
                -- Your config here
                background = 'hard',
            })
        end,
    },
    {
        "zk-org/zk-nvim",
        config = function()
            require("zk").setup({
                -- Can be "telescope", "fzf", "fzf_lua", "minipick", "snacks_picker",
                -- or select" (`vim.ui.select`). It's recommended to use "telescope",
                -- "fzf", "fzf_lua", "minipick", or "snacks_picker".
                picker = "telescope",

                lsp = {
                    -- `config` is passed to `vim.lsp.start_client(config)`
                    config = {
                        cmd = { "zk", "lsp" },
                        name = "zk",
                        -- on_attach = ...
                        -- etc, see `:h vim.lsp.start_client()`
                    },
                    -- automatically attach buffers in a zk notebook that match the given filetypes
                    auto_attach = {
                        enabled = true,
                        filetypes = { "markdown" },
                    },
                },
            })
        end
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },
}
