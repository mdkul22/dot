-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()
local act = wezterm.action
-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'EverforestDark (Gogh)'
config.font = wezterm.font_with_fallback {
    '0xProto',
    'Hack'
}
config.window_close_confirmation = 'NeverPrompt'
config.font_size = 16.0
config.mouse_bindings = {
  -- Right click sends "woot" to the terminal
  {
    event = { Down = { streak = 1, button = 'Right' } },
    mods = 'NONE',
    action = act.SendString 'woot',
  },

  -- Change the default click behavior so that it only selects
  -- text and doesn't open hyperlinks
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = act.CompleteSelection 'ClipboardAndPrimarySelection',
  },

  -- and make CTRL-Click open hyperlinks
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = act.OpenLinkAtMouseCursor,
  },
      -- Scrolling up while holding CTRL increases the font size
  {
    event = { Down = { streak = 1, button = { WheelUp = 1 } } },
    mods = 'CTRL',
    action = act.IncreaseFontSize,
  },

  -- Scrolling down while holding CTRL decreases the font size
  {
    event = { Down = { streak = 1, button = { WheelDown = 1 } } },
    mods = 'CTRL',
    action = act.DecreaseFontSize,
  },
  -- NOTE that binding only the 'Up' event can give unexpected behaviors.
  -- Read more below on the gotcha of binding an 'Up' event only.
}
config.keys = {
  -- Move backward one word
  {
    key = 'LeftArrow',
    mods = 'OPT',
    action = wezterm.action.SendString '\x1bb', -- Sends ALT+b
  },
  -- Move forward one word
  {
    key = 'RightArrow',
    mods = 'OPT',
    action = wezterm.action.SendString '\x1bf', -- Sends ALT+f
  },
  -- You might also want to add word deletion
  -- Delete word backward
  {
    key = 'Backspace',
    mods = 'OPT',
    action = wezterm.action.SendString '\x1b\x7f', -- Sends ALT+Backspace
  },
}

-- and finally, return the configuration to wezterm

return config
