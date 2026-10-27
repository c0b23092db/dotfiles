local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- フレーム
config.window_decorations = 'INTEGRATED_BUTTONS'
config.max_fps = 60
config.animation_fps = 60
config.default_cursor_style = "BlinkingBar"
config.win32_system_backdrop = "Disable"
config.window_background_opacity = 0.8
config.text_background_opacity = 0.8
config.window_frame = {
    inactive_titlebar_bg = 'None',
    active_titlebar_bg = 'None',
}
config.colors = {
    tab_bar = {
        inactive_tab_edge = "None"
    }
}
config.inactive_pane_hsb = {
    saturation = 0.8,
    brightness = 0.7,
}
-- カーソル
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'

-- タブバー
config.enable_tab_bar = true
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = false
config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false

return config