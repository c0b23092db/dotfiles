return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate', -- プラグイン更新時にパーサーも更新する
  config = function()
    local langs = { "c", "cpp", "c_sharp", "lua" }
    -- require("nvim-treesitter").install(langs)
    -- autocmdでファイルタイプごとにTreesitterの機能を起動する
    local group = vim.api.nvim_create_augroup('MyTreesitterSetup', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      group = group,
      pattern = langs,
      callback = function(args)
        -- ハイライトを有効にする
        vim.treesitter.start(args.buf)
        -- インデントを有効にする
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
