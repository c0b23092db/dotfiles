local act = require('wezterm').action
local wezterm = require("wezterm")

return {
  keys = {
    -- Test

    -- [[ Windowsのキーバインド ]] --
    -- 操作
    { key = 'PageUp', mods = 'NONE', action = act.ScrollByPage(-1) },
    { key = 'PageDown', mods = 'NONE', action = act.ScrollByPage(1) },
    { key = 'f', mods = 'CTRL|SHIFT', action = act.Search 'CurrentSelectionOrEmptyString' }, -- 文字の検索
    { key = 'F', mods = 'CTRL|SHIFT', action = act.Search 'CurrentSelectionOrEmptyString' },
    { key = 'p', mods = 'CTRL', action = act.ActivateCommandPalette }, -- コマンドパレットの表示
    { key = 'P', mods = 'CTRL', action = act.ActivateCommandPalette },
    { key = 'F4', mods = 'NONE', action = act.ActivateCommandPalette },
    { key = 'u', mods = 'CTRL|SHIFT', action = act.CharSelect{ copy_on_select = true, copy_to =  'ClipboardAndPrimarySelection' } }, -- Unicode文字の選択
    { key = 'U', mods = 'CTRL|SHIFT', action = act.CharSelect{ copy_on_select = true, copy_to =  'ClipboardAndPrimarySelection' } },
    { key = 'k', mods = 'SHIFT|CTRL', action = act.ClearScrollback 'ScrollbackOnly' }, -- スクロールバックのクリア
    { key = 'K', mods = 'SHIFT|CTRL', action = act.ClearScrollback 'ScrollbackOnly' },
    { key = 'l', mods = 'SHIFT|CTRL', action = act.ClearScrollback 'ScrollbackAndViewport' }, -- スクロールバックのクリア
    { key = 'L', mods = 'SHIFT|CTRL', action = act.ClearScrollback 'ScrollbackAndViewport' },
    { key = 'o', mods = 'SHIFT|CTRL', action = act.ActivateCopyMode }, -- コピーモードの開始
    { key = 'O', mods = 'SHIFT|CTRL', action = act.ActivateCopyMode },

    -- ウィンドウ
    { key = 'n', mods = 'CTRL|SHIFT', action = act.SpawnWindow }, -- ウィンドウの追加
    { key = 'N', mods = 'CTRL|SHIFT', action = act.SpawnWindow },
    { key = '0', mods = 'CTRL', action = act.ResetFontSize }, -- 文字サイズリセット
    { key = ';', mods = 'CTRL', action = act.IncreaseFontSize }, -- 文字サイズ拡大
    { key = '+', mods = 'SHIFT|CTRL', action = act.IncreaseFontSize },
    { key = '-', mods = 'CTRL', action = act.DecreaseFontSize }, -- 文字サイズ縮小
    { key = '=', mods = 'SHIFT|CTRL', action = act.DecreaseFontSize },

    -- ペイン
    { key = 'z', mods = 'SHIFT|ALT', action = act.TogglePaneZoomState }, -- アクティブペインの強調表示
    { key = 'Z', mods = 'SHIFT|ALT', action = act.TogglePaneZoomState },
    { key = 'c', mods = 'SHIFT|ALT', action = act.CloseCurrentPane { confirm = false } }, -- 現在のペインの削除
    { key = 'C', mods = 'SHIFT|ALT', action = act.CloseCurrentPane { confirm = false } },
    { key = 'd', mods = 'SHIFT|ALT', action = act.SplitHorizontal{ domain = 'CurrentPaneDomain' } }, -- 右に新しいペインを追加
    { key = 'D', mods = 'SHIFT|ALT', action = act.SplitHorizontal{ domain = 'CurrentPaneDomain' } },
    { key = 's', mods = 'SHIFT|ALT', action = act.SplitVertical{ domain = 'CurrentPaneDomain' } }, -- 下に新しいペインを追加
    { key = 'S', mods = 'SHIFT|ALT', action = act.SplitVertical{ domain = 'CurrentPaneDomain' } },
    -- { key = 'r', mods = 'SHIFT|ALT', action = act.SplitVertical{ domain = 'CurrentPaneDomain' } }, -- 下に小さな新しいペインを追加
    -- { key = 'R', mods = 'SHIFT|ALT', action = act.SplitVertical{ domain = 'CurrentPaneDomain' } },
    { key = 'LeftArrow', mods = 'SHIFT|ALT', action = act.AdjustPaneSize{ 'Left', 1 } }, -- ペインのサイズ調整
    { key = 'RightArrow', mods = 'SHIFT|ALT', action = act.AdjustPaneSize{ 'Right', 1 } },
    { key = 'UpArrow', mods = 'SHIFT|ALT', action = act.AdjustPaneSize{ 'Up', 1 } },
    { key = 'DownArrow', mods = 'SHIFT|ALT', action = act.AdjustPaneSize{ 'Down', 1 } },

    { key = 'UpArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Up' }, -- ペイン間のカーソル移動
    { key = 'DownArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Down' },
    { key = 'RightArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Right' },
    { key = 'LeftArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Left' },

    -- タブ
    { key = 'T', mods = 'CTRL|SHIFT', action = act.SpawnTab 'CurrentPaneDomain' }, -- タブの追加
    { key = 'W', mods = 'CTRL|SHIFT', action = act.CloseCurrentTab{ confirm = false } }, -- タブの削除
    { key = '{', mods = 'SHIFT|CTRL', action = act.MoveTabRelative(-1) }, -- タブの移動
    { key = '}', mods = 'SHIFT|CTRL', action = act.MoveTabRelative(1) },
    -- タブ切り替え
    { key = 'Tab', mods = 'CTRL', action = act.ActivateTabRelative(1) }, -- タブの切り替え
    { key = 'Tab', mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(-1) },
    { key = '1', mods = 'CTRL', action = act.ActivateTab(0) }, -- タブの切り替え（数字）
    { key = '2', mods = 'CTRL', action = act.ActivateTab(1) },
    { key = '3', mods = 'CTRL', action = act.ActivateTab(2) },
    { key = '4', mods = 'CTRL', action = act.ActivateTab(3) },
    { key = '5', mods = 'CTRL', action = act.ActivateTab(4) },
    { key = '6', mods = 'CTRL', action = act.ActivateTab(5) },
    { key = '7', mods = 'CTRL', action = act.ActivateTab(6) },
    { key = '8', mods = 'CTRL', action = act.ActivateTab(7) },
    { key = '9', mods = 'CTRL', action = act.ActivateTab(-1) },

    -- コピーペースト
    { -- https://zenn.dev/1step621/articles/d35cbfa0b4ebd0
      key = 'c',mods = 'CTRL',
      action = wezterm.action_callback(function(window, pane)
        local selection_text = window:get_selection_text_for_pane(pane)
        local is_selection_active = string.len(selection_text) ~= 0
        if is_selection_active then
          window:perform_action(wezterm.action.CopyTo('ClipboardAndPrimarySelection'), pane)
        else
          window:perform_action(wezterm.action.SendKey{ key='c', mods='CTRL' }, pane)
        end
      end),
    },
    --[[
    { key = 'C', mods = 'CTRL', action = act.CopyTo(Clipboard) }, -- コピー
    { key = 'V', mods = 'CTRL', action = act.PasteFrom(Clipboard) }, -- 貼り付け
    --]]

    { key = 'phys:Space', mods = 'SHIFT|CTRL', action = act.QuickSelect }, -- クイックセレクトの開始
    { key = 'F5', mods = 'NONE', action = act.ReloadConfiguration }, -- Weztermの設定の再読み込み
    { key = 'F11', mods = 'NONE', action = act.ToggleFullScreen }, -- フルスクリーン化
    { key = 'F12', mods = 'NONE',action = act.ShowDebugOverlay }, -- デバッグ情報の表示
    -- { key = 'Insert', mods = 'SHIFT', action = act.PasteFrom 'Clipboard' },
    -- { key = 'Insert', mods = 'CTRL', action = act.CopyTo 'Clipboard' },
    { key = 'Copy', mods = 'NONE', action = act.CopyTo 'Clipboard' },
    { key = 'Paste', mods = 'NONE', action = act.PasteFrom 'Clipboard' },
  },

  key_tables = {
    copy_mode = { -- コピーモード
      -- 操作
      { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
      -- { key = 'phys:Space', mods = 'NONE', action = act.CopyMode{ SetSelectionMode =  'Cell' } },

      -- 移動
      { key = 'Tab', mods = 'NONE', action = act.CopyMode 'MoveForwardWord' },
      { key = 'Tab', mods = 'SHIFT', action = act.CopyMode 'MoveBackwardWord' },
      { key = 'Enter', mods = 'NONE', action = act.CopyMode 'MoveToStartOfNextLine' },
      { key = 'Home', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLine' },
      { key = 'End', mods = 'NONE', action = act.CopyMode 'MoveToEndOfLineContent' },
      { key = 'LeftArrow', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
      { key = 'RightArrow', mods = 'NONE', action = act.CopyMode 'MoveRight' },
      { key = 'UpArrow', mods = 'NONE', action = act.CopyMode 'MoveUp' },
      { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'MoveDown' },
      { key = 'LeftArrow', mods = 'CTRL', action = act.CopyMode 'MoveBackwardWord' },
      { key = 'RightArrow', mods = 'CTRL', action = act.CopyMode 'MoveForwardWord' },
    },

    search_mode = { -- 検索モード
      { key = 'Enter', mods = 'NONE', action = act.CopyMode 'PriorMatch' },
      { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
      { key = 'n', mods = 'CTRL', action = act.CopyMode 'NextMatch' },
      { key = 'p', mods = 'CTRL', action = act.CopyMode 'PriorMatch' },
      { key = 'r', mods = 'CTRL', action = act.CopyMode 'CycleMatchType' },
      { key = 'u', mods = 'CTRL', action = act.CopyMode 'ClearPattern' },
      { key = 'PageUp', mods = 'NONE', action = act.CopyMode 'PriorMatchPage' },
      { key = 'PageDown', mods = 'NONE', action = act.CopyMode 'NextMatchPage' },
      { key = 'UpArrow', mods = 'NONE', action = act.CopyMode 'PriorMatch' },
      { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'NextMatch' },
    },

  }
}
