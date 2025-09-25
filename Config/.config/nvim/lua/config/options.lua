-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

--[[ Neovim設定 ]]--
vim.opt.mouse = "a"  -- マウス操作を有効化
vim.opt.clipboard = 'unnamedplus' -- クリップボードの変更
vim.opt.backup = false -- バックアップの設定

--[[ エンコーディング設定 ]]--
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8" -- Neovimのデフォルト文字コード
vim.opt.fileencoding = "utf-8" -- ファイルの保存時
vim.opt.fileencodings = "utf-8,utf-16,sjis," -- ファイル読み込み時推定
vim.opt.list = true -- インデントの表示
vim.opt.listchars = { -- インデントの文字
  space = "-",
  tab = "▎ ",
}

--[[ 表示設定 ]]--
vim.opt.cursorline = true -- カーソル行のハイライト
vim.opt.number = true -- 行番号を表示
vim.opt.relativenumber = false -- 絶対行の表示

--[[ エディタ設定 ]]--
vim.opt.fixeol = false -- 最後の行に空行を入れない
-- 新しい行を改行で追加した時に、ひとつ上の行のインデントを引き継がせます。
vim.opt.autoindent = true
vim.opt.smartindent = true

--[[ 検索設定 ]]--
vim.opt.hlsearch = true  -- 検索結果をハイライト

--[[ ヘルプ設定 ]]--
vim.opt.helplang = "ja"  -- ヘルプの言語を日本語に設定

-- blink
vim.g.lazyvim_blink_main = false

-- Python
vim.g.python3_host_prog = ""
