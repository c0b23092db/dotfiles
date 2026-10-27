return {
  "mason-org/mason.nvim",
  "mason-org/mason-lspconfig.nvim",
  enabled = true,
  lazy = true,
  cmd = {
    "Mason",
    "MasonUpdate",
    "MasonInstall",
    "MasonUninstall",
    "MasonUninstallAll",
    "MasonLog",
  },
}