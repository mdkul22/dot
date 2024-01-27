-- Miscelaneous fun stuff
return {

    -- Better buffer closing actions. Available via the buffers helper.
    -- for better tag management for projects
    'ludovicchabant/vim-gutentags',
    -- provides better statusline messages
    'ojroques/nvim-hardline',
    --'tpope/vim-sleuth',
    'folke/neodev.nvim',
    'vim-scripts/a.vim',        -- go to header file directly
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
}
