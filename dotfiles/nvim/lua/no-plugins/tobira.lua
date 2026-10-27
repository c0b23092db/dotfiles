return {
  "kamegoro/tobira.nvim",
  enabled = false,
  lazy = true,
  event = "VeryLazy",
  cmd = {
    "Tobira",
    "TobiraGuide",
    "TobiraProgress",
    "TobiraStats",
    "TobiraReset"
  },
  opts = {
    lang                = 'ja', -- 'en' | 'ja'
    idle_delay          = 2000,
    idle_suggestions    = true, -- idle トリガーの提案を有効にするか
    suggestion_cooldown = 200,  -- 自動提案の最小インターバル（秒）
    max_shown           = 5,    -- 同じコマンドを提案する最大回数/セッション
  },
}
