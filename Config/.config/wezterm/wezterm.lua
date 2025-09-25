local wezterm = require("wezterm")
local config = wezterm.config_builder()
local function merge_config(file)
    for k, v in pairs(require(file)) do
        config[k] = v
    end
end

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    config.default_prog = { "pwsh.exe" }
elseif wezterm.target_triple == "aarch64-apple-darwin" then
    config.default_prog = { "zsh" }
elseif wezterm.target_triple == "x86_64-unknown-linux-gnu" then
    config.default_prog = { "bash" }
end

config.mouse_bindings = require("config/mousebinds").mouse_bindings
merge_config("config/general")
merge_config("config/colorscheme")
merge_config("config/frame")
merge_config("config/font")
merge_config("config/tabbar")
merge_config("config/keybinds")
-- merge_config("config/DEBUGLINE")

return config
