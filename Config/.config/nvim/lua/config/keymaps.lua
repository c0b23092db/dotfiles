-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- [[ Neovimの挙動 ]] --

-- インサートを抜ける
vim.api.nvim_set_keymap('i', 'jkl', '<Esc>', { noremap = true, silent = true })

-- LSP:変数名変更
vim.keymap.set('n','gn','<cmd>lua vim.lsp.buf.rename()<CR>')

-- ペースト挙動変更
vim.keymap.set('n', 'p', 'p`]', { desc = 'Paste and move to the end' })
vim.keymap.set('n', 'P', 'P`]', { desc = 'Paste and move to the end' })

-- [[ プラグインの影響 ]] --
-- vim.keymap.set("i", "<CR>","\n", { expr = true, noremap = true, silent = true })

--[[ コントロールキー・シフトキー ]] --

-- ノーマルモードで Ctrl + 矢印キーで単語間を移動
vim.keymap.set("n", "<C-Left>", "b", { desc = "Move to previous word" })
vim.keymap.set("n", "<C-Right>", "w", { desc = "Move to next word" })
-- 挿入モードで Ctrl + 矢印キーで単語間を移動
vim.keymap.set("i", "<C-Left>", "<C-o>b", { desc = "Move to previous word in insert mode" })
vim.keymap.set("i", "<C-Right>", "<C-o>w", { desc = "Move to next word in insert mode" })
-- ビジュアルモードで Ctrl + 矢印キーで単語間を移動
vim.keymap.set("v", "<C-Left>", "b", { desc = "Move to previous word in visual mode" })
vim.keymap.set("v", "<C-Right>", "w", { desc = "Move to next word in visual mode" })

-- ノーマルモードで Shift + 矢印キーでコピーモード・単語間を移動
vim.keymap.set("n", "<S-Left>", "vh", { desc = "Copy Mode and previous word" })
vim.keymap.set("n","<S-Right>", "vl", { desc = "Copy Mode and next word" })
-- 挿入モードで Shift + 矢印キーでコピーモードに移行
vim.keymap.set("i", "<S-Left>", "<esc>v", { desc = "Copy Mode to previous char" })
vim.keymap.set("i", "<S-Right>", "<esc>lv", { desc = "Copy Mode to next char" })

-- Ctrl + zで取り消し
vim.keymap.set("n", "<C-z>", "u", { noremap = true, silent = true })
vim.keymap.set("i", "<C-z>", "<C-o>u", { noremap = true, silent = true }) -- 挿入モード対応

-- Ctrl + cでコピー
vim.keymap.set("v", "<C-c>", "y`]", { noremap = true, silent = true })

-- Ctrl + vで貼り付け
-- vim.keymap.set("n", "<C-v>", "p`]", { noremap = true, silent = true })
vim.keymap.set("i", "<C-v>", "<esc>p`]a", { noremap = true, silent = true }) -- 挿入モード対応

--[[ マウス操作 ]]--
vim.keymap.set({'n','v','i','c'}, '<ScrollWheelLeft>', '<ScrollWheelRight>')
vim.keymap.set({'n','v','i','c'}, '<ScrollWheelRight>', '<ScrollWheelLeft>')
