return {
  "folke/todo-comments.nvim",
  enabled = true,
  lazy = true,
  event = "LazyFile",
  opts = {
    signs = true,
    sign_priority = 8,
    keywords = {
      FIX = { icon = " ", color = "error",
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }
      },
      TODO = { icon = " ", color = "info" },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO","MEMO" } },
      TEST = { icon = "！", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
    },
  }
}
