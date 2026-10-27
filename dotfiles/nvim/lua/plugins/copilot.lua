return {
  "zbirenbaum/copilot.lua",
  enabled = true,
  lazy = true,
  event = "InsertEnter",
  cmd = "Copilot",
  dependencies = {
    "copilotlsp-nvim/copilot-lsp",
    init = function()
      vim.g.copilot_nes_debounce = 500
    end,
  },
  config = function()
    require("copilot").setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
      nes = {
        enabled = false,
        keymap = {
          accept_and_goto = "<leader>p",
          accept = false,
          dismiss = "<Esc>",
        },
      },
      filetypes = {
        markdown = true,
        help = true,
      },
      server_opts_overrides = {
        offset_encoding = "utf-16",
      },
    })
  end,
}
