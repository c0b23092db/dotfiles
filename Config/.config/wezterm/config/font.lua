local config = {}

config.font = require("wezterm").font_with_fallback{
    {
        family = "UDEV Gothic JPDOC",
        weight="Regular",stretch="Normal",italic=false
    },
    "Noto Color Emoji",
    "Symbols Nerd Font Mono",
}
config.font_size = 12.0

return config