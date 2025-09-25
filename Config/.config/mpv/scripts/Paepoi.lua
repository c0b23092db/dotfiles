-- https://palepoli.skr.jp/tips/fedora/mpv.php
-- Fedora Tips | MPV をスクリプトで拡張

-- Esc 時にフルスクリーンなら解除、そうでなければ終了
-- ようするに Eye of GNOME と同じ動作
-- ~/.config/mpv/scripts/mpv_esc.lua
function on_escape()
    if mp.get_property_bool('fullscreen') then
        mp.set_property('fullscreen', 'no')
    else
        mp.command('quit')
    end
end
mp.add_key_binding('Esc', 'esc_func', on_escape)

-- Home キーで先頭に巻き戻して再生する
-- 最後まで再生しポーズ状態になっていても即再生できるように
-- ~/.config/mpv/scripts/mpv_go_home.lua
function on_go_home()
    mp.set_property_number('time-pos', 0)
    if mp.get_property_bool('pause') then
        mp.set_property_bool('pause', false)
    end
end
mp.add_key_binding('Home', 'go_home_func', on_go_home)
