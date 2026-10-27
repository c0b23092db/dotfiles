return {
  "nvim-mini/mini.ai",
  enabled = true,
  lazy = true,
  event = "VeryLazy",
  opts = {
    custom_textobjects = {},
    mappings = {
      around = 'a',
      inside = 'i',
      around_next = 'an',
      inside_next = 'in',
      around_last = 'al',
      inside_last = 'il',
      goto_left = 'g[',
      goto_right = 'g]'
    },
    n_lines = 50,
    search_method = 'cover_or_next',
    silent = false,
  }
}
