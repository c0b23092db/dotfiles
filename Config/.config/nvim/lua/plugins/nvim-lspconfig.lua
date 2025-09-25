return{
  "neovim/nvim-lspconfig",
  lazy = true,
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "saghen/blink.cmp",
  },
}