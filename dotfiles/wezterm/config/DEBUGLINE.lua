local wezterm = require("wezterm")
local config = {}

wezterm.on("update-right-status", function(window, pane)
  local process_name = pane:get_foreground_process_name()
  -- if process_name then
  --   process_name = process_name:match("[^\\/]+$") -- ファイル名だけ取得
  -- else
  --   process_name = "Unknown"
  -- end
  window:set_right_status(wezterm.format({ { Text = process_name } }))
end)

-- wezterm.on('update-right-status', function(window, pane)
--   -- フルスクリーンかどうかの判定
--   local is_fullscreen = window:get_dimensions().is_full_screen
--   local status = ""
--
--   if is_fullscreen then
--     status = " [FS] "
--   end
--
--   window:set_right_status(wezterm.format({
--     {Foreground = {Color = '#f7768e'}},
--     {Text = status},
--   }))
-- end)

return config