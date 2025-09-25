return {
  lazy = false,
  event = 'VimEnter',
  priority = 1000,
  --[[ - Like Color Scheme -
  "oxfist/night-owl.nvim"
  'cocopon/iceberg.vim'
  --]]
  {
    "oxfist/night-owl.nvim",
    config = function()
      require("night-owl").setup({
        italics = false,
        bold = true,
        underline = true,
        undercurl = true,
        transparent_background = true,
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "night-owl",
    },
  },
}
