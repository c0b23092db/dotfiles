return {
  "brenoprata10/nvim-highlight-colors",
  enabled = true,
  lazy = true,
  event = "LazyFile",
  config = function()
    require('nvim-highlight-colors').setup {
      render = 'background',
      enable_rgb = false,
    }
  end,
}
