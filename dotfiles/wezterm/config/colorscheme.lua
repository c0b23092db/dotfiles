local wezterm = require("wezterm")
local config = wezterm.config_builder()

--[[ - Like Color Scheme -
    'Iceberg (Gogh)'
    'Powershell (Gogh)'
    'Night Owl (Gogh)'
--]]
local scheme = 'Night Owl (Gogh)'
config.window_background_gradient = {
    colors = { wezterm.get_builtin_color_schemes()[scheme].background },
}
config.color_scheme = scheme

return config