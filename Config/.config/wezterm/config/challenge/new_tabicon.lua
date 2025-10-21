local wezterm = require("wezterm")

-- ファイル読み込み
local function load_tabicons()
  local f = io.open(wezterm.config_dir .. "/tabicon.toml", "r")
  local s = f and f:read('a') or ""
  if f then f:close() end
  return wezterm.json_parse(s)
end

local tabicons = load_tabicons()

local function get_tab_icon(tab)
  -- 元の Lua と同様に拡張子除去
  local name = string.gsub(tab:match("[^\\]+$"), ".exe", "")

  local entry = tabicons[name]
  if not entry then
    return { icon = nil, icon_color = nil, title = name }
  end

  local nf_icon = wezterm.nerdfonts[entry.icon] or entry.icon

  return {
    icon = nf_icon,
    icon_color = entry.icon_color,
    title = entry.title or name,
  }
end

return get_tab_icon