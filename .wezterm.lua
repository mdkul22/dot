-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Everblush (Gogh)'
config.font = wezterm.font_with_fallback {
    '0xProto',
    'Hack'
}
config.font_size = 18.0

-- and finally, return the configuration to wezterm
return config
