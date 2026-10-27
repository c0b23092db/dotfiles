local wezterm = require("wezterm")
local act = wezterm.action

return {
  keys = {
    -- [[ Windowsのキーバインド ]] --
    -- 操作
    { key = 'PageUp', mods = 'NONE', action = act.ScrollByPage(-1) }, -- 1ページ分スクロール
    { key = 'PageDown', mods = 'NONE', action = act.ScrollByPage(1) },
    { key = 'e', mods = 'CTRL', action = act.ActivateCommandPalette }, -- コマンドパレットの表示
    { key = 'E', mods = 'CTRL', action = act.ActivateCommandPalette },
    { key = 'F4', mods = 'NONE', action = act.ActivateCommandPalette },
    { key = 'f', mods = 'CTRL|SHIFT', action = act.Search 'CurrentSelectionOrEmptyString' }, -- 文字の検索
    { key = 'F', mods = 'CTRL|SHIFT', action = act.Search 'CurrentSelectionOrEmptyString' },
    -- { key = 'u', mods = 'CTRL|SHIFT', action = act.CharSelect{ copy_on_select = true, copy_to =  'ClipboardAndPrimarySelection' } }, -- Unicode文字の選択
    -- { key = 'U', mods = 'CTRL|SHIFT', action = act.CharSelect{ copy_on_select = true, copy_to =  'ClipboardAndPrimarySelection' } },
    { key = 'k', mods = 'CTRL|SHIFT', action = act.ClearScrollback 'ScrollbackOnly' }, -- スクロールバックのクリア
    { key = 'K', mods = 'CTRL|SHIFT', action = act.ClearScrollback 'ScrollbackOnly' },
    { key = 'l', mods = 'CTRL|SHIFT', action = act.ClearScrollback 'ScrollbackAndViewport' }, -- スクロールバックのクリア
    { key = 'L', mods = 'CTRL|SHIFT', action = act.ClearScrollback 'ScrollbackAndViewport' },
    { key = 'o', mods = 'CTRL|SHIFT', action = act.ActivateCopyMode }, -- コピーモードの開始
    { key = 'O', mods = 'CTRL|SHIFT', action = act.ActivateCopyMode },

    -- ウィンドウ
    { key = 'n', mods = 'CTRL|SHIFT', action = act.SpawnWindow }, -- ウィンドウの追加
    { key = 'N', mods = 'CTRL|SHIFT', action = act.SpawnWindow },
    { key = '0', mods = 'CTRL', action = act.ResetFontSize }, -- 文字サイズリセット
    { key = ';', mods = 'CTRL', action = act.IncreaseFontSize }, -- 文字サイズ拡大
    { key = '+', mods = 'CTRL|SHIFT', action = act.IncreaseFontSize },
    { key = '-', mods = 'CTRL', action = act.DecreaseFontSize }, -- 文字サイズ縮小
    { key = '=', mods = 'CTRL|SHIFT', action = act.DecreaseFontSize },

    -- ペイン
    { key = 'z', mods = 'SHIFT|ALT', action = act.TogglePaneZoomState }, -- アクティブペインの強調表示
    { key = 'Z', mods = 'SHIFT|ALT', action = act.TogglePaneZoomState },
    { key = 'W', mods = 'CTRL|SHIFT', action = act.CloseCurrentPane { confirm = false } }, -- 現在のペインの削除
    { key = '|', mods = 'SHIFT|ALT', action = act.SplitHorizontal{ domain = 'CurrentPaneDomain' } }, -- 右に新しいペインを追加
    { key = '=', mods = 'SHIFT|ALT', action = act.SplitVertical{ domain = 'CurrentPaneDomain' } }, -- 下に新しいペインを追加
    { key = 'UpArrow', mods = 'SHIFT|ALT', action = act.AdjustPaneSize{ 'Up', 1 } }, -- ペインのサイズ調整
    { key = 'DownArrow', mods = 'SHIFT|ALT', action = act.AdjustPaneSize{ 'Down', 1 } },
    { key = 'LeftArrow', mods = 'SHIFT|ALT', action = act.AdjustPaneSize{ 'Left', 1 } },
    { key = 'RightArrow', mods = 'SHIFT|ALT', action = act.AdjustPaneSize{ 'Right', 1 } },
    { key = 'UpArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Up' }, -- ペイン間のカーソル移動
    { key = 'DownArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Down' },
    { key = 'LeftArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
    { key = 'RightArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },

    -- タブ
    { key = 'T', mods = 'CTRL|SHIFT', action = act.SpawnTab 'CurrentPaneDomain' }, -- タブの追加
    { key = '{', mods = 'CTRL|SHIFT', action = act.MoveTabRelative(-1) }, -- タブの移動
    { key = '}', mods = 'CTRL|SHIFT', action = act.MoveTabRelative(1) },
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
          window:perform_action(act.CopyTo('ClipboardAndPrimarySelection'), pane)
        else
          window:perform_action(act.SendKey{ key='c', mods='CTRL' }, pane)
        end
      end),
    },
    { key = 'v', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },

    { key = 'phys:Space', mods = 'CTRL|SHIFT', action = act.QuickSelect }, -- クイックセレクトの開始
    { key = 'F5', mods = 'NONE', action = act.ReloadConfiguration }, -- Weztermの設定の再読み込み
    { key = 'F11', mods = 'NONE', action = act.ToggleFullScreen }, -- フルスクリーン化
    { key = 'F12', mods = 'NONE',action = act.ShowDebugOverlay }, -- デバッグ情報の表示
    { key = 'Insert', mods = 'SHIFT', action = act.PasteFrom 'PrimarySelection' },
    { key = 'Insert', mods = 'CTRL', action = act.CopyTo 'PrimarySelection' },
    { key = 'Copy', mods = 'NONE', action = act.CopyTo 'Clipboard' },
    { key = 'Paste', mods = 'NONE', action = act.PasteFrom 'Clipboard' },
  },

  key_tables = {
    copy_mode = {
      { key = 'Tab', mods = 'NONE', action = act.CopyMode 'MoveForwardWord' },
      { key = 'Tab', mods = 'SHIFT', action = act.CopyMode 'MoveBackwardWord' },
      { key = 'Enter', mods = 'NONE', action = act.CopyMode 'MoveToStartOfNextLine' },
      { key = '$', mods = 'NONE', action = act.CopyMode 'MoveToEndOfLineContent' },
      { key = '$', mods = 'SHIFT', action = act.CopyMode 'MoveToEndOfLineContent' },
      { key = ',', mods = 'NONE', action = act.CopyMode 'JumpReverse' },
      { key = '0', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLine' },
      { key = ';', mods = 'NONE', action = act.CopyMode 'JumpAgain' },
      { key = 'F', mods = 'NONE', action = act.CopyMode{ JumpBackward = { prev_char = false } } },
      { key = 'F', mods = 'SHIFT', action = act.CopyMode{ JumpBackward = { prev_char = false } } },
      { key = 'G', mods = 'NONE', action = act.CopyMode 'MoveToScrollbackBottom' },
      { key = 'G', mods = 'SHIFT', action = act.CopyMode 'MoveToScrollbackBottom' },
      { key = 'H', mods = 'NONE', action = act.CopyMode 'MoveToViewportTop' },
      { key = 'H', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportTop' },
      { key = 'L', mods = 'NONE', action = act.CopyMode 'MoveToViewportBottom' },
      { key = 'L', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportBottom' },
      { key = 'M', mods = 'NONE', action = act.CopyMode 'MoveToViewportMiddle' },
      { key = 'M', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportMiddle' },
      { key = 'O', mods = 'NONE', action = act.CopyMode 'MoveToSelectionOtherEndHoriz' },
      { key = 'O', mods = 'SHIFT', action = act.CopyMode 'MoveToSelectionOtherEndHoriz' },
      { key = 'T', mods = 'NONE', action = act.CopyMode{ JumpBackward = { prev_char = true } } },
      { key = 'T', mods = 'SHIFT', action = act.CopyMode{ JumpBackward = { prev_char = true } } },
      { key = '^', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLineContent' },
      { key = '^', mods = 'SHIFT', action = act.CopyMode 'MoveToStartOfLineContent' },
      { key = 'b', mods = 'NONE', action = act.CopyMode 'MoveBackwardWord' },
      { key = 'b', mods = 'ALT', action = act.CopyMode 'MoveBackwardWord' },
      { key = 'b', mods = 'CTRL', action = act.CopyMode 'PageUp' },
      { key = 'd', mods = 'CTRL', action = act.CopyMode{ MoveByPage = (0.5) } },
      { key = 'e', mods = 'NONE', action = act.CopyMode 'MoveForwardWordEnd' },
      { key = 'f', mods = 'NONE', action = act.CopyMode{ JumpForward = { prev_char = false } } },
      { key = 'f', mods = 'ALT', action = act.CopyMode 'MoveForwardWord' },
      { key = 'f', mods = 'CTRL', action = act.CopyMode 'PageDown' },
      { key = 'g', mods = 'NONE', action = act.CopyMode 'MoveToScrollbackTop' },
      { key = 'h', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
      { key = 'j', mods = 'NONE', action = act.CopyMode 'MoveDown' },
      { key = 'k', mods = 'NONE', action = act.CopyMode 'MoveUp' },
      { key = 'l', mods = 'NONE', action = act.CopyMode 'MoveRight' },
      { key = 'm', mods = 'ALT', action = act.CopyMode 'MoveToStartOfLineContent' },
      { key = 'o', mods = 'NONE', action = act.CopyMode 'MoveToSelectionOtherEnd' },
      { key = 't', mods = 'NONE', action = act.CopyMode{ JumpForward = { prev_char = true } } },
      { key = 'u', mods = 'CTRL', action = act.CopyMode{ MoveByPage = (-0.5) } },
      { key = 'w', mods = 'NONE', action = act.CopyMode 'MoveForwardWord' },
      { key = 'q', mods = 'NONE', action = act.Multiple{ 'ScrollToBottom', { CopyMode =  'Close' } } },
      { key = 'Escape', mods = 'NONE', action = act.Multiple{ 'ScrollToBottom', { CopyMode =  'Close' } } },
      { key = 'v', mods = 'NONE', action = act.CopyMode{ SetSelectionMode =  'Cell' } },
      { key = 'v', mods = 'CTRL', action = act.CopyMode{ SetSelectionMode =  'Block' } },
      { key = 'V', mods = 'NONE', action = act.CopyMode{ SetSelectionMode =  'Line' } },
      { key = 'V', mods = 'SHIFT', action = act.CopyMode{ SetSelectionMode =  'Line' } },
      { key = 'Space', mods = 'NONE', action = act.CopyMode{ SetSelectionMode =  'Cell' } },
      { key = 'y', mods = 'NONE', action = act.Multiple{ { CopyTo =  'ClipboardAndPrimarySelection' }, { Multiple = { 'ScrollToBottom', { CopyMode =  'Close' } } } } },
      { key = 'c', mods = 'CTRL', action = act.Multiple{ { CopyTo =  'ClipboardAndPrimarySelection' }, { Multiple = { 'ScrollToBottom', { CopyMode =  'Close' } } } } },
      { key = 'PageUp', mods = 'NONE', action = act.CopyMode 'PageUp' },
      { key = 'PageDown', mods = 'NONE', action = act.CopyMode 'PageDown' },
      { key = 'End', mods = 'NONE', action = act.CopyMode 'MoveToEndOfLineContent' },
      { key = 'Home', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLine' },
      { key = 'LeftArrow', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
      { key = 'LeftArrow', mods = 'ALT', action = act.CopyMode 'MoveBackwardWord' },
      { key = 'RightArrow', mods = 'NONE', action = act.CopyMode 'MoveRight' },
      { key = 'RightArrow', mods = 'ALT', action = act.CopyMode 'MoveForwardWord' },
      { key = 'UpArrow', mods = 'NONE', action = act.CopyMode 'MoveUp' },
      { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'MoveDown' },
    },

    search_mode = {
      { key = 'Enter', mods = 'NONE', action = act.CopyMode 'NextMatch' },
      { key = 'Enter', mods = 'SHIFT', action = act.CopyMode 'PriorMatch' },
      { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
      { key = 'r', mods = 'CTRL', action = act.CopyMode 'CycleMatchType' },
      { key = 'u', mods = 'CTRL', action = act.CopyMode 'ClearPattern' },
      { key = 'PageUp', mods = 'NONE', action = act.CopyMode 'PriorMatchPage' },
      { key = 'PageDown', mods = 'NONE', action = act.CopyMode 'NextMatchPage' },
      { key = 'UpArrow', mods = 'NONE', action = act.CopyMode 'PriorMatch' },
      { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'NextMatch' },
    },

  }
}
