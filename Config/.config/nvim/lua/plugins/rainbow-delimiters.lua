return{
  "HiPhish/rainbow-delimiters.nvim",
  lazy = true,
  event = {"BufReadPost","BufNewFile"},

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