return {
  "monkoose/neocodeium",
  lazy = true,
  event = "InsertEnter",

  config = function()
    local neocodeium = require("neocodeium")
    neocodeium.setup()
    -- https://zenn.dev/renlqqz/articles/8f98789ea8b280 --
    vim.keymap.set("i", "<A-f>", neocodeium.accept)
    -- 複数候補ある場合に次の候補を表示
    vim.keymap.set("i", "<C-j>", function()
      neocodeium.cycle(1)
    end)
    -- 前の候補を表示
    vim.keymap.set("i", "<C-k>", function()
      neocodeium.cycle(-1)
    end)
  end
}