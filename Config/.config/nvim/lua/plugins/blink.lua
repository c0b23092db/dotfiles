return {
  'saghen/blink.nvim',
  version = not vim.g.lazyvim_blink_main and "*",
  build = vim.g.lazyvim_blink_main and "cargo build --release",
  lazy = true,
  event = {"InsertEnter","CmdLineEnter"},

  opts_extend = {
    "sources.default",
  },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = "super-tab" },
    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono"
    },
    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'snippets','lsp','path','buffer' },
    },

    completion = {
      documentation = { auto_show = true },
      -- menu = { border = "rounded" },
      -- documentation = { window = { border = 'single' } },
    },
  }
}