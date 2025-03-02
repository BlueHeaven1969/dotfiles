-- Pull in the wezterm API
local wezterm = require('wezterm')

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.color_scheme = 'Catppuccin Mocha'
-- config.window_background_opacity = 0.9
-- config.text_background_opacity = 0.9
config.font = wezterm.font('0xProto Nerd Font')
config.initial_rows = 40
config.initial_cols = 100
config.enable_scroll_bar = true
config.inactive_pane_hsb = {
    saturation = 0.7,
    brightness = 0.6,
}
config.default_prog = { "/bin/fish" }

-- and finally, return the configuration to wezterm
return config

