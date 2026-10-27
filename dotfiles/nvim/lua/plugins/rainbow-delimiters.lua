return{
  "HiPhish/rainbow-delimiters.nvim",
  enabled = true,
  lazy = true,
  event = "LazyFile",
  config = function()
    require('rainbow-delimiters.setup').setup {
      strategy = {
        -- ...
      },
      query = {
        -- ...
      },
      highlight = {
        'RainbowDelimiterYellow',
        'RainbowDelimiterViolet',
        'RainbowDelimiterBlue',
        'RainbowDelimiterGreen',
      },
    }
  end
}