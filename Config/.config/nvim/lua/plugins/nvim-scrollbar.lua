return {
  "petertriho/nvim-scrollbar",
  event = {
    "BufWinEnter",
    "TabEnter",
    "TermEnter",
    "WinEnter",
    "CmdwinLeave",
    "TextChanged",
    "VimResized",
    "WinScrolled",
    "BufWinLeave",
    "TabLeave",
    "TermLeave",
    "WinLeave",
  },
  config = function()
    require("scrollbar").setup({})
  end
}