return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            spec = {
                { "<leader>f", desc = 'File Format', mode = 'n' },
                { "<leader>l", desc = 'LSP', mode = 'n', icon = {icon="🤖"}},
                { "<leader>c", desc = 'Autocomplete', mode = 'n', icon = {icon="🏁"} },
                { "<leader>b", desc = 'Buffer Actions', mode = 'n'},
                { "<leader>d", desc = 'Diagnostic', mode = 'n'},
                { "<leader>g", desc = 'Git', mode = 'n' },
                { "<leader>M", desc = 'Mason', mode = 'n', icon = "M"},
                { "<leader>h", desc = 'Header', mode = 'n', icon = ".h"},
                { "<leader>z", desc = 'Zk Actions', mode = 'n', icon = {icon="📝"}},
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
