local config = {}

config.font = require("wezterm").font_with_fallback{
    {
        --[[
        - Cascadia Code
        - UDEV Gothic HSJPDOC
        ]]--
        -- family = "Cascadia Code",
        family = "UDEV Gothic 35HSJPDOC",
        weight="Regular",stretch="Normal",italic=false,
    },
    "Noto Color Emoji",
    "Symbols Nerd Font Mono",
}
config.font_size = 12.0
config.harfbuzz_features = {
    "calt=0",  -- 文脈的合字を無効化
    "liga=0",  -- 標準合字を無効化
    "clig=0",  -- 必須合字を無効化
}

return config