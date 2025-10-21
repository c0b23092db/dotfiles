return {
  "mason-org/mason.nvim",
  "mason-org/mason-lspconfig.nvim",
  lazy = true,
  cmd = {
    "Mason",
    "MasonUpdate",
    "MasonInstall",
    "MasonUninstall",
    "MasonUninstallAll",
    "MasonLog",
  },

  config = function()
    local servers = {
      "clangd",-- C
      "rust_analyzer",-- Rust
    }
    require("mason").setup()
    require("mason-lspconfig").setup({
      automatic_installation = true,
      ensure_installed = servers,
    })
    vim.lsp.enable(servers)
  end,
}