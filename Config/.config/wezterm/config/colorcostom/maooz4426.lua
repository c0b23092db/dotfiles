local config = {}

local custom = {
    -- カラー設定
    purple = '#9c7af2',
    blue = '#6EADD8',
    light_green = "#7dcd5d",
    orange = "#e19500",
    red = "#E50000",
    yellow = "#D7650C",
}

-- カラー設定
config.colors = {
    foreground = 'silver',
    selection_fg = 'red',
    cursor_bg = custom.blue,
    cursor_fg = "white",
    cursor_border = custom.purple,
    tab_bar = {         
        inactive_tab_edge = "none",
    },

    ansi = {
        'black',          -- 0: Black
        custom.red,      -- 1: Custom Red
        custom.purple,   -- 2: Custom Purple
        custom.light_green, -- 3: Custom Light Green
        custom.blue,     -- 4: Custom Blue
        custom.yellow,   -- 5: Custom Yellow
        'teal',           -- 6: Custom Cyan
        'silver',         -- 7: Custom White
      },
      brights = {
        'grey',     -- 8: Custom Bright Black
        'red',      -- 9: Bright Red
        'lime',     -- 10: Custom Bright Green
        'yellow',   -- 11: Bright Yellow
        'blue',     -- 12: Bright Blue
        'fuchsia',  -- 13: Custom Bright Magenta
        'aqua',     -- 14: Custom Bright Cyan
        'white',    -- 15: Bright White
      },
}

return config