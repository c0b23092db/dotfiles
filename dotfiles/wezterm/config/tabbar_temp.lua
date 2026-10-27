local config = {}

local wezterm = require("wezterm")
local load_csv = require("config/tabicon")
local csv_data = load_csv(wezterm.config_dir .. "/config/tabicon.csv")
local text_width = #"Powershell"
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle
local function resolve_icon(icon)
  if not icon or icon == "" then
    return ""
  end
  local prefix = "wezterm.nerdfonts."
  if icon:sub(1, #prefix) == prefix then
    local key = icon:sub(#prefix + 1)
    return wezterm.nerdfonts[key] or icon
  end
  return icon
end
local function get_process_name(tab)
  local path = tab.active_pane.foreground_process_name or ""
  local name = wezterm.basename(path)
  if name == "nvim" then
    return "nvim"
  end
  return name
end
wezterm.on("format-tab-title", function(tab, _, _, _, _, _)
-- (tab, tabs, panes, config, hover, max_width)
    -- タブの色
    local foreground = tab.is_active and "#F0F0F0" or "#E0E0E0"
    local background = tab.is_active and "#0050A0" or "#909090"
    local edge_background = "None"
    local edge_foreground = background

    -- タブのアイコン
    local process_name = get_process_name(tab)
    local tab_info = csv_data[process_name] or {name = process_name, icon = wezterm.nerdfonts.md_console_line, color = "#50A0F0"}
    local name = tab_info.name
    local icon = tab.active_pane.is_zoomed and wezterm.nerdfonts.md_magnify_plus_outline or resolve_icon(tab_info.icon)
    local color = tab_info.color

    name = wezterm.truncate_right(name .. string.rep(" ",text_width - #name), text_width)

    return {
        { Background = { Color = edge_background } },
        { Foreground = { Color = edge_foreground } },
        { Text = SOLID_LEFT_ARROW },
        { Foreground = { Color = color } },
        { Background = { Color = background } },
        { Text = icon .. "  "},
        { Foreground = { Color = foreground } },
        { Text = name },
        { Background = { Color = edge_background } },
        { Foreground = { Color = edge_foreground } },
        { Text = SOLID_RIGHT_ARROW },
    }
end)

return config