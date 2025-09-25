local act = require('wezterm').action

return {
    mouse_bindings = {
        { -- 右クリックでペースト
            event = { Down = { streak = 1, button = "Right" } },
            mods = "NONE",action = act.PasteFrom("Clipboard"),
        },
    },
}