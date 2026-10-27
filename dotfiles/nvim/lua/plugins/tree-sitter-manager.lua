return {
  "romus204/tree-sitter-manager.nvim",
  enabled = true,
  lazy = true,
  cmd = {
    "TSManager",
    "TSInstall",
    "TSUninstall",
    "TSUpdate"
  },
  dependencies = {},
  config = function()
    require("tree-sitter-manager").setup({
      auto_install = true,
      -- ensure_installed = "all",
      ensure_installed = {
        "c",
        "cpp",
        "c_sharp",
        "lua",
        "rust",
        "python",
        "vhs",
        "html",
        "javascript",
        "typescript",
        "markdown",
        "markdown_inline",
        "csv",
        "tsv",
        "json",
        "toml",
        "yaml",
      }
    })
  end,
}
