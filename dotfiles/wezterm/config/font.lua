local config = {}

config.font_size = 11.0
config.cell_width = 1.0
config.line_height = 1.1
config.font = require("wezterm").font_with_fallback{
    {
        family = "UDEV Gothic 35NF",
        weight="Regular",stretch="Normal",italic=false,
    },
    {
      family = "Symbols Nerd Font Mono",
      assume_emoji_presentation = true
    },
    "Noto Color Emoji",
}
config.harfbuzz_features = {
    "calt=0",  -- 文脈的合字を無効化
    "liga=0",  -- 標準合字を無効化
    "clig=0",  -- 必須合字を無効化
}
config.treat_east_asian_ambiguous_width_as_wide = false

return config