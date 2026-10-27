return {
  "nwiizo/marp.nvim",
  enabled = true,
  lazy = true,
  ft = "markdown",
  cmd = {
    "MarpWatch",
    "MarpStop",
    "MarpStopAll",
    "MarpPreview",
    "MarpList",
    "MarpExport",
    "MarpThumbnail",
    "MarpTheme",
    "MarpSniippet",
    "MarpInfo",
    "MarpCopyPath",
    "MarpDebug"
  },
  config = function()
    require("marp").setup {
      marp_command = "marp",
      browser = nil,
      debug = true,
      server_mode = false,
    }
  end,
}
