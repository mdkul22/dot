return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            spec = {
                { "<leader>f", desc = 'File Format', mode = 'n' },
                { "<leader>l", desc = 'Lsp', mode = 'n' },
                { "<leader>c", desc = 'Cmp', mode = 'n' },
                { "<leader>t", desc = 'Tab Actions', mode = 'n' },
                { "<leader>d", desc = 'Diagnostic', mode = 'n' },
                { "<leader>g", desc = 'Git', mode = 'n' },
                { "<leader>h", desc = 'Header', mode = 'n' },
            },
            timeout = true,
            timeoutlen = 1000,
        },
        keys = {
            {
                "<leader>",
                function()
                    require("which-key").show({ keys = "<leader>" })
                end,
                desc = "leader key bindings",
            },
        },
    },
    { 'echasnovski/mini.nvim', version = false },
}
