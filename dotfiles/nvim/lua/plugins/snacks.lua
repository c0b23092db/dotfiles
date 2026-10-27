return {
  "folke/snacks.nvim",
  event = 'VimEnter',
  enabled = true,
  lazy = false,
  priority = 1000,
  opts = {
    dashboard = {
      enabled = true,
      preset = {
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        -- Font Name: Slant
        header = [[
    _   ____________ _    ________  ___
   / | / / ____/ __ \ |  / /  _/  |/  /
  /  |/ / __/ / / / / | / // // /|_/ / 
 / /|  / /___/ /_/ /| |/ // // /  / /  
/_/ |_/_____/\____/ |___/___/_/  /_/   
        ]],
      },
    },
    zen = {
      enabled = true,
      toggles = {
        dim = true,
        git_signs = false,
        mini_diff_signs = false,
        -- diagnostics = false,
        -- inlay_hints = false,
      },
    },
    picker = {
      enabled = true,
    },
    input = { enabled = true },
    notifier = { enabled = true },
    scope = { enabled = true },
    words = { enabled = true },
    lazygit = { enabled = true },
    statuscolumn = { enabled = false },
    indent = {
      enabled = false,
      char = "▏",
      scope = {
        char = "▏",
        underline = true,
      },
      animate = { enabled = false }
    },
    dim = { enabled = false },
    scroll = { enabled = false },
    animate = { enabled = false },
  },
  keys = {
    -- Other
    { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
    { "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<leader>ss", function() Snacks.scratch.select() end, desc = "Scratch Select" },
    { "<leader>ps", function() Snacks.profiler.scratch() end, desc = "Profiler Scratch" },
    -- Grep
    { "<leader>pl", function() Snacks.picker.lines() end, desc = "Picker Lines" },
    { "<leader>gb", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
    -- Toggle
    { "<leader>z", function() Snacks.zen() end, desc = "Toggle Zen Mode" },
    -- { "<leader>m", function() Snacks.toggle.zoom() end, desc = "Toggle Zoom Mode" },
    -- ui
    -- { "<leader>gG", function() Snacks.lazygit() end, desc = "Lazygit (cwd)" },
    -- { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
  }
}