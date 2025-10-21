return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = { enabled = true,
      preset = {
      -- Font Name: Slant
        header = [[
    _   ____________ _    ________  ___
   / | / / ____/ __ \ |  / /  _/  |/  /
  /  |/ / __/ / / / / | / // // /|_/ / 
 / /|  / /___/ /_/ /| |/ // // /  / /  
/_/ |_/_____/\____/ |___/___/_/  /_/   
        ]],
      }
    },
    indent = { enabled = false },
  },
}