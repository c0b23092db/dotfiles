local wezterm = require("wezterm")
config = {}

wezterm.on("update-right-status", function(window, pane)
  local process_name = pane:get_foreground_process_name()
  if process_name then
    process_name = process_name:match("[^\\/]+$") -- ファイル名だけ取得
  else
    process_name = "Unknown"
  end
  window:set_right_status(wezterm.format({ { Text = process_name } }))
end)

return config