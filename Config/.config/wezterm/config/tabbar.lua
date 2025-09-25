local config = {}
config.enable_tab_bar = true

config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = false
config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false

local wezterm = require("wezterm")
local tabicon = require("config/tabicon")
local text_width = #"Powershell"
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle
wezterm.on("format-tab-title", function(tab, _, _, _, _, _)
-- (tab, tabs, panes, config, hover, max_width)

    -- タブの色
    local foreground = tab.is_active and "#F0F0F0" or "#E0E0E0"
    local background = tab.is_active and "#0050A0" or "#909090"
    local edge_background = "None"
    local edge_foreground = background

    -- タブのアイコン
    local tab_info = tabicon(tab.active_pane.foreground_process_name)
    local icon = tab.active_pane.is_zoomed and wezterm.nerdfonts.md_magnify_plus_outline or tab_info.icon
    local icon_color = tab_info.icon_color
    local title = tab_info.title

    title = wezterm.truncate_right(title .. string.rep(" ",text_width - #title), text_width)

    return {
        { Background = { Color = edge_background } },
        { Foreground = { Color = edge_foreground } },
        { Text = SOLID_LEFT_ARROW },
        { Foreground = { Color = icon_color } },
        { Background = { Color = background } },
        { Text = icon .. " "},
        { Foreground = { Color = foreground } },
        { Text = title },
        { Background = { Color = edge_background } },
        { Foreground = { Color = edge_foreground } },
        { Text = SOLID_RIGHT_ARROW },
    }
end)

return config