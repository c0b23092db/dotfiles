return {
  "lukas-reineke/indent-blankline.nvim",
  enabled = true,
  lazy = true,
  event = "LazyFile",
  main = "ibl",
  config = function()
    local highlight = {
      "Red",
      "Orange",
      "Yellow",
      "Green",
      "Blue",
      "Purple",
    }
    local hooks = require "ibl.hooks"
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "Write", { fg = "#FFFFFF" })
      vim.api.nvim_set_hl(0, "Red", { fg = "#FF0000" })
      vim.api.nvim_set_hl(0, "Orange", { fg = "#FFA500" })
      vim.api.nvim_set_hl(0, "Yellow", { fg = "#FFFF00" })
      vim.api.nvim_set_hl(0, "Green", { fg = "#008000" })
      vim.api.nvim_set_hl(0, "Blue", { fg = "#0000FF" })
      vim.api.nvim_set_hl(0, "Purple", { fg = "#800080" })
    end)
    require("ibl").setup {
      scope = { highlight = "Write" },
      indent = {
        char = "▏",
        highlight = highlight,
      },
    }
  end,
}