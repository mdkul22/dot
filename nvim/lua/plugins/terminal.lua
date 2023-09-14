return {
    {
        'rebelot/terminal.nvim',
        config = function()
            require("terminal").setup({
                layout = { open_cmd = "botright vertical new" },
                cmd = { "zsh" },
            })
        end
    }
}
