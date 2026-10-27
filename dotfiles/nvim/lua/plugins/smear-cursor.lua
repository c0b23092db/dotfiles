return {
  "sphamba/smear-cursor.nvim",
  enabled = true,
  lazy = true,
  event = "LazyFile",
  cond = vim.g.neovide == nil,
  opts = {
    hide_target_hack = true,
    legacy_computing_symbols_support = true,
    transparent_bg_fallback_color = "#FFFFFF",
    cursor_color = "#FFFFFF",
  },
}
