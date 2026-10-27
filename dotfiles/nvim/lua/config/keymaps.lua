-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- *Modes*
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
local map = vim.keymap.set

-- [[ Neovim 挙動変更 ]] --
-- インサートを抜ける
map('i', 'jkl', '<Esc>')
-- コピー
map('x', 'y', 'mzy`z', { desc = 'Paste and move to the end' })
-- ペースト
map('n', 'p', ']p`]', { desc = 'Paste and move to the end' })
map('n', 'P', ']P`]', { desc = 'Paste and move to the end' })
-- インデント
map("x", "<", "<gv")
map("x", ">", ">gv")
-- コメント
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })
-- 検索
map("n", "f<cr>", "}")
map("n", "F<cr>", "{")
map('x', 'z/', '<C-\\><C-n>`</\\%V', { desc = 'ビジュアル選択範囲内: 前方検索' })
map('x', 'z?', '<C-\\><C-n>`>?\\%V', { desc = 'ビジュアル選択範囲内: 後方検索' })

-- [[ エディタ ]] --
-- Ctrl + z: 取り消し
map("n", "<C-z>", "u", { noremap = true, silent = true })
map("i", "<C-z>", "<C-o>u", { noremap = true, silent = true })
-- Ctrl + c: コピー
map("x", "<C-c>", "mzy`z", { noremap = true, silent = true })
-- Ctrl + x: 切り取り
map("x", "<C-x>", "d", { noremap = true, silent = true })
-- Ctrl + v: 貼り付け
map("n", "<C-v>", "]p`]", { noremap = true, silent = true })
map("i", "<C-v>", "<esc>]p`]a", { noremap = true, silent = true })
-- Ctrl + Backspace
map("i", "<C-h>", "<C-W>", { noremap = true, silent = true, desc = 'Delete previous word' })
map("i", "<C-Delete>", "<C-o>dw", { noremap = true, silent = true, desc = "Delete next word" })

-- [[ helix ]] --
map("n", "U", "<C-r>", { noremap = true, silent = true })

-- [[ LSP ]] --
-- 変数名変更
map('n','gn','<cmd>lua vim.lsp.buf.rename()<CR>')

--[[ Altキー ]] --
map("n", "<M-k>", "<Cmd>move .-2<CR>==", { silent = true })
map("n", "<M-j>", "<Cmd>move .+1<CR>==", { silent = true })
map("x", "<M-j>", ":move '>+1<CR>gv=gv", { silent = true })
map("x", "<M-k>", ":move '<-2<CR>gv=gv", { silent = true })

--[[ コントロールキー・シフトキー ]] --

-- Save File
map({"n","i","x","s"},"<C-s>","<cmd>w<cr><esc>", { desc = "Save File" })

-- Ctrl + 矢印キーで単語間を移動
map({"n","v"}, "<C-Left>", "b", { desc = "Move to previous word" })
map({"n","v"}, "<C-Right>", "w", { desc = "Move to next word" })
-- 挿入モードで Ctrl + 矢印キーで単語間を移動
map("i", "<C-Left>", "<C-o>b", { desc = "Move to previous word in insert mode" })
map("i", "<C-Right>", "<C-o>w", { desc = "Move to next word in insert mode" })

-- ノーマルモードで Shift + 矢印キーでコピーモード・単語間を移動
map("n", "<S-Left>", "vh", { desc = "Copy Mode and previous word" })
map("n","<S-Right>", "vl", { desc = "Copy Mode and next word" })
-- 挿入モードで Shift + 矢印キーでコピーモードに移行
map("i", "<S-Left>", "<esc>v", { desc = "Copy Mode to previous char" })
map("i", "<S-Right>", "<esc>lv", { desc = "Copy Mode to next char" })

--[[ マウス操作 ]]--
map({'n','v','i','c'}, '<ScrollWheelLeft>', '<ScrollWheelRight>')
map({'n','v','i','c'}, '<ScrollWheelRight>', '<ScrollWheelLeft>')

-- [[ プラグイン ]] --
-- Snacks.toggle.zoom():map("<leader>m")

