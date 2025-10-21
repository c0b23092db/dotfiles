return {
  "lukas-reineke/indent-blankline.nvim",
  lazy = true,
  event = {"BufReadPost","BufNewFile"},

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
    -- create the highlight groups in the highlight setup hook, so they are reset
    -- every time the colorscheme changes
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
      indent = { 
        char = "▏",
        highlight = highlight,
      },
      scope = { highlight = "Write" },
    }
  end,
}