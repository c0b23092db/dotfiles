return {
  "nvim-treesitter/nvim-treesitter",
  build = ':TSUpdate',
  install = function()
    require("nvim-treesitter.install").setup({
      prefer_git = false,
      compilers = { "cl" }
    })
  end,
  lazy = true,
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  keys = {
    { "<c-space>", desc = "Increment Selection" },
    { "<bs>", desc = "Decrement Selection", mode = "x" },
  },

  opts_extend = { "ensure_installed" },
  config = function()
    require("nvim-treesitter.configs").setup({
      enable = true,
      auto_install = false,
      modules = {},
      ensure_installed = {
        "html",
        "json",
        "yaml",
        "markdown",
        "markdown_inline",
        "javascript",
        "typescript",
        "bash",
        "lua",
        "python",
        "c",
        "cpp",
        "rust",
      },
      ignore_install = {},
      highlight = { enable = true },
      indent = { enable = true },
      sync_install = false,
    })
  end
}