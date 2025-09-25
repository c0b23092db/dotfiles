local config = {}

--[[ - Like Color Scheme -
        'Powershell (Gogh)'
        'Night Owl (Gogh)'
        'iceberg-dark'
--]]
local scheme = 'Night Owl (Gogh)'

config.color_scheme = scheme

config.window_background_gradient = {
    colors = { require("wezterm").get_builtin_color_schemes()[scheme].background },
}

return config