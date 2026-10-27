return {
  enabled = true,
  lazy = false,
  event = 'VimEnter',
  priority = 1000,
  --[[ - Like Color Scheme -
  "oxfist/night-owl.nvim"
  'cocopon/iceberg.vim'
  --]]
  {
    "oxfist/night-owl.nvim",
    opts = {
      italics = false,
      bold = true,
      underline = true,
      undercurl = true,
      transparent_background = true,
    }
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "night-owl",
    },
  },
}
